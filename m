Return-Path: <linux-kernel+bounces-48737-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 207BC846075
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 19:56:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE13528B516
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 18:56:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 386B184051;
	Thu,  1 Feb 2024 18:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g1MoWS29"
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4D0212FB26
	for <linux-kernel@vger.kernel.org>; Thu,  1 Feb 2024 18:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706813794; cv=none; b=CyDgi5GhGdemY2rOCyyLqT68dgEWqps4CzCzKz66JCSnclyZmT8OWMmi9skgQkD34VnrJMHqsoYQnzoMDWo1U/CKs5f0I67GoSJikwe2cjxnol1SB4F4Fdw28PSkpL8D/h7EnoROZXP9PeOkv20QZltikka08PCf+Fm88vK/vho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706813794; c=relaxed/simple;
	bh=2M8bXvGE0f7yNYLL09EYhq5u8vrGTVTnUYXt9Of/x2Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=u8w1ZWWSI1hInfxxg221Iim5YrqB3VX2sbxPtp09vJuwOJV+QYIqdMOzvA9KhuIqn4RJ/4PXd+xegmwcc4io6/kEPlldj2352UwCMvYXe0+vNw0BpvZ3prS369xWnJrrNzs1I00LhuSBwmpy8j7Co9ffEJsTuFEdgi4a2qJNXFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g1MoWS29; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-6da9c834646so906306b3a.3
        for <linux-kernel@vger.kernel.org>; Thu, 01 Feb 2024 10:56:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706813792; x=1707418592; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E+C9bCNlGtGcWf/MBgmL+MXY4hhS7q4FxdKWmwkKSHo=;
        b=g1MoWS29BFn/nZfZBHCvmf+wW67vf7y2lIGXozet/4YgtfNakEti/Dix00hWv16b+e
         5Yd6noDugf5VudM5zMmzwGHIxxnqn4NlDT5jY7VBNgann8RxH8lkU3SdcEoNQfZ0Wpn4
         Ty5ugLpOWN93TiqdBzmOV53c0Ihz2zMwEUh7a0NEpgxdmVmTEW4gkPgdEq80NQC2W8My
         sUoMPLXNJCJ0nDQREv/2xqv2fa5vSJtG/ET677Kreo6crcNuqXvCOl7iIb2DAT1C8RcF
         MDboN2pBLtTwcwTnEwpSncZyaUW7LTVphlXK/wYgkNgC9lLCfwT6AkfhIHZ5iGmTBkna
         RGug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706813792; x=1707418592;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E+C9bCNlGtGcWf/MBgmL+MXY4hhS7q4FxdKWmwkKSHo=;
        b=aS5+fyhgw6G71nisA7qq6TS41Q/s8GTD428M4xUSuY+rFApSNa+GwC+BIncSxgRh0+
         pVor+guxp5WRftr+Xfj3c5SComSNMjjLyPy6MnFF4BobS0OeGmI0OHb042XIjKhga9+O
         RlRp/0JmVO+U2sV3sa8yjGWefImXTkKlZLKYb7twLKq7yYs4128XRKG+OBIW1uGZ/Atl
         apUCCwgJ94sdekAONnyjA8jUT5mxOqhO5GmBYopsG8YBvcvGqCNqB4eNBgJ62XFCBxKI
         9WNVK9GuMA3y4OcBB4NNSl/bJOmTo0VtIBRtt1nQPhJavJsSOC8Id8qUah7YLfzeWVtE
         B6Mw==
X-Gm-Message-State: AOJu0YxJGLvX4OTUuFq1VBZpBSksk7W/j+nrxNaOX3smns39EHNmQNYO
	KTgTPkMCL7zp3EfPj/pDB+Kl0SbB/tc33+T0CkYkRvkKkhxOuI9AS2Sp6tj9M+pBtlFqKDYzqUq
	lwi/WQ2ovqeLd5aGHafdClkHSqhA=
X-Google-Smtp-Source: AGHT+IF8QlL0ZYgKkKtjE5g3LDBNUoNP+rn1QWPaBnUbbOz4Lxn9ioCZrmm7vqxlQDE66E4wFpPlBjq8yzekMgr4B/c=
X-Received: by 2002:a05:6a00:2da0:b0:6dd:c269:35a with SMTP id
 fb32-20020a056a002da000b006ddc269035amr7464pfb.27.1706813791816; Thu, 01 Feb
 2024 10:56:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240129054551.57728-1-ioworker0@gmail.com> <CAK1f24keWtJNVv37r2vNsqnmMLRMvF-F76WR5RD_Y-BbAgEaYQ@mail.gmail.com>
 <CAHbLzkodfgkf4vYXFL0R89+tDawAfH9_XPbv3z4-w+hAysZkGQ@mail.gmail.com> <CAK1f24=O34609mYcfyOhRAtei0Rag5EqJ1jX1kbqFhMTJxU61g@mail.gmail.com>
