Return-Path: <linux-kernel+bounces-415-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C44A28140C0
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 04:43:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B99871C2217F
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 03:43:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AD1ADDC7;
	Fri, 15 Dec 2023 03:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=me.com header.i=@me.com header.b="Tm4gEt2e"
X-Original-To: linux-kernel@vger.kernel.org
Received: from pv50p00im-ztdg10021901.me.com (pv50p00im-ztdg10021901.me.com [17.58.6.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 220A0DDB8
	for <linux-kernel@vger.kernel.org>; Fri, 15 Dec 2023 03:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=me.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=me.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=me.com; s=1a1hai;
	t=1702611804; bh=bODnJlG+KG/EKv36cxETUCIM/X+NGX+FI+DxIHyVCJg=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=Tm4gEt2epNLFRKmu4dJdJWK4EaWsxTyz7iD8+xIaF3Gbt0jw/GH2WIZfHBqbpqWMF
	 9kaWSqKVqEEhTPzyAAdoklWOFX5NLIsybV7JM8UfW0y4z0PZ5l6zVPpRTF+q74QnyX
	 px8SumtjYW6GyCTl4MfQioCGfG/yQxmS0ePs34JJISqOGrH3zE4bWnVfEpEot5Ih/w
	 2v/WWKizvhhvVayAdRyttxlDazD77N3j3SF8Nn9/VXFzdinq7jwzGeC6IizO8GB+q7
	 4naOrCvtOGV90tEtPQ1oOg2+/vcW2lxPYk5cOLWaYGmMj5wf3iQ0Owda583ogRTSjr
	 zeWkgzXSurFHA==
Received: from xiongwei.. (pv50p00im-dlb-asmtp-mailmevip.me.com [17.56.9.10])
	by pv50p00im-ztdg10021901.me.com (Postfix) with ESMTPSA id B4ACB814DA;
	Fri, 15 Dec 2023 03:42:58 +0000 (UTC)
From: sxwjean@me.com
To: vbabka@suse.cz,
	42.hyeyoo@gmail.com,
	cl@linux.com,
	linux-mm@kvack.org
Cc: penberg@kernel.org,
	rientjes@google.com,
	iamjoonsoo.kim@lge.com,
	roman.gushchin@linux.dev,
	corbet@lwn.net,
	keescook@chromium.org,
	arnd@arndb.de,
	akpm@linux-foundation.org,
	gregkh@linuxfoundation.org,
	quic_jjohnson@quicinc.com,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Xiongwei Song <xiongwei.song@windriver.com>
Subject: [PATCH v4 2/4] mm/slub: unify all sl[au]b parameters with "slab_$param"
Date: Fri, 15 Dec 2023 11:41:48 +0800
Message-Id: <20231215034150.108783-3-sxwjean@me.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231215034150.108783-1-sxwjean@me.com>
References: <20231215034150.108783-1-sxwjean@me.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: VflpYgzwl0eQjRpp7fpmWdTvV29PQhUV
X-Proofpoint-ORIG-GUID: VflpYgzwl0eQjRpp7fpmWdTvV29PQhUV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-14_17,2023-12-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0
 malwarescore=0 mlxlogscore=999 bulkscore=0 spamscore=0 mlxscore=0
 phishscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2312150026

From: Xiongwei Song <xiongwei.song@windriver.com>

Since the SLAB allocator has been removed, so we can clean up the
sl[au]b_$params. With only one slab allocator left, it's better to use the
generic "slab" term instead of "slub" which is an implementation detail,
which is pointed out by Vlastimil Babka. For more information please see
[1]. Hence, we are going to use "slab_$param" as the primary prefix.

This patch is changing the following slab parameters
- slub_max_order
- slub_min_order
- slub_min_objects
- slub_debug
to
- slab_max_order
- slab_min_order
- slab_min_objects
- slab_debug
as the primary slab parameters for all references of them in docs and
comments. But this patch won't change variables and functions inside
slub as we will have wider slub/slab change.

Meanwhile, "slub_$params" can also be passed by command line, which is
to keep backward compatibility. Also mark all "slub_$params" as legacy.

Remove the separate descriptions for slub_[no]merge, append legacy tip
for them at the end of descriptions of slab_[no]merge.

[1] https://lore.kernel.org/linux-mm/7512b350-4317-21a0-fab3-4101bc4d8f7a@suse.cz/

Signed-off-by: Xiongwei Song <xiongwei.song@windriver.com>
---
 .../admin-guide/kernel-parameters.txt         | 71 +++++++++----------
 drivers/misc/lkdtm/heap.c                     |  2 +-
 mm/Kconfig.debug                              |  6 +-
 mm/slab.h                                     |  2 +-
 mm/slab_common.c                              |  4 +-
 mm/slub.c                                     | 41 ++++++-----
 6 files changed, 62 insertions(+), 64 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 9f94baeb2f82..abfc0838feb9 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -5864,65 +5864,58 @@
 	simeth=		[IA-64]
 	simscsi=
 
-	slram=		[HW,MTD]
-
-	slab_merge	[MM]
-			Enable merging of slabs with similar size when the
-			kernel is built without CONFIG_SLAB_MERGE_DEFAULT.
-
-	slab_nomerge	[MM]
-			Disable merging of slabs with similar size. May be
-			necessary if there is some reason to distinguish
-			allocs to different slabs, especially in hardened
-			environments where the risk of heap overflows and
-			layout control by attackers can usually be
-			frustrated by disabling merging. This will reduce
-			most of the exposure of a heap attack to a single
-			cache (risks via metadata attacks are mostly
-			unchanged). Debug options disable merging on their
-			own.
-			For more information see Documentation/mm/slub.rst.
-
-	slab_max_order=	[MM, SLAB]
-			Determines the maximum allowed order for slabs.
-			A high setting may cause OOMs due to memory
-			fragmentation.  Defaults to 1 for systems with
-			more than 32MB of RAM, 0 otherwise.
-
-	slub_debug[=options[,slabs][;[options[,slabs]]...]	[MM, SLUB]
-			Enabling slub_debug allows one to determine the
+	slab_debug[=options[,slabs][;[options[,slabs]]...]	[MM]
+			Enabling slab_debug allows one to determine the
 			culprit if slab objects become corrupted. Enabling
-			slub_debug can create guard zones around objects and
+			slab_debug can create guard zones around objects and
 			may poison objects when not in use. Also tracks the
 			last alloc / free. For more information see
 			Documentation/mm/slub.rst.
+			(slub_debug legacy name also accepted for now)
 
-	slub_max_order= [MM, SLUB]
+	slab_max_order= [MM]
 			Determines the maximum allowed order for slabs.
 			A high setting may cause OOMs due to memory
 			fragmentation. For more information see
 			Documentation/mm/slub.rst.
+			(slub_max_order legacy name also accepted for now)
+
+	slab_merge	[MM]
+			Enable merging of slabs with similar size when the
+			kernel is built without CONFIG_SLAB_MERGE_DEFAULT.
+			(slub_merge legacy name also accepted for now)
 
-	slub_min_objects=	[MM, SLUB]
+	slab_min_objects=	[MM]
 			The minimum number of objects per slab. SLUB will
-			increase the slab order up to slub_max_order to
+			increase the slab order up to slab_max_order to
 			generate a sufficiently large slab able to contain
 			the number of objects indicated. The higher the number
 			of objects the smaller the overhead of tracking slabs
 			and the less frequently locks need to be acquired.
 			For more information see Documentation/mm/slub.rst.
+			(slub_min_objects legacy name also accepted for now)
 
-	slub_min_order=	[MM, SLUB]
+	slab_min_order=	[MM]
 			Determines the minimum page order for slabs. Must be
-			lower than slub_max_order.
-			For more information see Documentation/mm/slub.rst.
+			lower or equal to slab_max_order. For more information see
+			Documentation/mm/slub.rst.
+			(slub_min_order legacy name also accepted for now)
 
-	slub_merge	[MM, SLUB]
-			Same with slab_merge.
+	slab_nomerge	[MM]
+			Disable merging of slabs with similar size. May be
+			necessary if there is some reason to distinguish
+			allocs to different slabs, especially in hardened
+			environments where the risk of heap overflows and
+			layout control by attackers can usually be
+			frustrated by disabling merging. This will reduce
+			most of the exposure of a heap attack to a single
+			cache (risks via metadata attacks are mostly
+			unchanged). Debug options disable merging on their
+			own.
+			For more information see Documentation/mm/slub.rst.
+			(slub_nomerge legacy name also accepted for now)
 
-	slub_nomerge	[MM, SLUB]
-			Same with slab_nomerge. This is supported for legacy.
-			See slab_nomerge for more information.
+	slram=		[HW,MTD]
 
 	smart2=		[HW]
 			Format: <io1>[,<io2>[,...,<io8>]]
diff --git a/drivers/misc/lkdtm/heap.c b/drivers/misc/lkdtm/heap.c
index 0ce4cbf6abda..076ca9b225de 100644
--- a/drivers/misc/lkdtm/heap.c
+++ b/drivers/misc/lkdtm/heap.c
@@ -47,7 +47,7 @@ static void lkdtm_VMALLOC_LINEAR_OVERFLOW(void)
  * correctly.
  *
  * This should get caught by either memory tagging, KASan, or by using
- * CONFIG_SLUB_DEBUG=y and slub_debug=ZF (or CONFIG_SLUB_DEBUG_ON=y).
+ * CONFIG_SLUB_DEBUG=y and slab_debug=ZF (or CONFIG_SLUB_DEBUG_ON=y).
  */
 static void lkdtm_SLAB_LINEAR_OVERFLOW(void)
 {
diff --git a/mm/Kconfig.debug b/mm/Kconfig.debug
index 321ab379994f..afc72fde0f03 100644
--- a/mm/Kconfig.debug
+++ b/mm/Kconfig.debug
@@ -64,11 +64,11 @@ config SLUB_DEBUG_ON
 	help
 	  Boot with debugging on by default. SLUB boots by default with
 	  the runtime debug capabilities switched off. Enabling this is
-	  equivalent to specifying the "slub_debug" parameter on boot.
+	  equivalent to specifying the "slab_debug" parameter on boot.
 	  There is no support for more fine grained debug control like
-	  possible with slub_debug=xxx. SLUB debugging may be switched
+	  possible with slab_debug=xxx. SLUB debugging may be switched
 	  off in a kernel built with CONFIG_SLUB_DEBUG_ON by specifying
-	  "slub_debug=-".
+	  "slab_debug=-".
 
 config PAGE_OWNER
 	bool "Track page owner"
diff --git a/mm/slab.h b/mm/slab.h
index 54deeb0428c6..f7df6d701c5b 100644
--- a/mm/slab.h
+++ b/mm/slab.h
@@ -528,7 +528,7 @@ static inline bool __slub_debug_enabled(void)
 #endif
 
 /*
- * Returns true if any of the specified slub_debug flags is enabled for the
+ * Returns true if any of the specified slab_debug flags is enabled for the
  * cache. Use only for flags parsed by setup_slub_debug() as it also enables
  * the static key.
  */
diff --git a/mm/slab_common.c b/mm/slab_common.c
index 238293b1dbe1..230ef7cc3467 100644
--- a/mm/slab_common.c
+++ b/mm/slab_common.c
@@ -282,7 +282,7 @@ kmem_cache_create_usercopy(const char *name,
 
 #ifdef CONFIG_SLUB_DEBUG
 	/*
-	 * If no slub_debug was enabled globally, the static key is not yet
+	 * If no slab_debug was enabled globally, the static key is not yet
 	 * enabled by setup_slub_debug(). Enable it if the cache is being
 	 * created with any of the debugging flags passed explicitly.
 	 * It's also possible that this is the first cache created with
@@ -766,7 +766,7 @@ EXPORT_SYMBOL(kmalloc_size_roundup);
 }
 
 /*
- * kmalloc_info[] is to make slub_debug=,kmalloc-xx option work at boot time.
+ * kmalloc_info[] is to make slab_debug=,kmalloc-xx option work at boot time.
  * kmalloc_index() supports up to 2^21=2MB, so the final entry of the table is
  * kmalloc-2M.
  */
diff --git a/mm/slub.c b/mm/slub.c
index 02d5299810df..842379a17709 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -295,7 +295,7 @@ static inline bool kmem_cache_has_cpu_partial(struct kmem_cache *s)
 
 /*
  * Debugging flags that require metadata to be stored in the slab.  These get
- * disabled when slub_debug=O is used and a cache's min order increases with
+ * disabled when slab_debug=O is used and a cache's min order increases with
  * metadata.
  */
 #define DEBUG_METADATA_FLAGS (SLAB_RED_ZONE | SLAB_POISON | SLAB_STORE_USER)
@@ -1605,7 +1605,7 @@ static inline int free_consistency_checks(struct kmem_cache *s,
 }
 
 /*
- * Parse a block of slub_debug options. Blocks are delimited by ';'
+ * Parse a block of slab_debug options. Blocks are delimited by ';'
  *
  * @str:    start of block
  * @flags:  returns parsed flags, or DEBUG_DEFAULT_FLAGS if none specified
@@ -1666,7 +1666,7 @@ parse_slub_debug_flags(char *str, slab_flags_t *flags, char **slabs, bool init)
 			break;
 		default:
 			if (init)
-				pr_err("slub_debug option '%c' unknown. skipped\n", *str);
+				pr_err("slab_debug option '%c' unknown. skipped\n", *str);
 		}
 	}
 check_slabs:
@@ -1725,7 +1725,7 @@ static int __init setup_slub_debug(char *str)
 	/*
 	 * For backwards compatibility, a single list of flags with list of
 	 * slabs means debugging is only changed for those slabs, so the global
-	 * slub_debug should be unchanged (0 or DEBUG_DEFAULT_FLAGS, depending
+	 * slab_debug should be unchanged (0 or DEBUG_DEFAULT_FLAGS, depending
 	 * on CONFIG_SLUB_DEBUG_ON). We can extended that to multiple lists as
 	 * long as there is no option specifying flags without a slab list.
 	 */
@@ -1749,7 +1749,8 @@ static int __init setup_slub_debug(char *str)
 	return 1;
 }
 
-__setup("slub_debug", setup_slub_debug);
+__setup("slab_debug", setup_slub_debug);
+__setup_param("slub_debug", slub_debug, setup_slub_debug, 0);
 
 /*
  * kmem_cache_flags - apply debugging options to the cache
@@ -1759,7 +1760,7 @@ __setup("slub_debug", setup_slub_debug);
  *
  * Debug option(s) are applied to @flags. In addition to the debug
  * option(s), if a slab name (or multiple) is specified i.e.
- * slub_debug=<Debug-Options>,<slab name1>,<slab name2> ...
+ * slab_debug=<Debug-Options>,<slab name1>,<slab name2> ...
  * then only the select slabs will receive the debug option(s).
  */
 slab_flags_t kmem_cache_flags(unsigned int object_size,
@@ -3256,7 +3257,7 @@ slab_out_of_memory(struct kmem_cache *s, gfp_t gfpflags, int nid)
 		oo_order(s->min));
 
 	if (oo_order(s->min) > get_order(s->object_size))
-		pr_warn("  %s debugging increased min order, use slub_debug=O to disable.\n",
+		pr_warn("  %s debugging increased min order, use slab_debug=O to disable.\n",
 			s->name);
 
 	for_each_kmem_cache_node(s, node, n) {
@@ -3785,11 +3786,11 @@ void slab_post_alloc_hook(struct kmem_cache *s,	struct obj_cgroup *objcg,
 		zero_size = orig_size;
 
 	/*
-	 * When slub_debug is enabled, avoid memory initialization integrated
+	 * When slab_debug is enabled, avoid memory initialization integrated
 	 * into KASAN and instead zero out the memory via the memset below with
 	 * the proper size. Otherwise, KASAN might overwrite SLUB redzones and
 	 * cause false-positive reports. This does not lead to a performance
-	 * penalty on production builds, as slub_debug is not intended to be
+	 * penalty on production builds, as slab_debug is not intended to be
 	 * enabled there.
 	 */
 	if (__slub_debug_enabled())
@@ -4695,8 +4696,8 @@ static unsigned int slub_min_objects;
  * activity on the partial lists which requires taking the list_lock. This is
  * less a concern for large slabs though which are rarely used.
  *
- * slub_max_order specifies the order where we begin to stop considering the
- * number of objects in a slab as critical. If we reach slub_max_order then
+ * slab_max_order specifies the order where we begin to stop considering the
+ * number of objects in a slab as critical. If we reach slab_max_order then
  * we try to keep the page order as low as possible. So we accept more waste
  * of space in favor of a small page order.
  *
@@ -4763,14 +4764,14 @@ static inline int calculate_order(unsigned int size)
 	 * and backing off gradually.
 	 *
 	 * We start with accepting at most 1/16 waste and try to find the
-	 * smallest order from min_objects-derived/slub_min_order up to
-	 * slub_max_order that will satisfy the constraint. Note that increasing
+	 * smallest order from min_objects-derived/slab_min_order up to
+	 * slab_max_order that will satisfy the constraint. Note that increasing
 	 * the order can only result in same or less fractional waste, not more.
 	 *
 	 * If that fails, we increase the acceptable fraction of waste and try
 	 * again. The last iteration with fraction of 1/2 would effectively
 	 * accept any waste and give us the order determined by min_objects, as
-	 * long as at least single object fits within slub_max_order.
+	 * long as at least single object fits within slab_max_order.
 	 */
 	for (unsigned int fraction = 16; fraction > 1; fraction /= 2) {
 		order = calc_slab_order(size, min_order, slub_max_order,
@@ -4780,7 +4781,7 @@ static inline int calculate_order(unsigned int size)
 	}
 
 	/*
-	 * Doh this slab cannot be placed using slub_max_order.
+	 * Doh this slab cannot be placed using slab_max_order.
 	 */
 	order = get_order(size);
 	if (order <= MAX_ORDER)
@@ -5306,7 +5307,9 @@ static int __init setup_slub_min_order(char *str)
 	return 1;
 }
 
-__setup("slub_min_order=", setup_slub_min_order);
+__setup("slab_min_order=", setup_slub_min_order);
+__setup_param("slub_min_order=", slub_min_order, setup_slub_min_order, 0);
+
 
 static int __init setup_slub_max_order(char *str)
 {
@@ -5319,7 +5322,8 @@ static int __init setup_slub_max_order(char *str)
 	return 1;
 }
 
-__setup("slub_max_order=", setup_slub_max_order);
+__setup("slab_max_order=", setup_slub_max_order);
+__setup_param("slub_max_order=", slub_max_order, setup_slub_max_order, 0);
 
 static int __init setup_slub_min_objects(char *str)
 {
@@ -5328,7 +5332,8 @@ static int __init setup_slub_min_objects(char *str)
 	return 1;
 }
 
-__setup("slub_min_objects=", setup_slub_min_objects);
+__setup("slab_min_objects=", setup_slub_min_objects);
+__setup_param("slub_min_objects=", slub_min_objects, setup_slub_min_objects, 0);
 
 #ifdef CONFIG_HARDENED_USERCOPY
 /*
-- 
2.34.1


