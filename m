Return-Path: <linux-kernel+bounces-167537-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49A388BAB0A
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 12:52:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 05BE128144A
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 10:52:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C31817758;
	Fri,  3 May 2024 10:52:43 +0000 (UTC)
Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 347691509BA;
	Fri,  3 May 2024 10:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.6.53.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714733562; cv=none; b=ZjJYgx9FDJbKw83rq2ycF4aJFWFEpT3UcVzjbIY1lUfGOhfq8Dsrm3dlB2icylqq33hSYU8E7q1vi7bOBlr5okpf0hQVKkcbPHP70asUZUAqj8Dxk6cNzi08wyGBJEI8Cr3aIrFPbmDI/5yv0HceoRF/AopVdvanPeUumBD9Znk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714733562; c=relaxed/simple;
	bh=1I51ovZmhZ3EOpf+5FhxBfWBDueNlAZVpvhg2EqGNpk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LU31f2hx3kA9fn53buDU7ma22ofOiS0Gt0E5rECZnYV2axY7ksoNLVnvua1sIAKSsiPwmzH9YXOrU4MH+5wZXmUkBTIougzoBfnART2LFz3qy4Jv1FvZr6hu7O1aNIKTYeNgi4zs7MdFVcRp+xBOjZSMbn01Pgz1YRDkHcq06RM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; arc=none smtp.client-ip=144.6.53.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1s2qWI-009vRn-2W;
	Fri, 03 May 2024 18:52:03 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Fri, 03 May 2024 18:52:03 +0800
Date: Fri, 3 May 2024 18:52:03 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Maxime MERE <maxime.mere@foss.st.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>,
	Rob Herring <robh@kernel.org>, linux-crypto@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/3] crypto: stm32/cryp - use dma when possible.
Message-ID: <ZjTB03ErvDq-lEib@gondor.apana.org.au>
References: <20240423151409.902490-1-maxime.mere@foss.st.com>
 <20240423151409.902490-2-maxime.mere@foss.st.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240423151409.902490-2-maxime.mere@foss.st.com>

On Tue, Apr 23, 2024 at 05:14:07PM +0200, Maxime MERE wrote:
>
> @@ -1239,12 +1758,35 @@ static int stm32_cryp_cipher_one_req(struct crypto_engine *engine, void *areq)
>  	struct stm32_cryp_ctx *ctx = crypto_skcipher_ctx(
>  			crypto_skcipher_reqtfm(req));
>  	struct stm32_cryp *cryp = ctx->cryp;
> +	int ret;
>  
>  	if (!cryp)
>  		return -ENODEV;
>  
> -	return stm32_cryp_prepare_req(req, NULL) ?:
> -	       stm32_cryp_cpu_start(cryp);
> +	ret = stm32_cryp_prepare_req(req, NULL);
> +	if (ret)
> +		return ret;
> +
> +	/* Avoid to use DMA if peripheral 32 bit counter is about to overflow with ctr(aes) */
> +	if (is_aes(cryp) && is_ctr(cryp)) {
> +		u32 iv_overflow[4];
> +
> +		memcpy(iv_overflow, req->iv, sizeof(__be32) * 4);
> +		iv_overflow[3] = 0xffffffff - be32_to_cpu((__be32)iv_overflow[3]);

This triggers a new warning:

./drivers/crypto/stm32/stm32-cryp.c:1775:47: warning: cast to restricted __be32

The logic seems to be broken as the counter counts blocks but you're
testing against bytes (req->src->length)? What's more req->src->length
isn't even the length of the request as it's clamped by req->cryptlen.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

