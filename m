Return-Path: <linux-kernel+bounces-67587-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CC82D856DCA
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 20:33:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F16511C24030
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 19:33:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55B9913959D;
	Thu, 15 Feb 2024 19:32:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="GC0GKqpX"
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CC0D139597
	for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 19:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708025558; cv=none; b=CXwUtTxKz4AgVsbZnocIjXmc0VycYOHEF0cTB5L46KuW16G5FuwOrkl0QaOhV7ztoPMPBJEaNwu7FqxUNepryXGqckBm9p/+9tejxv76nqvWA5IaFVqUwy0M23Ul3PYC7160yd9V2ODfa+9hWBTGFruz2K72rPZsW19XwYEd88Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708025558; c=relaxed/simple;
	bh=rvIGIWHcBrZr24YyvIEFJSm+SW5cOYp6J1lQY8lUQpU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hpTd6rZpTm4bSfKRvu35fcd6GmDZdZYuDO4UeTmbY8tZhnXu4XiAuqM5SDc9JP4uyXbj+1MMAf3dVM4q0Bpo09unJZeWIXG1QenQCU02FvEz8tt7K9t/eMdJAs7+krbe8eGdG5QjcCvTKyeX5PK6vF0t8DHMTqoZHJHXWYHDXE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=GC0GKqpX; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2d180d6bd32so189931fa.1
        for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 11:32:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1708025554; x=1708630354; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3dGnDa/Oz3aEvOxHec4vMljI2UxK10cMnGt8HfSxrBg=;
        b=GC0GKqpXS9v+UFITQw2SuziwFv/s+HFJOgIAea5us3rJloUo5CCA8fG1QC5ToNsHR0
         aFNzqGMU7vg1cnJOfaJnRRUPPUeYBNE6b4i9BdkJ1CJgZhdGzct6S6QFSnEYpmb81/2O
         +8raWO8DZT/YDQEY42Fn2GiKqtM7cMev2htLQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708025554; x=1708630354;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3dGnDa/Oz3aEvOxHec4vMljI2UxK10cMnGt8HfSxrBg=;
        b=a7g6lVtELetT87pbvqhPNiB3f2GKvbWZ9Cz0OCWXAYtyr9g5ho8cDY5YYsCtzMsc2i
         OkeIPKAZVZRkO9nbgprjCXyfwcubEtQ2U1ss95XAg36qz/vsD/9FXbkXvgbey6bNuHYs
         qFBEScXfaXdOo3GnmjDzdwFfcT+9wsuzFYX29xKD8IPfyyNPifbGnOKMxE1sqL1F9fFf
         SoDtaAJZEzuB+3SHsr5hjxlVtgGmdajPATpZKtGFjIoYS4a5IKIZOWQ+EeAJPHdcqZhw
         rgfaD0bWLm6vRDAgUaC3/Rd4mmPFVG6SbP38Rim4GkGWtx+M4X1OqzOGiQGjxujypKha
         76CA==
X-Forwarded-Encrypted: i=1; AJvYcCUnI5drLimC9uC8U7+6yxJNFu2LQtnS2VJdD8C4/o7Fa04qdxO2JdfxZzl9OEJ2eLu7HbtjYVpYAwBxY4sbMqNHHiNVTIs91vKIS23a
X-Gm-Message-State: AOJu0Yz2zlScGYFU2dy4Cam4jZlaEcuCvKRQFyE46sVvQG0KljGyXfx5
	a8I5DeCisaNY2R0w78EQjGKBqkn1/wBRyNaWUX77PAiKtC9a0+U+YSF9AOJ1bPv8VAMLqIZk7JW
	6K2zDPStjuhDbf3KOvG78l8B7QTJqAu/4foNC
X-Google-Smtp-Source: AGHT+IEVbBEHs+8TzdHU5nFoCSTlxCJ4YDxFneMchfi70LsN6iQzikVAXO5XF8i9r0M5Lp7YPsvU1djqtN1VwoTTOPw=
X-Received: by 2002:a2e:9792:0:b0:2d0:f872:6f16 with SMTP id
 y18-20020a2e9792000000b002d0f8726f16mr1952684lji.16.1708025554250; Thu, 15
 Feb 2024 11:32:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240214170720.v1.1.Ic3de2566a7fd3de8501b2f18afa9f94eadb2df0a@changeid>
 <20240215034528.240-1-hdanton@sina.com> <87h6iaf7di.wl-tiwai@suse.de>
 <CAG-rBigFG-U-sKY77CvzghGzs+1Xm3YXzBF6N4ti0+h6UdAb8Q@mail.gmail.com> <875xypk6d6.wl-tiwai@suse.de>
