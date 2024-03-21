Return-Path: <linux-kernel+bounces-109869-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B60848856DB
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 10:55:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 50F251F240DD
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 09:55:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AE1154FAA;
	Thu, 21 Mar 2024 09:54:52 +0000 (UTC)
Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E62FF2A1C6;
	Thu, 21 Mar 2024 09:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.6.53.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711014892; cv=none; b=arvlyb+vLMtriH8C1NyuHKAerR6FmhKO8RQD8F7SRiT4e0u1ytTPVrj28hUHw7F9n5GyBRP+GVUE22/NsuVljM+jJuCDewkHuVkQeTFk1HMlOHriIuqAluWa0W1nhnhiz4h4+4U2V5edsZnHcr31LkImzU9DMkKv7bS7DgsfE4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711014892; c=relaxed/simple;
	bh=YNDfDBDwvH49zpBRMhXsnHAI/XLGH24RbzQx1/V7T18=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LM/LIDG1/vyIyEHVEs+aq/dYPvhmLzDTGj79huqxozSu8CekJVQRZqdHP26K78G1vmT/5QJ9UkbaslVWEajTgj87iFk5Mxo9JFnbZDienrRW+/ZI2gkE2hNxzbnC6zRa4PXmwwTJhyq+IXLfSIdhCDaB5XChCK6TQ+Tsj1hP3FM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; arc=none smtp.client-ip=144.6.53.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
	id 1rnF7z-00987R-QK; Thu, 21 Mar 2024 17:54:28 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Thu, 21 Mar 2024 17:54:44 +0800
Date: Thu, 21 Mar 2024 17:54:44 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Roman Smirnov <r.smirnov@omp.ru>
Cc: "David S. Miller" <davem@davemloft.net>,
	Sergey Shtylyov <s.shtylyov@omp.ru>,
	Karina Yankevich <k.yankevich@omp.ru>, linux-crypto@vger.kernel.org,
	linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org
Subject: Re: [PATCH] crypto: ecc: fix NULL pointer dereferencing in
 ecc_gen_privkey()
Message-ID: <ZfwD5EojMLYqBaid@gondor.apana.org.au>
References: <20240307071318.5206-1-r.smirnov@omp.ru>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240307071318.5206-1-r.smirnov@omp.ru>

On Thu, Mar 07, 2024 at 10:13:18AM +0300, Roman Smirnov wrote:
> ecc_get_curve() can return NULL. It is necessary to check
> for NULL before dereferencing.
> 
> Found by Linux Verification Center (linuxtesting.org) with Svace.
> 
> Signed-off-by: Roman Smirnov <r.smirnov@omp.ru>
> Reviewed-by: Sergey Shtylyov <s.shtylyov@omp.ru>
> ---
>  crypto/ecc.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)

Please point me to the exact code path where this can happen.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

