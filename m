Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A8E58001F8
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 04:16:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377081AbjLADQA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 22:16:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230098AbjLADP6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 22:15:58 -0500
Received: from pv50p00im-ztdg10012101.me.com (pv50p00im-ztdg10012101.me.com [17.58.6.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90C75171B
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 19:16:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=me.com; s=1a1hai;
        t=1701400563; bh=upp3f1b2uYPe5zjNm3g55BP6GkibG6wweQbsbezgvNQ=;
        h=From:To:Subject:Date:Message-Id:MIME-Version;
        b=Jgc3w9y7dmv0nMqzq0D/vFa6G0vU7e2faTX58VdD7X2QmVwWAzX50N5+9MMsVv4LB
         KtNjeYCg1eTpjs98PXaxJMqd/apUBPgoiE/3xNZZ9t3chwyJrQzaLVELvG+lrnXt5k
         PRmGu1h8UAzwIqPueCTmAsVplLBwKrNwPx6Nu17plLihnFNXD5lB5nyCozJLa9c1bP
         bOlxFwuqAmggjjFVjQv1x/i6ndCPnWmI8dnx/DMUJPB/VXaFiX27p51VB9clHGT5Lh
         7pkWf5LyYSrfQo/I5U0wnnd+wvoCt3xf60YpTtANGo0dICKBgje2usK0gYCVyyXWBT
         DB7hHOyKzMLQw==
Received: from xiongwei.. (pv50p00im-dlb-asmtp-mailmevip.me.com [17.56.9.10])
        by pv50p00im-ztdg10012101.me.com (Postfix) with ESMTPSA id 4B251740137;
        Fri,  1 Dec 2023 03:15:56 +0000 (UTC)
From:   sxwjean@me.com
To:     vbabka@suse.cz, 42.hyeyoo@gmail.com, cl@linux.com,
        linux-mm@kvack.org
Cc:     penberg@kernel.org, rientjes@google.com, iamjoonsoo.kim@lge.com,
        roman.gushchin@linux.dev, corbet@lwn.net, keescook@chromium.org,
        arnd@arndb.de, akpm@linux-foundation.org,
        gregkh@linuxfoundation.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Xiongwei Song <xiongwei.song@windriver.com>
Subject: [RFC PATCH 2/3] mm/slub: unify all sl[au]b parameters with "slab_$param"
Date:   Fri,  1 Dec 2023 11:15:04 +0800
Message-Id: <20231201031505.286117-3-sxwjean@me.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231201031505.286117-1-sxwjean@me.com>
References: <20231201031505.286117-1-sxwjean@me.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: buFJpuDYznbo62q3rfaCAvT4_c2kIyhB
X-Proofpoint-GUID: buFJpuDYznbo62q3rfaCAvT4_c2kIyhB
X-Proofpoint-Virus-Version: =?UTF-8?Q?vendor=3Dfsecure_engine=3D1.1.170-22c6f66c430a71ce266a39bfe25bc?=
 =?UTF-8?Q?2903e8d5c8f:6.0.517,18.0.572,17.11.64.514.0000000_definitions?=
 =?UTF-8?Q?=3D2022-06-21=5F01:2022-06-21=5F01,2020-02-14=5F11,2022-02-23?=
 =?UTF-8?Q?=5F01_signatures=3D0?=
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0
 clxscore=1015 mlxscore=0 phishscore=0 suspectscore=0 malwarescore=0
 adultscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2312010018
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xiongwei Song <xiongwei.song@windriver.com>

Since the SLAB allocator has been removed, so we need to clean up the
sl[au]b_$params. However, the "slab/SLAB" terms should be keep for
long-term rather than "slub/SLUB". Hence, we should use "slab_$param"
as the primary prefix, which is pointed out by Vlastimil Babka. For more
information please see [1].

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
as the primary slab parameters in
Documentation/admin-guide/kernel-parameters.txt and source, and rename all
setup functions of them too. Meanwhile, "slub_$params" can also be passed
by command line, which is to keep backward compatibility. Also mark all
"slub_$params" as legacy.

The function
    static int __init setup_slub_debug(char *str);
, which is to setup debug flags inside a slab during kernel init, is
changed to setup_slab_debug_flags(), which is to prevent the name
conflict. Because there is another function
    void setup_slab_debug(struct kmem_cache *s, struct slab *slab,
    		void *addr);
, which is to poison slab space, would have name confilct with the prior
one.

For parameter "slub_debug", beside replacing it with "slab_debug", there
are several global variables, local variables and functions which are
related with the parameter, let's rename them all.

Remove the separate descriptons for slub_[no]merge, append legacy tip
for them at the end of descriptions of slab_[no]merge.

I didn't change the parameters in Documentation/mm/slub.rst because the
file name is still "slub.rst", and slub_$params still can be used in
kernel command line to keep backward compatibility.

[1] https://lore.kernel.org/linux-mm/7512b350-4317-21a0-fab3-4101bc4d8f7a@suse.cz/

Signed-off-by: Xiongwei Song <xiongwei.song@windriver.com>
---
 .../admin-guide/kernel-parameters.txt         |  44 +++---
 drivers/misc/lkdtm/heap.c                     |   2 +-
 mm/Kconfig.debug                              |   6 +-
 mm/slab.h                                     |  16 +-
 mm/slab_common.c                              |   8 +-
 mm/slub.c                                     | 142 +++++++++---------
 6 files changed, 109 insertions(+), 109 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 9f94baeb2f82..d01c12e2a247 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -5869,6 +5869,8 @@
 	slab_merge	[MM]
 			Enable merging of slabs with similar size when the
 			kernel is built without CONFIG_SLAB_MERGE_DEFAULT.
+			(slub_merge is accepted too, but it's supported for
+			legacy)
 
 	slab_nomerge	[MM]
 			Disable merging of slabs with similar size. May be
@@ -5882,47 +5884,41 @@
 			unchanged). Debug options disable merging on their
 			own.
 			For more information see Documentation/mm/slub.rst.
+			(slub_nomerge is accepted too, but it's supported for
+			legacy)
 
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
-			Documentation/mm/slub.rst.
+			Documentation/mm/slub.rst. (slub_debug is accepted
+			too, but it's supported for legacy)
 
-	slub_max_order= [MM, SLUB]
+	slab_max_order= [MM]
 			Determines the maximum allowed order for slabs.
 			A high setting may cause OOMs due to memory
 			fragmentation. For more information see
-			Documentation/mm/slub.rst.
+			Documentation/mm/slub.rst. (slub_max_order is
+			accepted too, but it's supported for legacy)
 
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
+			(slub_min_objects is accepted too, but it's supported
+			for legacy)
 
-	slub_min_order=	[MM, SLUB]
+	slab_min_order=	[MM]
 			Determines the minimum page order for slabs. Must be
-			lower than slub_max_order.
-			For more information see Documentation/mm/slub.rst.
-
-	slub_merge	[MM, SLUB]
-			Same with slab_merge.
-
-	slub_nomerge	[MM, SLUB]
-			Same with slab_nomerge. This is supported for legacy.
-			See slab_nomerge for more information.
+			lower than slab_max_order. For more information see
+			Documentation/mm/slub.rst. (slub_min_order is accepted
+			too, but it's supported for legacy)
 
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
index 54deeb0428c6..c78b3d24be2c 100644
--- a/mm/slab.h
+++ b/mm/slab.h
@@ -507,36 +507,36 @@ ssize_t slabinfo_write(struct file *file, const char __user *buffer,
 
 #ifdef CONFIG_SLUB_DEBUG
 #ifdef CONFIG_SLUB_DEBUG_ON
-DECLARE_STATIC_KEY_TRUE(slub_debug_enabled);
+DECLARE_STATIC_KEY_TRUE(slab_debug_enabled);
 #else
-DECLARE_STATIC_KEY_FALSE(slub_debug_enabled);
+DECLARE_STATIC_KEY_FALSE(slab_debug_enabled);
 #endif
 extern void print_tracking(struct kmem_cache *s, void *object);
 long validate_slab_cache(struct kmem_cache *s);
-static inline bool __slub_debug_enabled(void)
+static inline bool __slab_debug_enabled(void)
 {
-	return static_branch_unlikely(&slub_debug_enabled);
+	return static_branch_unlikely(&slab_debug_enabled);
 }
 #else
 static inline void print_tracking(struct kmem_cache *s, void *object)
 {
 }
-static inline bool __slub_debug_enabled(void)
+static inline bool __slab_debug_enabled(void)
 {
 	return false;
 }
 #endif
 
 /*
- * Returns true if any of the specified slub_debug flags is enabled for the
- * cache. Use only for flags parsed by setup_slub_debug() as it also enables
+ * Returns true if any of the specified slab_debug flags is enabled for the
+ * cache. Use only for flags parsed by setup_slab_debug() as it also enables
  * the static key.
  */
 static inline bool kmem_cache_debug_flags(struct kmem_cache *s, slab_flags_t flags)
 {
 	if (IS_ENABLED(CONFIG_SLUB_DEBUG))
 		VM_WARN_ON_ONCE(!(flags & SLAB_DEBUG_FLAGS));
-	if (__slub_debug_enabled())
+	if (__slab_debug_enabled())
 		return s->flags & flags;
 	return false;
 }
diff --git a/mm/slab_common.c b/mm/slab_common.c
index 238293b1dbe1..d7360a50633c 100644
--- a/mm/slab_common.c
+++ b/mm/slab_common.c
@@ -282,14 +282,14 @@ kmem_cache_create_usercopy(const char *name,
 
 #ifdef CONFIG_SLUB_DEBUG
 	/*
-	 * If no slub_debug was enabled globally, the static key is not yet
-	 * enabled by setup_slub_debug(). Enable it if the cache is being
+	 * If no slab_debug was enabled globally, the static key is not yet
+	 * enabled by setup_slab_debug(). Enable it if the cache is being
 	 * created with any of the debugging flags passed explicitly.
 	 * It's also possible that this is the first cache created with
 	 * SLAB_STORE_USER and we should init stack_depot for it.
 	 */
 	if (flags & SLAB_DEBUG_FLAGS)
-		static_branch_enable(&slub_debug_enabled);
+		static_branch_enable(&slab_debug_enabled);
 	if (flags & SLAB_STORE_USER)
 		stack_depot_init();
 #endif
@@ -766,7 +766,7 @@ EXPORT_SYMBOL(kmalloc_size_roundup);
 }
 
 /*
- * kmalloc_info[] is to make slub_debug=,kmalloc-xx option work at boot time.
+ * kmalloc_info[] is to make slab_debug=,kmalloc-xx option work at boot time.
  * kmalloc_index() supports up to 2^21=2MB, so the final entry of the table is
  * kmalloc-2M.
  */
diff --git a/mm/slub.c b/mm/slub.c
index 3f8b95757106..f67108ed2653 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -197,9 +197,9 @@ do {					\
 
 #ifdef CONFIG_SLUB_DEBUG
 #ifdef CONFIG_SLUB_DEBUG_ON
-DEFINE_STATIC_KEY_TRUE(slub_debug_enabled);
+DEFINE_STATIC_KEY_TRUE(slab_debug_enabled);
 #else
-DEFINE_STATIC_KEY_FALSE(slub_debug_enabled);
+DEFINE_STATIC_KEY_FALSE(slab_debug_enabled);
 #endif
 #endif		/* CONFIG_SLUB_DEBUG */
 
@@ -280,7 +280,7 @@ static inline bool kmem_cache_has_cpu_partial(struct kmem_cache *s)
 
 /*
  * Debugging flags that require metadata to be stored in the slab.  These get
- * disabled when slub_debug=O is used and a cache's min order increases with
+ * disabled when slab_debug=O is used and a cache's min order increases with
  * metadata.
  */
 #define DEBUG_METADATA_FLAGS (SLAB_RED_ZONE | SLAB_POISON | SLAB_STORE_USER)
@@ -765,12 +765,12 @@ static inline void *restore_red_left(struct kmem_cache *s, void *p)
  * Debug settings:
  */
 #if defined(CONFIG_SLUB_DEBUG_ON)
-static slab_flags_t slub_debug = DEBUG_DEFAULT_FLAGS;
+static slab_flags_t slab_debug = DEBUG_DEFAULT_FLAGS;
 #else
-static slab_flags_t slub_debug;
+static slab_flags_t slab_debug;
 #endif
 
-static char *slub_debug_string;
+static char *slab_debug_string;
 static int disable_higher_order_debug;
 
 /*
@@ -1582,7 +1582,7 @@ static inline int free_consistency_checks(struct kmem_cache *s,
 }
 
 /*
- * Parse a block of slub_debug options. Blocks are delimited by ';'
+ * Parse a block of slab_debug options. Blocks are delimited by ';'
  *
  * @str:    start of block
  * @flags:  returns parsed flags, or DEBUG_DEFAULT_FLAGS if none specified
@@ -1592,7 +1592,7 @@ static inline int free_consistency_checks(struct kmem_cache *s,
  * returns the start of next block if there's any, or NULL
  */
 static char *
-parse_slub_debug_flags(char *str, slab_flags_t *flags, char **slabs, bool init)
+parse_slab_debug_flags(char *str, slab_flags_t *flags, char **slabs, bool init)
 {
 	bool higher_order_disable = false;
 
@@ -1643,7 +1643,7 @@ parse_slub_debug_flags(char *str, slab_flags_t *flags, char **slabs, bool init)
 			break;
 		default:
 			if (init)
-				pr_err("slub_debug option '%c' unknown. skipped\n", *str);
+				pr_err("slab_debug option '%c' unknown. skipped\n", *str);
 		}
 	}
 check_slabs:
@@ -1669,13 +1669,13 @@ parse_slub_debug_flags(char *str, slab_flags_t *flags, char **slabs, bool init)
 		return NULL;
 }
 
-static int __init setup_slub_debug(char *str)
+static int __init setup_slab_debug_flags(char *str)
 {
 	slab_flags_t flags;
 	slab_flags_t global_flags;
 	char *saved_str;
 	char *slab_list;
-	bool global_slub_debug_changed = false;
+	bool global_slab_debug_changed = false;
 	bool slab_list_specified = false;
 
 	global_flags = DEBUG_DEFAULT_FLAGS;
@@ -1687,11 +1687,11 @@ static int __init setup_slub_debug(char *str)
 
 	saved_str = str;
 	while (str) {
-		str = parse_slub_debug_flags(str, &flags, &slab_list, true);
+		str = parse_slab_debug_flags(str, &flags, &slab_list, true);
 
 		if (!slab_list) {
 			global_flags = flags;
-			global_slub_debug_changed = true;
+			global_slab_debug_changed = true;
 		} else {
 			slab_list_specified = true;
 			if (flags & SLAB_STORE_USER)
@@ -1702,31 +1702,32 @@ static int __init setup_slub_debug(char *str)
 	/*
 	 * For backwards compatibility, a single list of flags with list of
 	 * slabs means debugging is only changed for those slabs, so the global
-	 * slub_debug should be unchanged (0 or DEBUG_DEFAULT_FLAGS, depending
+	 * slab_debug should be unchanged (0 or DEBUG_DEFAULT_FLAGS, depending
 	 * on CONFIG_SLUB_DEBUG_ON). We can extended that to multiple lists as
 	 * long as there is no option specifying flags without a slab list.
 	 */
 	if (slab_list_specified) {
-		if (!global_slub_debug_changed)
-			global_flags = slub_debug;
-		slub_debug_string = saved_str;
+		if (!global_slab_debug_changed)
+			global_flags = slab_debug;
+		slab_debug_string = saved_str;
 	}
 out:
-	slub_debug = global_flags;
-	if (slub_debug & SLAB_STORE_USER)
+	slab_debug = global_flags;
+	if (slab_debug & SLAB_STORE_USER)
 		stack_depot_request_early_init();
-	if (slub_debug != 0 || slub_debug_string)
-		static_branch_enable(&slub_debug_enabled);
+	if (slab_debug != 0 || slab_debug_string)
+		static_branch_enable(&slab_debug_enabled);
 	else
-		static_branch_disable(&slub_debug_enabled);
+		static_branch_disable(&slab_debug_enabled);
 	if ((static_branch_unlikely(&init_on_alloc) ||
 	     static_branch_unlikely(&init_on_free)) &&
-	    (slub_debug & SLAB_POISON))
+	    (slab_debug & SLAB_POISON))
 		pr_info("mem auto-init: SLAB_POISON will take precedence over init_on_alloc/init_on_free\n");
 	return 1;
 }
 
-__setup("slub_debug", setup_slub_debug);
+__setup("slab_debug", setup_slab_debug_flags);
+__setup_param("slub_debug", slub_debug, setup_slab_debug_flags, 0);
 
 /*
  * kmem_cache_flags - apply debugging options to the cache
@@ -1736,7 +1737,7 @@ __setup("slub_debug", setup_slub_debug);
  *
  * Debug option(s) are applied to @flags. In addition to the debug
  * option(s), if a slab name (or multiple) is specified i.e.
- * slub_debug=<Debug-Options>,<slab name1>,<slab name2> ...
+ * slab_debug=<Debug-Options>,<slab name1>,<slab name2> ...
  * then only the select slabs will receive the debug option(s).
  */
 slab_flags_t kmem_cache_flags(unsigned int object_size,
@@ -1746,7 +1747,7 @@ slab_flags_t kmem_cache_flags(unsigned int object_size,
 	size_t len;
 	char *next_block;
 	slab_flags_t block_flags;
-	slab_flags_t slub_debug_local = slub_debug;
+	slab_flags_t slab_debug_local = slab_debug;
 
 	if (flags & SLAB_NO_USER_FLAGS)
 		return flags;
@@ -1757,13 +1758,13 @@ slab_flags_t kmem_cache_flags(unsigned int object_size,
 	 * but let the user enable it via the command line below.
 	 */
 	if (flags & SLAB_NOLEAKTRACE)
-		slub_debug_local &= ~SLAB_STORE_USER;
+		slab_debug_local &= ~SLAB_STORE_USER;
 
 	len = strlen(name);
-	next_block = slub_debug_string;
+	next_block = slab_debug_string;
 	/* Go through all blocks of debug options, see if any matches our slab's name */
 	while (next_block) {
-		next_block = parse_slub_debug_flags(next_block, &block_flags, &iter, false);
+		next_block = parse_slab_debug_flags(next_block, &block_flags, &iter, false);
 		if (!iter)
 			continue;
 		/* Found a block that has a slab list, search it */
@@ -1792,12 +1793,12 @@ slab_flags_t kmem_cache_flags(unsigned int object_size,
 		}
 	}
 
-	return flags | slub_debug_local;
+	return flags | slab_debug_local;
 }
 #else /* !CONFIG_SLUB_DEBUG */
 static inline void setup_object_debug(struct kmem_cache *s, void *object) {}
-static inline
-void setup_slab_debug(struct kmem_cache *s, struct slab *slab, void *addr) {}
+static inline void setup_slab_debug(struct kmem_cache *s,
+	struct slab *slab, void *addr) {}
 
 static inline bool alloc_debug_processing(struct kmem_cache *s,
 	struct slab *slab, void *object, int orig_size) { return true; }
@@ -1821,7 +1822,7 @@ slab_flags_t kmem_cache_flags(unsigned int object_size,
 {
 	return flags;
 }
-#define slub_debug 0
+#define slab_debug 0
 
 #define disable_higher_order_debug 0
 
@@ -3285,7 +3286,7 @@ slab_out_of_memory(struct kmem_cache *s, gfp_t gfpflags, int nid)
 		oo_order(s->min));
 
 	if (oo_order(s->min) > get_order(s->object_size))
-		pr_warn("  %s debugging increased min order, use slub_debug=O to disable.\n",
+		pr_warn("  %s debugging increased min order, use slab_debug=O to disable.\n",
 			s->name);
 
 	for_each_kmem_cache_node(s, node, n) {
@@ -3778,14 +3779,14 @@ void slab_post_alloc_hook(struct kmem_cache *s,	struct obj_cgroup *objcg,
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
-	if (__slub_debug_enabled())
+	if (__slab_debug_enabled())
 		kasan_init = false;
 
 	/*
@@ -4638,10 +4639,10 @@ EXPORT_SYMBOL(kmem_cache_alloc_bulk);
  * and increases the number of allocations possible without having to
  * take the list_lock.
  */
-static unsigned int slub_min_order;
-static unsigned int slub_max_order =
+static unsigned int slab_min_order;
+static unsigned int slab_max_order =
 	IS_ENABLED(CONFIG_SLUB_TINY) ? 1 : PAGE_ALLOC_COSTLY_ORDER;
-static unsigned int slub_min_objects;
+static unsigned int slab_min_objects;
 
 /*
  * Calculate the order of allocation given an slab object size.
@@ -4658,8 +4659,8 @@ static unsigned int slub_min_objects;
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
@@ -4695,7 +4696,7 @@ static inline int calculate_order(unsigned int size)
 	unsigned int max_objects;
 	unsigned int min_order;
 
-	min_objects = slub_min_objects;
+	min_objects = slab_min_objects;
 	if (!min_objects) {
 		/*
 		 * Some architectures will only update present cpus when
@@ -4712,10 +4713,10 @@ static inline int calculate_order(unsigned int size)
 		min_objects = 4 * (fls(nr_cpus) + 1);
 	}
 	/* min_objects can't be 0 because get_order(0) is undefined */
-	max_objects = max(order_objects(slub_max_order, size), 1U);
+	max_objects = max(order_objects(slab_max_order, size), 1U);
 	min_objects = min(min_objects, max_objects);
 
-	min_order = max_t(unsigned int, slub_min_order,
+	min_order = max_t(unsigned int, slab_min_order,
 			  get_order(min_objects * size));
 	if (order_objects(min_order, size) > MAX_OBJS_PER_PAGE)
 		return get_order(size * MAX_OBJS_PER_PAGE) - 1;
@@ -4726,24 +4727,24 @@ static inline int calculate_order(unsigned int size)
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
-		order = calc_slab_order(size, min_order, slub_max_order,
+		order = calc_slab_order(size, min_order, slab_max_order,
 					fraction);
-		if (order <= slub_max_order)
+		if (order <= slab_max_order)
 			return order;
 	}
 
 	/*
-	 * Doh this slab cannot be placed using slub_max_order.
+	 * Doh this slab cannot be placed using slab_max_order.
 	 */
 	order = get_order(size);
 	if (order <= MAX_ORDER)
@@ -5259,39 +5260,42 @@ void __kmem_obj_info(struct kmem_obj_info *kpp, void *object, struct slab *slab)
  *		Kmalloc subsystem
  *******************************************************************/
 
-static int __init setup_slub_min_order(char *str)
+static int __init setup_slab_min_order(char *str)
 {
-	get_option(&str, (int *)&slub_min_order);
+	get_option(&str, (int *)&slab_min_order);
 
-	if (slub_min_order > slub_max_order)
-		slub_max_order = slub_min_order;
+	if (slab_min_order > slab_max_order)
+		slab_max_order = slab_min_order;
 
 	return 1;
 }
 
-__setup("slub_min_order=", setup_slub_min_order);
+__setup("slab_min_order=", setup_slab_min_order);
+__setup_param("slub_min_order=", slub_min_order, setup_slab_min_order, 0);
 
-static int __init setup_slub_max_order(char *str)
+static int __init setup_slab_max_order(char *str)
 {
-	get_option(&str, (int *)&slub_max_order);
-	slub_max_order = min_t(unsigned int, slub_max_order, MAX_ORDER);
+	get_option(&str, (int *)&slab_max_order);
+	slab_max_order = min_t(unsigned int, slab_max_order, MAX_ORDER);
 
-	if (slub_min_order > slub_max_order)
-		slub_min_order = slub_max_order;
+	if (slab_min_order > slab_max_order)
+		slab_min_order = slab_max_order;
 
 	return 1;
 }
 
-__setup("slub_max_order=", setup_slub_max_order);
+__setup("slab_max_order=", setup_slab_max_order);
+__setup_param("slub_max_order=", slub_max_order, setup_slab_max_order, 0);
 
-static int __init setup_slub_min_objects(char *str)
+static int __init setup_slab_min_objects(char *str)
 {
-	get_option(&str, (int *)&slub_min_objects);
+	get_option(&str, (int *)&slab_min_objects);
 
 	return 1;
 }
 
-__setup("slub_min_objects=", setup_slub_min_objects);
+__setup("slab_min_objects=", setup_slab_min_objects);
+__setup_param("slub_min_objects=", slub_min_objects, setup_slab_min_objects, 0);
 
 #ifdef CONFIG_HARDENED_USERCOPY
 /*
@@ -5584,10 +5588,10 @@ void __init kmem_cache_init(void)
 	int node;
 
 	if (debug_guardpage_minorder())
-		slub_max_order = 0;
+		slab_max_order = 0;
 
 	/* Print slub debugging pointers without hashing */
-	if (__slub_debug_enabled())
+	if (__slab_debug_enabled())
 		no_hash_pointers_enable(NULL);
 
 	kmem_cache_node = &boot_kmem_cache_node;
@@ -5628,7 +5632,7 @@ void __init kmem_cache_init(void)
 
 	pr_info("SLUB: HWalign=%d, Order=%u-%u, MinObjects=%u, CPUs=%u, Nodes=%u\n",
 		cache_line_size(),
-		slub_min_order, slub_max_order, slub_min_objects,
+		slab_min_order, slab_max_order, slab_min_objects,
 		nr_cpu_ids, nr_node_ids);
 }
 
@@ -6702,7 +6706,7 @@ static int sysfs_slab_add(struct kmem_cache *s)
 	int unmergeable = slab_unmergeable(s);
 
 	if (!unmergeable && disable_higher_order_debug &&
-			(slub_debug & DEBUG_METADATA_FLAGS))
+			(slab_debug & DEBUG_METADATA_FLAGS))
 		unmergeable = 1;
 
 	if (unmergeable) {
-- 
2.34.1

