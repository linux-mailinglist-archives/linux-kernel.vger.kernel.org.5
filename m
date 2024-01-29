Return-Path: <linux-kernel+bounces-43367-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C745D8412C0
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 19:53:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B924286FCF
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 18:53:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDD871D687;
	Mon, 29 Jan 2024 18:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GiVLHyhu"
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE00812E5B
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 18:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706554402; cv=none; b=D/ArpqUvVaKqc6TAI+pBnvZ3Y8iEBg2Jrs13y1Jd9l/0xim44o1ygQeGX6uNVtg7H3BZS+OcqOxFkzY9b+jZGGoD82RwjDtidBvzTyAxRJC5L7Kfgc5x7+EaOLp5QtuNH7kyzOknFH8T6yEzKvjM3sUd/YDpfVIi8h4YQyDeG+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706554402; c=relaxed/simple;
	bh=e46CDQC6uKugIcK7ZKiaqR2cg59h/PM+/S55yLHdC/4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RfM5KNaZaI3pPJ85V1jKsfnK/A2+rHC8IQLcL7Zpo4XZeO3itermEqam/hzJGIvaXWiNpJWhrc/yLEjYdWkZj3esYbcO7kZDGklKTU9pV5XSf7GU3bGah6zSx4p5kJ8ip1i5MPXaFoVzCq1RUq4vhSt7xX5qTp6EEal0u0pk8a4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GiVLHyhu; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-2901ac9ba23so1513421a91.3
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 10:53:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706554400; x=1707159200; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+YwmkIaURVZ8vPjIbvRHrGqiyqFCmwDrlPD7H+kz8UE=;
        b=GiVLHyhu2rtOe0Pg5B3kL7JOL+g4nWxd5wyS/emznj4r3eoAtwyryKB5vw7+Okd6MO
         5SqB1HgI+lNGpIw+c6uSHvy9Hyui/yxp717nthagRMZ1SRyLTEC1j/on7ZGIMd5pA+8b
         Ggu7uOFGKd2D4z4KqAU0eSUQYvJHhrIRa4a6MaWEgxlrTGEO4r4wvB8CEnHQPdRZ9Fx4
         ecFHsNVNau9RD5a+vT/gqb42Ua7jr2caH7aBQRBCKORzbWX26vrPnUOYFoaei4BSuhqe
         XPU2bAmsh8vVLBLeoVQWDHY+i+CZ5lg8gahA8SImEl3xCaSf6wG7I8jPfsRw/lTf/4x+
         XeuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706554400; x=1707159200;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+YwmkIaURVZ8vPjIbvRHrGqiyqFCmwDrlPD7H+kz8UE=;
        b=MhqLN4S1jeVvpz3KwAuuEmqLQzdD6Pfu+BuW7M98YGLYisfNeTpWRzrSEHl2+q5CHV
         hP4aYevPr9qNyAy1Gx3o6UmVpiGPQgyUrCEVxRxP1V13hxEqdiX+cIq7FmjhPd+5/3T4
         EfOz9UPoJR0ecof/T1vrDN0PPUMlDjJjwb3Is4d+8qeq5jp4UoSwNe0LGlGcoLwUcauj
         sp1SLm/nmmWIyNh9IXdGtR57/vdS2v2+5Pthqp58yZVxz32Z0Scyhe5D5bEqmgq01YAy
         FB+BvvFDrfhIcy30GbFf+CaWnLgg0MGkU93ow6l734bCpEi9E6XLa2iVtpUbQWdLx+OS
         OIVw==
X-Gm-Message-State: AOJu0Yx1FCzJUelfeHR37cdJbBvMD5LTls2o9mRd+3L1RvFd0wZHnOYE
	zfQSDbq60tL4hjexkhio2fjhaoD2Wik11xvWKNaTUYhKedMld06QDl2L4trcCPzk5d4M5U5w72A
	otUhTEcKCwYzqJzY+yMj4l3pxBzU=
X-Google-Smtp-Source: AGHT+IFIzCfOdhT8ezi11yOAP4WRj9BoQB4VbdwxVvfa4oJDrxmfXQeNnWop+4JG9vj2143VUB2qaLHZ0+W6RMHzfF8=
X-Received: by 2002:a17:90a:ad06:b0:295:891f:aa19 with SMTP id
 r6-20020a17090aad0600b00295891faa19mr1479785pjq.16.1706554399900; Mon, 29 Jan
 2024 10:53:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240129054551.57728-1-ioworker0@gmail.com>
In-Reply-To: <20240129054551.57728-1-ioworker0@gmail.com>
From: Yang Shi <shy828301@gmail.com>
Date: Mon, 29 Jan 2024 10:53:07 -0800
Message-ID: <CAHbLzkqrTPZD_Fz_a5LYa49Tum_Za=J9dX_SRyTr=kVZA26RAg@mail.gmail.com>
Subject: Re: [PATCH 1/1] mm/khugepaged: bypassing unnecessary scans with
 MMF_DISABLE_THP check
