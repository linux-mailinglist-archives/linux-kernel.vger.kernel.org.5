Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDB017F0EE4
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 10:20:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232585AbjKTJUf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 04:20:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232495AbjKTJUa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 04:20:30 -0500
Received: from pv50p00im-ztdg10011201.me.com (pv50p00im-ztdg10011201.me.com [17.58.6.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF71BBC
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 01:20:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=me.com; s=1a1hai;
        t=1700471581; bh=AWaj1ki3rwcuwpTBAPDzYvQWi1J126ZZaCIJ2Nblgd8=;
        h=From:To:Subject:Date:Message-Id:MIME-Version;
        b=rYi1u8wZOp0OrfiANALqBBzTEN2M0f6lGNJBSLz6HLwevM0aEhdQWh9aoZkirKdFM
         NergaZPv15dFBOa6yN26VLwf60oecQ2t1knY4//RG/5gLDDgpr5uOiFdyPBu1dFuK2
         uy0BPrTW6OQTPP2WBeurw/gtydeSpsyHK3GGRcaP/eV3OT+42TEaJ8U6TACpXKliX9
         39d4pmfOhcG/iHZdyYJWpzdinJSiDGZvUqdrVJdeVscEPGZn85OitiKchCZ9vAVSBT
         Nx7zkD344/z0XjshDlf1XVTEi6cOESbvkOasJobMN7rZ1ND1c+fshy8KEdgyoI9x45
         W2ZV4djkODAqg==
Received: from xiongwei.. (pv50p00im-dlb-asmtp-mailmevip.me.com [17.56.9.10])
        by pv50p00im-ztdg10011201.me.com (Postfix) with ESMTPSA id BE336680246;
        Mon, 20 Nov 2023 09:12:56 +0000 (UTC)
From:   sxwjean@me.com
To:     cl@linux.com, penberg@kernel.org, rientjes@google.com,
        iamjoonsoo.kim@lge.com, vbabka@suse.cz, roman.gushchin@linux.dev,
        42.hyeyoo@gmail.com
Cc:     corbet@lwn.net, linux-mm@kvack.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 4/4] mm/slab: move slab merge from slab_common.c to slub.c
Date:   Mon, 20 Nov 2023 17:12:14 +0800
Message-Id: <20231120091214.150502-5-sxwjean@me.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231120091214.150502-1-sxwjean@me.com>
References: <20231120091214.150502-1-sxwjean@me.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: wmdiAmmV3HG-u_79uyar0KcaBugWOyer
X-Proofpoint-ORIG-GUID: wmdiAmmV3HG-u_79uyar0KcaBugWOyer
X-Proofpoint-Virus-Version: =?UTF-8?Q?vendor=3Dfsecure_engine=3D1.1.170-22c6f66c430a71ce266a39bfe25bc?=
 =?UTF-8?Q?2903e8d5c8f:6.0.517,18.0.883,17.0.605.474.0000000_definitions?=
 =?UTF-8?Q?=3D2022-06-21=5F08:2022-06-21=5F01,2022-06-21=5F08,2020-01-23?=
 =?UTF-8?Q?=5F02_signatures=3D0?=
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 suspectscore=0
 bulkscore=0 clxscore=1015 adultscore=0 phishscore=0 mlxscore=0
 malwarescore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2311200061
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xiongwei Song <xiongwei.song@windriver.com>

Since slab allocator has been removed. There is no users about slab
merge except slub. This commit is almost to revert
commit 423c929cbbec ("mm/slab_common: commonize slab merge logic").

Also change all prefix of slab merge related functions, variables and
definitions from "slab/SLAB" to"slub/SLUB".

Signed-off-by: Xiongwei Song <xiongwei.song@windriver.com>
---
 mm/slab.h        |   3 --
 mm/slab_common.c |  98 ----------------------------------------------
 mm/slub.c        | 100 ++++++++++++++++++++++++++++++++++++++++++++++-
 3 files changed, 99 insertions(+), 102 deletions(-)

diff --git a/mm/slab.h b/mm/slab.h
index 8d20f8c6269d..cd52e705ce28 100644
--- a/mm/slab.h
+++ b/mm/slab.h
@@ -429,9 +429,6 @@ extern void create_boot_cache(struct kmem_cache *, const char *name,
 
 unsigned int calculate_alignment(slab_flags_t flags,
 		unsigned int align, unsigned int size);
-int slab_unmergeable(struct kmem_cache *s);
-struct kmem_cache *find_mergeable(unsigned size, unsigned align,
-		slab_flags_t flags, const char *name, void (*ctor)(void *));
 struct kmem_cache *
 __kmem_cache_alias(const char *name, unsigned int size, unsigned int align,
 		   slab_flags_t flags, void (*ctor)(void *));
diff --git a/mm/slab_common.c b/mm/slab_common.c
index 62eb77fdedf2..6960ae5c35ee 100644
--- a/mm/slab_common.c
+++ b/mm/slab_common.c
@@ -45,36 +45,6 @@ static void slab_caches_to_rcu_destroy_workfn(struct work_struct *work);
 static DECLARE_WORK(slab_caches_to_rcu_destroy_work,
 		    slab_caches_to_rcu_destroy_workfn);
 
-/*
- * Set of flags that will prevent slab merging
- */
-#define SLAB_NEVER_MERGE (SLAB_RED_ZONE | SLAB_POISON | SLAB_STORE_USER | \
-		SLAB_TRACE | SLAB_TYPESAFE_BY_RCU | SLAB_NOLEAKTRACE | \
-		SLAB_FAILSLAB | SLAB_NO_MERGE | kasan_never_merge())
-
-#define SLAB_MERGE_SAME (SLAB_RECLAIM_ACCOUNT | SLAB_CACHE_DMA | \
-			 SLAB_CACHE_DMA32 | SLAB_ACCOUNT)
-
-/*
- * Merge control. If this is set then no merging of slab caches will occur.
- */
-static bool slub_nomerge = !IS_ENABLED(CONFIG_SLAB_MERGE_DEFAULT);
-
-static int __init setup_slab_nomerge(char *str)
-{
-	slub_nomerge = true;
-	return 1;
-}
-
-static int __init setup_slab_merge(char *str)
-{
-	slub_nomerge = false;
-	return 1;
-}
-
-__setup_param("slub_nomerge", slub_nomerge, setup_slab_nomerge, 0);
-__setup_param("slub_merge", slub_merge, setup_slab_merge, 0);
-
 /*
  * Determine the size of a slab object
  */
