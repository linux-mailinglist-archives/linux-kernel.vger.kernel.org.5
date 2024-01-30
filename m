Return-Path: <linux-kernel+bounces-45332-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BE07842EA3
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 22:28:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 12351288B39
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 21:28:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 555F378B67;
	Tue, 30 Jan 2024 21:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="N7+Q0xI5"
Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com [95.215.58.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7791F762F5
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 21:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706650085; cv=none; b=cEnZEj4lIk8qHbRkRdn5LjJkwxQWXxvvbNNcRf0Ivs8STeB5lPPvpd5CsdGg2gn5AeO91txy+ksqwQLJehzHdJxgGShc7UlWNszP/t30DGIsspeCP3476kx0BTAlL0y4IT43nxZS6S73VPwlhaNDObRiwEgsd28ceYITyF3rAQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706650085; c=relaxed/simple;
	bh=84ankGqkKaoBwYW2QX+O8tLWxl10MB0V/XYdf4n6n3g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bZCRwfcbwoFQPvUGXMvHBMbloh3b+X3aMznAigSE8mRCF9eEgaLouMcAYF5utm7UXk15+Wp2Zv463WZq5m6mWPyrsT/n7ujMEaCk7Jl5w0HbedPQ8xkI9qk+i1t5+6mgWbqa1TLAlRMp7+0Nnzp8twAoUuajWiGf6/7cYx3YeUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=N7+Q0xI5; arc=none smtp.client-ip=95.215.58.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <4fe16f45-0768-4f94-8522-0f79158086bf@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1706650081;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GLriNvWcOcuVP077T4oJGiw2KnYVlSBPJfmaRmuz4QE=;
	b=N7+Q0xI5Jv9H3QVDIG+4cj+7TvXEiDpdWBKWZlhAoTVRPb3L8J+d6Nw6OLhWGAvwVaer46
	CQWYQJS4/2ZB5NCxp8Y32ltEdGj/nQprj07mc5ou3iIZjzrq8L2ytrLgKjj1M9glnJlRIO
	Umo+a2MD4aigpgqgkN3aTKo2nK5MzbY=
Date: Tue, 30 Jan 2024 21:27:54 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next 3/3] net: macb: Add ARP support to WOL
Content-Language: en-US
To: Vineeth Karumanchi <vineeth.karumanchi@amd.com>,
 nicolas.ferre@microchip.com, claudiu.beznea@tuxon.dev, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, linux@armlinux.org.uk
Cc: netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, git@amd.com
References: <20240130104845.3995341-1-vineeth.karumanchi@amd.com>
 <20240130104845.3995341-4-vineeth.karumanchi@amd.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20240130104845.3995341-4-vineeth.karumanchi@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 30/01/2024 10:48, Vineeth Karumanchi wrote:
> Add wake-on LAN support using ARP with the provision to select
> through ethtool. Advertise wakeup capability in the probe and
> get the supported modes from the device tree.
> 
> Re-order MACB_WOL_<> macros for ease of extension.
> Add ARP support configurable through ethtool, "wolopts" variable in
> struct macb contains the current WOL options configured through ethtool.
> 
> For WOL via ARP, ensure the IP address is assigned and
> report an error otherwise.
> 
> Co-developed-by: Harini Katakam <harini.katakam@amd.com>
> Signed-off-by: Harini Katakam <harini.katakam@amd.com>
> Signed-off-by: Vineeth Karumanchi <vineeth.karumanchi@amd.com>
> ---
>   drivers/net/ethernet/cadence/macb.h      |  1 +
>   drivers/net/ethernet/cadence/macb_main.c | 54 ++++++++++++++++++------
>   2 files changed, 43 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/net/ethernet/cadence/macb.h b/drivers/net/ethernet/cadence/macb.h
> index f68ff163aa18..db7e95dc56e3 100644
> --- a/drivers/net/ethernet/cadence/macb.h
> +++ b/drivers/net/ethernet/cadence/macb.h
> @@ -1306,6 +1306,7 @@ struct macb {
>   	unsigned int		jumbo_max_len;
>   
>   	u32			wol;
> +	u32			wolopts;
>   
>   	/* holds value of rx watermark value for pbuf_rxcutthru register */
>   	u32			rx_watermark;
> diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
> index 47cbea58e6c3..cbe1a9de692a 100644
> --- a/drivers/net/ethernet/cadence/macb_main.c
> +++ b/drivers/net/ethernet/cadence/macb_main.c
> @@ -38,6 +38,7 @@
>   #include <linux/ptp_classify.h>
>   #include <linux/reset.h>
>   #include <linux/firmware/xlnx-zynqmp.h>
> +#include <linux/inetdevice.h>
>   #include "macb.h"
>   
>   /* This structure is only used for MACB on SiFive FU540 devices */
> @@ -84,8 +85,9 @@ struct sifive_fu540_macb_mgmt {
>   #define GEM_MTU_MIN_SIZE	ETH_MIN_MTU
>   #define MACB_NETIF_LSO		NETIF_F_TSO
>   
> -#define MACB_WOL_HAS_MAGIC_PACKET	(0x1 << 0)
> -#define MACB_WOL_ENABLED		(0x1 << 1)
> +#define MACB_WOL_ENABLED		(0x1 << 0)
> +#define MACB_WOL_HAS_MAGIC_PACKET	(0x1 << 1)
> +#define MACB_WOL_HAS_ARP_PACKET	(0x1 << 2)
>   
>   #define HS_SPEED_10000M			4
>   #define MACB_SERDES_RATE_10G		1
> @@ -3276,19 +3278,21 @@ static void macb_get_wol(struct net_device *netdev, struct ethtool_wolinfo *wol)
>   {
>   	struct macb *bp = netdev_priv(netdev);
>   
> -	if (bp->wol & MACB_WOL_HAS_MAGIC_PACKET) {
> +	if (bp->wol & (MACB_WOL_HAS_MAGIC_PACKET | MACB_WOL_HAS_ARP_PACKET))
>   		phylink_ethtool_get_wol(bp->phylink, wol);
> +	if (bp->wol & MACB_WOL_HAS_MAGIC_PACKET)
>   		wol->supported |= WAKE_MAGIC;
> -
> -		if (bp->wol & MACB_WOL_ENABLED)
> -			wol->wolopts |= WAKE_MAGIC;
> -	}
> +	if (bp->wol & MACB_WOL_HAS_ARP_PACKET)
> +		wol->supported |= WAKE_ARP;
> +	/* Pass wolopts to ethtool */
> +	wol->wolopts = bp->wolopts;
>   }
>   
>   static int macb_set_wol(struct net_device *netdev, struct ethtool_wolinfo *wol)
>   {
>   	struct macb *bp = netdev_priv(netdev);
>   	int ret;
> +	bp->wolopts = 0;

as there will be another spin, could you please use reverse xmas-tree order.

>   	/* Pass the order to phylink layer */
>   	ret = phylink_ethtool_set_wol(bp->phylink, wol);
> @@ -3298,11 +3302,16 @@ static int macb_set_wol(struct net_device *netdev, struct ethtool_wolinfo *wol)
>   	if (!ret || ret != -EOPNOTSUPP)
>   		return ret;
>   
> -	if (!(bp->wol & MACB_WOL_HAS_MAGIC_PACKET) ||
> -	    (wol->wolopts & ~WAKE_MAGIC))
> +	if (!(bp->wol & (MACB_WOL_HAS_MAGIC_PACKET | MACB_WOL_HAS_ARP_PACKET)) ||
> +	    (wol->wolopts & ~(WAKE_MAGIC | WAKE_ARP)))
>   		return -EOPNOTSUPP;
>   
>   	if (wol->wolopts & WAKE_MAGIC)
> +		bp->wolopts |= WAKE_MAGIC;
> +	if (wol->wolopts & WAKE_ARP)
> +		bp->wolopts |= WAKE_ARP;
> +
> +	if (bp->wolopts)
>   		bp->wol |= MACB_WOL_ENABLED;
>   	else
>   		bp->wol &= ~MACB_WOL_ENABLED;
> @@ -5086,7 +5095,10 @@ static int macb_probe(struct platform_device *pdev)
>   	bp->wol = 0;
>   	if (of_property_read_bool(np, "magic-packet"))
>   		bp->wol |= MACB_WOL_HAS_MAGIC_PACKET;
> -	device_set_wakeup_capable(&pdev->dev, bp->wol & MACB_WOL_HAS_MAGIC_PACKET);
> +	if (of_property_read_bool(np, "wol-arp-packet"))
> +		bp->wol |= MACB_WOL_HAS_ARP_PACKET;
> +
> +	device_set_wakeup_capable(&pdev->dev, (bp->wol) ? true : false);
>   
>   	bp->usrio = macb_config->usrio;
>   
> @@ -5243,6 +5255,7 @@ static int __maybe_unused macb_suspend(struct device *dev)
>   	struct net_device *netdev = dev_get_drvdata(dev);
>   	struct macb *bp = netdev_priv(netdev);
>   	struct macb_queue *queue;
> +	struct in_ifaddr *ifa;
>   	unsigned long flags;
>   	unsigned int q;
>   	u32 ctrlmask;
> @@ -5255,6 +5268,12 @@ static int __maybe_unused macb_suspend(struct device *dev)
>   		return 0;
>   
>   	if (bp->wol & MACB_WOL_ENABLED) {
> +		/* Check for IP address in WOL ARP mode */
> +		ifa = rtnl_dereference(bp->dev->ip_ptr->ifa_list);
> +		if ((bp->wolopts & WAKE_ARP) && !ifa) {
> +			netdev_err(netdev, "IP address not assigned\n");
> +			return -EOPNOTSUPP;
> +		}
>   		spin_lock_irqsave(&bp->lock, flags);
>   
>   		/* Disable Tx and Rx engines before  disabling the queues,
> @@ -5291,6 +5310,17 @@ static int __maybe_unused macb_suspend(struct device *dev)
>   			if (bp->caps & MACB_CAPS_ISR_CLEAR_ON_WRITE)
>   				queue_writel(queue, ISR, -1);
>   		}
> +
> +		ctrlmask = 0;
> +		if (bp->wolopts & WAKE_MAGIC)
> +			ctrlmask = MACB_BIT(MAG);
> +		if (bp->wolopts & WAKE_ARP) {
> +			ctrlmask |= MACB_BIT(ARP);
> +			/* write IP address into register */
> +			ctrlmask |= cpu_to_be32p(&ifa->ifa_local)
> +						& GENMASK(MACB_IP_SIZE - 1, 0);
> +		}
> +
>   		/* Change interrupt handler and
>   		 * Enable WoL IRQ on queue 0
>   		 */
> @@ -5306,7 +5336,7 @@ static int __maybe_unused macb_suspend(struct device *dev)
>   				return err;
>   			}
>   			queue_writel(bp->queues, IER, GEM_BIT(WOL));
> -			gem_writel(bp, WOL, MACB_BIT(MAG));
> +			gem_writel(bp, WOL, ctrlmask);
>   		} else {
>   			err = devm_request_irq(dev, bp->queues[0].irq, macb_wol_interrupt,
>   					       IRQF_SHARED, netdev->name, bp->queues);
> @@ -5318,7 +5348,7 @@ static int __maybe_unused macb_suspend(struct device *dev)
>   				return err;
>   			}
>   			queue_writel(bp->queues, IER, MACB_BIT(WOL));
> -			macb_writel(bp, WOL, MACB_BIT(MAG));
> +			macb_writel(bp, WOL, ctrlmask);
>   		}
>   		spin_unlock_irqrestore(&bp->lock, flags);
>   


