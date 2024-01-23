Return-Path: <linux-kernel+bounces-35597-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DB388393D2
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 16:54:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D29E28F7F0
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 15:54:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FBC96027E;
	Tue, 23 Jan 2024 15:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="W4bOotKa"
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45D5760279
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 15:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706025203; cv=none; b=UiVKDgscRI9f9XQWYjnedTaQpx7eq9fjO8ReUg/3Y87bgRATyU9AXd5QEMlg7BcYDLwPXToCNPKiXDjiHkbkSUdQWn67eYkHOTaS70aOxE39o6MaH9ZZcz0vHEQ5B7unfo2e/t8CsGZcQX+DY50OeZjKPMOnts1BbKF3JxaZ/Ro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706025203; c=relaxed/simple;
	bh=A6IFKy63B7wqRsRPymLAAdL0vwfpCGQ7uTgJzV24RXs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KoEoTIrCo6nq8U7c2esvuqrAUGh0n0eleXJuhzmiiYQAAhZqqQmF7oINKCnfpD4Ex1Q4ep8t4KgjBYb5ktaUl/jIgBjIAUrTRin0EP1XPSRU2hHQbjBcj8lPJud/rIMAP/ntBk7y3DztGDmPnoFZJgLsNTOseAzhTb/KEUom028=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=W4bOotKa; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-338aca547d9so3586031f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 07:53:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706025199; x=1706629999; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wN1zYbmyQqMAelG24I+F79Wy9Nx29GGurhOHrEZCBhQ=;
        b=W4bOotKacBQqhhPN1JgUhPlx0YjUM4FkZQx7PI6BwDzTgREBSgy3xj4LFkrzTfvyob
         ftjnHAtp+eDghH5f1YWMHJM87j6W/p05hjPRZGqu/LnXsqm1cZcgif9JIY218m5YGeIF
         ZsxNo70vksP7ZI8Na9uOxt8v99xD8wxjvpUQDqNpWVHt1FHoffOtAKqOTvByunYPohH1
         uWaxuO+CP91TigwxW8U08BDwQ5GoCq1C1ln6JJeO99A+1SyVeMFuQvoo1MNPFx+fXRzQ
         AxddX4OPWboK2G395o5WSTlnnTf3A3DlYQX9p/KNKSzTkqtSIBR4BT5MImsmTNDKgSzN
         nSmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706025199; x=1706629999;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wN1zYbmyQqMAelG24I+F79Wy9Nx29GGurhOHrEZCBhQ=;
        b=uQ9b4U04vmFj/8NmHO0hcGQKQtFd3YA2nWPPgc4Jk7v138B4OUDjZ8P02YDNmcO0Iq
         vq9AhtFjxnl9/7rbHwnFgm6ESVBqLiwkwtUd7+ulMAGtwSv6jEEh0iNunPy/lhoCm00J
         ZMXV3qCRjx9EtXeDWBGSGqiYC+zQnQhWUjS/q/46mRJ/pXZOrCDHTvj/ExpznAeZZ2ac
         v6QZt0D4l4YxtPwDx/Rl6dqbu6p7qcEPNAc3xMU52qNUSLIn4vEeCtEpeX1vhGlRtLYE
         E8OXo3Pttx/DehClWv5RPV/xl9s5pUbTalEB58XHAPBDNn6KZyfY+1ZYRVlZFVfxxThu
         fWMQ==
X-Gm-Message-State: AOJu0YzYUCv/BwlJn46gyY6CCg4OubzWS1xadWD8aAy/rUCauTjAe33Y
	fm6MNYoPLcm+G8Avl0/Rs7rmlfE+sq+pLx6WwDGcaaEPbVnjX6nLPWfz6W9s7g==
X-Google-Smtp-Source: AGHT+IHiMnUjdhR55qpE61cdcG9uCPMMHHLfkzGTGVTJW44PH+W1KF3mAeezHklxMdSsPZqN/669fw==
X-Received: by 2002:a5d:58f4:0:b0:337:d860:b260 with SMTP id f20-20020a5d58f4000000b00337d860b260mr1500203wrd.177.1706025199197;
        Tue, 23 Jan 2024 07:53:19 -0800 (PST)
Received: from elver.google.com ([2a00:79e0:9c:201:3ba0:aeb0:d827:1aee])
        by smtp.gmail.com with ESMTPSA id df10-20020a5d5b8a000000b0033947d7651asm1391689wrb.5.2024.01.23.07.53.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jan 2024 07:53:18 -0800 (PST)
Date: Tue, 23 Jan 2024 16:53:13 +0100
From: Marco Elver <elver@google.com>
To: Andrey Konovalov <andreyknvl@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Alexander Potapenko <glider@google.com>,
	Dmitry Vyukov <dvyukov@google.com>,
	Vlastimil Babka <vbabka@suse.cz>, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, kasan-dev@googlegroups.com
Subject: Re: [RFC PATCH] stackdepot: use variable size records for
 non-evictable entries