@@ -130,74 +100,6 @@ unsigned int calculate_alignment(slab_flags_t flags,
 	return ALIGN(align, sizeof(void *));
 }
 
-/*
- * Find a mergeable slab cache
- */
-int slab_unmergeable(struct kmem_cache *s)
-{
-	if (slub_nomerge || (s->flags & SLAB_NEVER_MERGE))
-		return 1;
-
-	if (s->ctor)
-		return 1;
-
-#ifdef CONFIG_HARDENED_USERCOPY
-	if (s->usersize)
-		return 1;
-#endif
-
-	/*
-	 * We may have set a slab to be unmergeable during bootstrap.
-	 */
-	if (s->refcount < 0)
-		return 1;
-
-	return 0;
-}
-
-struct kmem_cache *find_mergeable(unsigned int size, unsigned int align,
-		slab_flags_t flags, const char *name, void (*ctor)(void *))
-{
-	struct kmem_cache *s;
-
-	if (slub_nomerge)
-		return NULL;
-
-	if (ctor)
-		return NULL;
-
-	size = ALIGN(size, sizeof(void *));
-	align = calculate_alignment(flags, align, size);
-	size = ALIGN(size, align);
-	flags = kmem_cache_flags(size, flags, name);
-
-	if (flags & SLAB_NEVER_MERGE)
-		return NULL;
-
-	list_for_each_entry_reverse(s, &slab_caches, list) {
-		if (slab_unmergeable(s))
-			continue;
-
-		if (size > s->size)
-			continue;
-
-		if ((flags & SLAB_MERGE_SAME) != (s->flags & SLAB_MERGE_SAME))
-			continue;
-		/*
-		 * Check if alignment is compatible.
-		 * Courtesy of Adrian Drzewiecki
-		 */
-		if ((s->size & ~(align - 1)) != s->size)
-			continue;
-
-		if (s->size - size >= sizeof(void *))
-			continue;
-
-		return s;
-	}
-	return NULL;
-}
-
 static struct kmem_cache *create_cache(const char *name,
 		unsigned int object_size, unsigned int align,
 		slab_flags_t flags, unsigned int useroffset,
diff --git a/mm/slub.c b/mm/slub.c
index ae1e6e635253..435d9ed140e4 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -709,6 +709,104 @@ static inline bool slab_update_freelist(struct kmem_cache *s, struct slab *slab,
 	return false;
 }
 
+/*
+ * Set of flags that will prevent slab merging
+ */
+#define SLUB_NEVER_MERGE (SLAB_RED_ZONE | SLAB_POISON | SLAB_STORE_USER | \
+		SLAB_TRACE | SLAB_TYPESAFE_BY_RCU | SLAB_NOLEAKTRACE | \
+		SLAB_FAILSLAB | SLAB_NO_MERGE | kasan_never_merge())
+
+#define SLUB_MERGE_SAME (SLAB_RECLAIM_ACCOUNT | SLAB_CACHE_DMA | \
+			 SLAB_CACHE_DMA32 | SLAB_ACCOUNT)
+
+/*
+ * Merge control. If this is set then no merging of slab caches will occur.
+ */
+static bool slub_nomerge = !IS_ENABLED(CONFIG_SLAB_MERGE_DEFAULT);
+
+static int __init setup_slub_nomerge(char *str)
+{
+	slub_nomerge = true;
+	return 1;
+}
+
+static int __init setup_slub_merge(char *str)
+{
+	slub_nomerge = false;
+	return 1;
+}
+
+__setup_param("slub_nomerge", slub_nomerge, setup_slab_nomerge, 0);
+__setup_param("slub_merge", slub_merge, setup_slab_merge, 0);
+
+/*
+ * Find a mergeable slab cache
+ */
+static inline int slub_unmergeable(struct kmem_cache *s)
+{
+	if (slub_nomerge || (s->flags & SLUB_NEVER_MERGE))
+		return 1;
+
+	if (s->ctor)
+		return 1;
+
+#ifdef CONFIG_HARDENED_USERCOPY
+	if (s->usersize)
+		return 1;
+#endif
+
+	/*
+	 * We may have set a slab to be unmergeable during bootstrap.
+	 */
+	if (s->refcount < 0)
+		return 1;
+
+	return 0;
+}
+
+static struct kmem_cache *find_mergeable(unsigned int size, unsigned int align,
+		slab_flags_t flags, const char *name, void (*ctor)(void *))
+{
+	struct kmem_cache *s;
+
+	if (slub_nomerge)
+		return NULL;
+
+	if (ctor)
+		return NULL;
+
+	size = ALIGN(size, sizeof(void *));
+	align = calculate_alignment(flags, align, size);
+	size = ALIGN(size, align);
+	flags = kmem_cache_flags(size, flags, name);
+
+	if (flags & SLUB_NEVER_MERGE)
+		return NULL;
+
+	list_for_each_entry_reverse(s, &slab_caches, list) {
+		if (slub_unmergeable(s))
+			continue;
+
+		if (size > s->size)
+			continue;
+
+		if ((flags & SLUB_MERGE_SAME) != (s->flags & SLUB_MERGE_SAME))
+			continue;
+		/*
+		 * Check if alignment is compatible.
+		 * Courtesy of Adrian Drzewiecki
+		 */
+		if ((s->size & ~(align - 1)) != s->size)
+			continue;
+
+		if (s->size - size >= sizeof(void *))
+			continue;
+
+		return s;
+	}
+	return NULL;
+}
+
 #ifdef CONFIG_SLUB_DEBUG
 static unsigned long object_map[BITS_TO_LONGS(MAX_OBJS_PER_PAGE)];
 static DEFINE_SPINLOCK(object_map_lock);
@@ -6679,7 +6777,7 @@ static int sysfs_slab_add(struct kmem_cache *s)
 	int err;
 	const char *name;
 	struct kset *kset = cache_kset(s);
-	int unmergeable = slab_unmergeable(s);
+	int unmergeable = slub_unmergeable(s);
 
 	if (!unmergeable && disable_higher_order_debug &&
 			(slub_debug & DEBUG_METADATA_FLAGS))
-- 
2.34.1

