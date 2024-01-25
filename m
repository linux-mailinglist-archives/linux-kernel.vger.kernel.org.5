Return-Path: <linux-kernel+bounces-39014-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AB29883C9A8
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 18:16:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DED941C24017
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 17:16:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D8881C6A5;
	Thu, 25 Jan 2024 17:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="N0U7gxV4"
Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 791FD130E33
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 17:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706202684; cv=none; b=FftJb13skLapi+jx1OZqs7g23ZKk2MlNC6anXZUbw2uGDJWIsUjApxcJ7RO0GczpFAiTqx6h9N54naekvhL+2dA6CcaI7Q3x4Z6AfQzgD2v2P4VX+v9RLiLPBruNxl2Lb8arj5KqIygsxe45FeF2c/UsKkPd8Ilc2sWJyWvDEhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706202684; c=relaxed/simple;
	bh=nEOsNt6FFR1h3VkdNsbanGLxwjGlJ3VKJhYvlacD+Z0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jAQcNiGyesLpU4EHa/hJcvXo+p6vTVyFO4yNQAypoalEEVb3o/nQPke6gqZXYnMjpLjfcg8R7vknimliGiGBIighXRZsHLEEjbOgldIkcAF3LSzA5T/cpINOCBpHDqX+82kERUhh4rsaq7+rbEduw/LRaAews622vMn0XzttOCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=N0U7gxV4; arc=none smtp.client-ip=91.218.175.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <081af630-ab5d-4502-a29a-a8577d414809@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1706202677;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cwiSZZSX/ApevLiEYXtfnRTxSGnWM9HwOp5AgT3owUs=;
	b=N0U7gxV4MpRvXxZcKiNEOu7DcT42hPeaN/Y2U6qOFPHSWeUEx4AgFNLBjp7qqagQPL5Oin
	vS/FcFfWwyVinSJlI1TWDI/1iwAtorxSkT5HS1mkvoDa4w5K36G+wEdbCJp+CO7+M+5p6Y
	yxIDgy4Ne25i2rLOl8VrcxMTq+AfUn4=
Date: Thu, 25 Jan 2024 17:11:08 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 2/2] net: stmmac: dwmac-imx: set TSO/TBS TX queues default
 settings
Content-Language: en-US
To: Esben Haabendal <esben@geanix.com>, netdev@vger.kernel.org,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Jose Abreu <joabreu@synopsys.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Maxime Coquelin
 <mcoquelin.stm32@gmail.com>, Shawn Guo <shawnguo@kernel.org>,
 Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>, NXP Linux Team <linux-imx@nxp.com>
Cc: linux-arm-kernel@lists.infradead.org,
 linux-stm32@st-md-mailman.stormreply.com, linux-kernel@vger.kernel.org
References: <cover.1706184304.git.esben@geanix.com>
 <5606bb5f0b7566a20bb136b268dae89d22a48898.1706184304.git.esben@geanix.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <5606bb5f0b7566a20bb136b268dae89d22a48898.1706184304.git.esben@geanix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 25/01/2024 12:34, Esben Haabendal wrote:
> TSO and TBS cannot coexist. For now we set i.MX Ethernet QOS controller to use
> TX queue with TSO and the rest for TBS.
> 
> TX queues with TBS can support etf qdisc hw offload.
> 
> Signed-off-by: Esben Haabendal <esben@geanix.com>
> ---
>   drivers/net/ethernet/stmicro/stmmac/dwmac-imx.c | 6 ++++++
>   1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-imx.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-imx.c
> index 8f730ada71f9..c42e8f972833 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-imx.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-imx.c
> @@ -353,6 +353,12 @@ static int imx_dwmac_probe(struct platform_device *pdev)
>   	if (data->flags & STMMAC_FLAG_HWTSTAMP_CORRECT_LATENCY)
>   		plat_dat->flags |= STMMAC_FLAG_HWTSTAMP_CORRECT_LATENCY;
>   
> +        for (int i = 0; i < plat_dat->tx_queues_to_use; i++) {
> +                /* Default TX Q0 to use TSO and rest TXQ for TBS */
> +                if (i > 0)
> +                        plat_dat->tx_queues_cfg[i].tbs_en = 1;
> +        }
> +

Just wonder why don't you start with i = 1 and remove 'if' completely?
Keeping comment in place will make it understandable.

>   	plat_dat->host_dma_width = dwmac->ops->addr_width;
>   	plat_dat->init = imx_dwmac_init;
>   	plat_dat->exit = imx_dwmac_exit;


