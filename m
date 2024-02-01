Return-Path: <linux-kernel+bounces-47488-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A9503844E87
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 02:15:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E0F39B2CA9E
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 01:15:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 469236ADE;
	Thu,  1 Feb 2024 01:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lO3vHBh/"
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 805793FDB
	for <linux-kernel@vger.kernel.org>; Thu,  1 Feb 2024 01:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706749997; cv=none; b=lulSl2YIvHi7EyX7yUw8LPs9NvSkKO6O6hsGo0OL1O8ZAygWNF3ypQo5FPyaL7/jtoTc8YuT+D7i4B+kzZkCvVFkItE4Cu6tLDtwN2kxu8WJoGy/uCdrTQ9Sk+CUi5Bg09e4dszN1Oh1WfLNFmcMwatnwA9dAAiQwwmDJwN9Wm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706749997; c=relaxed/simple;
	bh=oZliER3IeF6JR3KFG9HV9w9b8UCLARiIQIygHLzMaS4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sopwyhyG7yfuZ7/zOzwafAhNGTcYAj7252Yuq1VmxmUcwHH5UxW45eHAA6wMItewghPsIUAr5sb7j00RGWmNB2EInh1MbgnyDvTgECb5O/qz9tEPCcgvF4cfomUBU1Q6h3MkIeBGTUE5KswbHfkBX2OkKDwWNsqmP5sbXsHPuS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lO3vHBh/; arc=none smtp.client-ip=209.85.219.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-db3a09e96daso382867276.3
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 17:13:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706749994; x=1707354794; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qu7TDXtuEwstu87+FhD80qzBfPypdOeZfjOo4stpT1Q=;
        b=lO3vHBh/o3t8rW0iNv9AWjHOwtZ8DmP1C72cPx34843myRyoEqj0CxA80lkDr6eE8V
         6+CgXZnEQSYx08hr8C0A3fiaI2cEXUSAdFJKpsYHcLkOJostiU1Ee47NTM1GbzPKau3i
         LMbBLc1LqeEsFeTSqw2cIJ+kVad13i4AhsptLSFRZAyMFM9Y6hW+u377Q1xCGvfS6nrP
         ELeoj55FbpF7dsiT+045x44PguWgJAnBmedsL+0LwJjL/EJr+8qKUzT7lxHcm9WMH2e5
         n3tMHeU2khZ0xwoQAjDdCFxAFCQF3nfNeSeggLjVo8WmeUapkouf7y0EQSNt74WdGWru
         +mmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706749994; x=1707354794;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Qu7TDXtuEwstu87+FhD80qzBfPypdOeZfjOo4stpT1Q=;
        b=bLbREGEPkNVGpZok68HhLnL/2uWNLntoiiqmJROp2ky7x7ZkMHuEv8T23X9nedMnDl
         4CEaeix3hXjMsGqSS5C0jVFJVDhBdT6FnTO9BWIDaCcgO38Du70VMUDiJhb4RIRTdmXj
         u0LFPQIAJqUFKxsiC7wotOYKZE9wWUjPzTD/znFaiwZl6+eLDukAZz2FZWupB+v6eMXg
         kIjRYD/iB8nfuuy8aLNROpJHwV5agoRtbvDlJ08fsYyXGB1DJphBlDfDUrIo5mf+lw2D
         fdPUPXq2ANAFRMq6JhcNu7cY5rO21nSc+C9qe0EZaMpDMtw9VNx8VhwwUGa9emR79OtR
         Lj2Q==
X-Gm-Message-State: AOJu0YxQQwkWNlcpt5qhpUSVhFtaF4S2fynKPFvT5tApYeP9x7aL7ak1
	mghX20C8+1fj2vX2RjKNOa4IaYnOJ8ccn4b0bKWjFeAwgSypwG41miSt/bFqlnDoy5SU8eXGWVi
	FmQ+k+sJ+W1/QA8itD3aiQ5UjdOM=
X-Google-Smtp-Source: AGHT+IHKXWWgiAZ1Zxbnc6MHAENf3squcjzzsB7r34ZiDW9mV7Z8OQBfmEKGxRYn9SgkJ/ST47X+yq4KhYlngFm2Awk=
X-Received: by 2002:a25:41d0:0:b0:dc2:5573:42df with SMTP id
 o199-20020a2541d0000000b00dc2557342dfmr3496260yba.25.1706749994147; Wed, 31
 Jan 2024 17:13:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240129054551.57728-1-ioworker0@gmail.com> <CAK1f24keWtJNVv37r2vNsqnmMLRMvF-F76WR5RD_Y-BbAgEaYQ@mail.gmail.com>
 <CAHbLzkodfgkf4vYXFL0R89+tDawAfH9_XPbv3z4-w+hAysZkGQ@mail.gmail.com>
