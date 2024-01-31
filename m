Return-Path: <linux-kernel+bounces-46140-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 09FD2843B23
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 10:30:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2ED061C28568
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 09:30:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5420C67E64;
	Wed, 31 Jan 2024 09:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J1pFQoza"
Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2280A67A1F
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 09:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706693426; cv=none; b=dDtz3WtczTbJyjoY0Le/K4z2Y699GoUfb2OSJbBm4dvK2E1AOfMs9DJQ7rGFVh7Ww2jyljs7PpjLGQBEhl6/EoQT9gGcAKSCZl+NkPYb5vPNBStXotjOGqriDhguKQFtmW7mXCToCKamILcKDPDVz7gZw4fvDKjSgEu+EZzLMqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706693426; c=relaxed/simple;
	bh=TVJL02G0kimP27mlX3sjX/UsIEhPEDElPeP+WCA5DWE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MgSlddLsvgOzoQOzpQfFTGglyjZvd0OCJHmICLqUTnY1h7F626PJJg8GhnWqwuoY2g/PIEaAX9+5QhwP6mq6Mh1veAg3nfsAEGtZTLHIc8LSR4S7X3vfJsH0lqbt/Y6F+MsaZGH/JqvVXRIrGyrLJ1D7mcYLeFFwRN5f1TQ1c3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J1pFQoza; arc=none smtp.client-ip=209.85.219.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-dc261316b0dso4229530276.3
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 01:30:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706693423; x=1707298223; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n1hVXwdyUh5O4q5jCGS4m9GkNrPafUP16G5xoPdeqV0=;
        b=J1pFQozaAr6L+UELeK4QmpdAyag6ZVBS/ULmcVXi6w0jbYu2cn7ED1iaJbMJRcaGov
         MbzkMjLrJwfPxknixpxCp7zox/FWcipl6JGwWY+2ARWUgK/NkTsH8+7dGplL5Mfcc31x
         E1Yo+ojdZPrKSNnSoLjbFjqKHV0ft87ncDPJthqGQsU5Q6XtM3iHjA19naBKpRCPVmb9
         /ImIJnzcasOaDBVvMm2iuM1O+Z/xI6GjGcKanvgz8s+JJyyWLOYKx9vVZWO+Tck06mFD
         2FqYHlW7gPMKrlWUECEPusTLFGE1LS5LQSyBYQwXhUd89gWuV3XZLyfzZW1xu/8uqrwr
         XGLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706693423; x=1707298223;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n1hVXwdyUh5O4q5jCGS4m9GkNrPafUP16G5xoPdeqV0=;
        b=TDfXR4FHccIP+243gzO9izuOkd7qDy8LMYrnvflZDFp9k9UCt6D83GHTq5hd0TGxuu
         yjJZVcClcx/LMMQavjIiCsCX2CoxdhsLQX0HnwtukvwEi+g2dvdkgZTFMqQQyaMk3uYa
         bwW+GP2eO9Wm49fisJ8Z14AgkWFWs3QmsC1Mpv5ymmdS34OlF5QyUQfWi2nQrbJ4bvj9
         v2mX9h8OjJYWYdTemD6VbCx9pcp9fy5ZG03EBcuOy4nRU6EdAMzcV7stqULKjJAxWU5e
         Yejgtgi8P06zA3f7HVV2yR4lIZ9OS9lP2a8GbusXPaTWkTbVlWYJtOjxGIc/vwgecjU7
         8h2Q==
X-Gm-Message-State: AOJu0YzU3PGs5oQ4EeBXkbhIfbJEmQQNeKrDVu2gYSUOYEynvlCQ6pBi
	Jg+nSBbIHbWl/mjUuKJb5aZtYfV23w0cgreaYRR+OVCnOcGWMKd+sJ3dNQjH9bqHtCtTKZ/P9Ix
	3oMszv6S2RToqoe72Do3NYT6teVk=
X-Google-Smtp-Source: AGHT+IGh2bSmh+uIzdUeEPJ0o5bZ1WTxUmBY9WeH8Yyf8ltmNtPPrRirIzXstNlEqmjWLu9W4uzjyOnWnzzyimD7/9Q=
X-Received: by 2002:a25:ce90:0:b0:dc2:271e:51ec with SMTP id
 x138-20020a25ce90000000b00dc2271e51ecmr1071886ybe.11.1706693422887; Wed, 31
 Jan 2024 01:30:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240129054551.57728-1-ioworker0@gmail.com>
In-Reply-To: <20240129054551.57728-1-ioworker0@gmail.com>
From: Lance Yang <ioworker0@gmail.com>
Date: Wed, 31 Jan 2024 17:30:11 +0800
Message-ID: <CAK1f24keWtJNVv37r2vNsqnmMLRMvF-F76WR5RD_Y-BbAgEaYQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] mm/khugepaged: bypassing unnecessary scans with
 MMF_DISABLE_THP check
To: akpm@linux-foundation.org
Cc: mhocko@suse.com, zokeefe@google.com, david@redhat.com, 
	songmuchun@bytedance.com, shy828301@gmail.com, peterx@redhat.com, 
	minchan@kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Updating the change log.

khugepaged scans the entire address space in the
background for each given mm, looking for
opportunities to merge sequences of basic pages
into huge pages. However, when an mm is inserted
to the mm_slots list, and the MMF_DISABLE_THP
flag is set later, this scanning process becomes
unnecessary for that mm and can be skipped to
avoid redundant operations, especially in scenarios
with a large address space.

This commit introduces a check before each scanning
process to test the MMF_DISABLE_THP flag for the
given mm; if the flag is set, the scanning process is
bypassed, thereby improving the efficiency of khugepaged.

This optimization is not a correctness issue but rather an
enhancement to save expensive checks on each VMA
when userspace cannot prctl itself before spawning
into the new process.

On some servers within our company, we deploy a
daemon responsible for monitoring and updating local
applications. Some applications prefer not to use THP,
so the daemon calls prctl to disable THP before fork/exec.
Conversely, for other applications, the daemon calls prctl
to enable THP before fork/exec.

Ideally, the daemon should invoke prctl after the fork,
but its current implementation follows the described
approach. In the Go standard library, there is no direct
encapsulation of the fork system call; instead, fork and
execve are combined into one through syscall.ForkExec.

Thanks,
Lance

On Mon, Jan 29, 2024 at 1:46=E2=80=AFPM Lance Yang <ioworker0@gmail.com> wr=
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

