Return-Path: <linux-kernel+bounces-118843-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E37E388C01B
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 12:04:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6532BB216AA
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 11:04:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DFB9219EA;
	Tue, 26 Mar 2024 11:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lz8AQyCT"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6115D803;
	Tue, 26 Mar 2024 11:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711451041; cv=none; b=FZh4ziZBu+9lxS2qOXk2m5Ib1g3RQTaj59LeLfrxOc4ZQbQ48yqxFZd0uyofs6F95wMa7Vk+FP0WknaErw4MrO8S4rGlIPm3BA3hXePtYgfq5i7+8CVZ+jWVvOQXuXa4x+OU2+4c/cyAmTWnfg8H8tg/E2KMmoGWVlbDnRJjTFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711451041; c=relaxed/simple;
	bh=F9slUs/Z49ylzomu+AHpY3mR0XJBNgjudTQ/JGzdJ94=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ChCqCY6N9oFLpeDzXvR6mlEc51aly/VGpRR6fIJH9jUzIEZM59H5S0RT+IcbN2i0lU+ifzgHNpYpgQbHTbAWm9WPykQQ2fk3+thhFMEG5zIf8WkT+bXfOj96uzSzibEvekmrXEPdGpSpyUjK6Ozeo/BwMCHY/a/7F8TdtWPxJ+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lz8AQyCT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EAFD8C433F1;
	Tue, 26 Mar 2024 11:03:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711451040;
	bh=F9slUs/Z49ylzomu+AHpY3mR0XJBNgjudTQ/JGzdJ94=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lz8AQyCTjgK7kYzZ/M7hDWasyGcgEI6QYOVA/HXmUrnoBbjIlyHokVOF4qfmPrpIn
	 q052rfQo1GJsHUkS6gcSBseMVHRqnlBOTQKnTkWWAk7jrEkejz6AsPvKDyeEMraYqk
	 UPBkTB31PWobwvf/io28jy4fDGdOwymg0yOPk0TlSnDtneU3Mx0th/hnFwU6h7Tbaf
	 FNe/Jg7SS6D3HK5wRuXyf1VL7pBSCYmK9orLrvdVNFWbpTsoSzQtieHbs4tVliQ7je
	 fjGCtBteWOzaA/hSfQ8Vzc493/9UUSEsAxzxjLVNzRRs1xUKplBHOHiyatlQ/1LU47
	 cijow3Bsvy6qQ==
Date: Tue, 26 Mar 2024 11:03:55 +0000
From: Simon Horman <horms@kernel.org>
To: Pawel Dembicki <paweldembicki@gmail.com>
Cc: netdev@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>,
	Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Claudiu Manoil <claudiu.manoil@nxp.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	UNGLinuxDriver@microchip.com, Russell King <linux@armlinux.org.uk>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v7 07/16] net: dsa: vsc73xx: Add vlan filtering
Message-ID: <20240326110355.GI403975@kernel.org>
References: <20240325204344.2298241-1-paweldembicki@gmail.com>
 <20240325204344.2298241-8-paweldembicki@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240325204344.2298241-8-paweldembicki@gmail.com>

On Mon, Mar 25, 2024 at 09:43:32PM +0100, Pawel Dembicki wrote:
> This patch implements VLAN filtering for the vsc73xx driver.
> 
> After starting VLAN filtering, the switch is reconfigured from QinQ to
> a simple VLAN aware mode. This is required because VSC73XX chips do not
> support inner VLAN tag filtering.
> 
> Signed-off-by: Pawel Dembicki <paweldembicki@gmail.com>

..

> +static int vsc73xx_port_vlan_add(struct dsa_switch *ds, int port,
> +				 const struct switchdev_obj_port_vlan *vlan,
> +				 struct netlink_ext_ack *extack)
> +{
> +	bool untagged = vlan->flags & BRIDGE_VLAN_INFO_UNTAGGED;
> +	bool pvid = vlan->flags & BRIDGE_VLAN_INFO_PVID;
> +	struct dsa_port *dp = dsa_to_port(ds, port);
> +	enum vsc73xx_port_vlan_conf port_vlan_conf;
> +	struct vsc73xx_bridge_vlan *vsc73xx_vlan;
> +	struct vsc73xx_vlan_summary summary;
> +	struct vsc73xx *vsc = ds->priv;
> +	bool operate_on_storage;
> +	int ret;
> +	u16 vid;
> +
> +	/* Be sure to deny alterations to the configuration done by tag_8021q.
> +	 */
> +	if (vid_is_dsa_8021q(vlan->vid)) {
> +		NL_SET_ERR_MSG_MOD(extack,
> +				   "Range 3072-4095 reserved for dsa_8021q operation");
> +		return -EBUSY;
> +	}
> +
> +	/* The processed vlan->vid is excluded from the search because the VLAN
> +	 * can be re-added with a different set of flags, so it's easiest to
> +	 * ignore its old flags from the VLAN database software copy.
> +	 */
> +	vsc73xx_bridge_vlan_summary(vsc, port, &summary, vlan->vid);
> +
> +	/* VSC73XX allow only three untagged states: none, one or all */
> +	if ((untagged && summary.num_tagged > 0 && summary.num_untagged > 0) ||
> +	    (!untagged && summary.num_untagged > 1)) {
> +		NL_SET_ERR_MSG_MOD(extack,
> +				   "Port can have only none, one or all untagged vlan");
> +		return -EBUSY;
> +	}
> +
> +	vsc73xx_vlan = vsc73xx_bridge_vlan_find(vsc, vlan->vid);
> +
> +	if (!vsc73xx_vlan) {
> +		vsc73xx_vlan = kzalloc(sizeof(*vsc73xx_vlan), GFP_KERNEL);
> +		if (!vsc73xx_vlan)
> +			return -ENOMEM;
> +
> +		vsc73xx_vlan->vid = vlan->vid;
> +		vsc73xx_vlan->portmask = 0;
> +		vsc73xx_vlan->untagged = 0;
> +
> +		INIT_LIST_HEAD(&vsc73xx_vlan->list);
> +		list_add_tail(&vsc73xx_vlan->list, &vsc->vlans);
> +	}
> +
> +	vsc73xx_vlan->portmask |= BIT(port);
> +
> +	if (untagged)
> +		vsc73xx_vlan->untagged |= BIT(port);
> +	else
> +		vsc73xx_vlan->untagged &= ~BIT(port);
> +
> +	/* CPU port must be always tagged because port separation is based on
> +	 * tag_8021q.
> +	 */
> +	if (port == CPU_PORT)
> +		goto update_vlan_table;
> +
> +	operate_on_storage = vsc73xx_tag_8021q_active(dp);
> +
> +	if (pvid)
> +		ret = vsc73xx_vlan_set_pvid(vsc, port, vlan->vid,
> +					    operate_on_storage, false);
> +	else if (vsc73xx_port_get_pvid(vsc, port, &vid, false) &&
> +		 vid == vlan->vid)
> +		ret = vsc73xx_vlan_clear_pvid(vsc, port, operate_on_storage,
> +					      false);

Hi Pawel,

some minor feedback from my side.

If neither of the above conditions immediately above is met,
then ret will be used ininitialised on the line below.

Flagged by clang-17 W=1 build, and Smatch.

> +	if (ret)
> +		goto err;

..

-- 
pw-bot: changes-requested

