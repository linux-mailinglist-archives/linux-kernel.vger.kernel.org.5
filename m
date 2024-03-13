Return-Path: <linux-kernel+bounces-101031-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DA9B787A0E7
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 02:44:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8CD311F21E9D
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 01:44:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7ADC3DF5A;
	Wed, 13 Mar 2024 01:44:01 +0000 (UTC)
Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AFADC127;
	Wed, 13 Mar 2024 01:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.6.53.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710294241; cv=none; b=gZ18UzDUJ0+QHT8dkmX0/qB23C6KpYXaHsX1R96Xw4jK13XZ3juLCgXYcVP/6Sl3qayvXA6vAc8VYHemc3573ObS8GqOdZJ7708lcdkhUBMivhU4KKROQ8QrV3H49+z/bgKwu7X6m8mRsdm0dAP0Bvd5C01BP1Qlcvix2mZ66mA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710294241; c=relaxed/simple;
	bh=f7yeVm+tvDwFwJCsglHSXT9pWsTcMAgHglOAr1Fgorw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZnjvRwwxdSF6Cssn388MDHGNOxRjpOFeC2peakSGrcYru6nMAhqoIgEJtOvSGO85GjAeFTK6Jsa0qmaZGb3V8vk3qS6QRl8RmHBl6dqQ85oi9m6fYBCPaP0G7INeMlNUYpcXBeewmCSDAEwzFjQB1bCGj+owXJX3pmrCjxbTMOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; arc=none smtp.client-ip=144.6.53.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
	id 1rkDea-006L2A-5j; Wed, 13 Mar 2024 09:43:37 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Wed, 13 Mar 2024 09:43:52 +0800
Date: Wed, 13 Mar 2024 09:43:52 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Eric Biggers <ebiggers@google.com>,
	Barry Song <v-songbaohua@oppo.com>,
	Linux Crypto List <linux-crypto@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the crypto tree
Message-ID: <ZfEE2GDznBOZDXs4@gondor.apana.org.au>
References: <20240313115751.36b01158@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240313115751.36b01158@canb.auug.org.au>

On Wed, Mar 13, 2024 at 11:57:51AM +1100, Stephen Rothwell wrote:
> Hi all,
> 
> After merging the crypto tree, today's linux-next build (powerpc
> ppc64_defconfig) failed like this:
> 
> In file included from mm/zswap.c:30:
> include/crypto/acompress.h: In function 'acomp_is_async':
> include/crypto/acompress.h:124:16: error: implicit declaration of function 'crypto_comp_alg_common'; did you mean 'crypto_tfm_alg_name'? [-Werror=implicit-function-declaration]
>   124 |         return crypto_comp_alg_common(tfm)->base.cra_flags &
>       |                ^~~~~~~~~~~~~~~~~~~~~~
>       |                crypto_tfm_alg_name
> include/crypto/acompress.h:124:43: error: invalid type argument of '->' (have 'int')
>   124 |         return crypto_comp_alg_common(tfm)->base.cra_flags &
>       |                                           ^~
> include/crypto/acompress.h:126:1: error: control reaches end of non-void function [-Werror=return-type]
>   126 | }
>       | ^
> cc1: some warnings being treated as errors
> 
> Caused by commit
> 
>   86464db929ca ("crypto: introduce: acomp_is_async to expose if comp drivers might sleep")

Instead of using the non-existent crypto_comp_alg_common, it
should do something like

		return crypto_acomp_tfm(tfm)->__crt_alg->cra_flags & ...

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

