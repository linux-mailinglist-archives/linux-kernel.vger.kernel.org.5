Return-Path: <linux-kernel+bounces-47044-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FCB2844869
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 21:06:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB7CC2897E4
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 20:06:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D387A3FE27;
	Wed, 31 Jan 2024 20:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VB4U32pY"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E7113F8EA
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 20:06:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706731606; cv=none; b=em3VM+QhM3suBVPEb9fa72RUxwCEG88jce9sZaZKcxorGjpmFE9maKl6rXl4vVRAIHBukQxBudiWrP/EDBesbzlXZobYnKCcRRA5ULBex7/VHsiLb2IFFEtza9k0/gDv1UPZEz3j2KmGtPiy5ui5mXF2kBuih1YPsCm20dbELKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706731606; c=relaxed/simple;
	bh=OQbCro/1VJ2RuXdWqCkdBpbIy7HYfcOXIhD5E8ok9JM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=i0FJucuc7fIacsQcczJxgvOZZVlnbZWwUV215MQ7uL05kBJ1jSUhN3nSbSJxBAV9XfnmsotSxbU55dAdgy9Jvko1voMMHRje6ZuYtJbqhCTqPpSTo/JqLTx9QykauQ8Q5FxSYYl8UZz7wIJAo5f2fOJ7tCAx6cFGCMneljrlTwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VB4U32pY; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1d74045c463so1312105ad.3
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 12:06:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706731604; x=1707336404; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XBzDdvRsLLKEceNS+LZmwQIkmEXrkHn77clVBzNk9Io=;
        b=VB4U32pYeImoOg3Zl2V4r7toRC/LNeIbeclILr2Lb3hTI+ZhMmk5AHciCa0kyoQVex
         RC6+3yc+ytGxtSazbV2eit+v7B0L38VlOo3PLwZV+R/4l4JhGWIiWQhcVtZxrae5UHSY
         0yEqz6Zy83uFnUjmiiBjJsao8UuAbXq7ioEPJ1qFVSVU6jgAxAeVq3kB0zE/UDmhmZNF
         yU6kaV/AVxXL38rIqocsIGpc6L4796/2hgrizvNdS+50GmSImibhgtCU8F0MjOFcraEk
         xkKxMWNksEe2Y7iJn8cIkIOBbcO5ycASKLi3nv7BxvEPBefKc2lrqtVhbebBCSc1+Wbj
         0RIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706731604; x=1707336404;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XBzDdvRsLLKEceNS+LZmwQIkmEXrkHn77clVBzNk9Io=;
        b=H9r2xaOdwSXdEtBzGjUmnMIaI4+CrsX31X3Iavs5KneTZ5u711yLGJJMWJ9xpseHYE
         nKSj2eYhteKODC+pF9neySEnYBZloQQxER1uUmkKxN6DE9dCgdTv6vNutfzNx8pG2yFQ
         yqq73RKIGk3e97EFMVjS1WAFuWSy9aVSCA7sfG2z8hDrjEOpVlQ5f6LHYcPKEhefowR5
         91P6X7WzioTPTCH1EBXarxSLnXMsrBqHTHJVoA/6BEQV5v+fkxvjU9o2fITJsNkNtfSl
         RHeuol+fr1iYqXBvFpreSOyobElgPL5/gAWVMYdUquSpvU+P/DsF48EZjyaI5omEFjpk
         OqTA==
X-Gm-Message-State: AOJu0YzV0SXavp1a6dl3+57IJ3hqLMed96Wxab8fP7/uTw0rewKBgCGp
	dVeVLpMaS08ZyT9qVf2qjj3zjn7UsPVNvk+2QqKHMLdFgKTaM5biEpXrdz3WHjtiSHOCAWxSsW7
	EnLYWjiVLEIm8RjZFjwoYa2TuBaA=
X-Google-Smtp-Source: AGHT+IESjf9/FSyS/yTRw9eFrkUbAOV0D3eR7ZN7x9oleGmjKJmzH+RoL9cs0qRYohW8MnQnTYhDHsYNe1UIBkFxRwk=
X-Received: by 2002:a17:90b:a0d:b0:295:b985:5323 with SMTP id
 gg13-20020a17090b0a0d00b00295b9855323mr2831805pjb.7.1706731604371; Wed, 31
 Jan 2024 12:06:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240129054551.57728-1-ioworker0@gmail.com> <CAK1f24keWtJNVv37r2vNsqnmMLRMvF-F76WR5RD_Y-BbAgEaYQ@mail.gmail.com>
In-Reply-To: <CAK1f24keWtJNVv37r2vNsqnmMLRMvF-F76WR5RD_Y-BbAgEaYQ@mail.gmail.com>
From: Yang Shi <shy828301@gmail.com>
Date: Wed, 31 Jan 2024 12:06:32 -0800
Message-ID: <CAHbLzkodfgkf4vYXFL0R89+tDawAfH9_XPbv3z4-w+hAysZkGQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] mm/khugepaged: bypassing unnecessary scans with
 MMF_DISABLE_THP check
To: Lance Yang <ioworker0@gmail.com>
Cc: akpm@linux-foundation.org, mhocko@suse.com, zokeefe@google.com, 
	david@redhat.com, songmuchun@bytedance.com, peterx@redhat.com, 
	minchan@kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 31, 2024 at 1:30=E2=80=AFAM Lance Yang <ioworker0@gmail.com> wr=
ote:
>
> Updating the change log.
>
> khugepaged scans the entire address space in the
> background for each given mm, looking for
> opportunities to merge sequences of basic pages
> into huge pages. However, when an mm is inserted
> to the mm_slots list, and the MMF_DISABLE_THP
> flag is set later, this scanning process becomes
> unnecessary for that mm and can be skipped to
> avoid redundant operations, especially in scenarios
> with a large address space.
>
> This commit introduces a check before each scanning
> process to test the MMF_DISABLE_THP flag for the
> given mm; if the flag is set, the scanning process is
> bypassed, thereby improving the efficiency of khugepaged.
>
> This optimization is not a correctness issue but rather an
> enhancement to save expensive checks on each VMA
> when userspace cannot prctl itself before spawning
> into the new process.

If this is an optimization, you'd better show some real numbers to help jus=
tify.

>
> On some servers within our company, we deploy a
> daemon responsible for monitoring and updating local
> applications. Some applications prefer not to use THP,
> so the daemon calls prctl to disable THP before fork/exec.
> Conversely, for other applications, the daemon calls prctl
> to enable THP before fork/exec.

If your daemon calls prctl with MMF_DISABLE_THP before fork, then you
end up having the child mm on the hash list in the first place, I
think it should be a bug in khugepaged_fork() IIUC. khugepaged_fork()
should check this flag and bail out if it is set. Did I miss
something?

>
> Ideally, the daemon should invoke prctl after the fork,
> but its current implementation follows the described
> approach. In the Go standard library, there is no direct
> encapsulation of the fork system call; instead, fork and
> execve are combined into one through syscall.ForkExec.
>
> Thanks,
> Lance
>
> On Mon, Jan 29, 2024 at 1:46=E2=80=AFPM Lance Yang <ioworker0@gmail.com> =
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

