Return-Path: <linux-kernel+bounces-106477-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 450F387EF25
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 18:45:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 753E81C22021
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 17:45:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9C5155C34;
	Mon, 18 Mar 2024 17:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WWaNDbWT"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2270D55C14;
	Mon, 18 Mar 2024 17:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710783909; cv=none; b=PXAUB3C5X5uxHSdK7qWU8uaIsLu2ZZjrsih98upGw21BPAzfDngPsgtYSvdjWmSNva43tfvExIfMTWv/m6uV4ilTt/SejXQJznWYIar+WWhYXaQfsYu1u9f6eBjPNmbaDhV1w5w3/hp/FmFB4YlrZ1q96PeJuZHWTX63WQvzsU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710783909; c=relaxed/simple;
	bh=Rv/2CA5wPLokC7VCqSey3DSFL6DXzXxuAMNj1og1Kh8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=htG0RGqTwPjeT1VPB8uWvApYDKrkj47FD134YOuHyH/6DJAQ9PJwhKITacf/ZVXI6VHKIlw4NupePjbPVFPNcLKucN5Z90xx0Pbp4UEE30uK3lTrLIHpgl9smWNVXxDf4m+tiTyodHZsLnswJ9pXfcfMKmKHpZuMCfrpS9nsJjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WWaNDbWT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5570FC433C7;
	Mon, 18 Mar 2024 17:45:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710783908;
	bh=Rv/2CA5wPLokC7VCqSey3DSFL6DXzXxuAMNj1og1Kh8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WWaNDbWTEAAmKf9IeOXu65Mq96lSZxdoIzl57Yufwp7sGduxsN9HEXIrYzX7xVFRB
	 Hy1mtA1Are4jKEG2IACOEirgKrPxv9Zs1dp7fdnMC0bfOtcyEQQneb+Sq2IR+LNeuJ
	 Qm4PaSYyJSYzEW1PyUQ3GA1oW4uCUo9cP2Kl9ZFUVbePgoZjMoBtm4yIL6lG3iI5Y6
	 Ap2yMBGMzoB+Ep1+VDrr0mYHjUf9hszzwqUb9eC2syA33HpPQrMK2u0+nfb9oVk6BT
	 M0dwO4pTylvIrS88SdlZVkZ9B3ZjCplzmiIWt/w24KRM8YTMndNRvb32gsfsIG37Lt
	 rRb95s82iaBfg==
Date: Mon, 18 Mar 2024 17:45:03 +0000
From: Simon Horman <horms@kernel.org>
To: Erwan Velu <erwanaliasr1@gmail.com>
Cc: Erwan Velu <e.velu@criteo.com>,
	Jesse Brandeburg <jesse.brandeburg@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 iwl-net] i40e: Prevent setting MTU if greater than MFS
Message-ID: <20240318174503.GE1623@kernel.org>
References: <20240313090719.33627-2-e.velu@criteo.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240313090719.33627-2-e.velu@criteo.com>

On Wed, Mar 13, 2024 at 10:07:16AM +0100, Erwan Velu wrote:
> Commit 6871a7de705 ("[intelxl] Use admin queue to set port MAC address
> and maximum frame size") from iPXE project set the MFS to 0x600 = 1536.
> See https://github.com/ipxe/ipxe/commit/6871a7de705
> 
> At boot time the i40e driver complains about it with
> the following message but continues.
> 
> 	MFS for port 1 has been set below the default: 600
> 
> If the MTU size is increased, the driver accepts it but large packets will
> not be processed by the firmware generating tx_errors. The issue is pretty
> silent for users. i.e doing TCP in such context will generates lots of
> retransmissions until the proper window size (below 1500) will be used.
> 
> To fix this case, it would have been ideal to increase the MFS,
> via i40e_aqc_opc_set_mac_config, incoming patch will take care of it.
> 
> At least, commit prevents setting up an MTU greater than the current MFS.
> It will avoid being in the position of having an MTU set to 9000 on the
> netdev with a firmware refusing packets larger than 1536.
> 
> A typical trace looks like:
> [  377.548696] i40e 0000:5d:00.0 eno5: Error changing mtu to 9000, Max is 1500. MFS is too small.
> 

Hi Erwan, all,

As a fix, I think this patch warrants a fixes tag.
Perhaps this one is appropriate?

Fixes: 41c445ff0f48 ("i40e: main driver core")

> Signed-off-by: Erwan Velu <e.velu@criteo.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_main.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
> index f86578857e8a..85ecf2f3de18 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e_main.c
> +++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
> @@ -2946,7 +2946,7 @@ static int i40e_change_mtu(struct net_device *netdev, int new_mtu)
>  	struct i40e_netdev_priv *np = netdev_priv(netdev);
>  	struct i40e_vsi *vsi = np->vsi;
>  	struct i40e_pf *pf = vsi->back;
> -	int frame_size;
> +	int frame_size, mfs, max_mtu;
>  
>  	frame_size = i40e_max_vsi_frame_size(vsi, vsi->xdp_prog);
>  	if (new_mtu > frame_size - I40E_PACKET_HDR_PAD) {

I am fine with this patch, so please take what follows as a suggestion
for improvement, possibly as a follow-up. Not as a hard requirement from
my side.

The part of this function between the two hunks of this patch is:

		netdev_err(netdev, "Error changing mtu to %d, Max is %d\n",
			   new_mtu, frame_size - I40E_PACKET_HDR_PAD);

My reading is that with this patch two different limits are
checked wrt maximum MTU size:

1. A VSI level limit, which relates to RX buffer size
2. A PHY level limit that relates to the MFS

That seems fine to me. But the log message for 1 (above) does
not seem particularly informative wrt which limit has been exceeded.

> @@ -2955,6 +2955,14 @@ static int i40e_change_mtu(struct net_device *netdev, int new_mtu)
>  		return -EINVAL;
>  	}
>  
> +	mfs = pf->hw.phy.link_info.max_frame_size;
> +	max_mtu = mfs - I40E_PACKET_HDR_PAD;
> +	if (new_mtu > max_mtu) {
> +		netdev_err(netdev, "Error changing mtu to %d, Max is %d. MFS is too small.\n",
> +			   new_mtu, max_mtu);
> +		return -EINVAL;
> +	}
> +
>  	netdev_dbg(netdev, "changing MTU from %d to %d\n",
>  		   netdev->mtu, new_mtu);
>  	netdev->mtu = new_mtu;
> -- 
> 2.44.0
> 
> 

