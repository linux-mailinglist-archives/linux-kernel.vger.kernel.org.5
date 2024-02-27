Return-Path: <linux-kernel+bounces-83903-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E8C1869FFB
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 20:16:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A9E90B2FBEF
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 19:13:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 806A351C34;
	Tue, 27 Feb 2024 19:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UNW9S+fS"
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FF5052F75
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 19:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709061213; cv=none; b=RMZ3tSh6I3/leHcwoyshdfBMUe3i0fs36w/Qywaw9pWanqudW9XbxfhbOmtN9fgoQaRRvOUlJGbpOqVPItOrqGtmI1DRl0Q0qoW+YhDw92+BLo8nLbTzQC2IqgfonPe2B4Hp6z6VLEYYKwesarsMVYXziea2XBYDS8srkW0o8Qg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709061213; c=relaxed/simple;
	bh=LBkRRri5lOqofO6BZrkIFyBWNzE92eGEiK2jzbe8HAI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=r4BvXbXO7YsPcgDHQyu3lsr6DJlpFqiVS7bhzQjEuxD3g0xgVEap5VN0KxKlBL31hyAvDp+pNaDjPJvgakTnDYXgrks5f4DL+9pZxbUyvaF+yIJv0ZBuEHrmfn5lzkKsK7noadpmgpcQpZrdh2IIHi34xnD4krAS30Pt+xALjoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UNW9S+fS; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-5d8ddbac4fbso3886559a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 11:13:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709061212; x=1709666012; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iBJKbsd4wIdKds37USwOrWAAhA255FzoeAt9UUCRGXc=;
        b=UNW9S+fSUscU5vhGyOB3w8zCNC8p4rdLsK+P93y7DAYtpTSpWco3bdyde6ZJREM2Zs
         C3Ru2s3iJtzVH6xylJeRK7lyoMMRGWqEvf6Q8WnUmpwAaL9bpsUmjLREBKxVzSYuIXt0
         svj+J1KtYwlXQl8KZAkFrfsf1l0LwHbGblac3EFia6E15+VGcKll842AZ4MVg84Xz/R7
         ryMNmgtISiU1xupQbFja2TcJw8M6PynJ4GE+9hWagT0HKlh/LN7DxSbxDThZZTNXntWO
         RWRmu5jpj7aMjGnFsGdlcs4nyTcdOAha51E4sFaWE7yVIJjF+wqWIsQd9fbTdEYVerm2
         ZV4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709061212; x=1709666012;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iBJKbsd4wIdKds37USwOrWAAhA255FzoeAt9UUCRGXc=;
        b=smclCryUZpGW0XA3bYTcKhkgKBTtJ8SkGT6ME+gtTdT54d4nbi51arqXJzdbLnBh8p
         4FhXT+0K3K7/vk5DpzYn0jDoC/xNJ/IB3JyNcEHLgpRP06aTCjYqyJ1lwVR7+W21sV4j
         Bp5A3ztLsEj8DVE+emdtvdTu4E9kdzzxxf9n3HYI7MmqD/vnWmHHcbfa9vNQ3KK4OUZa
         z2Z1g0WOO2whJlc7A0ROqAEj19bkp0aYG7kAvLSWFSXcdHhDc2cft9LEIIlTSSksXnfU
         BeWaAZb8jMgBenn6TGbMIKNSkHwW+1JhIwUzcOKJRkFV9roVHTTocE+fj367DQ3tOBtD
         LJMw==
X-Forwarded-Encrypted: i=1; AJvYcCXD7hnrDPVDf9nwjWDc96jFEqVlF2NvGhr+xqQXaDQ/ziOTVNroa0PoQhSY8hHeN3nnoA3ZcLE8nlXgwaWCGFJ9HRHi6TDcjEijIndZ
X-Gm-Message-State: AOJu0YxmWYedlLMSjC4+ERKyfR2w9VE/gNnqM8zJGQIPFKRwHq2uiUaU
	xvn+wXN41q+SvRNpM4JtP2yUKxZiP5G3eD9yspZ1MUmYnQMbpRma6uR9/Tw5TG9R3wobOzNiNPY
	3E1wEdQFAur/Ef69TnwI4kN22bkE=
