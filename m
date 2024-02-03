Return-Path: <linux-kernel+bounces-51153-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C1DF6848727
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 16:38:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3FC9B1F23B07
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 15:38:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A4355F57D;
	Sat,  3 Feb 2024 15:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="oKox4yi2"
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB2B95F571
	for <linux-kernel@vger.kernel.org>; Sat,  3 Feb 2024 15:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706974693; cv=none; b=q5X8+4Y3hCKx0uX1FLjRyMoYshbL0fbJumFtg2AfT328PizuYtz1DR3So5L6IXN06mRHLNnTpW/HvZMDf4Gg+qSvxwrX0I7FpUdyppOYKZQe72JPVWFoTJWQizoM2uVR2QTDNaZAuTLKwNel3qwhW4hteJjf55yPAa5qeIyL1wo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706974693; c=relaxed/simple;
	bh=WE5JPaidD90vkrcbaJ/CmqpRuf7diE03gScNIwMVnJE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Pm8VjfzeyY5MSRNCJoKpM6ZdRFdkzDwWIqswdcItwBN4kBs0YisgiiVgNlWdTicuZATT4VxCB9x3xz5PifDXkPLeNH5nANltXtotzDmoSzwqzkGvzGkUUwIRQZ0DPWlIwYID4PufR8hviIskDl+ib0MGIJ8xRGQfOEiW5UFtM9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=oKox4yi2; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a3122b70439so415003166b.3
        for <linux-kernel@vger.kernel.org>; Sat, 03 Feb 2024 07:38:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1706974689; x=1707579489; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RmXjMBjV3eTaj62ESkW/1VAxnakFokM6wo7z2vsUgqY=;
        b=oKox4yi2sRpw0zGrYW1SQOFt3ya4Jnn/bljpwSC2IzQMOnoCjEodu4/kwNwtzH7C3k
         0/3bkY6ay43m9TzluQCzn622O8g4boRWIeyyb9aMplCRmi0K6x/CJTovgvnSyUVxSx5i
         WFcCXS2vxiUJPKIqsgi399i5o0zvw5LU1Y4VkFVayfqrQ6RBvZNsqUk2wdhgfi0XrBK3
         qtt1CFCYruMi8z94/lzvjJylAlBZ9d1J6ehT7og5nFAnT0lKos2Y7FSbu9LOSectNeET
         FtIOR/n6Plvc+YIjId96pHHmgUP5UKwcOJjgzw6ksYq5A4Vxc2g96iWhT7Y0jW3mk/xU
         fF/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706974689; x=1707579489;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RmXjMBjV3eTaj62ESkW/1VAxnakFokM6wo7z2vsUgqY=;
        b=Pd4E97h12o33E9p5jxW6BR9S0QHoYybrlB3z6umlTG4DhnIj58Q7Kym3IaIA34/5Oj
         HgrnZXYsQb5GEXKYq2Hu3sh999VPa+KBk22wr4+8yOfLFCSt/fa/+lzEvVVmFpk65Wma
         y6KI717Hi4jjog0MZzwtCQ5eGU5CpkSjnyNWacRIJc17G9VgETLylCfHBtXlg9xXz46u
         89ka82hbCiez3x3dzvA0No9RW/ZlcJ8w3YfcZpaX/BjGUYelLJGN7TIDmEgkoVz/vntD
         qfkSuw5XPiaa2uYTpP6FzV8W3j70ebGdr9arWPN3U+PQvHqDd5NT/Gy5KG8iyuqKWLrv
         L7zA==
X-Gm-Message-State: AOJu0YyuKmsYlEkWex6ZYOOC3gTREQe4Kk63jFk1UIFwDFPp+aoc3Wq5
	buxAE4164ZjPkmo1cYnsp5shz65upN85woP0Xm0hqnHgT5MRqQ+qPynhRiZpxK4=
