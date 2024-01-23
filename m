Return-Path: <linux-kernel+bounces-35202-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5373B838D85
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 12:34:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0481D28601E
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 11:34:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1FD25D8E9;
	Tue, 23 Jan 2024 11:34:41 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 817325D73B;
	Tue, 23 Jan 2024 11:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706009681; cv=none; b=tFVfdmybqNYViItE+wlI2jHwMtZMsoKyOEQOqJ2gDA9Xp/0BudfK1RldorLEYpsBaVkjEcrEonaHPQojL5UJW14pwvYfyE96aB17xm5B2/GytLoHtkGDR6GBodL4P3sxbZl/Gnf/Ja6ADR8PZ70uezDvsB78/D41sCRYCP+q7QU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706009681; c=relaxed/simple;
	bh=Itound2rhJr3CwxbHvsE9PKUkyqy43GCjIgaMwm/PK8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rScickD49tKApugzhu+dugYSJW2pPG77DafhsHtfxSVdyIanpYIrO07akOudpP15tmdDDOjNXcsfZCs6N9bymN/F4d+TV5/Bvzy4+vSyF/tDFwOuNWJoYO0tFmNpeVCkv2KqzU9JsuNjNceksikI7r8RevX5n1lPwACPz++FMGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 353811FB;
	Tue, 23 Jan 2024 03:35:23 -0800 (PST)
Received: from e126817.. (e126817.cambridge.arm.com [10.2.3.5])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 0623B3F762;
	Tue, 23 Jan 2024 03:34:35 -0800 (PST)
From: Ben Gainey <ben.gainey@arm.com>
To: linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Cc: peterz@infradead.org,
	mingo@redhat.com,
	acme@kernel.org,
	mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com,
	jolsa@kernel.org,
	namhyung@kernel.org,
	irogers@google.com,
	adrian.hunter@intel.com,
	will@kernel.org,
	Ben Gainey <ben.gainey@arm.com>
Subject: [RFC PATCH 0/2] A mechanism for efficient support for per-function metrics
Date: Tue, 23 Jan 2024 11:34:18 +0000
Message-ID: <20240123113420.1928154-1-ben.gainey@arm.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I've been working on an approach to supporting per-function metrics for
aarch64 cores, which requires some changes to the arm_pmuv3 driver, and
I'm wondering if this approach would make sense as a generic feature
that could be used to enable the same on other architectures?

The basic idea is as follows:

 * Periodically sample one or more counters as needed for the chosen
   set of metrics.
 * Record a sample count for each symbol so as to identify hot
   functions.
 * Accumulate counter totals for each of the counters in each of the
   metrics *but* only do this where the previous sample's symbol
   matches the current sample's symbol.

Discarding the counter deltas for any given sample is important to
ensure that couters are correctly attributed to a single function,
without this step the resulting metrics trend towards some average
value across the top 'n' functions. It is acknowledged that it is
possible for this heuristic to fail, for example if samples to land
either side of a nested call, so a sufficiently small sample window
over which the counters are collected must be used to reduce the risk
of misattribution.

So far, this can be acheived without any further modifications to perf
tools or the kernel. However as noted it requires the counter
collection window to be sufficiently small; in testing on
Neoverse-N1/-V1, a window of about 300 cycles gives good results. Using
the cycle counter with a sample_period of 300 is possible, but such an
approach generates significant amounts of capture data, and introduces
a lot of overhead and probe effect. Whilst the kernel will throttle
such a configuration, which helps to mitigate a large portion of the
bandwidth and capture overhead, it is not something that can be
controlled for on a per event basis, or for non-root users, and because
throttling is controlled as a percentage of time its affects vary from
machine to machine.

