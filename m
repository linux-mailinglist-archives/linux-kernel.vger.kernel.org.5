Return-Path: <linux-kernel+bounces-70708-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B1303859B64
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 05:25:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EDD841C21A7A
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 04:25:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63DE6CA42;
	Mon, 19 Feb 2024 04:25:06 +0000 (UTC)
Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C609BA2F;
	Mon, 19 Feb 2024 04:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.6.53.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708316706; cv=none; b=dWPx+CQfALiEythNk4AVoPiGk5SdgnZGsuT9hDBiDjRVwbCnZYoAj+0SQBpTAt+iZHqlJ7sA6GKveOXqbYQtjeKBu+xBOudt5nv1lGc4IzRtIXzOFy9cSwrcW+T9KolK+c4ucsCMjbJ/OJFKEr438LKb49eHq5AdRFi/vlvNhak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708316706; c=relaxed/simple;
	bh=cBfVK9GJiD1MyX3gdtIKNvIC7a66sFGceG13FH2/R+o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CCqTwirLeZOKBMfe5BRa+UxsloRAAAJLMubuQ+b7XfkmTRUev5A2nsKzGBGn50qAFce5n90YLy++F90WQ/9HCna1/RncGym2g8nadFTnbvXTLo5UJtkIoauN20GO7pnZLbVVh64U9deuZnKOf0Iv1uFyFntZrnICghfO2O2S0Lo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; arc=none smtp.client-ip=144.6.53.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
	id 1rbvCn-00F8Hm-6v; Mon, 19 Feb 2024 12:24:38 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Mon, 19 Feb 2024 12:24:51 +0800
Date: Mon, 19 Feb 2024 12:24:51 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Barry Song <21cnbao@gmail.com>
Cc: akpm@linux-foundation.org, davem@davemloft.net, hannes@cmpxchg.org,
	linux-crypto@vger.kernel.org, linux-mm@kvack.org, nphamcs@gmail.com,
	yosryahmed@google.com, zhouchengming@bytedance.com,
	chriscli@google.com, chrisl@kernel.org, ddstreet@ieee.org,
	linux-kernel@vger.kernel.org, sjenning@redhat.com,
	vitaly.wool@konsulko.com, Barry Song <v-songbaohua@oppo.com>
Subject: Re: [PATCH v3 1/3] crypto: introduce acomp_is_sleepable to expose if
 comp drivers might sleep
Message-ID: <ZdLYE8mx0AJ7a7+t@gondor.apana.org.au>
References: <20240217045102.55339-1-21cnbao@gmail.com>
 <20240217045102.55339-2-21cnbao@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240217045102.55339-2-21cnbao@gmail.com>

On Sat, Feb 17, 2024 at 05:51:00PM +1300, Barry Song wrote:
.
> diff --git a/crypto/acompress.c b/crypto/acompress.c
> index 1c682810a484..fa15df394a4c 100644
> --- a/crypto/acompress.c
> +++ b/crypto/acompress.c
> @@ -152,6 +152,14 @@ struct crypto_acomp *crypto_alloc_acomp_node(const char *alg_name, u32 type,
>  }
>  EXPORT_SYMBOL_GPL(crypto_alloc_acomp_node);
>  
> +bool acomp_is_sleepable(struct crypto_acomp *acomp)
> +{
> +	struct crypto_tfm *tfm = crypto_acomp_tfm(acomp);
> +
> +	return tfm->__crt_alg->cra_type == &crypto_acomp_type;
> +}
> +EXPORT_SYMBOL_GPL(acomp_is_sleepable);

Just because something is of acomp_type it doesn't mean that it's
async.  You should be testing the algorithm flags.

So introduce a helper crypto_acomp_get_flags (see the similar
helper crypto_skcipher_get_flags) and test it against CRYPTO_ALG_ASYNC.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

