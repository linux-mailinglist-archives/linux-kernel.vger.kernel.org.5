Return-Path: <linux-kernel+bounces-39369-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0622E83CF81
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 23:37:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2B2FD1C228F3
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 22:37:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56FE510A3F;
	Thu, 25 Jan 2024 22:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dnku7Q3+"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E99F134A6
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 22:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706222177; cv=none; b=A9vwYmv2FBgmxwLldB/vp2VvrBNaYpD8XCseHeiyw1CE3WLsRIDfgybM7Jp4kj6j8ULuA02ike+UfUHUZhAEbttIDTmUwLGFPHI/cebCes3jb5x4iF1pFkYdgYHEXWPCritZyUxJHR1VoIut3zqd58+UVhzv261oL+IEQy8OIXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706222177; c=relaxed/simple;
	bh=WexNKD33hx3pa4jDuxsY4Pkt7zVWgu7BzrZzXi5qivQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=u5xreIRIaltFJLigaqMsXcocjCWOj58makPBDLWIy72WkzVAwz2HohuRJ+vFEzVidm5Jz6l9bhv3Pt5yQiDmtTEclKV7czE87vtWhaPoe9QBOwPIgsdlciueAeYRWvoBNePNBg3JzPMpcsQXHT/yDheXG4nG04amMozQ/yyKi3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Dnku7Q3+; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-40ed218ed1eso11067085e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 14:36:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706222173; x=1706826973; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=abiH/PhhRDGXkyL1IB+beHQOnSwz7Jg04l0sv5fMRUk=;
        b=Dnku7Q3+1tAnoUuTW/9ko6mPEBsSv+ycxilYNZmPNnytv7jJ5JrDTQTrOexVno5qWC
         QZEth0+xUxTH1RixwtffdqIM+s/s6WCGpmBdN05jdqJui2eu0G8jfAneAWj+4tBcWdeY
         8Uba+zexd5LJisafA1qpWzWXotwp5OxcKT87BdTYjGFr43iQvBdw5qB6cLgcQU3JznQM
         ShUnPNSIPN8q+w8RBonsPwHj5mwwiHRCpY1qFyNTZ6rVX8p8jDf7lQakr3RF9Klp/UzW
         o/oncI3g8OD0dAAGajAmyCP5cdp13Q1xxM7QbLrqxTFits9npmVBzzAUl0t1+NDDsfv/
         gOLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706222173; x=1706826973;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=abiH/PhhRDGXkyL1IB+beHQOnSwz7Jg04l0sv5fMRUk=;
        b=QkXkkTT8VruZtn8rIZ/Sc2aZ6IMSLBC4O1f8hAN1mIXqcXa2J7usZdES0cxuPksHNR
         b58hFv9L/wLVZ21WG8ujWrPnv2A0zkjI+p7zDb+aa9Qxd8hkNAWHdsUZ1DZ9UteI+onW
         m6QgNk/eEN3LI9dBnZGMTPoP93uh4DjGZAZeJ1K+OBJ/KMTDO3e4xvpuRLvESRn3UYIy
         N3SQFmbzNawEMqs4lsNFsVBEOW2z6JspdfXdSYRru7fCY2re6acbca3w+8yESwvw3pFV
         HehzYw5sps6M3cE97Rf3Fe0DeCbiEfAO9AkgULwppYszWPCcNxWzICmuhYJub3hAU8Bb
         z/Tw==
X-Gm-Message-State: AOJu0Yz6fh+4JjYFvrz81Kj6IHA70uoAxYm8ryBAkIYhySMGX99yytEE
	jLmP/PhfJWtUootKw3mz3QBMMqq0GmmGEqyuLdn/MW+ErA1EEUonxshVXogzjLUj09sEpGxT5r5
	Pssh6B0K6nLX8bc6OQ+bkbtJh+Ac=
X-Google-Smtp-Source: AGHT+IFa+Iin8gQ7TonNMFfz+ijkfFJZFx6vaYfznOHKeOAlCjnCkuFepmMP6ml3Fguv76JEt8aigeo6j0mFkqHIfZM=
X-Received: by 2002:a5d:66c7:0:b0:33a:eb3:d8e9 with SMTP id
 k7-20020a5d66c7000000b0033a0eb3d8e9mr297880wrw.83.1706222173438; Thu, 25 Jan
 2024 14:36:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240125094815.2041933-1-elver@google.com> <20240125094815.2041933-2-elver@google.com>
