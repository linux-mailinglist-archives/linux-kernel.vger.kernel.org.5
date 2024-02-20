Return-Path: <linux-kernel+bounces-73036-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F28CA85BC74
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 13:44:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5BB40287D51
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 12:44:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4C5469D0F;
	Tue, 20 Feb 2024 12:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="atZ3fq9A"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2194467C74;
	Tue, 20 Feb 2024 12:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708433051; cv=none; b=ouNVbknerKozU//mfW/Zaj8bJ5cp2JbhAJnKNzNS9i/XcMfv+jzF/eAanM1oXpovgsImE6qpDSiD1mVT9qEjRLbnE8VzVirGpUlnLqrRqvm0OGSV0I4FisjakGzL3Q/x5bxapWpcbcCc0FBbHrKBaWcsi38V1qyw7DxKNDELago=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708433051; c=relaxed/simple;
	bh=pOErrnrrbQEnaNXElPlM3SFEJg4SBjhPI7dWuasZy/4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MnbE3oQiwlrcW84VkK3sc7+q/UEt+HbBEUDcvdx305oqyApM5nZWABIE896Ap8N3dTsviRQ2tgL+Guaj3GXsx5QTBICsjhyscnchSI1uivPCSUJNo37Sh9940IFEHhyqxXHkhMOVD1dWfvaPRLq2ecez2oCP8srCwGOKs68EPrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=atZ3fq9A; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2082DC433F1;
	Tue, 20 Feb 2024 12:44:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708433050;
	bh=pOErrnrrbQEnaNXElPlM3SFEJg4SBjhPI7dWuasZy/4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=atZ3fq9AY0IiRLZO2jJFAcr63jgN0ZbIIYtOxV8gmqrHKW19DYq2yO9IHt9WGQFzC
	 w1RGc9MU0txJnxNkm4J75ZOhJMHChc5R3UyxDDlp+k+ngAc/MiVpfjokd4hwaUkZhR
	 sqPGEvVNj6nL66wzCdfBmkdNJToKuJAZ5Gpz5HSrKLN1bACwSerEeRIABSqcZUosqV
	 IG27lxcoQEoepMm8GZfctO0Mp9bN0a1kNTwFFyICClYwYuJQkrp1N7mkFdU2nMez8+
	 hnmTenjYSa0uMH1kSO+A/3PcqVw/RHGOMHelIadPB4PrXvOXE5JFoRf+Kpw/MqaLcn
	 z0sA+BCpO0i5A==
Date: Tue, 20 Feb 2024 12:44:05 +0000
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
Subject: Re: [PATCH net-next v4 3/9] net: qlogic: qede: Use linkmode helpers
 for EEE
Message-ID: <20240220124405.GB40273@kernel.org>
References: <20240218-keee-u32-cleanup-v4-0-71f13b7c3e60@lunn.ch>
 <20240218-keee-u32-cleanup-v4-3-71f13b7c3e60@lunn.ch>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240218-keee-u32-cleanup-v4-3-71f13b7c3e60@lunn.ch>

On Sun, Feb 18, 2024 at 11:07:00AM -0600, Andrew Lunn wrote:
> Make use of the existing linkmode helpers for bit manipulation of EEE
> advertise, support and link partner support. The aim is to drop the
> restricted _u32 variants in the near future.
> 
> Signed-off-by: Andrew Lunn <andrew@lunn.ch>

Thanks Andrew,

the nit below notwithstanding this looks good to me.

Reviewed-by: Simon Horman <horms@kernel.org>

> ---
>  drivers/net/ethernet/qlogic/qede/qede_ethtool.c | 60 ++++++++++++++++---------
>  1 file changed, 38 insertions(+), 22 deletions(-)
> 
> diff --git a/drivers/net/ethernet/qlogic/qede/qede_ethtool.c b/drivers/net/ethernet/qlogic/qede/qede_ethtool.c

..

> @@ -1812,9 +1820,12 @@ static int qede_get_eee(struct net_device *dev, struct ethtool_keee *edata)
>  
>  static int qede_set_eee(struct net_device *dev, struct ethtool_keee *edata)
>  {
> +	__ETHTOOL_DECLARE_LINK_MODE_MASK(supported) = {};
> +	__ETHTOOL_DECLARE_LINK_MODE_MASK(tmp) = {};
>  	struct qede_dev *edev = netdev_priv(dev);
>  	struct qed_link_output current_link;
>  	struct qed_link_params params;
> +	bool unsupp;
>  
>  	if (!edev->ops->common->can_link_change(edev->cdev)) {
>  		DP_INFO(edev, "Link settings are not allowed to be changed\n");
> @@ -1832,21 +1843,26 @@ static int qede_set_eee(struct net_device *dev, struct ethtool_keee *edata)
>  	memset(&params, 0, sizeof(params));
>  	params.override_flags |= QED_LINK_OVERRIDE_EEE_CONFIG;
>  
> -	if (!(edata->advertised_u32 & (ADVERTISED_1000baseT_Full |
> -				       ADVERTISED_10000baseT_Full)) ||
> -	    ((edata->advertised_u32 & (ADVERTISED_1000baseT_Full |
> -				       ADVERTISED_10000baseT_Full)) !=
> -	     edata->advertised_u32)) {
> +	linkmode_set_bit(ETHTOOL_LINK_MODE_10000baseT_Full_BIT,
> +			 supported);
> +	linkmode_set_bit(ETHTOOL_LINK_MODE_1000baseT_Full_BIT,
> +			 supported);
> +
> +	unsupp = linkmode_andnot(tmp, edata->advertised, supported);

nit: Given the types involved, I might have written this as:

	unsupp = !!linkmode_andnot(tmp, edata->advertised, supported);

> +	if (unsupp) {
>  		DP_VERBOSE(edev, QED_MSG_DEBUG,
> -			   "Invalid advertised capabilities %d\n",
> -			   edata->advertised_u32);
> +			   "Invalid advertised capabilities %*pb\n",
> +			   __ETHTOOL_LINK_MODE_MASK_NBITS, edata->advertised);
>  		return -EINVAL;
>  	}
>  
> -	if (edata->advertised_u32 & ADVERTISED_1000baseT_Full)
> +	if (linkmode_test_bit(ETHTOOL_LINK_MODE_1000baseT_Full_BIT,
> +			      edata->advertised))
>  		params.eee.adv_caps = QED_EEE_1G_ADV;
> -	if (edata->advertised_u32 & ADVERTISED_10000baseT_Full)
> -		params.eee.adv_caps |= QED_EEE_10G_ADV;
> +	if (linkmode_test_bit(ETHTOOL_LINK_MODE_10000baseT_Full_BIT,
> +			      edata->advertised))
> +		params.eee.adv_caps = QED_EEE_10G_ADV;
> +
>  	params.eee.enable = edata->eee_enabled;
>  	params.eee.tx_lpi_enable = edata->tx_lpi_enabled;
>  	params.eee.tx_lpi_timer = edata->tx_lpi_timer;
> 
> -- 
> 2.43.0
> 
> 

