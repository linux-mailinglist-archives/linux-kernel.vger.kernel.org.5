Return-Path: <linux-kernel+bounces-43834-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 454E084195D
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 03:37:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A83271F28078
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 02:37:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92DFD14F7F;
	Tue, 30 Jan 2024 02:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D+U/yqOO"
Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com [209.85.219.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19C11364BF
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 02:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706582263; cv=none; b=UvUNjYtu2CzmjmgUOUrgl2+lRwStba2J5q/J4IL3drYHBF0xpmMIVEULSc/vHDsbY85oy0rT6qY17Z2kp9MqEklzoojcqLD/EyjVIGjxqig4t4SD5nR795LwmbD4CV7hUj2tCAgqCTSWPl+UuL+rIN9usUCJ9WMHJBOihEyb6T8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706582263; c=relaxed/simple;
	bh=z9bBDJTIQyCBFfcB8DtDInc+WWmR0DvpkieJF1S1aGY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=H3IT7b5cyV1LNPfFdnUbPxngwBQs4pDCCZEPWcZUH6o2V/Gqn1xdZkfF3G8WKKY6IwK4jOaMjL1awtwPys1CA4EBLo3pMg98l0yEwYEZkcRDEaI0Ah/NVOd6jwTlTFckArnubgm2xJqo+J1JBVM74vkigm2eg518hMIGQBqBXw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D+U/yqOO; arc=none smtp.client-ip=209.85.219.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f181.google.com with SMTP id 3f1490d57ef6-dc6a2e63203so90818276.2
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 18:37:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706582261; x=1707187061; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1Nf7ZAE4lUdPHPJYVXVTuVeF2gxZD1vrM/mMUbDvf/w=;
        b=D+U/yqOO3gQgCf+VZHAQal1dByeUSnKma9UI7AK+avep/20rF6RptZzbSqbXQ8Wn8v
         ZgqFJ1h5NPztaAMQWRNdgKCZj2f4ufNZeC9V2KRHAs8azRWEGwccbD3ZjyfjBUyCGX3E
         YlN5LG1BwZ7rNYtkSBPyBrKMYZfcU6YytOXtUDNdZTZ3UWuiIBb38RPokSJcJVw8MfdW
         l5MbZtp68pjJPHLxJcPJ2LdptMtDZtTjY97bWwkBzMvd8aKGnVT5kg+1kmIjmeIvq4gZ
         bNwjfHkz4FkNSoi60NK5EJnDlKSQ98tGIx7B52bb3HqQfxVAR9lDU/K4icCYVBx19mzx
         poiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706582261; x=1707187061;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1Nf7ZAE4lUdPHPJYVXVTuVeF2gxZD1vrM/mMUbDvf/w=;
        b=TJFWlKIKrMnDBu7D0ufr/B7u/rYmPoDMptKnNPeWzkYLluDHQcofJf4fxihAmFlz6n
         xhXDVN4nQqJupEgh8c8NZ7ox+m3dfZYZq1r9Lk12CgfZ1wge1OVt+AWHwKV+/y/MYGyI
         Wen/JoHjkf5scayt+g1NPhIuE1jCryYK0wwcCOBxkscR1e7bApvOXNPvvDdaOZz9HYkT
         9UE3fSp9g+VQm8NbZgVD0FPv8V8B9oqX89JbcanG1tKtsLxNLEeI1A8hDyjbveSoKLLy
         VuC8xf2E1xAxpTDQf1BZ534NVX1ToyE6XB06UTHnJlSRUl0k5y7LwjZ/bYmYbyALoaKs
         KD1Q==
X-Gm-Message-State: AOJu0YzDTefBu/EcjXkkzfbLwJ7yxa4ifVqkPLS1Zgz7Fojv5soxuF9g
	16PAA0cqklls1kdTZX53hXYTYiwsfjxN+UDKZfbj5Y3yv20lDFThwDfa+9p65CjGe9eeQkuAkXV
	X3lV0vs0pYwPJ0YTmPX11pCDUf5msgrJjL55kufYMIMs=
X-Google-Smtp-Source: AGHT+IEAXhI5XMsUEZlfm8ZJ9kk+bnWCQ4wvDsNOoWmuR6EdN6gc+DKb+xIyNimqPRxtbyMJ/SJtg1F5mRRyfsomJtI=
X-Received: by 2002:a25:abc3:0:b0:dc6:7156:d2cc with SMTP id
 v61-20020a25abc3000000b00dc67156d2ccmr2857608ybi.82.1706582261010; Mon, 29
 Jan 2024 18:37:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240129054551.57728-1-ioworker0@gmail.com> <CAHbLzkqrTPZD_Fz_a5LYa49Tum_Za=J9dX_SRyTr=kVZA26RAg@mail.gmail.com>
 <CAAa6QmSSKFjzdG62MZ5bSrhP19AjPEr339WXaWY=OCLsGWVE8w@mail.gmail.com>
In-Reply-To: <CAAa6QmSSKFjzdG62MZ5bSrhP19AjPEr339WXaWY=OCLsGWVE8w@mail.gmail.com>
From: Lance Yang <ioworker0@gmail.com>
Date: Tue, 30 Jan 2024 10:37:26 +0800
Message-ID: <CAK1f24mFmqTmBcx2YqQ=TwD0xhA1DhLwPhONp18yzqKdC--K=w@mail.gmail.com>
Subject: Re: [PATCH 1/1] mm/khugepaged: bypassing unnecessary scans with
 MMF_DISABLE_THP check
To: "Zach O'Keefe" <zokeefe@google.com>
Cc: Yang Shi <shy828301@gmail.com>, akpm@linux-foundation.org, mhocko@suse.com, 
	david@redhat.com, songmuchun@bytedance.com, peterx@redhat.com, 
	minchan@kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hey Zach,

Thanks for taking time to review!

On Tue, Jan 30, 2024 at 3:04=E2=80=AFAM Zach O'Keefe <zokeefe@google.com> w=
rote:
[...]
> IIUC, there really isn't any correctness race. Claim is just that we

Yes, there is indeed no correctness race.

> can avoid a number of per-vma checks. AFAICT, any task w/
> MMF_DISABLE_THP set will always have each and every vma checked
> (albeit, with a very inexpensive ->vm_mm->flags check)
[...]

IMO, for any task with MMF_DISABLE_THP set, the check
for each VMA can be skipped to avoid redundant operations,
(with a very inexpensive ->mm->flags check)
especially in scenarios with a large address space.

BR,
Lance

On Tue, Jan 30, 2024 at 3:04=E2=80=AFAM Zach O'Keefe <zokeefe@google.com> w=
rote:
>
> On Mon, Jan 29, 2024 at 10:53=E2=80=AFAM Yang Shi <shy828301@gmail.com> w=
rote:
> >
> > On Sun, Jan 28, 2024 at 9:46=E2=80=AFPM Lance Yang <ioworker0@gmail.com=
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
> >
> > The later thp_vma_allowable_order() does check whether MMF_DISABLE_THP
> > is set or not. And the hugepage_vma_revalidate() after re-acquiring
> > mmap_lock does the same check too. The checking in khugepaged should
> > be already serialized with prctl, which takes mmap_lock in write.
>
> IIUC, there really isn't any correctness race. Claim is just that we
> can avoid a number of per-vma checks. AFAICT, any task w/
> MMF_DISABLE_THP set will always have each and every vma checked
> (albeit, with a very inexpensive ->vm_mm->flags check)
>
> Thanks,
> Zach
>
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

