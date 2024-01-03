Return-Path: <linux-kernel+bounces-15815-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D17A78233AF
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 18:45:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 70C131F213F8
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 17:45:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DE501C2AC;
	Wed,  3 Jan 2024 17:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Veires6m"
X-Original-To: linux-kernel@vger.kernel.org
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FD841CA82;
	Wed,  3 Jan 2024 17:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 56C29240005;
	Wed,  3 Jan 2024 17:45:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1704303906;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cs8g0KhAOJTfgaQgA8pB+LP2E2avXgkG+OV/pjDzLaE=;
	b=Veires6mA8qVJybyozb4tqAFhj632S+ab3KXk7HxxGI9kA0HcSZwNRQeznIVcH7lC/RUj8
	S3d2kl+IsJMw9EFA1kgKLwWgDtlbdKAqBCCBCdzV00V3CGuUej0cZ0awnvoYu3yOh91W+k
	9M5GLLfk2Zo2KO0UP8I+wwV+lVYnnGdJjRQ49aMKIHIosn93STnefnlQfRA+CQtSXaGn+3
	NxPbpzQVlef9KBUClTVID4YiZL88f3eqPyoOh9DzeCWTDhSvDaz3s9LRn52B6nUKoeVlwx
	vIA+KHaC3FyGopwvR4ayIFzmEagbfKym2TpjaTkAGICVPBLtCbYNmoIgiLCnMQ==
Date: Wed, 3 Jan 2024 18:45:01 +0100
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: davem@davemloft.net, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com, Andrew Lunn
 <andrew@lunn.ch>, Jakub Kicinski <kuba@kernel.org>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 linux-arm-kernel@lists.infradead.org, Christophe Leroy
 <christophe.leroy@csgroup.eu>, Herve Codina <herve.codina@bootlin.com>,
 Florian Fainelli <f.fainelli@gmail.com>, Heiner Kallweit
 <hkallweit1@gmail.com>, Vladimir Oltean <vladimir.oltean@nxp.com>,
 =?UTF-8?B?S8O2cnk=?= Maincent <kory.maincent@bootlin.com>, Jesse Brandeburg
 <jesse.brandeburg@intel.com>, Jonathan Corbet <corbet@lwn.net>, Marek
 =?UTF-8?B?QmVow7pu?= <kabel@kernel.org>, Piergiorgio Beruto
 <piergiorgio.beruto@gmail.com>, Oleksij Rempel <o.rempel@pengutronix.de>,
 =?UTF-8?B?Tmljb2zDsg==?= Veronese <nicveronese@gmail.com>, Simon Horman
 <horms@kernel.org>
Subject: Re: [PATCH net-next v5 02/13] net: sfp: pass the phy_device when
 disconnecting an sfp module's PHY
Message-ID: <20240103184501.00be82c2@device-28.home>
In-Reply-To: <ZZV7OerAJWGkSL1I@shell.armlinux.org.uk>
References: <20231221180047.1924733-1-maxime.chevallier@bootlin.com>
	<20231221180047.1924733-3-maxime.chevallier@bootlin.com>
	<ZZV7OerAJWGkSL1I@shell.armlinux.org.uk>
Organization: Bootlin
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.39; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-GND-Sasl: maxime.chevallier@bootlin.com

Hi Russell,

On Wed, 3 Jan 2024 15:20:25 +0000
"Russell King (Oracle)" <linux@armlinux.org.uk> wrote:

> On Thu, Dec 21, 2023 at 07:00:35PM +0100, Maxime Chevallier wrote:
> > Pass the phy_device as a parameter to the sfp upstream .disconnect_phy
> > operation. This is preparatory work to help track phy devices across
> > a net_device's link.
> > 
> > Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
> > ---
> > V5: No changes
> > V4: No changes
> > V3: No changes
> > 
> >  drivers/net/phy/phy_device.c | 8 ++++++++
> >  drivers/net/phy/phylink.c    | 3 ++-
> >  drivers/net/phy/sfp-bus.c    | 4 ++--
> >  include/linux/sfp.h          | 2 +-
> >  4 files changed, 13 insertions(+), 4 deletions(-)
> > 
> > diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
> > index d7c0812bd107..aad78e3f7894 100644
> > --- a/drivers/net/phy/phy_device.c
> > +++ b/drivers/net/phy/phy_device.c
> > @@ -266,6 +266,14 @@ static void phy_mdio_device_remove(struct mdio_device *mdiodev)
> >  
> >  static struct phy_driver genphy_driver;
> >  
> > +static struct phy_link_topology *phy_get_link_topology(struct phy_device *phydev)
> > +{
> > +	if (phydev->attached_dev)
> > +		return &phydev->attached_dev->link_topo;
> > +
> > +	return NULL;
> > +}
> > +
> >  static LIST_HEAD(phy_fixup_list);
> >  static DEFINE_MUTEX(phy_fixup_lock);
> >    
> 
> This should be in a different patch, it seems unrelated to the remainder
> of this patch, and as it's static and no other changes to this file,
> this would cause a build warning.

Arg looks like I squashed that bit here to the wrong commit while
rebasing, it should have been part of commit 03/13 indeed... Sorry for
the hiccup.

Maxime 


