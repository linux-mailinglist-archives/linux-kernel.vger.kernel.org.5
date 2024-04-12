Return-Path: <linux-kernel+bounces-142144-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7DA88A280A
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 09:30:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7398E2852AE
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 07:30:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 170BC4D595;
	Fri, 12 Apr 2024 07:30:39 +0000 (UTC)
Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 321612C683;
	Fri, 12 Apr 2024 07:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.6.53.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712907038; cv=none; b=fZ8t7oYsZc+l/OW27QCRx+H3F7qqC1hP9zoaCpa4Z4y9oF2Lfvje7nWoyejjMULDBLCurBTPF+QJAwiKRHpjsKExBJOrWsggT+zbEb0n1dzMipxJMCmL5GqNVclBLFvG/15gy0IizBexzusI5BA+iNNluq0EpWJ0R/n7g5NnLOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712907038; c=relaxed/simple;
	bh=+dPppAY5oVrd+V2xX2+vY7Pkto4QZ8YxijijuiM5RLA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nVkdAM8RMHc8S7/owiJeKrmUQ9LGjIJH1Cm6nIUxQqxh17pG1grB2TZPXm0QkUmig+RkNE5ZwHUGA1GcmurNJ9WJlVcY6JiMT7Ke5tEriO8iWh1uujboFh6ZHzu09FBYwoFYdL1APYaQ8H1ViypfbLkZVRMXcsPeMzW/+vWsaGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; arc=none smtp.client-ip=144.6.53.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
	id 1rvBMZ-000lfd-7v; Fri, 12 Apr 2024 15:30:20 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Fri, 12 Apr 2024 15:30:36 +0800
Date: Fri, 12 Apr 2024 15:30:36 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Arnd Bergmann <arnd@kernel.org>
Cc: linux-kernel@vger.kernel.org, Tom Lendacky <thomas.lendacky@amd.com>,
	John Allen <john.allen@amd.com>,
	"David S. Miller" <davem@davemloft.net>,
	Arnd Bergmann <arnd@arndb.de>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>,
	linux-crypto@vger.kernel.org
Subject: Re: [PATCH 24/34] crypto: ccp - drop platform ifdef checks
Message-ID: <ZhjjHDzlq3Kt69MQ@gondor.apana.org.au>
References: <20240403080702.3509288-1-arnd@kernel.org>
 <20240403080702.3509288-25-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240403080702.3509288-25-arnd@kernel.org>

On Wed, Apr 03, 2024 at 10:06:42AM +0200, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> When both ACPI and OF are disabled, the dev_vdata variable is unused:
> 
> drivers/crypto/ccp/sp-platform.c:33:34: error: unused variable 'dev_vdata' [-Werror,-Wunused-const-variable]
> 
> This is not a useful configuration, and there is not much point in saving
> a few bytes when only one of the two is enabled, so just remove all
> these ifdef checks and rely on of_match_node() and acpi_match_device()
> returning NULL when these subsystems are disabled.
> 
> Fixes: 6c5063434098 ("crypto: ccp - Add ACPI support")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/crypto/ccp/sp-platform.c | 14 ++------------
>  1 file changed, 2 insertions(+), 12 deletions(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

