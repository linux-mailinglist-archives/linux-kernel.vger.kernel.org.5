Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E679812325
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 00:37:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442675AbjLMXhH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 18:37:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442695AbjLMXgv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 18:36:51 -0500
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F306910A;
        Wed, 13 Dec 2023 15:36:56 -0800 (PST)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3BDNWpG0008639;
        Wed, 13 Dec 2023 23:36:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=kALH6Y40PszMAinDNJqUOT92xkYCLa2PA86QJ0JSv5E=;
 b=rti6IzmvgbsZRjEVeEO1xXvE5pE073L2SYCZ3ZV01QYSF42RcR7ebu8vD2jRYzkQtXw5
 +O6U2ydu4p1TuIwsNLP+vZyVYfYFfgQWDJo7R6dJpYlC7lircnWjz0CfJO5mjBKVkWjK
 BPxWsgF37h1WKIzZzVZxQAUv8LCOqN5aD3SIpA4NtXXEIXPfJTFrVdb0jXXvRjjx66aa
 EtPawQFf1/kgV1dsNJJNtOotYqGFxBf7IhPnzxzLnxgYq5RSP0qaZNtfpVRJIzoxa/CT
 wNP/icCT57ZYwxne1b6oPTUEHe35U6bvvZdKEn16MZ+ZA4bHiztVwAuLRyC6nm3sgCmW KA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3uypce81tm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 13 Dec 2023 23:36:37 +0000
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3BDNaaPI017559;
        Wed, 13 Dec 2023 23:36:36 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3uypce81sp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 13 Dec 2023 23:36:36 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
        by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3BDKwk1X008585;
        Wed, 13 Dec 2023 23:36:29 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
        by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3uw2jtmvkk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 13 Dec 2023 23:36:29 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
        by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3BDNaR9V20906592
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 13 Dec 2023 23:36:27 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E149B2004B;
        Wed, 13 Dec 2023 23:36:26 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7B4F320040;
        Wed, 13 Dec 2023 23:36:25 +0000 (GMT)
Received: from heavy.boeblingen.de.ibm.com (unknown [9.171.70.156])
        by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Wed, 13 Dec 2023 23:36:25 +0000 (GMT)
From:   Ilya Leoshkevich <iii@linux.ibm.com>
To:     Alexander Gordeev <agordeev@linux.ibm.com>,
        Alexander Potapenko <glider@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Lameter <cl@linux.com>,
        David Rientjes <rientjes@google.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Marco Elver <elver@google.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Pekka Enberg <penberg@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Vlastimil Babka <vbabka@suse.cz>
Cc:     Christian Borntraeger <borntraeger@linux.ibm.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-s390@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Sven Schnelle <svens@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH v3 11/34] kmsan: Allow disabling KMSAN checks for the current task
Date:   Thu, 14 Dec 2023 00:24:31 +0100
Message-ID: <20231213233605.661251-12-iii@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231213233605.661251-1-iii@linux.ibm.com>
References: <20231213233605.661251-1-iii@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: jBznlbH2FEtEOu-Pu04xnJahDcCOZLZZ
X-Proofpoint-ORIG-GUID: is7ZIVg49ekM5OZcy2r9v7nHMXQ7PWe1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-13_14,2023-12-13_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxlogscore=999
 lowpriorityscore=0 adultscore=0 phishscore=0 mlxscore=0 suspectscore=0
 priorityscore=1501 clxscore=1015 spamscore=0 impostorscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2312130167
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Like for KASAN, it's useful to temporarily disable KMSAN checks around,
e.g., redzone accesses. Introduce kmsan_disable_current() and
kmsan_enable_current(), which are similar to their KASAN counterparts.

Make them reentrant in order to handle memory allocations in interrupt
context. Repurpose the allow_reporting field for this.

Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 Documentation/dev-tools/kmsan.rst |  4 ++--
 include/linux/kmsan.h             | 24 ++++++++++++++++++++++++
 include/linux/kmsan_types.h       |  2 +-
 mm/kmsan/core.c                   |  1 -
 mm/kmsan/hooks.c                  | 18 +++++++++++++++---
 mm/kmsan/report.c                 |  7 ++++---
 6 files changed, 46 insertions(+), 10 deletions(-)

diff --git a/Documentation/dev-tools/kmsan.rst b/Documentation/dev-tools/kmsan.rst
index 323eedad53cd..022a823f5f1b 100644
--- a/Documentation/dev-tools/kmsan.rst
+++ b/Documentation/dev-tools/kmsan.rst
@@ -338,11 +338,11 @@ Per-task KMSAN state
 ~~~~~~~~~~~~~~~~~~~~
 
 Every task_struct has an associated KMSAN task state that holds the KMSAN
-context (see above) and a per-task flag disallowing KMSAN reports::
+context (see above) and a per-task counter disallowing KMSAN reports::
 
   struct kmsan_context {
     ...
-    bool allow_reporting;
+    unsigned int depth;
     struct kmsan_context_state cstate;
     ...
   }
