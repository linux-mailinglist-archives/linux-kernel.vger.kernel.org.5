Return-Path: <linux-kernel+bounces-8937-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C39781BE54
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 19:36:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BBCF2287700
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 18:36:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BFEC65196;
	Thu, 21 Dec 2023 18:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Wp4SgxAx"
X-Original-To: linux-kernel@vger.kernel.org
Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 459C963505
	for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 18:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1703183748;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wLcCaNYp1HtmrZAPrigLSWnYXTa9aslZ8ruUHa0DHbo=;
	b=Wp4SgxAxzf33U9vG6eCpb57dWh/1TqzRC2qPSlMKfzo4YFjahK6jxrjxwucpfy7HNf515z
	HVTQaBE2QE4c7zE1ojOnJfPr31drq3YJKN5R0J3wvccZ6BKYlSSN5VG/UPs4jM7chLnJJ2
	iVscHV7PW/6Z659boGsoyF6DsXA5Ssw=
From: andrey.konovalov@linux.dev
To: Andrew Morton <akpm@linux-foundation.org>,
	Juntong Deng <juntong.deng@outlook.com>
Cc: Andrey Konovalov <andreyknvl@gmail.com>,
	Marco Elver <elver@google.com>,
	Alexander Potapenko <glider@google.com>,
	Dmitry Vyukov <dvyukov@google.com>,
	Andrey Ryabinin <ryabinin.a.a@gmail.com>,
	kasan-dev@googlegroups.com,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Andrey Konovalov <andreyknvl@google.com>
Subject: [PATCH mm 3/4] kasan: simplify saving extra info into tracks
Date: Thu, 21 Dec 2023 19:35:39 +0100
Message-Id: <20231221183540.168428-3-andrey.konovalov@linux.dev>
In-Reply-To: <20231221183540.168428-1-andrey.konovalov@linux.dev>
References: <20231221183540.168428-1-andrey.konovalov@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Andrey Konovalov <andreyknvl@google.com>

Avoid duplicating code for saving extra info into tracks: reuse the
common function for this.

Fixes: 5d4c6ac94694 ("kasan: record and report more information")
Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 mm/kasan/common.c  | 12 ++++++++++--
 mm/kasan/generic.c |  4 ++--
 mm/kasan/kasan.h   |  3 ++-
 mm/kasan/tags.c    | 17 +----------------
 4 files changed, 15 insertions(+), 21 deletions(-)

diff --git a/mm/kasan/common.c b/mm/kasan/common.c
index fe6c4b43ad9f..d004a0f4406c 100644
--- a/mm/kasan/common.c
+++ b/mm/kasan/common.c
@@ -48,7 +48,7 @@ depot_stack_handle_t kasan_save_stack(gfp_t flags, depot_flags_t depot_flags)
 	return stack_depot_save_flags(entries, nr_entries, flags, depot_flags);
 }
 
-void kasan_set_track(struct kasan_track *track, gfp_t flags)
+void kasan_set_track(struct kasan_track *track, depot_stack_handle_t stack)
 {
 #ifdef CONFIG_KASAN_EXTRA_INFO
 	u32 cpu = raw_smp_processor_id();
@@ -58,8 +58,16 @@ void kasan_set_track(struct kasan_track *track, gfp_t flags)
 	track->timestamp = ts_nsec >> 3;
 #endif /* CONFIG_KASAN_EXTRA_INFO */
 	track->pid = current->pid;
-	track->stack = kasan_save_stack(flags,
+	track->stack = stack;
+}
+
+void kasan_save_track(struct kasan_track *track, gfp_t flags)
+{
+	depot_stack_handle_t stack;
+
+	stack = kasan_save_stack(flags,
 			STACK_DEPOT_FLAG_CAN_ALLOC | STACK_DEPOT_FLAG_GET);
+	kasan_set_track(track, stack);
 }
 
 #if defined(CONFIG_KASAN_GENERIC) || defined(CONFIG_KASAN_SW_TAGS)
diff --git a/mm/kasan/generic.c b/mm/kasan/generic.c
index 769e43e05d0b..11b575707b05 100644
--- a/mm/kasan/generic.c
+++ b/mm/kasan/generic.c
@@ -553,7 +553,7 @@ void kasan_save_alloc_info(struct kmem_cache *cache, void *object, gfp_t flags)
 	stack_depot_put(alloc_meta->aux_stack[1]);
 	__memset(alloc_meta, 0, sizeof(*alloc_meta));
 
-	kasan_set_track(&alloc_meta->alloc_track, flags);
+	kasan_save_track(&alloc_meta->alloc_track, flags);
 }
 
 void kasan_save_free_info(struct kmem_cache *cache, void *object)
@@ -564,7 +564,7 @@ void kasan_save_free_info(struct kmem_cache *cache, void *object)
 	if (!free_meta)
 		return;
 
-	kasan_set_track(&free_meta->free_track, 0);
+	kasan_save_track(&free_meta->free_track, 0);
 	/* The object was freed and has free track set. */
 	*(u8 *)kasan_mem_to_shadow(object) = KASAN_SLAB_FREETRACK;
 }
diff --git a/mm/kasan/kasan.h b/mm/kasan/kasan.h
index 9072ce4c1263..31fb6bb26fed 100644
--- a/mm/kasan/kasan.h
+++ b/mm/kasan/kasan.h
@@ -372,7 +372,8 @@ static inline void kasan_init_object_meta(struct kmem_cache *cache, const void *
 #endif
 
 depot_stack_handle_t kasan_save_stack(gfp_t flags, depot_flags_t depot_flags);
-void kasan_set_track(struct kasan_track *track, gfp_t flags);
+void kasan_set_track(struct kasan_track *track, depot_stack_handle_t stack);
+void kasan_save_track(struct kasan_track *track, gfp_t flags);
 void kasan_save_alloc_info(struct kmem_cache *cache, void *object, gfp_t flags);
 void kasan_save_free_info(struct kmem_cache *cache, void *object);
 
diff --git a/mm/kasan/tags.c b/mm/kasan/tags.c
index c4d14dbf27c0..d65d48b85f90 100644
--- a/mm/kasan/tags.c
+++ b/mm/kasan/tags.c
@@ -94,17 +94,6 @@ void __init kasan_init_tags(void)
 	}
 }
 
-#ifdef CONFIG_KASAN_EXTRA_INFO
-static void save_extra_info(struct kasan_stack_ring_entry *entry)
-{
-	u32 cpu = raw_smp_processor_id();
-	u64 ts_nsec = local_clock();
-
-	entry->track.cpu = cpu;
-	entry->track.timestamp = ts_nsec >> 3;
-}
-#endif /* CONFIG_KASAN_EXTRA_INFO */
-
 static void save_stack_info(struct kmem_cache *cache, void *object,
 			gfp_t gfp_flags, bool is_free)
 {
@@ -137,11 +126,7 @@ static void save_stack_info(struct kmem_cache *cache, void *object,
 	old_stack = entry->track.stack;
 
 	entry->size = cache->object_size;
-	entry->track.pid = current->pid;
-	entry->track.stack = stack;
-#ifdef CONFIG_KASAN_EXTRA_INFO
-	save_extra_info(entry);
-#endif /* CONFIG_KASAN_EXTRA_INFO */
+	kasan_set_track(&entry->track, stack);
 	entry->is_free = is_free;
 
 	entry->ptr = object;
-- 
2.25.1