X-Google-Smtp-Source: AGHT+IFNsO28izVMP8pIS0uG/LTzycePakrpu0Nmlo+q5mN4gBIZ/jC5Ghz64jzcjiQtB+fYbWyG8g==
X-Received: by 2002:a17:907:7711:b0:a36:f672:6e8d with SMTP id kw17-20020a170907771100b00a36f6726e8dmr3066161ejc.5.1706974688909;
        Sat, 03 Feb 2024 07:38:08 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCUfVQxw844Uzd7Z5KW53j+B/daUt7M/Mad0Ah/Jvk/f1EmL3BagGqdp2FdXMImT0pHVTVNSbuRKoT+JWOBhjOdGy4lYKvD5gL5M/dLKMiFF/a9OGulB8FAep1YEtp87poQbI4ncOYXBYtZDgoRRl/sdJACL8C9TtJdPoq/tewpeVZg8lk4koEvNaUOJw93u2WOTHHw5dTkhTmrhmgRUzfK1lj9MIpFJ68oWgzKU11r5Lom1doavGiYR6pNW619iC1FekY97TI4jxFSlcPa8aezkRR3wdwEy8VB23an6Xt2BBgeOInWOD6Xi3/lTSNOrRuyZl/7R64YtM9mBK1GgrEXu8F2aG3ET7P+brD9HqEYBEBYYzNxzx62fbwYDkm4jIKZBajHIXdaiPY0ev1jl1y1L3UvVd5sakf8xTpZ4bk7Tnfl7ffZToe2D0i+PTR4TprjTKY/zJV29EQM0vLBQ
Received: from [192.168.50.4] ([82.78.167.154])
        by smtp.gmail.com with ESMTPSA id ty24-20020a170907c71800b00a372a739731sm1322794ejc.45.2024.02.03.07.38.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 03 Feb 2024 07:38:08 -0800 (PST)
Message-ID: <d8c48839-8b22-47ad-b270-e96a1ad1adee@tuxon.dev>
Date: Sat, 3 Feb 2024 17:38:06 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 1/3] net: macb: queue tie-off or disable during
 WOL suspend
To: Vineeth Karumanchi <vineeth.karumanchi@amd.com>,
 nicolas.ferre@microchip.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, linux@armlinux.org.uk
Cc: netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, git@amd.com
References: <20240130104845.3995341-1-vineeth.karumanchi@amd.com>
 <20240130104845.3995341-2-vineeth.karumanchi@amd.com>
From: claudiu beznea <claudiu.beznea@tuxon.dev>
Content-Language: en-US
In-Reply-To: <20240130104845.3995341-2-vineeth.karumanchi@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi, Vineeth,

On 30.01.2024 12:48, Vineeth Karumanchi wrote:
> When GEM is used as a wake device, it is not mandatory for the RX DMA
> to be active. The RX engine in IP only needs to receive and identify
> a wake packet through an interrupt. The wake packet is of no further
> significance; hence, it is not required to be copied into memory.
> By disabling RX DMA during suspend, we can avoid unnecessary DMA
> processing of any incoming traffic.
> 
> During suspend, perform either of the below operations:
> 
> tie-off/dummy descriptor: Disable unused queues by connecting
> them to a looped descriptor chain without free slots.
> 
> queue disable: The newer IP version allows disabling individual queues.

I would add a dash line for each of these 2 items for better understanding.
E.g.:

- tie-off/dummy descriptior: ...
- queue disable: ...

> 
> Co-developed-by: Harini Katakam <harini.katakam@amd.com>
> Signed-off-by: Harini Katakam <harini.katakam@amd.com>
> Signed-off-by: Vineeth Karumanchi <vineeth.karumanchi@amd.com>
> ---
>  drivers/net/ethernet/cadence/macb.h      |  7 +++
>  drivers/net/ethernet/cadence/macb_main.c | 58 +++++++++++++++++++++++-
>  2 files changed, 64 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/cadence/macb.h b/drivers/net/ethernet/cadence/macb.h
> index aa5700ac9c00..f68ff163aa18 100644
> --- a/drivers/net/ethernet/cadence/macb.h
> +++ b/drivers/net/ethernet/cadence/macb.h
> @@ -645,6 +645,9 @@
>  #define GEM_T2OFST_OFFSET			0 /* offset value */
>  #define GEM_T2OFST_SIZE				7
>  
> +/* Bitfields in queue pointer registers */
> +#define GEM_RBQP_DISABLE    BIT(0)

You have spaces after macro name. However the approach in this driver is to
define bit offset and lenght and use {MACB,GEM}_BIT() macros (see the above
bitfield definitions).

