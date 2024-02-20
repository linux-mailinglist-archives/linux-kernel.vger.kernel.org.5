Return-Path: <linux-kernel+bounces-72314-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D82985B1E0
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 05:14:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4E5D91C20DAC
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 04:14:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB8FF56453;
	Tue, 20 Feb 2024 04:14:05 +0000 (UTC)
Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65AC7535D0;
	Tue, 20 Feb 2024 04:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.6.53.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708402445; cv=none; b=Q/eq0Pzsh3jI8qdq8XxyM+4M6Vm083SYp25+enwI1WuyQrynf95Tgzhl4CjUzfrDoMrxFix2v9wzy3jt2iSa9mmVknB9RFyXxt9exIEQNQBvWZouDu1XDnf6EWsNP+2wpgHw0FRO0CFK3dO54z7H4JUjRZw8bT0VezDo8kBgw+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708402445; c=relaxed/simple;
	bh=Rw0SNFpu2lvJoc2ZPCuOeQBEPxOptGaW+GgiAziczGM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Lds7qmnp7zZqRHP2ck9UWvyxL3zHK/nxU5gdXYmKfbbzNBZZnhx6YmGDInslCndiT8mZu1VuugcTDvw3E/gG4XX9tpzS+WwX6aKpFjXuWSO8xVxKMrqZf5U+ezF1XobVi1Bvnrz68Bc52O7hfAfsuG4bvpW+sDBLR6i/Pdu5gps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; arc=none smtp.client-ip=144.6.53.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
	id 1rcHVP-00FWFK-U5; Tue, 20 Feb 2024 12:13:21 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Tue, 20 Feb 2024 12:13:34 +0800
Date: Tue, 20 Feb 2024 12:13:34 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Barry Song <21cnbao@gmail.com>
Cc: akpm@linux-foundation.org, davem@davemloft.net, hannes@cmpxchg.org,
	linux-crypto@vger.kernel.org, linux-mm@kvack.org, nphamcs@gmail.com,
	yosryahmed@google.com, zhouchengming@bytedance.com,
	chriscli@google.com, chrisl@kernel.org, ddstreet@ieee.org,
	linux-kernel@vger.kernel.org, sjenning@redhat.com,
	vitaly.wool@konsulko.com, Barry Song <v-songbaohua@oppo.com>,
	Yang Shen <shenyang39@huawei.com>,
	Zhou Wang <wangzhou1@hisilicon.com>,
	Tom Zanussi <tom.zanussi@linux.intel.com>
Subject: Re: [PATCH v4 1/3] crypto: introduce crypto_acomp_get_alg_flags to
 expose algorithm flags
Message-ID: <ZdQm7n6Jc3tqsg1F@gondor.apana.org.au>
References: <20240220025545.194886-1-21cnbao@gmail.com>
 <20240220025545.194886-2-21cnbao@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240220025545.194886-2-21cnbao@gmail.com>

On Tue, Feb 20, 2024 at 03:55:43PM +1300, Barry Song wrote:
>
> diff --git a/drivers/crypto/hisilicon/zip/zip_crypto.c b/drivers/crypto/hisilicon/zip/zip_crypto.c
> index c650c741a18d..94e2d66b04b6 100644
> --- a/drivers/crypto/hisilicon/zip/zip_crypto.c
> +++ b/drivers/crypto/hisilicon/zip/zip_crypto.c
> @@ -591,6 +591,7 @@ static struct acomp_alg hisi_zip_acomp_deflate = {
>  	.base			= {
>  		.cra_name		= "deflate",
>  		.cra_driver_name	= "hisi-deflate-acomp",
> +		.cra_flags		= CRYPTO_ALG_ASYNC,
>  		.cra_module		= THIS_MODULE,
>  		.cra_priority		= HZIP_ALG_PRIORITY,
>  		.cra_ctxsize		= sizeof(struct hisi_zip_ctx),
> diff --git a/drivers/crypto/intel/iaa/iaa_crypto_main.c b/drivers/crypto/intel/iaa/iaa_crypto_main.c
> index dfd3baf0a8d8..91adf9d76a2e 100644
> --- a/drivers/crypto/intel/iaa/iaa_crypto_main.c
> +++ b/drivers/crypto/intel/iaa/iaa_crypto_main.c
> @@ -1916,6 +1916,7 @@ static struct acomp_alg iaa_acomp_fixed_deflate = {
>  	.base			= {
>  		.cra_name		= "deflate",
>  		.cra_driver_name	= "deflate-iaa",
> +		.cra_flags		= CRYPTO_ALG_ASYNC,
>  		.cra_ctxsize		= sizeof(struct iaa_compression_ctx),
>  		.cra_module		= THIS_MODULE,
>  		.cra_priority		= IAA_ALG_PRIORITY,

Good catch.  I think this should go into a separate bug-fix patch.

> diff --git a/include/crypto/acompress.h b/include/crypto/acompress.h
> index 574cffc90730..07bd8f6bc79a 100644
> --- a/include/crypto/acompress.h
> +++ b/include/crypto/acompress.h
> @@ -160,6 +160,11 @@ static inline void acomp_request_set_tfm(struct acomp_req *req,
>  	req->base.tfm = crypto_acomp_tfm(tfm);
>  }
>  
> +static inline u32 crypto_acomp_get_alg_flags(struct crypto_acomp *tfm)
> +{
> +	return crypto_tfm_alg_flags(crypto_acomp_tfm(tfm));
> +}

Sorry, my mistake.  I shouldn't have suggested copying skcipher
since that gets the tfm flags as opposed to the alg flags which
you've found out.

I think you should just go with your original function acomp_is_async
but do it like this:

static inline bool acomp_is_async(struct crypto_acomp *tfm)
{
	return crypto_comp_alg_common(tfm)->base.cra_flags &
	       CRYPTO_ALG_ASYNC;
}

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