In-Reply-To: <CAHbLzkodfgkf4vYXFL0R89+tDawAfH9_XPbv3z4-w+hAysZkGQ@mail.gmail.com>
From: Lance Yang <ioworker0@gmail.com>
Date: Thu, 1 Feb 2024 09:13:02 +0800
Message-ID: <CAK1f24=O34609mYcfyOhRAtei0Rag5EqJ1jX1kbqFhMTJxU61g@mail.gmail.com>
Subject: Re: [PATCH 1/1] mm/khugepaged: bypassing unnecessary scans with
 MMF_DISABLE_THP check
To: Yang Shi <shy828301@gmail.com>
Cc: akpm@linux-foundation.org, mhocko@suse.com, zokeefe@google.com, 
	david@redhat.com, songmuchun@bytedance.com, peterx@redhat.com, 
	minchan@kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hey Yang,

Thank you for the clarification.

You're correct. If the daemon calls prctl with
MMF_DISABLE_THP before fork, the child
mm won't be on the hash list.

What I meant is that the daemon mm might
already be on the hash list before fork.
Therefore, khugepaged might still scan the
address space for the daemon.

Thanks,
Lance

On Thu, Feb 1, 2024 at 4:06=E2=80=AFAM Yang Shi <shy828301@gmail.com> wrote=
:
>
> On Wed, Jan 31, 2024 at 1:30=E2=80=AFAM Lance Yang <ioworker0@gmail.com> =
wrote:
> >
> > Updating the change log.
> >
> > khugepaged scans the entire address space in the
> > background for each given mm, looking for
> > opportunities to merge sequences of basic pages
> > into huge pages. However, when an mm is inserted
> > to the mm_slots list, and the MMF_DISABLE_THP
> > flag is set later, this scanning process becomes
> > unnecessary for that mm and can be skipped to
> > avoid redundant operations, especially in scenarios
> > with a large address space.
> >
> > This commit introduces a check before each scanning
> > process to test the MMF_DISABLE_THP flag for the
> > given mm; if the flag is set, the scanning process is
> > bypassed, thereby improving the efficiency of khugepaged.
> >
> > This optimization is not a correctness issue but rather an
> > enhancement to save expensive checks on each VMA
> > when userspace cannot prctl itself before spawning
> > into the new process.
>
> If this is an optimization, you'd better show some real numbers to help j=
ustify.
>
> >
> > On some servers within our company, we deploy a
> > daemon responsible for monitoring and updating local
> > applications. Some applications prefer not to use THP,
> > so the daemon calls prctl to disable THP before fork/exec.
> > Conversely, for other applications, the daemon calls prctl
> > to enable THP before fork/exec.
>
> If your daemon calls prctl with MMF_DISABLE_THP before fork, then you
> end up having the child mm on the hash list in the first place, I
> think it should be a bug in khugepaged_fork() IIUC. khugepaged_fork()
> should check this flag and bail out if it is set. Did I miss
> something?
>
> >
> > Ideally, the daemon should invoke prctl after the fork,
> > but its current implementation follows the described
> > approach. In the Go standard library, there is no direct
> > encapsulation of the fork system call; instead, fork and
> > execve are combined into one through syscall.ForkExec.
> >
> > Thanks,
> > Lance
> >
> > On Mon, Jan 29, 2024 at 1:46=E2=80=AFPM Lance Yang <ioworker0@gmail.com=
> wrote:
> > >
> > > khugepaged scans the entire address space in the
> > > background for each given mm, looking for
> > > opportunities to merge sequences of basic pages
> > > into huge pages. However, when an mm is inserted
> > > to the mm_slots list, and the MMF_DISABLE_THP flag
> > > is set later, this scanning process becomes
> > > unnecessary for that mm and can be skipped to avoid
> > > redundant operations, especially in scenarios with
> > > a large address space.
> > >
> > > This commit introduces a check before each scanning
> > > process to test the MMF_DISABLE_THP flag for the
> > > given mm; if the flag is set, the scanning process
> > > is bypassed, thereby improving the efficiency of
> > > khugepaged.
> > >
> > > Signed-off-by: Lance Yang <ioworker0@gmail.com>
> > > ---
> > >  mm/khugepaged.c | 18 ++++++++++++------
> > >  1 file changed, 12 insertions(+), 6 deletions(-)
> > >
> > > diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> > > index 2b219acb528e..d6a700834edc 100644
> > > --- a/mm/khugepaged.c
> > > +++ b/mm/khugepaged.c
> > > @@ -410,6 +410,12 @@ static inline int hpage_collapse_test_exit(struc=
t mm_struct *mm)
> > >         return atomic_read(&mm->mm_users) =3D=3D 0;
> > >  }
> > >
> > > +static inline int hpage_collapse_test_exit_or_disable(struct mm_stru=
ct *mm)
> > > +{
> > > +       return hpage_collapse_test_exit(mm) ||
> > > +              test_bit(MMF_DISABLE_THP, &mm->flags);
> > > +}
> > > +
> > >  void __khugepaged_enter(struct mm_struct *mm)
> > >  {
> > >         struct khugepaged_mm_slot *mm_slot;
> > > @@ -1422,7 +1428,7 @@ static void collect_mm_slot(struct khugepaged_m=
m_slot *mm_slot)
> > >
> > >         lockdep_assert_held(&khugepaged_mm_lock);
> > >
> > > -       if (hpage_collapse_test_exit(mm)) {
> > > +       if (hpage_collapse_test_exit_or_disable(mm)) {
> > >                 /* free mm_slot */
> > >                 hash_del(&slot->hash);
> > >                 list_del(&slot->mm_node);
> > > @@ -2360,7 +2366,7 @@ static unsigned int khugepaged_scan_mm_slot(uns=
igned int pages, int *result,
> > >                 goto breakouterloop_mmap_lock;
> > >
> > >         progress++;
> > > -       if (unlikely(hpage_collapse_test_exit(mm)))
> > > +       if (unlikely(hpage_collapse_test_exit_or_disable(mm)))
> > >                 goto breakouterloop;
> > >
> > >         vma_iter_init(&vmi, mm, khugepaged_scan.address);
> > > @@ -2368,7 +2374,7 @@ static unsigned int khugepaged_scan_mm_slot(uns=
igned int pages, int *result,
> > >                 unsigned long hstart, hend;
> > >
> > >                 cond_resched();
> > > -               if (unlikely(hpage_collapse_test_exit(mm))) {
> > > +               if (unlikely(hpage_collapse_test_exit_or_disable(mm))=
) {
> > >                         progress++;
> > >                         break;
> > >                 }
> > > @@ -2390,7 +2396,7 @@ static unsigned int khugepaged_scan_mm_slot(uns=
igned int pages, int *result,
> > >                         bool mmap_locked =3D true;
> > >
> > >                         cond_resched();
> > > -                       if (unlikely(hpage_collapse_test_exit(mm)))
> > > +                       if (unlikely(hpage_collapse_test_exit_or_disa=
ble(mm)))
> > >                                 goto breakouterloop;
> > >
> > >                         VM_BUG_ON(khugepaged_scan.address < hstart ||
> > > @@ -2408,7 +2414,7 @@ static unsigned int khugepaged_scan_mm_slot(uns=
igned int pages, int *result,
> > >                                 fput(file);
> > >                                 if (*result =3D=3D SCAN_PTE_MAPPED_HU=
GEPAGE) {
> > >                                         mmap_read_lock(mm);
> > > -                                       if (hpage_collapse_test_exit(=
mm))
> > > +                                       if (hpage_collapse_test_exit_=
or_disable(mm))
> > >                                                 goto breakouterloop;
> > >                                         *result =3D collapse_pte_mapp=
ed_thp(mm,
> > >                                                 khugepaged_scan.addre=
ss, false);
> > > @@ -2450,7 +2456,7 @@ static unsigned int khugepaged_scan_mm_slot(uns=
igned int pages, int *result,
> > >          * Release the current mm_slot if this mm is about to die, or
> > >          * if we scanned all vmas of this mm.
> > >          */
> > > -       if (hpage_collapse_test_exit(mm) || !vma) {
> > > +       if (hpage_collapse_test_exit_or_disable(mm) || !vma) {
> > >                 /*
> > >                  * Make sure that if mm_users is reaching zero while
> > >                  * khugepaged runs here, khugepaged_exit will find
> > > --
> > > 2.33.1
> > >

