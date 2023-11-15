Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54D8C7ED24F
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 21:35:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344597AbjKOUfn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 15:35:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235701AbjKOUfI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 15:35:08 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62D7AE5;
        Wed, 15 Nov 2023 12:34:52 -0800 (PST)
Received: from pps.filterd (m0353728.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AFKWmer030721;
        Wed, 15 Nov 2023 20:34:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=7CSL1yly+mfTewmMZpRp6TG2r/w75e0//7iE+NvfE7E=;
 b=axpKf0C/ZK/y3UTVDuOPNB4zkPQc//qb+BANtaAjODsnGHwLBbs2P3W3of5diek/MTsz
 Pnthd+vfpolYybLS/DJpAM4eoztiGrZvjqYPNa5oOc7TW608nW5UbAsxDPf2eFYPCk8p
 JiiOSUs+eNTSVpE7U3Hzt8w8DCtSKI6HnsZgO6KgBkpZbTz3NxAYeP6te1/NnY/Q+9Zf
 MArD2wVJhbErxcE1rnIw8hvLBhIg1D24d6jWWrs53939dw8cpRGsbTNloROSzYX6hOf4
 I4kL6jrqaAYhw23a5uT8MO6y30dLGEUKNUUj0Z/dmXd3VQuG/1INwiewlYLy00npd/y9 8Q== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ud543g1aj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 15 Nov 2023 20:34:34 +0000
Received: from m0353728.ppops.net (m0353728.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3AFKXiCV001884;
        Wed, 15 Nov 2023 20:34:34 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ud543g1a3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 15 Nov 2023 20:34:34 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
        by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3AFKJ06d014625;
        Wed, 15 Nov 2023 20:34:32 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
        by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3uaneksvsy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 15 Nov 2023 20:34:32 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
        by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3AFKYTS916253564
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 15 Nov 2023 20:34:29 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1DC912004D;
        Wed, 15 Nov 2023 20:34:29 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C5CD220040;
        Wed, 15 Nov 2023 20:34:27 +0000 (GMT)
Received: from heavy.boeblingen.de.ibm.com (unknown [9.179.9.51])
        by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Wed, 15 Nov 2023 20:34:27 +0000 (GMT)
From:   Ilya Leoshkevich <iii@linux.ibm.com>
To:     Alexander Gordeev <agordeev@linux.ibm.com>,
        Alexander Potapenko <glider@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Lameter <cl@linux.com>,
        David Rientjes <rientjes@google.com>,
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
Subject: [PATCH 12/32] kmsan: Allow disabling KMSAN checks for the current task
Date:   Wed, 15 Nov 2023 21:30:44 +0100
Message-ID: <20231115203401.2495875-13-iii@linux.ibm.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231115203401.2495875-1-iii@linux.ibm.com>
References: <20231115203401.2495875-1-iii@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: _iPe_nLp2MEt0BGzXvKFnSXZBmzon80R
X-Proofpoint-GUID: zd4VFCqUaPM6hnX8Cj5Ti_7HDBuQLQCb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-15_20,2023-11-15_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 phishscore=0
 spamscore=0 adultscore=0 priorityscore=1501 suspectscore=0 clxscore=1015
 mlxlogscore=999 bulkscore=0 mlxscore=0 lowpriorityscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311060000
 definitions=main-2311150163
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

Even though it's not strictly necessary, make them reentrant, in order
to match the KASAN behavior. Repurpose the allow_reporting field for
this.

Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 Documentation/dev-tools/kmsan.rst |  4 ++--
 include/linux/kmsan-checks.h      | 12 ++++++++++++
 include/linux/kmsan_types.h       |  2 +-
 mm/kmsan/core.c                   |  2 +-
 mm/kmsan/hooks.c                  | 14 +++++++++++++-
 mm/kmsan/report.c                 |  6 +++---
 6 files changed, 32 insertions(+), 8 deletions(-)

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
diff --git a/include/linux/kmsan-checks.h b/include/linux/kmsan-checks.h
index 5218973f0ad0..bab2603685f7 100644
--- a/include/linux/kmsan-checks.h
+++ b/include/linux/kmsan-checks.h
@@ -72,6 +72,10 @@ void kmsan_copy_to_user(void __user *to, const void *from, size_t to_copy,
  */
 void kmsan_memmove_metadata(void *dst, const void *src, size_t n);
 
+void kmsan_enable_current(void);
+
+void kmsan_disable_current(void);
+
 #else
 
 static inline void kmsan_poison_memory(const void *address, size_t size,
@@ -92,6 +96,14 @@ static inline void kmsan_memmove_metadata(void *dst, const void *src, size_t n)
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
 
 #endif /* _LINUX_KMSAN_CHECKS_H */
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
index c19f47af0424..b8767378cf8a 100644
--- a/mm/kmsan/core.c
+++ b/mm/kmsan/core.c
@@ -43,7 +43,7 @@ void kmsan_internal_task_create(struct task_struct *task)
 	struct thread_info *info = current_thread_info();
 
 	__memset(ctx, 0, sizeof(*ctx));
-	ctx->allow_reporting = true;
+	ctx->depth = 0;
 	kmsan_internal_unpoison_memory(info, sizeof(*info), false);
 }
 
diff --git a/mm/kmsan/hooks.c b/mm/kmsan/hooks.c
index 4d477a0a356c..7b5814412e9f 100644
--- a/mm/kmsan/hooks.c
+++ b/mm/kmsan/hooks.c
@@ -44,7 +44,7 @@ void kmsan_task_exit(struct task_struct *task)
 	if (!kmsan_enabled || kmsan_in_runtime())
 		return;
 
-	ctx->allow_reporting = false;
+	ctx->depth++;
 }
 
 void kmsan_slab_alloc(struct kmem_cache *s, void *object, gfp_t flags)
@@ -434,3 +434,15 @@ void kmsan_check_memory(const void *addr, size_t size)
 					   REASON_ANY);
 }
 EXPORT_SYMBOL(kmsan_check_memory);
+
+void kmsan_enable_current(void)
+{
+	current->kmsan_ctx.depth--;
+}
+EXPORT_SYMBOL(kmsan_enable_current);
+
+void kmsan_disable_current(void)
+{
+	current->kmsan_ctx.depth++;
+}
+EXPORT_SYMBOL(kmsan_disable_current);
diff --git a/mm/kmsan/report.c b/mm/kmsan/report.c
index c79d3b0d2d0d..edcf53ca428e 100644
--- a/mm/kmsan/report.c
+++ b/mm/kmsan/report.c
@@ -158,12 +158,12 @@ void kmsan_report(depot_stack_handle_t origin, void *address, int size,
 
 	if (!kmsan_enabled)
 		return;
-	if (!current->kmsan_ctx.allow_reporting)
+	if (current->kmsan_ctx.depth)
 		return;
 	if (!origin)
 		return;
 
-	current->kmsan_ctx.allow_reporting = false;
+	current->kmsan_ctx.depth++;
 	ua_flags = user_access_save();
 	raw_spin_lock(&kmsan_report_lock);
 	pr_err("=====================================================\n");
@@ -216,5 +216,5 @@ void kmsan_report(depot_stack_handle_t origin, void *address, int size,
 	if (panic_on_kmsan)
 		panic("kmsan.panic set ...\n");
 	user_access_restore(ua_flags);
-	current->kmsan_ctx.allow_reporting = true;
+	current->kmsan_ctx.depth--;
 }
-- 
2.41.0

