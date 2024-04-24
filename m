Return-Path: <linux-kernel+bounces-156842-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 051A48B0900
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 14:13:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ADE931F23B72
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 12:13:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3326715ADB6;
	Wed, 24 Apr 2024 12:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="Ld/VClUu"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69DBD158DDD;
	Wed, 24 Apr 2024 12:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713960822; cv=none; b=bSvxb9CBdeVizJYVPzdIDUTuEqIpT4N3wP3wGZ7O/gieoycdSs62A4dPDL79s1/ig+cIA80fwB7P+3VsW8YP7VCvcjfOjs9flgHShfeRrrl+qz8xI5J4rlxW2mGmNog+/Rz1NaqGvc6ZRMQdljG/a0svZA108oWCr69ftR6zniw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713960822; c=relaxed/simple;
	bh=sLXTt9GB/rsKOXLZoUYneBDDC3CyVoxDen23EWg8h5E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b0Z+LLVppjef9HZ8qyjkYyZwqeAGHe8wV4EbainRDCB8hVOqUFdqUhkH7+57ag8UmCIjaE2jerVnBAUw0d8pYOw95BzDaVGU/PU8bPSdipEGXPUDM2VDYPMgeaOQzmrx3J8uuzTFteKtWS2/E5gl3BSYn1icYywCbNUPiWf18FM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=Ld/VClUu; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=SHD0stuCMK+KD0Sdi1Jz9uN5MAoinReJ6Vu81pY4K68=; b=Ld/VClUu4wPtjwWuOpaHqHnAeC
	AISzs1A3ztPno5HsqjcS0PJkH5+clU4bg7JwOlPABSmr4bYGUhhhrVVrwt72tO1wnAHjjzGdXdLon
	rdcfvk1T4HbVwj+j/6nt2hmk/Ohkd+AwUElQKZ9Bw8SUIJSMFnM/SObJy2bCf1mmbq40=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rzbVD-00DoHK-6c; Wed, 24 Apr 2024 14:13:31 +0200
Date: Wed, 24 Apr 2024 14:13:31 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Ronnie.Kunin@microchip.com
Cc: Raju.Lakkaraju@microchip.com, netdev@vger.kernel.org,
	davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
	edumazet@google.com, linux-kernel@vger.kernel.org,
	Bryan.Whitehead@microchip.com, UNGLinuxDriver@microchip.com
Subject: Re: [PATCH net V2 2/2] net: lan743x: support WOL in MAC even when
 PHY does not
Message-ID: <3285a386-5c3e-445d-94d7-4157240a4eb8@lunn.ch>
References: <20240320042107.903051-1-Raju.Lakkaraju@microchip.com>
 <20240320042107.903051-3-Raju.Lakkaraju@microchip.com>
 <22089299-a3e2-4cbd-942a-65ea070657b8@lunn.ch>
 <LV8PR11MB87003ABBCA98F00F3EEA9AB09F032@LV8PR11MB8700.namprd11.prod.outlook.com>
 <fb5a6f19-ae4c-443e-babb-cbbcf6ba5fc6@lunn.ch>
 <LV8PR11MB8700A34520EA2521BC5F59EF9F112@LV8PR11MB8700.namprd11.prod.outlook.com>
 <9c4f8fcd-ae95-4874-b829-d381928c5f13@lunn.ch>
 <PH8PR11MB7965211413E7295D537BF53095102@PH8PR11MB7965.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PH8PR11MB7965211413E7295D537BF53095102@PH8PR11MB7965.namprd11.prod.outlook.com>

> > This is the bit that is missing from your commit message, and maybe it should be in a comment. The
> > interrupt controller is part of the MAC. So you need to leave MAC burning power, maybe even
> > processing packets, because you cannot disable the MAC but leave the interrupt controller functioning,
> > so that it can trigger a wake up via PCIe.
> 

> I think there is a terminology problem here. Within MCHP we
> sometimes call "the MAC" to the whole ethernet controller chip that
> has everything (i.e. actual MAC, FIFOs, filtering engines, offloads,
> interrupt controller, bus interface, etc) except the PHY.

> That is what Raju probably means when he says that the interrupt is
> handled by "the MAC". While the registers that control
> enabling/disabling processing of the phy interrupt do reside within
> the MAC block's register set in the ethernet controller, it neither
> means that the extensive parts of the actual MAC block need to be
> kept enabled nor that processing packets has to occur in the MAC in
> order for the PCI11x1x chip to detect an event coming from the PHY
> that should be processed as a wake event over PCIe

I was expecting that, which is why i suggested looking at shutting
down what is not needed.  The current lan743x_ethtool_set_wol() does
not do any of that.

> I am Windows driver expert, not Linux so I may be wrong for Linux,
> but with the advent of dynamic PM in modern OSs (connected and then
> modern standby in Windows, I remember also autosuspend - at least in
> USB, maybe not applicable to PCIe - in Linux ) we have stayed away
> from renegotiating the link to down speed during suspend - resume
> events since those interfere with / delay connectivity
> significantly.

Renegotiation does take a little over 1s. It maybe not worth it for
suspend to RAM. But for suspend to disk, a resume is probably going to
take awhile, so maybe 1 second is less noticeable.

Also you maybe need to think about is EU norms about standby and power
off consumption. Going from 1G to 10M can save you 1W.

	Andrew

