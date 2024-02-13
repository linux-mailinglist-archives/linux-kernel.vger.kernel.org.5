Return-Path: <linux-kernel+bounces-63633-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BF1B85328D
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 15:03:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D6C38288C9E
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 14:03:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F84158108;
	Tue, 13 Feb 2024 14:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="gUMVj4CE"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1594756767;
	Tue, 13 Feb 2024 14:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707832988; cv=none; b=ka4XVNU7OySIBIXoN0iwQCJylGWMtWZVnj3AzxFhMzS/uiuJeAXje8SWkwnsj3Dz4zCE8Li1Bbcn42RQnB+ij7ews9cKVQGnKz4WK2oU2nqWYCQ5kYyGjn5P7moW6IYtbwO6wSFaDCQUU6O3iDIZ5ZssIKbmGVI08kN2J07JrOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707832988; c=relaxed/simple;
	bh=l6xGtXUVd0pZcjRV1106mZieZPMPAOqCaQaJHGZfhNo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I6t62miL0iSwEQzuvjNRDk4P0pnieLCrMRg2eDEUX5HGDlL5eHPr9B/lu1sv/4S3jHj6V1ONpaxIoo+40+jNissXgQQzC0Ol/Qqmv2OTIhFRQdf/vuUphKB/WwOkkIn2Qkf4nptDtoAFExazB4z52FaSM5lopS+1q013TtVfWhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=gUMVj4CE; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=pXy28F4oZs8p0WURsI7cKbzl3wBcMbF+9piGOUored0=; b=gUMVj4CEgguPKwSCS923HiZVXN
	j6g/h2QmDdOwAeQPhtAq5AkeNyms6snBVTuO1yP0w23t1ciTBKUhIycrEaNq/Bj8z4mB1H39Bwqhj
	hWtyaONOdm7Q7s3TGSkqei2OWSjwmfzQPbzcBqCaSWN4RhNEK4RJc2Z/kaTFV+tK/b+8=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rZtNF-007gUi-NX; Tue, 13 Feb 2024 15:03:01 +0100
Date: Tue, 13 Feb 2024 15:03:01 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>, davem@davemloft.net,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Horatiu Vultur <horatiu.vultur@microchip.com>,
	Richard Cochran <richardcochran@gmail.com>,
	UNGLinuxDriver@microchip.com, netdev@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	thomas.petazzoni@bootlin.com,
	=?iso-8859-1?Q?K=F6ry?= Maincent <kory.maincent@bootlin.com>
Subject: Re: [PATCH net-next 1/3] net: phy: Add support for inband extensions
Message-ID: <27644300-ff4f-4603-9338-bad4aa0e5610@lunn.ch>
References: <20240212173307.1124120-1-maxime.chevallier@bootlin.com>
 <20240212173307.1124120-2-maxime.chevallier@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240212173307.1124120-2-maxime.chevallier@bootlin.com>

> +Inband Extensions
> +=================
> +
> +The USGMII Standard allows the possibility to re-use the full-length 7-bytes
> +frame preamble to convey meaningful data. This is already partly used by modes
> +like QSGMII, which passes the port number in the preamble.
> +
> +In USGMII, we have a standardized approach to allow the MAC and PHY to pass
> +such data in the preamble, which looks like this :
> +
> +|  0   |  1   |  2  |  3  |  4  |  5  |  6  |  7  |  Frame data
> +| SoP  |      |      Extension              | CRC |
> +|     /        \_______________             |     |
> +|    /                         \            |     |
> +|   | type | subport | ext type |           |     |
> +
> +The preamble in that case uses the Packet Control Header (PCH) format, where
> +the byte 1 is used as a control field with :
> +
> +type - 2 bits :
> +        - 00 : Packet with PCH
> +        - 01 : Packet without PCH
> +        - 10 : Idle Packet, without data
> +        - 11 : Reserved
> +
> +subport - 4 bits : The subport identifier. For QUSGMII, this field ranges from
> +                   0 to 3, and for OUSGMII, it ranges from 0 to 7.
> +
> +ext type - 2 bits : Indicated the type of data conveyed in the extension
> +        - 00 : Ignore extension
> +        - 01 : 8 bits reserved + 32 timestamp
> +        - 10 : Reserved
> +        - 11 : Reserved

