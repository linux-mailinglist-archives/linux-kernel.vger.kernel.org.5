Return-Path: <linux-kernel+bounces-67444-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B12BB856B9E
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 18:52:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6BB3028449F
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 17:52:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11CC91384A4;
	Thu, 15 Feb 2024 17:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="gsNS5axL"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 809E31369AC;
	Thu, 15 Feb 2024 17:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708019522; cv=none; b=Lw5PzTjARDVN3vjIppRICtQNpapiJOfUeqb6md/ObjYD4N03tdjUVVY8XNVRdLvx39g7i+O2nPIqmpOf9XZLOoU5cIO7qZCK7iM9o5HkBieYhQAx8HXpns9R7Fd/72OHeCjYCq7ntG8g3gqLOcXZeTgi4pykfT58B6VdYpaOhL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708019522; c=relaxed/simple;
	bh=M6zXTumOL2shrnbpTbNe6dcztXS6mmrTVGsLmlPGQoY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F/mPh9B8TFywnmUjrW5FvIzPd6hPlwQj+OIYAWCmo2RTD5xyeBkfLInmYkiavGxr3pCmXOVwduOY6MM6kRR6mSbdinm5UkYRAbBbrotifa8pYuQ3MOqE9YPzdMwYQp29lqR9qu5UqIcQvRfTYZrvg2so8gLwbZuknIHDHZDs3K0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=gsNS5axL; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=afifmMcrSbICMT6eW/B4pDL5KgJCwV2V/YrMyURwkms=; b=gsNS5axLRq3buRV6dXpy+Bz2As
	8UXaY7jygcMiSlnXuOamtkRuVun1KmDgFmKGqN5cX53zP9UdBrWpreEjbzvNTW1Knmqt7VmBo/0pI
	4M2SnqUkG4OMzJ4OdowkDh+L8Ggg+jPwosskYbdlI0dGpnfXN3dZgxznbLiGynmBvU5M=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1raftr-007umH-W8; Thu, 15 Feb 2024 18:51:55 +0100
Date: Thu, 15 Feb 2024 18:51:55 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: Rob Herring <robh@kernel.org>,
	Kory Maincent <kory.maincent@bootlin.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Russ Weight <russ.weight@linux.dev>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, Mark Brown <broonie@kernel.org>,
	Frank Rowand <frowand.list@gmail.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, devicetree@vger.kernel.org,
	Dent Project <dentproject@linuxfoundation.org>
Subject: Re: [PATCH net-next v3 14/17] dt-bindings: net: pse-pd: Add bindings
 for PD692x0 PSE controller
Message-ID: <65099b67-b7dc-4d78-ba42-d550aae2c31e@lunn.ch>
References: <20240208-feature_poe-v3-0-531d2674469e@bootlin.com>
 <20240208-feature_poe-v3-14-531d2674469e@bootlin.com>
 <20240209145727.GA3702230-robh@kernel.org>
 <ZciUQqjM4Z8Tc6Db@pengutronix.de>
 <618be4b1-c52c-4b8f-8818-1e4150867cad@lunn.ch>
 <Zc3IrO_MXIdLXnEL@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zc3IrO_MXIdLXnEL@pengutronix.de>

> Hm.. good question. I didn't found the answer in the spec. By combining all
> puzzle parts I assume, different Alternative configurations are designed
> to handle conflict between "PSE Physical Layer classification" and PHY
> autoneg.
> 
> Here is how multi-pulse Physical Layer classification is done:
> https://img.electronicdesign.com/files/base/ebm/electronicdesign/image/2020/07/Figure_5.5f2094553a61c.png
> 
> this is the source:
> https://www.electronicdesign.com/technologies/power/whitepaper/21137799/silicon-labs-90-w-power-over-ethernet-explained
> 
> To avoid classification conflict with autoneg. Assuming, PHY on PD side
> will be not powered until classification is completed. The only source
> of pulses is the PHY on PSE side (if it is not under control of software
> on PSE side or Midspan PSE is used), so aneg pulses should be send on
> negative PoE pair? This all is just speculation, I would need to ask
> some expert or do testing.
> 
> If this assumption is correct, PHY framework will need to know exact
> layout of MDI-X setting and/or silent PHY until PSE classification is done.

Ideally, we don't want to define a DT binding, and then find it is
wrong for 1000BaseT and above and we need to change it.

So, either somebody needs to understand 1000BaseT and can say the
proposed binding works, or we explicitly document the binding is
limited to 10BaseT and 100BaseT.

I'm not sure the second solution will actually fly. This was being
tested with Marvell Prestera switch. I doubt it even has any Fast
Ethernet ports.

	Andrew


