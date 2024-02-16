Return-Path: <linux-kernel+bounces-69071-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A17985841C
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 18:28:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 14972285A44
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 17:28:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C7BD132472;
	Fri, 16 Feb 2024 17:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="z3il1sbo"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01142130E39;
	Fri, 16 Feb 2024 17:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708104518; cv=none; b=XHEk7a7MTUVwh5F7rx40HpqcnfHjQAO8U27bO05JgBhD4qEfrYsaVlArnGq/U4elSs6IYsAAg3l6Q/818iWia+9Cgbgbck2QZF1aPle7sAcnzi+9+1+SGHBkTZTYmQQQjHb5svZ8B6FNN4qF4rlBFPXYKTt06cNmi0jsIL5UDeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708104518; c=relaxed/simple;
	bh=aNVEXDiJi6VMChdVIAhoIHDD0mjExyyaV2pttYA54tM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OXEYQzPV0PVKpOM1rMPva9hZp7Jkaz0GawgLUm/qH9/3cxlzuMz6THLqtEmX6YCmCYFuIlQ3CvphD4azoosiezd4A02fsf9ehdaIj5SBvXF+VBRgP/jHMEnTG77tfQe3bp/VyrBXScT0BgTgK01kCiWuaqB901MFI7OZiDz4TxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=z3il1sbo; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=2o0piiHymx2o0AqbvBOlZhU2HWHRJd9hWUdKlncu1Wo=; b=z3
	il1sboGebyF5ty+7v10SJ58TyYQXM/49dLz6nCS9zXdy9KG7vajiSHnIGQyYql2r52FBSAgx982wm
	nSHfeaz9boeIdFAh7Ffv0v+aUity5zWjpVUiOyCkKIJAG0T6+xWPI3cnSs36n/JCxavkRbn4BPJOr
	JBDcC7XKOE+4SH4=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rb20l-00809r-J7; Fri, 16 Feb 2024 18:28:31 +0100
Date: Fri, 16 Feb 2024 18:28:31 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Bastien Curutchet <bastien.curutchet@bootlin.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Richard Cochran <richardcochran@gmail.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Herve Codina <herve.codina@bootlin.com>
Subject: Re: [PATCH 1/2] dt-bindings: net: Add TI DP83640
Message-ID: <68c3b805-5532-41dd-bcf3-ff3cb86f4acc@lunn.ch>
References: <20240130085935.33722-1-bastien.curutchet@bootlin.com>
 <20240130085935.33722-2-bastien.curutchet@bootlin.com>
 <dc81a307-3541-47e2-9c72-d661e76889bf@lunn.ch>
 <be23b24e-5de1-400d-84fa-cf5b25e72a19@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <be23b24e-5de1-400d-84fa-cf5b25e72a19@bootlin.com>

> > > +  ti,phy-control-frames:
> > > +    $ref: /schemas/types.yaml#/definitions/uint32
> > > +    enum: [0, 1]
> > > +    description: |
> > > +      If present, enables or disables the PHY control frames.
> > > +      PHY Control Frames support can also be strapped. If the strap pin is not
> > > +      set correctly or not set at all then this can be used to configure it.
> > > +       - 0     = PHY Control Frames disabled
> > > +       - 1     = PHY Control Frames enabled
> > > +       - unset = Configured by straps
> > What is a control frame?
> I'm not an expert on this but it seems that if the PHY's Serial Management
> interface is not available, it is possible to build PCF (PHY Control Frame)
> packets that will be passed to PHY through the MAC Transmit Data interface.
> The
> PHY is then able to intercept and interpret these packets. Enabling it
> increases
> the MII Transmit packet latency.
> You'll find details in §5.4.6 of datasheet
> [https://www.ti.com/lit/gpn/dp83640]

Do you actually need this feature?

[Looks at data sheet]

Ah, so it allows you to access PHY registers by sending it commands in
Ethernet frames. That should in theory be faster than MDIO. However,
my experience with Ethernet switches which offer similar capabilities,
it is often not faster, because of interrupt coalescing. 

Anyway, the serial management interface is the MDIO bus. You know this
is available, because that is how the PHY driver it talking to the
PHY! Also, i've not seen any code which implements sending commands to
the PHY using Ethernet frames.

So why not just hard code it in the driver to disable this feature?

	Andrew

