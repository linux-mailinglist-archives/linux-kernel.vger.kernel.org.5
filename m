Return-Path: <linux-kernel+bounces-4467-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E595817DE8
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 00:11:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7721B1C219B7
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 23:11:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 290B7760B3;
	Mon, 18 Dec 2023 23:11:11 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from 66-220-144-178.mail-mxout.facebook.com (66-220-144-178.mail-mxout.facebook.com [66.220.144.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BEAE76096
	for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 23:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=devkernel.io
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=devkernel.io
Received: by devbig1114.prn1.facebook.com (Postfix, from userid 425415)
	id AAA42111427A7; Mon, 18 Dec 2023 15:10:56 -0800 (PST)
From: Stefan Roesch <shr@devkernel.io>
To: kernel-team@fb.com
Cc: shr@devkernel.io,
	akpm@linux-foundation.org,
	david@redhat.com,
	hannes@cmpxchg.org,
	riel@surriel.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH v5 0/4] mm/ksm: Add ksm advisor
Date: Mon, 18 Dec 2023 15:10:50 -0800
Message-Id: <20231218231054.1625219-1-shr@devkernel.io>
X-Mailer: git-send-email 2.39.3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

What is the KSM advisor?
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
The ksm advisor automatically manages the pages_to_scan setting to
achieve a target scan time. The target scan time defines how many seconds
it should take to scan all the candidate KSM pages. In other words the
pages_to_scan rate is changed by the advisor to achieve the target scan
time.

Why do we need a KSM advisor?
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
The number of candidate pages for KSM is dynamic. It can often be observe=
d
that during the startup of an application more candidate pages need to be
processed. Without an advisor the pages_to_scan parameter needs to be
sized for the maximum number of candidate pages. With the scan time
advisor the pages_to_scan parameter based can be changed based on demand.

Algorithm
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
The algorithm calculates the change value based on the target scan time
and the previous scan time. To avoid pertubations an exponentially
weighted moving average is applied.

The algorithm has a max and min
value to:
- guarantee responsiveness to changes
- to limit CPU resource consumption

Parameters to influence the KSM scan advisor
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
The respective parameters are:
- ksm_advisor_mode
  0: None (default), 1: scan time advisor
- ksm_advisor_target_scan_time
  how many seconds a scan should of all candidate pages take
- ksm_advisor_max_cpu
  upper limit for the cpu usage in percent of the ksmd background thread

The initial value and the max value for the pages_to_scan parameter can
be limited with:
- ksm_advisor_min_pages_to_scan
  minimum value for pages_to_scan per batch
- ksm_advisor_max_pages_to_scan
  maximum value for pages_to_scan per batch

The default settings for the above two parameters should be suitable for
most workloads.

The parameters are exposed as knobs in /sys/kernel/mm/ksm. By default the
scan time advisor is disabled.

Currently there are two advisors:
- none and
- scan-time.

Resource savings
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Tests with various workloads have shown considerable CPU savings. Most
of the workloads I have investigated have more candidate pages during
startup. Once the workload is stable in terms of memory, the number of
candidate pages is reduced. Without the advisor, the pages_to_scan needs
to be sized for the maximum number of candidate pages. So having this
advisor definitely helps in reducing CPU consumption.

For the instagram workload, the advisor achieves a 25% CPU reduction.
Once the memory is stable, the pages_to_scan parameter gets reduced to
about 40% of its max value.

The new advisor works especially well if the smart scan feature is also
enabled.

How is defining a target scan time better?
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
For an administrator it is more logical to set a target scan time.. The
administrator can determine how many pages are scanned on each scan.
Therefore setting a target scan time makes more sense.

In addition the administrator might have a good idea about the memory
sizing of its respective workloads.

Setting cpu limits is easier than setting The pages_to_scan parameter. Th=
e
pages_to_scan parameter is per batch. For the administrator it is difficu=
lt
to set the pages_to_scan parameter.

Tracing
=3D=3D=3D=3D=3D=3D=3D
A new tracing event has been added for the scan time advisor. The new
trace event is called ksm_advisor. It reports the scan time, the new
pages_to_scan setting and the cpu usage of the ksmd background thread.

Other approaches
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

Approach 1: Adapt pages_to_scan after processing each batch. If KSM
  merges pages, increase the scan rate, if less KSM pages, reduce the
  the pages_to_scan rate. This doesn't work too well. While it increases
  the pages_to_scan for a short period, but generally it ends up with a
  too low pages_to_scan rate.

Approach 2: Adapt pages_to_scan after each scan. The problem with that
  approach is that the calculated scan rate tends to be high. The more
  aggressive KSM scans, the more pages it can de-duplicate.

There have been earlier attempts at an advisor:
  propose auto-run mode of ksm and its tests
  (https://marc.info/?l=3Dlinux-mm&m=3D166029880214485&w=3D2)


Changes:
=3D=3D=3D=3D=3D=3D=3D=3D
V5:
  - Changed ksm_advisor_min_cpu to use a define and uppercased it
  - Removed ksm_advisor_min_pages_to_scan from first patch, its only
    needed in the second patch
  - Only reset defaults in advisor_mode_store() when mode changes
  - Add #ifdef CONFIG_SYSFS for set_advisor_defaults()

V4:=20
  - rename ksm_advisor_min_pages to ksm_advisor_min_pages_to_scan
  - rename ksm_advisor_max_pages to ksm_advisor_max_pages_to_scan
  - folded init_advisor() into set_advisor_defaults()
  - moved set_advisor_defaults() to second patch
  - Fixed long division for 32 bit platforms in scan_time_advisor()
  - folded stop_advisor_scan() into scan_time_advisor()
  - renamed run_advisor() to stop_advisor_scan()
  - Fixed typo
  - Added documentation for min and max cpu and how they are used in
    the scan time advisor calculation

V3:
  - Use string parameters for advisor mode
  - Removed min cpu load sysfs knob
  - dropped unused enums in ksm_advisor_type
  - renamed KSM_ADVISOR_LAST to KSM_ADVISOR_COUNT
  - init_advisor() is needed but changed how it is initialized
  - don't allow to change pages_to_scan parameter when scan-time advisor
    is enabled
  - add ksm_advisor_start_scan() and ksm_advisor_stop_scan() functions
    to calculate scan time
  - removed scan time parameter to scan_time_advisor() function

V2:
  - Use functions for long long calculations to support 32 bit platforms
  - Use cpu min and cpu max settings for the advisor instead of the pages
    min and max parameters.
  - pages min and max values are now used for the initial and max values.
    Generally they are not required to be changed.
  - Add cpu percent usage value to tracepoint definition
  - Update documentation for cpu min and cpu max values=20
  - Update commit messages for the above changes


Stefan Roesch (4):
  mm/ksm: add ksm advisor
  mm/ksm: add sysfs knobs for advisor
  mm/ksm: add tracepoint for ksm advisor
  mm/ksm: document ksm advisor and its sysfs knobs

 Documentation/admin-guide/mm/ksm.rst |  55 +++++
 include/trace/events/ksm.h           |  33 +++
 mm/ksm.c                             | 307 ++++++++++++++++++++++++++-
 3 files changed, 394 insertions(+), 1 deletion(-)


base-commit: 4d9256c0c56bafd76b8b1517916451e168fae495
--=20
2.39.3


