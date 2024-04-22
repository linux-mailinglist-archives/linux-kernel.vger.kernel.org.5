Return-Path: <linux-kernel+bounces-153231-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 39E908ACB38
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 12:49:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A843B1F2121C
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 10:49:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B36C51448E5;
	Mon, 22 Apr 2024 10:49:41 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D344205E38;
	Mon, 22 Apr 2024 10:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713782980; cv=none; b=YVJZ3hi/xzasyPxW3g8+7zsuZt+ybbfRRSHmqSQhPVp5hslYSDJ614TcqWEfNPyySuikUmj+apkW9lRxyqyAyIfprIPmzeU1v2lL0xndv5D17K7xhgYH2UpTW1WZm+Vk+QU699QzDfRCzOloqZwgAVjslVUfRfKOUZvPykZYSlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713782980; c=relaxed/simple;
	bh=V3JVLUQkKZ0ClwbpVUKwOrj3hNFz5KqPyYqlIjHSMP8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iOO00uRc6E2pI5JN9HPIr6FQ7A+2Gffgj8CHnZCRHSHOu/RlQOqAXccL1NI2euwBvm+Ie2dTLVfrWglZaANZD0iZ3j9cJ7jWnGxtVxKbWNDM+0x5V1Ui8CqiaO7fVmzpjF0WGajzW/1Ne3qVsBpZw+Rn3Tz+t3WQjeiEbt8K3Bc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A3697339;
	Mon, 22 Apr 2024 03:50:05 -0700 (PDT)
Received: from e126817.cambridge.arm.com (e126817.cambridge.arm.com [10.2.3.5])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 4DFF13F7BD;
	Mon, 22 Apr 2024 03:49:35 -0700 (PDT)
From: Ben Gainey <ben.gainey@arm.com>
To: peterz@infradead.org,
	mingo@redhat.com,
	acme@kernel.org,
	namhyung@kernel.org
Cc: ak@linux.intel.com,
	will@kernel.org,
	james.clark@arm.com,
	mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com,
	jolsa@kernel.org,
	irogers@google.com,
	adrian.hunter@intel.com,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Ben Gainey <ben.gainey@arm.com>
Subject: [RFC PATCH v2 0/4] A mechanism for efficient support for per-function metrics
Date: Mon, 22 Apr 2024 11:49:25 +0100
Message-ID: <20240422104929.264241-1-ben.gainey@arm.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I've been working on an approach to supporting per-function metrics for
aarch64 cores. The basic idea is to extend a plain periodic sampling
profiler as follows:

 * Periodically sample one or more counters as needed for the chosen
   set of metrics.
 * Record a sample count for each symbol so as to identify hot
   functions.
 * Accumulate counter totals for each of the counters in each of the
   metrics.
 * Apply some filtering to the PMU values to improve attributability.

So far, this can be achieved without any further modifications to perf
tools or the kernel. However, using the sample period that might
typically be used for a plain periodic sampling statistical profiler
(for example once every millisecond) leads to poor results. Such an
approach gives you a reasonable estimation of where the profiled
application is spending time for relatively low overhead, but the
PMU counters cannot easily be attributed to a single function as the
window over which they are collected is too large. A modern CPU may
execute many millions of instructions over many thousands of functions
within 1mS window. With this approach, the per-function metrics tend
to trend to some average value across the top N functions in the
profile.

In order to improve the attributability of the PMU counters, it is
desirable to shorten the sampling window to something small enough that
it fits within the execution time of a typical single function; for
example a few hundred cycles. This can be achieved with perf, by
reducing the sample period, for example by sampling the CPU cycle
counter with `period=<window>`. With this change, it is possible to
collect seemingly reasonable per-function metrics on aarch64.

There are at least three major concerns with this approach:

 * A short sample window is not guaranteed to cover a single function.
 * For speculatively executing, out of order cores, can the results be
   accurately attributed to a give function or the given sample window?
 * The overhead of sampling every few hundred cycles is very high.

This patch set does not attempt to address the first point directly; it
is possible to detect cases where the sample window starts in one symbol
and ends in another by comparing the two symbols. In the post-processing
script provided at the bottom of this message, the approach is to
discard the PMU counts for any given sample if the start and end symbols
are not matched. In order to avoid biasing the overall results against
small functions, the script will still increment the "number of samples"
count for the sampled symbol so that the relative rank of that function
remains correct despite the PMU data being discarded.
It is possible for a this approach to fail, for example if the start
and end of the window fall within the same function, with a sufficiently
short call-return occurring between the two. On Arm systems, the
BR_RETURN_RETIRED or BR_RETURN_SPEC PMU counter could be used to detect
such cases, or a tool could just accept such misattribution on the basis
that folding the cost of a very small leaf function into its caller may
be more useful than discarding the data entirely.

