Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1003B7DFDC6
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Nov 2023 02:38:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344334AbjKCBh0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 21:37:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjKCBhZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 21:37:25 -0400
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [67.231.154.164])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23616134
        for <linux-kernel@vger.kernel.org>; Thu,  2 Nov 2023 18:37:17 -0700 (PDT)
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mail3.candelatech.com (mail2.candelatech.com [208.74.158.173])
        by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id C327A8006F
        for <linux-kernel@vger.kernel.org>; Fri,  3 Nov 2023 01:37:14 +0000 (UTC)
Received: from ben-dt5.candelatech.com (50-251-239-81-static.hfc.comcastbusiness.net [50.251.239.81])
        by mail3.candelatech.com (Postfix) with ESMTP id 5D81E13C2B0;
        Thu,  2 Nov 2023 18:37:11 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 5D81E13C2B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
        s=default; t=1698975431;
        bh=hYq93e/+vsMDmp3C/vMEccOLqze47dJ0YhSLnsVwsFs=;
        h=From:To:Cc:Subject:Date:From;
        b=sZ+5+gXSeZFiRCvpBzVw26hD3BQi6tDlwSHqkH3iks7wmspjMB0R0VS43KHlAJfoU
         HtSkhj13gQjWpx63MGcqcIlKtvLeh+Ovlviwk2yWa0hsB2K+5h7A/XCBNKXdNV4/B3
         HteVPH9aKeJh39ljBeNb+lPWdaIg2H5hhmQW8LII=
From:   greearb@candelatech.com
To:     linux-kernel@vger.kernel.org
Cc:     Ben Greear <greearb@candelatech.com>
Subject: [PATCH/RFC] debugobjects/slub:  Print slab info and backtrace.
Date:   Thu,  2 Nov 2023 18:37:04 -0700
Message-ID: <20231103013704.1232723-1-greearb@candelatech.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MDID: 1698975435-5W-rvjJhNRvr
X-MDID-O: us5;at1;1698975435;5W-rvjJhNRvr;<greearb@candelatech.com>;c71d53d8b4bf163c84f4470b0e4d7294
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ben Greear <greearb@candelatech.com>

When debugobjects detects a problem, it may be in generic code
where the backtraces currently printed are not helpful.

To try to improve this, store the backtrace of where the
debug_obj was created and print that out when problems
are found.

Also print out slub info for the object held by the
debug_obj.  In my particular case, this was not super
useful, appearantly because of all of the KASAN and other
debugging I have enabled.  Still, might provide a few
clues.

Signed-off-by: Ben Greear <greearb@candelatech.com>
---
 include/linux/debugobjects.h |  5 +++++
 include/linux/slab.h         | 11 +++++++++++
 include/linux/slab_def.h     |  2 ++
 lib/debugobjects.c           | 37 ++++++++++++++++++++++++++++++++++++
 mm/slab.h                    |  4 ++--
 mm/slub.c                    | 34 +++++++++++++++++++++++++++++----
 6 files changed, 87 insertions(+), 6 deletions(-)

diff --git a/include/linux/debugobjects.h b/include/linux/debugobjects.h
index 32444686b6ff..8e8df719bd88 100644
--- a/include/linux/debugobjects.h
+++ b/include/linux/debugobjects.h
@@ -31,6 +31,11 @@ struct debug_obj {
 	unsigned int		astate;
 	void			*object;
 	const struct debug_obj_descr *descr;
+#ifdef CONFIG_STACKDEPOT
+#define DEBUG_OBJ_ADDRS_COUNT 16
+	/* Including stackdepot.h blows up the build, so open-code the handle. */
+	u64 trace_handle;
+#endif
 };
 
 /**
diff --git a/include/linux/slab.h b/include/linux/slab.h
index 8228d1276a2f..87a5da669eaf 100644
--- a/include/linux/slab.h
+++ b/include/linux/slab.h
@@ -793,4 +793,15 @@ int slab_dead_cpu(unsigned int cpu);
 #define slab_dead_cpu		NULL
 #endif
 
+
+/**
+ * Calling this on allocated memory will print debugging info
+ * about the object, if CONFIG_SLAB_DEBUG is enabled.
+ */
+#ifdef CONFIG_SLUB_DEBUG
+void slab_print_mem_info(const void *x);
+#else
+static inline void slab_print_mem_info(const void *x) { }
+#endif
+
 #endif	/* _LINUX_SLAB_H */
diff --git a/include/linux/slab_def.h b/include/linux/slab_def.h
index a61e7d55d0d3..db3ce19be339 100644
--- a/include/linux/slab_def.h
+++ b/include/linux/slab_def.h
@@ -121,4 +121,6 @@ static inline int objs_per_slab(const struct kmem_cache *cache,
 	return cache->num;
 }
 
+static inline void slab_print_mem_info(const void *x) { }
+
 #endif	/* _LINUX_SLAB_DEF_H */
diff --git a/lib/debugobjects.c b/lib/debugobjects.c
index a517256a270b..1f458e473bc5 100644
--- a/lib/debugobjects.c
+++ b/lib/debugobjects.c
@@ -17,6 +17,8 @@
 #include <linux/hash.h>
 #include <linux/kmemleak.h>
 #include <linux/cpu.h>
+#include <linux/slab.h>
+#include <linux/stackdepot.h>
 
 #define ODEBUG_HASH_BITS	14
 #define ODEBUG_HASH_SIZE	(1 << ODEBUG_HASH_BITS)