X-Google-Smtp-Source: AGHT+IHSN5qjnCnPdtOApqmCnCgsyXU11KA4GxFAczsdYUf2buDmdN+hfpvM8/FpiV81mxo6JYdi3Zbs+sl4LCVi710=
X-Received: by 2002:a17:90a:bf0a:b0:29a:68ad:b77e with SMTP id
 c10-20020a17090abf0a00b0029a68adb77emr8525394pjs.19.1709061211735; Tue, 27
 Feb 2024 11:13:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240227035135.54593-1-ioworker0@gmail.com>
In-Reply-To: <20240227035135.54593-1-ioworker0@gmail.com>
From: Yang Shi <shy828301@gmail.com>
Date: Tue, 27 Feb 2024 11:13:19 -0800
Message-ID: <CAHbLzkoQ1wFjA5aR51K-XMW+shSVFgujJjKK+-OG4OfVFvgOyQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] mm/khugepaged: keep mm in mm_slot without
 MMF_DISABLE_THP check
To: Lance Yang <ioworker0@gmail.com>
Cc: akpm@linux-foundation.org, mhocko@suse.com, zokeefe@google.com, 
	david@redhat.com, songmuchun@bytedance.com, peterx@redhat.com, 
	minchan@kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 26, 2024 at 7:51=E2=80=AFPM Lance Yang <ioworker0@gmail.com> wr=
ote:
>
> Previously, we removed the mm from mm_slot and dropped mm_count
> if the MMF_THP_DISABLE flag was set. However, we didn't re-add
> the mm back after clearing the MMF_THP_DISABLE flag. Additionally,
> We add a check for the MMF_THP_DISABLE flag in hugepage_vma_revalidate().
>
> Fixes: 879c6000e191 ("mm/khugepaged: bypassing unnecessary scans with MMF=
_DISABLE_THP check")

I think Andrew will fold this fix into your original patch.

>
> Signed-off-by: Lance Yang <ioworker0@gmail.com>
> Suggested-by: Yang Shi <shy828301@gmail.com>

Reviewed-by: Yang Shi <shy828301@gmail.com>

> ---
>  mm/khugepaged.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> index 2771fc043b3b..1c0073daad82 100644
> --- a/mm/khugepaged.c
> +++ b/mm/khugepaged.c
> @@ -920,7 +920,7 @@ static int hugepage_vma_revalidate(struct mm_struct *=
mm, unsigned long address,
>  {
>         struct vm_area_struct *vma;
>
> -       if (unlikely(hpage_collapse_test_exit(mm)))
> +       if (unlikely(hpage_collapse_test_exit_or_disable(mm)))
>                 return SCAN_ANY_PROCESS;
>
>         *vmap =3D vma =3D find_vma(mm, address);
> @@ -1428,7 +1428,7 @@ static void collect_mm_slot(struct khugepaged_mm_sl=
ot *mm_slot)
>
>         lockdep_assert_held(&khugepaged_mm_lock);
>
> -       if (hpage_collapse_test_exit_or_disable(mm)) {
> +       if (hpage_collapse_test_exit(mm)) {
>                 /* free mm_slot */
>                 hash_del(&slot->hash);
>                 list_del(&slot->mm_node);
> @@ -2456,7 +2456,7 @@ static unsigned int khugepaged_scan_mm_slot(unsigne=
d int pages, int *result,
>          * Release the current mm_slot if this mm is about to die, or
>          * if we scanned all vmas of this mm.
>          */
> -       if (hpage_collapse_test_exit_or_disable(mm) || !vma) {
> +       if (hpage_collapse_test_exit(mm) || !vma) {
>                 /*
>                  * Make sure that if mm_users is reaching zero while
>                  * khugepaged runs here, khugepaged_exit will find
> --
> 2.33.1
>

