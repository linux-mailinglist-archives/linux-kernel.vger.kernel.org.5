Return-Path: <linux-kernel+bounces-155782-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 407628AF70E
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 21:11:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7BE131C2284B
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 19:11:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F65113FD7C;
	Tue, 23 Apr 2024 19:11:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="mnovCFXQ"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD31F6A03F;
	Tue, 23 Apr 2024 19:11:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713899468; cv=none; b=OH/6gcXMOwAZfs7Smb+Vh3qv4WR9Pxeh1lljB+SFpEK2rzD2eHfF0SPzCZbK5ZDi90oltNhYyRTw95Byq16YerEVFkKanqlM1OfdjGkSUeq3roTejv37h/ydgZ2d0sRL409Uc+Cm7p+zZfsV/onC9BA7iwDfjwAgf9j+lC93Ikw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713899468; c=relaxed/simple;
	bh=WRbJ59b54E2zW2pAjJ4/AdXZ+3Ac82rV/2RvTgovby4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ReRMsU+0wHZ6RD/9Q8+uPlUiX6Fss5yPUZ+z3cnFNTK70zFzr9oAPNJW70Fjxh2R+x7eQUFpbCkjGOgq8U1qmcGOw5RNQ2ffYi1A4mwFyTj0HtoyBvdVcp1xhtY2jOseSyH+O6Q19SMWIsgFzPnkgL3KN6JNi6f/15/EvdJS4HM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=mnovCFXQ; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=Dft1VQm1fVxjiquLAa5e6mK9R+WqDs9Hw/UPc7j496Y=; b=mnovCFXQCkr0ccgTpWrSeU7r9K
	X7PsoAm3Ng58wGWCMxAhgzwKmENnCu3vZQPuwSkHRmqcMLPNCyE/sh481Ar28un7i7ve3jISjLgPL
	hfVNrbq13+9fYeHyIQYfLijAIm9PeIIqhHymsuv+xN3ajc27hvoVVTf5rZkcIG90okZU=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rzLXX-00DkAl-PD; Tue, 23 Apr 2024 21:10:51 +0200
Date: Tue, 23 Apr 2024 21:10:51 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Raju.Lakkaraju@microchip.com
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
	pabeni@redhat.com, edumazet@google.com,
	linux-kernel@vger.kernel.org, Bryan.Whitehead@microchip.com,
	UNGLinuxDriver@microchip.com
Subject: Re: [PATCH net V2 2/2] net: lan743x: support WOL in MAC even when
 PHY does not
Message-ID: <9c4f8fcd-ae95-4874-b829-d381928c5f13@lunn.ch>
References: <20240320042107.903051-1-Raju.Lakkaraju@microchip.com>
 <20240320042107.903051-3-Raju.Lakkaraju@microchip.com>
 <22089299-a3e2-4cbd-942a-65ea070657b8@lunn.ch>
 <LV8PR11MB87003ABBCA98F00F3EEA9AB09F032@LV8PR11MB8700.namprd11.prod.outlook.com>
 <fb5a6f19-ae4c-443e-babb-cbbcf6ba5fc6@lunn.ch>
 <LV8PR11MB8700A34520EA2521BC5F59EF9F112@LV8PR11MB8700.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <LV8PR11MB8700A34520EA2521BC5F59EF9F112@LV8PR11MB8700.namprd11.prod.outlook.com>

> If we don't enable/register the PCI11x1x's ethernet device in wake
> list by calling " device_set_wakeup_enable( )" function, device
> power state shows as disable.

> PHY (GPY211C)'s interrupt pin (MDINT) connect to PCI11x1x's ethernet device.

> When I configure the WAKE_PHY or WAKE_MAGIC on GPY211C PHY,
> Interrupt generation observed when magic packet or link activity
> (link down or link up).  If wakeup enable in PCI11x1x's ethernet
> device, System resumes from sleep.

This is the bit that is missing from your commit message, and maybe it
should be in a comment. The interrupt controller is part of the
MAC. So you need to leave MAC burning power, maybe even processing
packets, because you cannot disable the MAC but leave the interrupt
controller functioning, so that it can trigger a wake up via PCIe.

There are a few things you should consider:

Call phy_speed_down().  This will renegotiate the link, dropping it to
the slowest speed both link partners support. So hopefully down to
10Mbps. Your MAC will then only need to pointlessly process 10Mbps of
packets, rather than 1Gbps.

See if you can disable parts of the MAC, in particularly the receive
engine, in order to save power.

Talk to your hardware engineer and see if the next generation of the
hardware can separate the interrupt controller from the MAC, so you
can disable the MAC and leave the interrupt controller functioning.

> Please find the attached prototype code change (Temporary patch)for reference. 
> I will submit this patch separately.

Please just submit it in the normal way for review.

       Andrew

