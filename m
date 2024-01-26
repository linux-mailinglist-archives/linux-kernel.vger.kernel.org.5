Return-Path: <linux-kernel+bounces-39635-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB83983D3ED
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 06:25:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 31100B254BC
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 05:25:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7E68BE65;
	Fri, 26 Jan 2024 05:25:06 +0000 (UTC)
Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D66DB660;
	Fri, 26 Jan 2024 05:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.6.53.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706246706; cv=none; b=Wv2fwPX5TMOBudmj3rk1n/3KO3VZHhNizG42ag+CHo9BgQg8CQ2NVTXrb4Eu1aHuUfdziSmYRbqt1koAFA9LT7+NOomZ0lo3qKtWfD7KdB5Yn3XYUkSNohudAAqYxrGmF9Oqji7/qJ8Git2Jbe65eUiQ9T33C97Ht9pyF2vJvTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706246706; c=relaxed/simple;
	bh=4r87ljn+2t+Zv9KFPue1fv4ZD9TkwWTLOHkBCo7ksMo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QB0oiXiJrW4ewYI0h2KHkBA3VvurhSLQ+eckkk2mGFRG20HnsiJ0MvsPWNoE480fWgNbx4olfo2GT3nlMQZAL8FEadQR+eO4MNssfHCNNyMqhEShcUXAz7RJAZvoqt7BJfBHf98jjNE3sjnVG10jMU/dBkLfG8cbIxSTjJwT+WU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; arc=none smtp.client-ip=144.6.53.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
	id 1rTEhp-006Cbq-RH; Fri, 26 Jan 2024 13:24:46 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Fri, 26 Jan 2024 13:24:58 +0800
Date: Fri, 26 Jan 2024 13:24:58 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Jia Jie Ho <jiajie.ho@starfivetech.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-crypto@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/5] crypto: starfive: Add sm3 support for JH8100
Message-ID: <ZbNCKrTLXmPcsrSH@gondor.apana.org.au>
References: <20240116090135.75737-1-jiajie.ho@starfivetech.com>
 <20240116090135.75737-5-jiajie.ho@starfivetech.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240116090135.75737-5-jiajie.ho@starfivetech.com>

