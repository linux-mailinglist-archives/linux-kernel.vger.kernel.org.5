Return-Path: <linux-kernel+bounces-27607-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D3F4782F2D6
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 18:04:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EC6531C237BE
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 17:04:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F4591CA97;
	Tue, 16 Jan 2024 17:04:20 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B062A1CA89;
	Tue, 16 Jan 2024 17:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705424658; cv=none; b=T5hlxraMnuGIPRsZCCarMdQtNOo5JzF+YdFtbz1zW4j95tO2FCPtD6l3t+rmAb5WPqmwdcX1tJA0kUzI5+nrEbro8opbdpkWGOj5FaIqEcbnNVnMUBeh9HWG6q6CnbpLhzaotdhcykkQY/m/ctwiz01gOZhefisb695nNfXw0Vc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705424658; c=relaxed/simple;
	bh=7v2Vng/QlBCThCRogsk01ysllYBjGdtj3KZrJW3DEsU=;
	h=Received:Received:From:To:Cc:Subject:Date:Message-Id:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding; b=n7Pn3CGm5JimAjkkHHrNJyWYvtN4jg6srBlh2E9I3F1QvhtqBAM28tp6ASeJ+fgQn2sL6AumRr98DAhB/6P58yZN/dfuJmX0mFAPzKdVlc8U3tyMLoJaYshNMF9LHdju4yfRI+k8aXyAUk7TeaX5DbIfMEpcVe2EvQvi3cUOr5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; none
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 158092F4;
	Tue, 16 Jan 2024 09:05:00 -0800 (PST)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id B1BC03F73F;
	Tue, 16 Jan 2024 09:04:11 -0800 (PST)
From: Mark Rutland <mark.rutland@arm.com>
To: linux-kernel@vger.kernel.org,
	Hector Martin <marcan@marcan.st>,
	Marc Zyngier <maz@kernel.org>,
	Ian Rogers <irogers@google.com>
Cc: acme@redhat.com,
	james.clark@arm.com,
	john.g.garry@oracle.com,
	leo.yan@linaro.org,
	linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org,
	mark.rutland@arm.com,
	mike.leach@linaro.org,
	namhyung@kernel.org,
	suzuki.poulose@arm.com,
	tmricht@linux.ibm.com,
	will@kernel.org
Subject: [PATCH] perf print-events: make is_event_supported() more robust
Date: Tue, 16 Jan 2024 17:03:48 +0000
Message-Id: <20240116170348.463479-1-mark.rutland@arm.com>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently the perf tool doesn't deteect support for extneded event types
on Apple M1/M2 systems, and will not auto-expand plain PERF_EVENT_TYPE
hardware events into per-PMU events. This is due to the detection of
extended event types not handling mandatory filters required by the
M1/M2 PMU driver.

PMU drivers and the core perf_events code can require that
perf_event_attr::exclude_* filters are configured in a specific way and
may reject certain configurations of filters, for example:

(a) Many PMUs lack support for any event filtering, and require all
    perf_event_attr::exclude_* bits to be clear. This includes Alpha's
    CPU PMU, and ARM CPU PMUs prior to the introduction of PMUv2 in
    ARMv7,

(b) When /proc/sys/kernel/perf_event_paranoid >= 2, the perf core
    requires that perf_event_attr::exclude_kernel is set.

(c) The Apple M1/M2 PMU requires that perf_event_attr::exclude_guest is
    set as the hardware PMU does not count while a guest is running (but
    might be extended in future to do so).

In is_event_supported(), we try to account for cases (a) and (b), first
attempting to open an event without any filters, and if this fails,
retrying with perf_event_attr::exclude_kernel set. We do not account for
case (c), or any other filters that drivers could theoretically require
to be set.

Thus is_event_supported() will fail to detect support for any events
targetting an Apple M1/M2 PMU, even where events would be supported with
perf_event_attr:::exclude_guest set.

Since commit:

  82fe2e45cdb00de4 ("perf pmus: Check if we can encode the PMU number in perf_event_attr.type")

.. we use is_event_supported() to detect support for extended types,
with the PMU ID encoded into the perf_event_attr::type. As above, on an
Apple M1/M2 system this will always fail to detect that the event is
supported, and consequently we fail to detect support for extended types
even when these are supported, as they have been since commit:

  5c816728651ae425 ("arm_pmu: Add PERF_PMU_CAP_EXTENDED_HW_TYPE capability")

Due to this, the perf tool will not automatically expand plain
PERF_TYPE_HARDWARE events into per-PMU events, even when all the
necessary kernel support is present.

