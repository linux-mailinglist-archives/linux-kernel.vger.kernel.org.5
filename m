Return-Path: <linux-kernel+bounces-49743-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 58432846EDF
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 12:23:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7D13D1C226C7
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 11:23:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE27A13D4E0;
	Fri,  2 Feb 2024 11:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kKjTR9tL"
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 866405C5E6
	for <linux-kernel@vger.kernel.org>; Fri,  2 Feb 2024 11:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706873008; cv=none; b=UQhAwholw8VQcA4dV3xy+gLzXODPtmltazWxvnkNnEV7NfZBk3H8vz0Jv5PQvLR3u0wOS/4qJhVoP3uN5BUmHF8YnpSbMwEoVsUSaz6gT/Nu4kBckMFckiXQrcn+AzPeNCR/CEHjjj7aLWv040vrni7ymgFhT+g2UEAJNLof5Xw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706873008; c=relaxed/simple;
	bh=hUN1VM5UDQkrAqzi8zSV71Ge5ARXZHbYNIWZQAH45Bc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CQMoT8uuoXLV58EpmlaVvWjoDAUnYjCu8sKBMPr3lgkqVtlsGRJTHXC3HlxSfmdHtTzqo6bdHgjvdO4NyCGePJMiz8a3zD13yu1h5mQCJN9NRkr1QGlPVq90GdCzuJhKPmKrLx+7HbAZNpChgec3ITo5BS+xoDEBlobVIABKV7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kKjTR9tL; arc=none smtp.client-ip=209.85.219.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-dc6d7e3b5bfso1669409276.2
        for <linux-kernel@vger.kernel.org>; Fri, 02 Feb 2024 03:23:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706873005; x=1707477805; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1KOce/rNIsOTa8oBL/B9soOdUTgL+D05JTqUDqwEEKQ=;
        b=kKjTR9tLD8d8xH3uqqJvfEw+ZFICDXsybF/3wmU354XlTNMCbjqYjCt7ginovL47bM
         J7EqA4l3xjXZ4R4ScCtHzqgI6d3Mwyrep7nalksWtsHl/1k2HEN5yw53ZcDayUl7fvhg
         5JhVedBaxSDN2bwOB3JQUh1YRUKx8uDmdQ4aryUoiSVifVgjwQ8G8gQ1cXeVx1PsM8cs
         9Kar3EEEG/pnnz3F4XzBuewq5Mm31RHBZrnCkf2e//fLISsUSJzim4o+uMVT7VTK6ZJZ
         4tu16A4rXbduDEmRN/l1G6cKZbbliuUVLVvcwsndycXF6ksRdNGLIhgCxb4riOVuxTzu
         siWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706873005; x=1707477805;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1KOce/rNIsOTa8oBL/B9soOdUTgL+D05JTqUDqwEEKQ=;
        b=ecXnPkEkqWQtnGNZfmgW84mRlzHnvgc0zeNrVd1/TghwFridjbPqQofiUS1zOrr8Tb
         QdFavVCTYVy7OcWycjRiEtmRm520rswDaVjpHVEaKbxjo+5gJPAoBUO0yD3VkUyU85mr
         q9GOhnfeYHEYZPDRTU8zUO1IGWLSpBF2eExZqZKioK9uB66uZwEd7qbfU2jxrYZk9rwt
         FRQQE1i9lpxADPNIiCSm7KSxhZk/2TS0Wcpz+jnH5NfplELlYtANnHhRZ2LliQN3EFlH
         L4VqcIffYrzj2kACrev/MX8A0RwmTBp2TZqsABoS3A4UhxCeoDlXnyQWwUBLOIDKqll5
         olBw==
X-Gm-Message-State: AOJu0YxROYlsJzYEaGYh33+oO5IELqgDfq6HzFaQy9bcMfMlQKWLZ/te
	H+JGR4UchU7dcaVkJ0k1WasL79tD7qt0ifGebKLcLMsrGZA8ThNsj+zAepDUywyENgqVOrl+WIb
	75GBAXGCyBWPtXnsXXpDfUGF1gaM=
X-Google-Smtp-Source: AGHT+IHotxU7Do/mwe8RBQy1Prt/LOpJsoznYZjdpK0c3L9GAPq7bxWrCVRBtGU0P75D9YdnsJX1NAf4Zh044Th6W+4=
X-Received: by 2002:a25:aaed:0:b0:dc6:a5e1:3a05 with SMTP id
 t100-20020a25aaed000000b00dc6a5e13a05mr5181665ybi.14.1706873005389; Fri, 02
 Feb 2024 03:23:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240201125226.28372-1-ioworker0@gmail.com> <CAHbLzkqUyYy67Fp6Zv2oeGyawHZuHqkiDGruivcRMcCGj6a-_A@mail.gmail.com>
