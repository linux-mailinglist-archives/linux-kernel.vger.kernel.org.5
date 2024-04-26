Return-Path: <linux-kernel+bounces-160277-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 831628B3B49
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 17:25:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0209F1F217D3
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 15:25:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD5F914A600;
	Fri, 26 Apr 2024 15:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="miMaPaWE"
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88DCB143886
	for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 15:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714145011; cv=none; b=Y1fXWnVM90MNEe5A+ivAK+0DAFNRZbfCOsGxqfRQvHGD5qQEx2+qKY637eVE3FNb0wXEoxGDYOYKN1SgYC9WlKEq2++hVZZXRg4TmEu4N69nDgIRJMbTLH1e1nyBrNczY7YALi/WQnIfDN0IguU3W2cJCkzPH6Kpnlhy9lZ28nw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714145011; c=relaxed/simple;
	bh=iCt18BOvFIOjhGF+HusQ5DL1yCwbZwXLs9IUSPWGpYE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=O/cT7HrzYyc3pPIIwd3hs77UH09xD0/DbX2FZcxyI805Smi6EQK9wOcEz8B3F5rqxjodm4Rgx7FPvijq8az+Cc6uV/bFLE2C8fYkEgaNwnUOqx8/LZdMQ6snaCh3zy2VA+iH8KkDeewYnLeNuiDqGpdGxRCvnlo16ByZNbpBtC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=miMaPaWE; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-617ddc988f5so23388457b3.2
        for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 08:23:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714145008; x=1714749808; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9S/Vbi1rWTYHkgfpvQ1kviWugUk7qWwPSxIH68nf+es=;
        b=miMaPaWE17azsm1Ckg1hRwQ99RLnw+3FxzPwYDTwE0QF4VHHyTySIyEXMukzlwDDMq
         UKTgsr1FoGE81nZkvF3EyhCA3pQn9ORNC+isxM/8/wn1LpPPAnZH2ZyN2QYtGw1256Vx
         2FK0IwFtAuTf0e3qC0CnRm4FAOnWoTmQe+2SDXAUDneBa2gJhgTGdKHkLps3Y/guAdvh
         UZzFL9NPQDU1kHzyJuUe38jUJ+ASAKQ2BCp3uT33XSaF/JL+LyP3ITpSGKTnARHNTBNu
         HGW3feXzrrqFUtQ1Xtb2XG4QzCgPue+HgEm09KBXm2NO/0WDOeiuhIN8101JvIPRB6Ou
         4Fhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714145008; x=1714749808;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9S/Vbi1rWTYHkgfpvQ1kviWugUk7qWwPSxIH68nf+es=;
        b=p0BTGdF2ThXMKCNWH0isdXtIF1lb3I6P7yBxk2KMNEnbyCUau/lbPAA1fo24hYXnbe
         BoyVA+R66V7WsG71yXrjVcPUsiIHePBy7yTjoGOx2kP2IMoV7QK3+Hb/AXgTvs6T42UG
         OErl8K0l/W5cfmN2Cma/hXg2HPuRsNoq3JnB852gSw5GrdzNQyNSt3lLt+6WW3oHNJ5B
         FtYB2J2Wl2YglWnTUHkSLg/s4Es6wtyLGqZxOuLnZQIcmzbgL2PQmp0jJuXEPFCUTxdq
         z2SidCXZx30rDIDwiZFpG0FM5mEdtJIUNFZ2Trg8TLOZgh+Ky7jW29gNN5njU61phbyt
         Oxvg==
X-Forwarded-Encrypted: i=1; AJvYcCV08POnJmAduMNWHykGe1xSbiteFKWHprOsD96XAgu82OM+LUBl7PP8E/befxznuBjwfdSSUjgjuhiCv0XRk+6SsBfu97WJ6GqnwdjP
X-Gm-Message-State: AOJu0YwXsraLiILLFIuoV4MjJgp9jqOWN0LPz3d0bIVFetctpvWgFJZM
	IBjYJOhuRH8+4nuUo710Fky2xdCoRyH5qN0PlQTUkQGWprnGUne8nJiZWTN+mdyaY4UZValWw6L
	RNPTgRw6DuDrwF3d+v4enDkKG7m2KbML2uapjj1tFfD0z4gJnGQ==
X-Google-Smtp-Source: AGHT+IGvXhi2q6CEB1ib20Ig72BlIkAcES3YWowI9stDA3mzTwXuhXozoF3Ru4XUKmhjbm3nZy2tcUJhycQ0xzPM98M=
X-Received: by 2002:a05:690c:3706:b0:615:a86:f77b with SMTP id
 fv6-20020a05690c370600b006150a86f77bmr3177502ywb.26.1714145008244; Fri, 26
 Apr 2024 08:23:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240426144506.1290619-1-willy@infradead.org> <20240426144506.1290619-4-willy@infradead.org>
