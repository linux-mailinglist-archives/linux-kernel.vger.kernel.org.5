Return-Path: <linux-kernel+bounces-90658-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 270938702CF
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 14:34:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D77A0285124
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 13:34:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDE9A3F9C5;
	Mon,  4 Mar 2024 13:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="FtebJCye"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 882CB3F8E0;
	Mon,  4 Mar 2024 13:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709559167; cv=none; b=vCVdiCkYV85Rr2n2Rbif1ro7QFCDqgypcvyGJSYTOVO40GNQjyiH6pRRpK66YoUN5DhmZ1cneZH+mDEACcbuaDvhk+lJ8LZq7GF5HAdbe5qDxOa/2mDlvBRpT3aHcyW3lF/hF1QBfo12xcxcVX7hb9YiIVj4xIh0e9Bxzd6OyVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709559167; c=relaxed/simple;
	bh=0atBaHXl1e3n7AZO5fT2Mm64OWqwf3KkX/ptCgjWNPE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ezZYGjoAWoQhifxPmGUccPFeVTpjBzdpevudypsjkY0zhqi6vlStMMsZQHi31LdSoHID6lURg9IPakdH98WQ4+RBtXmJYKLG1PeKs+UhLSCTET+lZjoJf9TyPJsKUKxbDh+j4bO8b1hPWUKkKIwz1WYv720t07jRAQ5sUAbGHgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=FtebJCye; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=OZLHOEQOwrKYkhkP5YCytEcFYTUgdUuOzV0w6B1zc5w=; b=FtebJCyeTDDX8B9ncGsT+3dwiL
	S/NRnnAK6ew7ipqWGNe7yO3T6105XYq4XD9wuBMEA9pKAL3wxp0sPSpOxvkQp+PKPAoCn4YeKijJQ
	/TOjzehI3Xhj0WU+wlS/ZS19CRhlv4Re7nhdAmWMH6c3r46K3efgJy+SdsJPdq9Tni7s=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rh8R0-009KGP-11; Mon, 04 Mar 2024 14:32:50 +0100
Date: Mon, 4 Mar 2024 14:32:50 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: =?iso-8859-1?Q?K=F6ry?= Maincent <kory.maincent@bootlin.com>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Russ Weight <russ.weight@linux.dev>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, Mark Brown <broonie@kernel.org>,
	Frank Rowand <frowand.list@gmail.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, devicetree@vger.kernel.org,
	Dent Project <dentproject@linuxfoundation.org>
Subject: Re: [PATCH net-next v5 13/17] net: pse-pd: Use regulator framework
 within PSE framework
Message-ID: <84b300c7-8295-424b-9117-c604fb4cd73e@lunn.ch>
References: <20240227-feature_poe-v5-0-28f0aa48246d@bootlin.com>
 <20240227-feature_poe-v5-13-28f0aa48246d@bootlin.com>
 <ZeObuKHkPN3tiWz_@pengutronix.de>
 <20240304102708.5bb5d95c@kmaincent-XPS-13-7390>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240304102708.5bb5d95c@kmaincent-XPS-13-7390>

> > > +	psec = dev_find_pse_control(&phy->mdio.dev);
> > > +	if (IS_ERR(psec)) {
> > > +		rc = PTR_ERR(psec);
> > > +		goto unregister_phy;
> > > +	}
> > > +  
> > 
> > I do not think it is a good idea to make PSE controller depend on
> > phy->mdio.dev. The only reason why we have fwnode_find_pse_control()
> > here was the missing port abstraction.
> 
> I totally agree that having port abstraction would be more convenient.
> Maxime Chevallier is currently working on this and will post it after his
> multi-phy series get merged.
> Meanwhile, we still need a device pointer for getting the regulator. The
> phy->mdio.dev is the only one I can think of as a regulator consumer.
> Another idea?

Sorry, i've not been keeping up...

Doesn't the device tree binding determine this? Where is the consumer
in the tree?

   Andrew

