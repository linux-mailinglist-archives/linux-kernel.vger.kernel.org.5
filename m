Return-Path: <linux-kernel+bounces-142137-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 828218A27FA
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 09:27:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 987621C22958
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 07:27:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCEA24C3C3;
	Fri, 12 Apr 2024 07:27:31 +0000 (UTC)
Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48A15481AB;
	Fri, 12 Apr 2024 07:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.6.53.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712906851; cv=none; b=oHMRbdQe4KxjT3Q9PPP1vjGMcR8Ac9C/mi9zNJYc9oAGZQxhzkpNs7Oj3lETeynRBjif8uOtMYpBG8mBzFtRRa6Di/uAk7xGY/qoQthz5pij1S69Hh/CQfOi6q84O/ZsV1IpZRsII9sp9f3uQ0JElTk9AXRcfZey9NNfRU7q80s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712906851; c=relaxed/simple;
	bh=l2BGLiuJGHHWG/G6qEjSB1ceFBeBSLwtH1M1QxOBe5w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lOLzG62+kxGbB6KzKWs+0EokFPmfgct7ceiK2N9al1YQwnVFKpUFVT6ltzYjqvHBw5/Fxa/VDi5vQfIOJkK9Sz43q4gyAy9Y7f1fXo40JKgF52nSIyaqpP7hza/yyPQvHUPNBrril+gOXPkZ1bmQx4llzEAHGppjCsq80eAC7+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; arc=none smtp.client-ip=144.6.53.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
	id 1rvBJi-000lZc-1y; Fri, 12 Apr 2024 15:27:23 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Fri, 12 Apr 2024 15:27:39 +0800
Date: Fri, 12 Apr 2024 15:27:39 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Roman Smirnov <r.smirnov@omp.ru>
Cc: "David S. Miller" <davem@davemloft.net>, linux-crypto@vger.kernel.org,
	linux-kernel@vger.kernel.org, Sergey Shtylyov <s.shtylyov@omp.ru>
Subject: Re: [PATCH] crypto: ecc: remove checks in
 crypto_ecdh_shared_secret() and ecc_make_pub_key()
Message-ID: <Zhjia82Bl+gaGHym@gondor.apana.org.au>
References: <20240401121623.110263-1-r.smirnov@omp.ru>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240401121623.110263-1-r.smirnov@omp.ru>

On Mon, Apr 01, 2024 at 03:16:23PM +0300, Roman Smirnov wrote:
> With the current state of the code, ecc_get_curve() cannot return
> NULL in crypto_ecdh_shared_secret() and ecc_make_pub_key(). This is
> conditioned by the fact that they are only called from ecdh_compute_value(),
> which implements the kpp_alg::{generate_public_key,compute_shared_secret}()
> methods. Also ecdh implements the kpp_alg::init() method, which is called
> before the other methods and sets ecdh_ctx::curve_id to a valid value.
> 
> Signed-off-by: Roman Smirnov <r.smirnov@omp.ru>
> Reviewed-by: Sergey Shtylyov <s.shtylyov@omp.ru>
> ---
>  crypto/ecc.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

