Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A19D811C67
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 19:28:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235582AbjLMS1r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 13:27:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235592AbjLMS1j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 13:27:39 -0500
Received: from 66-220-144-179.mail-mxout.facebook.com (66-220-144-179.mail-mxout.facebook.com [66.220.144.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42C33116
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 10:27:46 -0800 (PST)
Received: by devbig1114.prn1.facebook.com (Postfix, from userid 425415)
        id BCBAB10CFA72C; Wed, 13 Dec 2023 10:27:33 -0800 (PST)
From:   Stefan Roesch <shr@devkernel.io>
To:     kernel-team@fb.com
Cc:     shr@devkernel.io, akpm@linux-foundation.org, david@redhat.com,
        hannes@cmpxchg.org, riel@surriel.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: [PATCH v4 3/4] mm/ksm: add tracepoint for ksm advisor
Date:   Wed, 13 Dec 2023 10:27:28 -0800
Message-Id: <20231213182729.587081-4-shr@devkernel.io>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20231213182729.587081-1-shr@devkernel.io>
References: <20231213182729.587081-1-shr@devkernel.io>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=0.1 required=5.0 tests=BAYES_00,HELO_MISC_IP,
        RCVD_IN_DNSWL_BLOCKED,RDNS_DYNAMIC,SPF_HELO_PASS,SPF_NEUTRAL,
        TVD_RCVD_IP,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
index f7387a6d02050..4962e44131e68 100644
--- a/mm/ksm.c
+++ b/mm/ksm.c
@@ -452,6 +452,7 @@ static void scan_time_advisor(void)
 	advisor_ctx.cpu_time =3D cpu_time;
=20
 	ksm_thread_pages_to_scan =3D pages;
+	trace_ksm_advisor(scan_time, pages, cpu_percent);
 }
=20
 static void advisor_stop_scan(void)
--=20
2.39.3

