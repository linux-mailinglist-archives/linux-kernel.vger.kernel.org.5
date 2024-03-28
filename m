Return-Path: <linux-kernel+bounces-122632-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 31B6B88FAA7
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 10:05:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B050F1F236EE
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 09:05:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41A2C5F569;
	Thu, 28 Mar 2024 09:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="F5BMyzi1"
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ED653F9DE
	for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 09:05:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711616717; cv=none; b=Gn42lx6jrxOR1/N3Sbpp/1CzqSL6E8IlzpRRG344dlYTSvwuRHD4jex2A9XgEcGVtk7ZhZEau/NC7Rc3Y9Doi9zjUe89h+UeMD5iclRaMzWGb32qftZUvVB9xZJUtsm6A1Cq+zTRD2rUzHKEwamj1XsJoXt0UsNJ8XgAyPH9LI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711616717; c=relaxed/simple;
	bh=6T4yGPmJu34uRBcPwl1hNwi43YyWt+lVR9yf7CUHql8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=N04n4EnRlqPhLQcZa18up3svlPepwauLZsxK2+/jOHZq6L9HIC1OOTsrsZlsbIKa7yKO5Tf2+FN/waoAWefb5kQIefIQB2i/5GB+4UGHPR6rq0YFhvStbLXmila7y+gei+BjtXNKYH+aHOPfQHHLliPo/zvt+L0Ct2SX4MeR4/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=F5BMyzi1; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-3417a3151c4so594687f8f.3
        for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 02:05:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1711616712; x=1712221512; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=k0Zoda5/PWfmG3tdB4xaR5Gwiq6FjJ6RsD+9yrf3YQQ=;
        b=F5BMyzi1UcpSLT7DamY65H9I5JNcxNDbvsmX8kdeYptfvqBMKy6CjZFJU/Zn4ugOpA
         MQOt1zDTGV7A5iWykiiBBvKYRUTInkNgy4ySWWqMJvt6SJbCM3IO90ZdU8hJ/ksuWRRr
         uekIa9PSi13FgzyOVKAjOaij3S3XS2anfziLYxZp79aRL/FIZuzbAmp5tTytIOb8po90
         VHa+4FIceiIseQY69Cn/xNlOFqAmPNs/SxTQKRK2Ehq+pzCs1yO8WT3Gnoe4dnIuDEdb
         OSBj2MITz206xiWFboU9me2iO/H4SshqphjE+WwNIODdjf+NSPvyq6OzTknQGdwIpfbT
         G2/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711616712; x=1712221512;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=k0Zoda5/PWfmG3tdB4xaR5Gwiq6FjJ6RsD+9yrf3YQQ=;
        b=dcJV4gBbdWEx8KYk16fx/Mpc2ay4L9u+uOq4Y3fmhbnYEDksAYsZzpcWicM5zPbt5Z
         M6i6ndFGRvdoxshgTChtGH+LvxDJEf8wdcamjHaGnK5QnTuEKyDgeUldTN9BV6hjpyVH
         v0n4XXfIp54xoVAPw0LemEm/TfvdQely5USDcpxe0b20HlcYtjcvsJ+yIcZanvbIzvV1
         1Fl4Fo1qkoIslZrh8LkeDbHKF8UFlf1v08faYLdUEIP9H3pSbTL4md25EemVVxk5QyXd
         Y/x/E5/hD3KE4nJeivxqQPVMu3+WlEIZqz5Ojc8SAv97fDsJ0lnf+tV3Acrqo5MX7FQJ
         +X0A==
X-Forwarded-Encrypted: i=1; AJvYcCUb1DOjZ+sVvjpYPx4rgUwkBoRQG1oeX2GbaIiczGGBsx6Y9LVAbjYnbRzU+nMy5Uw80LYDDn7b/pVEouJMtn/gEGS3aXpwE6F0ajeA
X-Gm-Message-State: AOJu0YwKH8+7Kn5fgP5Pyd2hUWQL9lfQMB5TBVn1W8zBzud1FIHjijPQ
	TI2SUfvKKuCV0QA490PGZvsQ/rF7TlVkNxRrZztbMwkOygBC1LskX/NzvzYiv3M=