@@ -216,6 +218,33 @@ static struct debug_obj *__alloc_object(struct hlist_head *list)
 	return obj;
 }
 
+#ifdef CONFIG_STACKDEPOT
+static void debug_print_stack_info(struct debug_obj *object)
+{
+	if (object->trace_handle) {
+		pr_err("debugobjects: debug_obj allocated at:\n");
+		stack_depot_print(object->trace_handle);
+		pr_err("end of stack dump\n");
+	}
+}
+
+static noinline depot_stack_handle_t set_track_prepare(void)
+{
+	depot_stack_handle_t trace_handle;
+	unsigned long entries[DEBUG_OBJ_ADDRS_COUNT];
+	unsigned int nr_entries;
+
+	nr_entries = stack_trace_save(entries, ARRAY_SIZE(entries), 3);
+	trace_handle = stack_depot_save(entries, nr_entries, GFP_NOWAIT);
+
+	return trace_handle;
+}
+
+#else
+static void debug_print_stack_info(struct debug_obj *object) { }
+static depot_stack_handle_t set_track_prepare(void) { }
+#endif
+
 static struct debug_obj *
 alloc_object(void *addr, struct debug_bucket *b, const struct debug_obj_descr *descr)
 {
@@ -272,6 +301,12 @@ alloc_object(void *addr, struct debug_bucket *b, const struct debug_obj_descr *d
 		obj->state  = ODEBUG_STATE_NONE;
 		obj->astate = 0;
 		hlist_add_head(&obj->node, &b->list);
+
+		/* Save stack of where object was created */
+#ifdef CONFIG_STACKDEPOT
+		/* kernel backtrace */
+		obj->trace_handle = set_track_prepare();
+#endif
 	}
 	return obj;
 }
@@ -515,6 +550,8 @@ static void debug_print_object(struct debug_obj *obj, char *msg)
 				 "object: %p object type: %s hint: %pS\n",
 			msg, obj_states[obj->state], obj->astate,
 			obj->object, descr->name, hint);
+		debug_print_stack_info(obj);
+		slab_print_mem_info(obj->object);
 	}
 	debug_objects_warnings++;
 }
diff --git a/mm/slab.h b/mm/slab.h
index 799a315695c6..d977c093e90d 100644
--- a/mm/slab.h
+++ b/mm/slab.h
@@ -399,14 +399,14 @@ DECLARE_STATIC_KEY_TRUE(slub_debug_enabled);
 #else
 DECLARE_STATIC_KEY_FALSE(slub_debug_enabled);
 #endif
-extern void print_tracking(struct kmem_cache *s, void *object);
+extern void print_tracking(struct kmem_cache *s, const void *object);
 long validate_slab_cache(struct kmem_cache *s);
 static inline bool __slub_debug_enabled(void)
 {
 	return static_branch_unlikely(&slub_debug_enabled);
 }
 #else
-static inline void print_tracking(struct kmem_cache *s, void *object)
+static inline void print_tracking(struct kmem_cache *s, const void *object)
 {
 }
 static inline bool __slub_debug_enabled(void)
diff --git a/mm/slub.c b/mm/slub.c
index f7940048138c..7d0c648369ab 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -760,10 +760,10 @@ static inline unsigned int get_info_end(struct kmem_cache *s)
 		return s->inuse;
 }
 
-static struct track *get_track(struct kmem_cache *s, void *object,
+static struct track *get_track(struct kmem_cache *s, const void *object,
 	enum track_item alloc)
 {
-	struct track *p;
+	const struct track *p;
 
 	p = object + get_info_end(s);
 
@@ -841,11 +841,14 @@ static void print_track(const char *s, struct track *t, unsigned long pr_time)
 #endif
 }
 
-void print_tracking(struct kmem_cache *s, void *object)
+void print_tracking(struct kmem_cache *s, const void *object)
 {
 	unsigned long pr_time = jiffies;
-	if (!(s->flags & SLAB_STORE_USER))
+	if (!(s->flags & SLAB_STORE_USER)) {
+		pr_err("slub-print-tracking, STORE-USER not enabled, cache: %s flags: 0x%x\n",
+		       s->name, s->flags);
 		return;
+	}
 
 	print_track("Allocated", get_track(s, object, TRACK_ALLOC), pr_time);
 	print_track("Freed", get_track(s, object, TRACK_FREE), pr_time);
@@ -1712,6 +1715,29 @@ slab_flags_t kmem_cache_flags(unsigned int object_size,
 
 	return flags | slub_debug_local;
 }
+
+void slab_print_mem_info(const void *x)
+{
+	struct slab *slab;
+
+	if (unlikely(ZERO_OR_NULL_PTR(x)))
+		return;
+
+	slab = virt_to_slab(x);
+	if (!slab) {
+		pr_err("slub-print-mem-info, could not find slab for virt addr: %p\n",
+		       x);
+		return;
+	}
+
+	pr_err("slab-info, slab: %p\n", slab);
+	print_slab_info(slab);
+	pr_err("slab-tracking-info: cache: %s (%p)\n",
+	       slab->slab_cache->name, slab->slab_cache);
+	print_tracking(slab->slab_cache, x);
+	pr_err("end of slab-tracking-info\n");
+}
+
 #else /* !CONFIG_SLUB_DEBUG */
 static inline void setup_object_debug(struct kmem_cache *s, void *object) {}
 static inline
-- 
2.41.0

