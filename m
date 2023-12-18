Return-Path: <linux-kernel+bounces-4468-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6201E817DEA
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 00:11:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E4E2286498
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 23:11:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99D37768ED;
	Mon, 18 Dec 2023 23:11:11 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from 66-220-144-179.mail-mxout.facebook.com (66-220-144-179.mail-mxout.facebook.com [66.220.144.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA2F176098
	for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 23:11:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=devkernel.io
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=devkernel.io
Received: by devbig1114.prn1.facebook.com (Postfix, from userid 425415)
	id 7028E111427B3; Mon, 18 Dec 2023 15:10:57 -0800 (PST)
From: Stefan Roesch <shr@devkernel.io>
To: kernel-team@fb.com
Cc: shr@devkernel.io,
	akpm@linux-foundation.org,
	david@redhat.com,
	hannes@cmpxchg.org,
	riel@surriel.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH v5 3/4] mm/ksm: add tracepoint for ksm advisor
Date: Mon, 18 Dec 2023 15:10:53 -0800
Message-Id: <20231218231054.1625219-4-shr@devkernel.io>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20231218231054.1625219-1-shr@devkernel.io>
References: <20231218231054.1625219-1-shr@devkernel.io>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This adds a new tracepoint for the ksm advisor. It reports the last scan
time, the new setting of the pages_to_scan parameter and the average cpu
percent usage of the ksmd background thread for the last scan.

Signed-off-by: Stefan Roesch <shr@devkernel.io>
Acked-by: David Hildenbrand <david@redhat.com>
---
 include/trace/events/ksm.h | 33 +++++++++++++++++++++++++++++++++
 mm/ksm.c                   |  1 +
 2 files changed, 34 insertions(+)

diff --git a/include/trace/events/ksm.h b/include/trace/events/ksm.h
index b5ac35c1d0e88..e728647b5d268 100644
--- a/include/trace/events/ksm.h
+++ b/include/trace/events/ksm.h
@@ -245,6 +245,39 @@ TRACE_EVENT(ksm_remove_rmap_item,
 			__entry->pfn, __entry->rmap_item, __entry->mm)
 );
=20
+/**
+ * ksm_advisor - called after the advisor has run
+ *
+ * @scan_time:		scan time in seconds
+ * @pages_to_scan:	new pages_to_scan value
+ * @cpu_percent:	cpu usage in percent
+ *
+ * Allows to trace the ksm advisor.
+ */
+TRACE_EVENT(ksm_advisor,
+
+	TP_PROTO(s64 scan_time, unsigned long pages_to_scan,
+		 unsigned int cpu_percent),
+
+	TP_ARGS(scan_time, pages_to_scan, cpu_percent),
+
+	TP_STRUCT__entry(
+		__field(s64,		scan_time)
+		__field(unsigned long,	pages_to_scan)
+		__field(unsigned int,	cpu_percent)
+	),
+
+	TP_fast_assign(
+		__entry->scan_time	=3D scan_time;
+		__entry->pages_to_scan	=3D pages_to_scan;
+		__entry->cpu_percent	=3D cpu_percent;
+	),
+
+	TP_printk("ksm scan time %lld pages_to_scan %lu cpu percent %u",
+			__entry->scan_time, __entry->pages_to_scan,
+			__entry->cpu_percent)
+);
+
 #endif /* _TRACE_KSM_H */
=20
 /* This part must be outside protection */
diff --git a/mm/ksm.c b/mm/ksm.c
index 10e2696907250..82688fc6f119f 100644
--- a/mm/ksm.c
+++ b/mm/ksm.c
@@ -458,6 +458,7 @@ static void scan_time_advisor(void)
 	advisor_ctx.cpu_time =3D cpu_time;
=20
 	ksm_thread_pages_to_scan =3D pages;
+	trace_ksm_advisor(scan_time, pages, cpu_percent);
 }
=20
 static void advisor_stop_scan(void)
--=20
2.39.3


