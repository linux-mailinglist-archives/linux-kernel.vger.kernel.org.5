Return-Path: <linux-kernel+bounces-50890-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62AED847FE6
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 04:21:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 87F421C21C72
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 03:21:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A00EF9D7;
	Sat,  3 Feb 2024 03:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dH1khIHZ"
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C84BF8829
	for <linux-kernel@vger.kernel.org>; Sat,  3 Feb 2024 03:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706930472; cv=none; b=INIiq7F1/dAZg/oi3gwj5dP16SS3Vd26WkRvUQz2BqxFkLIIuPTO68NZrWib/OO/3wEuPNGTsA4c+gAUg69V5l59iBNpjtqp/fWKc5mJxJp+7xkIjbtBkx93IiObB2oRR5wtkJkLSAnZnj0YR7Wl4AciSid70Smc+/9xLCzczc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706930472; c=relaxed/simple;
	bh=3k1YvwqjSAv/+HXEgBiRCCwu7JwfIPETBCpHuhbZ5XU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=urbqEZJhAd/6YZt4erRc8bnRuABMcedDp3y0C7qMQQgGDoKKVuUJYh5Q+npjJ5iExn//jiEmTSCpYUKt+2xyjFBVcGUI80duCi2GgTHmabF+hGZsLZqY/z7uue2CntBIaJmLTWMxOAIEpJyhUgkZy0YrAVQbn7IAD6Vu3Vc88Ag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dH1khIHZ; arc=none smtp.client-ip=209.85.219.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-dc6db13f1abso2222354276.2
        for <linux-kernel@vger.kernel.org>; Fri, 02 Feb 2024 19:21:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706930470; x=1707535270; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W699dhQrIRx2hl06FjgorWvkEI0rXLNSwHMVMLrlHT0=;
        b=dH1khIHZn4TaFqyKjMPb8nMKr+cnRH/dF6wqX78OanLs4rgcT6AnWoMQtYUJNjfEci
         HyE8oq4xNQri+bev303w+S5M9abFFRZzt22KekuHzHVVXtXfx/KfL/KJUhEcGZ9IVpJh
         8RiQgqpD1XKTLZinysc4UMgFnE+oyEeVOHR/j8OMdswOztqTYOlVACd8DSHrvtWy8y0E
         t5Tvwr9rpA39wCpVfu6PIyh+rp6y0EYB3aQLfzuAnTFrzMSdADFFWsbglL/JvYuUGnQF
         cmywi7XY8G2N5Gz9t/9NTCy8lQ4CNIvMU1ailEBv6TCbNpSjBoruOyoP5I48sKsftrOS
         1UuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706930470; x=1707535270;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W699dhQrIRx2hl06FjgorWvkEI0rXLNSwHMVMLrlHT0=;
        b=scDhG1KQ1ZhwJEkMhyYLstACe+XhKwtVx8LRjsND6HINaAvBQvp11gSMC3CT/PTZih
         QOltQf2vPwIyJl+afEUnFXR0CkN8FRLFnupEiYl9JAyk7B4GC/+0o7PP+StRf/L22fyB
         l7IcPnFsyFA4sReX/3q80HiYc1PYajmslYdqhI4ASfZOelzMfHDg4XBWUaBm01T3aRiI
         07gFnO3U978XtzK8PeEwB7U1zzqTIRHNzCZm3z//FqSM4/xJg1V9r6JGJLoV+5I4sl8T
         oRLABfU1SVBQN5We8W5hDmHxQPT6zlrNX/WWk1O7XtCmXsaGUKusGmxmnEK4x/s6OtDN
         R5iw==
X-Gm-Message-State: AOJu0Yy5c0LJldvS4kXJIYESFQZ30hOmobyjmmYHNX4Sw0C87EcXdpTa
	2VNcQfj2qsll3Fae1S2c1Ukr1/WM/VQ39/M3bVODfxLbGEQHRQK8qb0q9rIRy2Q/YDieyW4oGs6
	m+LAtFREKaI2n0/C1zAiWzIQRNxg=
X-Google-Smtp-Source: AGHT+IGal0zu142ko8bnWqOPYyWjrK1GRtwWKns3Z9ARyOW+iDlA4UpYue30PMH5R5Ovdsl8l6k0oc9URByYj9g6VJc=
X-Received: by 2002:a25:eb07:0:b0:dc2:3ec3:95d4 with SMTP id
 d7-20020a25eb07000000b00dc23ec395d4mr3957148ybs.47.1706930469673; Fri, 02 Feb
 2024 19:21:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240129054551.57728-1-ioworker0@gmail.com> <CAK1f24keWtJNVv37r2vNsqnmMLRMvF-F76WR5RD_Y-BbAgEaYQ@mail.gmail.com>
 <CAHbLzkodfgkf4vYXFL0R89+tDawAfH9_XPbv3z4-w+hAysZkGQ@mail.gmail.com>
 <CAK1f24=O34609mYcfyOhRAtei0Rag5EqJ1jX1kbqFhMTJxU61g@mail.gmail.com> <CAHbLzkpsdHDK3KPS4M-TCMWt7svL40nkrgE3G43FO+b=s+tD_Q@mail.gmail.com>
