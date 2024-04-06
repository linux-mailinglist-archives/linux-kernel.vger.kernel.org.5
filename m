Return-Path: <linux-kernel+bounces-133988-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E8C889ABC9
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Apr 2024 17:51:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C611FB21734
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Apr 2024 15:51:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1378F3BBD2;
	Sat,  6 Apr 2024 15:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="04ff6QxF"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13F7F2B9CE;
	Sat,  6 Apr 2024 15:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712418679; cv=none; b=Z5AZhF19gtiMG9IN+4dmQH9WYJUwVdOPLo+azQ772g2K3NcNfIKaWEbSFhCu25P2oGr32ovBJmqFRz++5u5aTbnY4tenG5J+X8JfmAokkN47XOgvZ2kTnPafOOD1udSCguPD7xU5TiNiMKlIrYh7ItxfeejtUE9zd5iZ4CDBIf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712418679; c=relaxed/simple;
	bh=lp6fIx2QGzzZL15VJHwAUgYmgUhpH59peCuTj/YVL8E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PF8j3zfJoQn0c786XqKHiAnoD1zrUwVzhKhYjuES3wI6HXgwboWx6Cqu3OD5v0esGTwYKwEY0Ds3b3yvmV03q6/dH51NjMfcRE7lu1xsSRJptVBWW84aWrLL/qJqVJ/eDdjZa0KOIui4ZbKa7aXRBliDk5mPG90yR3o86oLOVu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=04ff6QxF; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=Eq+WYVe7ZG4D7uYVbOzuAjHgqNe69MUAj/3ZLYiacM0=; b=04ff6QxFGP+O57ChfgcHW3uZbO
	obGU9F50Oxw3CTxg7vb4GrGMfdCVexgtBoJOSO9sgvqihy+gz+r4aCJxv8rUzRrKZlSR14uvnn4q3
	kCv/ByhY6HWGoufYbwjjkAIXYIGmJk7VIAADlfO54zQaXzWv91tjI6gj/23lGHfk58n4=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rt8Jv-00CNRN-K5; Sat, 06 Apr 2024 17:51:07 +0200
Date: Sat, 6 Apr 2024 17:51:07 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>,
	linux-arm-kernel@lists.infradead.org,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Herve Codina <herve.codina@bootlin.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	=?iso-8859-1?Q?K=F6ry?= Maincent <kory.maincent@bootlin.com>,
	Jesse Brandeburg <jesse.brandeburg@intel.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>,
	Piergiorgio Beruto <piergiorgio.beruto@gmail.com>,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	=?iso-8859-1?Q?Nicol=F2?= Veronese <nicveronese@gmail.com>,
	Simon Horman <horms@kernel.org>, mwojtas@chromium.org
Subject: Re: [PATCH net-next v11 01/13] net: phy: Introduce ethernet link
 topology representation
Message-ID: <f0a33859-bdb7-474d-8c23-edb158b0fd91@lunn.ch>
References: <20240404093004.2552221-1-maxime.chevallier@bootlin.com>
 <20240404093004.2552221-2-maxime.chevallier@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240404093004.2552221-2-maxime.chevallier@bootlin.com>

On Thu, Apr 04, 2024 at 11:29:51AM +0200, Maxime Chevallier wrote:
> Link topologies containing multiple network PHYs attached to the same
> net_device can be found when using a PHY as a media converter for use
> with an SFP connector, on which an SFP transceiver containing a PHY can
> be used.
> 
> With the current model, the transceiver's PHY can't be used for
> operations such as cable testing, timestamping, macsec offload, etc.
> 
> The reason being that most of the logic for these configuration, coming
> from either ethtool netlink or ioctls tend to use netdev->phydev, which
> in multi-phy systems will reference the PHY closest to the MAC.
> 
> Introduce a numbering scheme allowing to enumerate PHY devices that
> belong to any netdev, which can in turn allow userspace to take more
> precise decisions with regard to each PHY's configuration.
> 
> The numbering is maintained per-netdev, in a phy_device_list.
> The numbering works similarly to a netdevice's ifindex, with
> identifiers that are only recycled once INT_MAX has been reached.
> 
> This prevents races that could occur between PHY listing and SFP
> transceiver removal/insertion.
> 
> The identifiers are assigned at phy_attach time, as the numbering
> depends on the netdevice the phy is attached to. The PHY index can be
> re-used for PHYs that are persistent.
> 
> Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

