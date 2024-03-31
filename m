Return-Path: <linux-kernel+bounces-126020-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CBB4893101
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Mar 2024 11:03:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7EBAC1C21A3C
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Mar 2024 09:03:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEFD1757F2;
	Sun, 31 Mar 2024 08:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hnenQLRM"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 268C16BB23;
	Sun, 31 Mar 2024 08:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711875284; cv=none; b=E4rQwWbkqg7K7yiK0NQohFpheOREtj0q9rO4gbb8ASZbrLjvWKnm8ELAVhVpDhh59JWB7qqirRyyFXdkSg4mmvzV0CCvAJMq//3SmkruaB1ouIzy/LAHxiy/4hgy1TrUmEW+EWJ9a4J9gYTyYllqvSFejCGJB1WMXS5NpyW+48Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711875284; c=relaxed/simple;
	bh=vq+yVxHBNYz1MHfaG/f7xwyOH/JCSiaOQmS2/BWaKb4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X95HGmomnKacIV++w9omnMkcSokfK68zNLLLyUpGsJ/6uGcHIykxe0dV0sTeXB+z2taWdF21qgjZq7TxUgclgYmfcgXXTNns0KcfGej3oR4VrNPWDQzVVXhLR2vKl9yuXLrGsj+iNRbszKS5TWGe27ctRTvsJjb/WXtMqs/aOEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hnenQLRM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C27EC433C7;
	Sun, 31 Mar 2024 08:54:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711875283;
	bh=vq+yVxHBNYz1MHfaG/f7xwyOH/JCSiaOQmS2/BWaKb4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hnenQLRMWEJv9JsczxYuZzPYE00Uygwtk+6KJaj7VtKppqD3jESbEZdPnql67BOpo
	 eqmFnEQ1SJiM3jstS2wrxcASOgOz4ebv0R5/ZBvg1B5GgmfsA91HkBGyDeeMQyVbbQ
	 H4J8hGHP4wMoRvMsWljXdQVJmxy8MmbJx14eOLuPtyJgGLM2LIbl7tUaryLrCvXRKj
	 phEsy+C1a6v67TaG4O+aL9r9ngSNDC/h14r1sP4+HgOb8fRSrkX9mUIFMVrnGmQCf2
	 zSYkg5X9xzs1/RCURPXm/tYgVfmuijIs9FpoDGZgmsDVFLYbgqvB+c1zLMEzShnInA
	 f76qTV/KTCz8w==
Date: Sun, 31 Mar 2024 09:54:38 +0100
From: Simon Horman <horms@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: aleksander.lobakin@intel.com, kuba@kernel.org, davem@davemloft.net,
	pabeni@redhat.com, edumazet@google.com,
	Taras Chornyi <taras.chornyi@plvision.eu>,
	quic_jjohnson@quicinc.com, kvalo@kernel.org, leon@kernel.org,
	dennis.dalessandro@cornelisnetworks.com,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH net-next v2 2/5] net: marvell: prestera: allocate dummy
 net_device dynamically
Message-ID: <20240331085438.GA26556@kernel.org>
References: <20240328235214.4079063-1-leitao@debian.org>
 <20240328235214.4079063-3-leitao@debian.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240328235214.4079063-3-leitao@debian.org>

On Thu, Mar 28, 2024 at 04:52:02PM -0700, Breno Leitao wrote:
> Embedding net_device into structures prohibits the usage of flexible
> arrays in the net_device structure. For more details, see the discussion
> at [1].
> 
> Un-embed the net_device from the private struct by converting it
> into a pointer. Then use the leverage the new alloc_netdev_dummy()
> helper to allocate and initialize dummy devices.
> 
> [1] https://lore.kernel.org/all/20240229225910.79e224cf@kernel.org/
> 
> Signed-off-by: Breno Leitao <leitao@debian.org>
> ---
>  .../net/ethernet/marvell/prestera/prestera_rxtx.c | 15 ++++++++++++---
>  1 file changed, 12 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/net/ethernet/marvell/prestera/prestera_rxtx.c b/drivers/net/ethernet/marvell/prestera/prestera_rxtx.c

..

> @@ -654,13 +654,21 @@ static int prestera_sdma_switch_init(struct prestera_switch *sw)
>  	if (err)
>  		goto err_evt_register;
>  
> -	init_dummy_netdev(&sdma->napi_dev);
> +	sdma->napi_dev = alloc_netdev_dummy(0);
> +	if (!sdma->napi_dev) {
> +		dev_err(dev, "not able to initialize dummy device\n");
> +		goto err_alloc_dummy;

Hi Breno,

This goto will result in the function returning err.
But err is 0 here. Perhaps it should be set to a negative error value
instead?

Flagged by Smatch.

> +	}
> +
>  
> -	netif_napi_add(&sdma->napi_dev, &sdma->rx_napi, prestera_sdma_rx_poll);
> +	netif_napi_add(sdma->napi_dev, &sdma->rx_napi, prestera_sdma_rx_poll);
>  	napi_enable(&sdma->rx_napi);
>  
>  	return 0;
>  
> +err_alloc_dummy:
> +	prestera_hw_event_handler_unregister(sw, PRESTERA_EVENT_TYPE_RXTX,
> +					     prestera_rxtx_handle_event);
>  err_evt_register:
>  err_tx_init:
>  	prestera_sdma_tx_fini(sdma);

..