This patch updates is_event_supported() to additionally try opening
events with perf_event_attr::exclude_guest set, allowing support for
events to be detected on Apple M1/M2 systems. I beleive that this is
sufficient for all contemporary CPU PMU drivers, though in future it may
be necessary to check for other combinations of filter bits.

I've deliberately changed the check to not expect a specific error code
for missing filters, as today ;the kernel may return a number of
different error codes for missing filters (e.g. -EACCESS, -EINVAL, or
-EOPNOTSUPP) depending on why and where the filter configuration is
rejected, and retrying for any error is more robust.

Note that this does not remove the need for commit:

  a24d9d9dc096fc0d ("perf parse-events: Make legacy events lower priority than sysfs/JSON")

.. which is still necessary so that named-pmu/event/ events work on
kernels without extended type support, even if the event name happens to
be the same as a PERF_EVENT_TYPE_HARDWARE event (e.g. as is the case for
the M1/M2 PMU's 'cycles' and 'instructions' events).

Fixes: 82fe2e45cdb00de4 ("perf pmus: Check if we can encode the PMU number in perf_event_attr.type")
Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Hector Martin <marcan@marcan.st>
Cc: Ian Rogers <irogers@google.com>
Cc: James Clark <james.clark@arm.com>
Cc: John Garry <john.g.garry@oracle.com>
Cc: Leo Yan <leo.yan@linaro.org>
Cc: Marc Zyngier <maz@kernel.org>
Cc: Mike Leach <mike.leach@linaro.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
Cc: Thomas Richter <tmricht@linux.ibm.com>
Cc: Will Deacon <will@kernel.org>
---
 tools/perf/util/print-events.c | 27 +++++++++++++++++++--------
 1 file changed, 19 insertions(+), 8 deletions(-)

Hector, Marc, I'd appreciate if either of you could give this a spin on
your M1/M2 machines. I've given it local testing with the arm_pmuv3
driver modified to behave the same as the apple_m1_pmu driver (requiring
exclude_guest, having a 'cycles' event in sysfs), but that might not
perfectly replicate your setup.

The patch is based on the 'perf-tools-for-v6.8-1-2024-01-09' tag in the
perf-tools tree:

  https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools.git/

.. and I've pushed it out to the 'perf-tools/event-supported-filters'
branch in my tree:

  https://git.kernel.org/pub/scm/linux/kernel/git/mark/linux.git/

This patch *should* make it possible to do:

	perf stat -e cycles ./workload
	perf stat -e instructions ./workload

.. with those 'cycles' and 'instructions' events being automatically
expanded and reported as separate events per-PMU, which is a nice
quality-of-life improvement.

Comparing before and after this patch:

| # ./perf-before stat -e cycles true
| 
|  Performance counter stats for 'true':
| 
|      <not counted>      cycles                                                                  (0.00%)
| 
|        0.000990250 seconds time elapsed
| 
|        0.000934000 seconds user
|        0.000000000 seconds sys
| 
| # ./perf-after stat -e cycles true
| 
|  Performance counter stats for 'true':
| 
|             965175      armv8_pmuv3_0/cycles/                                                 
|      <not counted>      armv8_pmuv3_1/cycles/                                                   (0.00%)
|      <not counted>      armv8_pmuv3_2/cycles/                                                   (0.00%)
|      <not counted>      armv8_pmuv3_3/cycles/                                                   (0.00%)
| 
|        0.000836555 seconds time elapsed
| 
|        0.000884000 seconds user
|        0.000000000 seconds sys

This *shouldn't* change the interpetation of named-pmu events, e.g.

	perf stat -e apple_whichever_pmu/cycles/ ./workload

.. should behave the same as without this patch

Comparing before and after this patch:

| # ./perf-before stat -e armv8_pmuv3_0/cycles/ -e armv8_pmuv3_1/cycles/ -e armv8_pmuv3_2/cycles/ -e armv8_pmuv3_3/cycles/ true
| 
|  Performance counter stats for 'true':
| 
|      <not counted>      armv8_pmuv3_0/cycles/                                                   (0.00%)
|      <not counted>      armv8_pmuv3_1/cycles/                                                   (0.00%)
|      <not counted>      armv8_pmuv3_2/cycles/                                                   (0.00%)
|             901415      armv8_pmuv3_3/cycles/                                                 
| 
|        0.000756590 seconds time elapsed
| 
|        0.000811000 seconds user
|        0.000000000 seconds sys
| 
| # ./perf-after stat -e armv8_pmuv3_0/cycles/ -e armv8_pmuv3_1/cycles/ -e armv8_pmuv3_2/cycles/ -e armv8_pmuv3_3/cycles/ true
| 
|  Performance counter stats for 'true':
| 
|             923314      armv8_pmuv3_0/cycles/                                                 
|      <not counted>      armv8_pmuv3_1/cycles/                                                   (0.00%)
|      <not counted>      armv8_pmuv3_2/cycles/                                                   (0.00%)
|      <not counted>      armv8_pmuv3_3/cycles/                                                   (0.00%)
| 
|        0.000782420 seconds time elapsed
| 
|        0.000836000 seconds user
|        0.000000000 seconds sys

One thing I'm still looing into is that this doesn't seem to do anything
for a default perf stat session, e.g.

	perf stat ./workload

.. doesn't automatically expand the implicitly-created events into per-pmu
events.

Comparing before and after this patch:

| # ./perf-before stat true
| 
|  Performance counter stats for 'true':
| 
|               0.42 msec task-clock                       #    0.569 CPUs utilized             
|                  0      context-switches                 #    0.000 /sec                      
|                  0      cpu-migrations                   #    0.000 /sec                      
|                 38      page-faults                      #   89.796 K/sec                     
|      <not counted>      cycles                                                                  (0.00%)
|      <not counted>      instructions                                                            (0.00%)
|      <not counted>      branches                                                                (0.00%)
|      <not counted>      branch-misses                                                           (0.00%)
| 
|        0.000744185 seconds time elapsed
| 
|        0.000795000 seconds user
|        0.000000000 seconds sys
| 
| # ./perf-after stat true
| 
|  Performance counter stats for 'true':
| 
|               0.43 msec task-clock                       #    0.582 CPUs utilized             
|                  0      context-switches                 #    0.000 /sec                      
|                  0      cpu-migrations                   #    0.000 /sec                      
|                 38      page-faults                      #   88.960 K/sec                     
|      <not counted>      cycles                                                                  (0.00%)
|      <not counted>      instructions                                                            (0.00%)
|      <not counted>      branches                                                                (0.00%)
|      <not counted>      branch-misses                                                           (0.00%)
| 
|        0.000734120 seconds time elapsed
| 
|        0.000786000 seconds user
|        0.000000000 seconds sys

Ian, how does that behave on x86? Is that the same, or do the default
events get expanded?

Thanks,
Mark.

diff --git a/tools/perf/util/print-events.c b/tools/perf/util/print-events.c
index b0fc48be623f3..4f67e8f00a4d6 100644
--- a/tools/perf/util/print-events.c
+++ b/tools/perf/util/print-events.c
@@ -232,7 +232,6 @@ void print_sdt_events(const struct print_callbacks *print_cb, void *print_state)
 bool is_event_supported(u8 type, u64 config)
 {
 	bool ret = true;
-	int open_return;
 	struct evsel *evsel;
 	struct perf_event_attr attr = {
 		.type = type,
@@ -246,20 +245,32 @@ bool is_event_supported(u8 type, u64 config)
 
 	evsel = evsel__new(&attr);
 	if (evsel) {
-		open_return = evsel__open(evsel, NULL, tmap);
-		ret = open_return >= 0;
+		ret = evsel__open(evsel, NULL, tmap) >= 0;
 
-		if (open_return == -EACCES) {
+		if (!ret) {
 			/*
-			 * This happens if the paranoid value
+			 * The event may fail to open if the paranoid value
 			 * /proc/sys/kernel/perf_event_paranoid is set to 2
-			 * Re-run with exclude_kernel set; we don't do that
-			 * by default as some ARM machines do not support it.
-			 *
+			 * Re-run with exclude_kernel set; we don't do that by
+			 * default as some ARM machines do not support it.
 			 */
 			evsel->core.attr.exclude_kernel = 1;
 			ret = evsel__open(evsel, NULL, tmap) >= 0;
 		}
+
+		if (!ret) {
+			/*
+			 * The event may fail to open if the PMU requires
+			 * exclude_guest to be set (e.g. as the Apple M1 PMU
+			 * requires).
+			 * Re-run with exclude_guest set; we don't do that by
+			 * default as it's equally legitimate for another PMU
+			 * driver to require that exclude_guest is clear.
+			 */
+			evsel->core.attr.exclude_guest = 1;
+			ret = evsel__open(evsel, NULL, tmap) >= 0;
+		}
+
 		evsel__delete(evsel);
 	}
 
-- 
2.30.2


