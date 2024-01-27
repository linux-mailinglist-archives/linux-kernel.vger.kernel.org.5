Return-Path: <linux-kernel+bounces-40972-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E836483E925
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 02:53:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9F73428C6D1
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 01:53:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD384B65C;
	Sat, 27 Jan 2024 01:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OfyC2O4r"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4944B8F6D
	for <linux-kernel@vger.kernel.org>; Sat, 27 Jan 2024 01:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706320418; cv=none; b=U26qYFQwYvwwR1OjMBD1FjCVTQw24Y2Tj+H+HrxoFk4VPe6HKNHaW9h7N5KN1fOP/9rcI5YJPJI5ssCqrDyEXsfscX3URMTzhxYjfJ2N/pDAsyJnlN0UZe58FFqIEunNOfT9YRF8LWQIEM2cs8gU+fUTghhR8FkcRBPibcEZrCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706320418; c=relaxed/simple;
	bh=H866OhvWh/DpOwHra28Cs5wo5wE97XWdObX3PTDcNTQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MYk26x3lSsu8RHFa/qX9RYNQjzRfuqxBz1gbY2dGfP4JoFQiNNzLGYRkbLXKrbgIP878jVZWyv2U1VjBIz4mngQHaCro07Iep3hp7zHmvO/RAbPEWWTtKy9kaFfkB56GI94LhngGyO+DdhReaBFGhaAMf0+Cd+yDQrjdISOlJaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OfyC2O4r; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-40e8fec0968so17774185e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 17:53:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706320414; x=1706925214; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WXrbWEt/1qQdJy8DYI2a1Mv/37w6xBSoBjlES19/LuY=;
        b=OfyC2O4rr4jiWd3zCHhbh8/29sxRMVXh0MpDifSYCxUGUzAgbW0Fq+AAdasLbWyLfH
         2uHU6lxhE14SBQNkxS2Z00mIeykX/ywuDCNFRGW1HkLZ7PsgsKiax6aMch/13a8SbBBC
         RF45lcDWzXCR7qLWD3NomUmL2QwIJu3JgmxZGOm4Ds8O4I8Lo1HK/vBj6Z8NWCintEqP
         J9SjXm7P9yMSrKg+uIgD9o9tO6EwjIiWqKnUq4O1b2PprxS3wA/if6BwO5B6WBchgY3q
         TJDmXZaQjyIIRtv7v9CKMLFWrjp27R3jzHYTaJbl+HLjqcMG0lEyGjrfvMhxAwI7Psyx
         UYdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706320414; x=1706925214;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WXrbWEt/1qQdJy8DYI2a1Mv/37w6xBSoBjlES19/LuY=;
        b=rgypvfiaO+DjCpq8Z3+MgMQHfwAav4/4DF5m66jN2/Ip+yrHoA5P7Izb+aYMCfARe+
         tSlru9VX8xOAgbsr6xWzbIfDIYncXuPh7xDFNnXik/is8btr7V/HUxN/Vf2TZDyqzaug
         7tKXQjdxRW/BCpUkgMKKq0klxk8sk0I7LKUmIjhKdiidbvXLXll7J18vMQlOU/Rd65qM
         TmwEnYXFFO2RuBsHCMUjWrXC6dF1u2mGkG+8FDUlw773XdKNs97bs15+Abbknp3qDJVQ
         ynfG5EUu9LSKy3XG0bVXgytBJ/NCSPYTuD/KRmlHKi7OychAFPvmRVsR+iA8+ikBWdSi
         5RUg==
X-Gm-Message-State: AOJu0YwV1ccOXDfqJYhkZSvQ5/JWv+0iLVvtw20QL1Lkd7uqQzbNs1EA
	AyJ7kD9WsSf/fQmruZiB38JSnDYT/kLHkYckGEfN8LeZV0sXPe5CHAYgyWEWylZ4KbEU4ewiQ4K
	9ZPubMrRLVh9imGRG6EYKel5bTRY=
X-Google-Smtp-Source: AGHT+IFIaRsewSFaU5O34oAPpEWxPXr10elT1/kf7v442sw5K56ZXlfin0AAl4T0yDZGZxTbrRZKh67LZJ46L4lOcwA=
X-Received: by 2002:a05:600c:3515:b0:40d:5b0c:736c with SMTP id
 h21-20020a05600c351500b0040d5b0c736cmr447423wmq.127.1706320414219; Fri, 26
 Jan 2024 17:53:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240125094815.2041933-1-elver@google.com> <20240125094815.2041933-2-elver@google.com>
 <CA+fCnZc6L3t3AdQS1rjFCT0s6RpT+q4Z4GmctOveeaDJW0tBow@mail.gmail.com> <ZbPFUXNeENyuwync@elver.google.com>
In-Reply-To: <ZbPFUXNeENyuwync@elver.google.com>
From: Andrey Konovalov <andreyknvl@gmail.com>
Date: Sat, 27 Jan 2024 02:53:23 +0100
Message-ID: <CA+fCnZeOmHf-zjMnorXJQCyy3em9sMVS_uKaRUwZkbhVRVbRmg@mail.gmail.com>
Subject: Re: [PATCH 2/2] kasan: revert eviction of stack traces in generic mode
To: Marco Elver <elver@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Alexander Potapenko <glider@google.com>, 
	Dmitry Vyukov <dvyukov@google.com>, Vlastimil Babka <vbabka@suse.cz>, 
	Andrey Ryabinin <ryabinin.a.a@gmail.com>, Vincenzo Frascino <vincenzo.frascino@arm.com>, 
	linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 26, 2024 at 3:44=E2=80=AFPM Marco Elver <elver@google.com> wrot=
