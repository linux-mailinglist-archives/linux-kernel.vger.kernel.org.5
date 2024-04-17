Return-Path: <linux-kernel+bounces-148437-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 039F88A828B
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 13:54:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E96F21C219F2
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 11:54:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 177A313DDC1;
	Wed, 17 Apr 2024 11:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="g6NDCX/4"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 076EC13C912;
	Wed, 17 Apr 2024 11:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713354799; cv=none; b=axEaxfW4oEnks9oMktz3sU9DvCH/YG/DjIg17pTcw+oGB9+2LaU/e7Hk6QYD66aLY8iV1sx4sfuA3wKPvACS0AOKeYHyxC4kqDyDiEBOw1fQFGAZjyevZ8YrB5DxfDReynclky8hF/ZLXaTshrHMRXzpcDx95rqKU4IvcMRc8mc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713354799; c=relaxed/simple;
	bh=y3eWCdXu0nQFXPbrcYJlZ6MXBl6jVKpTEEEPdDB+qsc=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=LyC3P8t6wmmHM62xA+MgHGpyfsi5aoq4RLnEGwSGn4IoJtiGcUEmcX53tw+S2/Jle8FGYEl5NPSa7kQJ+Cq4Iui1k8jZZbyttOsDW02dqYzUOrAsgzq96nm+SJHKVWq8J9RZ0MbE2Cr2i/96a5XqRerkMQ16ZiVo5Fm9lH2Ji1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=g6NDCX/4; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 43HBr2Tr086818;
	Wed, 17 Apr 2024 06:53:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1713354782;
	bh=2S60DskOdraIAfQVBJqu5vbasXLr40mOMW/8wtfVtec=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=g6NDCX/42WfI23kmoR4lbzadMze4DEDyMoCEfyxPQokLrhRB92BXRD15e1pcBSMzu
	 eceX68gJvcFM40AsNxDRjMohrjHay06FmmTft05pq7FWLlRjtrfNwLxRycOaORAceZ
	 h+0qiZOF3UahrbhvMpLPiNaiqwfaoDEpXYrf/XDU=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 43HBr1QP071647
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 17 Apr 2024 06:53:02 -0500
Received: from DFLE114.ent.ti.com (10.64.6.35) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 17
 Apr 2024 06:53:01 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 17 Apr 2024 06:53:01 -0500
Received: from [172.24.227.220] (chintan-thinkstation-p360-tower.dhcp.ti.com [172.24.227.220])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 43HBqvwi040125;
	Wed, 17 Apr 2024 06:52:57 -0500
Message-ID: <62c91155-eae8-436a-91f7-ad5dd11e9cce@ti.com>
Date: Wed, 17 Apr 2024 17:22:56 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v6 2/2] net: ethernet: ti: am65-cpsw/ethtool:
 Enable RX HW timestamp only for PTP packets
Content-Language: en-US
To: Julien Panis <jpanis@baylibre.com>, Arnd Bergmann <arnd@arndb.de>,
        "Dan
 Carpenter" <dan.carpenter@linaro.org>,
        Heiner Kallweit
	<hkallweit1@gmail.com>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Vladimir Oltean <vladimir.oltean@nxp.com>,
        Andrew Lunn <andrew@lunn.ch>, Roger Quadros <rogerq@kernel.org>,
        Richard Cochran
	<richardcochran@gmail.com>,
        Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski
	<kuba@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        "David S. Miller"
	<davem@davemloft.net>
CC: <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>
References: <20240417113904.3804936-1-c-vankar@ti.com>
 <20240417113904.3804936-3-c-vankar@ti.com>
From: Chintan Vankar <c-vankar@ti.com>
In-Reply-To: <20240417113904.3804936-3-c-vankar@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180



On 17/04/24 17:09, Chintan Vankar wrote:

Due to some issue in my email client other two patches of the series
are missing from this version. I am posting v7 as v6.

