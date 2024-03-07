Return-Path: <linux-kernel+bounces-95104-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7CE187493C
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 09:10:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EB6AC1C21299
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 08:10:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BAED63136;
	Thu,  7 Mar 2024 08:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I0+mFAfH"
Received: from mail-ua1-f52.google.com (mail-ua1-f52.google.com [209.85.222.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6730CA6B
	for <linux-kernel@vger.kernel.org>; Thu,  7 Mar 2024 08:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709799024; cv=none; b=Io8eVkL+FDBUT0WxUKrg2E7VAWAcLVAVYTGKWxgBl5eOtZKiHUm+mkruowIwikETNGaTRyUZYwTEcCc8++/pg97tqJAPZWWMQBOGyV3OzayQA4MAP9pJpA9Z/ETfIhyBfBZ6b+FCyP8LaOVCGF/vS5p7BQ3idP+hoHYeU+Yg0k4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709799024; c=relaxed/simple;
	bh=xaN7oz9uMpageX+H2Ks9h97t1DE+grVuncB39xcNR3I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FtlpEfFc8I1lyqXJeoukZYjdk/kwCr68Kd05ixh4y3x5qCkpbhCGiketYwQ0mdTCE6soLcruES6zDXyhaHbFMdSwhv8qr6noLS/WCGKbOVM4KjjcNC+N74SV8mpmE7bzcxJG0rpWgFiQDav2iZlw5BF0w+WRjYRj1IpCI7Q1zwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I0+mFAfH; arc=none smtp.client-ip=209.85.222.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f52.google.com with SMTP id a1e0cc1a2514c-7ce4512d308so400321241.1
        for <linux-kernel@vger.kernel.org>; Thu, 07 Mar 2024 00:10:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709799021; x=1710403821; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2AmHTTL6+wN1fLYHyk0rj2h2RNkxty2LDYDaC4IfuRE=;
        b=I0+mFAfHJOKugKtQgzWuoTkLVpzS+LQ1sebQzY76qBOJ/EpazOr1QYFslcLkmKfh71
         5KM/F+Gqkxk2W854B5Kf2eLmDMI7WDJlclx1udpALV7TdXBm0RdBS0HsTyk8YHcO8VJC
         Qtp+VFFA2muAXDLWZ8rdxH2hiC2RUKBajNfegVU23KbaXg6IEaHQE9nXhS4mD+ZGPcPW
         UNU3qvH6DwbLJqz9xqylsz63hokiCvpY4Uxli4XGtRjLtnTSW3FPlqfKCl1gQ2Vy9/xq
         P8VAtVxnB9MWclJ5lFIykB0hV3u0FcG8huMKlJrmuZDhLWFZL2OxS4dLIFtff6ZjeFiL
         4iUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709799021; x=1710403821;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2AmHTTL6+wN1fLYHyk0rj2h2RNkxty2LDYDaC4IfuRE=;
        b=PAcs2W6AElGqRXOd3FUUj3dAilUZ94RkF73RJ+q47k1whayRCz24/Zb7Aae2rwUieb
         n9vepyVKr5/X4cXd5nHVHQd6KXqojGJ/67YSW6rknOHa9Ajay8jIKocpsusXjRF6wvbZ
         BkfrwkSiFUBUSw+hIzR1qpPeG/5SikMZ0l8ovP9pTEutCyZYgtOcXpfWgQdSFLWQbTmX
         +5dJlzpnSRKd3//hGICI1dxkXk0cCf2I3b4SLqYCu0MUBZfDPfsaXaQgdFubkHOf6zaw
         OQQP7ju0KZo+r11546k7Jsrc1eW1RR7UqJZMj8I/touYrHt6PPrj340nO5O/vYjoxp93
         zxhw==
X-Forwarded-Encrypted: i=1; AJvYcCWQhtfaLZEzVjrJBRhabjCqtJSRwOsWtXyeal5OIoUNHjnkPKOySL7EcaaShyaiIv3ON4UGItYJODy7DiyCz9+0oBIXl6qjTCTADUHD
X-Gm-Message-State: AOJu0YxSqkFs++nEugK46jshlqLUr47TUhM1w4UzRIzTRmP3+AUpyylm
	GmjmvwU0WMSVIYO2o9S5EwYf3p84hSRyZnatDUuSNR5gDoRAgF2Xm94Eg4on2Jz5jm7ptfo/dqZ
	mhxlMiHmGOncHUrOanBmytguPBiU=
X-Google-Smtp-Source: AGHT+IHBd9M4Vewc9Pofp+DsTiYPu+tTGVg926af7ZK02t8baQJeg5Mn6oUyR1UvKrgVzKigkni/uZuO+nVKVLFBLkQ=
X-Received: by 2002:a67:ead6:0:b0:471:e02d:9eb1 with SMTP id
 s22-20020a67ead6000000b00471e02d9eb1mr260220vso.9.1709799021655; Thu, 07 Mar
 2024 00:10:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240307061425.21013-1-ioworker0@gmail.com> <CAGsJ_4xcRvZGdpPh1qcFTnTnDUbwz6WreQ=L_UO+oU2iFm9EPg@mail.gmail.com>
 <CAK1f24k2G_DSEjuqqqPyY0f7+btpYbjfoyMH7btLfP8nkasCTQ@mail.gmail.com>
In-Reply-To: <CAK1f24k2G_DSEjuqqqPyY0f7+btpYbjfoyMH7btLfP8nkasCTQ@mail.gmail.com>
From: Barry Song <21cnbao@gmail.com>
Date: Thu, 7 Mar 2024 21:10:10 +1300
Message-ID: <CAGsJ_4xREM-P1mFqeM-s3-cJ9czb6PXwizb-3hOhwaF6+QM5QA@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] mm/madvise: enhance lazyfreeing with mTHP in madvise_free
To: Lance Yang <ioworker0@gmail.com>, david@redhat.com, 
	Vishal Moola <vishal.moola@gmail.com>
Cc: akpm@linux-foundation.org, zokeefe@google.com, ryan.roberts@arm.com, 
	shy828301@gmail.com, mhocko@suse.com, fengwei.yin@intel.com, 
	xiehuan09@gmail.com, wangkefeng.wang@huawei.com, songmuchun@bytedance.com, 
	peterx@redhat.com, minchan@kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 7, 2024 at 9:00=E2=80=AFPM Lance Yang <ioworker0@gmail.com> wro=
te:
>
> Hey Barry,
>
> Thanks for taking time to review!
>
> On Thu, Mar 7, 2024 at 3:00=E2=80=AFPM Barry Song <21cnbao@gmail.com> wro=
te:
> >
> > On Thu, Mar 7, 2024 at 7:15=E2=80=AFPM Lance Yang <ioworker0@gmail.com>=
 wrote:
> > >
> [...]
> > > +static inline bool can_mark_large_folio_lazyfree(unsigned long addr,
> > > +                                                struct folio *folio,=
 pte_t *start_pte)
> > > +{
> > > +       int nr_pages =3D folio_nr_pages(folio);
> > > +       fpb_t flags =3D FPB_IGNORE_DIRTY | FPB_IGNORE_SOFT_DIRTY;
> > > +
> > > +       for (int i =3D 0; i < nr_pages; i++)
> > > +               if (page_mapcount(folio_page(folio, i)) !=3D 1)
> > > +                       return false;
> >
> > we have moved to folio_estimated_sharers though it is not precise, so
> > we don't do
> > this check with lots of loops and depending on the subpage's mapcount.
>
> If we don't check the subpage=E2=80=99s mapcount, and there is a cow foli=
o associated
> with this folio and the cow folio has smaller size than this folio,
> should we still
> mark this folio as lazyfree?

I agree, this is true. However, we've somehow accepted the fact that
folio_likely_mapped_shared
can result in false negatives or false positives to balance the
overhead.  So I really don't know :-)

Maybe David and Vishal can give some comments here.

>
> > BTW, do we need to rebase our work against David's changes[1]?
> > [1] https://lore.kernel.org/linux-mm/20240227201548.857831-1-david@redh=
at.com/
>
> Yes, we should rebase our work against David=E2=80=99s changes.
>
> >
> > > +
> > > +       return nr_pages =3D=3D folio_pte_batch(folio, addr, start_pte=
,
> > > +                                        ptep_get(start_pte), nr_page=
s, flags, NULL);
> > > +}
> > > +
> > >  static int madvise_free_pte_range(pmd_t *pmd, unsigned long addr,
> > >                                 unsigned long end, struct mm_walk *wa=
lk)
> > >
> > > @@ -676,11 +690,45 @@ static int madvise_free_pte_range(pmd_t *pmd, u=
nsigned long addr,
> > >                  */
> > >                 if (folio_test_large(folio)) {
> > >                         int err;
> > > +                       unsigned long next_addr, align;
> > >
> > > -                       if (folio_estimated_sharers(folio) !=3D 1)
> > > -                               break;
> > > -                       if (!folio_trylock(folio))
> > > -                               break;
> > > +                       if (folio_estimated_sharers(folio) !=3D 1 ||
> > > +                           !folio_trylock(folio))
> > > +                               goto skip_large_folio;
> >
> >
> > I don't think we can skip all the PTEs for nr_pages, as some of them mi=
ght be
> > pointing to other folios.
> >
> > for example, for a large folio with 16PTEs, you do MADV_DONTNEED(15-16)=
,
> > and write the memory of PTE15 and PTE16, you get page faults, thus PTE1=
5
> > and PTE16 will point to two different small folios. We can only skip wh=
en we
> > are sure nr_pages =3D=3D folio_pte_batch() is sure.
>
> Agreed. Thanks for pointing that out.
>
> >
> > > +
> > > +                       align =3D folio_nr_pages(folio) * PAGE_SIZE;
> > > +                       next_addr =3D ALIGN_DOWN(addr + align, align)=
;
> > > +
> > > +                       /*
> > > +                        * If we mark only the subpages as lazyfree, =
or
> > > +                        * cannot mark the entire large folio as lazy=
free,
> > > +                        * then just split it.
> > > +                        */
> > > +                       if (next_addr > end || next_addr - addr !=3D =
align ||
> > > +                           !can_mark_large_folio_lazyfree(addr, foli=
o, pte))
> > > +                               goto split_large_folio;
> > > +
> > > +                       /*
> > > +                        * Avoid unnecessary folio splitting if the l=
arge
> > > +                        * folio is entirely within the given range.
> > > +                        */
> > > +                       folio_clear_dirty(folio);
> > > +                       folio_unlock(folio);
> > > +                       for (; addr !=3D next_addr; pte++, addr +=3D =
PAGE_SIZE) {
> > > +                               ptent =3D ptep_get(pte);
> > > +                               if (pte_young(ptent) || pte_dirty(pte=
nt)) {
> > > +                                       ptent =3D ptep_get_and_clear_=
full(
> > > +                                               mm, addr, pte, tlb->f=
ullmm);
> > > +                                       ptent =3D pte_mkold(ptent);
> > > +                                       ptent =3D pte_mkclean(ptent);
> > > +                                       set_pte_at(mm, addr, pte, pte=
nt);
> > > +                                       tlb_remove_tlb_entry(tlb, pte=
, addr);
> > > +                               }
> >
> > Can we do this in batches? for a CONT-PTE mapped large folio, you are u=
nfolding
> > and folding again. It seems quite expensive.
>
> Thanks for your suggestion. I'll do this in batches in v3.
>
> Thanks again for your time!
>
> Best,
> Lance
>
> >
> > > +                       }
> > > +                       folio_mark_lazyfree(folio);
> > > +                       goto next_folio;
> > > +
> > > +split_large_folio:
> > >                         folio_get(folio);
> > >                         arch_leave_lazy_mmu_mode();
> > >                         pte_unmap_unlock(start_pte, ptl);
> > > @@ -688,13 +736,28 @@ static int madvise_free_pte_range(pmd_t *pmd, u=
nsigned long addr,
> > >                         err =3D split_folio(folio);
> > >                         folio_unlock(folio);
> > >                         folio_put(folio);
> > > -                       if (err)
> > > -                               break;
> > > -                       start_pte =3D pte =3D
> > > -                               pte_offset_map_lock(mm, pmd, addr, &p=
tl);
> > > -                       if (!start_pte)
> > > -                               break;
> > > -                       arch_enter_lazy_mmu_mode();
> > > +
> > > +                       /*
> > > +                        * If the large folio is locked or cannot be =
split,
> > > +                        * we just skip it.
> > > +                        */
> > > +                       if (err) {
> > > +skip_large_folio:
> > > +                               if (next_addr >=3D end)
> > > +                                       break;
> > > +                               pte +=3D (next_addr - addr) / PAGE_SI=
ZE;
> > > +                               addr =3D next_addr;
> > > +                       }
> > > +
> > > +                       if (!start_pte) {
> > > +                               start_pte =3D pte =3D pte_offset_map_=
lock(
> > > +                                       mm, pmd, addr, &ptl);
> > > +                               if (!start_pte)
> > > +                                       break;
> > > +                               arch_enter_lazy_mmu_mode();
> > > +                       }
> > > +
> > > +next_folio:
> > >                         pte--;
> > >                         addr -=3D PAGE_SIZE;
> > >                         continue;
> > > --
> > > 2.33.1
> > >

Thanks
Barry

