Return-Path: <linux-kernel+bounces-43804-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DDDB88418FE
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 03:21:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4C1191F222FF
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 02:21:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 712ED364C6;
	Tue, 30 Jan 2024 02:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gJw4hoZQ"
Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com [209.85.219.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19AF5364BE
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 02:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706581276; cv=none; b=GDai6fn6k9sxcHP0z8KWVxFsUHFUsWxcY98RBWzxxE4mQ1UVs8kE8wFOWFBoGlXPQQXbYGyYb4dsf50014a/q94PVrl7ntKoQt9L8Mc7M3s7QHx+64PbDjG/UBe+4J0TIpOod3reAHyRZpq+NqqeOcT0DkMlrrxaGYq5R7+mksY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706581276; c=relaxed/simple;
	bh=MUQAOvrbAp0fEVzj2B/cPGawpmUwfk6DPhQbUpZGMO8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PbtErIm3oAo0NsYRG1LnaBW67ZtPfuF/1BEwQk4MjSrc4XXAqYmbD+X1Pl/G7nLPlJw1xyuKDioxlq8UPPOkjZ0Ng4GQwvbKwg6Gez7FgVO0ZEOZIZG7WYQfFr/KRnx7AaOLekcueEiPE5wn0cdLakwISlF3R70Ofggbvf2NMPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gJw4hoZQ; arc=none smtp.client-ip=209.85.219.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-d9b9adaf291so3098160276.1
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 18:21:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706581274; x=1707186074; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SqvvkgNcia++P3J4vObWaZUkkmBWvOpjfl4ds6Ix2cQ=;
        b=gJw4hoZQMRDNhWeDvrCQ5LoUCbfCx0f0Tv7WbZ0OcyueKXyp7pUntZjVO7kiuBoO4Y
         UNZtUTwQxC/n4n06dBcrUZxdOLwlcDsxYA2SGYxxrzsJGyZpLa7Bekc4TUpZPekF7qU6
         VZGG8JDWQpDf1mpZLknoFWvwBlGozbNuiVHB/WB8iQfCWG2yiZonPaPGlEtVOTntL5zK
         1+MqYqThO+qjP/M/HZTP0TeaWTb/7x+UcLm82IxOVfLJ24yA4jk6y27k8abAoS1g8X+6
         R7WX7D4xCvBNiFcWEqFWQvzlOYEuOO+p8aoPI5brJUp0hZKSHvx5wUnEravyk1fINCAF
         r9Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706581274; x=1707186074;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SqvvkgNcia++P3J4vObWaZUkkmBWvOpjfl4ds6Ix2cQ=;
        b=LbLOD44LZy0hoy88bVGN4b9Ay/POQtlevqglb0fQaLeed3GLL514NnuwgqKQ5j7YQ5
         ftVOaAAj66wP9Tn+SUe0jA5TrJZSrdjMZujboEst2ec/9Q9VjhtLergXjw76/z5gAdqj
         RrqJpF5NRkuRWidmmKRh0mfL/ssm/F6mFnYNDBDlpgnTSWWq6/quprNSO7Fd3dh5PNBj
         e3ROFTGimyXbWuHKJrgIC40bK2aFSJb4S7IsKyevHfk2Cw+S5Z8jEiDTARDWFhZve7Rf
         vb09gv8Ww4xoBeYrb6xw53W9qfU8T4ICA2wh5fFXUZmZ4FYwqtMk3etgbc/bIjj3E6+0
         rKhw==
X-Gm-Message-State: AOJu0YyG2xvNZJMTCxXeI6jny0TbtgmcgXAFTI485GgnQ5XdLRhQ7gh8
	F8Y7ggglYK5PdKsxlqSjO+mr8kN60FsFUWGgcS2Cyqd91GQzCXT2UhYKcg0e6yfL08h8iU+SKMm
	VngZAPwb+TPuhMMkjFvadZwyjOaE=
X-Google-Smtp-Source: AGHT+IGPUm2g3mX53rCNExa6/35IeYTMYeLrmrsnYIT9kHR/YEO91YNEXMJovx3BPc4Dn2EWGw+mQS97dvaKkzoOGFg=
X-Received: by 2002:a05:6902:218a:b0:dc3:696f:167e with SMTP id
 dl10-20020a056902218a00b00dc3696f167emr3985908ybb.64.1706581273948; Mon, 29
 Jan 2024 18:21:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240129054551.57728-1-ioworker0@gmail.com> <CAHbLzkqrTPZD_Fz_a5LYa49Tum_Za=J9dX_SRyTr=kVZA26RAg@mail.gmail.com>
In-Reply-To: <CAHbLzkqrTPZD_Fz_a5LYa49Tum_Za=J9dX_SRyTr=kVZA26RAg@mail.gmail.com>
From: Lance Yang <ioworker0@gmail.com>
Date: Tue, 30 Jan 2024 10:21:00 +0800
Message-ID: <CAK1f24m=KBZnG1acd5dp+A+8F3DXXvAHK4W8+8Kr3f6w3bTzLQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] mm/khugepaged: bypassing unnecessary scans with
 MMF_DISABLE_THP check
To: Yang Shi <shy828301@gmail.com>
Cc: akpm@linux-foundation.org, mhocko@suse.com, zokeefe@google.com, 
	david@redhat.com, songmuchun@bytedance.com, peterx@redhat.com, 
	minchan@kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hey Yang,

Thanks for taking time to review!

thp_vma_allowable_order and hugepage_vma_revalidate
do check whether MMF_DISABLE_THP is set. IIRC, even if
MMF_DISABLE_THP is set, khugepaged will still continue to
scan the address space.

