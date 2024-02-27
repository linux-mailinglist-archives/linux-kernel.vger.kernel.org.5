Return-Path: <linux-kernel+bounces-83665-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 33796869D02
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 18:00:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD16928326C
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 17:00:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FB913839C;
	Tue, 27 Feb 2024 17:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mEZVkleo"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DE632421D;
	Tue, 27 Feb 2024 17:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709053217; cv=none; b=BgyM/NQyKzeDRInc9zSwkfL6EqS5Qzwgli+NHPgrJHldJ/yASPD7IivseeLOQAaoyBNTHwY7bGfnI1FqupxNYu7iO3iT3OG1aYw0xYmyxJgYQYV3tGFVu6eOIt9Emjv6ftc7Et6SBnj5fGDT/B2sQlRR6jkuB6zZhOpId+xldhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709053217; c=relaxed/simple;
	bh=Rtg/wJB+BwOfbLpXE7ewLdRK21mvIkgnQ8NFpKpylzg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Uuhj1ExzJvovrYUwgzsKyufpsEiaYyj41b/bCFqHxrs7zNHPLNyhX4Iga/tZzF9luL3ha3rAOtfC0GnhlvOHKjzkht2/85tX/OCoQ6vGFYreJb058FyNYYXEpoP3uhWHsN1ewPbVAVlv2cPIwvJ48I3TJiJeGUttGC4LheFAeDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mEZVkleo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99DA7C433F1;
	Tue, 27 Feb 2024 17:00:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709053217;
	bh=Rtg/wJB+BwOfbLpXE7ewLdRK21mvIkgnQ8NFpKpylzg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mEZVkleoAOhydHqEWHg/rQfg/pNdE3CSGBgWQPF8/NJIv8K3UrpYePZbTNCCm2uNf
	 A07aYmhkG2OxxOI4hy+BI4cpj0H/6nQjkSCQ9JiFfrvfzldGbQ3VKf/eHzx9cPSWhq
	 J/w/GXftvQZYCfEutbIu7/HIeJhwiKZU8f4EaWp7YdeRh0AH+SKWnPvUO30c7lvUzz
	 vZrO1FKHgPBXGn/vr2dpjcBaqVAqx+0x3ytQV1y5OyR3GXUVfBMfTFs/Rmf1xu8ULY
	 24WLz6N4GqSW3UaH+/AJCULFkhFmaLKgJK2dhTNUfaDEJt/3qnHhwWsD5C/Byhl+Gq
	 yw1U2w14cQlLg==
Date: Tue, 27 Feb 2024 17:00:12 +0000
From: Simon Horman <horms@kernel.org>
To: Piotr Wejman <piotrwejman90@gmail.com>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] net: stmmac: fix rx queue priority assignment
Message-ID: <20240227170012.GC277116@kernel.org>
References: <20240226093144.31965-1-piotrwejman90@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240226093144.31965-1-piotrwejman90@gmail.com>