diff --git a/include/linux/kmsan.h b/include/linux/kmsan.h
index fe6c2212bdb1..23de1b3d6aee 100644
--- a/include/linux/kmsan.h
+++ b/include/linux/kmsan.h
@@ -239,6 +239,22 @@ void kmsan_unpoison_entry_regs(const struct pt_regs *regs);
  */
 void *kmsan_get_metadata(void *addr, bool is_origin);
 
+/*
+ * kmsan_enable_current(): Enable KMSAN for the current task.
+ *
+ * Each kmsan_enable_current() current call must be preceded by a
+ * kmsan_disable_current() call. These call pairs may be nested.
+ */
+void kmsan_enable_current(void);
+
+/*
+ * kmsan_disable_current(): Disable KMSAN for the current task.
+ *
+ * Each kmsan_disable_current() current call must be followed by a
+ * kmsan_enable_current() call. These call pairs may be nested.
+ */
+void kmsan_disable_current(void);
+
 #else
 
 static inline void kmsan_init_shadow(void)
@@ -338,6 +354,14 @@ static inline void kmsan_unpoison_entry_regs(const struct pt_regs *regs)
 {
 }
 
+static inline void kmsan_enable_current(void)
+{
+}
+
+static inline void kmsan_disable_current(void)
+{
+}
+
 #endif
 
 #endif /* _LINUX_KMSAN_H */
diff --git a/include/linux/kmsan_types.h b/include/linux/kmsan_types.h
index 8bfa6c98176d..27bb146ece95 100644
--- a/include/linux/kmsan_types.h
+++ b/include/linux/kmsan_types.h
@@ -29,7 +29,7 @@ struct kmsan_context_state {
 struct kmsan_ctx {
 	struct kmsan_context_state cstate;
 	int kmsan_in_runtime;
-	bool allow_reporting;
+	unsigned int depth;
 };
 
 #endif /* _LINUX_KMSAN_TYPES_H */
diff --git a/mm/kmsan/core.c b/mm/kmsan/core.c
index c19f47af0424..68c68b30441d 100644
--- a/mm/kmsan/core.c
+++ b/mm/kmsan/core.c
@@ -43,7 +43,6 @@ void kmsan_internal_task_create(struct task_struct *task)
 	struct thread_info *info = current_thread_info();
 
 	__memset(ctx, 0, sizeof(*ctx));
-	ctx->allow_reporting = true;
 	kmsan_internal_unpoison_memory(info, sizeof(*info), false);
 }
 
diff --git a/mm/kmsan/hooks.c b/mm/kmsan/hooks.c
index eafc45f937eb..3acf010c9814 100644
--- a/mm/kmsan/hooks.c
+++ b/mm/kmsan/hooks.c
@@ -39,12 +39,10 @@ void kmsan_task_create(struct task_struct *task)
 
 void kmsan_task_exit(struct task_struct *task)
 {
-	struct kmsan_ctx *ctx = &task->kmsan_ctx;
-
 	if (!kmsan_enabled || kmsan_in_runtime())
 		return;
 
-	ctx->allow_reporting = false;
+	kmsan_disable_current();
 }
 
 void kmsan_slab_alloc(struct kmem_cache *s, void *object, gfp_t flags)
@@ -423,3 +421,17 @@ void kmsan_check_memory(const void *addr, size_t size)
 					   REASON_ANY);
 }
 EXPORT_SYMBOL(kmsan_check_memory);
+
+void kmsan_enable_current(void)
+{
+	KMSAN_WARN_ON(current->kmsan_ctx.depth == 0);
+	current->kmsan_ctx.depth--;
+}
+EXPORT_SYMBOL(kmsan_enable_current);
+
+void kmsan_disable_current(void)
+{
+	current->kmsan_ctx.depth++;
+	KMSAN_WARN_ON(current->kmsan_ctx.depth == 0);
+}
+EXPORT_SYMBOL(kmsan_disable_current);
diff --git a/mm/kmsan/report.c b/mm/kmsan/report.c
index c79d3b0d2d0d..92e73ec61435 100644
--- a/mm/kmsan/report.c
+++ b/mm/kmsan/report.c
@@ -8,6 +8,7 @@
  */
 
 #include <linux/console.h>
+#include <linux/kmsan.h>
 #include <linux/moduleparam.h>
 #include <linux/stackdepot.h>
 #include <linux/stacktrace.h>
@@ -158,12 +159,12 @@ void kmsan_report(depot_stack_handle_t origin, void *address, int size,
 
 	if (!kmsan_enabled)
 		return;
-	if (!current->kmsan_ctx.allow_reporting)
+	if (current->kmsan_ctx.depth)
 		return;
 	if (!origin)
 		return;
 
-	current->kmsan_ctx.allow_reporting = false;
+	kmsan_disable_current();
 	ua_flags = user_access_save();
 	raw_spin_lock(&kmsan_report_lock);
 	pr_err("=====================================================\n");
@@ -216,5 +217,5 @@ void kmsan_report(depot_stack_handle_t origin, void *address, int size,
 	if (panic_on_kmsan)
 		panic("kmsan.panic set ...\n");
 	user_access_restore(ua_flags);
-	current->kmsan_ctx.allow_reporting = true;
+	kmsan_enable_current();
 }
-- 
2.43.0