BR,
Lance

On Tue, Jan 30, 2024 at 2:53=E2=80=AFAM Yang Shi <shy828301@gmail.com> wrot=
e:
>
> On Sun, Jan 28, 2024 at 9:46=E2=80=AFPM Lance Yang <ioworker0@gmail.com> =
wrote:
> >
> > khugepaged scans the entire address space in the
> > background for each given mm, looking for
> > opportunities to merge sequences of basic pages
> > into huge pages. However, when an mm is inserted
> > to the mm_slots list, and the MMF_DISABLE_THP flag
> > is set later, this scanning process becomes
> > unnecessary for that mm and can be skipped to avoid
> > redundant operations, especially in scenarios with
> > a large address space.
> >
> > This commit introduces a check before each scanning
> > process to test the MMF_DISABLE_THP flag for the
> > given mm; if the flag is set, the scanning process
> > is bypassed, thereby improving the efficiency of
> > khugepaged.
> >
> > Signed-off-by: Lance Yang <ioworker0@gmail.com>
> > ---
> >  mm/khugepaged.c | 18 ++++++++++++------
> >  1 file changed, 12 insertions(+), 6 deletions(-)
> >
> > diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> > index 2b219acb528e..d6a700834edc 100644
> > --- a/mm/khugepaged.c
> > +++ b/mm/khugepaged.c
> > @@ -410,6 +410,12 @@ static inline int hpage_collapse_test_exit(struct =
mm_struct *mm)
> >         return atomic_read(&mm->mm_users) =3D=3D 0;
> >  }
> >
> > +static inline int hpage_collapse_test_exit_or_disable(struct mm_struct=
 *mm)
> > +{
> > +       return hpage_collapse_test_exit(mm) ||
> > +              test_bit(MMF_DISABLE_THP, &mm->flags);
> > +}
> > +
> >  void __khugepaged_enter(struct mm_struct *mm)
> >  {
> >         struct khugepaged_mm_slot *mm_slot;
> > @@ -1422,7 +1428,7 @@ static void collect_mm_slot(struct khugepaged_mm_=
slot *mm_slot)
> >
> >         lockdep_assert_held(&khugepaged_mm_lock);
> >
> > -       if (hpage_collapse_test_exit(mm)) {
> > +       if (hpage_collapse_test_exit_or_disable(mm)) {
> >                 /* free mm_slot */
> >                 hash_del(&slot->hash);
> >                 list_del(&slot->mm_node);
> > @@ -2360,7 +2366,7 @@ static unsigned int khugepaged_scan_mm_slot(unsig=
ned int pages, int *result,
> >                 goto breakouterloop_mmap_lock;
> >
> >         progress++;
> > -       if (unlikely(hpage_collapse_test_exit(mm)))
> > +       if (unlikely(hpage_collapse_test_exit_or_disable(mm)))
> >                 goto breakouterloop;
> >
> >         vma_iter_init(&vmi, mm, khugepaged_scan.address);
> > @@ -2368,7 +2374,7 @@ static unsigned int khugepaged_scan_mm_slot(unsig=
ned int pages, int *result,
> >                 unsigned long hstart, hend;
> >
> >                 cond_resched();
> > -               if (unlikely(hpage_collapse_test_exit(mm))) {
> > +               if (unlikely(hpage_collapse_test_exit_or_disable(mm))) =
{
>
> The later thp_vma_allowable_order() does check whether MMF_DISABLE_THP
> is set or not. And the hugepage_vma_revalidate() after re-acquiring
> mmap_lock does the same check too. The checking in khugepaged should
> be already serialized with prctl, which takes mmap_lock in write.
>
> >                         progress++;
> >                         break;
> >                 }
> > @@ -2390,7 +2396,7 @@ static unsigned int khugepaged_scan_mm_slot(unsig=
ned int pages, int *result,
> >                         bool mmap_locked =3D true;
> >
> >                         cond_resched();
> > -                       if (unlikely(hpage_collapse_test_exit(mm)))
> > +                       if (unlikely(hpage_collapse_test_exit_or_disabl=
e(mm)))
> >                                 goto breakouterloop;
> >
> >                         VM_BUG_ON(khugepaged_scan.address < hstart ||
> > @@ -2408,7 +2414,7 @@ static unsigned int khugepaged_scan_mm_slot(unsig=
ned int pages, int *result,
> >                                 fput(file);
> >                                 if (*result =3D=3D SCAN_PTE_MAPPED_HUGE=
PAGE) {
> >                                         mmap_read_lock(mm);
> > -                                       if (hpage_collapse_test_exit(mm=
))
> > +                                       if (hpage_collapse_test_exit_or=
_disable(mm))
> >                                                 goto breakouterloop;
> >                                         *result =3D collapse_pte_mapped=
_thp(mm,
> >                                                 khugepaged_scan.address=
, false);
> > @@ -2450,7 +2456,7 @@ static unsigned int khugepaged_scan_mm_slot(unsig=
ned int pages, int *result,
> >          * Release the current mm_slot if this mm is about to die, or
> >          * if we scanned all vmas of this mm.
> >          */
> > -       if (hpage_collapse_test_exit(mm) || !vma) {
> > +       if (hpage_collapse_test_exit_or_disable(mm) || !vma) {
> >                 /*
> >                  * Make sure that if mm_users is reaching zero while
> >                  * khugepaged runs here, khugepaged_exit will find
> > --
> > 2.33.1
> >

