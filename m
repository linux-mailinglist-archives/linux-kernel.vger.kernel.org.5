Return-Path: <linux-kernel+bounces-88252-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D9C5B86DF37
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 11:28:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9EFE82873D9
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 10:28:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C150A6BB4F;
	Fri,  1 Mar 2024 10:27:58 +0000 (UTC)
Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFE986BB21;
	Fri,  1 Mar 2024 10:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.6.53.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709288878; cv=none; b=jl8MpyNDK8+2iSBDBusaHpbKCJrmZITG4ZePrExjwjsQh0Cy6QH/utW4PFrk8y9rRKaOOWFfOMpJ6i+s/8bMTitutjmHxQSCvm1Vca2GIbX0haw6edX6l6T/GOeukYtWB2Xq4N8XKEfLLbLfXoScpPjfaN1SsoEEToFzCmMF5+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709288878; c=relaxed/simple;
	bh=iy39Q0PmbCSReLq/Ws6hOu/z5TtI9QjD98GQOJha/pY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ccYUvey7Q43tzrtwVpBcLKWQwm/ZkPpArFM1uX+Se0MuIzIrrf7Ujy8YXYOc/YNgaKDSW8kAgu82AaIQ1m+CktFXBgFPhntiVHSemZfZZd6xmTK3PcUOvAH6YcHNHCmiMHScfM2lV8bxGPEaP7SRIIsIQMG2Tfi9Ii/rCvAYFGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; arc=none smtp.client-ip=144.6.53.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
	id 1rg07D-002H41-In; Fri, 01 Mar 2024 18:27:44 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Fri, 01 Mar 2024 18:27:58 +0800
Date: Fri, 1 Mar 2024 18:27:58 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Barry Song <21cnbao@gmail.com>
Cc: davem@davemloft.net, linux-crypto@vger.kernel.org,
	akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
	hannes@cmpxchg.org, chriscli@google.com, chrisl@kernel.org,
	sjenning@redhat.com, vitaly.wool@konsulko.com,
	Barry Song <v-songbaohua@oppo.com>, Nhat Pham <nphamcs@gmail.com>,
	Yosry Ahmed <yosryahmed@google.com>,
	Chengming Zhou <zhouchengming@bytedance.com>,
	Matthew Wilcox <willy@infradead.org>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	"Darrick J. Wong" <djwong@kernel.org>,
	Christoph Hellwig <hch@lst.de>, Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH v6] crypto: scompress: remove memcpy if sg_nents is 1 and
 pages are lowmem
Message-ID: <ZeGtrvm9WGv5cxQV@gondor.apana.org.au>
References: <20240222020617.31041-1-21cnbao@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240222020617.31041-1-21cnbao@gmail.com>

On Thu, Feb 22, 2024 at 03:06:17PM +1300, Barry Song wrote:
>
> -	scatterwalk_map_and_copy(scratch->src, req->src, 0, req->slen, 0);
> +	if (sg_nents(req->src) == 1 && !PageHighMem(sg_page(req->src))) {
> +		src = page_to_virt(sg_page(req->src)) + req->src->offset;

Incidentally this made me look at other uses of PageHighMem in
the kernel.

The one in copy_page_from_iter_atomic looks buggy because it assumes
that the kmap never maps a page if PageHighMem is false, which is not
the case for CONFIG_DEBUG_KMAP_LOCAL_FORCE_MAP.

> @@ -152,8 +165,12 @@ static int scomp_acomp_comp_decomp(struct acomp_req *req, int dir)
>  			ret = -ENOSPC;
>  			goto out;
>  		}
> -		scatterwalk_map_and_copy(scratch->dst, req->dst, 0, req->dlen,
> -					 1);
> +		if (dst == scratch->dst) {
> +			scatterwalk_map_and_copy(scratch->dst, req->dst, 0,
> +						 req->dlen, 1);
> +		} else {
> +			flush_dcache_page(sg_page(req->dst));

I think this is still wrong for the > PAGE_SIZE case.  The existing
code flushes each page sequentially  but the new code only flushes the
first page.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