On Mon, Feb 26, 2024 at 10:31:44AM +0100, Piotr Wejman wrote:
> The driver should ensure that same priority is not mapped to multiple
> rx queues. Currently rx_queue_priority() function is adding
> priorities for a queue without clearing them from others.
> 
> >From DesignWare Cores Ethernet Quality-of-Service
> Databook, section 17.1.29 MAC_RxQ_Ctrl2:
> "[...]The software must ensure that the content of this field is
> mutually exclusive to the PSRQ fields for other queues, that is,
> the same priority is not mapped to multiple Rx queues[...]"
> 
> After this patch, rx_queue_priority() function will:
> - assign desired priorities to a queue
> - remove those priorities from all other queues
> The write sequence of CTRL2 and CTRL3 registers is done in the way to
> ensure this order.
> 
> Signed-off-by: Piotr Wejman <piotrwejman90@gmail.com>
> ---
> Changes in v2:
>   - Add some comments
>   - Apply same changes to dwxgmac2_rx_queue_prio()
>   - Revert "Rename prio argument to prio_mask"
>   - Link to v1: https://lore.kernel.org/netdev/20240219102405.32015-1-piotrwejman90@gmail.com/T/#u
> 
>  .../net/ethernet/stmicro/stmmac/dwmac4_core.c | 42 +++++++++++++++----
>  .../ethernet/stmicro/stmmac/dwxgmac2_core.c   | 40 ++++++++++++++----
>  2 files changed, 66 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c b/drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c
> index 6b6d0de09619..76ec0c1da250 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c
> @@ -92,19 +92,43 @@ static void dwmac4_rx_queue_priority(struct mac_device_info *hw,
>  				     u32 prio, u32 queue)
>  {
>  	void __iomem *ioaddr = hw->pcsr;
> -	u32 base_register;
> -	u32 value;
> +	u32 clear_mask = 0;
> +	u32 ctrl2, ctrl3;
> +	int i;
>  
> -	base_register = (queue < 4) ? GMAC_RXQ_CTRL2 : GMAC_RXQ_CTRL3;
> -	if (queue >= 4)
> -		queue -= 4;
> +	ctrl2 = readl(ioaddr + GMAC_RXQ_CTRL2);
> +	ctrl3 = readl(ioaddr + GMAC_RXQ_CTRL3);
> +	
> +	/* The software must ensure that the same priority
> +	 * is not mapped to multiple Rx queues.
> +	 */
> +	for (i = 0; i < 4; i++)
> +		clear_mask |= ((prio << GMAC_RXQCTRL_PSRQX_SHIFT(i)) &
> +						GMAC_RXQCTRL_PSRQX_MASK(i));
>  
> -	value = readl(ioaddr + base_register);
> +	ctrl2 &= ~clear_mask;
> +	ctrl3 &= ~clear_mask;
>  
> -	value &= ~GMAC_RXQCTRL_PSRQX_MASK(queue);
> -	value |= (prio << GMAC_RXQCTRL_PSRQX_SHIFT(queue)) &
> +	/* Assign new priorities to a queue and
> +	 * clear them from others queues.
> +	 * The CTRL2 and CTRL3 registers write sequence is done
> +	 * in the way to ensure this order.
> +	 */
> +	if (queue < 4) {
> +		ctrl2 |= (prio << GMAC_RXQCTRL_PSRQX_SHIFT(queue)) &
>  						GMAC_RXQCTRL_PSRQX_MASK(queue);
> -	writel(value, ioaddr + base_register);
> +
> +		writel(ctrl2, ioaddr + GMAC_RXQ_CTRL2);
> +		writel(ctrl3, ioaddr + GMAC_RXQ_CTRL3);
> +	} else {
> +		queue -= 4;
> +
> +		ctrl3 |= (prio << GMAC_RXQCTRL_PSRQX_SHIFT(queue)) &
> +						GMAC_RXQCTRL_PSRQX_MASK(queue);
> +
> +		writel(ctrl3, ioaddr + GMAC_RXQ_CTRL3);
> +		writel(ctrl2, ioaddr + GMAC_RXQ_CTRL2);
> +	}
>  }

Hi Piotr,

Sorry if I am on the wrong track here, but this seems a little odd to me.

My reading is that each byte of GMAC_RXQ_CTRL2 and GMAC_RXQ_CTRL3
hold the priority value - an integer in the range of 0-255 - for
each of 8 queues.

This corresponds with the way that the queue is set both before and
after this patch.

But the code immediately above treats these bytes as bit fields.

Consider the case where all queues are initialised to 0
(I have no idea if this is valid queue values).

Now suppose we wish to set Queue 0 to Priority 7.
Then my my reading we will end up with.

clear_mask = 0x07070707
ctrl0 = (0x00000000 & ~clear_mask) | 0x00000007 = 0x00000007
ctrl3 =  0x00000000 & ~clear_mask               = 0x00000000

So far so good, but now suppose we now wish to set Queue 1 to Priority 9.
Then we get:

clear_mask = 0x09090909
ctrl0 = (0x00000007 & ~clear_mask) | 0x00000900 = 0x00000906
ctrl3 =  0x00000000 & ~clear_mask               = 0x00000000

Now queue 0 seems to have priority 6.

..


