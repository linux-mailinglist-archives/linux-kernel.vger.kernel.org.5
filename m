Return-Path: <linux-kernel+bounces-35604-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 600058393E3
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 16:56:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 84F251C23624
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 15:56:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4334060ECC;
	Tue, 23 Jan 2024 15:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XPFVMk8u"
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 599EB60DF9
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 15:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706025371; cv=none; b=gOAW5PdSt5XreiysrdlrsJaEHPcA1jcTavqyRDRvz/heF/m5JpqsNsBO4iKOSmrvMegBP9qZpsZ5lDmHvE2yb1drXt/lcEbFdBFStM0SnGCHuO9f1hWQdMYGu5PoFeg2xyblj68kk6LjBO/oXzQDUAtM5dqT7OxhuK6GIwqDcqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706025371; c=relaxed/simple;
	bh=5CfcWw/r+gLO0GSTpJ86WRXjYekj43jcIrHUeThvUVk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Cyq3NNgk9MpOQpPEEGyQ4uaZpGINCJLXuMsgDqICtIhy/I0Xf4HxwHHrxnUCFnY2IZiAQRm5JcVRbL1yTtzOJxDl/U0m3N4j/R51U4KOz0RxYBcB6VL5fNMqOx9b45YDNMEtNwuBDas6k3hkbAlf9loqQkoCAqQK7z+acxC0cUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XPFVMk8u; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-50e70d8273fso2800e87.0
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 07:56:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706025367; x=1706630167; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=EBv30KMy0zvXmwC7oxK4cZSZ9HSjQvy5SlIH3Zj4wIY=;
        b=XPFVMk8u59Y61d9/SI45ew5cPQEyjsNPpOBzDQMmnb8g7o/a8TVNbhfCK1nbPA9Euv
         MZ9qj2bCjOWBb6vNVc3KVHqfko/h0IAKcTcm7nCewbxKrwcq1tdwc1tRr60T7AaLIVpM
         YLK0wNteUsYPrkzwzb8ikrRmAHSyAAkQ0N/Lki0jovkohzYmf9wL69q0DoqC4Qyp/uT6
         Fnq3BsKK18sZmxF4G6caxSlbGKRPmTDmfN59gdfOLbVfxvTFLONPCGnz5lF1fWQtDmzI
         zKRql8HGz3Qhf2bJwrfRlzvh04EGeMlfyen72RBQrEpAD6jcFVtlr/yzQFBemL58Azfk
         jZhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706025367; x=1706630167;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EBv30KMy0zvXmwC7oxK4cZSZ9HSjQvy5SlIH3Zj4wIY=;
        b=bt6qTtN4WHnMAwV6U8WbwyzYFtXFIiaJSbl1bvU+QXrLD/5aOqACPJCtc39Pafkttx
         BiHKPdEELkOcPesp6VyKRllg9uY0eRSoJr20TEfg15QhBqthN6DbeOouNiEQurn6C9vi
         lQjjDQ2rmfKU2UHJ7ELa/JY9dly1mFfRpxbNssuBgzghIva2Qnl3GiWEjECfV6nBBabl
         +Y6BenM6OOM6OWOfBmbyxV4BCe3PkSI0TycHGgN5q8C6q1aATjwwIsA0mng3RisJV2+Y
         AJt8NXGMeRR7I8varzVPX+jRI74ziWEuarZl4Dt9l90/IEl4WD/rtwbrjlA6ELK9j0hZ
         i0yw==
X-Gm-Message-State: AOJu0YxS/jYeVh8yxqoPyy8FOvmMmIvdEZW1VHfD41/5ja6HabaolV4f
	bRPyOg4p9LJG7VijBeDnY2y13NkTiHRaOzS3Aqy/xdM3/ZEcZs2aTRiKsjI17OlZrbz6YWtr2yt
	qDwb1PUVv5WeDOhr/NGWzqVwth8sQk3vbVcJi
X-Google-Smtp-Source: AGHT+IGX7ORTrUQQYto8V+zR0lNs54Y7uli6s5LaFoyrmcVGLPjD8aENG1Gjzi2/hwj9N+EQj1O9ExjUZAXgyclAJFg=
X-Received: by 2002:ac2:4d85:0:b0:50e:7be0:3ac1 with SMTP id
 g5-20020ac24d85000000b0050e7be03ac1mr149756lfe.6.1706025367012; Tue, 23 Jan
 2024 07:56:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240122171215.319440-2-elver@google.com> <Za_g6QkbGoAcXBNH@elver.google.com>
In-Reply-To: <Za_g6QkbGoAcXBNH@elver.google.com>
From: Dmitry Vyukov <dvyukov@google.com>
Date: Tue, 23 Jan 2024 16:55:54 +0100
Message-ID: <CACT4Y+ZcWsArFZs5E8actLz1q2L4-juptLAcVPp2BcjkdscCtQ@mail.gmail.com>
Subject: Re: [RFC PATCH] stackdepot: use variable size records for
 non-evictable entries
To: Marco Elver <elver@google.com>
Cc: Andrey Konovalov <andreyknvl@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Alexander Potapenko <glider@google.com>, Vlastimil Babka <vbabka@suse.cz>, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, kasan-dev@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

