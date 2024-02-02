Return-Path: <linux-kernel+bounces-49607-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C66A846D1C
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 10:58:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 11178B2F442
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 09:47:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA7C47C087;
	Fri,  2 Feb 2024 09:44:17 +0000 (UTC)
Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E6607A730;
	Fri,  2 Feb 2024 09:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.6.53.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706867057; cv=none; b=E9lOrGqqoik4OlmrdpnGoIQLZr/hY3jp8HqNPAJX4fbDMpZmT4QYxC4+uSFdL4olSBrifWhv9vjJqrgjWhbEMk8vzmeD4NUDrdOa7PqvdeVXVj8Owy20ovf0naRBbJqLclh2xNalgHJYwG2ZureMoCE/0jPskmeaK3mYfyFcCFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706867057; c=relaxed/simple;
	bh=Bf+4ZbsD/KaLOEcg0A2at4EAsFDvJn42PNtErzLoa6s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h8/yu/V7ll8IPnHmdXbN2s/rttYGsKJGjuna7GRjM/lYST0rHP/slHcHy7ufh7TlpBiSlafN+fbPAWCq064H+WpWdVq2783Y9ZdLWk49aoSoIfWjkVGunqsGGssanNl6L6WbgQIXimSgKPABCu7prwYc1e9iES8k+kWFI3toRZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; arc=none smtp.client-ip=144.6.53.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
	id 1rVq5W-0092Ed-PT; Fri, 02 Feb 2024 17:43:59 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Fri, 02 Feb 2024 17:44:12 +0800
Date: Fri, 2 Feb 2024 17:44:12 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Akhil R <akhilrajeev@nvidia.com>
Cc: davem@davemloft.net, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	thierry.reding@gmail.com, jonathanh@nvidia.com,
	catalin.marinas@arm.com, will@kernel.org, mperttunen@nvidia.com,
	linux-crypto@vger.kernel.org, devicetree@vger.kernel.org,
	linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
	krzk@kernel.org
Subject: Re: [PATCH v4 3/5] crypto: tegra: Add Tegra Security Engine driver
Message-ID: <Zby5bLEgz/UktarE@gondor.apana.org.au>
References: <20240124083846.46487-1-akhilrajeev@nvidia.com>
 <20240124083846.46487-4-akhilrajeev@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240124083846.46487-4-akhilrajeev@nvidia.com>

On Wed, Jan 24, 2024 at 02:08:44PM +0530, Akhil R wrote:
>
> +static void tegra_sha_init_fallback(struct tegra_sha_ctx *ctx, const char *algname)
> +{
> +	ctx->fallback_tfm = crypto_alloc_ahash(algname, 0, CRYPTO_ALG_ASYNC |
> +						CRYPTO_ALG_NEED_FALLBACK);
> +
> +	if (IS_ERR(ctx->fallback_tfm)) {
> +		dev_warn(ctx->se->dev, "failed to allocate fallback for %s %ld\n",
> +			 algname, PTR_ERR(ctx->fallback_tfm));
> +		ctx->fallback_tfm = NULL;
> +	}
> +}

This should check that the fallback state size is smaller than
that of tegra.  As otherwise the fallback export/import will break.

> +static int tegra_sha_import(struct ahash_request *req, const void *in)
> +{
> +	struct tegra_sha_reqctx *rctx = ahash_request_ctx(req);
> +	struct crypto_ahash *tfm = crypto_ahash_reqtfm(req);
> +	struct tegra_sha_ctx *ctx = crypto_ahash_ctx(tfm);
> +	int i;
> +
> +	if (ctx->fallback)
> +		return tegra_sha_fallback_import(req, in);
> +
> +	memcpy(rctx, in, sizeof(*rctx));
> +
> +	/* Paste all intermediate results */
> +	for (i = 0; i < HASH_RESULT_REG_COUNT; i++)
> +		writel(rctx->result[i],
> +		       ctx->se->base + ctx->se->hw->regs->result + (i * 4));

What happens when multiple requests of the same tfm import at
the same time?  Normally we don't actually touch the hardware
in the import function.  Instead, all the hard work happens at
the end of the update function, which moves hardware state into
the request object.

The import/export function then simply copies the request object
state to the in/out buffer.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

