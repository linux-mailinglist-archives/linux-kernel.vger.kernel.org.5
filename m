Return-Path: <linux-kernel+bounces-50258-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C79584767B
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 18:45:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 12B4E1F282C3
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 17:45:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50DF814533A;
	Fri,  2 Feb 2024 17:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cbNCcnlE"
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA4D814C5B1
	for <linux-kernel@vger.kernel.org>; Fri,  2 Feb 2024 17:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706895824; cv=none; b=goHIcpta59MgK1i7dp14kjuNEu2ekeKoMoL1/+nsFBPOjgEtIk246Ahwjmw+FkO8Xn5KvknLcZbwGvnx3eJhu+3gQzJbCGdYz4DwjF/bvKR3jQRd9Fw/NQMGxlK2u832hRjH8IS7gkR9+fg0Zyp8f8kNe/G/eDCCDaNTLuLSuxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706895824; c=relaxed/simple;
	bh=7REJ4jrwPqak64PynFh64FPAUTHUyGKZE4FczsKPRrA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TGhF/KJJeZb1C0kFgHE7ygZBzunGF1bSWvR+SJapo4Jloc5kN+ZSnHoaDLSCio36ZkXR2n83UMyl+6R3MldCqhYVe7Q5xrx5q13TZ4RUuGfc/8pODBTNgq1f+jtkgIVzS5N+E3Bm29cEM0gAbhQwHvQdY6Xid1t5JrqYTdRZgHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cbNCcnlE; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-5c66b093b86so2628043a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 02 Feb 2024 09:43:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706895822; x=1707500622; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ohf58qwHS9OfZsVTPFlr5rG9ibb3sy6+1zmgublylac=;
        b=cbNCcnlEtAUFS7+CreIICejTgx3fyzcNKWqdilSlHbG5ptyYpZuzrxSGerL7+kzO5+
         kp9Q1cQ8X6PQ6OoiWGEXVggYfrKVa44AcyKialuyU0WSZ1Ns+tA+swBBxITXS3dk4ZKi
         xTojDjR4Uw0dhKe1rFdpKgGV2m+sMAYm0TaXleXX02uMyjtEFnLUOToQ9lFFSVok8mHe
         WHJGruErBJqDugR6AG+D6thsh1FfFCBkJD8WjzthALSt6KJGQEdShuwe0hmfgKq1BdnW
         Og99TZYZa2AmswpzHmYs3cxdQ29BkO7of96KzZ9gtoUfeJKTgxQDu/3b1t059K4tcn7c
         6evA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706895822; x=1707500622;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ohf58qwHS9OfZsVTPFlr5rG9ibb3sy6+1zmgublylac=;
        b=fGaUCWUXCZK9MPjXrP8bCd2reELNTQHOrVTZ209RBw7o7Suu/0Lfy3L0IT+x0TGIvz
         gEkNpe4EPBVTVvY1/6vGQF6GAL5WpNzIAjYkMZC2Hs1QOmD2R2N7hUTEeM9k4xdAP/cw
         rV/lrvrBe5cpsIA/DckpJpbSO97jUs8mnTcaqIEznU3yo65XC6tgXo/4sN19KR53Z0Kb
         xHJNP6QNLVJ4wYOIbsuyTAbSu7Gj6OzdEuWpxd666NZG7pPRnZDln8gSBAd7bXu2yKnf
         w1SpeITP0VB6A1UgSAfn6bkjpNtAJMr3/JKmvLlbRuKDmn+wIS49BTUH0Mn8deuH1jos
         FDLg==
X-Gm-Message-State: AOJu0YzOVSKG/zflg+ODD+1w+kV2Tm8+F0hJIaj2zNbFeHiL8ofNLtVR
	Sp3dDIUWRpC9pNo+1+N2FsH6Di8cto+hBfEOCWU4VvxFM5RUiZzvdgoetH9P7/ETtC5w9u8WjdO
	UVfvXXO6qvPUxM+uSMEebq+b/dro=
X-Google-Smtp-Source: AGHT+IE4dSolelQjrgNHfq12kZYEQAarNzx/Bs7uqLuBqre6ETpVv4o6KY8ZcgJ5g9LNnxIU7cuyNvR0jq9o/hS83mY=
X-Received: by 2002:a05:6a21:3945:b0:19e:4f3e:5b5f with SMTP id
 ac5-20020a056a21394500b0019e4f3e5b5fmr3383511pzc.9.1706895822096; Fri, 02 Feb
 2024 09:43:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240201125226.28372-1-ioworker0@gmail.com> <CAHbLzkqUyYy67Fp6Zv2oeGyawHZuHqkiDGruivcRMcCGj6a-_A@mail.gmail.com>
 <CAK1f24ng_+rFd0Z5TiuZ86QUtso_09g5ksZ+p8Va+m-tK85JoQ@mail.gmail.com>