In-Reply-To: <875xypk6d6.wl-tiwai@suse.de>
From: Karthikeyan Ramasubramanian <kramasub@chromium.org>
Date: Thu, 15 Feb 2024 12:32:22 -0700
Message-ID: <CAJZwx_n6sGfgNgm-WKoHEgY-=L0r1HbbZc8p5LroF0etMSx=gg@mail.gmail.com>
Subject: Re: [PATCH v1] ALSA: memalloc: Fix indefinite hang in non-iommu case
To: Takashi Iwai <tiwai@suse.de>
Cc: Sven van Ashbrook <svenva@chromium.org>, Hillf Danton <hdanton@sina.com>, 
	LKML <linux-kernel@vger.kernel.org>, Brian Geffon <bgeffon@google.com>, 
	linux-sound@vger.kernel.org, Kai Vehmanen <kai.vehmanen@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 15, 2024 at 10:03=E2=80=AFAM Takashi Iwai <tiwai@suse.de> wrote=
:
>
> On Thu, 15 Feb 2024 17:07:38 +0100,
> Sven van Ashbrook wrote:
> >
> > Hi Takashi,
> >
> > On Thu, Feb 15, 2024 at 3:40=E2=80=AFAM Takashi Iwai <tiwai@suse.de> wr=
ote:
> > >
> > > Yes, the main problem is the indefinite hang from
> > > dma_alloc_noncontiguous().
> >
> > We have a publicly-visible test [1] which readily triggers the
> > indefinite hang on non-iommu Intel SoCs such as JasperLake.
> > As noted in the commit message, iommu SoCs are not currently
> > affected.
> >
> > > So, is the behavior more or less same even if you pass
> > > __GFP_RETRY_MAYFAIL to dma_alloc_noncontiguous()?  Or is this flag
> > > already implicitly set somewhere in the middle?  It shouldn't hang
> > > indefinitely, but the other impact to the system like OOM-killer
> > > kickoff may be seen.
> >
> > My incomplete understanding:
> >
> > Alsa specifies __GFP_RETRY_MAYFAIL because it wants to prevent triggeri=
ng
> > the OOM killer.
>
> Ah I forgot that we set that bit commonly in the flag.
>
> > This was __GFP_NORETRY in the not-too-distant past [2],
> > but that failed too quickly, which resulted in permanent loss of audio =
due
> > to failed firmware dma sg allocations.
>
> Hm, the change in commit a61c7d88d38c assumed that __GFP_RETRY_MAYFAIL
> shouldn't have that big impact.  If the hang really happens with a
> high order allocation, it's dangerous to use it in other code
> allocations than noncontiguous case (i.e. SNDRV_DMA_TYPE_DEV and co).
> In the tight memory situation, a similar problem can be triggered
> quite easily, then.
>
> > In the iommu case, dma_alloc_noncontiguous() implements a backoff [3] l=
oop
> > which ORs in __GFP_NORETRY except for minimum order allocations. We obs=
erve
> > experimentally that __GFP_RETRY_MAYFAIL does not get "stuck" on minimum=
 order
> > allocations. So the iommu case is not affected.
> >
> > In the non-iommu case however, dma_alloc_noncontiguous() actually becom=
es a
> > contiguous allocator, with no backoff loop. The commit introducing it [=
4]
> > states "This API is only properly implemented for dma-iommu and will si=
mply
> > return a contigious chunk as a fallback." In this case we observe the i=
ndefinite
> > hang.
> >
> > The alsa fallback allocator is also not affected by the problem, as it =
does
> > not specify __GFP_RETRY_MAYFAIL. Except in the XENPV case.
>
> So it sounds like that we should go back for __GFP_NORETRY in general
> for non-zero order allocations, not only the call you changed, as
> __GFP_RETRY_MAYFAIL doesn't guarantee the stuck.
>
> How about the changes like below?