Message-ID: <Za_g6QkbGoAcXBNH@elver.google.com>
References: <20240122171215.319440-2-elver@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240122171215.319440-2-elver@google.com>
User-Agent: Mutt/2.2.12 (2023-09-09)

And on top of this we can make KASAN generic happier again:

Objections?

------ >8 ------

From: Marco Elver <elver@google.com>
Date: Tue, 23 Jan 2024 12:11:36 +0100
Subject: [PATCH RFC] kasan: revert eviction of stack traces in generic mode

This partially reverts commits cc478e0b6bdf, 63b85ac56a64, 08d7c94d9635,
a414d4286f34, and 773688a6cb24 to make use of variable-sized stack depot
records, since eviction of stack entries from stack depot forces fixed-
sized stack records. Care was taken to retain the code cleanups by the
above commits.

Eviction was added to generic KASAN as a response to alleviating the
additional memory usage from fixed-sized stack records, but this still
uses more memory than previously.

With the re-introduction of variable-sized records for stack depot, we
can just switch back to non-evictable stack records again, and return
back to the previous performance and memory usage baseline.

Before (observed after a KASAN kernel boot):

  pools: 597
  allocations: 29657
  frees: 6425
  in_use: 23232
  freelist_size: 3493

After:

  pools: 315
  allocations: 28964
  frees: 0
  in_use: 28964
  freelist_size: 0

As can be seen from the number of "frees", with a generic KASAN config,
evictions are no longer used but due to using variable-sized records, I
observe a reduction of 282 stack depot pools (saving 4512 KiB).

Fixes: cc478e0b6bdf ("kasan: avoid resetting aux_lock")
Fixes: 63b85ac56a64 ("kasan: stop leaking stack trace handles")
Fixes: 08d7c94d9635 ("kasan: memset free track in qlink_free")
Fixes: a414d4286f34 ("kasan: handle concurrent kasan_record_aux_stack calls")
Fixes: 773688a6cb24 ("kasan: use stack_depot_put for Generic mode")
Signed-off-by: Marco Elver <elver@google.com>
Cc: Alexander Potapenko <glider@google.com>
Cc: Andrey Konovalov <andreyknvl@gmail.com>
Cc: Dmitry Vyukov <dvyukov@google.com>
---
 mm/kasan/common.c  |  3 +--
 mm/kasan/generic.c | 54 ++++++----------------------------------------
 mm/kasan/kasan.h   |  8 -------
 3 files changed, 8 insertions(+), 57 deletions(-)

diff --git a/mm/kasan/common.c b/mm/kasan/common.c
index 610efae91220..ad32803e34e9 100644
--- a/mm/kasan/common.c
+++ b/mm/kasan/common.c
@@ -65,8 +65,7 @@ void kasan_save_track(struct kasan_track *track, gfp_t flags)
 {
 	depot_stack_handle_t stack;
 
-	stack = kasan_save_stack(flags,
-			STACK_DEPOT_FLAG_CAN_ALLOC | STACK_DEPOT_FLAG_GET);
+	stack = kasan_save_stack(flags, STACK_DEPOT_FLAG_CAN_ALLOC);
 	kasan_set_track(track, stack);
 }
 
diff --git a/mm/kasan/generic.c b/mm/kasan/generic.c
index df6627f62402..8bfb52b28c22 100644
--- a/mm/kasan/generic.c
+++ b/mm/kasan/generic.c
@@ -485,16 +485,6 @@ void kasan_init_object_meta(struct kmem_cache *cache, const void *object)
 	if (alloc_meta) {
 		/* Zero out alloc meta to mark it as invalid. */
 		__memset(alloc_meta, 0, sizeof(*alloc_meta));
-
-		/*
-		 * Prepare the lock for saving auxiliary stack traces.
-		 * Temporarily disable KASAN bug reporting to allow instrumented
-		 * raw_spin_lock_init to access aux_lock, which resides inside
-		 * of a redzone.
-		 */
-		kasan_disable_current();
-		raw_spin_lock_init(&alloc_meta->aux_lock);
-		kasan_enable_current();
 	}
 
 	/*
@@ -506,18 +496,8 @@ void kasan_init_object_meta(struct kmem_cache *cache, const void *object)
 
 static void release_alloc_meta(struct kasan_alloc_meta *meta)
 {
-	/* Evict the stack traces from stack depot. */
-	stack_depot_put(meta->alloc_track.stack);
-	stack_depot_put(meta->aux_stack[0]);
-	stack_depot_put(meta->aux_stack[1]);
-
-	/*
-	 * Zero out alloc meta to mark it as invalid but keep aux_lock
-	 * initialized to avoid having to reinitialize it when another object
-	 * is allocated in the same slot.
-	 */
-	__memset(&meta->alloc_track, 0, sizeof(meta->alloc_track));
-	__memset(meta->aux_stack, 0, sizeof(meta->aux_stack));
+	/* Zero out alloc meta to mark it as invalid. */
+	__memset(meta, 0, sizeof(*meta));
 }
 
 static void release_free_meta(const void *object, struct kasan_free_meta *meta)
