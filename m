Return-Path: <linux-kernel+bounces-72981-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B90685BB6B
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 13:07:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AEE551F25283
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 12:07:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 104A167E70;
	Tue, 20 Feb 2024 12:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IsU1gpx6"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CA5467C45;
	Tue, 20 Feb 2024 12:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708430808; cv=none; b=JL9Y9KesD0NvEJDCwSigXDiL+jrgsXOk/yB+520B4dKqpkxRXcl44lb/e/3Hwf5F8h+jEXnolV2BHt9ok+tzD0Vk0iwpK2blmIoCyq4uYuI6XrGEtsN04VPyRruagv7H29abocGTCXfxZ/aU02XFW2IkNlxtg2UPFONJ3//nbu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708430808; c=relaxed/simple;
	bh=g7OWh2V1T0jWuCWOpLghLxY/l/z2kpl8hgQUF80BDLk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q4EryJtKNeuugjNf9lVSNJUNm0OYIbPNxhBMOTNRrIrlhyfF/3DV3WrJMS6GWBXTah/Kb0nzzo+69u5Q4z4rcdpM9QStjxnWh/ariS5SdXHndObtAwjaHpPRU8oaWVPn3sCo0rB6e6AU5yZ0o3kNos89KlCb4lZZfbQB91cEqx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IsU1gpx6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C2E0C433C7;
	Tue, 20 Feb 2024 12:06:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708430807;
	bh=g7OWh2V1T0jWuCWOpLghLxY/l/z2kpl8hgQUF80BDLk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IsU1gpx6BLHMdxvwzV2splWpbqoYa6PWyr4iVc0LZEQTV6AUeKVxCp7HM0rvMoTRs
	 JXhqKr4qcuCtMvQx9mO7FcroqUtYg4XPI9KC0azUZI1Ftea729VOTL59xrSQKsJqM6
	 GwVZLjjaNiLgDxk7hxB2QTzw5Shxg6QkjWyasn59ei5xf2cPcIqN/x30PaBuQRB0zf
	 KazOn5NIGF2ZJIr+mRvp+UDjviLAR+o2Om3voD9dgke7DPyohmDaK/jMCQOOyJV77r
	 WyW630lB2Lmvf3mMoVt6jD5xweAjYAshlQVDV2KkDWSGKJDeH9vR2eh//bv3zOsGhv
	 5eorKcz+qy36w==
Date: Tue, 20 Feb 2024 12:06:43 +0000
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
Subject: Re: [PATCH net-next v4 4/9] net: ethernet: ixgbe: Convert EEE to use
 linkmodes
Message-ID: <20240220120643.GZ40273@kernel.org>
References: <20240218-keee-u32-cleanup-v4-0-71f13b7c3e60@lunn.ch>
 <20240218-keee-u32-cleanup-v4-4-71f13b7c3e60@lunn.ch>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240218-keee-u32-cleanup-v4-4-71f13b7c3e60@lunn.ch>

On Sun, Feb 18, 2024 at 11:07:01AM -0600, Andrew Lunn wrote:
> Convert the tables to make use of ETHTOOL link mode bits, rather than
> the old u32 SUPPORTED speeds. Make use of the linkmode helps to set
> bits and compare linkmodes. As a result, the _u32 members of keee are
> no longer used, a step towards removing them.
> 
> Signed-off-by: Andrew Lunn <andrew@lunn.ch>
> ---
>  drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c | 48 ++++++++++++------------
>  1 file changed, 25 insertions(+), 23 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c

..

> @@ -3436,28 +3437,29 @@ ixgbe_get_eee_fw(struct ixgbe_adapter *adapter, struct ethtool_keee *edata)
>  	if (rc)
>  		return rc;
>  
> -	edata->lp_advertised_u32 = 0;
>  	for (i = 0; i < ARRAY_SIZE(ixgbe_lp_map); ++i) {
>  		if (info[0] & ixgbe_lp_map[i].lp_advertised)
> -			edata->lp_advertised_u32 |= ixgbe_lp_map[i].mac_speed;
> +			linkmode_set_bit(ixgbe_lp_map[i].link_mode,
> +					 edata->lp_advertised);
>  	}
>  
> -	edata->supported_u32 = 0;
>  	for (i = 0; i < ARRAY_SIZE(ixgbe_ls_map); ++i) {
>  		if (hw->phy.eee_speeds_supported & ixgbe_ls_map[i].mac_speed)
> -			edata->supported_u32 |= ixgbe_ls_map[i].supported;
> +			linkmode_set_bit(ixgbe_lp_map[i].link_mode,
> +					 edata->lp_advertised);

Hi Andrew,

should this be edata->supported rather than edata->lp_advertised?

>  	}
>  
> -	edata->advertised_u32 = 0;
>  	for (i = 0; i < ARRAY_SIZE(ixgbe_ls_map); ++i) {
>  		if (hw->phy.eee_speeds_advertised & ixgbe_ls_map[i].mac_speed)
> -			edata->advertised_u32 |= ixgbe_ls_map[i].supported;
> +			linkmode_set_bit(ixgbe_lp_map[i].link_mode,
> +					 edata->advertised);
>  	}
>  
> -	edata->eee_enabled = !!edata->advertised_u32;
> +	edata->eee_enabled = !linkmode_empty(edata->advertised);
>  	edata->tx_lpi_enabled = edata->eee_enabled;
> -	if (edata->advertised_u32 & edata->lp_advertised_u32)
> -		edata->eee_active = true;
> +
> +	linkmode_and(common, edata->advertised, edata->lp_advertised);
> +	edata->eee_active = !linkmode_empty(common);
>  
>  	return 0;
>  }

..