In-Reply-To: <CAHbLzkpsdHDK3KPS4M-TCMWt7svL40nkrgE3G43FO+b=s+tD_Q@mail.gmail.com>
From: Lance Yang <ioworker0@gmail.com>
Date: Sat, 3 Feb 2024 11:20:58 +0800
Message-ID: <CAK1f24mF07JMRXNrP0Jxv9JiqqTyYF7UUav+HXy26iHWFT37Zw@mail.gmail.com>
Subject: Re: [PATCH 1/1] mm/khugepaged: bypassing unnecessary scans with
 MMF_DISABLE_THP check
To: Yang Shi <shy828301@gmail.com>
Cc: akpm@linux-foundation.org, mhocko@suse.com, zokeefe@google.com, 
	david@redhat.com, songmuchun@bytedance.com, peterx@redhat.com, 
	minchan@kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I asked the maintainer of the daemon.
Currently, the daemon is not optimized for huge
pages. It has over 200 VMAs, with the majority
being file-mapped.

On Fri, Feb 2, 2024 at 2:56=E2=80=AFAM Yang Shi <shy828301@gmail.com> wrote=
:
>
> On Wed, Jan 31, 2024 at 5:13=E2=80=AFPM Lance Yang <ioworker0@gmail.com> =
wrote:
> >
> > Hey Yang,
> >
> > Thank you for the clarification.
> >
> > You're correct. If the daemon calls prctl with
> > MMF_DISABLE_THP before fork, the child
> > mm won't be on the hash list.
> >
> > What I meant is that the daemon mm might
> > already be on the hash list before fork.
> > Therefore, khugepaged might still scan the
> > address space for the daemon.
>
> OK, I thought you don't care about the daemon since you mentioned the
> daemon would call prctl to disable THP or enable THP for different
> children, so the daemon's THP preference may be constantly changed or
> doesn't matter at all.
>
> So the actual cost is actually traversing the maple tree for the
> daemon. Does the daemon have excessive vmas? I'm not sure whether the
> improvement is noticeable or not.
>
> >
> > Thanks,
> > Lance
> >
> > On Thu, Feb 1, 2024 at 4:06=E2=80=AFAM Yang Shi <shy828301@gmail.com> w=
rote:
> > >
> > > On Wed, Jan 31, 2024 at 1:30=E2=80=AFAM Lance Yang <ioworker0@gmail.c=
om> wrote:
> > > >
> > > > Updating the change log.
> > > >
> > > > khugepaged scans the entire address space in the
> > > > background for each given mm, looking for
> > > > opportunities to merge sequences of basic pages
> > > > into huge pages. However, when an mm is inserted
> > > > to the mm_slots list, and the MMF_DISABLE_THP
> > > > flag is set later, this scanning process becomes
> > > > unnecessary for that mm and can be skipped to
> > > > avoid redundant operations, especially in scenarios
> > > > with a large address space.
> > > >
> > > > This commit introduces a check before each scanning
> > > > process to test the MMF_DISABLE_THP flag for the
> > > > given mm; if the flag is set, the scanning process is
> > > > bypassed, thereby improving the efficiency of khugepaged.
> > > >
> > > > This optimization is not a correctness issue but rather an
> > > > enhancement to save expensive checks on each VMA
> > > > when userspace cannot prctl itself before spawning
> > > > into the new process.
> > >
> > > If this is an optimization, you'd better show some real numbers to he=
lp justify.
> > >
> > > >
> > > > On some servers within our company, we deploy a
> > > > daemon responsible for monitoring and updating local
> > > > applications. Some applications prefer not to use THP,
> > > > so the daemon calls prctl to disable THP before fork/exec.
> > > > Conversely, for other applications, the daemon calls prctl
> > > > to enable THP before fork/exec.
> > >
> > > If your daemon calls prctl with MMF_DISABLE_THP before fork, then you
> > > end up having the child mm on the hash list in the first place, I
> > > think it should be a bug in khugepaged_fork() IIUC. khugepaged_fork()
> > > should check this flag and bail out if it is set. Did I miss
> > > something?
> > >
> > > >
> > > > Ideally, the daemon should invoke prctl after the fork,
> > > > but its current implementation follows the described
> > > > approach. In the Go standard library, there is no direct
> > > > encapsulation of the fork system call; instead, fork and
> > > > execve are combined into one through syscall.ForkExec.
> > > >
> > > > Thanks,
> > > > Lance
> > > >
> > > > On Mon, Jan 29, 2024 at 1:46=E2=80=AFPM Lance Yang <ioworker0@gmail=
com> wrote:
> > > > >
> > > > > khugepaged scans the entire address space in the
> > > > > background for each given mm, looking for
> > > > > opportunities to merge sequences of basic pages
> > > > > into huge pages. However, when an mm is inserted
> > > > > to the mm_slots list, and the MMF_DISABLE_THP flag
> > > > > is set later, this scanning process becomes
> > > > > unnecessary for that mm and can be skipped to avoid
> > > > > redundant operations, especially in scenarios with
> > > > > a large address space.
> > > > >
> > > > > This commit introduces a check before each scanning
> > > > > process to test the MMF_DISABLE_THP flag for the
> > > > > given mm; if the flag is set, the scanning process
> > > > > is bypassed, thereby improving the efficiency of
> > > > > khugepaged.
> > > > >
> > > > > Signed-off-by: Lance Yang <ioworker0@gmail.com>
> > > > > ---
> > > > >  mm/khugepaged.c | 18 ++++++++++++------
> > > > >  1 file changed, 12 insertions(+), 6 deletions(-)
> > > > >
> > > > > diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> > > > > index 2b219acb528e..d6a700834edc 100644
> > > > > --- a/mm/khugepaged.c
> > > > > +++ b/mm/khugepaged.c
> > > > > @@ -410,6 +410,12 @@ static inline int hpage_collapse_test_exit(s=
truct mm_struct *mm)
> > > > >         return atomic_read(&mm->mm_users) =3D=3D 0;
> > > > >  }
> > > > >
> > > > > +static inline int hpage_collapse_test_exit_or_disable(struct mm_=
struct *mm)
> > > > > +{
> > > > > +       return hpage_collapse_test_exit(mm) ||
> > > > > +              test_bit(MMF_DISABLE_THP, &mm->flags);
> > > > > +}
> > > > > +
> > > > >  void __khugepaged_enter(struct mm_struct *mm)
> > > > >  {
> > > > >         struct khugepaged_mm_slot *mm_slot;
> > > > > @@ -1422,7 +1428,7 @@ static void collect_mm_slot(struct khugepag=
ed_mm_slot *mm_slot)
> > > > >
> > > > >         lockdep_assert_held(&khugepaged_mm_lock);
> > > > >
> > > > > -       if (hpage_collapse_test_exit(mm)) {
> > > > > +       if (hpage_collapse_test_exit_or_disable(mm)) {
> > > > >                 /* free mm_slot */
> > > > >                 hash_del(&slot->hash);
> > > > >                 list_del(&slot->mm_node);
> > > > > @@ -2360,7 +2366,7 @@ static unsigned int khugepaged_scan_mm_slot=
(unsigned int pages, int *result,
> > > > >                 goto breakouterloop_mmap_lock;
> > > > >
> > > > >         progress++;
> > > > > -       if (unlikely(hpage_collapse_test_exit(mm)))
> > > > > +       if (unlikely(hpage_collapse_test_exit_or_disable(mm)))
> > > > >                 goto breakouterloop;
> > > > >
> > > > >         vma_iter_init(&vmi, mm, khugepaged_scan.address);
> > > > > @@ -2368,7 +2374,7 @@ static unsigned int khugepaged_scan_mm_slot=
(unsigned int pages, int *result,
> > > > >                 unsigned long hstart, hend;
> > > > >
> > > > >                 cond_resched();
> > > > > -               if (unlikely(hpage_collapse_test_exit(mm))) {
> > > > > +               if (unlikely(hpage_collapse_test_exit_or_disable(=
mm))) {
> > > > >                         progress++;
> > > > >                         break;
> > > > >                 }
> > > > > @@ -2390,7 +2396,7 @@ static unsigned int khugepaged_scan_mm_slot=
(unsigned int pages, int *result,
> > > > >                         bool mmap_locked =3D true;
> > > > >
> > > > >                         cond_resched();
> > > > > -                       if (unlikely(hpage_collapse_test_exit(mm)=
))
> > > > > +                       if (unlikely(hpage_collapse_test_exit_or_=
disable(mm)))
> > > > >                                 goto breakouterloop;
> > > > >
> > > > >                         VM_BUG_ON(khugepaged_scan.address < hstar=
t ||
> > > > > @@ -2408,7 +2414,7 @@ static unsigned int khugepaged_scan_mm_slot=
(unsigned int pages, int *result,
> > > > >                                 fput(file);
> > > > >                                 if (*result =3D=3D SCAN_PTE_MAPPE=
D_HUGEPAGE) {
> > > > >                                         mmap_read_lock(mm);
> > > > > -                                       if (hpage_collapse_test_e=
xit(mm))
> > > > > +                                       if (hpage_collapse_test_e=
xit_or_disable(mm))
> > > > >                                                 goto breakouterlo=
op;
> > > > >                                         *result =3D collapse_pte_=
mapped_thp(mm,
> > > > >                                                 khugepaged_scan.a=
ddress, false);
> > > > > @@ -2450,7 +2456,7 @@ static unsigned int khugepaged_scan_mm_slot=
(unsigned int pages, int *result,
> > > > >          * Release the current mm_slot if this mm is about to die=
, or
> > > > >          * if we scanned all vmas of this mm.
> > > > >          */
> > > > > -       if (hpage_collapse_test_exit(mm) || !vma) {
> > > > > +       if (hpage_collapse_test_exit_or_disable(mm) || !vma) {
> > > > >                 /*
> > > > >                  * Make sure that if mm_users is reaching zero wh=
ile
> > > > >                  * khugepaged runs here, khugepaged_exit will fin=
d
> > > > > --
> > > > > 2.33.1
> > > > >

