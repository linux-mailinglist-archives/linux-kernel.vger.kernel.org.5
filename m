Return-Path: <linux-kernel+bounces-159793-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 266B78B341E
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 11:34:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D06821F23449
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 09:34:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F019A140387;
	Fri, 26 Apr 2024 09:33:46 +0000 (UTC)
Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03DF17EF;
	Fri, 26 Apr 2024 09:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.6.53.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714124026; cv=none; b=Ydy3GhFXOja5kvnFH6wk3yhTaMJFWZC8tTxoyjYvKXVX1eY5pW1VMTIi/+3YknAhZMHv5JRVMIleREP7lHbHh9fyITGUwkR3af1m2cUQFcXqWigY/UoDx+06YwrdRW9uTxQRXV6mWAIFcFhdpaChA9JYV049/rhcy0VKmd65ed0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714124026; c=relaxed/simple;
	bh=KtdZRT0AgIFuzw20NQYONI1ukZmIKXfG2gF/BlqBVcg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KFM2Kd9eFZVZZ35iqBCZZiaJecbruU4UrJKVMdPWuJ4r/cfzKv9WT709xl6pFnPa0yobVI+vgYiyijPoOzUzZrBQjvBXJsdQ2o1H8PSDN8czjI7cPRmTSvj7L3qyXrK6SHW2rahif3U1j8OgmjLHUOrJDrO42ostrI2/gtZoSk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; arc=none smtp.client-ip=144.6.53.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
	id 1s0HxZ-006eRA-EA; Fri, 26 Apr 2024 17:33:38 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Fri, 26 Apr 2024 17:33:55 +0800
Date: Fri, 26 Apr 2024 17:33:55 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Stefan Berger <stefanb@linux.ibm.com>
Cc: linux-crypto@vger.kernel.org, davem@davemloft.net,
	linux-kernel@vger.kernel.org, jarkko@kernel.org, ardb@kernel.org,
	git@jvdsn.com, hkario@redhat.com, simo@redhat.com
Subject: Re: [PATCH v3 0/2] crypto: ecdh & ecc: Fix private key byte ordering
 issues
Message-ID: <Zit1AwnkuuPZcwol@gondor.apana.org.au>
References: <20240418152445.2773042-1-stefanb@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240418152445.2773042-1-stefanb@linux.ibm.com>

On Thu, Apr 18, 2024 at 11:24:43AM -0400, Stefan Berger wrote:
> The 1st patch fixes a byte ordering issue where ctx->private_key is
> currently passed to ecc_is_key_valid but the key is in reverse byte order.
> To solve this issue it introduces the variable 'priv', that is already used
> throughout the ecc and ecdh code bases for a private key in proper byte
> order, and calls ecc_is_key_valid with 'priv'. Note that ecc_gen_privkey
> also calls __ecc_is_key_valid with 'priv' already.
> 
> The 2nd patch gets rid of the 'priv' variable wherever it is used to hold
> a private key (byte-swapped initialized from ctx->private_key) in proper
> byte order and uses ctx->private_key directly that is now initialized in
> proper byte order.
> 
> Regards,
>   Stefan
> 
> v3:
>   - Added Jarkko's A-b tag
>   - Expanded on the description of changes to ecc_gen_privkey (2/2)
> 
> v2:
>   - Added missing zeroizing of priv variable (1/2)
>   - Improved patch description (2/2)
> 
> 
> 
> 
> Stefan Berger (2):
>   crypto: ecdh - Pass private key in proper byte order to check valid
>     key
>   crypto: ecdh & ecc - Initialize ctx->private_key in proper byte order
> 
>  crypto/ecc.c                  | 29 ++++++++++-------------------
>  crypto/ecdh.c                 |  9 ++++++---
>  include/crypto/internal/ecc.h |  3 ++-
>  3 files changed, 18 insertions(+), 23 deletions(-)
> 
> -- 
> 2.43.0

All applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