We are concerned that the below proposed change might break the fix
introduced by commit a61c7d88d38c ("FROMGIT: ALSA: memalloc: use
__GFP_RETRY_MAYFAIL for DMA mem allocs"). More specifically in the
IOMMU case with a large allocation, the fallback algorithm in the DMA
IOMMU allocator[1] will not try really hard and hence may fail
prematurely when it gets to minimum order allocations. This will
result in no audio when there is significant load on physical memory.

Thanks and Regards,
Karthikeyan.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree=
/drivers/iommu/dma-iommu.c?h=3Dv6.8-rc4#n903

>
> And, Kai, could you verify whether this change with the recent kernel
> code won't give significant regressions for the issues you tried to
> address with commit a61c7d88d38c?
>
>
> thanks,
>
> Takashi
>
> --- a/sound/core/memalloc.c
> +++ b/sound/core/memalloc.c
> @@ -19,17 +19,22 @@
>  #include <sound/memalloc.h>
>  #include "memalloc_local.h"
>
> -#define DEFAULT_GFP \
> -       (GFP_KERNEL | \
> -        __GFP_RETRY_MAYFAIL | /* don't trigger OOM-killer */ \
> -        __GFP_NOWARN)   /* no stack trace print - this call is non-criti=
cal */
> -
>  static const struct snd_malloc_ops *snd_dma_get_ops(struct snd_dma_buffe=
r *dmab);
>
>  #ifdef CONFIG_SND_DMA_SGBUF
>  static void *snd_dma_sg_fallback_alloc(struct snd_dma_buffer *dmab, size=
_t size);
>  #endif
>
> +/* default GFP bits for our allocations */
> +static gfp_t default_gfp(size_t size)
> +{
> +       /* don't allocate intensively for high-order pages */
> +       if (size > PAGE_SIZE)
> +               return GFP_KERNEL | __GFP_NOWARN | __GFP_NORETRY;
> +       else
> +               return GFP_KERNEL | __GFP_NOWARN | __GFP_RETRY_MAYFAIL;
> +}
> +
>  static void *__snd_dma_alloc_pages(struct snd_dma_buffer *dmab, size_t s=
ize)
>  {
>         const struct snd_malloc_ops *ops =3D snd_dma_get_ops(dmab);
> @@ -281,7 +286,7 @@ static void *do_alloc_pages(struct device *dev, size_=
t size, dma_addr_t *addr,
>                             bool wc)
>  {
>         void *p;
> -       gfp_t gfp =3D GFP_KERNEL | __GFP_NORETRY | __GFP_NOWARN;
> +       gfp_t gfp =3D default_gfp(size);
>
>   again:
>         p =3D alloc_pages_exact(size, gfp);
> @@ -466,7 +471,7 @@ static const struct snd_malloc_ops snd_dma_iram_ops =
=3D {
>   */
>  static void *snd_dma_dev_alloc(struct snd_dma_buffer *dmab, size_t size)
>  {
> -       return dma_alloc_coherent(dmab->dev.dev, size, &dmab->addr, DEFAU=
LT_GFP);
> +       return dma_alloc_coherent(dmab->dev.dev, size, &dmab->addr, defau=
lt_gfp(size));
>  }
>
>  static void snd_dma_dev_free(struct snd_dma_buffer *dmab)
> @@ -511,7 +516,7 @@ static int snd_dma_wc_mmap(struct snd_dma_buffer *dma=
b,
>  #else
>  static void *snd_dma_wc_alloc(struct snd_dma_buffer *dmab, size_t size)
>  {
> -       return dma_alloc_wc(dmab->dev.dev, size, &dmab->addr, DEFAULT_GFP=
);
> +       return dma_alloc_wc(dmab->dev.dev, size, &dmab->addr, default_gfp=
(size));
>  }
>
>  static void snd_dma_wc_free(struct snd_dma_buffer *dmab)
> @@ -546,7 +551,7 @@ static void *snd_dma_noncontig_alloc(struct snd_dma_b=
uffer *dmab, size_t size)
>                 return snd_dma_sg_fallback_alloc(dmab, size);
>  #endif
>         sgt =3D dma_alloc_noncontiguous(dmab->dev.dev, size, dmab->dev.di=
r,
> -                                     DEFAULT_GFP, 0);
> +                                     default_gfp(size), 0);
>  #ifdef CONFIG_SND_DMA_SGBUF
>         if (!sgt && !get_dma_ops(dmab->dev.dev))
>                 return snd_dma_sg_fallback_alloc(dmab, size);
> @@ -783,7 +788,7 @@ static void *snd_dma_sg_fallback_alloc(struct snd_dma=
_buffer *dmab, size_t size)
>         while (size > 0) {
>                 chunk =3D min(size, chunk);
>                 if (sgbuf->use_dma_alloc_coherent)
> -                       p =3D dma_alloc_coherent(dmab->dev.dev, chunk, &a=
ddr, DEFAULT_GFP);
> +                       p =3D dma_alloc_coherent(dmab->dev.dev, chunk, &a=
ddr, default_gfp(size));
>                 else
>                         p =3D do_alloc_pages(dmab->dev.dev, chunk, &addr,=
 false);
>                 if (!p) {
> @@ -871,7 +876,7 @@ static void *snd_dma_noncoherent_alloc(struct snd_dma=
_buffer *dmab, size_t size)
>         void *p;
>
>         p =3D dma_alloc_noncoherent(dmab->dev.dev, size, &dmab->addr,
> -                                 dmab->dev.dir, DEFAULT_GFP);
> +                                 dmab->dev.dir, default_gfp(size));
>         if (p)
>                 dmab->dev.need_sync =3D dma_need_sync(dmab->dev.dev, dmab=
->addr);
>         return p;

