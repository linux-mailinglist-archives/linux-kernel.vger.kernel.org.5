Return-Path: <linux-kernel+bounces-142602-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E0EC48A2DAC
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 13:39:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9589F280A1A
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 11:39:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8664F54FB1;
	Fri, 12 Apr 2024 11:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PXLUkW7H"
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB1BC4087B
	for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 11:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712921950; cv=none; b=afC92KJhnGnca/cyh0JuevwkwfmubV5KC1xAcEu/JsxXUiw7c6vMYuEA2b2H5vH3QzHYdeP0MZsy5vKKuPV6M6Fky+07TlaegOS1xIfbriWjVixquGd6JQRbwjQCrU5oO7kDhhlIi9isDiI/XqIpwkRMPPSV5YjDErcatP22zrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712921950; c=relaxed/simple;
	bh=sIU3hgoHw1bRexRx3Jn7dEhIyiOYe5W+0NALhhgdBss=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aqKQPcm/YR9JdoUAZiFilbHeOjXZMvR5ZtzbW9vJqLNuXJ0jftj5axFsM5ixfKi82RGEq6H+fGdgvC4GmhWLK47GdjpH96Pu60JZpQgDNiGBf72JDnGv3rxTgSfBVMwzVWvMcC+CeQp6u2WKv6cR3OJpeW9wT/a+jYLUo88VT0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PXLUkW7H; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-56e1baf0380so849575a12.3
        for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 04:39:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712921947; x=1713526747; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ne+lbARHIxIH9ow2SNPs+xIBWW7muiKC/RnuB4JLtkU=;
        b=PXLUkW7HTXGHTG7I+odzsCmKXNFKgKLc281M+82O40pNlW5Cr+PtA26HmIvhaYpZah
         R/CjlE+2R+yb1/imRH5J9/ep9KT7BGMaD7J9WwywqK4fKF8vs89sa0wC9mm2Ya6BDQoP
         VOf+8J0EOnKowArujSZAEYfZPmqP3a/nvIKlWOSM6QYsqT5eNB0RWod2jqLip9j7UzSZ
         JfinW14boBMgsVQikGk/NjjWXSwDUUh8ai/Bx+kQ2rjHlFYcbXVPUAro157cnjKmKnTY
         Wx4xtAZS4/9+9MqrqWTRQDYI+ceHiA44L/DlJalppccKEKZgppHe1OXirRTn3WhBkXx1
         qbog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712921947; x=1713526747;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ne+lbARHIxIH9ow2SNPs+xIBWW7muiKC/RnuB4JLtkU=;
        b=VjVo8cF0QBLVWBkG7DotrbNtFVaM0hMqqxpI6QgROBdlxYo6PZHbSiz+FNAy51HQR6
         Tex0WosMqO7JC5SOMfNg1U1aPS8Z5eKWCbE36on1riDYgqKnx+qCPUo5cSdXlAsaAdD3
         lsRMSbyhx4ykN22tvVFsa9WAlsqug+BU7vI/plV6ow226sd4+k5kyi9uKXqu8STdZPaP
         nQHdzO59Wx9l2QNTRzVKKFcE1B1Q6GSmXVQ3UJdLq4WYpawadOiL5twsQJp80Db8U9Xm
         NG6M0CSSy+pGch6Ru4N1FxTm45FN0RBsXSr1pvPJySGknMZBSAGY84e/B42GuX6lXSUs
         Isxg==
X-Forwarded-Encrypted: i=1; AJvYcCUzTuRTKclwNVvCEIBakUpmxCkdUZipxDLtlOPPC/5lUd/mYye2ELjH6r7bo6CytdaSMDu3YBqmLgl6KHhFHWFOXNg6JcaY5wWsQRdO
X-Gm-Message-State: AOJu0Yxh/X6awSarYdvD3ty4Fr5e3lffRgKX5cV/UL9W/SpJdHsOINHa
	z1OnKK6teY5TRIx9a9spyUQ9OMXyHjl/dODFO5XMcOsQRuyd3GVk9cprrMTbO3QyFQFsCgQZosu
	LGeJRyw37wifbS0es67TwRtDiLFs=
