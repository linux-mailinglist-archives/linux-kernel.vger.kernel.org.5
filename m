Return-Path: <linux-kernel+bounces-44143-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BBA9841DDD
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 09:35:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 47A6C289EA4
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 08:35:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6B6755E52;
	Tue, 30 Jan 2024 08:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fz8Jl9Mj"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16B0312E4D;
	Tue, 30 Jan 2024 08:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706603688; cv=none; b=ErM3ioUkRFMpD9QcERr68pOLWvxEEdMYnAr8zRPh0+fcqA6pNZ+PiK2uWgPhFMlo4g6JK4PwHjGuTbubqHYgzgKMOdL2YqVQJCYIAxRpw6PI/OOCUNOBC5vKPWZDXS2M2OCxdqTINCh0Z/EGhl18SJ9LcMn83gSLrBgvn53mIK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706603688; c=relaxed/simple;
	bh=PDBalufe/OZxGpAG/naTR/fooOv/KA48jowWnj1HpOI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i00bS+mf0BvB81r6qaDJis9yrMD04hM6EINwBWe4sCbKI+mPGj7C0WKeTKvZJKayteWFunQAp9WlKTTxMmX/ombUYsr2h7GGpeoTS0d8ESZ/UkKECEP3m2P1jqWhdRUg6L4w1iqBYFvsnG8+WYBfBZ66ezp3hPm9C9lKLfOxg44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fz8Jl9Mj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4784CC433C7;
	Tue, 30 Jan 2024 08:34:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706603687;
	bh=PDBalufe/OZxGpAG/naTR/fooOv/KA48jowWnj1HpOI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fz8Jl9MjAfgIKJeEbtyvr73lL20xJkHm+iy0ge/8TgeDpUF4MsFPoq+h89DdsflZH
	 1/mO8u6Yc4OxRFzPOsiOznTCtdEt3j5Un4bRezPuu5h+5ONHwCrY82Iz8as1FLc4g9
	 K6s+sEaK4GiSyMlOHz5dOsJbEIq3Ckp7RJiOUWK1IdBQp5QVzp2Ci8PuqFVwhmrtO6
	 R0Twc6fzF3xp6l3v+y9DBaHgDtupj8FNvNjYvDvLG8jzqac7Bh2kTpHalW7TPYnMqJ
	 5tzopcL3NcKRS1ocE8jtG78th8PAKD5YyoPvb6i0RTPiW73IEdWi2byr2wp5vqcblE
	 dtsbkE326Mx2A==
Date: Tue, 30 Jan 2024 14:04:38 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Erick Archer <erick.archer@gmx.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Jeffrey Hugo <quic_jhugo@quicinc.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Dan Carpenter <error27@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-arm-msm@vger.kernel.org, mhi@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] bus: mhi: ep: Use kcalloc() instead of kzalloc()
Message-ID: <20240130083438.GM32821@thinkpad>
References: <20240120152518.13006-1-erick.archer@gmx.com>
 <43614a09-d520-4111-873a-b352bd93ea07@moroto.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <43614a09-d520-4111-873a-b352bd93ea07@moroto.mountain>

On Mon, Jan 22, 2024 at 10:15:20AM +0300, Dan Carpenter wrote:
> This code does not have an integer overflow, but it might have a
> different memory corruption bug.
> 
> On Sat, Jan 20, 2024 at 04:25:18PM +0100, Erick Archer wrote:
> > As noted in the "Deprecated Interfaces, Language Features, Attributes,
> > and Conventions" documentation [1], size calculations (especially
> > multiplication) should not be performed in memory allocator (or similar)
> > function arguments due to the risk of them overflowing. This could lead
> > to values wrapping around and a smaller allocation being made than the
> > caller was expecting. Using those allocations could lead to linear
> > overflows of heap memory and other misbehaviors.
> > 
> > So, use the purpose specific kcalloc() function instead of the argument
> > count * size in the kzalloc() function.
> > 
> 
> This one is more complicated to analyze.  I have built a Smatch cross
> function database so it's easy for me and I will help you.
> 
> $ smbd.py where mhi_ep_cntrl event_rings
> drivers/pci/endpoint/functions/pci-epf-mhi.c | pci_epf_mhi_probe              | (struct mhi_ep_cntrl)->event_rings | 0
> drivers/bus/mhi/ep/main.c      | mhi_ep_irq                     | (struct mhi_ep_cntrl)->event_rings | min-max
> drivers/bus/mhi/ep/mmio.c      | mhi_ep_mmio_init               | (struct mhi_ep_cntrl)->event_rings | 0-255
> drivers/bus/mhi/ep/mmio.c      | mhi_ep_mmio_update_ner         | (struct mhi_ep_cntrl)->event_rings | 0-255
> 
> The other way to figure this stuff out would be to do:
> 
> $ grep -Rn "event_rings = " drivers/bus/mhi/ep/
> drivers/bus/mhi/ep/mmio.c:260:  mhi_cntrl->event_rings = FIELD_GET(MHICFG_NER_MASK, regval);
> drivers/bus/mhi/ep/mmio.c:261:  mhi_cntrl->hw_event_rings = FIELD_GET(MHICFG_NHWER_MASK, regval);
> drivers/bus/mhi/ep/mmio.c:271:  mhi_cntrl->event_rings = FIELD_GET(MHICFG_NER_MASK, regval);
> drivers/bus/mhi/ep/mmio.c:272:  mhi_cntrl->hw_event_rings = FIELD_GET(MHICFG_NHWER_MASK, regval);
> 
> That means that this multiplication can never overflow so the patch
> has no effect on runtime.  The patch is still useful because we don't
> want every single person to have to do this analysis.  The kcalloc()
> function is just safer and more obviously correct.
> 

Agree.

> It's a bit concerning that ->event_rings is set multiple times, but only
> allocated one time.  It's either unnecessary or there is a potential
> memory corruption bug.  If it's really necessary then there should be a
> check that the new size is <= the size of the original buffer that we
> allocated.

Agree, the dual assignment could be avoided. I added it initially to have all
the memory allocations in one place, and also there is a guarantee from the spec
that the MHICFG_NER_MASK will always be initialized to hw max value.

But looking at it again, it seems redundant. So I will drop the assignment from
mhi_ep_mmio_init().

Thanks for spotting!

- Mani

-- 
மணிவண்ணன் சதாசிவம்

