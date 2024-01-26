Return-Path: <linux-kernel+bounces-39874-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EDFE83D6E4
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 10:53:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 715D21C2E456
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 09:53:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 971DF5A79D;
	Fri, 26 Jan 2024 09:03:27 +0000 (UTC)
Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 476C85914E;
	Fri, 26 Jan 2024 09:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.6.53.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706259807; cv=none; b=ALLn/Tyyq789YzkG5bYXThhEs+GGJHnGuBiQLZGIZlflgpBh4a5NzUYkiW3mGCOVSTVdhsuWLE2YSqwlCnbaRjnpi4GcHV/FrC4mS6qRkyGIjtf9TpAqndBsDFUYdBIF1OghgdLOOl8HWtQcbXft1/urjLNdIj9pxRyW/V4Z18s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706259807; c=relaxed/simple;
	bh=az8KoYYHL54wFPBeGIuPLFmaIGFuIvOXDtCDBH93erk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VCJH6rMJoM1WQQxh0V9VPKTaaGXSQAkEJ7pcO8Mo8kIwfy2x93uKkZE3DCt7WJyZOCkhwkisggYQJnaZsKRyHMb9WSvH1F1LmOrZf+yW6bZQaf5qk116pljiuhzbMFt89KfropDKTcMX8tBC18SLq7jY0CWeT0L0PywQpqPk/kc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; arc=none smtp.client-ip=144.6.53.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
	id 1rTI7I-006EmX-WD; Fri, 26 Jan 2024 17:03:18 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Fri, 26 Jan 2024 17:03:29 +0800
Date: Fri, 26 Jan 2024 17:03:29 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Gaurav Jain <gaurav.jain@nxp.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Eric Biggers <ebiggers@google.com>,
	Horia Geanta <horia.geanta@nxp.com>,
	Pankaj Gupta <pankaj.gupta@nxp.com>, Varun Sethi <V.Sethi@nxp.com>,
	Meenakshi Aggarwal <meenakshi.aggarwal@nxp.com>,
	Aisheng Dong <aisheng.dong@nxp.com>,
	Silvano Di Ninno <silvano.dininno@nxp.com>,
	linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-imx@nxp.com
Subject: Re: [PATCH v2] crypto: caam: fix asynchronous hash
Message-ID: <ZbN1YRJnrml3IU8o@gondor.apana.org.au>
References: <20240118092557.1891120-1-gaurav.jain@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240118092557.1891120-1-gaurav.jain@nxp.com>

On Thu, Jan 18, 2024 at 02:55:57PM +0530, Gaurav Jain wrote:
> ahash_alg->setkey is updated to ahash_nosetkey in ahash.c
> so checking setkey() function to determine hmac algorithm is not valid.
> 
> to fix this added is_hmac variable in structure caam_hash_alg to determine
> whether the algorithm is hmac or not.
> 
> Fixes: 2f1f34c1bf7b ("crypto: ahash - optimize performance when wrapping shash")
> Signed-off-by: Gaurav Jain <gaurav.jain@nxp.com>
> ---
> changes in v2:
> 	- remove if condition based on crypto_hash_alg_has_setkey() funcion.
> 	- added is_hmac variable in caam_hash_alg and updated the if
> 	  condition for checking hmac algorithm.
> 
>  drivers/crypto/caam/caamalg_qi2.c | 7 +++++--
>  drivers/crypto/caam/caamhash.c    | 7 +++++--
>  2 files changed, 10 insertions(+), 4 deletions(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

