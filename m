Return-Path: <linux-kernel+bounces-126787-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 07380893CB3
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 17:15:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8B1C91F2113A
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 15:15:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E823745C07;
	Mon,  1 Apr 2024 15:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fuS3Qooa"
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 518CB45948
	for <linux-kernel@vger.kernel.org>; Mon,  1 Apr 2024 15:15:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711984539; cv=none; b=CzEvXln4J+mckCB38QS27J7S84qk2s7ISFWyEw96dT3SMd1lkD0i5YxNqA4Cb3Gm1aSCeZxd+7Uo4emUXIh2/5NJeWORM7XA7ylBaZzMZZuD1CdE03Ro9RxIh79PUj691QznwCF+qKI3D/nTrh+wj9kubwcix8ksNm4Jcj1I3wA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711984539; c=relaxed/simple;
	bh=UGCJnGrY1HcT4tS9dtSCnBbe3N2cEX03n/ihCHy5DtM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZmQHXPpR8mnYzlHDrU6Twj2T5Rg7LI4WX+HLhgbdDYVbZ06VGiMvo5k4oqAZiw7nbgZDGTCByz17DTVtAP3KRGsjAm9HzSXetTpuI/uxgXKpADNmwaKFZIWtHJXfKCuVL4UUzEtvtYiwbIFXyFrG3xnpwdp/cHVUQsD+8DR+aUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fuS3Qooa; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2d485886545so68354701fa.2
        for <linux-kernel@vger.kernel.org>; Mon, 01 Apr 2024 08:15:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711984535; x=1712589335; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UGCJnGrY1HcT4tS9dtSCnBbe3N2cEX03n/ihCHy5DtM=;
        b=fuS3QooaUMUHghgSy1M3y3jMB5yKg/HNEXBgdwVfJab+91pE22HnnM4bVvqDj9zbGx
         RqW9zn0L9BK2YBJeT4RwGQHDH92vhpz5m2CKyY+1bfGhsmY01ISHKaxyU6CK2ptGdpNf
         WPLSSLeQ29SVfgBLU/Qv+jl2yUZZTUZ6VgtsJxdj2syWLVYfZTA4aTnNAWBBROxSIJFD
         /Q+yA02dYK0hIq8zNrswILnAxL1XSXPfVEfIvGQ2d0YUEfKJ0Q+0gq0AWGRllB7hF+PX
         un9ppVfkaH9BZEBkW6ceeL9ppMotQAFvJzahaVs8K4nq+upHXJ+ISMOfG9JqZ2RFjsZB
         kX4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711984535; x=1712589335;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UGCJnGrY1HcT4tS9dtSCnBbe3N2cEX03n/ihCHy5DtM=;
        b=rhKA5myU5cjLnvULr4oNLXR5HjmPCde7swgLzceeNI5xB962dGY2tnTJRhvXYuaiCm
         o+GdQxPY2HxIBwCwP0gvTu0oE/N+Lg199iyXNxgu9RyETuzbYCKbb9pZfRBSF5tg2rQj
         NqH10cEF+50mFW3a6mGWgk5ph7Pb1ilRXE1RwWMK/tRCqGem6GP/POZc5/YMS0djt1d5
         iBsGu43lxSaJEwcLmxRSU7+gGcExTiZf9nuZ2VMEApZ11oZnSieSoQCqiaMDYTIx6bVE
         WXSo4ZlUTIybRKc/EDgrMjV0oMbnnI85F/RsukwXctEVdbGVtetwq5f3zFPK3ybeFHeE
         eRjA==
X-Forwarded-Encrypted: i=1; AJvYcCX5IUQQieI8istYqFAArx/7boEGNWkSjQGEsEh0VrTtshwhEXfmInJaGlmiYYJb6xKUzvtLspmjWa8PC47slWDQxxgqM+KuUDymRotG
X-Gm-Message-State: AOJu0YwCdFAdEza7Xe7u5xdChlmphIxBv0AW9ehpZef/a9Iw8yWn28JL
	5Q8BV1yadT/7GFGwGLAFycC2nUeaN0LjLc+gfF0HUAbXrYBlYyd7YIUl8nWNKIUpry+uZmkeQfh
	bH1fjNliZVMt+YHVC1SPo5Sz6toc=
X-Google-Smtp-Source: AGHT+IGWPNJzVz4HVG8JBI+Lb3BFjPn8V5RTtoWCOJIC3fg/s5S8XIefdWJSSyvjaaFSLZqqNbyLoYL5IT3mnGdozmc=
X-Received: by 2002:a05:651c:384:b0:2d6:a609:9a33 with SMTP id
 e4-20020a05651c038400b002d6a6099a33mr7549832ljp.0.1711984535069; Mon, 01 Apr
 2024 08:15:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CACFO4hLEReDiPvaLmEj1c105xUnC3o_zXshpw1zF_+2n0CZpiQ@mail.gmail.com>
In-Reply-To: <CACFO4hLEReDiPvaLmEj1c105xUnC3o_zXshpw1zF_+2n0CZpiQ@mail.gmail.com>
From: Kairui Song <ryncsn@gmail.com>
Date: Mon, 1 Apr 2024 23:15:18 +0800
Message-ID: <CAMgjq7C-4H5zcbs_-mvSNBBWiGhx__0_sTTG32Nfsz7TnP=i5Q@mail.gmail.com>
Subject: Re: [PATCH] mm: swap: prejudgement swap_has_cache to avoid page allocation
To: Zhaoyu Liu <liuzhaoyu.zackary@bytedance.com>
Cc: akpm@linux-foundation.org, ying.huang@intel.com, songmuchun@bytedance.com, 
	david@redhat.com, willy@infradead.org, chrisl@kernel.org, nphamcs@gmail.com, 
	yosryahmed@google.com, guo.ziliang@zte.com.cn, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 1, 2024 at 10:15=E2=80=AFPM Zhaoyu Liu
