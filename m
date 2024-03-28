Return-Path: <linux-kernel+bounces-122805-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 995F088FD94
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 11:57:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3FECA29757D
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 10:57:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04C3F7D416;
	Thu, 28 Mar 2024 10:57:33 +0000 (UTC)
Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4797657A9;
	Thu, 28 Mar 2024 10:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.6.53.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711623452; cv=none; b=jmeIJy9CqxTIx8KHB39bcNMcFGUbN9d03RW1LOwg9Fe8YpOhQntHHTvDN0KSAeFVAFd5b29fegWw9O+PfDxQMeLFn4B0R+7PQZ9Rx/4KC1ij80BjwtDxw7P+qy5A38wgpyojZFeIlzn8B4Gzq0yZlgJPVG5aKdaX7y8ttK2bW3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711623452; c=relaxed/simple;
	bh=JFenx0tH3EH5g8x7Z2+LGn7i7pluO4hbZ0l7YkDg+eY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oXZUJtYHEiiztO/lVytC72xgr0KuQTqmrn/ZBeSd7njVFvMydpphme1AciC9ohgPc6FjgLTBjFkIS2xo2XkT/2dWUrK1saC24Mq5WUlpBZ1/ttyUikMrvFcbG2AfMyjZnY8xcGV/iZ2EG+VXxEOc8x2Bxh33m9JLUuWoBuz0t4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; arc=none smtp.client-ip=144.6.53.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
	id 1rpnRm-00C8W9-Jf; Thu, 28 Mar 2024 18:57:27 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Thu, 28 Mar 2024 18:57:43 +0800
Date: Thu, 28 Mar 2024 18:57:43 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: "Chang S. Bae" <chang.seok.bae@intel.com>
Cc: linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
	davem@davemloft.net, ebiggers@kernel.org, ardb@kernel.org,
	x86@kernel.org
Subject: Re: [PATCH v2 0/2] crypto: x86/aesni - Simplify AES key expansion
 code
Message-ID: <ZgVNJ+YASurGz1sB@gondor.apana.org.au>
References: <20240311213232.128240-1-chang.seok.bae@intel.com>
 <20240322230459.456606-1-chang.seok.bae@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240322230459.456606-1-chang.seok.bae@intel.com>

On Fri, Mar 22, 2024 at 04:04:57PM -0700, Chang S. Bae wrote:
> Previously, V1 [1] was posted to update the aesni_set_key() prototype to
> remove an unnecessary error code return type.
> 
> During the review process, it was discovered that both aes_expandkey()
> and the AES-NI glue code redundantly check the key size. V2 includes a
> cleanup to invoke aes_expandkey() immediately if AES-NI is unusable.
> 
> Thanks,
> Chang
> 
> [1]: https://lore.kernel.org/lkml/20240311213232.128240-1-chang.seok.bae@intel.com/
> 
> Chang S. Bae (2):
>   crypto: x86/aesni - Rearrange AES key size check
>   crypto: x86/aesni - Update aesni_set_key() to return void
> 
>  arch/x86/crypto/aesni-intel_asm.S  |  5 ++---
>  arch/x86/crypto/aesni-intel_glue.c | 24 +++++++++++-------------
>  2 files changed, 13 insertions(+), 16 deletions(-)
> 
> 
> base-commit: e8f897f4afef0031fe618a8e94127a0934896aba
> -- 
> 2.34.1

All applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