> +
>  /* Offset for screener type 2 compare values (T2CMPOFST).
>   * Note the offset is applied after the specified point,
>   * e.g. GEM_T2COMPOFST_ETYPE denotes the EtherType field, so an offset
> @@ -737,6 +740,7 @@
>  #define MACB_CAPS_HIGH_SPEED			0x02000000
>  #define MACB_CAPS_CLK_HW_CHG			0x04000000
>  #define MACB_CAPS_MACB_IS_EMAC			0x08000000
> +#define MACB_CAPS_QUEUE_DISABLE			0x00002000

Can you keep this sorted by value with the rest of the caps?

>  #define MACB_CAPS_FIFO_MODE			0x10000000
>  #define MACB_CAPS_GIGABIT_MODE_AVAILABLE	0x20000000
>  #define MACB_CAPS_SG_DISABLED			0x40000000
> @@ -1254,6 +1258,7 @@ struct macb {
>  	u32	(*macb_reg_readl)(struct macb *bp, int offset);
>  	void	(*macb_reg_writel)(struct macb *bp, int offset, u32 value);
>  
> +	struct macb_dma_desc	*rx_ring_tieoff;

Keep this ^

>  	size_t			rx_buffer_size;
>  
>  	unsigned int		rx_ring_size;
> @@ -1276,6 +1281,8 @@ struct macb {
>  		struct gem_stats	gem;
>  	}			hw_stats;
>  
> +	dma_addr_t		rx_ring_tieoff_dma;

And this ^ toghether.

> +
>  	struct macb_or_gem_ops	macbgem_ops;
>  
>  	struct mii_bus		*mii_bus;
> diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
> index 898debfd4db3..47cbea58e6c3 100644
> --- a/drivers/net/ethernet/cadence/macb_main.c
> +++ b/drivers/net/ethernet/cadence/macb_main.c
> @@ -2479,6 +2479,12 @@ static void macb_free_consistent(struct macb *bp)
>  
>  	bp->macbgem_ops.mog_free_rx_buffers(bp);
>  
> +	if (bp->rx_ring_tieoff) {
> +		dma_free_coherent(&bp->pdev->dev, macb_dma_desc_get_size(bp),
> +				  bp->rx_ring_tieoff, bp->rx_ring_tieoff_dma);
> +		bp->rx_ring_tieoff = NULL;
> +	}
> +

Keep the reverse order of operation as oposed to macb_alloc_consistent,
thus move this before bp->macbgem_ops.mog_free_rx_buffers();

>  	for (q = 0, queue = bp->queues; q < bp->num_queues; ++q, ++queue) {
>  		kfree(queue->tx_skb);
>  		queue->tx_skb = NULL;
> @@ -2568,6 +2574,16 @@ static int macb_alloc_consistent(struct macb *bp)
>  	if (bp->macbgem_ops.mog_alloc_rx_buffers(bp))
>  		goto out_err;
>  
> +	/* Required for tie off descriptor for PM cases */
> +	if (!(bp->caps & MACB_CAPS_QUEUE_DISABLE)) {
> +		bp->rx_ring_tieoff = dma_alloc_coherent(&bp->pdev->dev,
> +							macb_dma_desc_get_size(bp),
> +							&bp->rx_ring_tieoff_dma,
> +							GFP_KERNEL);
> +		if (!bp->rx_ring_tieoff)
> +			goto out_err;

You also need to free the previously allocated rx buffers.

> +	}
> +
>  	return 0;
>  
>  out_err:
> @@ -2575,6 +2591,16 @@ static int macb_alloc_consistent(struct macb *bp)
>  	return -ENOMEM;
>  }
>  
> +static void macb_init_tieoff(struct macb *bp)
> +{
> +	struct macb_dma_desc *d = bp->rx_ring_tieoff;

s/d/desc to cope with the rest of descriptor usage in this file.

Add this here:

	if (bp->caps & MACB_CAPS_QUEUE_DISABLE)
		return;

to avoid checking it in different places where this function is called.

> +	/* Setup a wrapping descriptor with no free slots
> +	 * (WRAP and USED) to tie off/disable unused RX queues.
> +	 */
> +	macb_set_addr(bp, d, MACB_BIT(RX_WRAP) | MACB_BIT(RX_USED));
> +	d->ctrl = 0;
> +}
> +
>  static void gem_init_rings(struct macb *bp)
>  {
>  	struct macb_queue *queue;
> @@ -2598,6 +2624,8 @@ static void gem_init_rings(struct macb *bp)
>  		gem_rx_refill(queue);
>  	}
>  
> +	if (!(bp->caps & MACB_CAPS_QUEUE_DISABLE))
> +		macb_init_tieoff(bp);
>  }
>  
>  static void macb_init_rings(struct macb *bp)
> @@ -2615,6 +2643,8 @@ static void macb_init_rings(struct macb *bp)
>  	bp->queues[0].tx_head = 0;
>  	bp->queues[0].tx_tail = 0;
>  	desc->ctrl |= MACB_BIT(TX_WRAP);
> +
> +	macb_init_tieoff(bp);
>  }
>  
>  static void macb_reset_hw(struct macb *bp)
> @@ -4917,7 +4947,8 @@ static const struct macb_config sama7g5_emac_config = {
>  
>  static const struct macb_config versal_config = {
>  	.caps = MACB_CAPS_GIGABIT_MODE_AVAILABLE | MACB_CAPS_JUMBO |
> -		MACB_CAPS_GEM_HAS_PTP | MACB_CAPS_BD_RD_PREFETCH | MACB_CAPS_NEED_TSUCLK,
> +		MACB_CAPS_GEM_HAS_PTP | MACB_CAPS_BD_RD_PREFETCH |
> +		MACB_CAPS_QUEUE_DISABLE | MACB_CAPS_NEED_TSUCLK,

This should go in a different patch.

>  	.dma_burst_length = 16,
>  	.clk_init = macb_clk_init,
>  	.init = init_reset_optional,
> @@ -5214,6 +5245,7 @@ static int __maybe_unused macb_suspend(struct device *dev)
>  	struct macb_queue *queue;
>  	unsigned long flags;
>  	unsigned int q;
> +	u32 ctrlmask;

val/tmp should be enough for this as you are, anyway, re-using it in the
next patch for different purpose.

>  	int err;
>  
>  	if (!device_may_wakeup(&bp->dev->dev))
> @@ -5224,6 +5256,30 @@ static int __maybe_unused macb_suspend(struct device *dev)
>  
>  	if (bp->wol & MACB_WOL_ENABLED) {
>  		spin_lock_irqsave(&bp->lock, flags);
> +
> +		/* Disable Tx and Rx engines before  disabling the queues,
> +		 * this is mandatory as per the IP spec sheet
> +		 */
> +		ctrlmask = macb_readl(bp, NCR);
> +		ctrlmask &= ~(MACB_BIT(TE) | MACB_BIT(RE));

You can remove this
> +		macb_writel(bp, NCR, ctrlmask);

And add this:
macb_writel(bp, NCR, ctrlmask & ~(MACB_BIT(TE) | MACB_BIT(RE));

> +		for (q = 0, queue = bp->queues; q < bp->num_queues;
> +		     ++q, ++queue) {
> +			/* Disable RX queues */

Operation in this for loop could be moved in the the above IRQ disable
loop. Have you tried it? are there any issues with it?

> +			if (bp->caps & MACB_CAPS_QUEUE_DISABLE) {
> +				queue_writel(queue, RBQP, GEM_RBQP_DISABLE);
> +			} else {
> +				/* Tie off RX queues */
> +				queue_writel(queue, RBQP,
> +					     lower_32_bits(bp->rx_ring_tieoff_dma));

I think this should be guarded by:
#ifdef CONFIG_ARCH_DMA_ADDR_T_64BIT
> +				queue_writel(queue, RBQPH,
> +					     upper_32_bits(bp->rx_ring_tieoff_dma));
> +			}
> +		}
> +		/* Enable Receive engine */
> +		ctrlmask = macb_readl(bp, NCR);

Is this needed?

> +		ctrlmask |= MACB_BIT(RE);
> +		macb_writel(bp, NCR, ctrlmask);

These could be merged

>  		/* Flush all status bits */
>  		macb_writel(bp, TSR, -1);
>  		macb_writel(bp, RSR, -1);

