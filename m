Return-Path: <linux-kernel+bounces-103278-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BF92987BD5F
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 14:12:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 399891F216CB
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 13:12:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 621915B200;
	Thu, 14 Mar 2024 13:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dv84ZFji"
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C21445811C
	for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 13:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710421960; cv=none; b=mVI8UeLhalptUoBng8BhZkF2LliUVxUoc9zLsYyilsoFCDMLsvHpW6P+L/B4oEpIgRzGaqJYdvT95yefb4DZMf2NBxMs7kX0YlkD+CS83ukRM1d1QdDp20pu7tYKRqXzFhLc5LE3/cvkAEWVBKtDNXdwZekN37sokvVPJwGKG9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710421960; c=relaxed/simple;
	bh=vEPrcEG4Y0Cc8YlvPQ1MDq6dRxjCwPX8a0r/4aKe/3c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WBcuxUe0WkRXlFC/r5CMAFFli9E6zO5GPEuGuoUTo1FAB9C+LUFb4vpiMBNGgG83Nt04EsYDTujdd4t3JvKdl3Od/D0ROiXt5cfd5DY2ycX6CoXRimxM1e27SEiUHjFLm00TGiDS7lDBA2fIW0sj/aGWkleUwprQus46CEu/iZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dv84ZFji; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-56845954ffeso1231794a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 06:12:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710421957; x=1711026757; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H62lO+oi6cqZ8jJaBCDOw4WoFlGyuOK3o5bFL4QH/2Y=;
        b=dv84ZFjihmlxRt5AL4tYLZvF+IHB5AHMYQdSedYRXxQn5RgriPdbHE8532vWJ2/0bZ
         T3AHv05eNupTLreDa4B+hD1Xm2czl8pINcqh+UR26Il+dCyn1Dv5RzcEOmR2/h6r8AJN
         tflx0sb48FM5VPtv1c2JdsbMLRXE2/d3fyUst6YVEAeNPC6X9zyh5BGH/R2b3tmiPyJ5
         5FJLmiywNjn9JouvyCyp9LISQzIjSkalN0XLYDlbTpEM/IF6cI/23wlhuVNyvwWK6ShC
         d4s334IBdRWu3vJnnDCbzcgyNfyqCoV8aESPh6qLpHIPsaIsyIVOyf7h/7iFXj/sRmdm
         N4Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710421957; x=1711026757;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H62lO+oi6cqZ8jJaBCDOw4WoFlGyuOK3o5bFL4QH/2Y=;
        b=kHPREWb35q1O9EaHxKIRfM5ws68S1CcUm3LPj1R7t6QbeUawAUA09HMdVRL0s8Xfiq
         ASp5YiBofRObTLJ68qDaTGiQi5y2vCtD3shlgFf4FzOiCh9qKuPkHS3t+GxXZ9MGOeIe
         z1jPd1CscaEJV2bpiTcHKJIEfd3OfGy0WY8QGFLFvWcrlw3awSNFyJYak1ZVFOVhRLW3
         isv/c1qTrOAxlbGF6WYRttgBt05gRWTtcUZVYOOlIE2LS0WVQv+lxJ9YWj0id3c+XfrK
         G9h2oOkWqZfcziSqZWJKpQyit6AMV/Vcdn+yoSdKafIcvnlIo5mynHrnSqI20Ilo7sHs
         z1tg==
X-Forwarded-Encrypted: i=1; AJvYcCUYcppfwxES9B9FZRCWQD64GF1CeF2AbzBwQSDLnf5KSpkk+aYYOgkC+CzcKoQAbEZ648FX4SBGQOn6H4BxO8RZ27fugGqgFIs28fum
X-Gm-Message-State: AOJu0Yw9TTmvbTc1WeDZwEwcbzTkE78yUAsLBO1ehnu5lRuHQcNNbqkb
	dFhWyEH9hEhLJy9lIpP5u1HaUFJnM/BjZ/GgIsnvLchQOVlHt47Kf6xr6SB6y40y59Qr8mxdxGE
	aJSWG+4Y//EuRHMiaUbR6FfBQ2gQ=
