Return-Path: <linux-kernel+bounces-168179-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EFFE8BB4D2
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 22:26:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F1023285492
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 20:25:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97A74158DB2;
	Fri,  3 May 2024 20:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QmoYejKD"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDD36158D82
	for <linux-kernel@vger.kernel.org>; Fri,  3 May 2024 20:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714767936; cv=none; b=FlyHnD2P/4DEYkVPCPMK+WKwpnis9pClLrZIM17FUKfXTXDxzAd7yrgiG/Hmo4CL5VInjalamSp9JAJ+OeAAb+4SQ+XVI5xaVKlKzY4mvmImeDyyvXQ3Tpq8LwEOYEx7lGM6koKDraK66y9CSImmMGQANygZQsckYyq7dxH//gw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714767936; c=relaxed/simple;
	bh=ItEGCpuVwR6wfs1rCi1LDD0NyFGrhaydJzh05ZLWjr4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=X77EQybuduAjOizjFZVN5Aa57jSqdficoRvQsiK3w6yD7ZDgnAzu6sYcxujMdDDBl04/1zR72NzZM+NwdCJCWJCqK4vxFQBG+OGtZAxk2T17bzZYUSZa3bUoYBD1Cv0NpvYWcxvQ8UDYxoeCgyUZptNAKNWEhmWtSLCRIsEYCWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QmoYejKD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C8F0C4AF19
	for <linux-kernel@vger.kernel.org>; Fri,  3 May 2024 20:25:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714767936;
	bh=ItEGCpuVwR6wfs1rCi1LDD0NyFGrhaydJzh05ZLWjr4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=QmoYejKDmwFJb1tYMkCgohRki2rpvmSrjFjoCe2qFnEW2z8+Vy8JrmHRK49QEt4A8
	 5BBHSkr1yv+xQFz9rPiIGbStkrNkzZCc8VzNfpC105L6Zasm4XwOpSZ35QSh87S91G
	 D/RfD3fvQ4hG9HiCBbeL2YPpV264bHfKu1V1dyFSFbe8eYCZ+e4pB5obvyOloVrxLX
	 nINVJk5X5AMi/KDqDAKYzj09fsB4rV9J1bO5bUbpl8wlaiUubEMhPBPGTiCTkF1ijk
	 cHm2RnZlZLxYlsMI271+tLAUO7ie0pEqRtuJmpVzk9E+0wkO6AOClSeXKTnSeBvVj1
	 ckmlwnX7AVJSQ==
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2e20f2db068so743261fa.2
        for <linux-kernel@vger.kernel.org>; Fri, 03 May 2024 13:25:36 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXQJrsEU62gBsbQOzIqE4SvZKMLFSHhUFKp7FZvX2SlMR7QfAd/YVqZoUluwZkLWIk2tYX7ayGXxwsCKA9iTJ6mZyKN3RxMT5biU3zv
X-Gm-Message-State: AOJu0YxpB4CjPzhVvuIY0unAtdZQQcsfNy56rTJPHfz7Tif3G7/dUHIt
	8qlcyfzI9IPlsJQ1Br5hIMv2+aKZA+P4xQWpdYtb2U7Ap1+EvA6MCWjO9s753g9cZ75FzQ9uBgs
	y3gIoYW9DkquYnFrkUKqpPKYk1Q==
X-Google-Smtp-Source: AGHT+IG26udORfjMHQagSGCQro/CQlVpCtUbDwiD+tUU+7hyVtPfFNDPDGalOxjTcQ1r9VQt/Ml3fLFFiQPORKIiICI=
X-Received: by 2002:a2e:a0d7:0:b0:2df:c0b8:2dd6 with SMTP id
 f23-20020a2ea0d7000000b002dfc0b82dd6mr2761062ljm.21.1714767934953; Fri, 03
 May 2024 13:25:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240503005023.174597-1-21cnbao@gmail.com> <20240503005023.174597-2-21cnbao@gmail.com>
In-Reply-To: <20240503005023.174597-2-21cnbao@gmail.com>
From: Chris Li <chrisl@kernel.org>
Date: Fri, 3 May 2024 13:25:22 -0700
X-Gmail-Original-Message-ID: <CANeU7Qkqjxp4hHceK3f5ZAxRiidRN_mpYpTc44oBZ9T=hESMSg@mail.gmail.com>
Message-ID: <CANeU7Qkqjxp4hHceK3f5ZAxRiidRN_mpYpTc44oBZ9T=hESMSg@mail.gmail.com>
Subject: Re: [PATCH v3 1/6] mm: swap: introduce swap_free_nr() for batched swap_free()
To: Barry Song <21cnbao@gmail.com>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org, 
	baolin.wang@linux.alibaba.com, david@redhat.com, hanchuanhua@oppo.com, 
	hannes@cmpxchg.org, hughd@google.com, kasong@tencent.com, 
	linux-kernel@vger.kernel.org, ryan.roberts@arm.com, surenb@google.com, 
	v-songbaohua@oppo.com, willy@infradead.org, xiang@kernel.org, 
	ying.huang@intel.com, yosryahmed@google.com, yuzhao@google.com, 
	ziy@nvidia.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Barry,