In-Reply-To: <20240125094815.2041933-2-elver@google.com>
From: Andrey Konovalov <andreyknvl@gmail.com>
Date: Thu, 25 Jan 2024 23:36:02 +0100
Message-ID: <CA+fCnZc6L3t3AdQS1rjFCT0s6RpT+q4Z4GmctOveeaDJW0tBow@mail.gmail.com>
Subject: Re: [PATCH 2/2] kasan: revert eviction of stack traces in generic mode
To: Marco Elver <elver@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Alexander Potapenko <glider@google.com>, 
	Dmitry Vyukov <dvyukov@google.com>, Vlastimil Babka <vbabka@suse.cz>, 
	Andrey Ryabinin <ryabinin.a.a@gmail.com>, Vincenzo Frascino <vincenzo.frascino@arm.com>, 
	linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 25, 2024 at 10:48=E2=80=AFAM Marco Elver <elver@google.com> wro=
te:
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
> observe a reduction of 282 stack depot pools (saving 4512 KiB) with my
> test setup.
>
> Fixes: cc478e0b6bdf ("kasan: avoid resetting aux_lock")
> Fixes: 63b85ac56a64 ("kasan: stop leaking stack trace handles")
> Fixes: 08d7c94d9635 ("kasan: memset free track in qlink_free")
> Fixes: a414d4286f34 ("kasan: handle concurrent kasan_record_aux_stack cal=
ls")
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
> @@ -65,8 +65,7 @@ void kasan_save_track(struct kasan_track *track, gfp_t =
flags)
>  {
>         depot_stack_handle_t stack;
>
> -       stack =3D kasan_save_stack(flags,
> -                       STACK_DEPOT_FLAG_CAN_ALLOC | STACK_DEPOT_FLAG_GET=
);
> +       stack =3D kasan_save_stack(flags, STACK_DEPOT_FLAG_CAN_ALLOC);
>         kasan_set_track(track, stack);
>  }
>
> diff --git a/mm/kasan/generic.c b/mm/kasan/generic.c
> index df6627f62402..8bfb52b28c22 100644
> --- a/mm/kasan/generic.c
> +++ b/mm/kasan/generic.c
> @@ -485,16 +485,6 @@ void kasan_init_object_meta(struct kmem_cache *cache=
, const void *object)
>         if (alloc_meta) {
>                 /* Zero out alloc meta to mark it as invalid. */
>                 __memset(alloc_meta, 0, sizeof(*alloc_meta));
> -
> -               /*
> -                * Prepare the lock for saving auxiliary stack traces.
> -                * Temporarily disable KASAN bug reporting to allow instr=
umented
> -                * raw_spin_lock_init to access aux_lock, which resides i=
nside
> -                * of a redzone.
> -                */
> -               kasan_disable_current();
> -               raw_spin_lock_init(&alloc_meta->aux_lock);
> -               kasan_enable_current();
>         }
>
>         /*
> @@ -506,18 +496,8 @@ void kasan_init_object_meta(struct kmem_cache *cache=
, const void *object)
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
> -        * initialized to avoid having to reinitialize it when another ob=
ject
> -        * is allocated in the same slot.
> -        */
> -       __memset(&meta->alloc_track, 0, sizeof(meta->alloc_track));
> -       __memset(meta->aux_stack, 0, sizeof(meta->aux_stack));
> +       /* Zero out alloc meta to mark it as invalid. */
> +       __memset(meta, 0, sizeof(*meta));
>  }
>
>  static void release_free_meta(const void *object, struct kasan_free_meta=
 *meta)