The patch set also cannot address the second concern. Where alternative,
more precises mechanisms are available, it is likely preferable to use
those. However, in many cases, such as across the vast majority of Arm
CPUs, the PMU is the only available mechanism, and in this context, and
in the context of a statistical sampling profiler, it is intended that
this approach ought to give representative/actionable metrics rather
than absolutely precise metrics.

This patch set focuses on improving the capture and processing overhead.

There are several reasons why the high overhead is undesirable:

  * PMU counter overflow typically causes an interrupt into the kernel;
    this affects program runtime, and can affect things like branch
    prediction, cache locality and so on which can skew the metrics.
  * The very high sample rate produces significant amounts of data.
    Depending on the configuration of the profiling session and machine,
    it is easily possible to produce many orders of magnitude more data
    which is costly for tools to post-process and increases the chance
    of data loss. This is especially relevant on larger core count
    systems where it is very easy to produce massive recordings.
    Whilst the kernel will throttle such a configuration,
    which helps to mitigate a large portion of the bandwidth and capture
    overhead, it is not something that can be controlled for on a per
    event basis, or for non-root users, and because throttling is
    controlled as a percentage of time its affects vary from machine to
    machine. AIUI throttling may also produce an uneven temporal
    distribution of samples. Finally, whilst throttling does a good job
    at reducing the overall amount of data produced, it still leads to
    much larger captures than with this method; typically I have
    observed 1-2 orders of magnitude larger captures.

In order to mitigate this high overhead, this patch set proposes a cheap
mechanism to decouple the sample window (time over which events are
counted) from the sample period (time between interesting samples).
This patch set modifies perf core to support alternating between two
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
be programmed to overflow after a sufficiently short window (which may
not be possible with software timer, for example). This patch does not
restrict to only the cycle counter, it is possible there could be other
novel uses based on different events, or more appropriate counters on
other architectures. This patch set does not modify or otherwise disable
the kernel's existing throttling behaviour; if a configuration is given
that would lead high CPU usage, then throttling still occurs.

To test this I have developed a simple `perf script` based python
script. For a limited set of Arm PMU events it will post process a
`perf record`-ing and generate a table of metrics. Along side this I
have developed a benchmark application that rotates through a sequence
of different classes of behaviour that can be detected by the Arm PMU
(eg. mispredicts, cache misses, different instruction mixes). The path
through the benchmark can be rotated after each iteration so as to
ensure the results don't land on some lucky harmonic with the sample
period. The script can be used with and without this patch allowing
comparison of the results. Testing was on Juno (A53+A57), N1SDP,
Gravaton 2 and 3. In addition this approach has been applied to a few
of Arm's tools projects and has correctly identified improvements and
regressions.

Headline results from testing indicate that ~300 cycles sample window
gives good results with or without this patch. Typical output on N1SDP
for the provided benchmark when run as:

    perf record -T --sample-cpu --call-graph fp,4 --user-callchains \
        -k CLOCK_MONOTONIC_RAW \
        -e '{cycles/period=999700,alt-period=300/,instructions,branch-misses,cache-references,cache-misses}:uS' \
        benchmark 0 1

    perf script -s generate-function-metrics.py -- -s discard

Looks like (reformatted for email brevity):

    Symbol              #     CPI   BM/KI  CM/KI  %CM   %CY   %I    %BM   %L1DA  %L1DM
    fp_divider_stalls   6553   4.9   0.0     0.0   0.0  41.8  22.9   0.1   0.6    0.0
    int_divider_stalls  4741   3.5   0.0     0.0   1.1  28.3  21.5   0.1   1.9    0.2
    isb                 3414  20.1   0.2     0.0   0.4  17.6   2.3   0.1   0.8    0.0
    branch_mispredicts  1234   1.1  33.0     0.0   0.0   6.1  15.2  99.0  71.6    0.1
    double_to_int        694   0.5   0.0     0.0   0.6   3.4  19.1   0.1   1.2    0.1
    nops                 417   0.3   0.2     0.0   2.8   1.9  18.3   0.6   0.4    0.1
    dcache_miss          185   3.6   0.4   184.7  53.8   0.7   0.5   0.0  18.4   99.1

(CPI = Cycles/Instruction, BM/KI = Branch Misses per 1000 Instruction,
 CM/KI = Cache Misses per 1000 Instruction, %CM = Percent of Cache
 accesses that miss, %CY = Percentage of total cycles, %I = Percentage
 of total instructions, %BM = Percentage of total branch mispredicts,
 %L1DA = Percentage of total cache accesses, %L1DM = Percentage of total
 cache misses)