X-Google-Smtp-Source: AGHT+IGJKL463vGhgAykZA/DrJ7dmuatQjc3W/dExDHS0ebPMyuuPP1hoCfNK2hrcfqmUASRS5iguO3X2fBw2gqm1Qo=
X-Received: by 2002:a50:c30e:0:b0:56e:543c:bbb5 with SMTP id
 a14-20020a50c30e000000b0056e543cbbb5mr1435336edb.26.1712921946997; Fri, 12
 Apr 2024 04:39:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240409082631.187483-1-21cnbao@gmail.com> <20240409082631.187483-2-21cnbao@gmail.com>
 <95bc0ebb-49f4-4331-8809-3e4625f1d91a@arm.com> <CANzGp4Jzw9bUnQw1zVdw7V6=pARx7x5s8QTyXJGfdEzrXVkZTA@mail.gmail.com>
 <66afc978-0221-488b-9fc6-7d5213d385ed@arm.com>
In-Reply-To: <66afc978-0221-488b-9fc6-7d5213d385ed@arm.com>
From: Chuanhua Han <chuanhuahan@gmail.com>
Date: Fri, 12 Apr 2024 19:38:55 +0800
Message-ID: <CANzGp4J_7-Rj8N3jM3Tb+zAMZm21nf-cni0RjWWWfJNDXu5asQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/5] mm: swap: introduce swap_free_nr() for batched swap_free()
To: Ryan Roberts <ryan.roberts@arm.com>
Cc: Barry Song <21cnbao@gmail.com>, akpm@linux-foundation.org, linux-mm@kvack.org, 
	baolin.wang@linux.alibaba.com, chrisl@kernel.org, david@redhat.com, 
	hanchuanhua@oppo.com, hannes@cmpxchg.org, hughd@google.com, 
	kasong@tencent.com, surenb@google.com, v-songbaohua@oppo.com, 
	willy@infradead.org, xiang@kernel.org, ying.huang@intel.com, 
	yosryahmed@google.com, yuzhao@google.com, ziy@nvidia.com, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Ryan Roberts <ryan.roberts@arm.com> =E4=BA=8E2024=E5=B9=B44=E6=9C=8812=E6=
=97=A5=E5=91=A8=E4=BA=94 19:28=E5=86=99=E9=81=93=EF=BC=9A
>
> On 12/04/2024 03:07, Chuanhua Han wrote:
> > Ryan Roberts <ryan.roberts@arm.com> =E4=BA=8E2024=E5=B9=B44=E6=9C=8811=
=E6=97=A5=E5=91=A8=E5=9B=9B 22:30=E5=86=99=E9=81=93=EF=BC=9A
> >>
> >> On 09/04/2024 09:26, Barry Song wrote:
> >>> From: Chuanhua Han <hanchuanhua@oppo.com>
> >>>
> >>> While swapping in a large folio, we need to free swaps related to the=
 whole
