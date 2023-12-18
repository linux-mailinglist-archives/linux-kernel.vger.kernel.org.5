Return-Path: <linux-kernel+bounces-3282-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B6BC7816A5D
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 10:59:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DBC981C22871
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 09:59:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04B81134B6;
	Mon, 18 Dec 2023 09:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="jCdHceUW"
X-Original-To: linux-kernel@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B05A813FFB;
	Mon, 18 Dec 2023 09:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=oy2S57Ia795NCnjW5zgqmFnUT8qKZ0VYqVrGM8Qzdt0=; b=jCdHceUWD3PsaQmS/oFMeVfJ2o
	7BLA8GOd1jGU5ZpJmX8+Jn0GS4HKTcIW/Ft9DX4jPUZykcGlAwpgw62tEuL945S2WSe42du458N15
	abj0cn2QjZduhb0eLOn7D1y3tHjS02Aut+19Fpepj1Pw7TX73S2v/l7aHDOBzXgj1da8=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rFAOM-003ENO-9a; Mon, 18 Dec 2023 10:58:30 +0100
Date: Mon, 18 Dec 2023 10:58:30 +0100
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
	=?iso-8859-1?Q?Nicol=F2?= Veronese <nicveronese@gmail.com>
Subject: Re: [PATCH net-next v4 10/13] net: ethtool: pse-pd: Target the
 command to the requested PHY
Message-ID: <5f3a74fe-11e4-4c6e-a77d-f9c4f6fab156@lunn.ch>
References: <20231215171237.1152563-1-maxime.chevallier@bootlin.com>
 <20231215171237.1152563-11-maxime.chevallier@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231215171237.1152563-11-maxime.chevallier@bootlin.com>

On Fri, Dec 15, 2023 at 06:12:32PM +0100, Maxime Chevallier wrote:
> PSE and PD configuration is a PHY-specific command. Instead of targeting
> the command towards dev->phydev, use the request to pick the targeted
> PHY device.
> 
> Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
> ---
> V4: No changes
> V3: No changes
> V2: New patch
> 
>  net/ethtool/pse-pd.c | 14 +++-----------
>  1 file changed, 3 insertions(+), 11 deletions(-)
> 
> diff --git a/net/ethtool/pse-pd.c b/net/ethtool/pse-pd.c
> index cc478af77111..0d9cd9c87104 100644
> --- a/net/ethtool/pse-pd.c
> +++ b/net/ethtool/pse-pd.c
> @@ -31,17 +31,10 @@ const struct nla_policy ethnl_pse_get_policy[ETHTOOL_A_PSE_HEADER + 1] = {
>  	[ETHTOOL_A_PSE_HEADER] = NLA_POLICY_NESTED(ethnl_header_policy),
>  };
>  
> -static int pse_get_pse_attributes(struct net_device *dev,
> +static int pse_get_pse_attributes(struct phy_device *phydev,
>  				  struct netlink_ext_ack *extack,
>  				  struct pse_reply_data *data)
>  {
> -	struct phy_device *phydev = dev->phydev;
> -
> -	if (!phydev) {
> -		NL_SET_ERR_MSG(extack, "No PHY is attached");
> -		return -EOPNOTSUPP;
> -	}
> -

It would be good to say in the commit message why it is safe to remove
this.

> @@ -132,7 +124,7 @@ ethnl_set_pse(struct ethnl_req_info *req_info, struct genl_info *info)
>  	/* this values are already validated by the ethnl_pse_set_policy */
>  	config.admin_cotrol = nla_get_u32(tb[ETHTOOL_A_PODL_PSE_ADMIN_CONTROL]);
>  
> -	phydev = dev->phydev;
> +	phydev = req_info->phydev;
>  	if (!phydev) {
>  		NL_SET_ERR_MSG(info->extack, "No PHY is attached");
>  		return -EOPNOTSUPP;

So you removed one test, but this one stays?

   Andrew