When the patch is used, the resulting `perf.data` files are typically
between 25-50x smaller than without, and take ~25x less time for the
python script to post-process. For example, running the following:

    perf record -i -vvv -e '{cycles/period=1000000/,instructions}:uS' benchmark 0 1
    perf record -i -vvv -e '{cycles/period=1000/,instructions}:uS' benchmark 0 1
    perf record -i -vvv -e '{cycles/period=300/,instructions}:uS' benchmark 0 1

produces captures on N1SDP (Neoverse-N1) of the following sizes:

    * period=1000000: 2.601 MB perf.data (55780 samples), script time = 0m0.362s
    * period=1000: 283.749 MB perf.data (6162932 samples), script time = 0m33.100s
    * period=300: 304.281 MB perf.data (6614182 samples), script time = 0m35.826s

The "script time" is the user time from running "time perf script -s generate-function-metrics.py"
on the recording. Similar processing times were observed for "time perf report --stdio|cat"
as well.

By comparison, with the patch active:

    perf record -i -vvv -e '{cycles/period=999700,alt-period=300/,instructions}:uS' benchmark 0 1

produces 4.923 MB perf.data (107512 samples), and script time = 0m0.578s.
Which is as expected ~2x the size and ~2x the number of samples as per
the period=1000000 recording. When compared to the period=300 recording,
the results from the provided post-processing script are (within margin
of error) the same, but the data file is ~62x smaller. The same affect
is seen for the post-processing script runtime.

Notably, without the patch enable, L1D cache miss rates are often higher
than with, which we attribute to increased impact on the cache that
trapping into the kernel every 300 cycles has.

These results are given with `perf_cpu_time_max_percent=25`. When tested
with `perf_cpu_time_max_percent=100` the size and time comparisons are
more significant. Disabling throttling did not lead to obvious
improvements in the collected metrics, suggesting that the sampling
approach is sufficient to collect representative metrics.

Cursory testing on a Xeon(R) W-2145 with a 300 *instruction* sample
window (with and without the patch) suggests this approach would work
for some counters. Calculating branch miss rates for example appears to
be correct when used with the instruction counter as the sampling event,
or at least this approach correctly identifies which functions in the
test benchmark are prone to poor predictability. On the other hand the
combination cycle and instructions counter does not appear to sample
correctly as a pair. With something like

    perf record -e '{cycles/period=999700,alt-period=300/,instructions}:uS' ... benchmark

I often see very large CPI, the same affect is observed without the
patch enabled. No idea whats going on there, so any insight welcome...

This patch modifies the perf_event_attr and introduces an additional
field called `alternative_sample_period` to configure the behaviour.
Setting a non-zero value to this field activates this feature (so long

A copy of the post-processing script and test benchmark source are
available at
https://github.com/ARM-software/gator/tree/prototypes/strobing/prototypes/strobing-patches/test-script

(Note that the script its self has a dependency on
https://lore.kernel.org/linux-perf-users/20240123103137.1890779-1-ben.gainey@arm.com/
but that patch is now part of v6.9-rc1).


Changes since v1:
 - Rebased on v6.9-rc1.
 - Refactored from arm_pmu based extension to core feature
 - Added the ability to jitter the sample window based on feedback
   from Andi Kleen.
 - Modified perf tool to parse the "alt-period" and "alt-period-jitter"
   terms in the event specification.


Ben Gainey (4):
  perf: Allow periodic events to alternate between two sample periods
  perf: Allow adding fixed random jitter to the alternate sampling
    period
  tools/perf: Modify event parser to support alt-period term
  tools/perf: Modify event parser to support alt-period-jitter term

 include/linux/perf_event.h                    |  5 ++
 include/uapi/linux/perf_event.h               |  6 ++-
 kernel/events/core.c                          | 48 +++++++++++++++++++
 tools/include/uapi/linux/perf_event.h         |  6 ++-
 tools/perf/tests/attr.c                       |  2 +
 tools/perf/tests/attr.py                      |  2 +
 tools/perf/tests/attr/base-record             |  4 +-
 tools/perf/tests/attr/base-record-spe         |  2 +
 tools/perf/tests/attr/base-stat               |  4 +-
 tools/perf/tests/attr/system-wide-dummy       |  4 +-
 .../attr/test-record-alt-period-jitter-term   | 12 +++++
 .../tests/attr/test-record-alt-period-term    | 11 +++++
 tools/perf/tests/attr/test-record-dummy-C0    |  4 +-
 tools/perf/util/parse-events.c                | 30 ++++++++++++
 tools/perf/util/parse-events.h                |  4 +-
 tools/perf/util/parse-events.l                |  2 +
 tools/perf/util/perf_event_attr_fprintf.c     |  1 +
 17 files changed, 140 insertions(+), 7 deletions(-)
 create mode 100644 tools/perf/tests/attr/test-record-alt-period-jitter-term
 create mode 100644 tools/perf/tests/attr/test-record-alt-period-term

--
2.44.0