X-Google-Smtp-Source: AGHT+IFRe02F2th8jZvDnTorPoPnIBUOrzJTyhGpxLIaUswHjwgI+8oWrXDOivVwqpcds/sqXavbfw==
X-Received: by 2002:a5d:4ccc:0:b0:341:76bc:2bfe with SMTP id c12-20020a5d4ccc000000b0034176bc2bfemr2472006wrt.4.1711616712379;
        Thu, 28 Mar 2024 02:05:12 -0700 (PDT)
Received: from [192.168.50.4] ([82.78.167.144])
        by smtp.gmail.com with ESMTPSA id bn9-20020a056000060900b00341bdecdae3sm1192362wrb.117.2024.03.28.02.05.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Mar 2024 02:05:11 -0700 (PDT)
Message-ID: <f8e9fca1-69e9-42c9-a14e-078d763a6788@tuxon.dev>
Date: Thu, 28 Mar 2024 11:05:08 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 2/4] net: macb: Add ARP support to WOL
Content-Language: en-US
To: Vineeth Karumanchi <vineeth.karumanchi@amd.com>,
 nicolas.ferre@microchip.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 linux@armlinux.org.uk, vadim.fedorenko@linux.dev, andrew@lunn.ch
Cc: netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, git@amd.com
References: <20240222153848.2374782-1-vineeth.karumanchi@amd.com>
 <20240222153848.2374782-3-vineeth.karumanchi@amd.com>
From: claudiu beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <20240222153848.2374782-3-vineeth.karumanchi@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 22.02.2024 17:38, Vineeth Karumanchi wrote:
> -Add wake-on LAN support using ARP with the provision to select
>  through ethtool. Advertise wakeup capability in the probe and
>  get the supported modes from OS policy (MACB_CAPS_WOL).
> 
> -Re-order MACB_WOL_<> macros for ease of extension.
> -Add ARP support configurable through ethtool, "wolopts" variable in
>  struct macb contains the current WOL options configured through ethtool.
> 
> -For WOL via ARP, ensure the IP address is assigned and
>  report an error otherwise.

Having '-' for each thing that you did makes the 1st time reader of this
commit message think that you did multiple things in this patch, which
should be avoided.

Also, please compose the commit message such that it responds to the
questions "what the patch does?" and "why it's necessary?"

