Return-Path: <linux-kernel+bounces-42666-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 40EB8840498
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 13:07:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6656F1C224E7
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 12:07:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FE4B5FEE5;
	Mon, 29 Jan 2024 12:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="Bng2QaIT"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B8F85F849
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 12:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706530047; cv=none; b=Mrw42wPuHUn+IinR1mHm2H7N9QgVy89LwraSwkUABnJ6kXkRdouN6lS+kR61Qs/94UegZ/2OPkzRXfKgqTA35jwNJU3N70axDXjhkc160DKMkcegtmdK9YXfJRgF7Iur1LAyv7DlacP9mEI92Pr/TLkkbNvbcoyi+rdAlHtURgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706530047; c=relaxed/simple;
	bh=02RsKKzHL4abWx1faKlfDuafe93KQrefn/s+0sF/td4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ls0rfXNCVCEYhhgc8S7aIecDKggdjCFom5EhFYZmLLXUV3BEk91Kv/GRoJLk340MTRZi8kvzzBO4zYq6Av39mWMmS7UHIEw87mkUyVU1cgNRQtsEJf9DggbLuYdQ9x53raGMnG4SB+45RAA1DdSP8qhfJnBn9+YxMqujuZOoDao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=Bng2QaIT; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from pendragon.ideasonboard.com (117.145-247-81.adsl-dyn.isp.belgacom.be [81.247.145.117])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id E2A301F73;
	Mon, 29 Jan 2024 13:06:05 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1706529966;
	bh=02RsKKzHL4abWx1faKlfDuafe93KQrefn/s+0sF/td4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Bng2QaITQuLJ4bvGTqFurH19uWh0yXqPUEFBt+X1ITARn2E9TKIO+L0WqYNrXBWdr
	 CUHI57HtWuujJMfjtRrv1Gu1kgEtvaeW1kHOa6Yk2NK5b9AKaTAmrRzgsKMYjveFQk
	 U0MiROY+lOq+OgWaANiqkaeDeMci27kvfS4mcOU0=
Date: Mon, 29 Jan 2024 14:07:23 +0200
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Maxime Ripard <mripard@redhat.com>
Cc: Pavel Machek <pavel@ucw.cz>, Lucas Stach <dev@lynxeye.de>,
	kernel list <linux-kernel@vger.kernel.org>,
	Milan Zamazal <mzamazal@redhat.com>, Christoph Hellwig <hch@lst.de>,
	iommu@lists.linux.dev, Will Deacon <will@kernel.org>,
	catalin.marinas@arm.com,
	Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
	Andrey Konovalov <andrey.konovalov.ynk@gmail.com>,
	kieran.bingham@ideasonboard.com,
	Hans de Goede <hdegoede@redhat.com>
Subject: Re: Re: Uncached buffers from CMA DMA heap on some Arm devices?
Message-ID: <20240129120723.GB8131@pendragon.ideasonboard.com>
References: <87bk9ahex7.fsf@redhat.com>
 <d2ff8df896d8a167e9abf447ae184ce2f5823852.camel@lynxeye.de>
 <Zbd8lOgVqfCrGUL7@duo.ucw.cz>
 <xd5ofun26gfdgn7hig3gipj5rgojqyuouwmii7xecgrbzyliil@y6rufxtwdmrc>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xd5ofun26gfdgn7hig3gipj5rgojqyuouwmii7xecgrbzyliil@y6rufxtwdmrc>

On Mon, Jan 29, 2024 at 11:32:08AM +0100, Maxime Ripard wrote:
> On Mon, Jan 29, 2024 at 11:23:16AM +0100, Pavel Machek wrote:
> > Hi!
> > 
> > > That's right and a reality you have to deal with on those small ARM
> > > systems. The ARM architecture allows for systems that don't enforce
> > > hardware coherency across the whole SoC and many of the small/cheap SoC
> > > variants make use of this architectural feature.
> > > 
> > > What this means is that the CPU caches aren't coherent when it comes to
> > > DMA from other masters like the video capture units. There are two ways
> > > to enforce DMA coherency on such systems:
> > > 1. map the DMA buffers uncached on the CPU
> > > 2. require explicit cache maintenance when touching DMA buffers with
> > > the CPU
> > > 
> > > Option 1 is what you see is happening in your setup, as it is simple,
> > > straight-forward and doesn't require any synchronization points.
> > 
> > Yeah, and it also does not work :-).
> > 
> > Userspace gets the buffers, and it is not really equipped to work with
> > them. For example, on pinephone, memcpy() crashes on uncached
> > memory. I'm pretty sure user could have some kind of kernel-crashing
> > fun if he passed the uncached memory to futex or something similar.
> 
> Uncached buffers are ubiquitous on arm/arm64 so there must be something
> else going on. And there's nothing to equip for, it's just a memory
> array you can access in any way you want (but very slowly).
> 
> How does it not work?

I agree, this should just work (albeit possibly slowly). A crash is a
sign something needs to be fixed.

> > > Option 2 could be implemented by allocating cached DMA buffers in the
> > > V4L2 device and then executing the necessary cache synchronization in
> > > qbuf/dqbuf when ownership of the DMA buffer changes between CPU and DMA
> > > master. However this isn't guaranteed to be any faster, as the cache
> > > synchronization itself is a pretty heavy-weight operation when you are
> > > dealing with buffer that are potentially multi-megabytes in size.
> > 
> > Yes, cache synchronization can be slow, but IIRC it was on order of
> > milisecond in the worst case.. and copying megayte images is still
> > slower than that.

Those numbers are platform-specific, you can't assume this to be true
everywhere.

> > Note that it is faster to do read/write syscalls then deal with
> > uncached memory. And userspace can't simply flush the caches and remap
> > memory as cached.
> 
> You can't change the memory mapping, but you can flush the caches with
> dma-buf. It's even required by the dma-buf documentation.
> 
> > v4l2 moved away from read/write "because it is slow" and switched to
> > interface that is even slower than that. And libcamera exposes
> > uncached memory to the user :-(.
> 
> There's also the number of copies to consider. If you were to use
> read/write to display a frame on a framebuffer, you would use 4 copies
> vs 2 with dma-buf.

-- 
Regards,

Laurent Pinchart