Looks good. Looking forward to the change to batch free to skipping
the swap slot cache.
All the entries are from the same swap device, it does not need the
sort function. Currently it goes through a lot of locking and and
unlocking inside the loop.

Acked-by: Chris Li <chrisl@kernel.org>

Chris

On Thu, May 2, 2024 at 5:50=E2=80=AFPM Barry Song <21cnbao@gmail.com> wrote=
:
>
> From: Chuanhua Han <hanchuanhua@oppo.com>
>
> While swapping in a large folio, we need to free swaps related to the who=
le
> folio. To avoid frequently acquiring and releasing swap locks, it is bett=
er
> to introduce an API for batched free.
> Furthermore, this new function, swap_free_nr(), is designed to efficientl=
y
> handle various scenarios for releasing a specified number, nr, of swap
> entries.
>
> Signed-off-by: Chuanhua Han <hanchuanhua@oppo.com>
> Co-developed-by: Barry Song <v-songbaohua@oppo.com>
> Signed-off-by: Barry Song <v-songbaohua@oppo.com>
> ---
>  include/linux/swap.h |  5 +++++
>  mm/swapfile.c        | 47 ++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 52 insertions(+)
>
> diff --git a/include/linux/swap.h b/include/linux/swap.h
> index 11c53692f65f..d1d35e92d7e9 100644
> --- a/include/linux/swap.h
> +++ b/include/linux/swap.h
> @@ -483,6 +483,7 @@ extern void swap_shmem_alloc(swp_entry_t);
>  extern int swap_duplicate(swp_entry_t);
>  extern int swapcache_prepare(swp_entry_t);
>  extern void swap_free(swp_entry_t);
> +extern void swap_free_nr(swp_entry_t entry, int nr_pages);
>  extern void swapcache_free_entries(swp_entry_t *entries, int n);
>  extern void free_swap_and_cache_nr(swp_entry_t entry, int nr);
>  int swap_type_of(dev_t device, sector_t offset);
> @@ -564,6 +565,10 @@ static inline void swap_free(swp_entry_t swp)
>  {
>  }
>
> +static inline void swap_free_nr(swp_entry_t entry, int nr_pages)
> +{
> +}
> +
>  static inline void put_swap_folio(struct folio *folio, swp_entry_t swp)
>  {
>  }
> diff --git a/mm/swapfile.c b/mm/swapfile.c
> index f6ca215fb92f..ec12f2b9d229 100644
> --- a/mm/swapfile.c
> +++ b/mm/swapfile.c
> @@ -1356,6 +1356,53 @@ void swap_free(swp_entry_t entry)
>                 __swap_entry_free(p, entry);
>  }
>
> +static void cluster_swap_free_nr(struct swap_info_struct *sis,
> +               unsigned long offset, int nr_pages)
> +{
> +       struct swap_cluster_info *ci;
> +       DECLARE_BITMAP(to_free, BITS_PER_LONG) =3D { 0 };
> +       int i, nr;
> +
> +       ci =3D lock_cluster_or_swap_info(sis, offset);
> +       while (nr_pages) {
> +               nr =3D min(BITS_PER_LONG, nr_pages);
> +               for (i =3D 0; i < nr; i++) {
> +                       if (!__swap_entry_free_locked(sis, offset + i, 1)=
)
> +                               bitmap_set(to_free, i, 1);
> +               }
> +               if (!bitmap_empty(to_free, BITS_PER_LONG)) {
> +                       unlock_cluster_or_swap_info(sis, ci);
> +                       for_each_set_bit(i, to_free, BITS_PER_LONG)
> +                               free_swap_slot(swp_entry(sis->type, offse=
t + i));
> +                       if (nr =3D=3D nr_pages)
> +                               return;
> +                       bitmap_clear(to_free, 0, BITS_PER_LONG);
> +                       ci =3D lock_cluster_or_swap_info(sis, offset);
> +               }
> +               offset +=3D nr;
> +               nr_pages -=3D nr;
> +       }
> +       unlock_cluster_or_swap_info(sis, ci);
> +}
> +
> +void swap_free_nr(swp_entry_t entry, int nr_pages)
> +{
> +       int nr;
> +       struct swap_info_struct *sis;
> +       unsigned long offset =3D swp_offset(entry);
> +
> +       sis =3D _swap_info_get(entry);
> +       if (!sis)
> +               return;
> +
> +       while (nr_pages) {
> +               nr =3D min_t(int, nr_pages, SWAPFILE_CLUSTER - offset % S=
WAPFILE_CLUSTER);
> +               cluster_swap_free_nr(sis, offset, nr);
> +               offset +=3D nr;
> +               nr_pages -=3D nr;
> +       }
> +}
> +
>  /*
>   * Called after dropping swapcache to decrease refcnt to swap entries.
>   */
> --
> 2.34.1
>

