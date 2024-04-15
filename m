Return-Path: <linux-kernel+bounces-145492-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E56D8A56DD
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 17:58:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 307731C21CCD
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 15:58:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBD887F464;
	Mon, 15 Apr 2024 15:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="StCRRAdM"
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D51F2837D
	for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 15:58:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713196724; cv=none; b=nKuRpQAQpbKojjIft399lTNfhVE4NhlY4Anas3AwjZ1Fm6/GiNECvABKfFlQWW+5/ygyFooMv8H4PAyOIJlUtBeKwS196aCOrkmqAaAfJfhEjRV42lO1qFXkDDMOiLyf5245V1rBdP3eM4iU5XM9IfY5l88sGu+xlfKU46cIsUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713196724; c=relaxed/simple;
	bh=f8hTPpbMuE/W1bIMmiDJLYhkAj9bpOkgXFYOfTRZHjM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Q92slyMXQvWFHLpYIBuIeCROTXENiMrLI5J6CxelRPRtNd7xGb85XRpjnWedusKfOWKKkAuN3zov+19JCjzJcDUOs2bcnA5ixgTNlTDpkv+mngTqu3+zDTZKnpV6QxiHTWP3y6bqmYb/8qulwrX4Yz4/NL/EeGuvbF3Gb5ja0ZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=StCRRAdM; arc=none smtp.client-ip=209.85.219.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-dcc7cdb3a98so3141421276.2
        for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 08:58:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713196721; x=1713801521; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vQs4ugT2y6J/4IutYdKUBVbhJN3bb9YCkttNLEXXcuk=;
        b=StCRRAdMeJL+zc+txTslEv3fzwsXEb9ABWrL9EWskGSoxVE2FJ4obe8m33XOHZY7OA
         vKP2dYANxN9XBul6nDeZj1WL9l2BjmXM4oXAZ1CQMra/NCUDyF9JgZ5Y9ACW5C5Y0yVW
         H0dKw8Upz2JpdVSDpCgJfGhEsoZQ+3sjajFhsFcM9MNk8tSbhB7RKIlXR5tk3cBLlHag
         +r7nkCoPWv0g3SR3Tb5boFqDW+MCFQNfCQc0yexZ9TmNWuTJRZTbgXOOYJvhx8CH2dOi
         Tr0c6jCXhnr/o9kaQD64y5zc5ngxuayzfMWEJ1WRJaJpwTOL44uRsgDbOY0Yzm9Qhg2e
         0nIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713196721; x=1713801521;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vQs4ugT2y6J/4IutYdKUBVbhJN3bb9YCkttNLEXXcuk=;
        b=cauPsJSlcOOdzfYDOywfrp2WTkQY25DUDihZ+Sois7jgXuvxEGj1S+Jvy0lZLICAR6
         4J2lCOD03skOFsrl/Yf/DrN2wRUWiuhIlHOqW+tknfwvwceDtEVzhZMxMjgpoDWopxx7
         28CSfDNHjm2w3EbJ/E423F5WHzI90hStDLNb+9lDiTadnpP3/mQS9SVJ2ApvQ0LTsHtV
         Ovv2QsjJWCTTYhu3VKNgEkjgb9XY4BWiZx9waVnkBuKNhbhbGx5+nrtVf3FdZIibQ3MJ
         zMnfgSL3K3ehHnG+wIqea9WS0TbTyuNMGGY5rHyYMHj11aNY+TtrNZogWukgAWzLsZtL
         fyQA==
X-Forwarded-Encrypted: i=1; AJvYcCWGh3rgcUaI9ujXPVCZri48vNO19IJWgYQ/SsSIOOlUweeI2AF8SbHV4EgtsbIFv++i8pQrsf1y4HcXKeTc5YhIEtyodaKlDRDwAZbB
X-Gm-Message-State: AOJu0YyApXP1mbmbI3t8Q+/GKEeLp1jaS1XrPWmCcwQz+66uWcnQedSN
	icxTjfZRiziytoBrFsq29F1b3RObKwsBeqG3Qa/Hmcn40i8FzZeYtdcH2G87rExy+01+UB3Sqpn
	u/YrYsjr5wslPMSO83Hl3pY9OBRvF6EGTaHrf
X-Google-Smtp-Source: AGHT+IHj+dUON+x7kGfY5lFgFmSTO1gbp1zS1dRy20XQvezBONy3gNljvQoqw/0z2FVCc4FIrrRpwWxfBSbd20Fg1Rc=
X-Received: by 2002:a25:9e05:0:b0:dcc:99b6:830b with SMTP id
 m5-20020a259e05000000b00dcc99b6830bmr9897702ybq.19.1713196721063; Mon, 15 Apr
 2024 08:58:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240411171319.almhz23xulg4f7op@revolver> <ZhhSItiyLYBEdAX3@x1n>
 <ZhhV3PKgEX9d7_vA@casper.infradead.org> <ZhhaRXHKk7w_hKgi@x1n>
 <Zhhd-A7w1A8JUadM@casper.infradead.org> <ZhinCD-PoblxGFm0@casper.infradead.org>
 <ZhkrY5tkxgAsL1GF@x1n> <CAJuCfpG7YkQ2giKiv07TetTn=QHK9x723vnLaTjDCaQjUvAavw@mail.gmail.com>
 <ZhlCVOz7qaDtldfL@casper.infradead.org> <CAJuCfpGGUD6ev-KFhON2D2RqQRZSgjxFXvkNqeux-LrJw4L+iw@mail.gmail.com>
 <ZhlQ_4Ve0vYNbWbl@casper.infradead.org>
