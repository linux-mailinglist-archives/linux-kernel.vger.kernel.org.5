Return-Path: <linux-kernel+bounces-43387-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF85C8412FE
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 20:04:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D968D1C21CDC
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 19:04:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93C3424B57;
	Mon, 29 Jan 2024 19:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dYW1B646"
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF73612E74
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 19:04:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706555060; cv=none; b=PuBatM3mPTGlXvSkVVmH2uBSVfm6gyHUelZiwV7V6EEyLlbRuyzwl72j+zyMBPCnWPFFk3/sagAqkr0e5qfuZ1PMspqgodg/EvcyWn9IJo3Pu/B8WI6jUBrdL8rcKsoCBWLzdF6Q3qw3mPOIlmJMhvkrXubDy50btoWwcJbS9OM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706555060; c=relaxed/simple;
	bh=D2A65xlzvVR1A52XKFkjlczqVzemZuNQk4n9NwCjFEM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jDSqcCvG5bDKZ4dLIDpKqFzfQ+6YqRSZYb+qVB6Dao5vXfyku+VVt52Lj4AYzzmqxKeGn6UXf6HlkeATrn7Noe3UCMogrcDZ+AC6SaU695gisJgWMgXX038/Qt/kcz3PkyBL3V6CrMTnVpOKj0JXL4ZAD/h9heQXpBWIpT+ZgS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dYW1B646; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-55eda7c5bffso1355a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 11:04:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706555057; x=1707159857; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zfk63n86B5JSqicAWX9Q/j/lAYaF2C1u83gX8kyOotg=;
        b=dYW1B646Lb4yPhSsv7OWEwsFzwSHecBOGb36+Cf/AbCBQs10X8Zf9X6sEPzLxhWJAe
         HFkBcq3C4Af4AjiTfAjivvYvq1W3nPSFrv8JjkFeGAlh4H85gk0B2c4Jq4YRQ4al8Vyr
         IGEJvScf/b2neh57plwaWG8c5mC0n3/zrNDi1DIljOJBet+nky7HxSvzrUZT91rqHkSQ
         X7b2dBPXxXesVQSThRjBXn/ZMrJ8+fmMW6iCay2Fn6sNUIDNfxEWMpAKtxFufc8Svp7q
         TLGg8msoUYLH+BaR9pOswkRMsl/Q3gqvejd8OYnbOSvH9LOCNLVfY0Kb+TuOr24UbRQ7
         hpPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706555057; x=1707159857;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Zfk63n86B5JSqicAWX9Q/j/lAYaF2C1u83gX8kyOotg=;
        b=fouNuBJumR6ol59rdzndUPhF/OkNinOy9vs13JQRegIaN86EsmFvd1V9iPTFBP6Q81
         97t3T5a5iDbyujCgPLg5IsZnVri2TdudnpANb3m8WDm9GLqIyS381LnKtS7TASPRPuuk
         PK46RpuYHUsyrwFULe9TMtrH3mlIbM+HWo7k0vZogczNXeIkME9Fka/2JGGAnEdP2EMg
         4/fpzsfpZ9D/RHGg7dqn7JXE0zxqTdkgDqcY+Aa2Dn5t9BO3yAipZaq5gmzAfFB02nd/
         RiSusfEsnfLd9u6EZs0ydzq6sVzDhR9djj73D1PvA9q0yTZrlFcSOTdSzLkZS+evbqOn
         KUlw==
X-Gm-Message-State: AOJu0Ywa4oH6Mt//Soql5H6RuYt7iofIDd14jo4u332Wo7eQiF2Rk8E8
	qNbK8umQMm0PkhW0KPdvjbMJxJA5eZ9pa5wVdqZzw+vAs42D6T1PRio9egiM8938V7IajiR85xt
	FTXU2vhoMstXb5HnXr+DDofGsbAkia7wuLqf9
X-Google-Smtp-Source: AGHT+IEvbaU/dgjjI1icFJRHFIY5hi4PapHDFTvsY7KqHsSoeG7OlrWxGUjRRkk4L9vrUQjZbK4MODRkMXA+gD+Yutw=
X-Received: by 2002:a05:6402:37a:b0:55f:368:246f with SMTP id
 s26-20020a056402037a00b0055f0368246fmr10881edw.4.1706555056885; Mon, 29 Jan
 2024 11:04:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240129054551.57728-1-ioworker0@gmail.com> <CAHbLzkqrTPZD_Fz_a5LYa49Tum_Za=J9dX_SRyTr=kVZA26RAg@mail.gmail.com>
In-Reply-To: <CAHbLzkqrTPZD_Fz_a5LYa49Tum_Za=J9dX_SRyTr=kVZA26RAg@mail.gmail.com>
From: "Zach O'Keefe" <zokeefe@google.com>
Date: Mon, 29 Jan 2024 11:03:40 -0800
Message-ID: <CAAa6QmSSKFjzdG62MZ5bSrhP19AjPEr339WXaWY=OCLsGWVE8w@mail.gmail.com>
Subject: Re: [PATCH 1/1] mm/khugepaged: bypassing unnecessary scans with
 MMF_DISABLE_THP check
To: Yang Shi <shy828301@gmail.com>
Cc: Lance Yang <ioworker0@gmail.com>, akpm@linux-foundation.org, mhocko@suse.com, 
	david@redhat.com, songmuchun@bytedance.com, peterx@redhat.com, 
	minchan@kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 29, 2024 at 10:53=E2=80=AFAM Yang Shi <shy828301@gmail.com> wro=
te:
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

IIUC, there really isn't any correctness race. Claim is just that we
can avoid a number of per-vma checks. AFAICT, any task w/
MMF_DISABLE_THP set will always have each and every vma checked
(albeit, with a very inexpensive ->vm_mm->flags check)

Thanks,
Zach

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

