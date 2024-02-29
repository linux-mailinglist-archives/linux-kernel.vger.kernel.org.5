Return-Path: <linux-kernel+bounces-86930-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 630C886CD14
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 16:33:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B79C28A70E
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 15:33:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB5C214601B;
	Thu, 29 Feb 2024 15:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="H80J6atU"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71977145B0B;
	Thu, 29 Feb 2024 15:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709220799; cv=none; b=l+E3WFpZZQw1qYXThZsvfXMETXiWbhqANpoMCcexXI4gqOHGEvjfIwXzLNgpn7JO0WAPOI8kLR8gTVKIAg7U+926Y8Q2rz1k2AcHF2vgbByFXRZz3tYTeHkE0enpSnpwATAv2tp/1LzgrpGO+nA9WoUfT02FsLuBVIvevVWQhNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709220799; c=relaxed/simple;
	bh=jcKhsTopZNl10YjkMIgoh5Owtj6TepXp5ES55FTTNl4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iA8PIfUrCMfnjPHQYPYZWGWxt7GQOII/SZxkKi7npnF2nlk2hQb4+a+SGto3+JAhMsKFs3+8dLAvTafGrFPNcV5MYzqVPi5YSQU+JzZATFaAt1r5dwfHczc004JRe+8P4k7lq+/3iadDGrqj05cBftmprrQI0kQv3lrt01vEuOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=H80J6atU; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=z0o5l+kVnqEYsDvrmqqol3BU9NWdcfLfrHl+N+cDZ70=; b=H80J6atUrwVbc0SK7ypE0N4fRv
	Lm3dC/QDaraMBubNTH/BWiUNuA9+Agc8ao4bGCA01//H35q0QmrzEZt6XlOdnajXQMr9IBdEIpvGB
	tL5avMolDxzGhgRZ5rAY0lQcO5E/jEHZVcrshzCrvYItWsb0PUdmxh22YLTpjVZ5p8CY=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rfiPL-0093Ju-Ph; Thu, 29 Feb 2024 16:33:15 +0100
Date: Thu, 29 Feb 2024 16:33:15 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Siddharth Vadapalli <s-vadapalli@ti.com>
Cc: Roger Quadros <rogerq@kernel.org>, Jiri Pirko <jiri@resnulli.us>,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, vladimir.oltean@nxp.com, hkallweit1@gmail.com,
	dan.carpenter@linaro.org, horms@kernel.org, yuehaibing@huawei.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, srk@ti.com,
	Pekka Varis <p-varis@ti.com>
Subject: Re: [PATCH net-next] net: ethernet: ti: am65-cpsw: Add priv-flag for
 Switch VLAN Aware mode
Message-ID: <cd2a03e6-dee2-46eb-b686-6df513324b5e@lunn.ch>
References: <20240227082815.2073826-1-s-vadapalli@ti.com>
 <Zd3YHQRMnv-ZvSWs@nanopsycho>
 <7d1496da-100a-4336-b744-33e843eba930@ti.com>
 <Zd7taFB2nEvtZh8E@nanopsycho>
 <49e531f7-9465-40ea-b604-22a3a7f13d62@ti.com>
 <10287788-614a-4eef-9c9c-a0ef4039b78f@lunn.ch>
 <0004e3d5-0f62-49dc-b51f-5a302006c303@ti.com>
 <0106ce78-c83f-4552-a234-1bf7a33f1ed1@kernel.org>
 <389aea37-ce0f-4b65-bf7c-d00c45b80e04@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <389aea37-ce0f-4b65-bf7c-d00c45b80e04@ti.com>

On Thu, Feb 29, 2024 at 04:37:06PM +0530, Siddharth Vadapalli wrote:
> On Thu, Feb 29, 2024 at 12:52:07PM +0200, Roger Quadros wrote:
> > 
> > 
> > On 29/02/2024 11:27, Siddharth Vadapalli wrote:
> > > On Wed, Feb 28, 2024 at 02:36:55PM +0100, Andrew Lunn wrote:
> > >>> What if there is no kernel behavior associated with it? How can it be mimicked
> > >>> then?
> > >>
> > >> Simple. Implement the feature in software in the kernel for
> > >> everybody. Then offload it to your hardware.
> > >>
> > >> Your hardware is an accelerator. You use it to accelerate what linux
> > >> can already do. If Linux does not have the feature your accelerator
> > >> has, that accelerator feature goes unused.
> > > 
> > > Is it acceptable to have a macro in the Ethernet Driver to conditionally
> > > disable/enable the feature (via setting the corresponding bit in the
> > > register)?

Please re-read my sentence above.

Your hardware is an accelerate for what Linux already does. That is
the key point here. Please understand that. Once you understand that
point, everything else becomes simple.

Does linux have this feature? If yes, accelerate it. If no, you have
something in your hardware which is currently not usable.

	Andrew

