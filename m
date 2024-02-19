Return-Path: <linux-kernel+bounces-71165-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C9CE85A186
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 12:00:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D6BC4B210FD
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 11:00:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02D7528E2B;
	Mon, 19 Feb 2024 11:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iGvZODlo"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10C5D28DD0;
	Mon, 19 Feb 2024 11:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708340401; cv=none; b=klW/SZ3HgNoSQi52wwoLBPcjJhJXRudgKmyo48uUQ8IJlmfc9mzBT/rCqeky3fJH7RgEitARuWjkB0kQL2j59X4pd2z+KBxVHH24IW7YZbepIhd0PSS3hXvTcMzkjg0+0IxUTFsEP/9tHHim3D1qcYHgzk6oTWUBm6/p73YV1Io=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708340401; c=relaxed/simple;
	bh=jsvXuDgrhzmLQQkWo9m03bLHnbDYCahFfm5VtgDaB1M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HMtuLRv27Ymc8i3n1O4sG1gM0iaQBlGS9eXIvBBDWWMI+PdqMR9wBBoY3sJ1MVINFnDORF/hCejwFT/3cMX6as+drXnXrsKoao7ORN2JwYiULRtyKM1tIfDrGzHLUHr14bHcFA4YcErxL9KjVbtve5blFiNDHEdRZrf/l34gqYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iGvZODlo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62CA5C433F1;
	Mon, 19 Feb 2024 10:59:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708340400;
	bh=jsvXuDgrhzmLQQkWo9m03bLHnbDYCahFfm5VtgDaB1M=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=iGvZODlofN//Vu9i1EJoaN39LBb9I2juxMzFCR/aCs4DJgK464pRnJi/gnPXJ0QiC
	 PSHFxn8O0XSWEd59KwAFw1pOroIHbtfFrycrQCjgPM4nDfUDGxECFKNrTg1b/JVI1D
	 F6CMzB7UmzVOsX24frU9mCl+y1nWl6RmVa774XSurxYMxP7VwO1ye7af2zqzH8DgkH
	 U7LnXqRlSvGB0zUlIcegX94c/vYlhHrK4Fodk3BGo2i5uewrCp7diBrEm+1q6diaT0
	 RjogMTfRdxqTdw+/gp+ZvJKTPXyJUhzq8+vxui9Li/901myBV/GJjcFQEWJxAiwVYO
	 ECVveB726pzmQ==
Message-ID: <4c82705d-b05c-4ee8-88ed-42f944a023ac@kernel.org>
Date: Mon, 19 Feb 2024 12:59:55 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 2/2] net: ethernet: ti: am65-cpsw: Enable RX HW
 timestamp only for PTP packets
Content-Language: en-US
To: Chintan Vankar <c-vankar@ti.com>, Dan Carpenter
 <dan.carpenter@linaro.org>, Siddharth Vadapalli <s-vadapalli@ti.com>,
 Richard Cochran <richardcochran@gmail.com>, Paolo Abeni <pabeni@redhat.com>,
 Jakub Kicinski <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>,
 "David S. Miller" <davem@davemloft.net>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 Pekka Varis <p-varis@ti.com>
References: <20240215110953.3225099-1-c-vankar@ti.com>
 <20240215110953.3225099-2-c-vankar@ti.com>
From: Roger Quadros <rogerq@kernel.org>
In-Reply-To: <20240215110953.3225099-2-c-vankar@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 15/02/2024 13:09, Chintan Vankar wrote:
> The CPSW peripherals on J7AHP, J7VCL, J7AEP, J7ES, AM64 SoCs have
> an errata i2401 "CPSW: Host Timestamps Cause CPSW Port to Lock up".

Does this affect all platforms using am65-cpsw?
If this affects only some platforms then you need to restrict the
workaround to those platforms only.

> 
> As a workaround, Disable timestamping on all RX packets and timestamp
> only PTP packets.

This does not exactly reflect what you are doing here.

I think you need to clarify that you are disabling in-band RX timestamp
mechanism on all packets and using out of band mechanism to get the
RX timestamps only for certain type of packets.