In-Reply-To: <20240426144506.1290619-4-willy@infradead.org>
From: Suren Baghdasaryan <surenb@google.com>
Date: Fri, 26 Apr 2024 08:23:17 -0700
Message-ID: <CAJuCfpFC-f7HV43rkeVTM6=DoF78y2YbnS8W0hCRzPSGgbkrbg@mail.gmail.com>
Subject: Re: [PATCH 3/4] mm: Fix some minor per-VMA lock issues in userfaultfd
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Peter Xu <peterx@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 26, 2024 at 7:45=E2=80=AFAM Matthew Wilcox (Oracle)
<willy@infradead.org> wrote:
>
> Rename lock_vma() to uffd_lock_vma() because it really is uffd specific.
> Remove comment referencing unlock_vma() which doesn't exist.
> Fix the comment about lock_vma_under_rcu() which I just made incorrect.
>
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>

Reviewed-by: Suren Baghdasaryan <surenb@google.com>

> ---
>  mm/userfaultfd.c | 20 +++++++++-----------
>  1 file changed, 9 insertions(+), 11 deletions(-)
>
> diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
> index e6486923263c..defa5109cc62 100644
> --- a/mm/userfaultfd.c
> +++ b/mm/userfaultfd.c
> @@ -56,17 +56,16 @@ struct vm_area_struct *find_vma_and_prepare_anon(stru=
ct mm_struct *mm,
>
>  #ifdef CONFIG_PER_VMA_LOCK
>  /*
> - * lock_vma() - Lookup and lock vma corresponding to @address.
> + * uffd_lock_vma() - Lookup and lock vma corresponding to @address.
>   * @mm: mm to search vma in.
>   * @address: address that the vma should contain.
>   *
> - * Should be called without holding mmap_lock. vma should be unlocked af=
ter use
> - * with unlock_vma().
> + * Should be called without holding mmap_lock.
>   *
>   * Return: A locked vma containing @address, -ENOENT if no vma is found,=
 or
>   * -ENOMEM if anon_vma couldn't be allocated.
>   */
> -static struct vm_area_struct *lock_vma(struct mm_struct *mm,
> +static struct vm_area_struct *uffd_lock_vma(struct mm_struct *mm,
>                                        unsigned long address)
>  {
>         struct vm_area_struct *vma;
> @@ -74,9 +73,8 @@ static struct vm_area_struct *lock_vma(struct mm_struct=
 *mm,
>         vma =3D lock_vma_under_rcu(mm, address);
>         if (vma) {
>                 /*
> -                * lock_vma_under_rcu() only checks anon_vma for private
> -                * anonymous mappings. But we need to ensure it is assign=
ed in
> -                * private file-backed vmas as well.
> +                * We know we're going to need to use anon_vma, so check
> +                * that early.
>                  */
>                 if (!(vma->vm_flags & VM_SHARED) && unlikely(!vma->anon_v=
ma))
>                         vma_end_read(vma);
> @@ -107,7 +105,7 @@ static struct vm_area_struct *uffd_mfill_lock(struct =
mm_struct *dst_mm,
>  {
>         struct vm_area_struct *dst_vma;
>
> -       dst_vma =3D lock_vma(dst_mm, dst_start);
> +       dst_vma =3D uffd_lock_vma(dst_mm, dst_start);
>         if (IS_ERR(dst_vma) || validate_dst_vma(dst_vma, dst_start + len)=
)
>                 return dst_vma;
>
> @@ -1436,7 +1434,7 @@ static int uffd_move_lock(struct mm_struct *mm,
>         struct vm_area_struct *vma;
>         int err;
>
> -       vma =3D lock_vma(mm, dst_start);
> +       vma =3D uffd_lock_vma(mm, dst_start);
>         if (IS_ERR(vma))
>                 return PTR_ERR(vma);
>
> @@ -1451,7 +1449,7 @@ static int uffd_move_lock(struct mm_struct *mm,
>         }
>
>         /*
> -        * Using lock_vma() to get src_vma can lead to following deadlock=
:
> +        * Using uffd_lock_vma() to get src_vma can lead to following dea=
dlock:
>          *
>          * Thread1                              Thread2
>          * -------                              -------
> @@ -1473,7 +1471,7 @@ static int uffd_move_lock(struct mm_struct *mm,
>         err =3D find_vmas_mm_locked(mm, dst_start, src_start, dst_vmap, s=
rc_vmap);
>         if (!err) {
>                 /*
> -                * See comment in lock_vma() as to why not using
> +                * See comment in uffd_lock_vma() as to why not using
>                  * vma_start_read() here.
>                  */
>                 down_read(&(*dst_vmap)->vm_lock->lock);
> --
> 2.43.0
>