@@ -526,9 +506,6 @@ static void release_free_meta(const void *object, struct kasan_free_meta *meta)
 	if (*(u8 *)kasan_mem_to_shadow(object) != KASAN_SLAB_FREE_META)
 		return;
 
-	/* Evict the stack trace from the stack depot. */
-	stack_depot_put(meta->free_track.stack);
-
 	/* Mark free meta as invalid. */
 	*(u8 *)kasan_mem_to_shadow(object) = KASAN_SLAB_FREE;
 }
@@ -571,8 +548,6 @@ static void __kasan_record_aux_stack(void *addr, depot_flags_t depot_flags)
 	struct kmem_cache *cache;
 	struct kasan_alloc_meta *alloc_meta;
 	void *object;
-	depot_stack_handle_t new_handle, old_handle;
-	unsigned long flags;
 
 	if (is_kfence_address(addr) || !slab)
 		return;
@@ -583,33 +558,18 @@ static void __kasan_record_aux_stack(void *addr, depot_flags_t depot_flags)
 	if (!alloc_meta)
 		return;
 
-	new_handle = kasan_save_stack(0, depot_flags);
-
-	/*
-	 * Temporarily disable KASAN bug reporting to allow instrumented
-	 * spinlock functions to access aux_lock, which resides inside of a
-	 * redzone.
-	 */
-	kasan_disable_current();
-	raw_spin_lock_irqsave(&alloc_meta->aux_lock, flags);
-	old_handle = alloc_meta->aux_stack[1];
 	alloc_meta->aux_stack[1] = alloc_meta->aux_stack[0];
-	alloc_meta->aux_stack[0] = new_handle;
-	raw_spin_unlock_irqrestore(&alloc_meta->aux_lock, flags);
-	kasan_enable_current();
-
-	stack_depot_put(old_handle);
+	alloc_meta->aux_stack[0] = kasan_save_stack(0, depot_flags);
 }
 
 void kasan_record_aux_stack(void *addr)
 {
-	return __kasan_record_aux_stack(addr,
-			STACK_DEPOT_FLAG_CAN_ALLOC | STACK_DEPOT_FLAG_GET);
+	return __kasan_record_aux_stack(addr, STACK_DEPOT_FLAG_CAN_ALLOC);
 }
 
 void kasan_record_aux_stack_noalloc(void *addr)
 {
-	return __kasan_record_aux_stack(addr, STACK_DEPOT_FLAG_GET);
+	return __kasan_record_aux_stack(addr, 0);
 }
 
 void kasan_save_alloc_info(struct kmem_cache *cache, void *object, gfp_t flags)
@@ -620,7 +580,7 @@ void kasan_save_alloc_info(struct kmem_cache *cache, void *object, gfp_t flags)
 	if (!alloc_meta)
 		return;
 
-	/* Evict previous stack traces (might exist for krealloc or mempool). */
+	/* Invalidate previous stack traces (might exist for krealloc or mempool). */
 	release_alloc_meta(alloc_meta);
 
 	kasan_save_track(&alloc_meta->alloc_track, flags);
@@ -634,7 +594,7 @@ void kasan_save_free_info(struct kmem_cache *cache, void *object)
 	if (!free_meta)
 		return;
 
-	/* Evict previous stack trace (might exist for mempool). */
+	/* Invalidate previous stack trace (might exist for mempool). */
 	release_free_meta(object, free_meta);
 
 	kasan_save_track(&free_meta->free_track, 0);
diff --git a/mm/kasan/kasan.h b/mm/kasan/kasan.h
index d0f172f2b978..216ae0ef1e4b 100644
--- a/mm/kasan/kasan.h
+++ b/mm/kasan/kasan.h
@@ -6,7 +6,6 @@
 #include <linux/kasan.h>
 #include <linux/kasan-tags.h>
 #include <linux/kfence.h>
-#include <linux/spinlock.h>
 #include <linux/stackdepot.h>
 
 #if defined(CONFIG_KASAN_SW_TAGS) || defined(CONFIG_KASAN_HW_TAGS)
@@ -265,13 +264,6 @@ struct kasan_global {
 struct kasan_alloc_meta {
 	struct kasan_track alloc_track;
 	/* Free track is stored in kasan_free_meta. */
-	/*
-	 * aux_lock protects aux_stack from accesses from concurrent
-	 * kasan_record_aux_stack calls. It is a raw spinlock to avoid sleeping
-	 * on RT kernels, as kasan_record_aux_stack_noalloc can be called from
-	 * non-sleepable contexts.
-	 */
-	raw_spinlock_t aux_lock;
 	depot_stack_handle_t aux_stack[2];
 };
 
-- 
2.43.0.429.g432eaa2c6b-goog


