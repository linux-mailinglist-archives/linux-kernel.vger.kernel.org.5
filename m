Return-Path: <linux-kernel+bounces-143896-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D522A8A3EE4
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 23:47:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D7B72819FA
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 21:47:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 591EF56452;
	Sat, 13 Apr 2024 21:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cZXIFMkr"
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D2065473D
	for <linux-kernel@vger.kernel.org>; Sat, 13 Apr 2024 21:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713044830; cv=none; b=J9MtTiSVtjATJmZ+PVEFGysCd80ZSzBamyZTa2N2jjAkXV+E+Y+EF5kPC4ZZSqxHsPnCgoxMBlnBC3wgeulpP/chWvWXSovvnhZMRcvzcl0WtJtzE1fmHCGTCxDcAE+WIJ7Ro6w3vfIWW04UdVYip6zqay28wPe8EUt5DSaBBDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713044830; c=relaxed/simple;
	bh=TaCnm/Obc7Z0vp+ngc+DAzlWcSpLUpikAtOTSogEtCk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=u3gbNtQx9oB7mY4PI8Vgdyb24NNZIQTJ/Kl8yfQxNTsZMQnKYyNU2FSZrREv04jlE/pi5ax4UIQA0gkdkI/B1Z2qRHjm51fOGt9NFjV2IZfRiDa1uvx3oN0fN23MY/NvDAYD1oTGXcDqFkhC0X/oVbfXzpMdKmwa6amKN5IU5No=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cZXIFMkr; arc=none smtp.client-ip=209.85.219.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-dcc71031680so1928974276.2
        for <linux-kernel@vger.kernel.org>; Sat, 13 Apr 2024 14:47:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713044828; x=1713649628; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mH5yU1UU4J6v01NpTBvFGYdIvUalUK5gzhtQ+379C/I=;
        b=cZXIFMkrhdUXgy1InkmtJfkj+vRQNBaX5GarVZQwbWoO8TGSc7s8zEYTtB4cmaEijv
         WHRzAiMdHQCwGCQ5cnNHffekyvwkplyGHO4yKhXwSJd5zZfvHVVX+FWGZ5tLai+yrQhb
         abXjpB/KM320vEG19gDQs8vqZivIUQ4jkiiXD+uiuwEv1R9UnkBqLlKG8xjXJmVb9t+t
         di4/Hqs0JxruQKyEP8BKidbIXSFuRgpOXLAdb4ExEmTU54k8+mJZc05YkspHAvReVVzN
         l94L/nH394VnMGRTkX5FycpA03l8YLYpZ7JgaakSEJ6kOQM37PaXXIh7KPOkE+YOvio/
         cbtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713044828; x=1713649628;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mH5yU1UU4J6v01NpTBvFGYdIvUalUK5gzhtQ+379C/I=;
        b=XIMrNWY+TDOuY8gWya7d0eHi35f0TQGdcbGRPKXZpQm/GpmhaUBKApDGNPuYSL7GYX
         gBmBM8F1BOvMwa6GMcE5v2kkOVXXC3TnH5RKVbY34hWhvxOUDZOX0urAUvfKBg0WRdPe
         KHUFCIRXcSMSAFrnej3FFAae64t/1vy33/I00XAY7GE8W5BCNt8w5+/RDUpWtAgnLeY/
         gbANfUjCLslwgH8U7Qey4hx34yDEHh9WEsmj06iUkuvdVnKmJvR8Jm31Im/z2dJk4ibv
         bh2b7raIxI1du7GXPGV9SgXmxU/bF3oEz38XafVlIudJ98uJbm5Meqn3Q51KfI6Qu6ZU
         syTQ==
X-Forwarded-Encrypted: i=1; AJvYcCUume/pkHD3i/o2WgoC5gn2uR4qPDA6PTxPAhgQsV6CPvYJo5EFXbWuojnS/GhIjnm6C+ND+j1hj9PsuYDNP5Fm6t3df1qAG38QtVVW
X-Gm-Message-State: AOJu0Ywhw/MZgVC8k1wz/cCtSZqa/o8XArjUOn1imEKm+Bh87jLhXrha
	ju/V2C3YGDia4ZzBQH1HY6C1VNTvj2opWnj5IisVUDW6lMSJZxXwpEtFijRbIpOxmuQb212FYsM
	6KgoxFtH4v/vbNFkPyBMTWBKKkLBseTTNMzT5
