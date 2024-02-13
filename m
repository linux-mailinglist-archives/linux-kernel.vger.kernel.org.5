Return-Path: <linux-kernel+bounces-63866-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CF868535AC
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 17:08:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B15E41C21FE7
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 16:08:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 443CE5FB90;
	Tue, 13 Feb 2024 16:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Bnx3owWj"
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4838F5D914;
	Tue, 13 Feb 2024 16:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707840470; cv=none; b=XJVP0tphw9I/CRwZaMwe/D1OR+gNexPsDDeh3rEeZaGjrNax7xVMX5axmWmuQzqeH+iP5dJmTjUnUIWbt7paot+y6F9vP01xfP2eyUGoPqDlZwI6tsgK7B1m+1fUogirpYQko3CXu99QFUk8la8LM/Gum8eeyBBZLYYXLOvNYP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707840470; c=relaxed/simple;
	bh=Nq5NLWM8fquBBRNIIZ/z4DwyXucV/4AOy2bTNrl4gfM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FHN0i51MB+ke4/a71oJ1Te4Z1bknVCx7qWFtLv3oOe3Mo8JtxgesU7FGy+oOo5e8m1bbla/NssmTN9mKbNjf+uJGLA5304CugEI1ktCw/RyRBMichjFd9axyRNB3eynI17qmW/6U2Cfk2whwIiyueIQPrPJ6/GtL/eUeLLSA5Ho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Bnx3owWj; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 93E41C000B;
	Tue, 13 Feb 2024 16:07:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1707840464;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gVnzc7OAdrtUJbFDyTTibW0hk3NfWNlLDbaHw8ta+S8=;
	b=Bnx3owWjNw2cJ0Jza4wUrQauMZ+sFCg4yoKBcAIBj/yJBtyZtWax7yKqIPwQRn12E6tuTa
	tH9TbpLp08NNV0UZsDFx+XXBO5ROXyCuY31lNQ05P4vvnCwOvTzlp2nSiLGDDtjUdGusLD
	0FY0RAGiwSQAqeGMfkpGHZRc7z9IRqb7uVt/pDGYx+ZlQFBILq3pS2unj+ofv6RnskuWnU
	ROlzfe+uAx3ERoGD6S61ZsgbdKHWNKVoa5UBD4EtEGqTcSOi2Ue/mWaobcr5lgao6nV7h7
	kDn67fD1vkhGVsK+yS5EMGgnHmOXUV5qX6k/VF5fFMEYeIlPu0Lk0nqvAgkcYg==
Date: Tue, 13 Feb 2024 17:07:41 +0100
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Heiner Kallweit <hkallweit1@gmail.com>, Russell King
 <linux@armlinux.org.uk>, davem@davemloft.net, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Jonathan Corbet <corbet@lwn.net>, Horatiu Vultur
 <horatiu.vultur@microchip.com>, Richard Cochran <richardcochran@gmail.com>,
 UNGLinuxDriver@microchip.com, netdev@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 thomas.petazzoni@bootlin.com, =?UTF-8?B?S8O2cnk=?= Maincent
 <kory.maincent@bootlin.com>
Subject: Re: [PATCH net-next 1/3] net: phy: Add support for inband
 extensions
Message-ID: <20240213170741.3ffa20e8@device-28.home>
In-Reply-To: <27644300-ff4f-4603-9338-bad4aa0e5610@lunn.ch>
References: <20240212173307.1124120-1-maxime.chevallier@bootlin.com>
	<20240212173307.1124120-2-maxime.chevallier@bootlin.com>
	<27644300-ff4f-4603-9338-bad4aa0e5610@lunn.ch>
Organization: Bootlin
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-GND-Sasl: maxime.chevallier@bootlin.com

Hello Andrew,

On Tue, 13 Feb 2024 15:03:01 +0100
Andrew Lunn <andrew@lunn.ch> wrote:

> > +Inband Extensions
> > +=================
> > +
> > +The USGMII Standard allows the possibility to re-use the full-length 7-bytes
> > +frame preamble to convey meaningful data. This is already partly used by modes
> > +like QSGMII, which passes the port number in the preamble.
> > +
> > +In USGMII, we have a standardized approach to allow the MAC and PHY to pass
> > +such data in the preamble, which looks like this :
> > +
> > +|  0   |  1   |  2  |  3  |  4  |  5  |  6  |  7  |  Frame data
> > +| SoP  |      |      Extension              | CRC |
> > +|     /        \_______________             |     |
> > +|    /                         \            |     |
> > +|   | type | subport | ext type |           |     |
> > +
> > +The preamble in that case uses the Packet Control Header (PCH) format, where
> > +the byte 1 is used as a control field with :
> > +
> > +type - 2 bits :
> > +        - 00 : Packet with PCH
> > +        - 01 : Packet without PCH
> > +        - 10 : Idle Packet, without data
> > +        - 11 : Reserved
> > +
> > +subport - 4 bits : The subport identifier. For QUSGMII, this field ranges from
> > +                   0 to 3, and for OUSGMII, it ranges from 0 to 7.
> > +
> > +ext type - 2 bits : Indicated the type of data conveyed in the extension
> > +        - 00 : Ignore extension
> > +        - 01 : 8 bits reserved + 32 timestamp
> > +        - 10 : Reserved
> > +        - 11 : Reserved  
> 
> Somewhat crystal ball...
> 
> Those two reserved values could be used in the future to indicate
> other extensions. So we could have three in operation at once, but
> only one selected per frame.
> 
> > +A PHY driver can register available modes with::
> > +
> > +  int phy_inband_ext_set_available(struct phy_device *phydev, enum phy_inband_ext ext);
> > +  int phy_inband_ext_set_unavailable(struct phy_device *phydev, enum phy_inband_ext ext);  
> 
> enum phy_inband_ext is just an well defined, but arbitrary number? 0
> is this time stamp value mode, 1 could be used MACSEC, 2 could be a
> QoS indicator when doing rate adaptation? 3 could be ....
> 
> > +It's then up to the MAC driver to enable/disable the extension in the PHY as
> > +needed. This was designed to fit the timestamping configuration model, as it
> > +is the only mode supported so far.
> > +
> > +Enabling/Disabling an extension is done from the MAC driver through::
> > +
> > +  int phy_inband_ext_enable(struct phy_device *phydev, enum phy_inband_ext ext);  
> 
> So maybe this should return the 2 bit ext type value? The MAC can
> request QoS marking, and the PHY replies it expects the bits to be 3 ?
> 
> I'm just trying to ensure we have an API which is extensible in the
> future to make use of those two reserved values.

You are right, that's a much better idea !

> 
> > diff --git a/drivers/net/phy/phy.c b/drivers/net/phy/phy.c
> > index 3b9531143be1..4b6cf94f51d5 100644
> > --- a/drivers/net/phy/phy.c
> > +++ b/drivers/net/phy/phy.c
> > @@ -1760,3 +1760,89 @@ int phy_ethtool_nway_reset(struct net_device *ndev)
> >  	return ret;
> >  }
> >  EXPORT_SYMBOL(phy_ethtool_nway_reset);
> > +
> > +/**
> > + * PHY modes in the USXGMII family can have extensions, with data transmitted
> > + * in the frame preamble.
> > + * For now, only QUSGMII is supported, but other variants like USGMII and
> > + * OUSGMII can be added in the future.
> > + */
> > +static inline bool phy_interface_has_inband_ext(phy_interface_t interface)  
> 
> No inline functions in .c file please. Let the compiler decide.

My bad this one slept through the cracks...

> 
> > +bool phy_inband_ext_available(struct phy_device *phydev, enum phy_inband_ext ext)
> > +{
> > +	return !!(phydev->inband_ext.available & ext);  
> 
> should this be BIT(ext) ?

Correct indeed

> 
> > +}
> > +EXPORT_SYMBOL(phy_inband_ext_available);  
> 
> If you don't mind, i would prefer EXPORT_SYMBOL_GPL().

I don't mind, I'll fix that

> 
> > +static int phy_set_inband_ext(struct phy_device *phydev,
> > +			      enum phy_inband_ext ext,
> > +			      bool enable)
> > +{
> > +	int ret;
> > +
> > +	if (!phy_interface_has_inband_ext(phydev->interface))
> > +		return -EOPNOTSUPP;
> > +
> > +	if (!phydev->drv->set_inband_ext)
> > +		return -EOPNOTSUPP;  
> 
> That is a driver bug. It should not set phydev->inband_ext.available
> and then not have drv->set_inband_ext. So we should probably test this
> earlier. Maybe define that phydev->inband_ext.available has to be set
> during probe, and the core can validate this after probe and reject
> the device if it is inconsistent?

Good point, I'll add that !

> 
> > +
> > +	mutex_lock(&phydev->lock);
> > +	ret = phydev->drv->set_inband_ext(phydev, ext, enable);
> > +	mutex_unlock(&phydev->lock);
> > +	if (ret)
> > +		return ret;
> > +
> > +	if (enable)
> > +		phydev->inband_ext.enabled |= BIT(ext);
> > +	else
> > +		phydev->inband_ext.enabled &= ~BIT(ext);  
> 
> Should these be also protected by the mutex?

I think you are right, it would be better making sure we serialize
accesses to these indeed.

Thanks for the review,

Maxime

