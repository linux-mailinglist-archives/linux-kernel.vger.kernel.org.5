Return-Path: <linux-kernel+bounces-74079-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5077385CFB9
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 06:35:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 248EDB21D7B
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 05:35:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D0B112B89;
	Wed, 21 Feb 2024 05:35:18 +0000 (UTC)
Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8376139FC8;
	Wed, 21 Feb 2024 05:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.6.53.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708493717; cv=none; b=g8wIYMU0H2zgicqZmoxlWPyc7AXYCJOWH2iD4KNAvBb67Cee/HGTdFtW1pd+hK0d9W9dgKM12mu+PF/4sDNpBJRNHjAX2bTFqaDM/T/HRSJ2Q0EQLuDJISNbzRC62jux0dMIxLP6VtS9eQzz+E7rBmx3EvYuci6QMmy/bbfMwYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708493717; c=relaxed/simple;
	bh=idHZC08uWPSop2TYajMG3SatIvkNgD9dKQXq4wqE7Rw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iVvins2x4JYw1mKX8Q9p7BHFP5GKx2GsfusaCUCKlQ9/slVpe2DB5SPqDTkLt1o9HckvIV5sFNoZyv1V+4PEXQe/mmutXJVqYU6NjBC8hYzqUKs8A42t9A+OdFvYttRL3jwcoT3aN/VDYHDTtHFCdksBFfyNMyaoX3/hU/1TJb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; arc=none smtp.client-ip=144.6.53.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
	id 1rcfFr-00Fwpg-MC; Wed, 21 Feb 2024 13:34:52 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Wed, 21 Feb 2024 13:35:06 +0800
Date: Wed, 21 Feb 2024 13:35:06 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Barry Song <21cnbao@gmail.com>
Cc: akpm@linux-foundation.org, davem@davemloft.net, hannes@cmpxchg.org,
	linux-crypto@vger.kernel.org, linux-mm@kvack.org, nphamcs@gmail.com,
	yosryahmed@google.com, zhouchengming@bytedance.com,
	chriscli@google.com, chrisl@kernel.org, ddstreet@ieee.org,
	linux-kernel@vger.kernel.org, sjenning@redhat.com,
	vitaly.wool@konsulko.com, Barry Song <v-songbaohua@oppo.com>
Subject: Re: [PATCH v5 3/3] crypto: scompress: remove memcpy if sg_nents is 1
Message-ID: <ZdWLim6zYSl/x1Bk@gondor.apana.org.au>
References: <20240220064414.262582-1-21cnbao@gmail.com>
 <20240220064414.262582-4-21cnbao@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240220064414.262582-4-21cnbao@gmail.com>

On Tue, Feb 20, 2024 at 07:44:14PM +1300, Barry Song wrote:
> From: Barry Song <v-songbaohua@oppo.com>
> 
> while sg_nents is 1 which is always true for the current kernel
> as the only user - zswap is the case, we should remove two big
> memcpy.
> 
> Signed-off-by: Barry Song <v-songbaohua@oppo.com>
> Tested-by: Chengming Zhou <zhouchengming@bytedance.com>
> ---
>  crypto/scompress.c | 36 +++++++++++++++++++++++++++++-------
>  1 file changed, 29 insertions(+), 7 deletions(-)

This patch is independent of the other two.  Please split it
out so I can apply it directly.

> @@ -134,13 +135,25 @@ static int scomp_acomp_comp_decomp(struct acomp_req *req, int dir)
>  	scratch = raw_cpu_ptr(&scomp_scratch);
>  	spin_lock(&scratch->lock);
>  
> -	scatterwalk_map_and_copy(scratch->src, req->src, 0, req->slen, 0);
> +	if (sg_nents(req->src) == 1) {
> +		src = kmap_local_page(sg_page(req->src)) + req->src->offset;

What if the SG entry is longer than PAGE_SIZE (or indeed crosses a
page boundary)? I think the test needs to be strengthened.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