X-Google-Smtp-Source: AGHT+IG/GjntQoa0HI5RhiEC8sNuWYHvstFUNYvTBidST9LMhJw1ALiwKoLNTqJRuae8Ce5p/NgKQrXV8iok42LLJt8=
X-Received: by 2002:a25:15c5:0:b0:dca:e4fd:b6d6 with SMTP id
 188-20020a2515c5000000b00dcae4fdb6d6mr5038035ybv.61.1713044827769; Sat, 13
 Apr 2024 14:47:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZhhSItiyLYBEdAX3@x1n> <ZhhV3PKgEX9d7_vA@casper.infradead.org>
 <ZhhaRXHKk7w_hKgi@x1n> <Zhhd-A7w1A8JUadM@casper.infradead.org>
 <ZhinCD-PoblxGFm0@casper.infradead.org> <ZhkrY5tkxgAsL1GF@x1n>
 <CAJuCfpG7YkQ2giKiv07TetTn=QHK9x723vnLaTjDCaQjUvAavw@mail.gmail.com>
 <ZhlCVOz7qaDtldfL@casper.infradead.org> <CAJuCfpGGUD6ev-KFhON2D2RqQRZSgjxFXvkNqeux-LrJw4L+iw@mail.gmail.com>
 <ZhlQ_4Ve0vYNbWbl@casper.infradead.org> <ZhlT4eG05mUcOQQJ@casper.infradead.org>
In-Reply-To: <ZhlT4eG05mUcOQQJ@casper.infradead.org>
From: Suren Baghdasaryan <surenb@google.com>
Date: Sat, 13 Apr 2024 14:46:56 -0700
Message-ID: <CAJuCfpENhnjnrDPfJPyYaNNLT9VT414VbT45WBoN-EkqTjGMtA@mail.gmail.com>
Subject: Re: [PATCH] mm: Always sanity check anon_vma first for per-vma locks
To: Matthew Wilcox <willy@infradead.org>
Cc: Peter Xu <peterx@redhat.com>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org, 
	Andrew Morton <akpm@linux-foundation.org>, Lokesh Gidra <lokeshgidra@google.com>, 
	Alistair Popple <apopple@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 12, 2024 at 8:31=E2=80=AFAM Matthew Wilcox <willy@infradead.org=
> wrote:
>
> On Fri, Apr 12, 2024 at 04:19:27PM +0100, Matthew Wilcox wrote:
> > On Fri, Apr 12, 2024 at 09:53:29AM -0500, Suren Baghdasaryan wrote:
> > > Unless vmf_anon_prepare() already explains why vma->anon_vma poses a
> > > problem for per-vma locks, we should have an explanation there. This
> > > comment would serve that purpose IMO.
> >
> > I'll do you one better; here's some nice kernel-doc for
> > vmd_anon_prepare():
>
> And here's a followup patch to fix some minor issues in uffd.
>
>  - Rename lock_vma() to uffd_lock_vma() because it really is uffd
>    specific.

I'm planning to expand the scope of lock_vma() and reuse it for
/proc/pid/maps reading under per-VMA locks. No objection to renaming
it for now but I'll likely rename it back later once it's used in more
places.

>  - Remove comment referencing unlock_vma() which doesn't exist.
>  - Fix the comment about lock_vma_under_rcu() which I just made
>    incorrect.
>
> diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
> index f6267afe65d1..a32171158c38 100644
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
> @@ -1437,7 +1435,7 @@ static int uffd_move_lock(struct mm_struct *mm,
>         struct vm_area_struct *vma;
>         int err;
>
> -       vma =3D lock_vma(mm, dst_start);
> +       vma =3D uffd_lock_vma(mm, dst_start);
>         if (IS_ERR(vma))
>                 return PTR_ERR(vma);
>
> @@ -1452,7 +1450,7 @@ static int uffd_move_lock(struct mm_struct *mm,
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
> @@ -1474,7 +1472,7 @@ static int uffd_move_lock(struct mm_struct *mm,
>         err =3D find_vmas_mm_locked(mm, dst_start, src_start, dst_vmap, s=
rc_vmap);
>         if (!err) {
>                 /*
> -                * See comment in lock_vma() as to why not using
> +                * See comment in uffd_lock_vma() as to why not using
>                  * vma_start_read() here.
>                  */
>                 down_read(&(*dst_vmap)->vm_lock->lock);

