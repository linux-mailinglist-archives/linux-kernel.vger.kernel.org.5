Return-Path: <linux-kernel+bounces-28515-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C42782FF94
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 05:33:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A807E288BE6
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 04:33:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A63DD6FB9;
	Wed, 17 Jan 2024 04:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aX++13or"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2D575CB0;
	Wed, 17 Jan 2024 04:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705465991; cv=none; b=QwNzDborLRRu/1Zr6SHVrG5u7mfJI/xEKZJVAbyTk790FSmCNt4/8FeENqDCs2Ne20GEh5swYc+/FafOuz9yDpwcf/YPkmTJv/FPLNofbCrwyIDQK5+qE4kfGhHDtOjotbtcK2Ebb570kAOz+yk3yk9J8xyDovCY38X3O8R061g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705465991; c=relaxed/simple;
	bh=S4Y+N5roFk3ljK8uuhGxBeghOoBpwMv3omGMxYBhshU=;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To; b=S1kLXEW1PFHJhRM1fyZ/36pewz0YHmjibRiQBDUgTQqBx9cU3/cYGJYOxiEopi3Vt8SCMjHFNmuOBQxb0LYXG7c3Y6jQB0hkAH/YUN4Rlhx4+yIISBymD/kmQuKGXJvxX7atHGrVt9va1Zd5CDkyqWxiJ2ISHFe2N1szYuAJB8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aX++13or; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2D3CC433F1;
	Wed, 17 Jan 2024 04:33:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705465990;
	bh=S4Y+N5roFk3ljK8uuhGxBeghOoBpwMv3omGMxYBhshU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aX++13orocI0DvGwwJV4MJLk9l8LyX4I+tL+j1tzw4Efm+ckDSm9E82k20c1IguDX
	 GLVe5GH3u0eeQ8RX/v56Up9qYVPmUTXCg1y0410+6r3FABo6ItLAEJapGsbkzflhl7
	 T///THcRxnnYTSAQqyaqrwI/R41CzievnOJIK5GHW8/JVVhhGDJH0Id0qlRfObQGwl
	 fsg261V10HnXFZjScl33OYe3t+EJbhFgbMlNsd0f1gPSzCuZ1ckyIcSwXX/5Fpv5n0
	 0ggQI//NFBXfQnARvHacOsjv5HIeQ+hzflBFtl5CqQWtfFiOxnYZ5lz2pfVN0Z2Nw8
	 HAQ5W+6FPEB4A==
Date: Tue, 16 Jan 2024 20:33:08 -0800
From: Eric Biggers <ebiggers@kernel.org>
To: Gaurav Jain <gaurav.jain@nxp.com>
Cc: Herbert Xu <herbert@gondor.apana.org.au>,
	"David S . Miller" <davem@davemloft.net>,
	Horia Geanta <horia.geanta@nxp.com>,
	Pankaj Gupta <pankaj.gupta@nxp.com>, Varun Sethi <V.Sethi@nxp.com>,
	Meenakshi Aggarwal <meenakshi.aggarwal@nxp.com>,
	Aisheng Dong <aisheng.dong@nxp.com>,
	Silvano Di Ninno <silvano.dininno@nxp.com>,
	linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-imx@nxp.com
Subject: Re: [PATCH] crypto: caam/hash - fix asynchronous hash
Message-ID: <20240117043308.GA1137@sol.localdomain>
References: <20240116094405.744466-1-gaurav.jain@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240116094405.744466-1-gaurav.jain@nxp.com>

On Tue, Jan 16, 2024 at 03:14:05PM +0530, Gaurav Jain wrote:
> ahash_alg->setkey is updated to ahash_nosetkey in ahash.c
> so updating the handling of setkey in caam driver.
> 
> Fixes: 2f1f34c1bf7b ("crypto: ahash - optimize performance when wrapping shash")
> Signed-off-by: Gaurav Jain <gaurav.jain@nxp.com>
> ---
>  drivers/crypto/caam/caamalg_qi2.c | 4 ++--
>  drivers/crypto/caam/caamhash.c    | 4 ++--
>  2 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/crypto/caam/caamalg_qi2.c b/drivers/crypto/caam/caamalg_qi2.c
> index a148ff1f0872..93a400e286b4 100644
> --- a/drivers/crypto/caam/caamalg_qi2.c
> +++ b/drivers/crypto/caam/caamalg_qi2.c
> @@ -4571,7 +4571,7 @@ static int caam_hash_cra_init(struct crypto_tfm *tfm)
>  
>  	ctx->dev = caam_hash->dev;
>  
> -	if (alg->setkey) {
> +	if (crypto_hash_alg_has_setkey(halg)) {
>  		ctx->adata.key_dma = dma_map_single_attrs(ctx->dev, ctx->key,
>  							  ARRAY_SIZE(ctx->key),
>  							  DMA_TO_DEVICE,
> @@ -4611,7 +4611,7 @@ static int caam_hash_cra_init(struct crypto_tfm *tfm)
>  	 * For keyed hash algorithms shared descriptors
>  	 * will be created later in setkey() callback
>  	 */
> -	return alg->setkey ? 0 : ahash_set_sh_desc(ahash);
> +	return crypto_hash_alg_has_setkey(halg) ? 0 : ahash_set_sh_desc(ahash);
>  }
>  
>  static void caam_hash_cra_exit(struct crypto_tfm *tfm)
> diff --git a/drivers/crypto/caam/caamhash.c b/drivers/crypto/caam/caamhash.c
> index 290c8500c247..4d50356b593c 100644
> --- a/drivers/crypto/caam/caamhash.c
> +++ b/drivers/crypto/caam/caamhash.c
> @@ -1804,7 +1804,7 @@ static int caam_hash_cra_init(struct crypto_tfm *tfm)
>  	} else {
>  		if (priv->era >= 6) {
>  			ctx->dir = DMA_BIDIRECTIONAL;
> -			ctx->key_dir = alg->setkey ? DMA_TO_DEVICE : DMA_NONE;
> +			ctx->key_dir = crypto_hash_alg_has_setkey(halg) ? DMA_TO_DEVICE : DMA_NONE;
>  		} else {
>  			ctx->dir = DMA_TO_DEVICE;
>  			ctx->key_dir = DMA_NONE;
> @@ -1862,7 +1862,7 @@ static int caam_hash_cra_init(struct crypto_tfm *tfm)
>  	 * For keyed hash algorithms shared descriptors
>  	 * will be created later in setkey() callback
>  	 */
> -	return alg->setkey ? 0 : ahash_set_sh_desc(ahash);
> +	return crypto_hash_alg_has_setkey(halg) ? 0 : ahash_set_sh_desc(ahash);
>  }
>  

Thanks.  Did you also consider putting something in struct caam_hash_alg (the
struct in which this driver embeds its ahash_alg structure) that indicates
whether the algorithm is an HMAC or not?  Other drivers use that solution.

- Eric

