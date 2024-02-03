Return-Path: <linux-kernel+bounces-51180-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BA6884876B
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 17:25:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AE43D1F23402
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 16:25:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E61795F84C;
	Sat,  3 Feb 2024 16:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="2lLAyxbH"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 755CF58206;
	Sat,  3 Feb 2024 16:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706977536; cv=none; b=mBEaenqDutFcjHq6+krDJKnkeH73pq6nzQcUIfI/Cu3HqbISwyfzGsq49Tv/6zcRRQhZy/Z0/stcuoQt9q900MEXQ+C8l/qBfXS0sClys3xfXhIqXcANKyE0LeTBepl7cXiWTXsNgEQfHK960Z53WkvrPmTiQmjKscXqCQfiZbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706977536; c=relaxed/simple;
	bh=vWy0Zx39e4wmgFNDFPUH6HFaDxM9TNK1v6d9d2+MVE0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dlMx3mv+n0P9ghj0uJ9TXo7pctnIbWNtwgRBGuQpYs4f0wGmNBymofL2rvMMqBRXGXVjR4sqy8va/EG+0/VclaVPX/p/piPCgqLwYpU1jWNVbs780+Wk4RBZRjufcOITKWZAx9x0vbRW86h8WLYQZ3PIiJQUH1iux/+Dlb7m7+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=2lLAyxbH; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=4djEjuQQh7CJm2rcKQ3SV1fnshnuP3wO2z85v1DRISU=; b=2lLAyxbH+7u/rQ2fN8is/U0PSy
	zy9m9wMMdFiIMIaQYnPZd1qcz7HhGAraK1eO2zuCDS66BBJsDS5jHUCoPXwqe6IkhA3OnGmmNzN/d
	nFFk4s63sIR1BliZKt808FdHcKr4D4OQiZKa5EA1M2/GsSvFYljoJMTVquL0dqDAgGGs=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rWIpX-006udA-V2; Sat, 03 Feb 2024 17:25:23 +0100
Date: Sat, 3 Feb 2024 17:25:23 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Frank Rowand <frowand.list@gmail.com>,
	Robert Marko <robert.marko@sartura.hr>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-msm@vger.kernel.org
Subject: Re: [net-next PATCH v5 7/9] net: phy: qcom: add support for QCA807x
 PHY Family
Message-ID: <c3447c2b-4b43-4c09-b89e-d6a44971b923@lunn.ch>
References: <20240201151747.7524-1-ansuelsmth@gmail.com>
 <20240201151747.7524-8-ansuelsmth@gmail.com>
 <a530f40c-b8fd-4da1-b4df-f80ab05f0394@lunn.ch>
 <65bd29f9.050a0220.a175d.3d5f@mx.google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <65bd29f9.050a0220.a175d.3d5f@mx.google.com>

On Fri, Feb 02, 2024 at 06:44:22PM +0100, Christian Marangi wrote:
> On Fri, Feb 02, 2024 at 02:35:11AM +0100, Andrew Lunn wrote:
> > > +static int qca807x_read_fiber_status(struct phy_device *phydev)
> > > +{
> > > +	int ss, err, lpa, old_link = phydev->link;
> > > +
> > > +	/* Update the link, but return if there was an error */
> > > +	err = genphy_update_link(phydev);
> > > +	if (err)
> > > +		return err;
> > > +
> > > +	/* why bother the PHY if nothing can have changed */
> > > +	if (phydev->autoneg == AUTONEG_ENABLE && old_link && phydev->link)
> > > +		return 0;
> > > +
> > > +	phydev->speed = SPEED_UNKNOWN;
> > > +	phydev->duplex = DUPLEX_UNKNOWN;
> > > +	phydev->pause = 0;
> > > +	phydev->asym_pause = 0;
> > > +
> > > +	if (phydev->autoneg == AUTONEG_ENABLE && phydev->autoneg_complete) {
> > > +		lpa = phy_read(phydev, MII_LPA);
> > > +		if (lpa < 0)
> > > +			return lpa;
> > > +
> > > +		linkmode_mod_bit(ETHTOOL_LINK_MODE_Autoneg_BIT,
> > > +				 phydev->lp_advertising, lpa & LPA_LPACK);
> > > +		linkmode_mod_bit(ETHTOOL_LINK_MODE_1000baseX_Full_BIT,
> > > +				 phydev->lp_advertising, lpa & LPA_1000XFULL);
> > > +		linkmode_mod_bit(ETHTOOL_LINK_MODE_Pause_BIT,
> > > +				 phydev->lp_advertising, lpa & LPA_1000XPAUSE);
> > > +		linkmode_mod_bit(ETHTOOL_LINK_MODE_Asym_Pause_BIT,
> > > +				 phydev->lp_advertising,
> > > +				 lpa & LPA_1000XPAUSE_ASYM);
> > > +
> > > +		phy_resolve_aneg_linkmode(phydev);
> > > +	}
> > 
> > This looks a lot like genphy_c37_read_status(). Can it be used?
> >
> 
> Yes but I had to expand genphy_c37_read_status. Hope it will be OK.

You can expand it, but please keep to what is defined within 802.3. We
don't want any vendor extensions in this common code. Vendor things
should be kept in the vendor driver. So you can call
genphy_c37_read_status() and then do any vendor specific fixups
needed.

      Andrew

