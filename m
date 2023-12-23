Return-Path: <linux-kernel+bounces-10470-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05FE081D4C2
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 16:07:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6588EB223BB
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 15:06:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 448FCDF6B;
	Sat, 23 Dec 2023 15:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pFzz9Z9Q"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91FBEE569;
	Sat, 23 Dec 2023 15:06:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C69DC433C7;
	Sat, 23 Dec 2023 15:06:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703344007;
	bh=ef2yb2BryqG0/ajOzfHPoXfS6PX968o7B3v+ONmu7jw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pFzz9Z9QxYZQQYNdKoZzRGTRsoNv9iUNVoOMjgJ3IT5sbGFOvYXe2x0fjom39lQR2
	 /EZcNV00Wm8GJztcTxdGMEMkue9ri3FGIUNnhXhNp13G1kEPYl0v0zxxnZ8CnJKMTJ
	 fXqCV7W+gNXRqhoVicIlKt1pn4k2Z69aFs3/u/4mo0tIwMib5xQ2iN4k7HVxqhgtjN
	 JARH4D/HyHVO+Lu2cTfmCJHg1ncxeqYEcvzFZMeSrN81Ify11+Oer/ka266bZKxlge
	 Q/h+Dzx4bXzCxA7mHoNt0loajcV+3kGfqQvucWp14StSHYemiGoWOyegTNX4GH0GGY
	 rLcLGvWpLtqtw==
Date: Sat, 23 Dec 2023 15:06:42 +0000
From: Simon Horman <horms@kernel.org>
To: deepakx.nagaraju@intel.com
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	jdavem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
	mun.yew.tham@intel.com,
	Andy Schevchenko <andriy.schevchenko@linux.intel.com>
Subject: Re: [PATCH v2 4/4] net: ethernet: altera: rename functions and their
 prototypes
Message-ID: <20231223150642.GE201037@kernel.org>
References: <20231213071112.18242-6-deepakx.nagaraju@intel.com>
 <20231221134041.27104-1-deepakx.nagaraju@intel.com>
 <20231221134041.27104-5-deepakx.nagaraju@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231221134041.27104-5-deepakx.nagaraju@intel.com>

On Thu, Dec 21, 2023 at 09:40:41PM +0800, deepakx.nagaraju@intel.com wrote:
> From: Nagaraju DeepakX <deepakx.nagaraju@intel.com>
> 
> Move standard DMA interface for sgdma and msgdma and rename them
> from tse_private to dma_private.
> 
> Signed-off-by: Nagaraju DeepakX <deepakx.nagaraju@intel.com>
> Reviewed-by: Andy Schevchenko <andriy.schevchenko@linux.intel.com>

...

> diff --git a/drivers/net/ethernet/altera/altera_tse_main.c b/drivers/net/ethernet/altera/altera_tse_main.c

...

> @@ -252,42 +256,42 @@ static void tse_free_tx_buffer(struct altera_tse_private *priv,
> 
>  static int alloc_init_skbufs(struct altera_tse_private *priv)
>  {
> -	unsigned int rx_descs = priv->rx_ring_size;
> -	unsigned int tx_descs = priv->tx_ring_size;
> +	struct altera_dma_private *dma = &priv->dma_priv;
> +	unsigned int rx_descs = dma->rx_ring_size;
> +	unsigned int tx_descs = dma->tx_ring_size;
>  	int ret = -ENOMEM;
>  	int i;
> 
>  	/* Create Rx ring buffer */
> -	priv->rx_ring = kcalloc(rx_descs, sizeof(struct tse_buffer), GFP_KERNEL);
> -	if (!priv->rx_ring)
> +	dma->rx_ring = kcalloc(rx_descs, sizeof(struct altera_dma_private), GFP_KERNEL);

Hi Nagaraju,

Sorry, I didn't notice this until after I sent my previous review
to this patch.

Is struct altera_dma_private correct on the line above?
It seems to me that it should, rather, be struct altera_dma_buffer.
Likewise a few lines below.

Flagged by Smatch.

> +	if (!dma->rx_ring)
>  		goto err_rx_ring;
> 
>  	/* Create Tx ring buffer */
> -	priv->tx_ring = kcalloc(tx_descs, sizeof(struct tse_buffer), GFP_KERNEL);
> -	if (!priv->tx_ring)
> +	dma->tx_ring = kcalloc(tx_descs, sizeof(struct altera_dma_private), GFP_KERNEL);
> +	if (!dma->tx_ring)
>  		goto err_tx_ring;

> 
> -	priv->tx_cons = 0;
> -	priv->tx_prod = 0;
> +	dma->tx_cons = 0;
> +	dma->tx_prod = 0;
> 
>  	/* Init Rx ring */
>  	for (i = 0; i < rx_descs; i++) {
> -		ret = tse_init_rx_buffer(priv, &priv->rx_ring[i],
> -					 priv->rx_dma_buf_sz);
> +		ret = tse_init_rx_buffer(priv, &priv->dma_priv.rx_ring[i], dma->rx_dma_buf_sz);
>  		if (ret)
>  			goto err_init_rx_buffers;
>  	}
> 
> -	priv->rx_cons = 0;
> -	priv->rx_prod = 0;
> +	dma->rx_cons = 0;
> +	dma->rx_prod = 0;
> 
>  	return 0;
>  err_init_rx_buffers:
>  	while (--i >= 0)
> -		tse_free_rx_buffer(priv, &priv->rx_ring[i]);
> -	kfree(priv->tx_ring);
> +		tse_free_rx_buffer(priv, &priv->dma_priv.rx_ring[i]);
> +	kfree(dma->tx_ring);
>  err_tx_ring:
> -	kfree(priv->rx_ring);
> +	kfree(dma->rx_ring);
>  err_rx_ring:
>  	return ret;
>  }

...

