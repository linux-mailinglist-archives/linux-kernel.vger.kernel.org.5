Return-Path: <linux-kernel+bounces-159463-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FDA78B2EEC
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 05:28:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4FB45284713
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 03:28:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A3B3763F7;
	Fri, 26 Apr 2024 03:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gkNsjSu4"
Received: from mail-vk1-f171.google.com (mail-vk1-f171.google.com [209.85.221.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C45C617FF
	for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 03:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714102117; cv=none; b=I12mDbU+5sFCdfiMOw5DLRLWQDBdU6j1n5MJE9Hu1tWrlQ8Bv+i4eF7S+wrow+2gDpXt22mBFaZPcvBDUlKraSRb+bgRzw4+1j0cU3tTJ9uSdx7sCPXtRofUfvc7AvPWsELpaClsezQfznR3wU3ULD0F7w7RMP6SuCw8fFevds0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714102117; c=relaxed/simple;
	bh=VYhhBchJTr5KyucGYEtHNfSJQ7QKp37QoCKoqzZ4yQ8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OzzjXCa0OM17zyZy9H2qRbz3yaAzJe8Wy+NmlRiJ6Kw7r+bqb27HNIyuyhlrHq8u4EEI+FAmzFZDByxC8MW7oh6Yy59gbv4GD2We8HXmPhxK2+AunHTGpL397PpNfzdy5LjcJUXpt7AMc/UXwxelngccVSWrJbJgCBpNb0ZUzrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gkNsjSu4; arc=none smtp.client-ip=209.85.221.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f171.google.com with SMTP id 71dfb90a1353d-4dcf9659603so448345e0c.2
        for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 20:28:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714102114; x=1714706914; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CyHxC41lHfusFiTgDcGJmDgmhY96MrkI4VAWat9lk0A=;
        b=gkNsjSu46CdCoMuf94xBclnlK9nazPEC5zT2ArkD4gMoLIdZaSXR2DeTxHTvmNDZsn
         8cmE4UW6KOwnIcdEIQki+W0Irpl3vSAR2k+PFpMdrAVx0/W6QQZUAAJ1a1VrK4Cxb/ln
         liCfIpvfiVnbUBuEdDO6gw+TG7bTWYTvYh/EM4HmoFLFh6k5gTJDcemT8A4+gazkCYRM
         DhQARK/cMMab3QxS6Ath+DHJmbhOhs4PSiBf6udyJYS0upuiHpnxAbIneUVX2sd1QLdK
         dDFQrwOvQek5oU2fKucDeLfZa5Sd7QIEydDSeTC4IIWh/Kx0PzfXvTzORbzbN+LotB7o
         fTJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714102114; x=1714706914;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CyHxC41lHfusFiTgDcGJmDgmhY96MrkI4VAWat9lk0A=;
        b=kEPsdehPYXstqXtJ9qnvnRyx7JOS8CdDLItWMehLdUCpSVdhjVKa9nJbnHcSKzFuKm
         fdkSxn9jeDjM0LbOY98Ly/94m4HUgHmJqPeerWgXcXX5TbUXpm8U5HRHbkBY7TbNT/FQ
         bgapYf8Pxbin05+v6C2CEEuDqSGlEFtz7kRJLTgDMYeanyC1ScfrfC5++d/PPPUPZDTy
         bh88SUr2ST/Sf4ha0X4VF2OrmKVTC+QwrqlKDdqZNuMndD767cBERdu7GNitfxSnz9hO
         khxnEIhXXNb06p2OScMrEopSnQ6fER3FSZyNobGwxhxYkggYZrQdRaGWH/6qkr4+9AwF
         RZig==
X-Forwarded-Encrypted: i=1; AJvYcCXEihIWccNBvPCBPxdcm26ZH4g9otTaJLDUin9mIP5rqu1W8CLMGmyihxFKqtbdVrIXFlQ4jYCSMxfiJFL/g2/entFSE7xELgL60SCJ
X-Gm-Message-State: AOJu0YznUbxfm5HmvqyF4RjsCi0N0iH9xmlviqDLzWN8dGpIcaLuCNeo
	KIxVp0uAoesEqzWdwXu6lyY5ix2Sy2+2B9qeiP8orqllC5+Kw6n/FDYyZwZSfMyyDOxJ34ruzjm
	+VSTzpQKulFU2aj5reyLb2vHhmys=
X-Google-Smtp-Source: AGHT+IHHV9qmt/bnW4eu4JuN4hMYG1Vu/q/MSh/GsaDPNA2tdn/uecOBpGwt+YPK2O0cHKjTnBIqVgI8Ku77KnE4XGY=
X-Received: by 2002:a05:6122:3d15:b0:4d4:126b:2c8 with SMTP id
 ga21-20020a0561223d1500b004d4126b02c8mr1537871vkb.9.1714102114546; Thu, 25
 Apr 2024 20:28:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240425211136.486184-1-zi.yan@sent.com> <CAGsJ_4wa0LskQkoZf9r5bG5+wEkyfCYveMBSTbuDe0=t1QetTg@mail.gmail.com>
 <6C31DF81-94FB-4D09-A3B8-0CED2AD8EDDB@nvidia.com> <CAGsJ_4xzb8RrEuPEbnvR4GbDWuoGCYL4FsC3TObOifAZ4CHGOA@mail.gmail.com>
 <730660D2-E1BA-4A2E-B99C-2F160F9D9A9B@nvidia.com>
In-Reply-To: <730660D2-E1BA-4A2E-B99C-2F160F9D9A9B@nvidia.com>
From: Barry Song <21cnbao@gmail.com>
Date: Fri, 26 Apr 2024 11:28:23 +0800
Message-ID: <CAGsJ_4yNSKdft-G=4X2Dr5HJ-axh-8SohGW7nkUfTYrsNFr9_Q@mail.gmail.com>
Subject: Re: [PATCH v4] mm/rmap: do not add fully unmapped large folio to
 deferred split list
To: Zi Yan <ziy@nvidia.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, 
	"Matthew Wilcox (Oracle)" <willy@infradead.org>, Yang Shi <shy828301@gmail.com>, 
	Ryan Roberts <ryan.roberts@arm.com>, David Hildenbrand <david@redhat.com>, 
	Lance Yang <ioworker0@gmail.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 26, 2024 at 10:50=E2=80=AFAM Zi Yan <ziy@nvidia.com> wrote:
>
> On 25 Apr 2024, at 22:23, Barry Song wrote:
>
> > On Fri, Apr 26, 2024 at 9:55=E2=80=AFAM Zi Yan <ziy@nvidia.com> wrote:
> >>
> >> On 25 Apr 2024, at 21:45, Barry Song wrote:
> >>
> >>> On Fri, Apr 26, 2024 at 5:11=E2=80=AFAM Zi Yan <zi.yan@sent.com> wrot=
e:
> >>>>
> >>>> From: Zi Yan <ziy@nvidia.com>
> >>>>
> >>>> In __folio_remove_rmap(), a large folio is added to deferred split l=
ist
> >>>> if any page in a folio loses its final mapping. But it is possible t=
hat
> >>>> the folio is fully unmapped and adding it to deferred split list is
> >>>> unnecessary.
> >>>>
> >>>> For PMD-mapped THPs, that was not really an issue, because removing =
the
> >>>> last PMD mapping in the absence of PTE mappings would not have added=
 the
> >>>> folio to the deferred split queue.
> >>>>
> >>>> However, for PTE-mapped THPs, which are now more prominent due to mT=
HP,
> >>>> they are always added to the deferred split queue. One side effect
> >>>> is that the THP_DEFERRED_SPLIT_PAGE stat for a PTE-mapped folio can =
be
> >>>> unintentionally increased, making it look like there are many partia=
lly
> >>>> mapped folios -- although the whole folio is fully unmapped stepwise=
.
> >>>>
> >>>> Core-mm now tries batch-unmapping consecutive PTEs of PTE-mapped THP=
s
> >>>> where possible starting from commit b06dc281aa99 ("mm/rmap: introduc=
e
> >>>> folio_remove_rmap_[pte|ptes|pmd]()"). When it happens, a whole PTE-m=
apped
> >>>> folio is unmapped in one go and can avoid being added to deferred sp=
lit
> >>>> list, reducing the THP_DEFERRED_SPLIT_PAGE noise. But there will sti=
ll be
> >>>> noise when we cannot batch-unmap a complete PTE-mapped folio in one =
go
> >>>> -- or where this type of batching is not implemented yet, e.g., migr=
ation.
> >>>>
> >>>> To avoid the unnecessary addition, folio->_nr_pages_mapped is checke=
d
> >>>> to tell if the whole folio is unmapped. If the folio is already on
> >>>> deferred split list, it will be skipped, too.
> >>>>
> >>>> Note: commit 98046944a159 ("mm: huge_memory: add the missing
> >>>> folio_test_pmd_mappable() for THP split statistics") tried to exclud=
e
> >>>> mTHP deferred split stats from THP_DEFERRED_SPLIT_PAGE, but it does =
not
> >>>> fix the above issue. A fully unmapped PTE-mapped order-9 THP was sti=
ll
> >>>> added to deferred split list and counted as THP_DEFERRED_SPLIT_PAGE,
> >>>> since nr is 512 (non zero), level is RMAP_LEVEL_PTE, and inside
> >>>> deferred_split_folio() the order-9 folio is folio_test_pmd_mappable(=
).
> >>>>
> >>>> Signed-off-by: Zi Yan <ziy@nvidia.com>
> >>>> Reviewed-by: Yang Shi <shy828301@gmail.com>
> >>>> ---
> >>>>  mm/rmap.c | 8 +++++---
> >>>>  1 file changed, 5 insertions(+), 3 deletions(-)
> >>>>
> >>>> diff --git a/mm/rmap.c b/mm/rmap.c
> >>>> index a7913a454028..220ad8a83589 100644
> >>>> --- a/mm/rmap.c
> >>>> +++ b/mm/rmap.c
> >>>> @@ -1553,9 +1553,11 @@ static __always_inline void __folio_remove_rm=
ap(struct folio *folio,
> >>>>                  * page of the folio is unmapped and at least one pa=
ge
> >>>>                  * is still mapped.
> >>>>                  */
> >>>> -               if (folio_test_large(folio) && folio_test_anon(folio=
))
> >>>> -                       if (level =3D=3D RMAP_LEVEL_PTE || nr < nr_p=
mdmapped)
> >>>> -                               deferred_split_folio(folio);
> >>>> +               if (folio_test_large(folio) && folio_test_anon(folio=
) &&
> >>>> +                   list_empty(&folio->_deferred_list) &&
> >>>> +                   ((level =3D=3D RMAP_LEVEL_PTE && atomic_read(map=
ped)) ||
> >>>> +                    (level =3D=3D RMAP_LEVEL_PMD && nr < nr_pmdmapp=
ed)))
> >>>> +                       deferred_split_folio(folio);
> >>>
> >>> Hi Zi Yan,
> >>> in case a mTHP is mapped by two processed (forked but not CoW yet), i=
f we
> >>> unmap the whole folio by pte level in one process only, are we still =
adding this
> >>> folio into deferred list?
> >>
> >> No. Because the mTHP is still fully mapped by the other process. In te=
rms of code,
> >> nr will be 0 in that case and this if condition is skipped. nr is only=
 increased
> >> from 0 when one of the subpages in the mTHP has no mapping, namely pag=
e->_mapcount
> >> becomes negative and last is true in the case RMAP_LEVEL_PTE.
> >
> > Ok. i see, so "last" won't be true?
> >
> > case RMAP_LEVEL_PTE:
> > do {
> > last =3D atomic_add_negative(-1, &page->_mapcount);
> >    if (last && folio_test_large(folio)) {
> >        last =3D atomic_dec_return_relaxed(mapped);
> >        last =3D (last < ENTIRELY_MAPPED);
> > }
> >
> > if (last)
> >      nr++;
> > } while (page++, --nr_pages > 0);
> > break;
>
> Right, because for every subpage its corresponding
> last =3D atomic_add_negative(-1, &page->_mapcount); is not true after the=
 unmapping.2

if a mTHP is mapped only by one process, and we unmap it entirely, we will
get nr > 0, then we are executing adding it into deferred_list? so it seems
atomic_read(mapped) is preventing this case from adding deferred_list?

I wonder if  it is possible to fixup nr to 0 from the first place?
for example
/* we are doing an entire unmapping */
if (page=3D=3D&folio->page && nr_pages =3D=3D  folio_nr_pages(folio))
..

>
>
> --
> Best Regards,
> Yan, Zi

