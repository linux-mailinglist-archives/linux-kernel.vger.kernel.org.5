Return-Path: <linux-kernel+bounces-56081-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE0B984C5B2
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 08:34:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0EC591C25511
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 07:34:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9AF0200BD;
	Wed,  7 Feb 2024 07:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HpDoFKfj"
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 132DC200A8
	for <linux-kernel@vger.kernel.org>; Wed,  7 Feb 2024 07:34:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707291286; cv=none; b=SbzhiWxuXva2CqSVd2BVBLP2IiB4C9dEo/4vnLuBKPxV0Ix3aAVSt4fXJOR07LyKQJ1Hg38JpzXZQjobq4FOaFAvDD64Pnk8Tvd4Ev3SM0NmAAVUgm8v9rGaX5D4P5rnG4u6+gZNU6KRx6RDxex70aC6GkUABdYp979RjRCXXuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707291286; c=relaxed/simple;
	bh=S5gO4wFCGdf4U8hpr8PjPSAcXbRHD0h9TiGC7q7YDuY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nLhKWzkWg1WMa8FcnxoPrRkFGj7xNji+f3is5QYVZMubUBDFLI6M0RQR4a/POciIAdAwiNA1XZ5UNwxaDvyY+gRLiziiDdgL0CofvDg1twPI4w62R/xP+DfdTKZ0VbxWXW1hdAF07rihQOm/J49k7e2ALYM+Qqu/6uKLfWrx3DY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=HpDoFKfj; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2d04c0b1cacso3650781fa.0
        for <linux-kernel@vger.kernel.org>; Tue, 06 Feb 2024 23:34:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707291282; x=1707896082; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=S5gO4wFCGdf4U8hpr8PjPSAcXbRHD0h9TiGC7q7YDuY=;
        b=HpDoFKfjg80J60h/LJCIAWQPZ7Wwpbwcs5zbuwnVcv0wLGStidAP6qyxmFNLDzejpj
         rLt8chMKLB5LOqJ3fHNnfPOhLxbfXQqziyElpKR3ElxxOUyfcfAmPqhepF2gthZReAzN
         41IYHiFhPPwMUSK909bsaClWQwMT6n5f/MIJsuBXkbXnlBG72TzX1ztzpWFIBbaKaCF3
         cuVRNqxdlWjrh4E3xjT8IGeNrSAIEayMxFtdlcaWyS2r7NBzV0CHnj4qymIm+Bx8hqws
         gpGzPpj8GGPUXY+nXTbSwmlUS2Z3rIPfKmGmXrAcWN/ma9PjPgB6VHivabxiF7JGvunN
         hpfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707291282; x=1707896082;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=S5gO4wFCGdf4U8hpr8PjPSAcXbRHD0h9TiGC7q7YDuY=;
        b=cpguOCTxKD7KrxZi/McbshOpCJydAfyqSxovIFpRyQyTaObQOjF0fCKN0/FjejmnQH
         rdohhYRD19PUBsAf7ISVCIXMSuoYUmkTgPBgf7e6DPcbopjkdUcxLk5r0YXqppUhUFS3
         tzkfQzq+fUg/JTvwmhyJ1M5iZt2hTn2oaZYlSlcB31NRX5nVCCb6/Fk1KHHdESHX3/p0
         LxaiJ27dVc/tLXZo+m7T5cU0NGl/MoIIwkKEBrGfZYqFoNMBsN9hg9Lk1XOsXLxbAaP3
         9os1zfxbBqzXGatun9YO60vLf1ZeHy7yqhhCGWiq2qEfyzxVGjHdfY77kqZIFn8VjM3n
         ScyA==
X-Gm-Message-State: AOJu0YwA9UzXP4/pX9BjnXbp8n59IVyVM8dp0h+ck8oZXvS8V0/vR0VP
	gD1hsMdYyAr9bl0FdUZrTUwqFIhP5x0sXp4m+c+bbC42HJWaZhel+jyiRe8hbLwCy6yGqT/v+4W
	2MmEC22kX7ds4ly9UjybXXiNOaM14tt4g6iaBGw==
X-Google-Smtp-Source: AGHT+IFh5ekPQoYMkVSvFUTVNp490x3+3Wmn+QgL/l6NPj4Tgs/Wvg1ifow9CgPztr1eHKfD1iN26mAk36H9sC8qvo8=
X-Received: by 2002:a2e:3509:0:b0:2d0:aa2a:9ced with SMTP id
 z9-20020a2e3509000000b002d0aa2a9cedmr3421689ljz.6.1707291281948; Tue, 06 Feb
 2024 23:34:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240131174347.510961-1-jens.wiklander@linaro.org>
 <20240131174347.510961-2-jens.wiklander@linaro.org> <CAPDyKFqNhGWKm=+7niNsjXOjEJE3U=o7dRNG=JqpptUSo9G-ug@mail.gmail.com>
 <CAC_iWj+k_Vsz4ot=9pv-Gv7r11=vCunH5TSyOMTK4z-NZ2TeTA@mail.gmail.com> <CAFA6WYNQoRg0PWgr1oCzrkMens7e0=m_zkBSXKvp8JVjmn2OZQ@mail.gmail.com>