> 
> Co-developed-by: Harini Katakam <harini.katakam@amd.com>
> Signed-off-by: Harini Katakam <harini.katakam@amd.com>
> Signed-off-by: Vineeth Karumanchi <vineeth.karumanchi@amd.com>
> ---
>  drivers/net/ethernet/cadence/macb.h      |  2 +
>  drivers/net/ethernet/cadence/macb_main.c | 52 +++++++++++++++++-------
>  2 files changed, 40 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/net/ethernet/cadence/macb.h b/drivers/net/ethernet/cadence/macb.h
> index 50cd35ef21ad..c9ca61959f3c 100644
> --- a/drivers/net/ethernet/cadence/macb.h
> +++ b/drivers/net/ethernet/cadence/macb.h
> @@ -738,6 +738,7 @@
>  #define MACB_CAPS_MIIONRGMII			0x00000200
>  #define MACB_CAPS_NEED_TSUCLK			0x00000400
>  #define MACB_CAPS_QUEUE_DISABLE			0x00000800
> +#define MACB_CAPS_WOL				0x00001000
>  #define MACB_CAPS_PCS				0x01000000
>  #define MACB_CAPS_HIGH_SPEED			0x02000000
>  #define MACB_CAPS_CLK_HW_CHG			0x04000000
> @@ -1306,6 +1307,7 @@ struct macb {
>  	unsigned int		jumbo_max_len;
>  
>  	u32			wol;
> +	u32			wolopts;
>  
>  	/* holds value of rx watermark value for pbuf_rxcutthru register */
>  	u32			rx_watermark;
> diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
> index f34933ef03b0..62d796ef4035 100644
> --- a/drivers/net/ethernet/cadence/macb_main.c
> +++ b/drivers/net/ethernet/cadence/macb_main.c
> @@ -38,6 +38,7 @@
>  #include <linux/ptp_classify.h>
>  #include <linux/reset.h>
>  #include <linux/firmware/xlnx-zynqmp.h>
> +#include <linux/inetdevice.h>
>  #include "macb.h"
>  
>  /* This structure is only used for MACB on SiFive FU540 devices */
> @@ -84,8 +85,9 @@ struct sifive_fu540_macb_mgmt {
>  #define GEM_MTU_MIN_SIZE	ETH_MIN_MTU
>  #define MACB_NETIF_LSO		NETIF_F_TSO
>  
> -#define MACB_WOL_HAS_MAGIC_PACKET	(0x1 << 0)
> -#define MACB_WOL_ENABLED		(0x1 << 1)

> +#define MACB_WOL_ENABLED		(0x1 << 0)> +#define MACB_WOL_HAS_MAGIC_PACKET	(0x1 << 1)

Is there a reason you changed the values of these 2 macros?

> +#define MACB_WOL_HAS_ARP_PACKET		(0x1 << 2)
>  
>  #define HS_SPEED_10000M			4
>  #define MACB_SERDES_RATE_10G		1
> @@ -3278,18 +3280,18 @@ static void macb_get_wol(struct net_device *netdev, struct ethtool_wolinfo *wol)
>  {
>  	struct macb *bp = netdev_priv(netdev);
>  
> -	if (bp->wol & MACB_WOL_HAS_MAGIC_PACKET) {
> +	if (bp->wol & (MACB_WOL_HAS_MAGIC_PACKET | MACB_WOL_HAS_ARP_PACKET))
>  		phylink_ethtool_get_wol(bp->phylink, wol);
> -		wol->supported |= WAKE_MAGIC;
> -
> -		if (bp->wol & MACB_WOL_ENABLED)
> -			wol->wolopts |= WAKE_MAGIC;
> -	}
> +	wol->supported |= (bp->wol & MACB_WOL_HAS_MAGIC_PACKET) ? WAKE_MAGIC : 0;
> +	wol->supported |= (bp->wol & MACB_WOL_HAS_ARP_PACKET) ? WAKE_ARP : 0;
> +	/* Pass wolopts to ethtool */
> +	wol->wolopts = bp->wolopts;
>  }
>  
>  static int macb_set_wol(struct net_device *netdev, struct ethtool_wolinfo *wol)
>  {
>  	struct macb *bp = netdev_priv(netdev);
> +	bp->wolopts = 0;
>  	int ret;
>  
>  	/* Pass the order to phylink layer */
> @@ -3300,11 +3302,14 @@ static int macb_set_wol(struct net_device *netdev, struct ethtool_wolinfo *wol)
>  	if (!ret || ret != -EOPNOTSUPP)
>  		return ret;
>  
> -	if (!(bp->wol & MACB_WOL_HAS_MAGIC_PACKET) ||
> -	    (wol->wolopts & ~WAKE_MAGIC))
> +	if (!(bp->wol & (MACB_WOL_HAS_MAGIC_PACKET | MACB_WOL_HAS_ARP_PACKET)) ||
> +	    (wol->wolopts & ~(WAKE_MAGIC | WAKE_ARP)))
>  		return -EOPNOTSUPP;
>  
> -	if (wol->wolopts & WAKE_MAGIC)
> +	bp->wolopts |= (wol->wolopts & WAKE_MAGIC) ? WAKE_MAGIC : 0;
> +	bp->wolopts |= (wol->wolopts & WAKE_ARP) ? WAKE_ARP : 0;
> +
> +	if (bp->wolopts)
>  		bp->wol |= MACB_WOL_ENABLED;
>  	else
>  		bp->wol &= ~MACB_WOL_ENABLED;
> @@ -5087,7 +5092,6 @@ static int macb_probe(struct platform_device *pdev)
>  	bp->wol = 0;
>  	if (of_property_read_bool(np, "magic-packet"))
>  		bp->wol |= MACB_WOL_HAS_MAGIC_PACKET;
> -	device_set_wakeup_capable(&pdev->dev, bp->wol & MACB_WOL_HAS_MAGIC_PACKET);
>  
>  	bp->usrio = macb_config->usrio;
>  
> @@ -5115,6 +5119,11 @@ static int macb_probe(struct platform_device *pdev)
>  	/* setup capabilities */
>  	macb_configure_caps(bp, macb_config);
>  
> +	if (bp->caps & MACB_CAPS_WOL)
> +		bp->wol |= (MACB_WOL_HAS_ARP_PACKET | MACB_WOL_HAS_MAGIC_PACKET);
> +
> +	device_set_wakeup_capable(&pdev->dev, (bp->wol) ? true : false);

It can be simplified with:

device_set_wakeup_capable(&pdev->dev, !!bp->wol);

> +
>  #ifdef CONFIG_ARCH_DMA_ADDR_T_64BIT
>  	if (GEM_BFEXT(DAW64, gem_readl(bp, DCFG6))) {
>  		dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(44));
> @@ -5244,6 +5253,7 @@ static int __maybe_unused macb_suspend(struct device *dev)
>  	struct net_device *netdev = dev_get_drvdata(dev);
>  	struct macb *bp = netdev_priv(netdev);
>  	struct macb_queue *queue;
> +	struct in_ifaddr *ifa;
>  	unsigned long flags;
>  	unsigned int q;
>  	int err;
> @@ -5256,6 +5266,12 @@ static int __maybe_unused macb_suspend(struct device *dev)
>  		return 0;
>  
>  	if (bp->wol & MACB_WOL_ENABLED) {
> +		/* Check for IP address in WOL ARP mode */
> +		ifa = rcu_dereference(__in_dev_get_rcu(bp->dev)->ifa_list);
> +		if ((bp->wolopts & WAKE_ARP) && !ifa) {
> +			netdev_err(netdev, "IP address not assigned\n");
> +			return -EOPNOTSUPP;
> +		}
>  		spin_lock_irqsave(&bp->lock, flags);
>  
>  		/* Disable Tx and Rx engines before  disabling the queues,
> @@ -5289,6 +5305,14 @@ static int __maybe_unused macb_suspend(struct device *dev)
>  		macb_writel(bp, TSR, -1);
>  		macb_writel(bp, RSR, -1);
>  
> +		tmp = (bp->wolopts & WAKE_MAGIC) ? MACB_BIT(MAG) : 0;
> +		if (bp->wolopts & WAKE_ARP) {
> +			tmp |= MACB_BIT(ARP);
> +			/* write IP address into register */
> +			tmp |= MACB_BFEXT(IP,
> +					 (__force u32)(cpu_to_be32p((uint32_t *)&ifa->ifa_local)));
> +		}
> +
>  		/* Change interrupt handler and
>  		 * Enable WoL IRQ on queue 0
>  		 */
> @@ -5304,7 +5328,7 @@ static int __maybe_unused macb_suspend(struct device *dev)
>  				return err;
>  			}
>  			queue_writel(bp->queues, IER, GEM_BIT(WOL));
> -			gem_writel(bp, WOL, MACB_BIT(MAG));
> +			gem_writel(bp, WOL, tmp);
>  		} else {
>  			err = devm_request_irq(dev, bp->queues[0].irq, macb_wol_interrupt,
>  					       IRQF_SHARED, netdev->name, bp->queues);
> @@ -5316,7 +5340,7 @@ static int __maybe_unused macb_suspend(struct device *dev)
>  				return err;
>  			}
>  			queue_writel(bp->queues, IER, MACB_BIT(WOL));
> -			macb_writel(bp, WOL, MACB_BIT(MAG));
> +			macb_writel(bp, WOL, tmp);
>  		}
>  		spin_unlock_irqrestore(&bp->lock, flags);
>  