X-Google-Smtp-Source: AGHT+IGVeVLKvGGTbfxnWNv6CU4y+YUBNoogOO9HebA4vVKRVOECbhRQfqfq76ixhWrOIDUth6fTQBnfg3pOPg/Do64=
X-Received: by 2002:a05:6402:2486:b0:566:4dc1:522c with SMTP id
 q6-20020a056402248600b005664dc1522cmr1405949eda.15.1710421956967; Thu, 14 Mar
 2024 06:12:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240304081348.197341-1-21cnbao@gmail.com> <20240304081348.197341-3-21cnbao@gmail.com>
 <499a60c6-eeb8-4bbd-8563-9717c0d2e43d@arm.com>
In-Reply-To: <499a60c6-eeb8-4bbd-8563-9717c0d2e43d@arm.com>
From: Chuanhua Han <chuanhuahan@gmail.com>
Date: Thu, 14 Mar 2024 21:12:25 +0800
Message-ID: <CANzGp4+kSxc_JbOsOcvm6vXfu2KORaqqGyuKK_eJwCLTK5X__Q@mail.gmail.com>
Subject: Re: [RFC PATCH v3 2/5] mm: swap: introduce swap_nr_free() for batched swap_free()
To: Ryan Roberts <ryan.roberts@arm.com>
Cc: Barry Song <21cnbao@gmail.com>, akpm@linux-foundation.org, linux-mm@kvack.org, 
	chengming.zhou@linux.dev, chrisl@kernel.org, david@redhat.com, 
	hannes@cmpxchg.org, kasong@tencent.com, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, mhocko@suse.com, nphamcs@gmail.com, 
	shy828301@gmail.com, steven.price@arm.com, surenb@google.com, 
	wangkefeng.wang@huawei.com, willy@infradead.org, xiang@kernel.org, 
	ying.huang@intel.com, yosryahmed@google.com, yuzhao@google.com, 
	Chuanhua Han <hanchuanhua@oppo.com>, Barry Song <v-songbaohua@oppo.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Ryan Roberts <ryan.roberts@arm.com> =E4=BA=8E2024=E5=B9=B43=E6=9C=8812=E6=