> @@ -526,9 +506,6 @@ static void release_free_meta(const void *object, str=
uct kasan_free_meta *meta)
>         if (*(u8 *)kasan_mem_to_shadow(object) !=3D KASAN_SLAB_FREE_META)
>                 return;
>
> -       /* Evict the stack trace from the stack depot. */
> -       stack_depot_put(meta->free_track.stack);
> -
>         /* Mark free meta as invalid. */
>         *(u8 *)kasan_mem_to_shadow(object) =3D KASAN_SLAB_FREE;
>  }
> @@ -571,8 +548,6 @@ static void __kasan_record_aux_stack(void *addr, depo=
t_flags_t depot_flags)
>         struct kmem_cache *cache;
>         struct kasan_alloc_meta *alloc_meta;
>         void *object;
> -       depot_stack_handle_t new_handle, old_handle;
> -       unsigned long flags;
>
>         if (is_kfence_address(addr) || !slab)
>                 return;
> @@ -583,33 +558,18 @@ static void __kasan_record_aux_stack(void *addr, de=
pot_flags_t depot_flags)
>         if (!alloc_meta)
>                 return;
>
> -       new_handle =3D kasan_save_stack(0, depot_flags);
> -
> -       /*
> -        * Temporarily disable KASAN bug reporting to allow instrumented
> -        * spinlock functions to access aux_lock, which resides inside of=
 a
> -        * redzone.
> -        */
> -       kasan_disable_current();
> -       raw_spin_lock_irqsave(&alloc_meta->aux_lock, flags);
> -       old_handle =3D alloc_meta->aux_stack[1];
>         alloc_meta->aux_stack[1] =3D alloc_meta->aux_stack[0];
> -       alloc_meta->aux_stack[0] =3D new_handle;
> -       raw_spin_unlock_irqrestore(&alloc_meta->aux_lock, flags);
> -       kasan_enable_current();
> -
> -       stack_depot_put(old_handle);
> +       alloc_meta->aux_stack[0] =3D kasan_save_stack(0, depot_flags);
>  }
>
>  void kasan_record_aux_stack(void *addr)
>  {
> -       return __kasan_record_aux_stack(addr,
> -                       STACK_DEPOT_FLAG_CAN_ALLOC | STACK_DEPOT_FLAG_GET=
);
> +       return __kasan_record_aux_stack(addr, STACK_DEPOT_FLAG_CAN_ALLOC)=
;
>  }
>
>  void kasan_record_aux_stack_noalloc(void *addr)
>  {
> -       return __kasan_record_aux_stack(addr, STACK_DEPOT_FLAG_GET);
> +       return __kasan_record_aux_stack(addr, 0);
>  }
>
>  void kasan_save_alloc_info(struct kmem_cache *cache, void *object, gfp_t=
 flags)
> @@ -620,7 +580,7 @@ void kasan_save_alloc_info(struct kmem_cache *cache, =
void *object, gfp_t flags)
>         if (!alloc_meta)
>                 return;
>
> -       /* Evict previous stack traces (might exist for krealloc or mempo=
ol). */
> +       /* Invalidate previous stack traces (might exist for krealloc or =
mempool). */
>         release_alloc_meta(alloc_meta);
>
>         kasan_save_track(&alloc_meta->alloc_track, flags);
> @@ -634,7 +594,7 @@ void kasan_save_free_info(struct kmem_cache *cache, v=
oid *object)
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
> -        * kasan_record_aux_stack calls. It is a raw spinlock to avoid sl=
eeping
> -        * on RT kernels, as kasan_record_aux_stack_noalloc can be called=
 from
> -        * non-sleepable contexts.
> -        */
> -       raw_spinlock_t aux_lock;
>         depot_stack_handle_t aux_stack[2];
>  };
>
> --
> 2.43.0.429.g432eaa2c6b-goog
>

Reviewed-by: Andrey Konovalov <andreyknvl@gmail.com>

But I'm wondering if we should also stop resetting metadata when the
object is fully freed (from quarantine or bypassing quarantine).

With stack_depot_put, I had to put the stack handles on free, as
otherwise we would leak the stack depot references. And I also chose
to memset meta at that point, as its gets invalid anyway. But without
stack_depot_put, this is not required.

Before the stack depot-related changes, the code was inconsistent in
this regard AFAICS: for quarantine, free meta was marked as invalid
via KASAN_SLAB_FREE but alloc meta was kept; for no quarantine, both
alloc and free meta were kept.

So perhaps we can just keep both metas on full free. I.e. drop both
kasan_release_object_meta calls. This will go back to the old behavior
+ keeping free meta for the quarantine case (I think there's no harm
in that). This will give better reporting for uaf-before-realloc bugs.

WDYT?