> 
> Set Time Sync Receive bits in Time Sync control register so that
> packets can be determined as a valid Ethernet Receive Event for time
> synchronization.
> 
> Update the RX filter configuration to indicate Hardware Timestamping
> support only for PTP packets.
> 
> Replace "am65_cpsw_rx_ts()" function with "am65_cpts_rx_timestamp()"
> function which timestamps only PTP packets.
> 
> Fixes: b1f66a5bee07 ("net: ethernet: ti: am65-cpsw-nuss: enable packet timestamping support")
> Signed-off-by: Chintan Vankar <c-vankar@ti.com>
> ---
>  drivers/net/ethernet/ti/am65-cpsw-nuss.c | 51 +++++++++++-------------
>  1 file changed, 24 insertions(+), 27 deletions(-)
> 
> diff --git a/drivers/net/ethernet/ti/am65-cpsw-nuss.c b/drivers/net/ethernet/ti/am65-cpsw-nuss.c
> index 9d2f4ac783e4..ab843fb64b93 100644
> --- a/drivers/net/ethernet/ti/am65-cpsw-nuss.c
> +++ b/drivers/net/ethernet/ti/am65-cpsw-nuss.c
> @@ -101,6 +101,12 @@
>  #define AM65_CPSW_PN_TS_CTL_TX_HOST_TS_EN	BIT(11)
>  #define AM65_CPSW_PN_TS_CTL_MSG_TYPE_EN_SHIFT	16
>  
> +#define AM65_CPSW_PN_TS_CTL_RX_ANX_F_EN		BIT(0)
> +#define AM65_CPSW_PN_TS_CTL_RX_VLAN_LT1_EN	BIT(1)
> +#define AM65_CPSW_PN_TS_CTL_RX_VLAN_LT2_EN	BIT(2)
> +#define AM65_CPSW_PN_TS_CTL_RX_ANX_D_EN		BIT(3)
> +#define AM65_CPSW_PN_TS_CTL_RX_ANX_E_EN		BIT(9)
> +
>  /* AM65_CPSW_PORTN_REG_TS_SEQ_LTYPE_REG register fields */
>  #define AM65_CPSW_PN_TS_SEQ_ID_OFFSET_SHIFT	16
>  
> @@ -124,6 +130,11 @@
>  	 AM65_CPSW_PN_TS_CTL_TX_ANX_E_EN |	\
>  	 AM65_CPSW_PN_TS_CTL_TX_ANX_F_EN)
>  
> +#define AM65_CPSW_TS_RX_ANX_ALL_EN		\
> +	(AM65_CPSW_PN_TS_CTL_RX_ANX_D_EN |	\
> +	 AM65_CPSW_PN_TS_CTL_RX_ANX_E_EN |	\
> +	 AM65_CPSW_PN_TS_CTL_RX_ANX_F_EN)
> +
>  #define AM65_CPSW_ALE_AGEOUT_DEFAULT	30
>  /* Number of TX/RX descriptors */
>  #define AM65_CPSW_MAX_TX_DESC	500
> @@ -749,18 +760,6 @@ static int am65_cpsw_nuss_ndo_slave_open(struct net_device *ndev)
>  	return ret;
>  }
>  
> -static void am65_cpsw_nuss_rx_ts(struct sk_buff *skb, u32 *psdata)
> -{
> -	struct skb_shared_hwtstamps *ssh;
> -	u64 ns;
> -
> -	ns = ((u64)psdata[1] << 32) | psdata[0];
> -
> -	ssh = skb_hwtstamps(skb);
> -	memset(ssh, 0, sizeof(*ssh));
> -	ssh->hwtstamp = ns_to_ktime(ns);
> -}
> -
>  /* RX psdata[2] word format - checksum information */
>  #define AM65_CPSW_RX_PSD_CSUM_ADD	GENMASK(15, 0)
>  #define AM65_CPSW_RX_PSD_CSUM_ERR	BIT(16)
> @@ -841,9 +840,6 @@ static int am65_cpsw_nuss_rx_packets(struct am65_cpsw_common *common,
>  	skb->dev = ndev;
>  
>  	psdata = cppi5_hdesc_get_psdata(desc_rx);
> -	/* add RX timestamp */
> -	if (port->rx_ts_enabled)
> -		am65_cpsw_nuss_rx_ts(skb, psdata);
>  	csum_info = psdata[2];
>  	dev_dbg(dev, "%s rx csum_info:%#x\n", __func__, csum_info);
>  
> @@ -856,6 +852,9 @@ static int am65_cpsw_nuss_rx_packets(struct am65_cpsw_common *common,
>  		ndev_priv = netdev_priv(ndev);
>  		am65_cpsw_nuss_set_offload_fwd_mark(skb, ndev_priv->offload_fwd_mark);
>  		skb_put(skb, pkt_len);
> +		skb_reset_mac_header(skb);

Why do you need to add skb_reset_mac_header here?

> +		if (port->rx_ts_enabled)
> +			am65_cpts_rx_timestamp(common->cpts, skb);

The timestamp should be added before you do skb_put().

>  		skb->protocol = eth_type_trans(skb, ndev);
>  		am65_cpsw_nuss_rx_csum(skb, csum_info);
>  		napi_gro_receive(&common->napi_rx, skb);
> @@ -1334,7 +1333,6 @@ static int am65_cpsw_nuss_ndo_slave_set_mac_address(struct net_device *ndev,
>  static int am65_cpsw_nuss_hwtstamp_set(struct net_device *ndev,
>  				       struct ifreq *ifr)
>  {
> -	struct am65_cpsw_common *common = am65_ndev_to_common(ndev);
>  	struct am65_cpsw_port *port = am65_ndev_to_port(ndev);
>  	u32 ts_ctrl, seq_id, ts_ctrl_ltype2, ts_vlan_ltype;
>  	struct hwtstamp_config cfg;
> @@ -1358,11 +1356,6 @@ static int am65_cpsw_nuss_hwtstamp_set(struct net_device *ndev,
>  	case HWTSTAMP_FILTER_NONE:
>  		port->rx_ts_enabled = false;
>  		break;
> -	case HWTSTAMP_FILTER_ALL:
> -	case HWTSTAMP_FILTER_SOME:
> -	case HWTSTAMP_FILTER_PTP_V1_L4_EVENT:
> -	case HWTSTAMP_FILTER_PTP_V1_L4_SYNC:
> -	case HWTSTAMP_FILTER_PTP_V1_L4_DELAY_REQ:

Can't PTP_V1 be supported?

>  	case HWTSTAMP_FILTER_PTP_V2_L4_EVENT:
>  	case HWTSTAMP_FILTER_PTP_V2_L4_SYNC:
>  	case HWTSTAMP_FILTER_PTP_V2_L4_DELAY_REQ:
> @@ -1372,10 +1365,13 @@ static int am65_cpsw_nuss_hwtstamp_set(struct net_device *ndev,
>  	case HWTSTAMP_FILTER_PTP_V2_EVENT:
>  	case HWTSTAMP_FILTER_PTP_V2_SYNC:
>  	case HWTSTAMP_FILTER_PTP_V2_DELAY_REQ:
> -	case HWTSTAMP_FILTER_NTP_ALL:
>  		port->rx_ts_enabled = true;
> -		cfg.rx_filter = HWTSTAMP_FILTER_ALL;
> +		cfg.rx_filter = HWTSTAMP_FILTER_PTP_V2_EVENT;
>  		break;
> +	case HWTSTAMP_FILTER_ALL:
> +	case HWTSTAMP_FILTER_SOME:
> +	case HWTSTAMP_FILTER_NTP_ALL:
> +		return -EOPNOTSUPP;
>  	default:
>  		return -ERANGE;
>  	}
> @@ -1405,6 +1401,10 @@ static int am65_cpsw_nuss_hwtstamp_set(struct net_device *ndev,
>  		ts_ctrl |= AM65_CPSW_TS_TX_ANX_ALL_EN |
>  			   AM65_CPSW_PN_TS_CTL_TX_VLAN_LT1_EN;
>  
> +	if (port->rx_ts_enabled)
> +		ts_ctrl |= AM65_CPSW_TS_RX_ANX_ALL_EN |
> +			   AM65_CPSW_PN_TS_CTL_RX_VLAN_LT1_EN;
> +
>  	writel(seq_id, port->port_base + AM65_CPSW_PORTN_REG_TS_SEQ_LTYPE_REG);
>  	writel(ts_vlan_ltype, port->port_base +
>  	       AM65_CPSW_PORTN_REG_TS_VLAN_LTYPE_REG);
> @@ -1412,9 +1412,6 @@ static int am65_cpsw_nuss_hwtstamp_set(struct net_device *ndev,
>  	       AM65_CPSW_PORTN_REG_TS_CTL_LTYPE2);
>  	writel(ts_ctrl, port->port_base + AM65_CPSW_PORTN_REG_TS_CTL);
>  
> -	/* en/dis RX timestamp */
> -	am65_cpts_rx_enable(common->cpts, port->rx_ts_enabled);
> -
>  	return copy_to_user(ifr->ifr_data, &cfg, sizeof(cfg)) ? -EFAULT : 0;
>  }
>  
> @@ -1431,7 +1428,7 @@ static int am65_cpsw_nuss_hwtstamp_get(struct net_device *ndev,
>  	cfg.tx_type = port->tx_ts_enabled ?
>  		      HWTSTAMP_TX_ON : HWTSTAMP_TX_OFF;
>  	cfg.rx_filter = port->rx_ts_enabled ?
> -			HWTSTAMP_FILTER_ALL : HWTSTAMP_FILTER_NONE;
> +			HWTSTAMP_FILTER_PTP_V2_EVENT : HWTSTAMP_FILTER_NONE;
>  
>  	return copy_to_user(ifr->ifr_data, &cfg, sizeof(cfg)) ? -EFAULT : 0;
>  }

-- 
cheers,
-roger