=97=A5=E5=91=A8=E4=BA=8C 02:51=E5=86=99=E9=81=93=EF=BC=9A
>
> On 04/03/2024 08:13, Barry Song wrote:
> > From: Chuanhua Han <hanchuanhua@oppo.com>
> >
> > While swapping in a large folio, we need to free swaps related to the w=
hole
> > folio. To avoid frequently acquiring and releasing swap locks, it is be=
tter
> > to introduce an API for batched free.
> >
> > Signed-off-by: Chuanhua Han <hanchuanhua@oppo.com>
> > Co-developed-by: Barry Song <v-songbaohua@oppo.com>
> > Signed-off-by: Barry Song <v-songbaohua@oppo.com>
> > ---
> >  include/linux/swap.h |  6 ++++++
> >  mm/swapfile.c        | 35 +++++++++++++++++++++++++++++++++++
> >  2 files changed, 41 insertions(+)
> >
> > diff --git a/include/linux/swap.h b/include/linux/swap.h
> > index 2955f7a78d8d..d6ab27929458 100644
> > --- a/include/linux/swap.h
> > +++ b/include/linux/swap.h
> > @@ -481,6 +481,7 @@ extern void swap_shmem_alloc(swp_entry_t);
> >  extern int swap_duplicate(swp_entry_t);
> >  extern int swapcache_prepare(swp_entry_t);
> >  extern void swap_free(swp_entry_t);
> > +extern void swap_nr_free(swp_entry_t entry, int nr_pages);
>
> nit: In my swap-out v4 series, I've created a batched version of
> free_swap_and_cache() and called it free_swap_and_cache_nr(). Perhaps it =
is
> preferable to align the naming schemes - i.e. call this swap_free_nr(). Y=
our
> scheme doesn't really work when applied to free_swap_and_cache().
Thanks for your suggestions, and for the next version, we'll see which
package is more appropriate!
>
> >  extern void swapcache_free_entries(swp_entry_t *entries, int n);
> >  extern int free_swap_and_cache(swp_entry_t);
> >  int swap_type_of(dev_t device, sector_t offset);
> > @@ -561,6 +562,11 @@ static inline void swap_free(swp_entry_t swp)
> >  {
> >  }
> >
> > +void swap_nr_free(swp_entry_t entry, int nr_pages)
> > +{
> > +
> > +}
> > +
> >  static inline void put_swap_folio(struct folio *folio, swp_entry_t swp=
)
> >  {
> >  }
> > diff --git a/mm/swapfile.c b/mm/swapfile.c
> > index 3f594be83b58..244106998a69 100644
> > --- a/mm/swapfile.c
> > +++ b/mm/swapfile.c
> > @@ -1341,6 +1341,41 @@ void swap_free(swp_entry_t entry)
> >               __swap_entry_free(p, entry);
> >  }
> >
> > +/*
> > + * Called after swapping in a large folio, batched free swap entries
> > + * for this large folio, entry should be for the first subpage and
> > + * its offset is aligned with nr_pages
> > + */
> > +void swap_nr_free(swp_entry_t entry, int nr_pages)
> > +{
> > +     int i;
> > +     struct swap_cluster_info *ci;
> > +     struct swap_info_struct *p;
> > +     unsigned type =3D swp_type(entry);
>
> nit: checkpatch.py will complain about bare "unsigned", preferring "unsig=
ned
> int" or at least it did for me when I did something similar in my swap-ou=
t patch
> set.
Gee, thanks for pointing that out!
>
> > +     unsigned long offset =3D swp_offset(entry);
> > +     DECLARE_BITMAP(usage, SWAPFILE_CLUSTER) =3D { 0 };
>
> I don't love this, as it could blow the stack if SWAPFILE_CLUSTER ever
> increases. But the only other way I can think of is to explicitly loop ov=
er
> fixed size chunks, and that's not much better.
Is it possible to save kernel stack better by using bit_map here?  If
SWAPFILE_CLUSTER=3D512, we consume only (512/64)*8=3D 64 bytes.
>
> > +
> > +     /* all swap entries are within a cluster for mTHP */
> > +     VM_BUG_ON(offset % SWAPFILE_CLUSTER + nr_pages > SWAPFILE_CLUSTER=
);
> > +
> > +     if (nr_pages =3D=3D 1) {
> > +             swap_free(entry);
> > +             return;
> > +     }
> > +
> > +     p =3D _swap_info_get(entry);
>
> You need to handle this returning NULL, like swap_free() does.
Yes, you're right! We did forget to judge NULL here.
>
> > +
> > +     ci =3D lock_cluster(p, offset);
>
> The existing swap_free() calls lock_cluster_or_swap_info(). So if swap is=
 backed
> by rotating media, and clusters are not in use, it will lock the whole sw=
ap
> info. But your new version only calls lock_cluster() which won't lock any=
thing
> if clusters are not in use. So I think this is a locking bug.
Again, you're right, it's bug!
>
> > +     for (i =3D 0; i < nr_pages; i++) {
> > +             if (__swap_entry_free_locked(p, offset + i, 1))
> > +                     __bitmap_set(usage, i, 1);
> > +     }
> > +     unlock_cluster(ci);
> > +
> > +     for_each_clear_bit(i, usage, nr_pages)
> > +             free_swap_slot(swp_entry(type, offset + i));
> > +}
> > +
> >  /*
> >   * Called after dropping swapcache to decrease refcnt to swap entries.
> >   */
>
> Thanks,
> Ryan
>
>


--=20
Thanks,
Chuanhua