In-Reply-To: <CAFA6WYNQoRg0PWgr1oCzrkMens7e0=m_zkBSXKvp8JVjmn2OZQ@mail.gmail.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Wed, 7 Feb 2024 09:34:05 +0200
Message-ID: <CAC_iWj+ho3Wy2cbZdgf4Uhd=9-iY-_411psuGZJwpvVwXnnyqw@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] rpmb: add Replay Protected Memory Block (RPMB) subsystem
To: Sumit Garg <sumit.garg@linaro.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Jens Wiklander <jens.wiklander@linaro.org>, 
	linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, 
	op-tee@lists.trustedfirmware.org, 
	Shyam Saini <shyamsaini@linux.microsoft.com>, 
	Jerome Forissier <jerome.forissier@linaro.org>, Bart Van Assche <bvanassche@acm.org>, 
	Randy Dunlap <rdunlap@infradead.org>, Ard Biesheuvel <ardb@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Tomas Winkler <tomas.winkler@intel.com>, 
	=?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: text/plain; charset="UTF-8"

On Wed, 7 Feb 2024 at 08:11, Sumit Garg <sumit.garg@linaro.org> wrote:
>
> Hi Ilias, Ulf,
>
> On Tue, 6 Feb 2024 at 20:41, Ilias Apalodimas
> <ilias.apalodimas@linaro.org> wrote:
> >
> > Hi Ulf,
> >
> > On Tue, 6 Feb 2024 at 14:34, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> > >
> > > On Wed, 31 Jan 2024 at 18:44, Jens Wiklander <jens.wiklander@linaro.org> wrote:
> > > >
> > > > A number of storage technologies support a specialised hardware
> > > > partition designed to be resistant to replay attacks. The underlying
> > > > HW protocols differ but the operations are common. The RPMB partition
> > > > cannot be accessed via standard block layer, but by a set of specific
> > > > RPMB commands: WRITE, READ, GET_WRITE_COUNTER, and PROGRAM_KEY. Such a
> > > > partition provides authenticated and replay protected access, hence
> > > > suitable as a secure storage.
> > > >
> > > > The initial aim of this patch is to provide a simple RPMB Driver which
> > > > can be accessed by the optee driver to facilitate early RPMB access to
> > > > OP-TEE OS (secure OS) during the boot time.
> > >
> > > How early do we expect OP-TEE to need RPMB access?
> >
> > It depends on the requested services. I am currently aware of 2
> > services that depend on the RPMB
> > - FirmwareTPM
> > - UEFI variables stored there via optee.
> >
> > For the FirmwareTPM it depends on when you want to use it. This
> > typically happens when the initramfs is loaded or systemd requests
> > access to the TPM. I guess this is late enough to not cause problems?
>
> Actually RPMB access is done as early as during fTPM probe, probably
> to cache NVRAM from RPMB during fTPM init. Also, there is a kernel
> user being IMA which would require fTPM access too. So we really need
> to manage dependencies here.

Ah true. I was wrongly assuming loading is a module and having systemd
or something similar handling that dependency. But in case this is
built-in we do need to handle that internally.


>
> >
> > For the latter, we won't need the supplicant until a write is
> > requested. This will only happen once the userspace is up and running.
> > The UEFI driver that sits behind OP-TEE has an in-memory cache of the
> > variables, so all the reads (the kernel invokes get_next_variable
> > during boot) are working without it.
> >
> > Thanks
> > /Ilias
> > >
> > > The way things work for mmc today, is that the eMMC card gets
> > > discovered/probed via a workqueue. The work is punted by the mmc host
> > > driver (typically a module-platform-driver), when it has probed
> > > successfully.
>
> It would be nice if RPMB is available as early as possible but for the
> time being we can try to see if probe deferral suffices for all
> use-cases.
>
> > >
> > > The point is, it looks like we need some kind of probe deferral
> > > mechanism too. Whether we want the OP-TEE driver to manage this itself
> > > or whether we should let rpmb_dev_find_device() deal with it, I don't
> > > know.
>
> I wouldn't like to see the OP-TEE driver probe being deferred due to
> this since there are other kernel drivers like OP-TEE RNG (should be
> available as early as we can) etc. which don't have any dependency on
> RPMB.
>
> How about for the time being we defer fTPM probe until RPMB is available?
>
> -Sumit

