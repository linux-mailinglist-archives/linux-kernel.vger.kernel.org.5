Return-Path: <linux-kernel+bounces-73031-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AD5C485BC5E
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 13:40:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6AF232847F1
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 12:39:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8886E69DEF;
	Tue, 20 Feb 2024 12:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rzZm8mUW"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEA3E67E95;
	Tue, 20 Feb 2024 12:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708432769; cv=none; b=pnD5mTL30gqNThJNzt87AxdONDTCqOxXBjajJ0RHNT22kkHnKB0XaKXcJ7fm7+pDGKXd88Hz96GqdcTr2x1n1SoU8tcR5dA0XGV66yCjIyrZCSxkVpifPlWK9KsgZlfiZYwO+likvpeD0eHDbk5RCUhIpa4oG9wdPh/gIEMEIgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708432769; c=relaxed/simple;
	bh=zaRvBdCErfnTGRRy1hJDAaFwvmR35DTVIeIkU5YZ8ec=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a8tv56Ce8dmZAhZrBKowrB+6k5MrWjKWyrckZocJPtAERBHCipXXv6Qnin/OyMBGEt6QIG2qzAFlBnMGno1H+TKWDYZcpXjoekj08EJsfLOWvvE45DgUbjOFsR1qszDkDFDLd8Y1z5pIUGuZ7aRO4pYLaou+/4RpXXZehEDISCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rzZm8mUW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C578FC433F1;
	Tue, 20 Feb 2024 12:39:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708432769;
	bh=zaRvBdCErfnTGRRy1hJDAaFwvmR35DTVIeIkU5YZ8ec=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rzZm8mUWfLWVPAhjMB5ui51kgxlP9xkCOMONOR0ogWf89KCxuVO+kJbk+KdnLjF5D
	 TKoeUzJPAKDFjHcCIRZkr3g9G0u5t/tXUNs5awpZUaczYJlP6/HRdg70FscwWWNxPO
	 UvpeQ4y6A0Z5fB6svIAtv2q0fZJ8yeCRIyMHKzv6b1udlQFiVJq/OfCN3DC5hFxd7Y
	 kUhh++iQhYoYD87Ap3WHCF900Pnu1+0EqL/hiAXxBfq7Nh1toa/j87W5MPytjozLEI
	 LifVXEMXp7KzlIiJJw3G3e5dYDeb3og75TQpO89Kz56VIo2nCobToOkmlnhgcgJjH4
	 /ugMfTe9PHkVQ==
Date: Tue, 20 Feb 2024 12:39:24 +0000
From: Simon Horman <horms@kernel.org>
To: Andrew Lunn <andrew@lunn.ch>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Ariel Elior <aelior@marvell.com>,
	Manish Chopra <manishc@marvell.com>,
	Jesse Brandeburg <jesse.brandeburg@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>, linux-usb@vger.kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	intel-wired-lan@lists.osuosl.org
Subject: Re: [PATCH net-next v4 2/9] net: usb: ax88179_178a: Use linkmode
 helpers for EEE
Message-ID: <20240220123924.GA40273@kernel.org>
References: <20240218-keee-u32-cleanup-v4-0-71f13b7c3e60@lunn.ch>
 <20240218-keee-u32-cleanup-v4-2-71f13b7c3e60@lunn.ch>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240218-keee-u32-cleanup-v4-2-71f13b7c3e60@lunn.ch>

On Sun, Feb 18, 2024 at 11:06:59AM -0600, Andrew Lunn wrote:
> Make use of the existing linkmode helpers for converting PHY EEE
> register values into links modes, now that ethtool_keee uses link
> modes, rather than u32 values.
> 
> Signed-off-by: Andrew Lunn <andrew@lunn.ch>
> ---
>  drivers/net/usb/ax88179_178a.c | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/net/usb/ax88179_178a.c b/drivers/net/usb/ax88179_178a.c
> index d6168eaa286f..d4bf9865d87b 100644
> --- a/drivers/net/usb/ax88179_178a.c
> +++ b/drivers/net/usb/ax88179_178a.c
> @@ -676,21 +676,21 @@ ax88179_ethtool_get_eee(struct usbnet *dev, struct ethtool_keee *data)
>  					    MDIO_MMD_PCS);
>  	if (val < 0)
>  		return val;
> -	data->supported_u32 = mmd_eee_cap_to_ethtool_sup_t(val);
> +	mii_eee_cap1_mod_linkmode_t(data->supported, val);
>  
>  	/* Get advertisement EEE */
>  	val = ax88179_phy_read_mmd_indirect(dev, MDIO_AN_EEE_ADV,
>  					    MDIO_MMD_AN);
>  	if (val < 0)
>  		return val;
> -	data->advertised_u32 = mmd_eee_adv_to_ethtool_adv_t(val);
> +	mii_eee_cap1_mod_linkmode_t(data->advertised, val);
>  
>  	/* Get LP advertisement EEE */
>  	val = ax88179_phy_read_mmd_indirect(dev, MDIO_AN_EEE_LPABLE,
>  					    MDIO_MMD_AN);
>  	if (val < 0)
>  		return val;
> -	data->lp_advertised_u32 = mmd_eee_adv_to_ethtool_adv_t(val);
> +	mii_eee_cap1_mod_linkmode_t(data->lp_advertised, val);
>  
>  	return 0;
>  }
> @@ -698,7 +698,7 @@ ax88179_ethtool_get_eee(struct usbnet *dev, struct ethtool_keee *data)
>  static int
>  ax88179_ethtool_set_eee(struct usbnet *dev, struct ethtool_keee *data)
>  {
> -	u16 tmp16 = ethtool_adv_to_mmd_eee_adv_t(data->advertised_u32);
> +	u16 tmp16 = linkmode_to_mii_eee_cap1_t(data->advertised);
>  
>  	return ax88179_phy_write_mmd_indirect(dev, MDIO_AN_EEE_ADV,
>  					      MDIO_MMD_AN, tmp16);
> @@ -1663,7 +1663,6 @@ static int ax88179_reset(struct usbnet *dev)
>  	ax88179_disable_eee(dev);
>  
>  	ax88179_ethtool_get_eee(dev, &eee_data);
> -	eee_data.advertised_u32 = 0;

Hi Andrew,

could you clarify why advertised no longer needs to be cleared?

>  	ax88179_ethtool_set_eee(dev, &eee_data);
>  
>  	/* Restart autoneg */
> 
> -- 
> 2.43.0
> 
> 