Somewhat crystal ball...

Those two reserved values could be used in the future to indicate
other extensions. So we could have three in operation at once, but
only one selected per frame.

> +A PHY driver can register available modes with::
> +
> +  int phy_inband_ext_set_available(struct phy_device *phydev, enum phy_inband_ext ext);
> +  int phy_inband_ext_set_unavailable(struct phy_device *phydev, enum phy_inband_ext ext);

enum phy_inband_ext is just an well defined, but arbitrary number? 0
is this time stamp value mode, 1 could be used MACSEC, 2 could be a
QoS indicator when doing rate adaptation? 3 could be ....

> +It's then up to the MAC driver to enable/disable the extension in the PHY as
> +needed. This was designed to fit the timestamping configuration model, as it
> +is the only mode supported so far.
> +
> +Enabling/Disabling an extension is done from the MAC driver through::
> +
> +  int phy_inband_ext_enable(struct phy_device *phydev, enum phy_inband_ext ext);

So maybe this should return the 2 bit ext type value? The MAC can
request QoS marking, and the PHY replies it expects the bits to be 3 ?

I'm just trying to ensure we have an API which is extensible in the
future to make use of those two reserved values.

> diff --git a/drivers/net/phy/phy.c b/drivers/net/phy/phy.c
> index 3b9531143be1..4b6cf94f51d5 100644
> --- a/drivers/net/phy/phy.c
> +++ b/drivers/net/phy/phy.c
> @@ -1760,3 +1760,89 @@ int phy_ethtool_nway_reset(struct net_device *ndev)
>  	return ret;
>  }
>  EXPORT_SYMBOL(phy_ethtool_nway_reset);
> +
> +/**
> + * PHY modes in the USXGMII family can have extensions, with data transmitted
> + * in the frame preamble.
> + * For now, only QUSGMII is supported, but other variants like USGMII and
> + * OUSGMII can be added in the future.
> + */
> +static inline bool phy_interface_has_inband_ext(phy_interface_t interface)

No inline functions in .c file please. Let the compiler decide.

> +bool phy_inband_ext_available(struct phy_device *phydev, enum phy_inband_ext ext)
> +{
> +	return !!(phydev->inband_ext.available & ext);

should this be BIT(ext) ?

> +}
> +EXPORT_SYMBOL(phy_inband_ext_available);

If you don't mind, i would prefer EXPORT_SYMBOL_GPL().

> +static int phy_set_inband_ext(struct phy_device *phydev,
> +			      enum phy_inband_ext ext,
> +			      bool enable)
> +{
> +	int ret;
> +
> +	if (!phy_interface_has_inband_ext(phydev->interface))
> +		return -EOPNOTSUPP;
> +
> +	if (!phydev->drv->set_inband_ext)
> +		return -EOPNOTSUPP;

That is a driver bug. It should not set phydev->inband_ext.available
and then not have drv->set_inband_ext. So we should probably test this
earlier. Maybe define that phydev->inband_ext.available has to be set
during probe, and the core can validate this after probe and reject
the device if it is inconsistent?

> +
> +	mutex_lock(&phydev->lock);
> +	ret = phydev->drv->set_inband_ext(phydev, ext, enable);
> +	mutex_unlock(&phydev->lock);
> +	if (ret)
> +		return ret;
> +
> +	if (enable)
> +		phydev->inband_ext.enabled |= BIT(ext);
> +	else
> +		phydev->inband_ext.enabled &= ~BIT(ext);

Should these be also protected by the mutex?

       Andrew

