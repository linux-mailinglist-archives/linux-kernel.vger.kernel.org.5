Return-Path: <linux-kernel+bounces-110059-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 43333885976
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 13:56:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F0C95282623
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 12:56:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7A7A83CCE;
	Thu, 21 Mar 2024 12:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="KNYi/Ufs"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 253F3134CD;
	Thu, 21 Mar 2024 12:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711025782; cv=none; b=ZiUBM2JS5gLj/8MQDUSz/xDoAhkXXKVNOG7yqWMYeaXTM5e/12ZXZCBjrqdhmDNZ0NvY5C91DBQiWHEtZtNxJvzPt5eFEgTXKBYmIen4+LDSFERPPhhcFPK6bPtmBRXwplApmmTPNwhZxPgEGguB/iPD+Z+3GaXWS705CpokcqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711025782; c=relaxed/simple;
	bh=BxiWdf4/7BU0N7jaavO3/onZ7Kj2pPXj4FUIl3z2O1s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Hmd9cH8U+x5mrnEUT8oVP6O9Czzv8FLz/ve5zlp1K267JhVeiYylGgJn9bz9Nu2GCSRXbikMKVE09ohlXGk1gCt7+pesR2DQPyacD3TRYldQd1+3ojR0VEV1V46OQvXRGXbU+9QUsUcdMIGO+p+i2ZLkO9FbkoPMypfbO2JdUa4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=KNYi/Ufs; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=/VkiJjn/Ujsmq+U16JaWHWXV190NKV6cULGPu225XxU=; b=KNYi/UfsvbbcIhqHWGMXIBUscE
	0NUwAsju2opk5jzCII3uqEkHR38PO9RlU5fEkVlNiKk6G/xRsfJT95BBpVXuicO7xdAiJj2zANZVH
	b3cNy9k8i9zEFRfFL/mszQHX62S3jxZ+AaOcjMQvO2euRivm6dUzLycyLG+9z5r7rO+s=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rnHxe-00AsKQ-Pb; Thu, 21 Mar 2024 13:55:58 +0100
Date: Thu, 21 Mar 2024 13:55:58 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Vaishnav Achath <vaishnav.a@ti.com>
Cc: Michael Walle <mwalle@kernel.org>,
	"Russell King (Oracle)" <linux@armlinux.org.uk>,
	Ayush Singh <ayushdevel1325@gmail.com>,
	open list <linux-kernel@vger.kernel.org>, jkridner@beagleboard.org,
	robertcnelson@beagleboard.org, lorforlinux@beagleboard.org,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, Nishanth Menon <nm@ti.com>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Tero Kristo <kristo@kernel.org>,
	Derek Kiernan <derek.kiernan@amd.com>,
	Dragan Cvetic <dragan.cvetic@amd.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Mark Brown <broonie@kernel.org>, Johan Hovold <johan@kernel.org>,
	Alex Elder <elder@kernel.org>,
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>,
	"moderated list:ARM/TEXAS INSTRUMENTS K3 ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>,
	"open list:SPI SUBSYSTEM" <linux-spi@vger.kernel.org>,
	"moderated list:GREYBUS SUBSYSTEM" <greybus-dev@lists.linaro.org>,
	Vaishnav M A <vaishnav@beagleboard.org>
Subject: Re: [PATCH v4 1/5] dt-bindings: misc: Add mikrobus-connector
Message-ID: <3904c7eb-c179-4596-ba42-d6b545a562a6@lunn.ch>
References: <20240317193714.403132-1-ayushdevel1325@gmail.com>
 <20240317193714.403132-2-ayushdevel1325@gmail.com>
 <CZWVF90JJO98.2M7ARQ9WMGC94@kernel.org>
 <d4dc4d94-d323-4158-8c08-b7d37d8750d3@gmail.com>
 <b62915ca-c151-4e37-bb03-c92c569c84ff@lunn.ch>
 <4b319264-bff7-48e5-85e8-201ca0bafec6@ti.com>
 <4c299d42-84c7-46fc-952f-292cef1bb4b4@lunn.ch>
 <ded6c350-4c70-4a26-8b18-6605dcc6e084@ti.com>
 <CZZBT3ZMDCVI.40UX5MB6LY4I@kernel.org>
 <ef6a1c28-70dc-4077-b644-2704ac3cf30f@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ef6a1c28-70dc-4077-b644-2704ac3cf30f@ti.com>

> > How will the ethernet boards ([1], [2]) work? Where do they get
> > their MAC address from, for example. The DT has some nice properties
> > for that, but I doubt that will be possible with the manifest files.
> > I've looked at the manifest file for the w5500 board [3] and to me
> > it looks like that board will come up with a random MAC address on
> > each start. Thus, even today, you have some boards which require
> > a more complex description.
> > 
> 
> Agreed, this is a limitation, unless the corresponding drivers/subsystems
> use device_property_read_* helper to fetch properties, it will not work and
> net/core/of_net.c only implements of_get_* helpers even though the
> underlying functions can be implemented with equivalent
> device_property_read_* equivalent as well.

I think this is a good example of the limitations. For an Ethernet
NIC, you often want to describe properties of both the MAC and the
PHY. What phy-mode should be used, what delays on the RGMII bus, what
LEDs are there etc. This is a pretty much solved problem with DT, we
have a well defined sub tree to represent the MAC, the MDIO bus and
the PHY on the bus.

But we do have two classes of properties here. The MAC address is
unique to a board. So that does need to be stored in the EEPROM, and
cannot be in a one time converted manifest to DT file stored in
/lib/firmware. However, to some extent, this is a solved problem. We
have a DT representation of how to look in an EEPROM to find the MAC
address. So the DT just needs to point to some bytes in the manifest
in the EEPROM.

	Andrew

