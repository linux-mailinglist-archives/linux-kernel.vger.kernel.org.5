Return-Path: <linux-kernel+bounces-151797-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A0AB68AB3FB
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 18:58:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D257D1C21256
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 16:58:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7FBE1386C0;
	Fri, 19 Apr 2024 16:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kLRJLc48"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 110601369AA;
	Fri, 19 Apr 2024 16:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713545882; cv=none; b=C6c0o0zO+M69pxgmR25r4tXAaey/NwwIyO8vFfaIEWwjEwV7ZzQYwNAC5SkLf/0w8sfHfdRs0n+ZBZ9EH+G7PSUCA7RSfgGrUw1TrEUC+F5GOB08jnduGsksGKSzkTlZdkgyMMKj8ruQ1IWZ712hvr7U7koPKSeXlPgdZfdq2IA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713545882; c=relaxed/simple;
	bh=lXpDiwhQo98bP1FryEGDTvEaGE3S/DU83yCuP95iQf4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HL1j8p6/4/ESbN0AkxH+DqXZpyICyaETKIQ2ZGuRW28d6bZRNiKsdhEDHoCEGEWBBB6zFDNRdAuob4HkOTcLQU9HQcvRwG7Wan7xab7lVKo4js5IqWI0q71jwz+cPR4xcx9JxVo6wqhJLebEq0tB0U3s3nWihQE9OJnvtU94tWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kLRJLc48; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1e50a04c317so13731005ad.1;
        Fri, 19 Apr 2024 09:57:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713545879; x=1714150679; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=UVhdLoqOmP33JcxmAZZppMT40QvlL/I6MqHHmvjWVwA=;
        b=kLRJLc486T755n7RKGR5YKTiP8JBN1fbzEzTjq47m19Rc+9AvSwqAslt8i7eH6Pnq7
         UyGf8rPR7cj/YVmBuhUDzWJlK1bEjDNMX68S3v9xe1pxQgoWz6xnCfqqn7RtX7tQsaWp
         zDKh1+CYllTOmOaPPaZAtKutIHksYl3wWrmiHs5M5ALRs++DXbc3LemgyZraOOatHVUu
         HfxCtx/s0vhCeEocRfGjxaHN9Hvj+NxVKb9FnuVDNB2TZ0mRqbEyNa27uZ9GpoWy+j3k
         kV8ssAFpIq1crHSUww//ODEibyLztTG/I8eQT9DxkQ2MJfMb6i9L7mJUQmwRPbgXLmOs
         m9QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713545879; x=1714150679;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UVhdLoqOmP33JcxmAZZppMT40QvlL/I6MqHHmvjWVwA=;
        b=A9sbmiP0iJivzMcsURwdF49SxxGnfFCUCVZCIwel9RjYN8weiS65QNwp8HOa4gkAOm
         qNVhme2t/PadKi0/RGV81c83tiX2PTpQ72h9FuJ+H5sT1Ad8GCd7gk86PhzExaIhqBIQ
         nttIa5tVK6mIMGupSgSJ8pSdc5wDscvcaj8zswGWm6XiDWnQ+OuWjx2rdJlYvqun/MNk
         GitFcxoK6jrVZhxdd9d/75eltGHqyAx0A0vpql7c4TJJbM/dfBEUy62Xq8TG6vBASqkx
         x9SDnIYZVxUIxQ0FmqgSavZTOUOrd7wVCxaipOqkpwQuE5h9oMBSU1KxgOxn5duXbsBl
         3owQ==
X-Forwarded-Encrypted: i=1; AJvYcCW5h2xK1WRoDSTdz8lnQuKlYLUSt1cljtAAnItlvyWozGFC5hPAEgaCDJCgNvVyeXhbBT411lZ4zMeqaEUVgmATFi9AlQV8tQwUjaja3WBttwOz48xuYwv7KQ0pZW4DlukkpPV8mA1BR6Q=
X-Gm-Message-State: AOJu0YwlNWwLuN49Wzg+a/7bgtyaTGel2ioMBhXs7Ih8R93xSd3Q+6ir
	rMG+Y4MqS82stotlc2oKBPhEP2o8nfrOaQao7yPtxh2/QuYhVlw4T4dMRlYYrDp84vx3cIuO4a1
	73BNACVKhsCmDwc8Y8v5+H0sTGyA=
