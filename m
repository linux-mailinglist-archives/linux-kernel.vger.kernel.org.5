Return-Path: <linux-kernel+bounces-143892-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C3BBA8A3ED4
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 23:42:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 323A61F21609
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 21:42:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27D035644B;
	Sat, 13 Apr 2024 21:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gAHj/Zd1"
Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C882F5473D
	for <linux-kernel@vger.kernel.org>; Sat, 13 Apr 2024 21:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713044529; cv=none; b=mLgu9bBkKHsu48O+oAI0sEUP3iaZyA2h0q6kW0fFg3/VwieiaBVgnjcdVdiSWbv2RDnr87vuaFLM+nLd6DaxHUhpornJJByVuPw9+8WL+bacV1Mg4U9hW4WIzv6eDvxpxHUqjnBlhad+9TaiApoXo7KPvcZC2+qdh8IZg4eNQV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713044529; c=relaxed/simple;
	bh=1F6jr/FB6s2a0maaxIQ5yCQrpRw949k6Lw2C7Rp4zMg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VH1VBwDiV2fYg1JaYpuMZzhS3DMldV+HOFpCLDZq+b7wcsRic52rHm03XUuQpbX634bqCltXxE7HptDXoWi2ISZa5p5/734GpuYud11DjI5FJDmbBd2C8Jc/GG8c0fHezIlKK9yBFH/vsMKBjUt5aIZZDK7MQjAWPn9m49wj1jo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gAHj/Zd1; arc=none smtp.client-ip=209.85.219.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-dcd7c526cc0so1901537276.1
        for <linux-kernel@vger.kernel.org>; Sat, 13 Apr 2024 14:42:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713044527; x=1713649327; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H5SznCkZxk/IFmHBV34npTiNaRojYfg7iFEK8KRaY3s=;
        b=gAHj/Zd1PdNzAKmUG3Hek6B+kMN/DLyzdig/ftTvKeFd25hYm0/e9Yk0t44F5o7I3D
         j2Ez39cxSaEwx19OjYiFl09Z6d+iAOyIT8o138L2+Mwunl6D8uN/xMt4+ycbSBqX1UCg
         gx7Mz4IMTqTbduIGJY7Js40EJmUH/ckdGKUljgnwXJN7k4LhDr1znt02tWcdasBKHo3s
         YpFV18wdhs/lTVyjIZ/SVG4XXlcJXhVeL9VvsY+cI7Zky2uFScMaJlAoU2lfvK08Q2hY
         uyPSpGvzO698JK7Ezr+It/bZuXDzOtJn2yZ7A8zNsHEGQkRZy/3iRmi0u2AqossySr99
         nLCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713044527; x=1713649327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H5SznCkZxk/IFmHBV34npTiNaRojYfg7iFEK8KRaY3s=;
        b=pzNwUSm10P6Jo3mXDZxPD9OqCdZJUPOGkPd8oPHdSsxBPYwB8j2pkMaWBiIAtIQIQW
         5UirNq1eV4bLhSvN3o3hWRxVFfrs6uiPZ35kb2tP89kvea1eqKKvXUJhFwiEBdtuLs+H
         X8uyvtCwzv2tiN5SI25lK0UsnUUmgFrd2PhfM2JyMRZz7WCYhVCY5OpEb+ly1uTFEEwK
         gefkclLgmJ2pE9lX/w7TS3GHJfA9rEe9XiGgCDioHIZL7465NylHsHZTOotf7uvLtDKE
         HU39VXToMs76SHA8XFYukfeWzU62oh6md6Q+muzI7BBI8++t/ooXNMCfWSRIQ/RbwIp6
         qSCw==
X-Forwarded-Encrypted: i=1; AJvYcCU1KdRToiv9HqBnekrdoC/BgOfeT2c8+i1BNsIUV3tQ8SSZrw59mAeVAae4z6e3ttBaX1+Gsg+Cu9pXyDoGYip/FmlJMCFWXX7NxpNw
X-Gm-Message-State: AOJu0YyZsMp5heOaR/Exs8qElEzhBnjN1dRA9xLgtnxSEiAbwvtVsdQj
	fx4pjDJHnT+y2j8PwPLeIzSFJw+5Dg0Q4Jogp4ryDWXqn4lum51af7Fcy7280WZTosf8ssA4zaG
	rJfzzeTSGb6L3tjaXIJedWbPiEKetqVO+PiTsqYWANW//Yyt6EA==
X-Google-Smtp-Source: AGHT+IExGEinrM+v5ONv6PmTFB4ZaVOzQQm7Zmt+sR6VM9hDFB5og76FYXA2h0tp1zEqMvog+k68jD5NUHas2t1k0lE=
X-Received: by 2002:a25:8106:0:b0:dc6:de64:f74 with SMTP id
 o6-20020a258106000000b00dc6de640f74mr5340865ybk.9.1713044526444; Sat, 13 Apr
 2024 14:42:06 -0700 (PDT)
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
Date: Sat, 13 Apr 2024 14:41:55 -0700
Message-ID: <CAJuCfpEaVpuVUu0kwfpfBVQmOqbGwLkjKbXsiP=TxxmCTitukg@mail.gmail.com>
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

The patch looks good to me but I would like to run benchmark tests to
see how it affects different workloads (both positive and negative
effects). I'll try to do that in this coming week and will report if I
find any considerable difference. For now:

Reviewed-by: Suren Baghdasaryan <surenb@google.com>

Also we should ensure that this patch goes together with the next one
adjusting related code in uffd. It would be better to resend them as
one patchset to avoid confusion.

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