On Tue, Jan 16, 2024 at 05:01:34PM +0800, Jia Jie Ho wrote:
> Add driver support for SM3 hash/HMAC for JH8100 SoC. JH8100 contains a
> separate SM algo engine and new dedicated dma that supports 64-bit
> address access.
> 
> Signed-off-by: Jia Jie Ho <jiajie.ho@starfivetech.com>
> ---
>  drivers/crypto/starfive/Kconfig       |  25 +-
>  drivers/crypto/starfive/Makefile      |   3 +
>  drivers/crypto/starfive/jh7110-cryp.c |  48 ++-
>  drivers/crypto/starfive/jh7110-cryp.h |  59 +++
>  drivers/crypto/starfive/jh7110-hash.c |  20 +-
>  drivers/crypto/starfive/jh8100-sm3.c  | 532 ++++++++++++++++++++++++++
>  6 files changed, 677 insertions(+), 10 deletions(-)
>  create mode 100644 drivers/crypto/starfive/jh8100-sm3.c
> 
> diff --git a/drivers/crypto/starfive/Kconfig b/drivers/crypto/starfive/Kconfig
> index 0fe389e9f932..e6bf02d0ed1f 100644
> --- a/drivers/crypto/starfive/Kconfig
> +++ b/drivers/crypto/starfive/Kconfig
> @@ -5,7 +5,7 @@
>  config CRYPTO_DEV_JH7110
>  	tristate "StarFive JH7110 cryptographic engine driver"
>  	depends on (SOC_STARFIVE && AMBA_PL08X) || COMPILE_TEST
> -	depends on HAS_DMA
> +	depends on HAS_DMA && !CRYPTO_DEV_JH8100
>  	select CRYPTO_ENGINE
>  	select CRYPTO_HMAC
>  	select CRYPTO_SHA256
> @@ -24,3 +24,26 @@ config CRYPTO_DEV_JH7110
>  	  skciphers, AEAD and hash functions.
>  
>  	  If you choose 'M' here, this module will be called jh7110-crypto.
> +
> +config CRYPTO_DEV_JH8100
> +	tristate "StarFive JH8100 cryptographic engine drivers"
> +	depends on (SOC_STARFIVE && DW_AXI_DMAC) || COMPILE_TEST
> +	depends on HAS_DMA
> +	select CRYPTO_ENGINE
> +	select CRYPTO_HMAC
> +	select CRYPTO_SHA256
> +	select CRYPTO_SHA512
> +	select CRYPTO_SM3_GENERIC
> +	select CRYPTO_RSA
> +	select CRYPTO_AES
> +	select CRYPTO_CCM
> +	select CRYPTO_GCM
> +	select CRYPTO_CBC
> +	select CRYPTO_ECB
> +	select CRYPTO_CTR
> +	help
> +	  Support for StarFive JH8100 crypto hardware acceleration engine.
> +	  This module provides additional support for SM2 signature verification,
> +	  SM3 hash/hmac functions and SM4 skcipher.
> +
> +	  If you choose 'M' here, this module will be called jh8100-crypto.
> diff --git a/drivers/crypto/starfive/Makefile b/drivers/crypto/starfive/Makefile
> index 8c137afe58ad..67717fca3f5d 100644
> --- a/drivers/crypto/starfive/Makefile
> +++ b/drivers/crypto/starfive/Makefile
> @@ -2,3 +2,6 @@
>  
>  obj-$(CONFIG_CRYPTO_DEV_JH7110) += jh7110-crypto.o
>  jh7110-crypto-objs := jh7110-cryp.o jh7110-hash.o jh7110-rsa.o jh7110-aes.o
> +
> +obj-$(CONFIG_CRYPTO_DEV_JH8100) += jh8100-crypto.o
> +jh8100-crypto-objs := jh7110-cryp.o jh7110-hash.o jh7110-rsa.o jh7110-aes.o jh8100-sm3.o
> diff --git a/drivers/crypto/starfive/jh7110-cryp.c b/drivers/crypto/starfive/jh7110-cryp.c
> index fe33e87f25ab..fb7c19705fbf 100644
> --- a/drivers/crypto/starfive/jh7110-cryp.c
> +++ b/drivers/crypto/starfive/jh7110-cryp.c
> @@ -106,6 +106,26 @@ static irqreturn_t starfive_cryp_irq(int irq, void *priv)
>  	return IRQ_HANDLED;
>  }
>  
> +#ifdef CONFIG_CRYPTO_DEV_JH8100
> +static irqreturn_t starfive_cryp_irq1(int irq, void *priv)
> +{
> +	u32 status;
> +	u32 mask;
> +	struct starfive_cryp_dev *cryp = (struct starfive_cryp_dev *)priv;
> +
> +	mask = readl(cryp->base + STARFIVE_SM_IE_MASK_OFFSET);
> +	status = readl(cryp->base + STARFIVE_SM_IE_FLAG_OFFSET);
> +
> +	if (status & STARFIVE_SM_IE_FLAG_SM3_DONE) {
> +		mask |= STARFIVE_SM_IE_MASK_SM3_DONE;
> +		writel(mask, cryp->base + STARFIVE_SM_IE_MASK_OFFSET);
> +		tasklet_schedule(&cryp->sm3_done);
> +	}
> +
> +	return IRQ_HANDLED;
> +}
> +#endif
> +
>  static int starfive_cryp_probe(struct platform_device *pdev)
>  {
>  	struct starfive_cryp_dev *cryp;
> @@ -156,6 +176,16 @@ static int starfive_cryp_probe(struct platform_device *pdev)
>  		return dev_err_probe(&pdev->dev, ret,
>  				     "Failed to register interrupt handler\n");
>  
> +#ifdef CONFIG_CRYPTO_DEV_JH8100
> +	tasklet_init(&cryp->sm3_done, starfive_sm3_done_task, (unsigned long)cryp);
> +
> +	irq = platform_get_irq(pdev, 1);
> +	if (irq < 0)
> +		return irq;
> +
> +	ret = devm_request_irq(&pdev->dev, irq, starfive_cryp_irq1, 0,
> +			       pdev->name, (void *)cryp);
> +#endif
>  	clk_prepare_enable(cryp->hclk);
>  	clk_prepare_enable(cryp->ahb);
>  	reset_control_deassert(cryp->rst);
> @@ -191,8 +221,17 @@ static int starfive_cryp_probe(struct platform_device *pdev)
>  	if (ret)
>  		goto err_algs_rsa;
>  
> +#ifdef CONFIG_CRYPTO_DEV_JH8100
> +	ret = starfive_sm3_register_algs();
> +	if (ret)
> +		goto err_algs_sm3;
> +#endif
>  	return 0;
>  
> +#ifdef CONFIG_CRYPTO_DEV_JH8100
> +err_algs_sm3:
> +	starfive_rsa_unregister_algs();
> +#endif
>  err_algs_rsa:
>  	starfive_hash_unregister_algs();
>  err_algs_hash:
> @@ -213,7 +252,9 @@ static int starfive_cryp_probe(struct platform_device *pdev)
>  	reset_control_assert(cryp->rst);
>  
>  	tasklet_kill(&cryp->hash_done);
> -
> +#ifdef CONFIG_CRYPTO_DEV_JH8100
> +	tasklet_kill(&cryp->sm3_done);
> +#endif

Please use if instead if ifdef where possible:

	if (IS_ENABLED(CONFIG_CRYPTO_DEV_JH8100))
		tasklet_kill(&cryp->sm3_done);

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