In-Reply-To: <CAK1f24ng_+rFd0Z5TiuZ86QUtso_09g5ksZ+p8Va+m-tK85JoQ@mail.gmail.com>
From: Yang Shi <shy828301@gmail.com>
Date: Fri, 2 Feb 2024 09:43:30 -0800
Message-ID: <CAHbLzkq=7Z9PQFHOWnrbcS0YWexw40OSHbfQCNqV5+9gsDnYEQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] mm/khugepaged: skip copying lazyfree pages on collapse
To: Lance Yang <ioworker0@gmail.com>
Cc: akpm@linux-foundation.org, mhocko@suse.com, zokeefe@google.com, 
	david@redhat.com, songmuchun@bytedance.com, peterx@redhat.com, 
	minchan@kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 2, 2024 at 3:23=E2=80=AFAM Lance Yang <ioworker0@gmail.com> wro=
te:
>
> On Fri, Feb 2, 2024 at 4:37=E2=80=AFAM Yang Shi <shy828301@gmail.com> wro=
te:
> >
> > On Thu, Feb 1, 2024 at 4:53=E2=80=AFAM Lance Yang <ioworker0@gmail.com>=
 wrote:
> > >
> > > The collapsing behavior of khugepaged with pages
> > > marked using MADV_FREE might cause confusion
> > > among users.
> > >
> > > For instance, allocate a 2MB chunk using mmap and
> > > later release it by MADV_FREE. Khugepaged will not
> > > collapse this chunk. From the user's perspective,
> > > it treats lazyfree pages as pte_none. However,
> > > for some pages marked as lazyfree with MADV_FREE,
> > > khugepaged might collapse this chunk and copy
> > > these pages to a new huge page. This inconsistency
> > > in behavior could be confusing for users.
> > >
> > > After a successful MADV_FREE operation, if there is
> > > no subsequent write, the kernel can free the pages
> > > at any time. Therefore, in my opinion, counting
> > > lazyfree pages in max_pte_none seems reasonable.
> > >
> > > Perhaps treating MADV_FREE like MADV_DONTNEED, not
> > > copying lazyfree pages when khugepaged collapses
> > > huge pages in the background better aligns with
> > > user expectations.
> > >
> > > Signed-off-by: Lance Yang <ioworker0@gmail.com>
> > > ---
> > >  mm/khugepaged.c | 10 +++++++++-
> > >  1 file changed, 9 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> > > index 2b219acb528e..6cbf46d42c6a 100644
> > > --- a/mm/khugepaged.c
> > > +++ b/mm/khugepaged.c
> > > @@ -777,6 +777,7 @@ static int __collapse_huge_page_copy(pte_t *pte,
> > >                                      pmd_t orig_pmd,
> > >                                      struct vm_area_struct *vma,
> > >                                      unsigned long address,
> > > +                                    struct collapse_control *cc,
> > >                                      spinlock_t *ptl,
> > >                                      struct list_head *compound_pagel=
ist)
> > >  {
> > > @@ -797,6 +798,13 @@ static int __collapse_huge_page_copy(pte_t *pte,
> > >                         continue;
> > >                 }
> > >                 src_page =3D pte_page(pteval);
> > > +
> > > +               if (cc->is_khugepaged
> > > +                               && !folio_test_swapbacked(page_folio(=
src_page))) {
> > > +                       clear_user_highpage(page, _address);
> > > +                       continue;
> >
> > If the page was written before khugepaged collapsed it, and khugepaged
> > collapsed the page before memory reclaim kicked in, didn't this
> > somehow cause data corruption?
> >
>
> Thanks a lot! Yang, you're correct; indeed, there is
> a potential issue with data corruption.
>
> I took a look at the check for lazyfree pages in
> smaps_pte_entry.
>
> Here's the modification:
> if (cc->is_khugepaged && !PageSwapBacked(src_page)
>         && !pte_dirty(pteval) && !PageDirty(src_page)) {
>         clear_user_highpage(page, _address);
>         continue;
> }

This may be ok. But as I said in another reply, this may still incur
data corruption.

>
> Could you please take a look?
>
> Thanks,
> Lance
>
> > > +               }
> > > +
> > >                 if (copy_mc_user_highpage(page, src_page, _address, v=
ma) > 0) {
> > >                         result =3D SCAN_COPY_MC;
> > >                         break;
> > > @@ -1205,7 +1213,7 @@ static int collapse_huge_page(struct mm_struct =
*mm, unsigned long address,
> > >         anon_vma_unlock_write(vma->anon_vma);
> > >
> > >         result =3D __collapse_huge_page_copy(pte, hpage, pmd, _pmd,
> > > -                                          vma, address, pte_ptl,
> > > +                                          vma, address, cc, pte_ptl,
> > >                                            &compound_pagelist);
> > >         pte_unmap(pte);
> > >         if (unlikely(result !=3D SCAN_SUCCEED))
> > > --
> > > 2.33.1
> > >

