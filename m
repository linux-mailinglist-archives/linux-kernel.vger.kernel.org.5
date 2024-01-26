Return-Path: <linux-kernel+bounces-40228-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 05BD383DCD1
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 15:56:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 68B69B22D78
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 14:56:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8A131CA91;
	Fri, 26 Jan 2024 14:56:17 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BED6A1CA89;
	Fri, 26 Jan 2024 14:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706280977; cv=none; b=aDUKlH5z+/fjzk9heYhEpwzPCUayqpxCo2k54hCkXmkC676A3jW8kzrgOIaMjghy98kskdyPZ8UzZUYuyZzuCRfgB77+b8VUoGmO+9Bri8gaNjpEdIEEad4tM8kaSwT6DqC7ZNpdkiCvHgY1ZAcQQTHCpLMnQkFsr7+M/kSt8jk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706280977; c=relaxed/simple;
	bh=vYOYe9xwh/oqWX6EQ0FiRaB5BnNfTUiw8M7X2jBOBkw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=bBq/czi0HOkXejMGnEJhlP7T3IAxxjJMZBlmRB6qpw4ULh8nI7BZ6Bo+CmmMMPx9pU/fJHgXJVplmVItI8Znlmgs5WPB8gqb3xJOmbtp04SpRMUpU1dCkTrYWgDX2wcZvVwpA+P3UG+l0+WITD0c3cwj5lWvKcPATOZWqoWvTJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7A8041FB;
	Fri, 26 Jan 2024 06:56:58 -0800 (PST)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 21F1E3F73F;
	Fri, 26 Jan 2024 06:56:12 -0800 (PST)
From: Mark Rutland <mark.rutland@arm.com>
To: linux-kernel@vger.kernel.org
Cc: acme@redhat.com,
	irogers@google.com,
	james.clark@arm.com,
	john.g.garry@oracle.com,
	leo.yan@linaro.org,
	linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org,
	marcan@marcan.st,
	mark.rutland@arm.com,
	maz@kernel.org,
	mike.leach@linaro.org,
	namhyung@kernel.org,
	suzuki.poulose@arm.com,
	tmricht@linux.ibm.com,
	will@kernel.org
Subject: [PATCH v2] perf print-events: make is_event_supported() more robust
Date: Fri, 26 Jan 2024 14:56:05 +0000
Message-Id: <20240126145605.1005472-1-mark.rutland@arm.com>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently the perf tool doesn't detect support for extended event types
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
targeting an Apple M1/M2 PMU, even where events would be supported with
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
events to be detected on Apple M1/M2 systems. I believe that this is
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
Tested-by: Ian Rogers <irogers@google.com>
Tested-by: James Clark <james.clark@arm.com>
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

Since v1 [1]:
* Fix typos in commit message
* Accumulate tags

[1] https://lore.kernel.org/lkml/20240116170348.463479-1-mark.rutland@arm.com/

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