<liuzhaoyu.zackary@bytedance.com> wrote:
>

Hi Zhaoyu

Not sure why but I can't apply your patch, maybe you need to fix your
email client?

> Based on qemu arm64 - latest kernel + 100M memory + 1024M swapfile.
> Create 1G anon mmap and set it to shared, and has two processes
> randomly access the shared memory. When they are racing on swap cache,
> on average, each "alloc_pages_mpol + swapcache_prepare + folio_put"
> took about 1475 us.
>
> So skip page allocation if SWAP_HAS_CACHE was set, just
> schedule_timeout_uninterruptible and continue to acquire page
> via filemap_get_folio() from swap cache, to speedup
> __read_swap_cache_async.
>
> Signed-off-by: Zhaoyu Liu
> ---
> include/linux/swap.h | 6 ++++++
> mm/swap_state.c | 10 ++++++++++
> mm/swapfile.c | 15 +++++++++++++++
> 3 files changed, 31 insertions(+)
>
> diff --git a/include/linux/swap.h b/include/linux/swap.h
> index a211a0383425..8a0013299f38 100644
> --- a/include/linux/swap.h
> +++ b/include/linux/swap.h
> @@ -480,6 +480,7 @@ extern sector_t swapdev_block(int, pgoff_t);
> extern int __swap_count(swp_entry_t entry);
> extern int swap_swapcount(struct swap_info_struct *si, swp_entry_t entry)=
;
> extern int swp_swapcount(swp_entry_t entry);
> +extern bool swap_has_cache(struct swap_info_struct *si, swp_entry_t entr=
y);
> struct swap_info_struct *swp_swap_info(swp_entry_t entry);
> struct backing_dev_info;
> extern int init_swap_address_space(unsigned int type, unsigned long nr_pa=
ges);
> @@ -570,6 +571,11 @@ static inline int swp_swapcount(swp_entry_t entry)
> return 0;
> }
>
> +static inline bool swap_has_cache(struct swap_info_struct *si, swp_entry=
_t entry)
> +{
> + return false;
> +}
> +
> static inline swp_entry_t folio_alloc_swap(struct folio *folio)
> {
> swp_entry_t entry;
> diff --git a/mm/swap_state.c b/mm/swap_state.c
> index bfc7e8c58a6d..f130cfc669ce 100644
> --- a/mm/swap_state.c
> +++ b/mm/swap_state.c
> @@ -462,6 +462,15 @@ struct folio *__read_swap_cache_async(swp_entry_t en=
try, gfp_t gfp_mask,
> if (!swap_swapcount(si, entry) && swap_slot_cache_enabled)
> goto fail_put_swap;
>
> + /*
> + * Skipping page allocation if SWAP_HAS_CACHE was set,
> + * just schedule_timeout_uninterruptible and continue to
> + * acquire page via filemap_get_folio() from swap cache,
> + * to speedup __read_swap_cache_async.
> + */
> + if (swap_has_cache(si, entry))
> + goto skip_alloc;
> +

But will this cause more lock contention? You need to lock the cluster
for the has_cache now.

> /*
> * Get a new folio to read into from swap. Allocate it now,
> * before marking swap_map SWAP_HAS_CACHE, when -EEXIST will
> @@ -483,6 +492,7 @@ struct folio *__read_swap_cache_async(swp_entry_t ent=
ry, gfp_t gfp_mask,
> if (err !=3D -EEXIST)
> goto fail_put_swap;
>
> +skip_alloc:
> /*
> * Protect against a recursive call to __read_swap_cache_async()
> * on the same entry waiting forever here because SWAP_HAS_CACHE
> diff --git a/mm/swapfile.c b/mm/swapfile.c
> index cf900794f5ed..5388950c4ca6 100644
> --- a/mm/swapfile.c
> +++ b/mm/swapfile.c
> @@ -1513,6 +1513,21 @@ int swp_swapcount(swp_entry_t entry)
> return count;
> }
>
> +/*
> + * Verify that a swap entry has been tagged with SWAP_HAS_CACHE
> + */
> +bool swap_has_cache(struct swap_info_struct *si, swp_entry_t entry)
> +{
> + pgoff_t offset =3D swp_offset(entry);
> + struct swap_cluster_info *ci;
> + bool has_cache;
> +
> + ci =3D lock_cluster_or_swap_info(si, offset);
> + has_cache =3D !!(si->swap_map[offset] & SWAP_HAS_CACHE);

I think you also need to check swap_count here, if an entry was just
freed or loaded into slot cache, it will also have SWAP_HAS_CACHE set.

I have a very similar function in my another series (see __swap_has_cache):
https://lore.kernel.org/all/20240326185032.72159-10-ryncsn@gmail.com/

The situation is different with this patch though. But this check is
not reliable in both patches, having SWAP_HAS_CACHE doesn't mean the
folio is in the cache, and even if it's in the cache, it might get
freed very soon. So you need to ensure later checks can ensure the
final result is not affected.

eg. If swap_has_cache returns true, then swap cache is freed, and
skip_if_exists is set to true, __read_swap_cache_async will return
NULL for an entry that it should be able to alloc and cache, could
this be a problem (for example, causing zswap writeback to fail with
ENOMEM due to readahead)?

Also the race window that you are trying to avoid seems to be very
short and rare? Not sure if the whole idea is worth it and actually
affects performance in a positive way, any data on that?