e:
>
> On Thu, Jan 25, 2024 at 11:36PM +0100, Andrey Konovalov wrote:
> [...]
> >
> > Reviewed-by: Andrey Konovalov <andreyknvl@gmail.com>
> >
> > But I'm wondering if we should also stop resetting metadata when the
> > object is fully freed (from quarantine or bypassing quarantine).
> >
> > With stack_depot_put, I had to put the stack handles on free, as
> > otherwise we would leak the stack depot references. And I also chose
> > to memset meta at that point, as its gets invalid anyway. But without
> > stack_depot_put, this is not required.
> >
> > Before the stack depot-related changes, the code was inconsistent in
> > this regard AFAICS: for quarantine, free meta was marked as invalid
> > via KASAN_SLAB_FREE but alloc meta was kept; for no quarantine, both
> > alloc and free meta were kept.
> >
> > So perhaps we can just keep both metas on full free. I.e. drop both
> > kasan_release_object_meta calls. This will go back to the old behavior
> > + keeping free meta for the quarantine case (I think there's no harm
> > in that). This will give better reporting for uaf-before-realloc bugs.
> >
> > WDYT?
>
> Yes, that makes sense.
>
> You mean this on top?
>
> diff --git a/mm/kasan/common.c b/mm/kasan/common.c
> index ad32803e34e9..0577db1d2c62 100644
> --- a/mm/kasan/common.c
> +++ b/mm/kasan/common.c
> @@ -264,12 +264,6 @@ bool __kasan_slab_free(struct kmem_cache *cache, voi=
d *object,
>         if (kasan_quarantine_put(cache, object))
>                 return true;
>
> -       /*
> -        * If the object is not put into quarantine, it will likely be qu=
ickly
> -        * reallocated. Thus, release its metadata now.
> -        */
> -       kasan_release_object_meta(cache, object);
> -
>         /* Let slab put the object onto the freelist. */
>         return false;
>  }
> diff --git a/mm/kasan/generic.c b/mm/kasan/generic.c
> index 8bfb52b28c22..fc9cf1860efb 100644
> --- a/mm/kasan/generic.c
> +++ b/mm/kasan/generic.c
> @@ -510,20 +510,6 @@ static void release_free_meta(const void *object, st=
ruct kasan_free_meta *meta)
>         *(u8 *)kasan_mem_to_shadow(object) =3D KASAN_SLAB_FREE;
>  }
>
> -void kasan_release_object_meta(struct kmem_cache *cache, const void *obj=
ect)
> -{
> -       struct kasan_alloc_meta *alloc_meta;
> -       struct kasan_free_meta *free_meta;
> -
> -       alloc_meta =3D kasan_get_alloc_meta(cache, object);
> -       if (alloc_meta)
> -               release_alloc_meta(alloc_meta);
> -
> -       free_meta =3D kasan_get_free_meta(cache, object);
> -       if (free_meta)
> -               release_free_meta(object, free_meta);
> -}
> -
>  size_t kasan_metadata_size(struct kmem_cache *cache, bool in_object)
>  {
>         struct kasan_cache *info =3D &cache->kasan_info;
> diff --git a/mm/kasan/kasan.h b/mm/kasan/kasan.h
> index 216ae0ef1e4b..fb2b9ac0659a 100644
> --- a/mm/kasan/kasan.h
> +++ b/mm/kasan/kasan.h
> @@ -390,10 +390,8 @@ struct kasan_alloc_meta *kasan_get_alloc_meta(struct=
 kmem_cache *cache,
>  struct kasan_free_meta *kasan_get_free_meta(struct kmem_cache *cache,
>                                                 const void *object);
>  void kasan_init_object_meta(struct kmem_cache *cache, const void *object=
);
> -void kasan_release_object_meta(struct kmem_cache *cache, const void *obj=
ect);
>  #else
>  static inline void kasan_init_object_meta(struct kmem_cache *cache, cons=
t void *object) { }
> -static inline void kasan_release_object_meta(struct kmem_cache *cache, c=
onst void *object) { }
>  #endif
>
>  depot_stack_handle_t kasan_save_stack(gfp_t flags, depot_flags_t depot_f=
lags);
> diff --git a/mm/kasan/quarantine.c b/mm/kasan/quarantine.c
> index 3ba02efb952a..a758c2e10703 100644
> --- a/mm/kasan/quarantine.c
> +++ b/mm/kasan/quarantine.c
> @@ -145,8 +145,6 @@ static void qlink_free(struct qlist_node *qlink, stru=
ct kmem_cache *cache)
>         void *object =3D qlink_to_object(qlink, cache);
>         struct kasan_free_meta *free_meta =3D kasan_get_free_meta(cache, =
object);
>
> -       kasan_release_object_meta(cache, object);
> -
>         /*
>          * If init_on_free is enabled and KASAN's free metadata is stored=
 in
>          * the object, zero the metadata. Otherwise, the object's memory =
will

Please also add a comment saying something like "Keep per-object
metadata to allow KASAN print stack traces for
use-after-free-before-realloc bugs." to the places where you removed
kasan_release_object_meta.

Otherwise, looks good to me.