In-Reply-To: <ZhlQ_4Ve0vYNbWbl@casper.infradead.org>
From: Suren Baghdasaryan <surenb@google.com>
Date: Mon, 15 Apr 2024 08:58:28 -0700
Message-ID: <CAJuCfpH3sKvczqRix6Q6QX9L4FsHQbmnyFXetvY+TzVUk38soA@mail.gmail.com>
Subject: Re: [PATCH] mm: Always sanity check anon_vma first for per-vma locks
To: Matthew Wilcox <willy@infradead.org>
Cc: Peter Xu <peterx@redhat.com>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org, 
	Andrew Morton <akpm@linux-foundation.org>, Lokesh Gidra <lokeshgidra@google.com>, 
	Alistair Popple <apopple@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 12, 2024 at 8:19=E2=80=AFAM Matthew Wilcox <willy@infradead.org=
> wrote:
>
> On Fri, Apr 12, 2024 at 09:53:29AM -0500, Suren Baghdasaryan wrote:
> > Unless vmf_anon_prepare() already explains why vma->anon_vma poses a
> > problem for per-vma locks, we should have an explanation there. This
> > comment would serve that purpose IMO.
>
> I'll do you one better; here's some nice kernel-doc for
> vmd_anon_prepare():

I was looking at the find_tcp_vma(), which seems to be the only other
place where lock_vma_under_rcu() is currently used. I think it's used
there only for file-backed pages, so I don't think your change affects
that usecase but this makes me think that we should have some kind of
a warning for lock_vma_under_rcu() future users... Maybe your addition
of mmap_assert_locked() inside __anon_vma_prepare() is enough. Please
don't forget to include that assertion into your final patch.


>
> commit f89a1cd17f13
> Author: Matthew Wilcox (Oracle) <willy@infradead.org>
> Date:   Fri Apr 12 10:41:02 2024 -0400
>
>     mm: Delay the check for a NULL anon_vma
>
>     Instead of checking the anon_vma early in the fault path where all pa=
ge
>     faults pay the cost, delay it until we know we're going to need the
>     anon_vma to be filled in.  This will have a slight negative effect on=
 the
>     first fault in an anonymous VMA, but it shortens every other page fau=
lt.
>     It also makes the code slightly cleaner as the anon and file backed
>     fault handling look more similar.
>
>     Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
>
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index d8d2ed80b0bf..718f91f74a48 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -1057,11 +1057,13 @@ vm_fault_t do_huge_pmd_anonymous_page(struct vm_f=
ault *vmf)
>         gfp_t gfp;
>         struct folio *folio;
>         unsigned long haddr =3D vmf->address & HPAGE_PMD_MASK;
> +       vm_fault_t ret;
>
>         if (!thp_vma_suitable_order(vma, haddr, PMD_ORDER))
>                 return VM_FAULT_FALLBACK;
> -       if (unlikely(anon_vma_prepare(vma)))
> -               return VM_FAULT_OOM;
> +       ret =3D vmf_anon_prepare(vmf);
> +       if (ret)
> +               return ret;
>         khugepaged_enter_vma(vma, vma->vm_flags);
>
>         if (!(vmf->flags & FAULT_FLAG_WRITE) &&
> diff --git a/mm/memory.c b/mm/memory.c
> index 6e2fe960473d..46b509c3bbc1 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -3213,6 +3213,21 @@ static inline vm_fault_t vmf_can_call_fault(const =
struct vm_fault *vmf)
>         return VM_FAULT_RETRY;
>  }
>
> +/**
> + * vmf_anon_prepare - Prepare to handle an anonymous fault.
> + * @vmf: The vm_fault descriptor passed from the fault handler.
> + *
> + * When preparing to insert an anonymous page into a VMA from a
> + * fault handler, call this function rather than anon_vma_prepare().
> + * If this vma does not already have an associated anon_vma and we are
> + * only protected by the per-VMA lock, the caller must retry with the
> + * mmap_lock held.  __anon_vma_prepare() will look at adjacent VMAs to
> + * determine if this VMA can share its anon_vma, and that's not safe to
> + * do with only the per-VMA lock held for this VMA.
> + *
> + * Return: 0 if fault handling can proceed.  Any other value should be
> + * returned to the caller.
> + */
>  vm_fault_t vmf_anon_prepare(struct vm_fault *vmf)
>  {
>         struct vm_area_struct *vma =3D vmf->vma;
> @@ -4437,8 +4452,9 @@ static vm_fault_t do_anonymous_page(struct vm_fault=
 *vmf)
>         }
>
>         /* Allocate our own private page. */
> -       if (unlikely(anon_vma_prepare(vma)))
> -               goto oom;
> +       ret =3D vmf_anon_prepare(vmf);
> +       if (ret)
> +               return ret;
>         /* Returns NULL on OOM or ERR_PTR(-EAGAIN) if we must retry the f=
ault */
>         folio =3D alloc_anon_folio(vmf);
>         if (IS_ERR(folio))
> @@ -5821,15 +5837,6 @@ struct vm_area_struct *lock_vma_under_rcu(struct m=
m_struct *mm,
>         if (!vma_start_read(vma))
>                 goto inval;
>
> -       /*
> -        * find_mergeable_anon_vma uses adjacent vmas which are not locke=
d.
> -        * This check must happen after vma_start_read(); otherwise, a
> -        * concurrent mremap() with MREMAP_DONTUNMAP could dissociate the=
 VMA
> -        * from its anon_vma.
> -        */
> -       if (unlikely(vma_is_anonymous(vma) && !vma->anon_vma))
> -               goto inval_end_read;
> -
>         /* Check since vm_start/vm_end might change before we lock the VM=
A */
>         if (unlikely(address < vma->vm_start || address >=3D vma->vm_end)=
)
>                 goto inval_end_read;

