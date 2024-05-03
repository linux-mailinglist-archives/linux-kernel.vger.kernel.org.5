Return-Path: <linux-kernel+bounces-167415-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DAD28BA941
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 10:53:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BD4BEB214D1
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 08:53:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88CBA14C5B3;
	Fri,  3 May 2024 08:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bPaIg6UZ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9D4614A0AC;
	Fri,  3 May 2024 08:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714726382; cv=none; b=VsPlNLlK3GSrY/FLcsoqXvCVnU+ia7MOQVIGR1JWkjlbpYvoUWtxOc/6dfShKdUPAghcu3jsCj983owhFx6Jyi6g025btlKF80ng97FSeoEztU57Eef/9o7D+gbVY6QWCp6yGADSxy1Y8sMhLXNSMOfqCKu3mmu7zLfJyY6xWoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714726382; c=relaxed/simple;
	bh=UidPnR0rZN2K/R4rjDZjFLcQrMT3kKQ/ZzUwZ/or2iI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XPv8tKKZJrHyxOXnW0P5eMgCy1gAOhp5Ajsb5qN8ErI7u3GOEcJfAfo3XvbNs2XYfFx8aaiE0/nmHsX5EPQWdylQJAf0bcKv6qjWL+mcH7gljjdznLRX2id8qYowMYYBgvmH7C5x/bD2pS9uEtfS7DACVX4Nw8XXFMQMsU+KWww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bPaIg6UZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3A9DC4AF14;
	Fri,  3 May 2024 08:52:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714726382;
	bh=UidPnR0rZN2K/R4rjDZjFLcQrMT3kKQ/ZzUwZ/or2iI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bPaIg6UZhFQ1HZ3WfD4Xd8CSyroUAqyrJGFyf/7lZxCPdBqetBjPKu9Qrd7f8zJug
	 dW9qnAMYhRLDAeHYRsCinw8l8B6sF0ObxuPnfOMdRSOxjBpDw5/VZD8Grom8uMUyk/
	 ZQT89izhefWhqa38DQcutRBxptbBdC/nkqcyqHE+ScrkMKCRdIXPEPRMLtoXbhPtfb
	 WoJLw/jC08qjO52jzKRHYfbtn7P4TwH4vworE9RD/oX5o0W4wvjcM9qqX3UlRJ+4WW
	 PmqoU4epC6pZxObjUd5QyGckAMU/abVC5t1NUkAl4I2Uwva96LYjSzLE/kJfxdR0vg
	 LSwTJ6cu3ZVpg==
Date: Fri, 3 May 2024 09:52:57 +0100
From: Simon Horman <horms@kernel.org>
To: Justin Lai <justinlai0215@realtek.com>
Cc: kuba@kernel.org, davem@davemloft.net, edumazet@google.com,
	pabeni@redhat.com, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, andrew@lunn.ch, jiri@resnulli.us,
	pkshih@realtek.com, larry.chiu@realtek.com
Subject: Re: [PATCH net-next v17 02/13] rtase: Implement the .ndo_open
 function
Message-ID: <20240503085257.GM2821784@kernel.org>
References: <20240502091847.65181-1-justinlai0215@realtek.com>
 <20240502091847.65181-3-justinlai0215@realtek.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240502091847.65181-3-justinlai0215@realtek.com>

On Thu, May 02, 2024 at 05:18:36PM +0800, Justin Lai wrote:
> Implement the .ndo_open function to set default hardware settings
> and initialize the descriptor ring and interrupts. Among them,
> when requesting irq, because the first group of interrupts needs to
> process more events, the overall structure will be different from
> other groups of interrupts, so it needs to be processed separately.
> 
> Signed-off-by: Justin Lai <justinlai0215@realtek.com>

Hi Justin,

some minor feedback from my side.

> ---
>  .../net/ethernet/realtek/rtase/rtase_main.c   | 419 ++++++++++++++++++
>  1 file changed, 419 insertions(+)
> 
> diff --git a/drivers/net/ethernet/realtek/rtase/rtase_main.c b/drivers/net/ethernet/realtek/rtase/rtase_main.c
> index 5ddb5f7abfe9..b286aac1eedc 100644
> --- a/drivers/net/ethernet/realtek/rtase/rtase_main.c
> +++ b/drivers/net/ethernet/realtek/rtase/rtase_main.c
> @@ -130,6 +130,293 @@ static u32 rtase_r32(const struct rtase_private *tp, u16 reg)
>  	return readl(tp->mmio_addr + reg);
>  }
>  
> +static void rtase_set_rxbufsize(struct rtase_private *tp)
> +{
> +	tp->rx_buf_sz = RTASE_RX_BUF_SIZE;
> +}

I'm a big fan of helpers, but maybe it's better to just open-code this one
as it is trivial and seems to only be used once.

..

> +static int rtase_open(struct net_device *dev)
> +{
> +	struct rtase_private *tp = netdev_priv(dev);
> +	struct rtase_int_vector *ivec = &tp->int_vector[0];
> +	const struct pci_dev *pdev = tp->pdev;
> +	u16 i, j;
> +	int ret;

nit: please use reverse xmas tree order - longest line to shortest -
     for local variable declarations in new Networking code.

> +
> +	rtase_set_rxbufsize(tp);
> +
> +	ret = rtase_alloc_desc(tp);
> +	if (ret)
> +		goto err_free_all_allocated_mem;
> +
> +	ret = rtase_init_ring(dev);
> +	if (ret)
> +		goto err_free_all_allocated_mem;
> +
> +	rtase_hw_config(dev);
> +
> +	if (tp->sw_flag & RTASE_SWF_MSIX_ENABLED) {
> +		ret = request_irq(ivec->irq, rtase_interrupt, 0,
> +				  dev->name, ivec);
> +		if (ret)
> +			goto err_free_all_allocated_irq;

This goto jumps to code that relies on i to set the bounds on a loop.
However, i is not initialised here. Perhaps it should be set to 1?

Flagged by Smatch, and clang-18 W=1 builds.

> +
> +		/* request other interrupts to handle multiqueue */
> +		for (i = 1; i < tp->int_nums; i++) {
> +			ivec = &tp->int_vector[i];
> +			snprintf(ivec->name, sizeof(ivec->name), "%s_int%i", tp->dev->name, i);

nit: This line could trivially be split into two lines,
     each less than 80 columns wide.

> +			ret = request_irq(ivec->irq, rtase_q_interrupt, 0,
> +					  ivec->name, ivec);
> +			if (ret)
> +				goto err_free_all_allocated_irq;
> +		}
> +	} else {
> +		ret = request_irq(pdev->irq, rtase_interrupt, 0, dev->name,
> +				  ivec);
> +		if (ret)
> +			goto err_free_all_allocated_mem;
> +	}
> +
> +	rtase_hw_start(dev);
> +
> +	for (i = 0; i < tp->int_nums; i++) {
> +		ivec = &tp->int_vector[i];
> +		napi_enable(&ivec->napi);
> +	}
> +
> +	netif_carrier_on(dev);
> +	netif_wake_queue(dev);
> +
> +	return 0;
> +
> +err_free_all_allocated_irq:
> +	for (j = 0; j < i; j++)
> +		free_irq(tp->int_vector[j].irq, &tp->int_vector[j]);
> +
> +err_free_all_allocated_mem:
> +	rtase_free_desc(tp);
> +
> +	return ret;
> +}

..