In-Reply-To: <CAHbLzkqUyYy67Fp6Zv2oeGyawHZuHqkiDGruivcRMcCGj6a-_A@mail.gmail.com>
From: Lance Yang <ioworker0@gmail.com>
Date: Fri, 2 Feb 2024 19:23:13 +0800
Message-ID: <CAK1f24ng_+rFd0Z5TiuZ86QUtso_09g5ksZ+p8Va+m-tK85JoQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] mm/khugepaged: skip copying lazyfree pages on collapse
To: Yang Shi <shy828301@gmail.com>
Cc: akpm@linux-foundation.org, mhocko@suse.com, zokeefe@google.com, 
	david@redhat.com, songmuchun@bytedance.com, peterx@redhat.com, 
	minchan@kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 2, 2024 at 4:37=E2=80=AFAM Yang Shi <shy828301@gmail.com> wrote=
:
>
> On Thu, Feb 1, 2024 at 4:53=E2=80=AFAM Lance Yang <ioworker0@gmail.com> w=
rote:
> >
> > The collapsing behavior of khugepaged with pages
> > marked using MADV_FREE might cause confusion
> > among users.
> >
> > For instance, allocate a 2MB chunk using mmap and
> > later release it by MADV_FREE. Khugepaged will not
> > collapse this chunk. From the user's perspective,
> > it treats lazyfree pages as pte_none. However,
> > for some pages marked as lazyfree with MADV_FREE,
> > khugepaged might collapse this chunk and copy
> > these pages to a new huge page. This inconsistency
> > in behavior could be confusing for users.
> >
> > After a successful MADV_FREE operation, if there is
> > no subsequent write, the kernel can free the pages
> > at any time. Therefore, in my opinion, counting
> > lazyfree pages in max_pte_none seems reasonable.
> >
> > Perhaps treating MADV_FREE like MADV_DONTNEED, not
> > copying lazyfree pages when khugepaged collapses
> > huge pages in the background better aligns with
> > user expectations.
> >
> > Signed-off-by: Lance Yang <ioworker0@gmail.com>
> > ---
> >  mm/khugepaged.c | 10 +++++++++-
> >  1 file changed, 9 insertions(+), 1 deletion(-)
> >
> > diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> > index 2b219acb528e..6cbf46d42c6a 100644
> > --- a/mm/khugepaged.c
> > +++ b/mm/khugepaged.c
> > @@ -777,6 +777,7 @@ static int __collapse_huge_page_copy(pte_t *pte,
> >                                      pmd_t orig_pmd,
> >                                      struct vm_area_struct *vma,
> >                                      unsigned long address,
> > +                                    struct collapse_control *cc,
> >                                      spinlock_t *ptl,
> >                                      struct list_head *compound_pagelis=
t)
> >  {
> > @@ -797,6 +798,13 @@ static int __collapse_huge_page_copy(pte_t *pte,
> >                         continue;
> >                 }
> >                 src_page =3D pte_page(pteval);
> > +
> > +               if (cc->is_khugepaged
> > +                               && !folio_test_swapbacked(page_folio(sr=
c_page))) {
> > +                       clear_user_highpage(page, _address);
> > +                       continue;
>
> If the page was written before khugepaged collapsed it, and khugepaged
> collapsed the page before memory reclaim kicked in, didn't this
> somehow cause data corruption?
>

Thanks a lot! Yang, you're correct; indeed, there is
a potential issue with data corruption.

I took a look at the check for lazyfree pages in
smaps_pte_entry.

Here's the modification:
if (cc->is_khugepaged && !PageSwapBacked(src_page)
        && !pte_dirty(pteval) && !PageDirty(src_page)) {
        clear_user_highpage(page, _address);
        continue;
}

Could you please take a look?

Thanks,
Lance

> > +               }
> > +
> >                 if (copy_mc_user_highpage(page, src_page, _address, vma=
) > 0) {
> >                         result =3D SCAN_COPY_MC;
> >                         break;
> > @@ -1205,7 +1213,7 @@ static int collapse_huge_page(struct mm_struct *m=
m, unsigned long address,
> >         anon_vma_unlock_write(vma->anon_vma);
> >
> >         result =3D __collapse_huge_page_copy(pte, hpage, pmd, _pmd,
> > -                                          vma, address, pte_ptl,
> > +                                          vma, address, cc, pte_ptl,
> >                                            &compound_pagelist);
> >         pte_unmap(pte);
> >         if (unlikely(result !=3D SCAN_SUCCEED))
> > --
> > 2.33.1
> >

