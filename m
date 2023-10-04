Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B12A67B8C5D
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 21:20:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245457AbjJDTHt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 15:07:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343889AbjJDTHY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 15:07:24 -0400
Received: from 66-220-144-179.mail-mxout.facebook.com (66-220-144-179.mail-mxout.facebook.com [66.220.144.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1F8430EA
        for <linux-kernel@vger.kernel.org>; Wed,  4 Oct 2023 12:03:15 -0700 (PDT)
Received: by devbig1114.prn1.facebook.com (Postfix, from userid 425415)
        id 0521ED08C001; Wed,  4 Oct 2023 12:03:02 -0700 (PDT)
From:   Stefan Roesch <shr@devkernel.io>
To:     kernel-team@fb.com
Cc:     shr@devkernel.io, akpm@linux-foundation.org, david@redhat.com,
        hannes@cmpxchg.org, riel@surriel.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: [PATCH v1 3/4] mm/ksm: add tracepoint for ksm advisor
Date:   Wed,  4 Oct 2023 12:02:48 -0700
Message-Id: <20231004190249.829015-4-shr@devkernel.io>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20231004190249.829015-1-shr@devkernel.io>
References: <20231004190249.829015-1-shr@devkernel.io>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=0.1 required=5.0 tests=BAYES_00,HELO_MISC_IP,
        RCVD_IN_DNSWL_BLOCKED,RDNS_DYNAMIC,SPF_HELO_PASS,SPF_NEUTRAL,
        TVD_RCVD_IP autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds a new tracepoint for the ksm advisor. It reports the last scan
time and the new setting of the pages_to_scan parameter.

Signed-off-by: Stefan Roesch <shr@devkernel.io>
---
 include/trace/events/ksm.h | 28 ++++++++++++++++++++++++++++
 mm/ksm.c                   |  2 ++
 2 files changed, 30 insertions(+)

diff --git a/include/trace/events/ksm.h b/include/trace/events/ksm.h
index b5ac35c1d0e8..164133014922 100644
--- a/include/trace/events/ksm.h
+++ b/include/trace/events/ksm.h
@@ -245,6 +245,34 @@ TRACE_EVENT(ksm_remove_rmap_item,
 			__entry->pfn, __entry->rmap_item, __entry->mm)
 );
=20
+/**
+ * ksm_advisor - called after the advisor has run
+ *
+ * @scan_time:		scan time in seconds
+ * @pages_to_scan:	new pages_to_scan value
+ *
+ * Allows to trace the ksm advisor.
+ */
+TRACE_EVENT(ksm_advisor,
+
+	TP_PROTO(s64 scan_time, unsigned long pages_to_scan),
+
+	TP_ARGS(scan_time, pages_to_scan),
+
+	TP_STRUCT__entry(
+		__field(s64,		scan_time)
+		__field(unsigned long,	pages_to_scan)
+	),
+
+	TP_fast_assign(
+		__entry->scan_time	=3D scan_time;
+		__entry->pages_to_scan	=3D pages_to_scan;
+	),
+
+	TP_printk("ksm scan time %lld pages_to_scan %lu",
+			__entry->scan_time, __entry->pages_to_scan)
+);
+
 #endif /* _TRACE_KSM_H */
=20
 /* This part must be outside protection */
diff --git a/mm/ksm.c b/mm/ksm.c
index 12e70f806b2b..93dff974f6ea 100644
--- a/mm/ksm.c
+++ b/mm/ksm.c
@@ -415,6 +415,8 @@ static void scan_time_advisor(s64 scan_time)
 	advisor_ctx.change =3D change;
 	advisor_ctx.scan_time =3D scan_time;
 	ksm_thread_pages_to_scan =3D pages;
+
+	trace_ksm_advisor(scan_time, pages);
 }
=20
 static void run_advisor(void)
--=20
2.39.3