In-Reply-To: <CAK1f24=O34609mYcfyOhRAtei0Rag5EqJ1jX1kbqFhMTJxU61g@mail.gmail.com>
From: Yang Shi <shy828301@gmail.com>
Date: Thu, 1 Feb 2024 10:56:19 -0800
Message-ID: <CAHbLzkpsdHDK3KPS4M-TCMWt7svL40nkrgE3G43FO+b=s+tD_Q@mail.gmail.com>
Subject: Re: [PATCH 1/1] mm/khugepaged: bypassing unnecessary scans with
 MMF_DISABLE_THP check
To: Lance Yang <ioworker0@gmail.com>
Cc: akpm@linux-foundation.org, mhocko@suse.com, zokeefe@google.com, 
	david@redhat.com, songmuchun@bytedance.com, peterx@redhat.com, 
	minchan@kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 31, 2024 at 5:13=E2=80=AFPM Lance Yang <ioworker0@gmail.com> wr=
ote:
>
> Hey Yang,
>
> Thank you for the clarification.
>
> You're correct. If the daemon calls prctl with
> MMF_DISABLE_THP before fork, the child
> mm won't be on the hash list.
>
> What I meant is that the daemon mm might
> already be on the hash list before fork.
> Therefore, khugepaged might still scan the
> address space for the daemon.

OK, I thought you don't care about the daemon since you mentioned the
daemon would call prctl to disable THP or enable THP for different
children, so the daemon's THP preference may be constantly changed or
doesn't matter at all.

So the actual cost is actually traversing the maple tree for the
daemon. Does the daemon have excessive vmas? I'm not sure whether the
improvement is noticeable or not.

>
> Thanks,
> Lance
>
> On Thu, Feb 1, 2024 at 4:06=E2=80=AFAM Yang Shi <shy828301@gmail.com> wro=
te:
> >
> > On Wed, Jan 31, 2024 at 1:30=E2=80=AFAM Lance Yang <ioworker0@gmail.com=
> wrote:
> > >
> > > Updating the change log.
> > >
> > > khugepaged scans the entire address space in the
> > > background for each given mm, looking for
> > > opportunities to merge sequences of basic pages
> > > into huge pages. However, when an mm is inserted
> > > to the mm_slots list, and the MMF_DISABLE_THP
> > > flag is set later, this scanning process becomes
> > > unnecessary for that mm and can be skipped to
> > > avoid redundant operations, especially in scenarios
> > > with a large address space.
> > >
> > > This commit introduces a check before each scanning
> > > process to test the MMF_DISABLE_THP flag for the
> > > given mm; if the flag is set, the scanning process is
> > > bypassed, thereby improving the efficiency of khugepaged.
> > >
> > > This optimization is not a correctness issue but rather an
> > > enhancement to save expensive checks on each VMA
> > > when userspace cannot prctl itself before spawning
> > > into the new process.
> >
> > If this is an optimization, you'd better show some real numbers to help=
 justify.
