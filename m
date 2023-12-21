Return-Path: <linux-kernel+bounces-8853-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9674481BD48
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 18:32:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C9D1E1C23BB0
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 17:32:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9A5462815;
	Thu, 21 Dec 2023 17:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="oKKM/O7T"
X-Original-To: linux-kernel@vger.kernel.org
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA27462801;
	Thu, 21 Dec 2023 17:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 768841BF203;
	Thu, 21 Dec 2023 17:31:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1703179909;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0M+cuxQcvYewwyk4Th5VGeYl8kRK9tF6Qct+KX6cQ/4=;
	b=oKKM/O7T1r3p5geKv0JQS6h9R7CSVpqcu4nfFHVmAWrSSPd/n9e4grtwCFSsAntGJJC/XX
	hpJKGbmYH1W65BjgUIYe4Sv9CGa/HfyqeU9ym+N5wb2BizHli4nMh8osC3NEEjKRlpafCE
	vwowfV0rRkFbVzZoAwgYLbIP5f4FPGF5HF4Qbpw/Hr8PYG0E9Ow4y/diaTwqqNmhHtV91G
	KIIeTM/lfKR3qI35OAqpmw2L/GbOHMCAQ2+90iqmxgeXhMJZqULGKfgagjXzcBK83+qaQP
	NuzV8fCpgDcxBYXV55pBZ5vXR/e5NVNmbYAa5KKz8g7HYlm51bZjVOBNL7WncQ==
Date: Thu, 21 Dec 2023 18:31:45 +0100
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: davem@davemloft.net, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com, Jakub Kicinski
 <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Russell King <linux@armlinux.org.uk>,
 linux-arm-kernel@lists.infradead.org, Christophe Leroy
 <christophe.leroy@csgroup.eu>, Herve Codina <herve.codina@bootlin.com>,
 Florian Fainelli <f.fainelli@gmail.com>, Heiner Kallweit
 <hkallweit1@gmail.com>, Vladimir Oltean <vladimir.oltean@nxp.com>,
 =?UTF-8?B?S8O2cnk=?= Maincent <kory.maincent@bootlin.com>, Jesse Brandeburg
 <jesse.brandeburg@intel.com>, Jonathan Corbet <corbet@lwn.net>, Marek
 =?UTF-8?B?QmVow7pu?= <kabel@kernel.org>, Piergiorgio Beruto
 <piergiorgio.beruto@gmail.com>, Oleksij Rempel <o.rempel@pengutronix.de>,
 =?UTF-8?B?Tmljb2zDsg==?= Veronese <nicveronese@gmail.com>
Subject: Re: [PATCH net-next v4 10/13] net: ethtool: pse-pd: Target the
 command to the requested PHY
Message-ID: <20231221183145.31c167c0@device-28.home>
In-Reply-To: <5f3a74fe-11e4-4c6e-a77d-f9c4f6fab156@lunn.ch>
References: <20231215171237.1152563-1-maxime.chevallier@bootlin.com>
	<20231215171237.1152563-11-maxime.chevallier@bootlin.com>
	<5f3a74fe-11e4-4c6e-a77d-f9c4f6fab156@lunn.ch>
Organization: Bootlin
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-GND-Sasl: maxime.chevallier@bootlin.com

Hi Andrew,

Sorry I forgot to reply to that one...

On Mon, 18 Dec 2023 10:58:30 +0100
Andrew Lunn <andrew@lunn.ch> wrote:

> On Fri, Dec 15, 2023 at 06:12:32PM +0100, Maxime Chevallier wrote:
> > PSE and PD configuration is a PHY-specific command. Instead of targeting
> > the command towards dev->phydev, use the request to pick the targeted
> > PHY device.
> > 
> > Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
> > ---
> > V4: No changes
> > V3: No changes
> > V2: New patch
> > 
> >  net/ethtool/pse-pd.c | 14 +++-----------
> >  1 file changed, 3 insertions(+), 11 deletions(-)
> > 
> > diff --git a/net/ethtool/pse-pd.c b/net/ethtool/pse-pd.c
> > index cc478af77111..0d9cd9c87104 100644
> > --- a/net/ethtool/pse-pd.c
> > +++ b/net/ethtool/pse-pd.c
> > @@ -31,17 +31,10 @@ const struct nla_policy ethnl_pse_get_policy[ETHTOOL_A_PSE_HEADER + 1] = {
> >  	[ETHTOOL_A_PSE_HEADER] = NLA_POLICY_NESTED(ethnl_header_policy),
> >  };
> >  
> > -static int pse_get_pse_attributes(struct net_device *dev,
> > +static int pse_get_pse_attributes(struct phy_device *phydev,
> >  				  struct netlink_ext_ack *extack,
> >  				  struct pse_reply_data *data)
> >  {
> > -	struct phy_device *phydev = dev->phydev;
> > -
> > -	if (!phydev) {
> > -		NL_SET_ERR_MSG(extack, "No PHY is attached");
> > -		return -EOPNOTSUPP;
> > -	}
> > -  
> 
> It would be good to say in the commit message why it is safe to remove
> this.

That's a good catch, this removal is wrong and will be put back in the
next iteration.

> > @@ -132,7 +124,7 @@ ethnl_set_pse(struct ethnl_req_info *req_info, struct genl_info *info)
> >  	/* this values are already validated by the ethnl_pse_set_policy */
> >  	config.admin_cotrol = nla_get_u32(tb[ETHTOOL_A_PODL_PSE_ADMIN_CONTROL]);
> >  
> > -	phydev = dev->phydev;
> > +	phydev = req_info->phydev;
> >  	if (!phydev) {
> >  		NL_SET_ERR_MSG(info->extack, "No PHY is attached");
> >  		return -EOPNOTSUPP;  
> 
> So you removed one test, but this one stays?

Thanks for the review,

Maxime


