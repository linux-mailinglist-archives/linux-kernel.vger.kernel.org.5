Return-Path: <linux-kernel+bounces-79461-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F4EB86228D
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 04:54:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B8B661C220FE
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 03:54:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E06C13FEE;
	Sat, 24 Feb 2024 03:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h0ZY9Hfw"
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com [209.85.219.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE6F213ADD
	for <linux-kernel@vger.kernel.org>; Sat, 24 Feb 2024 03:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708746876; cv=none; b=CC0sqYQmkvjHOg+L6tciJl/jFDTZmdokK08KJFE4MzcU5HvJPhUZMjqPAdFQ03uPyGxVDZV/hUZf8aQbBNnFLv1wdQJ8CjYXeGhH8VgijexUnBQHxl45EZlUctDPdNCLkBOTDceh/XsXBveyqaiqOeiMh8YHngPUmaFw4whNr+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708746876; c=relaxed/simple;
	bh=J8yhRfjmeyjpC6AzusILI8mRdbT4kFht539okYZ9vRM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pgxh0y2L8ioq9tbQ+EzfmX2iUtAHdI8ohufDf4OXJH1BS+Za27mgQvRCyHVFBIgWgZlgOI7relbyPPZj3DtJrBvBwoSwD4WoH4nb1PK+r/vfGCPHTvlGyk4vKL60odzKId0i6HvmNBPuP+0y+8StuQqh4kb9iyQCYpYS2TIe+Qw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h0ZY9Hfw; arc=none smtp.client-ip=209.85.219.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-dcc7cdb3a98so1535044276.2
        for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 19:54:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708746874; x=1709351674; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sl2hbMYkg/YhUEOi4LJCwvnP+BbK5NoXlEwkB02OZsE=;
        b=h0ZY9HfwJ9sAmnYIZGZ+gCljI0/k8N/ZJaVov54MtXWWWh4qI4r/umRv8JXYIOLcN4
         Vfe5+y0XLkrvSm9L62f3Ae3kx/HhhbPN9+2BM8MbL8ixN3sukexMZaDmgvvyUrHGlkCH
         BMdwTcYPknE0paHtQq1zs5NE+1qi4PexNbDirOt9DlseIxXC4sHE27BQL3TcIxEigWSy
         SlN/wccVkQJnLmIw8cMHz9LdLmnubR9PrjJz3uDPoJrtxd6ujsxvfuxn2U2XGzOThndP
         p4Jhp2h0oPMqeDCKqDoswqJWpd4G8Bgeetdnz+UJATDMn3e/0DFkUa37WkhSr9hXi1y9
         tNag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708746874; x=1709351674;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sl2hbMYkg/YhUEOi4LJCwvnP+BbK5NoXlEwkB02OZsE=;
        b=GoTX3CpJwCFoj5YO4lelDTUUDYyw4oo7UyxitAjchCGj4qMcTnxSkQs5cccO2A4dPR
         DaSwejROESeqEf96rDuu9K6TLRDvebkTZWhirGsJkeOl8gFAeWVf5UH4WKX0mpCSFXLt
         aet/hVfnnufSw3SxI0B9iTb5BXqQ13T0ax4XU3FAccqUK32OHHqnAbd5eRbSvCVIr+ic
         JSv1MRWPCuO4qOoeu7RHuQb4QX/cZjfaEgNkRUMOPQmJjvxE7HVqM4Pq3eQFJNbYLuE2
         VSyg3QvcBMm3po/3LGu3BopBuEqJro0FYEKriUzDFiStWp1zrzkL5h/+3GwvphnrRNPx
         Jjew==
X-Forwarded-Encrypted: i=1; AJvYcCX6kUZkMERyrf+gyEkmLyVhMjXZc6RBITlHYzHE6BbrULiHn8xIty4pv6cDy+Wnnu5et9SJnpc8jrpFE6shiDLl7mtoPVhF6cZLVLoD
X-Gm-Message-State: AOJu0Yxsix4Gw44hv3nQPTzCLE0uTAWXUOVey8BgefPFSQrmdXv7eLEj
	Rcd6LPkVkXwOLhy8xtjm1+91p0FDoOX2tPnyV0A0M4eOexTpH1Y1JFz1xWBwfZnlirhlmnOfWik
	MOxubUyi6UUd18fRjyy1ji/q5fW8=
X-Google-Smtp-Source: AGHT+IH5UKUXVOYaKs9FkZP/1YIEVqspxasf2/Gfa43SYTduZraIUOcvqIgGYZwI2zy0mezLTtoOyykHyInv73A0lhc=
X-Received: by 2002:a81:4946:0:b0:604:a9c2:2a17 with SMTP id
 w67-20020a814946000000b00604a9c22a17mr1663459ywa.45.1708746873846; Fri, 23
 Feb 2024 19:54:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240129054551.57728-1-ioworker0@gmail.com> <CAHbLzkrScCvmDOPF0_+CieOtfcaP4JE=Pn29eYS_ZKiX-o4=-g@mail.gmail.com>
In-Reply-To: <CAHbLzkrScCvmDOPF0_+CieOtfcaP4JE=Pn29eYS_ZKiX-o4=-g@mail.gmail.com>
From: Lance Yang <ioworker0@gmail.com>
Date: Sat, 24 Feb 2024 11:54:20 +0800
Message-ID: <CAK1f24=2z9tk4cCCSobVpExZ+uV6N8gbGx+xiJ7p_UjrZvSv3g@mail.gmail.com>
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

On Sat, Feb 24, 2024 at 9:46=E2=80=AFAM Yang Shi <shy828301@gmail.com> wrot=
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
>
> I'm not quite sure whether we should remove the mm from mm_slot and
> drop mm_count or not since clearing MMF_THP_DISABLE flag doesn't add
> the mm back. Creating new vma may add the mm back, but I don't think
> the behavior should depend on this.

Thanks for bringing this up! I agree with your point.
I'll remove the MMF_THP_DISABLE flag check in
collect_mm_slot().

>
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
>
> Same like the above comment.

I=E2=80=98ll also remove the MMF_THP_DISABLE flag check here.

>
> In addition, didn't you need to change hpage_collapse_test_exit() to
> hpage_collapse_test_exit_or_disable() in hugepage_vma_revalidate()?

Thanks for your suggestion! It makes sense to change
hpage_collapse_test_exit() to hpage_collapse_test_exit_or_disable()
in hugepage_vma_revalidate().

Thanks again for your time!
Lance

>
> >                 /*
> >                  * Make sure that if mm_users is reaching zero while
> >                  * khugepaged runs here, khugepaged_exit will find
> > --
> > 2.33.1
> >