On Tue, 23 Jan 2024 at 16:53, Marco Elver <elver@google.com> wrote:
>
> And on top of this we can make KASAN generic happier again:
>
> Objections?

Not doing refcounting/aux locking for generic KASAN makes sense to me.

> ------ >8 ------
>
> From: Marco Elver <elver@google.com>
> Date: Tue, 23 Jan 2024 12:11:36 +0100
> Subject: [PATCH RFC] kasan: revert eviction of stack traces in generic mode
>
> This partially reverts commits cc478e0b6bdf, 63b85ac56a64, 08d7c94d9635,
> a414d4286f34, and 773688a6cb24 to make use of variable-sized stack depot
> records, since eviction of stack entries from stack depot forces fixed-
> sized stack records. Care was taken to retain the code cleanups by the
> above commits.
>
> Eviction was added to generic KASAN as a response to alleviating the
> additional memory usage from fixed-sized stack records, but this still
> uses more memory than previously.
>
> With the re-introduction of variable-sized records for stack depot, we
> can just switch back to non-evictable stack records again, and return
> back to the previous performance and memory usage baseline.
>
> Before (observed after a KASAN kernel boot):
>
>   pools: 597
>   allocations: 29657
>   frees: 6425
>   in_use: 23232
>   freelist_size: 3493
>
> After:
>
>   pools: 315
>   allocations: 28964
>   frees: 0
>   in_use: 28964
>   freelist_size: 0
>
> As can be seen from the number of "frees", with a generic KASAN config,
> evictions are no longer used but due to using variable-sized records, I
> observe a reduction of 282 stack depot pools (saving 4512 KiB).
>
> Fixes: cc478e0b6bdf ("kasan: avoid resetting aux_lock")
> Fixes: 63b85ac56a64 ("kasan: stop leaking stack trace handles")
> Fixes: 08d7c94d9635 ("kasan: memset free track in qlink_free")
> Fixes: a414d4286f34 ("kasan: handle concurrent kasan_record_aux_stack calls")
> Fixes: 773688a6cb24 ("kasan: use stack_depot_put for Generic mode")
> Signed-off-by: Marco Elver <elver@google.com>
> Cc: Alexander Potapenko <glider@google.com>
> Cc: Andrey Konovalov <andreyknvl@gmail.com>
> Cc: Dmitry Vyukov <dvyukov@google.com>
> ---
>  mm/kasan/common.c  |  3 +--
>  mm/kasan/generic.c | 54 ++++++----------------------------------------
>  mm/kasan/kasan.h   |  8 -------
>  3 files changed, 8 insertions(+), 57 deletions(-)
>
> diff --git a/mm/kasan/common.c b/mm/kasan/common.c
> index 610efae91220..ad32803e34e9 100644
> --- a/mm/kasan/common.c
> +++ b/mm/kasan/common.c
> @@ -65,8 +65,7 @@ void kasan_save_track(struct kasan_track *track, gfp_t flags)
>  {
>         depot_stack_handle_t stack;
>
> -       stack = kasan_save_stack(flags,
> -                       STACK_DEPOT_FLAG_CAN_ALLOC | STACK_DEPOT_FLAG_GET);
> +       stack = kasan_save_stack(flags, STACK_DEPOT_FLAG_CAN_ALLOC);
>         kasan_set_track(track, stack);
>  }
>
> diff --git a/mm/kasan/generic.c b/mm/kasan/generic.c
> index df6627f62402..8bfb52b28c22 100644
> --- a/mm/kasan/generic.c
> +++ b/mm/kasan/generic.c
> @@ -485,16 +485,6 @@ void kasan_init_object_meta(struct kmem_cache *cache, const void *object)
>         if (alloc_meta) {
>                 /* Zero out alloc meta to mark it as invalid. */
>                 __memset(alloc_meta, 0, sizeof(*alloc_meta));
> -
> -               /*
> -                * Prepare the lock for saving auxiliary stack traces.
> -                * Temporarily disable KASAN bug reporting to allow instrumented
> -                * raw_spin_lock_init to access aux_lock, which resides inside
> -                * of a redzone.
> -                */
> -               kasan_disable_current();
> -               raw_spin_lock_init(&alloc_meta->aux_lock);
> -               kasan_enable_current();
>         }
>
>         /*
> @@ -506,18 +496,8 @@ void kasan_init_object_meta(struct kmem_cache *cache, const void *object)
>
>  static void release_alloc_meta(struct kasan_alloc_meta *meta)
>  {
> -       /* Evict the stack traces from stack depot. */
> -       stack_depot_put(meta->alloc_track.stack);
> -       stack_depot_put(meta->aux_stack[0]);
> -       stack_depot_put(meta->aux_stack[1]);
> -
> -       /*
> -        * Zero out alloc meta to mark it as invalid but keep aux_lock
> -        * initialized to avoid having to reinitialize it when another object
> -        * is allocated in the same slot.
> -        */
> -       __memset(&meta->alloc_track, 0, sizeof(meta->alloc_track));
> -       __memset(meta->aux_stack, 0, sizeof(meta->aux_stack));
> +       /* Zero out alloc meta to mark it as invalid. */
> +       __memset(meta, 0, sizeof(*meta));
>  }
>
>  static void release_free_meta(const void *object, struct kasan_free_meta *meta)
> @@ -526,9 +506,6 @@ static void release_free_meta(const void *object, struct kasan_free_meta *meta)
>         if (*(u8 *)kasan_mem_to_shadow(object) != KASAN_SLAB_FREE_META)
>                 return;
>
> -       /* Evict the stack trace from the stack depot. */
> -       stack_depot_put(meta->free_track.stack);
> -
>         /* Mark free meta as invalid. */
>         *(u8 *)kasan_mem_to_shadow(object) = KASAN_SLAB_FREE;
>  }
> @@ -571,8 +548,6 @@ static void __kasan_record_aux_stack(void *addr, depot_flags_t depot_flags)
>         struct kmem_cache *cache;
>         struct kasan_alloc_meta *alloc_meta;
>         void *object;
> -       depot_stack_handle_t new_handle, old_handle;
> -       unsigned long flags;
>
>         if (is_kfence_address(addr) || !slab)
>                 return;
> @@ -583,33 +558,18 @@ static void __kasan_record_aux_stack(void *addr, depot_flags_t depot_flags)
>         if (!alloc_meta)
>                 return;
>
> -       new_handle = kasan_save_stack(0, depot_flags);
> -
> -       /*
> -        * Temporarily disable KASAN bug reporting to allow instrumented
> -        * spinlock functions to access aux_lock, which resides inside of a
> -        * redzone.
> -        */
> -       kasan_disable_current();
> -       raw_spin_lock_irqsave(&alloc_meta->aux_lock, flags);
> -       old_handle = alloc_meta->aux_stack[1];
>         alloc_meta->aux_stack[1] = alloc_meta->aux_stack[0];
> -       alloc_meta->aux_stack[0] = new_handle;
> -       raw_spin_unlock_irqrestore(&alloc_meta->aux_lock, flags);
> -       kasan_enable_current();
> -
> -       stack_depot_put(old_handle);
> +       alloc_meta->aux_stack[0] = kasan_save_stack(0, depot_flags);
>  }
>
>  void kasan_record_aux_stack(void *addr)
>  {
> -       return __kasan_record_aux_stack(addr,
> -                       STACK_DEPOT_FLAG_CAN_ALLOC | STACK_DEPOT_FLAG_GET);
> +       return __kasan_record_aux_stack(addr, STACK_DEPOT_FLAG_CAN_ALLOC);
>  }
>
>  void kasan_record_aux_stack_noalloc(void *addr)
>  {
> -       return __kasan_record_aux_stack(addr, STACK_DEPOT_FLAG_GET);
> +       return __kasan_record_aux_stack(addr, 0);
>  }
>
>  void kasan_save_alloc_info(struct kmem_cache *cache, void *object, gfp_t flags)
> @@ -620,7 +580,7 @@ void kasan_save_alloc_info(struct kmem_cache *cache, void *object, gfp_t flags)
>         if (!alloc_meta)
>                 return;
>
> -       /* Evict previous stack traces (might exist for krealloc or mempool). */
> +       /* Invalidate previous stack traces (might exist for krealloc or mempool). */
>         release_alloc_meta(alloc_meta);
>
>         kasan_save_track(&alloc_meta->alloc_track, flags);
> @@ -634,7 +594,7 @@ void kasan_save_free_info(struct kmem_cache *cache, void *object)
>         if (!free_meta)
>                 return;
>
> -       /* Evict previous stack trace (might exist for mempool). */
> +       /* Invalidate previous stack trace (might exist for mempool). */
>         release_free_meta(object, free_meta);
>
>         kasan_save_track(&free_meta->free_track, 0);
> diff --git a/mm/kasan/kasan.h b/mm/kasan/kasan.h
> index d0f172f2b978..216ae0ef1e4b 100644
> --- a/mm/kasan/kasan.h
> +++ b/mm/kasan/kasan.h
> @@ -6,7 +6,6 @@
>  #include <linux/kasan.h>
>  #include <linux/kasan-tags.h>
>  #include <linux/kfence.h>
> -#include <linux/spinlock.h>
>  #include <linux/stackdepot.h>
>
>  #if defined(CONFIG_KASAN_SW_TAGS) || defined(CONFIG_KASAN_HW_TAGS)
> @@ -265,13 +264,6 @@ struct kasan_global {
>  struct kasan_alloc_meta {
>         struct kasan_track alloc_track;
>         /* Free track is stored in kasan_free_meta. */
> -       /*
> -        * aux_lock protects aux_stack from accesses from concurrent
> -        * kasan_record_aux_stack calls. It is a raw spinlock to avoid sleeping
> -        * on RT kernels, as kasan_record_aux_stack_noalloc can be called from
> -        * non-sleepable contexts.
> -        */
> -       raw_spinlock_t aux_lock;
>         depot_stack_handle_t aux_stack[2];
>  };
>
> --
> 2.43.0.429.g432eaa2c6b-goog
>

