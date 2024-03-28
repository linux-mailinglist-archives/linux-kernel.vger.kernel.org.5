Return-Path: <linux-kernel+bounces-122743-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D28688FC67
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 11:06:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 383FC296A10
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 10:06:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 756987BB01;
	Thu, 28 Mar 2024 10:06:15 +0000 (UTC)
Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84FC553804;
	Thu, 28 Mar 2024 10:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.6.53.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711620375; cv=none; b=AXRlhScg0CmOJDlgTzOBpXq2Upjo6eWb+Z5kRQHyTtRxzecgm6Gpc996VQGb+MmDRJiDOAt21giVsk/APB1haEiN/YRIA4KRHDVvssGiIXw9KjZJd7DMKAQsmsAisDzGwytsv7/ESIhkI2aqcUmmTIGZtU1LT/5GKdgtwgELNNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711620375; c=relaxed/simple;
	bh=4dG8UhkcaQYzhOF03nvm3E5xZ94yc0It4+G2sZOnS6k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c+p2kILkvV0JE9Lupxm5tPhsAr1midKPe2tWaEWehzXlhnoa8wKB4BRjtplaQQzH2lVIohF/C/SfiJ+IxoKSqemhyJJwYskkakLup5gJGbbXn0eDVMa+a7jqiGauRxEiZYRTC9rAXVkYd/ee1Uyd3S07OEWmkVoWwoPhhjhrEbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; arc=none smtp.client-ip=144.6.53.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
	id 1rpmdb-00C7Dr-R3; Thu, 28 Mar 2024 18:05:36 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Thu, 28 Mar 2024 18:05:52 +0800
Date: Thu, 28 Mar 2024 18:05:52 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Akhil R <akhilrajeev@nvidia.com>
Cc: davem@davemloft.net, robh@kernel.org, krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org, thierry.reding@gmail.com, jonathanh@nvidia.com,
	catalin.marinas@arm.com, will@kernel.org, mperttunen@nvidia.com,
	airlied@gmail.com, daniel@ffwll.ch, linux-crypto@vger.kernel.org,
	devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v6 3/5] crypto: tegra: Add Tegra Security Engine driver
Message-ID: <ZgVBAFmfK7GKgmYi@gondor.apana.org.au>
References: <20240319082306.34716-1-akhilrajeev@nvidia.com>
 <20240319082306.34716-4-akhilrajeev@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240319082306.34716-4-akhilrajeev@nvidia.com>

On Tue, Mar 19, 2024 at 01:53:04PM +0530, Akhil R wrote:
>
> +		.alg.skcipher.op.do_one_request	= tegra_aes_do_one_req,
> +		.alg.skcipher.base = {
> +			.init = tegra_aes_cra_init,
> +			.exit = tegra_aes_cra_exit,
> +			.setkey = tegra_aes_setkey,
> +			.encrypt = tegra_aes_encrypt,
> +			.decrypt = tegra_aes_decrypt,
> +			.min_keysize = AES_MIN_KEY_SIZE,
> +			.max_keysize = AES_MAX_KEY_SIZE,
> +			.ivsize	= AES_BLOCK_SIZE,
> +			.base = {
> +				.cra_name = "ofb(aes)",
> +				.cra_driver_name = "ofb-aes-tegra",
> +				.cra_priority = 500,
> +				.cra_flags = CRYPTO_ALG_TYPE_SKCIPHER | CRYPTO_ALG_ASYNC,
> +				.cra_blocksize = AES_BLOCK_SIZE,
> +				.cra_ctxsize = sizeof(struct tegra_aes_ctx),
> +				.cra_alignmask = 0xf,
> +				.cra_module = THIS_MODULE,
> +			},
> +		}
> +	}, {

OFB no longer exists in the kernel.  Please remove all traces of it
from your driver.

Also please ensure that yuor driver passes the extra fuzz tests.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