> In the current mechanism of timestamping, am65-cpsw-nuss driver
> enables hardware timestamping for all received packets by setting
> the TSTAMP_EN bit in CPTS_CONTROL register, which directs the CPTS
> module to timestamp all received packets, followed by passing
> timestamp via DMA descriptors. This mechanism causes CPSW Port to
> Lock up.
> 
> To prevent port lock up, don't enable rx packet timestamping by
> setting TSTAMP_EN bit in CPTS_CONTROL register. The workaround for
> timestamping received packets is to utilize the CPTS Event FIFO
> that records timestamps corresponding to certain events. The CPTS
> module is configured to generate timestamps for Multicast Ethernet,
> UDP/IPv4 and UDP/IPv6 PTP packets.
> 
> Update supported hwtstamp_rx_filters values for CPSW's timestamping
> capability.
> 
> Fixes: b1f66a5bee07 ("net: ethernet: ti: am65-cpsw-nuss: enable packet timestamping support")
> 
> Signed-off-by: Chintan Vankar <c-vankar@ti.com>
> ---
> 
> Link to v5:
> https://lore.kernel.org/r/20240402114405.219100-3-c-vankar@ti.com/
> 
> Changes from v5 to v6:
> - No changes in v6.
> 
>   drivers/net/ethernet/ti/am65-cpsw-ethtool.c | 13 +++++-
>   drivers/net/ethernet/ti/am65-cpsw-nuss.c    | 51 ++++++++++-----------
>   drivers/net/ethernet/ti/am65-cpts.c         | 23 ----------
>   drivers/net/ethernet/ti/am65-cpts.h         |  5 --
>   4 files changed, 35 insertions(+), 57 deletions(-)
> 
> diff --git a/drivers/net/ethernet/ti/am65-cpsw-ethtool.c b/drivers/net/ethernet/ti/am65-cpsw-ethtool.c
> index d6ce2c9f0a8d..a1d0935d1ebe 100644
> --- a/drivers/net/ethernet/ti/am65-cpsw-ethtool.c
> +++ b/drivers/net/ethernet/ti/am65-cpsw-ethtool.c
> @@ -695,6 +695,17 @@ static int am65_cpsw_get_ethtool_ts_info(struct net_device *ndev,
>   					 struct ethtool_ts_info *info)
>   {
>   	struct am65_cpsw_common *common = am65_ndev_to_common(ndev);
> +	unsigned int ptp_v2_filter;
> +
> +	ptp_v2_filter = BIT(HWTSTAMP_FILTER_PTP_V2_L4_EVENT)	 |
> +			BIT(HWTSTAMP_FILTER_PTP_V2_L4_SYNC)	 |
> +			BIT(HWTSTAMP_FILTER_PTP_V2_L4_DELAY_REQ) |
> +			BIT(HWTSTAMP_FILTER_PTP_V2_L2_EVENT)	 |
> +			BIT(HWTSTAMP_FILTER_PTP_V2_L2_SYNC)	 |
> +			BIT(HWTSTAMP_FILTER_PTP_V2_L2_DELAY_REQ) |
> +			BIT(HWTSTAMP_FILTER_PTP_V2_EVENT)	 |
> +			BIT(HWTSTAMP_FILTER_PTP_V2_SYNC)	 |
> +			BIT(HWTSTAMP_FILTER_PTP_V2_DELAY_REQ);
>   
>   	if (!IS_ENABLED(CONFIG_TI_K3_AM65_CPTS))
>   		return ethtool_op_get_ts_info(ndev, info);
> @@ -708,7 +719,7 @@ static int am65_cpsw_get_ethtool_ts_info(struct net_device *ndev,
>   		SOF_TIMESTAMPING_RAW_HARDWARE;
>   	info->phc_index = am65_cpts_phc_index(common->cpts);
>   	info->tx_types = BIT(HWTSTAMP_TX_OFF) | BIT(HWTSTAMP_TX_ON);
> -	info->rx_filters = BIT(HWTSTAMP_FILTER_NONE) | BIT(HWTSTAMP_FILTER_ALL);
> +	info->rx_filters = BIT(HWTSTAMP_FILTER_NONE) | ptp_v2_filter;
>   	return 0;
>   }
>   
> diff --git a/drivers/net/ethernet/ti/am65-cpsw-nuss.c b/drivers/net/ethernet/ti/am65-cpsw-nuss.c
> index bfba883d4fc4..305eda711e0c 100644
> --- a/drivers/net/ethernet/ti/am65-cpsw-nuss.c
> +++ b/drivers/net/ethernet/ti/am65-cpsw-nuss.c
> @@ -103,6 +103,12 @@
>   #define AM65_CPSW_PN_TS_CTL_TX_HOST_TS_EN	BIT(11)
>   #define AM65_CPSW_PN_TS_CTL_MSG_TYPE_EN_SHIFT	16
>   
> +#define AM65_CPSW_PN_TS_CTL_RX_ANX_F_EN		BIT(0)
> +#define AM65_CPSW_PN_TS_CTL_RX_VLAN_LT1_EN	BIT(1)
> +#define AM65_CPSW_PN_TS_CTL_RX_VLAN_LT2_EN	BIT(2)
> +#define AM65_CPSW_PN_TS_CTL_RX_ANX_D_EN		BIT(3)
> +#define AM65_CPSW_PN_TS_CTL_RX_ANX_E_EN		BIT(9)
> +
>   /* AM65_CPSW_PORTN_REG_TS_SEQ_LTYPE_REG register fields */
>   #define AM65_CPSW_PN_TS_SEQ_ID_OFFSET_SHIFT	16
>   
> @@ -126,6 +132,11 @@
>   	 AM65_CPSW_PN_TS_CTL_TX_ANX_E_EN |	\
>   	 AM65_CPSW_PN_TS_CTL_TX_ANX_F_EN)
>   
> +#define AM65_CPSW_TS_RX_ANX_ALL_EN		\
> +	(AM65_CPSW_PN_TS_CTL_RX_ANX_D_EN |	\
> +	 AM65_CPSW_PN_TS_CTL_RX_ANX_E_EN |	\
> +	 AM65_CPSW_PN_TS_CTL_RX_ANX_F_EN)
> +
>   #define AM65_CPSW_ALE_AGEOUT_DEFAULT	30
>   /* Number of TX/RX descriptors */
>   #define AM65_CPSW_MAX_TX_DESC	500
> @@ -1044,18 +1055,6 @@ static int am65_cpsw_run_xdp(struct am65_cpsw_common *common,
>   	return ret;
>   }
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
>   /* RX psdata[2] word format - checksum information */
>   #define AM65_CPSW_RX_PSD_CSUM_ADD	GENMASK(15, 0)
>   #define AM65_CPSW_RX_PSD_CSUM_ERR	BIT(16)
> @@ -1171,13 +1170,11 @@ static int am65_cpsw_nuss_rx_packets(struct am65_cpsw_common *common,
>   		skb_reserve(skb, headroom);
>   	}
>   
> -	/* Pass skb to netstack if no XDP prog or returned XDP_PASS */
> -	if (port->rx_ts_enabled)
> -		am65_cpsw_nuss_rx_ts(skb, psdata);
> -
>   	ndev_priv = netdev_priv(ndev);
>   	am65_cpsw_nuss_set_offload_fwd_mark(skb, ndev_priv->offload_fwd_mark);
>   	skb_put(skb, pkt_len);
> +	if (port->rx_ts_enabled)
> +		am65_cpts_rx_timestamp(common->cpts, skb);
>   	skb_mark_for_recycle(skb);
>   	skb->protocol = eth_type_trans(skb, ndev);
>   	am65_cpsw_nuss_rx_csum(skb, csum_info);
> @@ -1730,7 +1727,6 @@ static int am65_cpsw_nuss_ndo_slave_set_mac_address(struct net_device *ndev,
>   static int am65_cpsw_nuss_hwtstamp_set(struct net_device *ndev,
>   				       struct ifreq *ifr)
>   {
> -	struct am65_cpsw_common *common = am65_ndev_to_common(ndev);
>   	struct am65_cpsw_port *port = am65_ndev_to_port(ndev);
>   	u32 ts_ctrl, seq_id, ts_ctrl_ltype2, ts_vlan_ltype;
>   	struct hwtstamp_config cfg;
> @@ -1754,11 +1750,6 @@ static int am65_cpsw_nuss_hwtstamp_set(struct net_device *ndev,
>   	case HWTSTAMP_FILTER_NONE:
>   		port->rx_ts_enabled = false;
>   		break;
> -	case HWTSTAMP_FILTER_ALL:
> -	case HWTSTAMP_FILTER_SOME:
> -	case HWTSTAMP_FILTER_PTP_V1_L4_EVENT:
> -	case HWTSTAMP_FILTER_PTP_V1_L4_SYNC:
> -	case HWTSTAMP_FILTER_PTP_V1_L4_DELAY_REQ:
>   	case HWTSTAMP_FILTER_PTP_V2_L4_EVENT:
>   	case HWTSTAMP_FILTER_PTP_V2_L4_SYNC:
>   	case HWTSTAMP_FILTER_PTP_V2_L4_DELAY_REQ:
> @@ -1768,10 +1759,13 @@ static int am65_cpsw_nuss_hwtstamp_set(struct net_device *ndev,
>   	case HWTSTAMP_FILTER_PTP_V2_EVENT:
>   	case HWTSTAMP_FILTER_PTP_V2_SYNC:
>   	case HWTSTAMP_FILTER_PTP_V2_DELAY_REQ:
> -	case HWTSTAMP_FILTER_NTP_ALL:
>   		port->rx_ts_enabled = true;
> -		cfg.rx_filter = HWTSTAMP_FILTER_ALL;
> +		cfg.rx_filter = HWTSTAMP_FILTER_PTP_V2_EVENT;
>   		break;
> +	case HWTSTAMP_FILTER_ALL:
> +	case HWTSTAMP_FILTER_SOME:
> +	case HWTSTAMP_FILTER_NTP_ALL:
> +		return -EOPNOTSUPP;
>   	default:
>   		return -ERANGE;
>   	}
> @@ -1801,6 +1795,10 @@ static int am65_cpsw_nuss_hwtstamp_set(struct net_device *ndev,
>   		ts_ctrl |= AM65_CPSW_TS_TX_ANX_ALL_EN |
>   			   AM65_CPSW_PN_TS_CTL_TX_VLAN_LT1_EN;
>   
> +	if (port->rx_ts_enabled)
> +		ts_ctrl |= AM65_CPSW_TS_RX_ANX_ALL_EN |
> +			   AM65_CPSW_PN_TS_CTL_RX_VLAN_LT1_EN;
> +
>   	writel(seq_id, port->port_base + AM65_CPSW_PORTN_REG_TS_SEQ_LTYPE_REG);
>   	writel(ts_vlan_ltype, port->port_base +
>   	       AM65_CPSW_PORTN_REG_TS_VLAN_LTYPE_REG);
> @@ -1808,9 +1806,6 @@ static int am65_cpsw_nuss_hwtstamp_set(struct net_device *ndev,
>   	       AM65_CPSW_PORTN_REG_TS_CTL_LTYPE2);
>   	writel(ts_ctrl, port->port_base + AM65_CPSW_PORTN_REG_TS_CTL);
>   
> -	/* en/dis RX timestamp */
> -	am65_cpts_rx_enable(common->cpts, port->rx_ts_enabled);
> -
>   	return copy_to_user(ifr->ifr_data, &cfg, sizeof(cfg)) ? -EFAULT : 0;
>   }
>   
> @@ -1827,7 +1822,7 @@ static int am65_cpsw_nuss_hwtstamp_get(struct net_device *ndev,
>   	cfg.tx_type = port->tx_ts_enabled ?
>   		      HWTSTAMP_TX_ON : HWTSTAMP_TX_OFF;
>   	cfg.rx_filter = port->rx_ts_enabled ?
> -			HWTSTAMP_FILTER_ALL : HWTSTAMP_FILTER_NONE;
> +			HWTSTAMP_FILTER_PTP_V2_EVENT : HWTSTAMP_FILTER_NONE;
>   
>   	return copy_to_user(ifr->ifr_data, &cfg, sizeof(cfg)) ? -EFAULT : 0;
>   }
> diff --git a/drivers/net/ethernet/ti/am65-cpts.c b/drivers/net/ethernet/ti/am65-cpts.c
> index 599454c1d19f..68891a227dc8 100644
> --- a/drivers/net/ethernet/ti/am65-cpts.c
> +++ b/drivers/net/ethernet/ti/am65-cpts.c
> @@ -866,29 +866,6 @@ static long am65_cpts_ts_work(struct ptp_clock_info *ptp)
>   	return delay;
>   }
>   
> -/**
> - * am65_cpts_rx_enable - enable rx timestamping
> - * @cpts: cpts handle
> - * @en: enable
> - *
> - * This functions enables rx packets timestamping. The CPTS can timestamp all
> - * rx packets.
> - */
> -void am65_cpts_rx_enable(struct am65_cpts *cpts, bool en)
> -{
> -	u32 val;
> -
> -	mutex_lock(&cpts->ptp_clk_lock);
> -	val = am65_cpts_read32(cpts, control);
> -	if (en)
> -		val |= AM65_CPTS_CONTROL_TSTAMP_EN;
> -	else
> -		val &= ~AM65_CPTS_CONTROL_TSTAMP_EN;
> -	am65_cpts_write32(cpts, val, control);
> -	mutex_unlock(&cpts->ptp_clk_lock);
> -}
> -EXPORT_SYMBOL_GPL(am65_cpts_rx_enable);
> -
>   static int am65_skb_get_mtype_seqid(struct sk_buff *skb, u32 *mtype_seqid)
>   {
>   	unsigned int ptp_class = ptp_classify_raw(skb);
> diff --git a/drivers/net/ethernet/ti/am65-cpts.h b/drivers/net/ethernet/ti/am65-cpts.h
> index 90296968a75c..6099d772799d 100644
> --- a/drivers/net/ethernet/ti/am65-cpts.h
> +++ b/drivers/net/ethernet/ti/am65-cpts.h
> @@ -25,7 +25,6 @@ int am65_cpts_phc_index(struct am65_cpts *cpts);
>   void am65_cpts_rx_timestamp(struct am65_cpts *cpts, struct sk_buff *skb);
>   void am65_cpts_tx_timestamp(struct am65_cpts *cpts, struct sk_buff *skb);
>   void am65_cpts_prep_tx_timestamp(struct am65_cpts *cpts, struct sk_buff *skb);
> -void am65_cpts_rx_enable(struct am65_cpts *cpts, bool en);
>   u64 am65_cpts_ns_gettime(struct am65_cpts *cpts);
>   int am65_cpts_estf_enable(struct am65_cpts *cpts, int idx,
>   			  struct am65_cpts_estf_cfg *cfg);
> @@ -64,10 +63,6 @@ static inline void am65_cpts_prep_tx_timestamp(struct am65_cpts *cpts,
>   {
>   }
>   
> -static inline void am65_cpts_rx_enable(struct am65_cpts *cpts, bool en)
> -{
> -}
> -
>   static inline s64 am65_cpts_ns_gettime(struct am65_cpts *cpts)
>   {
>   	return 0;

