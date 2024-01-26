Return-Path: <linux-kernel+bounces-39887-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7927983D72B
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 11:02:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E44E291A23
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 09:57:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E478060BAB;
	Fri, 26 Jan 2024 09:06:48 +0000 (UTC)
Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE5C860B90;
	Fri, 26 Jan 2024 09:06:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.6.53.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706260008; cv=none; b=nCJFaBYTpAiLqsiKsk5rjoLI0d92wMhbx7Q+EWG9WZ7GarBSWgmWZMfSK7ehyos2sBMPppcNavSI9Aze6yLT0ss7fiITDIB1DfkwLqncaQce3MnjuSMyz1BQVFeZibnpZTBcvXN2DIFvvK66N4AJQd4Ay7UFozu2wylcZ5nEiG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706260008; c=relaxed/simple;
	bh=FmZ7L70FxZzdqagdRT1MctQ8VKv5y9VO6LoUIfjlsTQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pT8I4HVCc8fBIywDamug1+mM3G5z8OfnRizdbNOx2FX0ydsh5RPxHpqBNY25FyF1y1r527gzwHmq5oQEaKW6j2MKF9crICKrkXNdUv4e3pxW6wnkdsQlLBLkWO6S/nxV9J0m+wSI+ocupGaQ3h0fKp2i1oGi5KPXJX1VhXg5dNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; arc=none smtp.client-ip=144.6.53.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
	id 1rTIAG-006Eu5-Mh; Fri, 26 Jan 2024 17:06:21 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Fri, 26 Jan 2024 17:06:33 +0800
Date: Fri, 26 Jan 2024 17:06:33 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Erick Archer <erick.archer@gmx.com>
Cc: Corentin Labbe <clabbe.montjoie@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Jonathan Corbet <corbet@lwn.net>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-crypto@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH] crypto: sun8i-ce - Use kcalloc() instead of kzalloc()
Message-ID: <ZbN2GfKU18pVEprw@gondor.apana.org.au>
References: <20240121153407.8348-1-erick.archer@gmx.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240121153407.8348-1-erick.archer@gmx.com>

On Sun, Jan 21, 2024 at 04:34:07PM +0100, Erick Archer wrote:
> As noted in the "Deprecated Interfaces, Language Features, Attributes,
> and Conventions" documentation [1], size calculations (especially
> multiplication) should not be performed in memory allocator (or similar)
> function arguments due to the risk of them overflowing. This could lead
> to values wrapping around and a smaller allocation being made than the
> caller was expecting. Using those allocations could lead to linear
> overflows of heap memory and other misbehaviors.
> 
> So, use the purpose specific kcalloc() function instead of the argument
> size * count in the kzalloc() function.
> 
> Link: https://www.kernel.org/doc/html/next/process/deprecated.html#open-coded-arithmetic-in-allocator-arguments [1]
> Link: https://github.com/KSPP/linux/issues/162
> Signed-off-by: Erick Archer <erick.archer@gmx.com>
> ---
>  drivers/crypto/allwinner/sun8i-ce/sun8i-ce-hash.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