To: Lance Yang <ioworker0@gmail.com>
Cc: akpm@linux-foundation.org, mhocko@suse.com, zokeefe@google.com, 
	david@redhat.com, songmuchun@bytedance.com, peterx@redhat.com, 
	minchan@kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jan 28, 2024 at 9:46=E2=80=AFPM Lance Yang <ioworker0@gmail.com> wr=
ote:
>
> khugepaged scans the entire address space in the
> background for each given mm, looking for
> opportunities to merge sequences of basic pages
> into huge pages. However, when an mm is inserted
> to the mm_slots list, and the MMF_DISABLE_THP flag
> is set later, this scanning process becomes
> unnecessary for that mm and can be skipped to avoid
> redundant operations, especially in scenarios with
> a large address space.
>
> This commit introduces a check before each scanning
> process to test the MMF_DISABLE_THP flag for the
> given mm; if the flag is set, the scanning process
> is bypassed, thereby improving the efficiency of
> khugepaged.
>
> Signed-off-by: Lance Yang <ioworker0@gmail.com>
> ---
>  mm/khugepaged.c | 18 ++++++++++++------
>  1 file changed, 12 insertions(+), 6 deletions(-)
>
> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> index 2b219acb528e..d6a700834edc 100644
> --- a/mm/khugepaged.c
> +++ b/mm/khugepaged.c
> @@ -410,6 +410,12 @@ static inline int hpage_collapse_test_exit(struct mm=
_struct *mm)
>         return atomic_read(&mm->mm_users) =3D=3D 0;
>  }
>
> +static inline int hpage_collapse_test_exit_or_disable(struct mm_struct *=
mm)
> +{
> +       return hpage_collapse_test_exit(mm) ||
> +              test_bit(MMF_DISABLE_THP, &mm->flags);
> +}
> +
>  void __khugepaged_enter(struct mm_struct *mm)
>  {
>         struct khugepaged_mm_slot *mm_slot;
> @@ -1422,7 +1428,7 @@ static void collect_mm_slot(struct khugepaged_mm_sl=
ot *mm_slot)
>
>         lockdep_assert_held(&khugepaged_mm_lock);
>
> -       if (hpage_collapse_test_exit(mm)) {
> +       if (hpage_collapse_test_exit_or_disable(mm)) {
>                 /* free mm_slot */
>                 hash_del(&slot->hash);
>                 list_del(&slot->mm_node);
> @@ -2360,7 +2366,7 @@ static unsigned int khugepaged_scan_mm_slot(unsigne=
d int pages, int *result,
>                 goto breakouterloop_mmap_lock;
>
>         progress++;
> -       if (unlikely(hpage_collapse_test_exit(mm)))
> +       if (unlikely(hpage_collapse_test_exit_or_disable(mm)))
>                 goto breakouterloop;
>
>         vma_iter_init(&vmi, mm, khugepaged_scan.address);
> @@ -2368,7 +2374,7 @@ static unsigned int khugepaged_scan_mm_slot(unsigne=
d int pages, int *result,
>                 unsigned long hstart, hend;
>
>                 cond_resched();
> -               if (unlikely(hpage_collapse_test_exit(mm))) {
> +               if (unlikely(hpage_collapse_test_exit_or_disable(mm))) {

The later thp_vma_allowable_order() does check whether MMF_DISABLE_THP
is set or not. And the hugepage_vma_revalidate() after re-acquiring
mmap_lock does the same check too. The checking in khugepaged should
be already serialized with prctl, which takes mmap_lock in write.

>                         progress++;
>                         break;
>                 }
> @@ -2390,7 +2396,7 @@ static unsigned int khugepaged_scan_mm_slot(unsigne=
d int pages, int *result,
>                         bool mmap_locked =3D true;
>
>                         cond_resched();
> -                       if (unlikely(hpage_collapse_test_exit(mm)))
> +                       if (unlikely(hpage_collapse_test_exit_or_disable(=
mm)))
>                                 goto breakouterloop;
>
>                         VM_BUG_ON(khugepaged_scan.address < hstart ||
> @@ -2408,7 +2414,7 @@ static unsigned int khugepaged_scan_mm_slot(unsigne=
d int pages, int *result,
>                                 fput(file);
>                                 if (*result =3D=3D SCAN_PTE_MAPPED_HUGEPA=
GE) {
>                                         mmap_read_lock(mm);
> -                                       if (hpage_collapse_test_exit(mm))
> +                                       if (hpage_collapse_test_exit_or_d=
isable(mm))
>                                                 goto breakouterloop;
>                                         *result =3D collapse_pte_mapped_t=
hp(mm,
>                                                 khugepaged_scan.address, =
false);
> @@ -2450,7 +2456,7 @@ static unsigned int khugepaged_scan_mm_slot(unsigne=
d int pages, int *result,
>          * Release the current mm_slot if this mm is about to die, or
>          * if we scanned all vmas of this mm.
>          */
> -       if (hpage_collapse_test_exit(mm) || !vma) {
> +       if (hpage_collapse_test_exit_or_disable(mm) || !vma) {
>                 /*
>                  * Make sure that if mm_users is reaching zero while
>                  * khugepaged runs here, khugepaged_exit will find
> --
> 2.33.1
>

