Return-Path: <linux-kernel+bounces-132506-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 10C33899600
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 08:56:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 432FB28E7B5
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 06:56:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFAB428DC8;
	Fri,  5 Apr 2024 06:55:56 +0000 (UTC)
Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB5532557A;
	Fri,  5 Apr 2024 06:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.6.53.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712300156; cv=none; b=Ga2ntcX3/aSuVSLUVnH6kvlQWwF6/d3EGf1qBEaPsnZwaqDLILzS5rLqw/RNvY0nldlHLqeYsrLesf3wQU+KbuXXRXS9Sx0Ik/ZQWwLYIHr48/GP/w1v2Qi5ZSCxGdV1QQy4c8sg4yzvZkrYAu/Fj2LqGgS/Y6XfOxRdXMMTDxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712300156; c=relaxed/simple;
	bh=q5ya0+Qci6RpJzPP5n4dyQIZcgIcb4VBIHESKNhAvvY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tXjDsHYgVWG6QVs7d4hKCb0cvTKWx/0kSgGyHDxF0Z2YQ++oQARysxFxdT1v/lAEfeZM0FwmTdAbNF8JyGvrhSUXS2Dn8s94p0lagzlsaPDQ0qha/BTens2j5hazV+TJ3XVF2TRy5iJvrKuuj+qK4iHUG/Fq1/XCpvgbVuo5Im0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; arc=none smtp.client-ip=144.6.53.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
	id 1rsdU3-00FSp7-Re; Fri, 05 Apr 2024 14:55:32 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Fri, 05 Apr 2024 14:55:48 +0800
Date: Fri, 5 Apr 2024 14:55:48 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Alexey Romanov <avromanov@salutedevices.com>
Cc: neil.armstrong@linaro.org, clabbe@baylibre.com, davem@davemloft.net,
	robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org, khilman@baylibre.com, jbrunet@baylibre.com,
	martin.blumenstingl@googlemail.com, vadim.fedorenko@linux.dev,
	linux-crypto@vger.kernel.org, linux-amlogic@lists.infradead.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, kernel@salutedevices.com
Subject: Re: [PATCH v6 10/23] drivers: crypto: meson: avoid kzalloc in engine
 thread
Message-ID: <Zg+gdDZQG1GeKwGn@gondor.apana.org.au>
References: <20240326153219.2915080-1-avromanov@salutedevices.com>
 <20240326153219.2915080-11-avromanov@salutedevices.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240326153219.2915080-11-avromanov@salutedevices.com>

On Tue, Mar 26, 2024 at 06:32:06PM +0300, Alexey Romanov wrote:
>
>  /*
>   * struct meson_cipher_tfm_ctx - context for a skcipher TFM
> - * @key:		pointer to key data
> + * @keyiv:		key data
>   * @keylen:		len of the key
>   * @keymode:		The keymode(type and size of key) associated with this TFM
>   * @mc:			pointer to the private data of driver handling this TFM
>   * @fallback_tfm:	pointer to the fallback TFM
>   */
>  struct meson_cipher_tfm_ctx {
> -	u32 *key;
> -	u32 keylen;
> +	u8 keyiv[AES_MAX_KEY_SIZE + AES_BLOCK_SIZE] ____cacheline_aligned;
> +	u32 keylen ____cacheline_aligned;

This doesn't do anything to guarantee that tfm_ctx is aligned.

You either need to align this by hand, or you could use the
crypto_skcipher_ctx_dma helper if DMA alignment is what you're
actually looking for.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

