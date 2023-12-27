Return-Path: <linux-kernel+bounces-11934-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 001E481EDC8
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 10:26:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AECEE28282C
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 09:26:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4667F28E20;
	Wed, 27 Dec 2023 09:26:23 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45C7F24B2A;
	Wed, 27 Dec 2023 09:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
	id 1rIQAg-00ErDe-MH; Wed, 27 Dec 2023 17:25:51 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Wed, 27 Dec 2023 17:26:01 +0800
Date: Wed, 27 Dec 2023 17:26:01 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: chengming.zhou@linux.dev
Cc: akpm@linux-foundation.org, chrisl@kernel.org, davem@davemloft.net,
	linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
	nphamcs@gmail.com, syzkaller-bugs@googlegroups.com,
	yosryahmed@google.com, 21cnbao@gmail.com,
	zhouchengming@bytedance.com,
	syzbot+3eff5e51bf1db122a16e@syzkaller.appspotmail.com
Subject: Re: [PATCH] crypto: scompress - fix req->dst buffer overflow
Message-ID: <ZYvtqW7TAm6mCelt@gondor.apana.org.au>
References: <0000000000000b05cd060d6b5511@google.com>
 <20231227065043.2730440-1-chengming.zhou@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231227065043.2730440-1-chengming.zhou@linux.dev>

On Wed, Dec 27, 2023 at 06:50:43AM +0000, chengming.zhou@linux.dev wrote:
> From: Chengming Zhou <zhouchengming@bytedance.com>
> 
> The req->dst buffer size should be checked before copying from the
> scomp_scratch->dst to avoid req->dst buffer overflow problem.
> 
> Fixes: 1ab53a77b772 ("crypto: acomp - add driver-side scomp interface")
> Reported-by: syzbot+3eff5e51bf1db122a16e@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/all/0000000000000b05cd060d6b5511@google.com/
> Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
> ---
>  crypto/scompress.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/crypto/scompress.c b/crypto/scompress.c
> index 442a82c9de7d..e654a120ae5a 100644
> --- a/crypto/scompress.c
> +++ b/crypto/scompress.c
> @@ -117,6 +117,7 @@ static int scomp_acomp_comp_decomp(struct acomp_req *req, int dir)
>  	struct crypto_scomp *scomp = *tfm_ctx;
>  	void **ctx = acomp_request_ctx(req);
>  	struct scomp_scratch *scratch;
> +	unsigned int dlen;
>  	int ret;
>  
>  	if (!req->src || !req->slen || req->slen > SCOMP_SCRATCH_SIZE)
> @@ -128,6 +129,8 @@ static int scomp_acomp_comp_decomp(struct acomp_req *req, int dir)
>  	if (!req->dlen || req->dlen > SCOMP_SCRATCH_SIZE)
>  		req->dlen = SCOMP_SCRATCH_SIZE;
>  
> +	dlen = req->dlen;
> +
>  	scratch = raw_cpu_ptr(&scomp_scratch);
>  	spin_lock(&scratch->lock);
>  
> @@ -145,6 +148,9 @@ static int scomp_acomp_comp_decomp(struct acomp_req *req, int dir)
>  				ret = -ENOMEM;
>  				goto out;
>  			}
> +		} else if (req->dlen > dlen) {
> +			ret = -ENOMEM;
> +			goto out;

I think ENOMEM is ambiguous, perhaps ENOSPC?

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

