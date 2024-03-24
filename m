Return-Path: <linux-kernel+bounces-113355-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DF46C8883A9
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 01:16:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 095731C21F8D
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 00:16:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B744B19B290;
	Sun, 24 Mar 2024 22:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EQx5Ijwl"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D34D919B285;
	Sun, 24 Mar 2024 22:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320156; cv=none; b=BAsyZ5xBlLfT/NNFdmOCVpr7JMQhHsQERGIfj+QkfzKVLi8F3Yq/vY06hHB/xyuGgLBpWrc2KP6rTPGOfNhqUgTAfNBJSsDMfPZLu3C/aAioKulzEoXbjGcDT7QIJR3qzsonyc8ixTibQa5ZdgctLqoeOktTQTU0yPAgfwUa0gE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320156; c=relaxed/simple;
	bh=Whij2vGZ4l0ulF8zIs79HoyEI6A+9JEw2oRt6XesVhs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TVLViNnPcCe6YtH5bE5rVR1IP1Li1DvAtG2HrLyFlYN7I0XED+6FbM1RY7hzfqX1LX4vQyWXe3mtMMLDV34UdS4KBXP5d+HayPneuxf6BITc+pdWw0OjUpMC6wPf7oZKKme2xlWWfk8M9tqI6RmtBDVq7CfbG4lfvWJmwSb4uIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EQx5Ijwl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFBBDC433B1;
	Sun, 24 Mar 2024 22:42:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320156;
	bh=Whij2vGZ4l0ulF8zIs79HoyEI6A+9JEw2oRt6XesVhs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EQx5IjwlvJ+6bipKRX7aorRGIxdtnXpLmjmzu6Bbv+Y4BY5B2vrMQPrsS4YtEqGfF
	 aCM6kEcKiirf5oAGdcwBsVuBF28tfqeHCYbVTSDwESIqhcRo16Or0wmlSWCzusjmD1
	 F7u9K1E+7kDmzRtzaZyy4ju0YcfISgjL44Ls/KDbB5rDXBaNDoQLC9eeC3dJZDRUxV
	 8URD9SCYjq1J6xmv++vUWoplqyNBf4TNNG0naYiB16lIy3Bu6bcM6QF1AO34DhLfhe
	 3/1iy+ShtsRjy0tQYXx/u3tY0tn6G3N2fgxSOuYbV37hpvtus2ZD4XjhqWtIn8W5s5
	 ChYUgfnCgh60Q==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Mark Rutland <mark.rutland@arm.com>,
	Ian Rogers <irogers@google.com>,
	James Clark <james.clark@arm.com>,
	Marc Zyngier <maz@kernel.org>,
	Hector Martin <marcan@marcan.st>,
	John Garry <john.g.garry@oracle.com>,
	Leo Yan <leo.yan@linux.dev>,
	Mike Leach <mike.leach@linaro.org>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Thomas Richter <tmricht@linux.ibm.com>,
	Will Deacon <will@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	Namhyung Kim <namhyung@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 464/715] perf print-events: make is_event_supported() more robust
Date: Sun, 24 Mar 2024 18:30:43 -0400
Message-ID: <20240324223455.1342824-465-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324223455.1342824-1-sashal@kernel.org>
References: <20240324223455.1342824-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Mark Rutland <mark.rutland@arm.com>

[ Upstream commit 25412c0364f7110faa6053c73e3fd47ca956b8c3 ]

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
Tested-by: Marc Zyngier <maz@kernel.org>
Cc: Hector Martin <marcan@marcan.st>
Cc: James Clark <james.clark@arm.com>
Cc: John Garry <john.g.garry@oracle.com>
Cc: Leo Yan <leo.yan@linux.dev>
Cc: Mike Leach <mike.leach@linaro.org>
Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
Cc: Thomas Richter <tmricht@linux.ibm.com>
Cc: Will Deacon <will@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
Link: https://lore.kernel.org/r/20240126145605.1005472-1-mark.rutland@arm.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/perf/util/print-events.c | 27 +++++++++++++++++++--------
 1 file changed, 19 insertions(+), 8 deletions(-)

diff --git a/tools/perf/util/print-events.c b/tools/perf/util/print-events.c
index 9e47712507cc2..b14d1a894abce 100644
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
2.43.0


