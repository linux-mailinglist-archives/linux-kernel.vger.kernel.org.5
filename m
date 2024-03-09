Return-Path: <linux-kernel+bounces-97774-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DDC12876F3D
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Mar 2024 06:01:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7309BB20E20
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Mar 2024 05:01:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 102E32D051;
	Sat,  9 Mar 2024 05:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eGvsp244"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5441F1DDF5;
	Sat,  9 Mar 2024 05:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709960483; cv=none; b=LzTxn/X69xkNQNMw/L95HPdKkDoAoZbQaZDrKVLFPNfAOv5YRZ4yryc9pRaCFqnaWr6InUl3fhB882CUYIrbO3PwuWXX76a/gDfALfcv2ZZE77bY2GeccNZeP1q4c0cc+dN5WGnXZ8CtOBkJPhn+TEkTbQEmnaalFUn5bD6NpZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709960483; c=relaxed/simple;
	bh=M8WzXsIw4eiekdfMBQOV1EE+w+xXtWIPGcGgOy2XVZg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=erYNiyi2UQs9z360Bexli7xpTUxn8Gd37rP4gTmRtm/h7Pw48x/HNWibhQwfs2Sw7ubHO881lHjI9Dmc6touKRuaGNHEF3kOiZlKO7iY8loXIJLKBfiEC4eAseeCCok1HHm3YIntY1Bf9i1vrO8PW8UWMmiZVeu5XJksQFaozYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eGvsp244; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 088EAC433C7;
	Sat,  9 Mar 2024 05:01:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709960482;
	bh=M8WzXsIw4eiekdfMBQOV1EE+w+xXtWIPGcGgOy2XVZg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=eGvsp2445SIEWJOB/eilitOYMaKkKywyIDgLixJUdT9E71GLyD3ftl0yqD7um3gIs
	 IEdJcdDrE7XBkzO5j1FC2Jy4iqLuUP+nBzeYhg23mAxJV4OoiBqit7Zy1NdS76kmR7
	 GDEXg0kQkhVBeBFfyZMhldFtgtlpZjNCXLNuLh2jxeqH6+W/BSidtxspMLy7ENZDYz
	 +zpraxRKLYhUccWA2Mk+4j9SrAmi3bOlEGpK0hGSlIjqkKHUAjnV4kpgkpKJciFzuZ
	 O0uLiBZyZkpcZRgCxhIo+L3jr8GYe0vRpnlTUyanewzZPLcwB4LXiF/D+P0Boib53U
	 cFTbXwcjDg3hQ==
Date: Fri, 8 Mar 2024 21:01:21 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com, Andrew Lunn
 <andrew@lunn.ch>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Russell King <linux@armlinux.org.uk>,
 linux-arm-kernel@lists.infradead.org, Christophe Leroy
 <christophe.leroy@csgroup.eu>, Herve Codina <herve.codina@bootlin.com>,
 Florian Fainelli <f.fainelli@gmail.com>, Heiner Kallweit
 <hkallweit1@gmail.com>, Vladimir Oltean <vladimir.oltean@nxp.com>,
 =?UTF-8?B?S8O2cnk=?= Maincent <kory.maincent@bootlin.com>, Jesse Brandeburg
 <jesse.brandeburg@intel.com>, Jonathan Corbet <corbet@lwn.net>, Marek
 =?UTF-8?B?QmVow7pu?= <kabel@kernel.org>, Piergiorgio Beruto
 <piergiorgio.beruto@gmail.com>, Oleksij Rempel <o.rempel@pengutronix.de>,
 =?UTF-8?B?Tmljb2zDsg==?= Veronese <nicveronese@gmail.com>, Simon Horman
 <horms@kernel.org>, mwojtas@chromium.org
Subject: Re: [PATCH net-next v10 05/13] net: ethtool: Allow passing a phy
 index for some commands
Message-ID: <20240308210121.0c6a33f9@kernel.org>
In-Reply-To: <20240304151011.1610175-6-maxime.chevallier@bootlin.com>
References: <20240304151011.1610175-1-maxime.chevallier@bootlin.com>
	<20240304151011.1610175-6-maxime.chevallier@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon,  4 Mar 2024 16:10:01 +0100 Maxime Chevallier wrote:
> +``ETHTOOL_A_HEADER_PHY_INDEX`` identify the ethernet PHY the message relates to.

identifies
Ethernet

> +As there are numerous commands that are related to PHY configuration, and because
> +we can have more than one PHY on the link, the PHY index can be passed in the

we can have -> there may be

> +request for the commands that needs it. It is however not mandatory, and if it

commas around however

> +is not passed for commands that target a PHY, the net_device.phydev pointer
> +is used, as a fallback that keeps the legacy behaviour.

s/ that keeps the legacy behaviour// feels more like a default than
legacy TBH

> @@ -104,7 +124,7 @@ int ethnl_parse_header_dev_get(struct ethnl_req_info *req_info,
>  	/* No validation here, command policy should have a nested policy set
>  	 * for the header, therefore validation should have already been done.
>  	 */
> -	ret = nla_parse_nested(tb, ARRAY_SIZE(ethnl_header_policy) - 1, header,
> +	ret = nla_parse_nested(tb, ARRAY_SIZE(ethnl_header_policy_phy) - 1, header,
>  			       NULL, extack);
>  	if (ret < 0)
>  		return ret;
> @@ -145,6 +165,26 @@ int ethnl_parse_header_dev_get(struct ethnl_req_info *req_info,
>  		return -EINVAL;
>  	}
>  
> +	if (dev) {
> +		if (tb[ETHTOOL_A_HEADER_PHY_INDEX]) {
> +			u32 phy_index = nla_get_u32(tb[ETHTOOL_A_HEADER_PHY_INDEX]);
> +
> +			phydev = phy_link_topo_get_phy(dev->link_topo,
> +						       phy_index);
> +			if (!phydev) {
> +				NL_SET_ERR_MSG_ATTR(extack, header,
> +						    "no phy matches phy index");
> +				return -EINVAL;

You can drop the msg, and use ENODEV?
Also point at the index, not header:

			struct nl_attr *phyid;

			phyid = tb[ETHTOOL_A_HEADER_PHY_INDEX];
			phydev = phy_link_topo_get_phy(dev->link_topo,
						       nla_get_u32(phyid));
			if (!...
				NL_SET_ERR_ATTR(extack, phyid);
				return -ENODEV;

> +			}
> +		} else {
> +			/* If we need a PHY but no phy index is specified, fallback
> +			 * to dev->phydev
> +			 */
> +			phydev = dev->phydev;
> +		}
> +	}

else if (tb[ETHTOOL_A_HEADER_PHY_INDEX]) {
	NL_SET_ERR_MSG_ATTR("can't target a PHY without a netdev")
	...

? just in case someone calls this with _phy policy and no dev required?