> >>> folio. To avoid frequently acquiring and releasing swap locks, it is =
better
> >>> to introduce an API for batched free.
> >>>
> >>> Signed-off-by: Chuanhua Han <hanchuanhua@oppo.com>
> >>> Co-developed-by: Barry Song <v-songbaohua@oppo.com>
> >>> Signed-off-by: Barry Song <v-songbaohua@oppo.com>
> >>
> >> Couple of nits; feel free to ignore.
> >>
> >> Reviewed-by: Ryan Roberts <ryan.roberts@arm.com>
> >>
> >>> ---
> >>>  include/linux/swap.h |  5 +++++
> >>>  mm/swapfile.c        | 51 ++++++++++++++++++++++++++++++++++++++++++=
++
> >>>  2 files changed, 56 insertions(+)
> >>>
> >>> diff --git a/include/linux/swap.h b/include/linux/swap.h
> >>> index 11c53692f65f..b7a107e983b8 100644
> >>> --- a/include/linux/swap.h
> >>> +++ b/include/linux/swap.h
> >>> @@ -483,6 +483,7 @@ extern void swap_shmem_alloc(swp_entry_t);
> >>>  extern int swap_duplicate(swp_entry_t);
> >>>  extern int swapcache_prepare(swp_entry_t);
> >>>  extern void swap_free(swp_entry_t);
> >>> +extern void swap_free_nr(swp_entry_t entry, int nr_pages);
> >>>  extern void swapcache_free_entries(swp_entry_t *entries, int n);
> >>>  extern void free_swap_and_cache_nr(swp_entry_t entry, int nr);
> >>>  int swap_type_of(dev_t device, sector_t offset);
> >>> @@ -564,6 +565,10 @@ static inline void swap_free(swp_entry_t swp)
> >>>  {
> >>>  }
> >>>
> >>> +void swap_free_nr(swp_entry_t entry, int nr_pages)
> >>> +{
> >>> +}
> >>> +
> >>>  static inline void put_swap_folio(struct folio *folio, swp_entry_t s=
wp)
> >>>  {
> >>>  }
> >>> diff --git a/mm/swapfile.c b/mm/swapfile.c
> >>> index 28642c188c93..f4c65aeb088d 100644
> >>> --- a/mm/swapfile.c
> >>> +++ b/mm/swapfile.c
> >>> @@ -1356,6 +1356,57 @@ void swap_free(swp_entry_t entry)
> >>>               __swap_entry_free(p, entry);
> >>>  }
> >>>
> >>> +/*
> >>> + * Free up the maximum number of swap entries at once to limit the
> >>> + * maximum kernel stack usage.
> >>> + */
> >>> +#define SWAP_BATCH_NR (SWAPFILE_CLUSTER > 512 ? 512 : SWAPFILE_CLUST=
ER)
> >>> +
> >>> +/*
> >>> + * Called after swapping in a large folio, batched free swap entries
> >>> + * for this large folio, entry should be for the first subpage and
> >>> + * its offset is aligned with nr_pages
> >>> + */
> >>> +void swap_free_nr(swp_entry_t entry, int nr_pages)
> >>> +{
> >>> +     int i, j;
> >>> +     struct swap_cluster_info *ci;
> >>> +     struct swap_info_struct *p;
> >>> +     unsigned int type =3D swp_type(entry);
> >>> +     unsigned long offset =3D swp_offset(entry);
> >>> +     int batch_nr, remain_nr;
> >>> +     DECLARE_BITMAP(usage, SWAP_BATCH_NR) =3D { 0 };
> >>> +
> >>> +     /* all swap entries are within a cluster for mTHP */
> >>> +     VM_BUG_ON(offset % SWAPFILE_CLUSTER + nr_pages > SWAPFILE_CLUST=
ER);
> >>> +
> >>> +     if (nr_pages =3D=3D 1) {
> >>> +             swap_free(entry);
> >>> +             return;
> >>> +     }
> >>> +
> >>> +     remain_nr =3D nr_pages;
> >>> +     p =3D _swap_info_get(entry);
> >>> +     if (p) {
> >>
> >> nit: perhaps return early if (!p) ? Then you dedent the for() block.
> >
> > Agreed!
> >
> >>
> >>> +             for (i =3D 0; i < nr_pages; i +=3D batch_nr) {
> >>> +                     batch_nr =3D min_t(int, SWAP_BATCH_NR, remain_n=
r);
> >>> +
> >>> +                     ci =3D lock_cluster_or_swap_info(p, offset);
> >>> +                     for (j =3D 0; j < batch_nr; j++) {
> >>> +                             if (__swap_entry_free_locked(p, offset =
+ i * SWAP_BATCH_NR + j, 1))
> >>> +                                     __bitmap_set(usage, j, 1);
> >>> +                     }
> >>> +                     unlock_cluster_or_swap_info(p, ci);
> >>> +
> >>> +                     for_each_clear_bit(j, usage, batch_nr)
> >>> +                             free_swap_slot(swp_entry(type, offset +=
 i * SWAP_BATCH_NR + j));
> >>> +
> >>
> >> nit: perhaps change to for (;;), and do the checks here to avoid clear=
ing the
> >> bitmap on the last run:
> >>
> >>                         i +=3D batch_nr;
> >>                         if (i < nr_pages)
> >>                                 break;
Should be=EF=BC=9A
if (i >=3D nr_pages)
    break;
> > Great, thank you for your advice!
>
> Or maybe leave the for() as is, but don't explicitly init the bitmap at t=
he
> start of the function and instead call:
>
>         bitmap_clear(usage, 0, SWAP_BATCH_NR);
>
> At the start of each loop?
Yeah, that's OK, actually these two ways are similar, both are to
reduce the number of bitmap_clear calls.
>
> >>
> >>> +                     bitmap_clear(usage, 0, SWAP_BATCH_NR);
> >>> +                     remain_nr -=3D batch_nr;
> >>> +             }
> >>> +     }
> >>> +}
> >>> +
> >>>  /*
> >>>   * Called after dropping swapcache to decrease refcnt to swap entrie=
s.
> >>>   */
> >>
> >>
> >
> >
>


--=20
Thanks,
Chuanhua