> >
> > >
> > > On some servers within our company, we deploy a
> > > daemon responsible for monitoring and updating local
> > > applications. Some applications prefer not to use THP,
> > > so the daemon calls prctl to disable THP before fork/exec.
> > > Conversely, for other applications, the daemon calls prctl
> > > to enable THP before fork/exec.
> >
> > If your daemon calls prctl with MMF_DISABLE_THP before fork, then you
> > end up having the child mm on the hash list in the first place, I
> > think it should be a bug in khugepaged_fork() IIUC. khugepaged_fork()
> > should check this flag and bail out if it is set. Did I miss
> > something?
> >
> > >
> > > Ideally, the daemon should invoke prctl after the fork,
> > > but its current implementation follows the described
> > > approach. In the Go standard library, there is no direct
> > > encapsulation of the fork system call; instead, fork and
> > > execve are combined into one through syscall.ForkExec.
> > >
> > > Thanks,
> > > Lance
> > >
> > > On Mon, Jan 29, 2024 at 1:46=E2=80=AFPM Lance Yang <ioworker0@gmail.c=
om> wrote:
> > > >
> > > > khugepaged scans the entire address space in the
> > > > background for each given mm, looking for
> > > > opportunities to merge sequences of basic pages
> > > > into huge pages. However, when an mm is inserted
> > > > to the mm_slots list, and the MMF_DISABLE_THP flag
> > > > is set later, this scanning process becomes
> > > > unnecessary for that mm and can be skipped to avoid
> > > > redundant operations, especially in scenarios with
> > > > a large address space.
> > > >
> > > > This commit introduces a check before each scanning
> > > > process to test the MMF_DISABLE_THP flag for the
> > > > given mm; if the flag is set, the scanning process
> > > > is bypassed, thereby improving the efficiency of
> > > > khugepaged.
> > > >
> > > > Signed-off-by: Lance Yang <ioworker0@gmail.com>
> > > > ---
> > > >  mm/khugepaged.c | 18 ++++++++++++------
> > > >  1 file changed, 12 insertions(+), 6 deletions(-)
> > > >
> > > > diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> > > > index 2b219acb528e..d6a700834edc 100644
> > > > --- a/mm/khugepaged.c
> > > > +++ b/mm/khugepaged.c
> > > > @@ -410,6 +410,12 @@ static inline int hpage_collapse_test_exit(str=
uct mm_struct *mm)
> > > >         return atomic_read(&mm->mm_users) =3D=3D 0;
> > > >  }
> > > >
> > > > +static inline int hpage_collapse_test_exit_or_disable(struct mm_st=
ruct *mm)
> > > > +{
> > > > +       return hpage_collapse_test_exit(mm) ||
> > > > +              test_bit(MMF_DISABLE_THP, &mm->flags);
> > > > +}
> > > > +
> > > >  void __khugepaged_enter(struct mm_struct *mm)
> > > >  {
> > > >         struct khugepaged_mm_slot *mm_slot;
> > > > @@ -1422,7 +1428,7 @@ static void collect_mm_slot(struct khugepaged=
_mm_slot *mm_slot)
> > > >
> > > >         lockdep_assert_held(&khugepaged_mm_lock);
> > > >
> > > > -       if (hpage_collapse_test_exit(mm)) {
> > > > +       if (hpage_collapse_test_exit_or_disable(mm)) {
> > > >                 /* free mm_slot */
> > > >                 hash_del(&slot->hash);
> > > >                 list_del(&slot->mm_node);
> > > > @@ -2360,7 +2366,7 @@ static unsigned int khugepaged_scan_mm_slot(u=
nsigned int pages, int *result,
> > > >                 goto breakouterloop_mmap_lock;
> > > >
> > > >         progress++;
> > > > -       if (unlikely(hpage_collapse_test_exit(mm)))
> > > > +       if (unlikely(hpage_collapse_test_exit_or_disable(mm)))
> > > >                 goto breakouterloop;
> > > >
> > > >         vma_iter_init(&vmi, mm, khugepaged_scan.address);
> > > > @@ -2368,7 +2374,7 @@ static unsigned int khugepaged_scan_mm_slot(u=
nsigned int pages, int *result,
> > > >                 unsigned long hstart, hend;
> > > >
> > > >                 cond_resched();
> > > > -               if (unlikely(hpage_collapse_test_exit(mm))) {
> > > > +               if (unlikely(hpage_collapse_test_exit_or_disable(mm=
))) {
> > > >                         progress++;
> > > >                         break;
> > > >                 }
> > > > @@ -2390,7 +2396,7 @@ static unsigned int khugepaged_scan_mm_slot(u=
nsigned int pages, int *result,
> > > >                         bool mmap_locked =3D true;
> > > >
> > > >                         cond_resched();
> > > > -                       if (unlikely(hpage_collapse_test_exit(mm)))
> > > > +                       if (unlikely(hpage_collapse_test_exit_or_di=
sable(mm)))
> > > >                                 goto breakouterloop;
> > > >
> > > >                         VM_BUG_ON(khugepaged_scan.address < hstart =
||
> > > > @@ -2408,7 +2414,7 @@ static unsigned int khugepaged_scan_mm_slot(u=
nsigned int pages, int *result,
> > > >                                 fput(file);
> > > >                                 if (*result =3D=3D SCAN_PTE_MAPPED_=
HUGEPAGE) {
> > > >                                         mmap_read_lock(mm);
> > > > -                                       if (hpage_collapse_test_exi=
t(mm))
> > > > +                                       if (hpage_collapse_test_exi=
t_or_disable(mm))
> > > >                                                 goto breakouterloop=
;
> > > >                                         *result =3D collapse_pte_ma=
pped_thp(mm,
> > > >                                                 khugepaged_scan.add=
ress, false);
> > > > @@ -2450,7 +2456,7 @@ static unsigned int khugepaged_scan_mm_slot(u=
nsigned int pages, int *result,
> > > >          * Release the current mm_slot if this mm is about to die, =
or
> > > >          * if we scanned all vmas of this mm.
> > > >          */
> > > > -       if (hpage_collapse_test_exit(mm) || !vma) {
> > > > +       if (hpage_collapse_test_exit_or_disable(mm) || !vma) {
> > > >                 /*
> > > >                  * Make sure that if mm_users is reaching zero whil=
e
> > > >                  * khugepaged runs here, khugepaged_exit will find
> > > > --
> > > > 2.33.1
> > > >

