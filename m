Return-Path: <linux-kernel+bounces-15695-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7817B823069
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 16:20:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0C227282698
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 15:20:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14E341A735;
	Wed,  3 Jan 2024 15:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="Kv0YNK7+"
X-Original-To: linux-kernel@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66D2F1B26C;
	Wed,  3 Jan 2024 15:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=m8sac+OI422yNvHd7yq1KwdsQdE6JGin4RzHy40w56s=; b=Kv0YNK7+rps9DdBGGO5WXeGDhB
	cS+HBcQYXuZCcEZ1ILAqsUv17vyuyM99oIggzYSP1WjPXt1stuAQHjPETsE2paOLu1LXXMr0Cod/F
	r9mSDrsW3O37Uf0mFwyPe2Y899uuLdsxMFXaRxPDeZ+mtcBTMzcIZ05BD0w/LNfcHkKI3shgm5I7A
	M6IM92vazLEVB/Q074wQfF5c3IAcH2mPMm7awXq11ZnAh+GlWkYui5NSCkXGivSRsNOZxAK0mAhl2
	nEP+dDC/kbku4oHEmenNVHzTjsJN5QbiDglXWHenifScisk5FeGub4uowuKjxZo9JAwpHxRj8Jh1a
	0JQEKCkQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:32952)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1rL32f-0007dm-2k;
	Wed, 03 Jan 2024 15:20:25 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1rL32f-0006U5-D9; Wed, 03 Jan 2024 15:20:25 +0000
Date: Wed, 3 Jan 2024 15:20:25 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com,
	Andrew Lunn <andrew@lunn.ch>, Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
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
	Simon Horman <horms@kernel.org>
Subject: Re: [PATCH net-next v5 02/13] net: sfp: pass the phy_device when
 disconnecting an sfp module's PHY
Message-ID: <ZZV7OerAJWGkSL1I@shell.armlinux.org.uk>
References: <20231221180047.1924733-1-maxime.chevallier@bootlin.com>
 <20231221180047.1924733-3-maxime.chevallier@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231221180047.1924733-3-maxime.chevallier@bootlin.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Thu, Dec 21, 2023 at 07:00:35PM +0100, Maxime Chevallier wrote:
> Pass the phy_device as a parameter to the sfp upstream .disconnect_phy
> operation. This is preparatory work to help track phy devices across
> a net_device's link.
> 
> Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
> ---
> V5: No changes
> V4: No changes
> V3: No changes
> 
>  drivers/net/phy/phy_device.c | 8 ++++++++
>  drivers/net/phy/phylink.c    | 3 ++-
>  drivers/net/phy/sfp-bus.c    | 4 ++--
>  include/linux/sfp.h          | 2 +-
>  4 files changed, 13 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
> index d7c0812bd107..aad78e3f7894 100644
> --- a/drivers/net/phy/phy_device.c
> +++ b/drivers/net/phy/phy_device.c
> @@ -266,6 +266,14 @@ static void phy_mdio_device_remove(struct mdio_device *mdiodev)
>  
>  static struct phy_driver genphy_driver;
>  
> +static struct phy_link_topology *phy_get_link_topology(struct phy_device *phydev)
> +{
> +	if (phydev->attached_dev)
> +		return &phydev->attached_dev->link_topo;
> +
> +	return NULL;
> +}
> +
>  static LIST_HEAD(phy_fixup_list);
>  static DEFINE_MUTEX(phy_fixup_lock);
>  

This should be in a different patch, it seems unrelated to the remainder
of this patch, and as it's static and no other changes to this file,
this would cause a build warning.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

