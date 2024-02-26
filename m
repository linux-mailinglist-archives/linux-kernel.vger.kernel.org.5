Return-Path: <linux-kernel+bounces-80555-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D326986696F
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 05:47:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C60E7B20DC2
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 04:47:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0D4F1B270;
	Mon, 26 Feb 2024 04:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="clvAPpsZ"
Received: from mail-ua1-f45.google.com (mail-ua1-f45.google.com [209.85.222.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C690199DC
	for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 04:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708922836; cv=none; b=TLF4eObf4WdREXMo6YboVEZ7bfcRv35FZwLYviQdmXiwg2Bt4C9vzv+/j6XO5XRzQLPFCHi42YWHhKyKPDiP4yrIAdbLYQK32BOhSGdvjf6AgdL+BGfqMAb2Wpj2IXuh8OWlnC96PhH056hVvo/Gf8DU5YGV5Ep8ZWnrwgbBkMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708922836; c=relaxed/simple;
	bh=h66mOhPCChkpo61t8ShlWCzzwguwnP/TmYuf4I290bo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DQ0meKCvp6U/73AorlSbROmxF2yC0s4tmktAcVO4l198qWCRMQSnOxNZuRuPC69QFVlqVYUYEHeM3QK2tnXHj4tbNY2MPYH9y9fn6F5Bfl6e/m0T4v3ed8YootB0lwjXXgCKHMAOKEX2/wnsYBMMaSV/MsQayRLtY8GNIi/+kaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=clvAPpsZ; arc=none smtp.client-ip=209.85.222.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f45.google.com with SMTP id a1e0cc1a2514c-7d5bfdd2366so1420129241.3
        for <linux-kernel@vger.kernel.org>; Sun, 25 Feb 2024 20:47:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708922833; x=1709527633; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2evqKUntkKcx/ouxIcn5GSYuRU6W+/guAPwVvK2rp+k=;
        b=clvAPpsZPef2iLF+bggWEXoImGNa3+XBLFJCleM+brnjGFawf2hb+kXyr/ZZzc6wkI
         vwcQJgqTpY4v74NREAbHRfiNxLtlhoVaMeR71ROUfbHW15CxmUrgw0BYYwOeOK0TGVQP
         fw2LWSwOWBmOkL3oDX3H3AsGCCmbg3uV3cdXI5fd2ExWHX6Jdpzw8807k1L3Tw2Efrqb
         whdb6rZhRYsmlxs9ziENO3Yw49LfiJdDWGiQmFjSqc396L0q86B2bCi8xN5z7ksWzD44
         FDJsUIw89F2AMyIoAc45ltez5JfwZQsg3RQI5f2N7Nf48XOmCQnkAklcqSNBkkW0heZw
         z2dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708922833; x=1709527633;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2evqKUntkKcx/ouxIcn5GSYuRU6W+/guAPwVvK2rp+k=;
        b=V06tD9Red+lfMNiZC6HiUUCE14n6pUAIjNoZEc1j/QCePFd9VrjxiV+JcdU+Uhb33G
         RWEPWCTV82NfUzAr42HRZddOclVQ8rXl9bXq7TJZDhGsxhoWnXyZl/i+gVIYv8B2mcM4
         of/HRH+azIPiZln/9hMg9AUCoJEaiVA2FsP/p7ObVsVtSdWAq2IKR9DJVsW5PeX3oXVQ
         0CB3exM7vZAmfUxWocqq/SjEil0KaV1FXorMZoTtiV9/gGLkJKOKZzVIFC1BY0KgGdwo
         5m5lXe4/DqPlQrqMqTGtYRbd8jTPz1MKufnDU2NwBNAsY5mmcAohwBR/fSDft4usNBRL
         BtyA==
X-Forwarded-Encrypted: i=1; AJvYcCUMOezOw2lkC6fsiC5xVV9q6xLAa4ra4iXuJ/HCoG08k9Sd2Or8fiL6RzNCi0bfu5W4IwPkMHK11OH28VKd4nKPBv/8mH3obWC/IPoE
X-Gm-Message-State: AOJu0YwKGRNHOlus8wDC7JjGb9fwQ6rvlPHYHPWiXygIRu91zHM3f1wk
	/MIIFIqAj0QmZOtExTY1BOoSKgYcqXfbp7muATURw9a3BR5LjFaPGSI0GQJ4YONM/16kA7Qo1XQ
	FeuJJrfuNygzxQH+KkouRrwKvufU=
X-Google-Smtp-Source: AGHT+IHBXtSc0pPDmFFVyN84Q/468/d4r71tO8SRKVOSIw1NeJ246xlCPqVxqgcMScvdWgPsfh9m/Js7eusVj1RMiOg=
X-Received: by 2002:a1f:c402:0:b0:4cd:b55a:bb0d with SMTP id
 u2-20020a1fc402000000b004cdb55abb0dmr2466062vkf.2.1708922833135; Sun, 25 Feb
 2024 20:47:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231025144546.577640-1-ryan.roberts@arm.com> <20240118111036.72641-1-21cnbao@gmail.com>
 <20240118111036.72641-3-21cnbao@gmail.com> <CAF8kJuOPXyAxmmh9QO1SdU=8GWtMhPjaWgGtQ8gvnNyfbSZbig@mail.gmail.com>
In-Reply-To: <CAF8kJuOPXyAxmmh9QO1SdU=8GWtMhPjaWgGtQ8gvnNyfbSZbig@mail.gmail.com>
From: Barry Song <21cnbao@gmail.com>
Date: Mon, 26 Feb 2024 17:47:01 +1300
Message-ID: <CAGsJ_4x1n4jtOKB2FAw1GffpvXbTCBMnwH6QRQSguk-rar46fw@mail.gmail.com>
Subject: Re: [PATCH RFC 2/6] mm: swap: introduce swap_nr_free() for batched swap_free()
To: Chris Li <chrisl@kernel.org>
Cc: ryan.roberts@arm.com, akpm@linux-foundation.org, david@redhat.com, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, mhocko@suse.com, 
	shy828301@gmail.com, wangkefeng.wang@huawei.com, willy@infradead.org, 
	xiang@kernel.org, ying.huang@intel.com, yuzhao@google.com, surenb@google.com, 
	steven.price@arm.com, Chuanhua Han <hanchuanhua@oppo.com>, 
	Barry Song <v-songbaohua@oppo.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Chris,

Thanks!

On Sat, Jan 27, 2024 at 12:17=E2=80=AFPM Chris Li <chrisl@kernel.org> wrote=
:
>
> On Thu, Jan 18, 2024 at 3:11=E2=80=AFAM Barry Song <21cnbao@gmail.com> wr=
ote:
> >
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
> >  mm/swapfile.c        | 29 +++++++++++++++++++++++++++++
> >  2 files changed, 35 insertions(+)
> >
> > diff --git a/include/linux/swap.h b/include/linux/swap.h
> > index 4db00ddad261..31a4ee2dcd1c 100644
> > --- a/include/linux/swap.h
> > +++ b/include/linux/swap.h
> > @@ -478,6 +478,7 @@ extern void swap_shmem_alloc(swp_entry_t);
> >  extern int swap_duplicate(swp_entry_t);
> >  extern int swapcache_prepare(swp_entry_t);
> >  extern void swap_free(swp_entry_t);
> > +extern void swap_nr_free(swp_entry_t entry, int nr_pages);
> >  extern void swapcache_free_entries(swp_entry_t *entries, int n);
> >  extern int free_swap_and_cache(swp_entry_t);
> >  int swap_type_of(dev_t device, sector_t offset);
> > @@ -553,6 +554,11 @@ static inline void swap_free(swp_entry_t swp)
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
> > index 556ff7347d5f..6321bda96b77 100644
> > --- a/mm/swapfile.c
> > +++ b/mm/swapfile.c
> > @@ -1335,6 +1335,35 @@ void swap_free(swp_entry_t entry)
> >                 __swap_entry_free(p, entry);
> >  }
> >
> > +void swap_nr_free(swp_entry_t entry, int nr_pages)
> > +{
> > +       int i;
> > +       struct swap_cluster_info *ci;
> > +       struct swap_info_struct *p;
> > +       unsigned type =3D swp_type(entry);
> > +       unsigned long offset =3D swp_offset(entry);
> > +       DECLARE_BITMAP(usage, SWAPFILE_CLUSTER) =3D { 0 };
> > +
> > +       VM_BUG_ON(offset % SWAPFILE_CLUSTER + nr_pages > SWAPFILE_CLUST=
ER);
>
> BUG_ON here seems a bit too developer originated. Maybe warn once and
> roll back to free one by one?

The function is used only for the case we are quite sure we are freeing
some contiguous swap entries within a cluster. if it is not the case,
we will need an array of entries[]. will people be more comfortable to
have a WARN_ON instead? but the problem is if that really happens,
it is a bug, WARN isn't enough.

>
> How big is your typical SWAPFILE_CUSTER and nr_pages typically in arm?

My case is SWAPFILE_CLUSTER  =3D HPAGE_PMD_NR =3D 2MB/4KB =3D 512.

>
> I ask this question because nr_ppages > 64, that is a totally
> different game, we can completely  bypass the swap cache slots.
>

I agree we have a chance to bypass slot cache if nr_pages is bigger than
SWAP_SLOTS_CACHE_SIZE. on the other hand, even when nr_pages <
64, we still have a good chance to optimize free_swap_slot() by batching
as there are many spin_lock and sort() for each single entry.


> > +
> > +       if (nr_pages =3D=3D 1) {
> > +               swap_free(entry);
> > +               return;
> > +       }
> > +
> > +       p =3D _swap_info_get(entry);
> > +
> > +       ci =3D lock_cluster(p, offset);
> > +       for (i =3D 0; i < nr_pages; i++) {
> > +               if (__swap_entry_free_locked(p, offset + i, 1))
> > +                       __bitmap_set(usage, i, 1);
> > +       }
> > +       unlock_cluster(ci);
> > +
> > +       for_each_clear_bit(i, usage, nr_pages)
> > +               free_swap_slot(swp_entry(type, offset + i));
>
> Notice that free_swap_slot() internal has per CPU cache batching as
> well. Every free_swap_slot will get some per_cpu swap slot cache and
> cache->lock. There is double batching here.
> If the typical batch size here is bigger than 64 entries, we can go
> directly to batching swap_entry_free and avoid the free_swap_slot()
> batching altogether. Unlike free_swap_slot_entries(), here swap slots
> are all from one swap device, there is no need to sort and group the
> swap slot by swap devices.

I agree.  you are completely right!
However, to make the patchset smaller at the beginning, I prefer
these optimizations to be deferred as a separate patchset after this one.

>
> Chris
>
>
> Chris
>
> > +}
> > +
> >  /*
> >   * Called after dropping swapcache to decrease refcnt to swap entries.
> >   */
> > --
> > 2.34.1

Thanks
Barry

