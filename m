Return-Path: <linux-kernel+bounces-159475-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FBC88B2F0B
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 05:36:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 35E291C224D2
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 03:36:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0216078C7B;
	Fri, 26 Apr 2024 03:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T1ex67mM"
Received: from mail-vs1-f50.google.com (mail-vs1-f50.google.com [209.85.217.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93AAB78C79
	for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 03:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714102593; cv=none; b=SxGkBfwvNe6YfDrQvyQxi/ya7kSlOgwVsiSRQczn8x/sRnUAIvWjNd//jkmBjiIzb2DzmshIPTNdPfV6gWpy1R9Ro46lwfqtZ9/fgu9syt6JInYCTyTrh8X0qf9pGGEOA4SQNSf0dNwqwFp8tjrhJWxXVSUUH6xRYYHrgF9uBuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714102593; c=relaxed/simple;
	bh=SqSvQgPWYxdY5VXn1hEObSGNDU1mSfebYd11vYn2TC4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hbl2VmBvzbjsUBXOMq2N9Y7TfkSBGsO7Y5eey73fmbSNY9bY0oQn9VTIqYEWq7l8z4d/6q/csEX53H5JUmKDAfatB8xR3Z0zhHsUmUWJO7aAs6bpZFnpEGC0HEmpqoo8dQJ7pqGybYHUdfoRBvjIzFT1Q+STEfrLDKuFpfMdPJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T1ex67mM; arc=none smtp.client-ip=209.85.217.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f50.google.com with SMTP id ada2fe7eead31-479ccc89792so837637137.0
        for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 20:36:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714102590; x=1714707390; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5mP63EtOiQrtP2MNkkQ3dOJIbcfxN3+tIBhU95IFWp8=;
        b=T1ex67mMchJlrXQGXuRyscOHyx3xMqPfmEZhn1CDvqPNL6wMkLwDBETgCvT9iOdnye
         NRsPuuihcEZuC5znALntNwGRw/SK6nhdAE1IE4Il7sjBb3muk4uRWPiWQAj4AI1jhbpq
         JhrC1+duybF2L6yUemV6fg/W8ewPLKRUpVHHe0KO7CAPTB5ayMpDU9/xYAOJ70NPjTPZ
         f5wlyRsrYHBRuub4Vg+HaEs89nC7zmIdrkyVeqPeifEHDitGhfA+JT++ZYTqxY8Gy0kU
         6vMdwKQiWb3+Qyr1XGn/YB0EIdvuHFBhd2dDVTABIDOA/MHHQXFLHJmXfWeKCv1EY5Aa
         Tc6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714102590; x=1714707390;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5mP63EtOiQrtP2MNkkQ3dOJIbcfxN3+tIBhU95IFWp8=;
        b=eenTornNUcnqRfDPYUqevFnPDmXx6qdt7KHyA74HSylodWPKLCWIQPcK1Bf7PD5tVh
         dkdgQ8Ip58y+hNVaOpufBd39Di/pFJY1gb03EL7Z7wjD3usP41aP2E3q8l3E0kM+Rg8o
         00jrwrF1Y9WgJLx5SJFmSLslNwoBX50wFkQX1+ksT3X6FpNulYnJKpLTosSIxC2jkfPv
         4nIB18p+TvMgP15bYcj66xe0/498eX0cT4wyroZmVKPEA8ZhKz1haxTKv+HceHX8UOaS
         W+9bRwpnxo+68HoJ/uEGzMVX9P6sw4Nx6ShlxB1khUzT/6NCbK6HgSfNcOrzK9n0hY6h
         YYUA==
X-Forwarded-Encrypted: i=1; AJvYcCUr40Zq7stZhflWVz9eoGHV6PvT1iP0VU62h8M5HzeINAWKOPtTj/XyXEYyDVNRrsAXY2bYmbxBO2MgiADRB+6KNVMaOE5ENl723hQu
X-Gm-Message-State: AOJu0YxlrpzZtxQnshZaTHPj2V/0Z0DxKP6fwkxUvfqaQIYrHW1ftTbr
	Dv75Xx6Tc2HbqrBZ3kUBLa5UHdqTkp4hCFGUv094Hkf+duBMyO2WgjoCCUDkG1/df+arxcXd3GY
	P9VmtnUDjO9lfEYmC58ZDvmSNKyk=
X-Google-Smtp-Source: AGHT+IECArRcUa1EoPD0EghSu9ojG36h4iSussPZ7fZe7AnYJYdpG6Y1zeJEaKJWxP+XRNNLYz6hD9u/mJqSgq/YR9A=
X-Received: by 2002:a05:6102:2ac4:b0:47c:22df:95a3 with SMTP id
 eh4-20020a0561022ac400b0047c22df95a3mr1992284vsb.2.1714102590468; Thu, 25 Apr
 2024 20:36:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240425211136.486184-1-zi.yan@sent.com> <CAGsJ_4wa0LskQkoZf9r5bG5+wEkyfCYveMBSTbuDe0=t1QetTg@mail.gmail.com>
 <6C31DF81-94FB-4D09-A3B8-0CED2AD8EDDB@nvidia.com> <CAGsJ_4xzb8RrEuPEbnvR4GbDWuoGCYL4FsC3TObOifAZ4CHGOA@mail.gmail.com>
 <730660D2-E1BA-4A2E-B99C-2F160F9D9A9B@nvidia.com> <CAGsJ_4yNSKdft-G=4X2Dr5HJ-axh-8SohGW7nkUfTYrsNFr9_Q@mail.gmail.com>
In-Reply-To: <CAGsJ_4yNSKdft-G=4X2Dr5HJ-axh-8SohGW7nkUfTYrsNFr9_Q@mail.gmail.com>
From: Barry Song <21cnbao@gmail.com>
Date: Fri, 26 Apr 2024 11:36:19 +0800
Message-ID: <CAGsJ_4wkDOvwru9pGLHUu_NPzwatX2UyizXKALicJ8qY2UXqHQ@mail.gmail.com>
Subject: Re: [PATCH v4] mm/rmap: do not add fully unmapped large folio to
 deferred split list
To: Zi Yan <ziy@nvidia.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, 
	"Matthew Wilcox (Oracle)" <willy@infradead.org>, Yang Shi <shy828301@gmail.com>, 
	Ryan Roberts <ryan.roberts@arm.com>, David Hildenbrand <david@redhat.com>, 
	Lance Yang <ioworker0@gmail.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 26, 2024 at 11:28=E2=80=AFAM Barry Song <21cnbao@gmail.com> wro=
te:
>
> On Fri, Apr 26, 2024 at 10:50=E2=80=AFAM Zi Yan <ziy@nvidia.com> wrote:
> >
> > On 25 Apr 2024, at 22:23, Barry Song wrote:
> >
> > > On Fri, Apr 26, 2024 at 9:55=E2=80=AFAM Zi Yan <ziy@nvidia.com> wrote=
:
> > >>
> > >> On 25 Apr 2024, at 21:45, Barry Song wrote:
> > >>
> > >>> On Fri, Apr 26, 2024 at 5:11=E2=80=AFAM Zi Yan <zi.yan@sent.com> wr=
ote:
> > >>>>
> > >>>> From: Zi Yan <ziy@nvidia.com>
> > >>>>
> > >>>> In __folio_remove_rmap(), a large folio is added to deferred split=
 list
> > >>>> if any page in a folio loses its final mapping. But it is possible=
 that
> > >>>> the folio is fully unmapped and adding it to deferred split list i=
s
> > >>>> unnecessary.
> > >>>>
> > >>>> For PMD-mapped THPs, that was not really an issue, because removin=
g the
> > >>>> last PMD mapping in the absence of PTE mappings would not have add=
ed the
> > >>>> folio to the deferred split queue.
> > >>>>
> > >>>> However, for PTE-mapped THPs, which are now more prominent due to =
mTHP,
> > >>>> they are always added to the deferred split queue. One side effect
> > >>>> is that the THP_DEFERRED_SPLIT_PAGE stat for a PTE-mapped folio ca=
n be
> > >>>> unintentionally increased, making it look like there are many part=
ially
> > >>>> mapped folios -- although the whole folio is fully unmapped stepwi=
se.
> > >>>>
> > >>>> Core-mm now tries batch-unmapping consecutive PTEs of PTE-mapped T=
HPs
> > >>>> where possible starting from commit b06dc281aa99 ("mm/rmap: introd=
uce
> > >>>> folio_remove_rmap_[pte|ptes|pmd]()"). When it happens, a whole PTE=
-mapped
> > >>>> folio is unmapped in one go and can avoid being added to deferred =
split
> > >>>> list, reducing the THP_DEFERRED_SPLIT_PAGE noise. But there will s=
till be
> > >>>> noise when we cannot batch-unmap a complete PTE-mapped folio in on=
e go
> > >>>> -- or where this type of batching is not implemented yet, e.g., mi=
gration.
> > >>>>
> > >>>> To avoid the unnecessary addition, folio->_nr_pages_mapped is chec=
ked
> > >>>> to tell if the whole folio is unmapped. If the folio is already on
> > >>>> deferred split list, it will be skipped, too.
> > >>>>
> > >>>> Note: commit 98046944a159 ("mm: huge_memory: add the missing
> > >>>> folio_test_pmd_mappable() for THP split statistics") tried to excl=
ude
> > >>>> mTHP deferred split stats from THP_DEFERRED_SPLIT_PAGE, but it doe=
s not
> > >>>> fix the above issue. A fully unmapped PTE-mapped order-9 THP was s=
till
> > >>>> added to deferred split list and counted as THP_DEFERRED_SPLIT_PAG=
E,
> > >>>> since nr is 512 (non zero), level is RMAP_LEVEL_PTE, and inside
> > >>>> deferred_split_folio() the order-9 folio is folio_test_pmd_mappabl=
e().
> > >>>>
> > >>>> Signed-off-by: Zi Yan <ziy@nvidia.com>
> > >>>> Reviewed-by: Yang Shi <shy828301@gmail.com>
> > >>>> ---
> > >>>>  mm/rmap.c | 8 +++++---
> > >>>>  1 file changed, 5 insertions(+), 3 deletions(-)
> > >>>>
> > >>>> diff --git a/mm/rmap.c b/mm/rmap.c
> > >>>> index a7913a454028..220ad8a83589 100644
> > >>>> --- a/mm/rmap.c
> > >>>> +++ b/mm/rmap.c
> > >>>> @@ -1553,9 +1553,11 @@ static __always_inline void __folio_remove_=
rmap(struct folio *folio,
> > >>>>                  * page of the folio is unmapped and at least one =
page
> > >>>>                  * is still mapped.
> > >>>>                  */
> > >>>> -               if (folio_test_large(folio) && folio_test_anon(fol=
io))
> > >>>> -                       if (level =3D=3D RMAP_LEVEL_PTE || nr < nr=
_pmdmapped)
> > >>>> -                               deferred_split_folio(folio);
> > >>>> +               if (folio_test_large(folio) && folio_test_anon(fol=
io) &&
> > >>>> +                   list_empty(&folio->_deferred_list) &&
> > >>>> +                   ((level =3D=3D RMAP_LEVEL_PTE && atomic_read(m=
apped)) ||
> > >>>> +                    (level =3D=3D RMAP_LEVEL_PMD && nr < nr_pmdma=
pped)))
> > >>>> +                       deferred_split_folio(folio);
> > >>>
> > >>> Hi Zi Yan,
> > >>> in case a mTHP is mapped by two processed (forked but not CoW yet),=
 if we
> > >>> unmap the whole folio by pte level in one process only, are we stil=
l adding this
> > >>> folio into deferred list?
> > >>
> > >> No. Because the mTHP is still fully mapped by the other process. In =
terms of code,
> > >> nr will be 0 in that case and this if condition is skipped. nr is on=
ly increased
> > >> from 0 when one of the subpages in the mTHP has no mapping, namely p=
age->_mapcount
> > >> becomes negative and last is true in the case RMAP_LEVEL_PTE.
> > >
> > > Ok. i see, so "last" won't be true?
> > >
> > > case RMAP_LEVEL_PTE:
> > > do {
> > > last =3D atomic_add_negative(-1, &page->_mapcount);
> > >    if (last && folio_test_large(folio)) {
> > >        last =3D atomic_dec_return_relaxed(mapped);
> > >        last =3D (last < ENTIRELY_MAPPED);
> > > }
> > >
> > > if (last)
> > >      nr++;
> > > } while (page++, --nr_pages > 0);
> > > break;
> >
> > Right, because for every subpage its corresponding
> > last =3D atomic_add_negative(-1, &page->_mapcount); is not true after t=
he unmapping.2
>
> if a mTHP is mapped only by one process, and we unmap it entirely, we wil=
l
> get nr > 0, then we are executing adding it into deferred_list? so it see=
ms
> atomic_read(mapped) is preventing this case from adding deferred_list?
>
> I wonder if  it is possible to fixup nr to 0 from the first place?
> for example
> /* we are doing an entire unmapping */
> if (page=3D=3D&folio->page && nr_pages =3D=3D  folio_nr_pages(folio))

or maybe
 case RMAP_LEVEL_PTE:
..
+ if (!atomic_read(mapped))
+     nr =3D 0;
break;

> ...
>
> >
> >
> > --
> > Best Regards,
> > Yan, Zi