X-Google-Smtp-Source: AGHT+IGd2q8SP9g4kc04Aop9W0vIGu3rv607Ws+SBDlsjApM9U32JwLK736Znh95YUtvArDUHHvirc9PKw/9X7r6Yj4=
X-Received: by 2002:a17:90a:5d04:b0:2a0:4c3b:2c39 with SMTP id
 s4-20020a17090a5d0400b002a04c3b2c39mr3379824pji.23.1713545879215; Fri, 19 Apr
 2024 09:57:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240409120605.4138472-1-Pascal.FONTAIN@bachmann.info>
 <20240409120605.4138472-3-Pascal.FONTAIN@bachmann.info> <2024040944-flashcard-tribune-6a8e@gregkh>
In-Reply-To: <2024040944-flashcard-tribune-6a8e@gregkh>
From: Christian Gmeiner <christian.gmeiner@gmail.com>
Date: Fri, 19 Apr 2024 18:57:47 +0200
Message-ID: <CAH9NwWezn1A=n9_NqY_Lp9VzYwzAd0dAjQPD9wBB3_ragddZWg@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] misc: sram: Add DMA-BUF Heap exporting of SRAM areas
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Pascal FONTAIN <Pascal.FONTAIN@bachmann.info>, linux-kernel@vger.kernel.org, 
	Derek Kiernan <derek.kiernan@amd.com>, Dragan Cvetic <dragan.cvetic@amd.com>, 
	Arnd Bergmann <arnd@arndb.de>, Sumit Semwal <sumit.semwal@linaro.org>, 
	=?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, afd@ti.com, 
	linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	linaro-mm-sig@lists.linaro.org
Content-Type: text/plain; charset="UTF-8"

Am Di., 9. Apr. 2024 um 14:14 Uhr schrieb Greg Kroah-Hartman
<gregkh@linuxfoundation.org>:
>
> On Tue, Apr 09, 2024 at 02:06:05PM +0200, Pascal FONTAIN wrote:
> > From: Andrew Davis <afd@ti.com>
> >
> > This new export type exposes to userspace the SRAM area as a DMA-BUF
> > Heap,
> > this allows for allocations of DMA-BUFs that can be consumed by various
> > DMA-BUF supporting devices.
> >
> > Signed-off-by: Andrew Davis <afd@ti.com>
> > Tested-by: Pascal Fontain <pascal.fontain@bachmann.info>
>
> When sending on a patch from someone else, you too must sign off on it
> as per our documenation.  Please read it and understand what you are
> agreeing to when you do that for a new version please.
>
> > ---
> >  drivers/misc/Kconfig         |   7 +
> >  drivers/misc/Makefile        |   1 +
> >  drivers/misc/sram-dma-heap.c | 246 +++++++++++++++++++++++++++++++++++
> >  drivers/misc/sram.c          |   6 +
> >  drivers/misc/sram.h          |  16 +++
> >  5 files changed, 276 insertions(+)
> >  create mode 100644 drivers/misc/sram-dma-heap.c
> >
> > diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
> > index 9e4ad4d61f06..e6674e913168 100644
> > --- a/drivers/misc/Kconfig
> > +++ b/drivers/misc/Kconfig
> > @@ -448,6 +448,13 @@ config SRAM
> >  config SRAM_EXEC
> >       bool
> >
> > +config SRAM_DMA_HEAP
> > +     bool "Export on-chip SRAM pools using DMA-Heaps"
> > +     depends on DMABUF_HEAPS && SRAM
> > +     help
> > +       This driver allows the export of on-chip SRAM marked as both pool
> > +       and exportable to userspace using the DMA-Heaps interface.
>
> What will use this in userspace?
>

I could imagine a way it might be used.

Imagine a SoC like TI's AM64x series, where some cores (A53) run Linux
and others (R5F) are managed by remoteproc to
execute a RTOS. When it comes to efficiently exchanging large data
sets, the conventional method involves using rpmsg,
which has limitations due to message size and could potentially slow
down data transfer. However, an alternative
approach could be to allocate a sizable chunk of SRAM memory in
userspace. By utilizing memcpy() to copy data into
this memory, followed by a single rpmsg signal to notify the RTOS that
the data is ready, we can leverage the faster access
speed of SRAM compared to DDR from the remoteproc.

-- 
greets
--
Christian Gmeiner, MSc

https://christian-gmeiner.info/privacypolicy

