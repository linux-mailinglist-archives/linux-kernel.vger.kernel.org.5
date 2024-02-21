Return-Path: <linux-kernel+bounces-74076-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D6B0885CFAE
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 06:32:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 138A71C209E3
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 05:32:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA62239FC8;
	Wed, 21 Feb 2024 05:32:23 +0000 (UTC)
Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D40D22F0C;
	Wed, 21 Feb 2024 05:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.6.53.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708493543; cv=none; b=LwEFXRIFcSc/KMgZBtMLaBueb5jCXbL/mHem4biwxuBE2ovSBTYfBHUBOj6kohRffgqsnbztRqA0qHgBLByejSbpSE9DeKYFWrRvg+btD/YCgDFuJRzuePzXdF8m8QdLrPqgxMinJji+Txi8QSi533t27jaOLBF9XG2TXBzB5O0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708493543; c=relaxed/simple;
	bh=zvcvPUBtHMU0SFvQxH1roRSCnOnD9ot/WLPV0qFdLaM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EAYI3ll2DUL8I9CMHpX26pJAPZ5V/bpTk59VDfSuEHm7zjRhuShhhoFRvg143nxgD4nogU2vUNZIBfi3XojY98aBhDAIqCZynE4m7H+sjUtlDG46nAFcvBXh+16sU70lo/lHd0Tf96j+PVZ5z8/+l2HJc2kjEp4SChtfPW5bOwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; arc=none smtp.client-ip=144.6.53.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
	id 1rcfCr-00FwlR-24; Wed, 21 Feb 2024 13:31:46 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Wed, 21 Feb 2024 13:31:59 +0800
Date: Wed, 21 Feb 2024 13:31:59 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Barry Song <21cnbao@gmail.com>
Cc: akpm@linux-foundation.org, davem@davemloft.net, hannes@cmpxchg.org,
	linux-crypto@vger.kernel.org, linux-mm@kvack.org, nphamcs@gmail.com,
	yosryahmed@google.com, zhouchengming@bytedance.com,
	chriscli@google.com, chrisl@kernel.org, ddstreet@ieee.org,
	linux-kernel@vger.kernel.org, sjenning@redhat.com,
	vitaly.wool@konsulko.com, Barry Song <v-songbaohua@oppo.com>
Subject: Re: [PATCH v5 1/3] crypto: introduce: acomp_is_async to expose if
 comp drivers might sleep
Message-ID: <ZdWKz43tTz2XY4ca@gondor.apana.org.au>
References: <20240220064414.262582-1-21cnbao@gmail.com>
 <20240220064414.262582-2-21cnbao@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240220064414.262582-2-21cnbao@gmail.com>

On Tue, Feb 20, 2024 at 07:44:12PM +1300, Barry Song wrote:
> From: Barry Song <v-songbaohua@oppo.com>
> 
> acomp's users might want to know if acomp is really async to
> optimize themselves. One typical user which can benefit from
> exposed async stat is zswap.
> 
> In zswap, zsmalloc is the most commonly used allocator for
> (and perhaps the only one). For zsmalloc, we cannot sleep
> while we map the compressed memory, so we copy it to a
> temporary buffer. By knowing the alg won't sleep can help
> zswap to avoid the need for a buffer. This shows noticeable
> improvement in load/store latency of zswap.
> 
> Signed-off-by: Barry Song <v-songbaohua@oppo.com>
> ---
>  include/crypto/acompress.h | 6 ++++++
>  1 file changed, 6 insertions(+)

Acked-by: Herbert Xu <herbert@gondor.apana.org.au>

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

