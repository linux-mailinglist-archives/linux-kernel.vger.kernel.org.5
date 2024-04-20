Return-Path: <linux-kernel+bounces-152160-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3397B8ABA02
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Apr 2024 08:36:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E47A51F212DD
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Apr 2024 06:36:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE9461119B;
	Sat, 20 Apr 2024 06:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="0FsGL3L3"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AD8320EB;
	Sat, 20 Apr 2024 06:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713595002; cv=none; b=S+6m17LnGqeXkGnc4QcrJ1Csj09kz7nSSqrJujgPQEzGf0FXcxt1M3UhDzbUOULipH39JnyVxto40AmCU5VSHGgh2PoSbAfk16hv8CPHp35cW9kMD9hYep/5YMmZQOIlPRaLfz6DRwn+XZPx7gZQBztRdd4nuvnd/Kc3CrCBls0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713595002; c=relaxed/simple;
	bh=4ZTtTXI4g9M/agNAvTBYKN6n6HilBTuHVmnqwooqBfE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lJxXGn6x4sNhoqQYSqtLMi8LzLmcYg0CG2PKJHy4grP6FsrnLPAXdcQ61kYyVIQYvBq5A6Z7632rGLc9M1xAK4OioWSF7AzmmrZbWLaOrfea7v/ZEqupJuQBDIhqNqkWWR8cjgt+eLwW7dKgtG2E9EbtZhZ+FVjiUlno8rHFDUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=0FsGL3L3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCFCAC072AA;
	Sat, 20 Apr 2024 06:36:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1713595001;
	bh=4ZTtTXI4g9M/agNAvTBYKN6n6HilBTuHVmnqwooqBfE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=0FsGL3L3LeROXc734pyxXG2RCzM8GIMTdZqalBjsuAwWZi6SJsD3JhFih9MygA9bE
	 D67SPQ3KyoYcSoyKTfpl+yYe+OZe30YTkQTOP91tBSxltbxZq+xB6qjQGkTp4IOQwk
	 Y7xQ2ue8J76g2LIpRiDBWca/BWuJfFcunV0dCSwo=
Date: Sat, 20 Apr 2024 08:36:34 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Christian Gmeiner <christian.gmeiner@gmail.com>
Cc: Pascal FONTAIN <Pascal.FONTAIN@bachmann.info>,
	linux-kernel@vger.kernel.org, Derek Kiernan <derek.kiernan@amd.com>,
	Dragan Cvetic <dragan.cvetic@amd.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
	afd@ti.com, linux-media@vger.kernel.org,
	dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org
Subject: Re: [PATCH v3 2/2] misc: sram: Add DMA-BUF Heap exporting of SRAM
 areas
Message-ID: <2024042043-joyride-parish-3d3b@gregkh>
References: <20240409120605.4138472-1-Pascal.FONTAIN@bachmann.info>
 <20240409120605.4138472-3-Pascal.FONTAIN@bachmann.info>
 <2024040944-flashcard-tribune-6a8e@gregkh>
 <CAH9NwWezn1A=n9_NqY_Lp9VzYwzAd0dAjQPD9wBB3_ragddZWg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAH9NwWezn1A=n9_NqY_Lp9VzYwzAd0dAjQPD9wBB3_ragddZWg@mail.gmail.com>

On Fri, Apr 19, 2024 at 06:57:47PM +0200, Christian Gmeiner wrote:
> Am Di., 9. Apr. 2024 um 14:14 Uhr schrieb Greg Kroah-Hartman
> <gregkh@linuxfoundation.org>:
> >
> > On Tue, Apr 09, 2024 at 02:06:05PM +0200, Pascal FONTAIN wrote:
> > > From: Andrew Davis <afd@ti.com>
> > >
> > > This new export type exposes to userspace the SRAM area as a DMA-BUF
> > > Heap,
> > > this allows for allocations of DMA-BUFs that can be consumed by various
> > > DMA-BUF supporting devices.
> > >
> > > Signed-off-by: Andrew Davis <afd@ti.com>
> > > Tested-by: Pascal Fontain <pascal.fontain@bachmann.info>
> >
> > When sending on a patch from someone else, you too must sign off on it
> > as per our documenation.  Please read it and understand what you are
> > agreeing to when you do that for a new version please.
> >
> > > ---
> > >  drivers/misc/Kconfig         |   7 +
> > >  drivers/misc/Makefile        |   1 +
> > >  drivers/misc/sram-dma-heap.c | 246 +++++++++++++++++++++++++++++++++++
> > >  drivers/misc/sram.c          |   6 +
> > >  drivers/misc/sram.h          |  16 +++
> > >  5 files changed, 276 insertions(+)
> > >  create mode 100644 drivers/misc/sram-dma-heap.c
> > >
> > > diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
> > > index 9e4ad4d61f06..e6674e913168 100644
> > > --- a/drivers/misc/Kconfig
> > > +++ b/drivers/misc/Kconfig
> > > @@ -448,6 +448,13 @@ config SRAM
> > >  config SRAM_EXEC
> > >       bool
> > >
> > > +config SRAM_DMA_HEAP
> > > +     bool "Export on-chip SRAM pools using DMA-Heaps"
> > > +     depends on DMABUF_HEAPS && SRAM
> > > +     help
> > > +       This driver allows the export of on-chip SRAM marked as both pool
> > > +       and exportable to userspace using the DMA-Heaps interface.
> >
> > What will use this in userspace?
> >
> 
> I could imagine a way it might be used.

This implies it is not needed because no one actually has actually used
it for anything, so why make this change?

> Imagine a SoC like TI's AM64x series, where some cores (A53) run Linux
> and others (R5F) are managed by remoteproc to
> execute a RTOS. When it comes to efficiently exchanging large data
> sets, the conventional method involves using rpmsg,
> which has limitations due to message size and could potentially slow
> down data transfer. However, an alternative
> approach could be to allocate a sizable chunk of SRAM memory in
> userspace. By utilizing memcpy() to copy data into
> this memory, followed by a single rpmsg signal to notify the RTOS that
> the data is ready, we can leverage the faster access
> speed of SRAM compared to DDR from the remoteproc.

Why is virtio not used instead?

thanks,

greg k-h