For this to work efficiently, it is useful to provide a means to
decouple the sample window (time over which events are counted) from
the sample period (time between interesting samples). This patcheset
modifies the Arm PMU driver to support alternating between two
sample_period values, providing a simple and inexpensive way for tools
to separate out the sample period and the sample window. It is expected
to be used with the cycle counter event, alternating between a long and
short period and subsequently discarding the counter data for samples
with the long period. The combined long and short period gives the
overall sampling period, and the short sample period gives the sample
window. The symbol taken from the sample at the end of the long period
can be used by tools to ensure correct attribution as described
previously. The cycle counter is recommended as it provides fair
temporal distribution of samples as would be required for the
per-symbol sample count mentioned previously, and because the PMU can
be programmed to overflow after a sufficiently short window; this may
not be possible with software timer (for example). This patch does not
restrict to only the cycle counter, it is possible there could be other
novel uses based on different events.

To test this I have developed a simple `perf script` based python
script. For a limited set of Arm PMU events it will post process a
`perf record`-ing and generate a table of metrics. Along side this I
have developed a benchmark application that rotates through a sequence
of different classes of behaviour that can be detected by the Arm PMU
(eg. mispredics, cache misses, different instruction mixes). The path
through the benchmark can be rotated after each iteration so as to
ensure the results don't land on some lucky harmonic with the sample
period. The script can be used with and without the strobing patch
allowing comparison of the results. Testing was on Juno (A53+A57), 
N1SDP, Gravaton 2 and 3. In addition this approach has been applied to
a few of Arm's tools projects and has correctly identified improvements
and regressions. 

Headline results from testing indicate that ~300 cycles sample window
gives good results with or without the strobing patch. When the
strobing patch is used, the resulting `perf.data` files are typically
25-50x smaller that without, and take ~25x less time for the python
script to post-process. Without strobing, the test application's
runtime was x20 slower when sampling every 300 cycles as compared to
every 1000000 cycles. With strobing enabled such that the long period
was 999700 cycles and the short period was 300 cycles, the test
applications runtime was only x1.2 slower than every 1000000 cycles.
Notably, without the patch, L1D cache miss rates are significantly
higher than with the patch, which we attribute to increased impact on
the cache that trapping into the kernel every 300 cycles has. These
results are given with `perf_cpu_time_max_percent=25`. When tested
with `perf_cpu_time_max_percent=100` the size and time comparisons are
more significant. Disabling throttling did not lead to obvious
improvements in the collected metrics, suggesting that the sampling
approach is sufficient to collect representative metrics.

Cursory testing on a Xeon(R) W-2145 sampling every 300 cycles (without
the patch) suggests this approach would work for some counters.
Calculating branch miss rates for example appears to be correct,
likewise UOPS_EXECUTED.THREAD seems to give something like a sensible
cycles-per-uop value. On the other hand the fixed function instructions
counter does not appear to sample correctly (it seems to report either
very small or very large numbers). No idea whats going on there, so any
insight welcome...

This patch modifies the arm_pmu and introduces an additional field in
config2 to configure the behaviour. If we think there is broad
applicability, would it make sense to move into perf_event_attr flags
or field, and possibly pull up into core? If we don't think so, then
some feedback around the core header and arm_pmu modifications would
be appreciated.

A copy of the post-processing script is available at 
https://github.com/ARM-software/gator/blob/prototypes/strobing/prototypes/strobing-patches/test-script/generate-function-metrics.py
note that the script its self has a dependency on
https://lore.kernel.org/linux-perf-users/20240123103137.1890779-1-ben.gainey@arm.com/


Ben Gainey (2):
  arm_pmu: Allow the PMU to alternate between two sample_period values.
  arm_pmuv3: Add config bits for sample period strobing

 drivers/perf/arm_pmu.c       | 74 +++++++++++++++++++++++++++++-------
 drivers/perf/arm_pmuv3.c     | 25 ++++++++++++
 include/linux/perf/arm_pmu.h |  1 +
 include/linux/perf_event.h   | 10 ++++-
 4 files changed, 95 insertions(+), 15 deletions(-)

-- 
2.43.0


