Return-Path: <linux-kernel+bounces-151346-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 12E478AAD45
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 13:04:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C28E0282DDE
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 11:04:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BDEA8061D;
	Fri, 19 Apr 2024 11:04:21 +0000 (UTC)
Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09D508005E;
	Fri, 19 Apr 2024 11:04:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.6.53.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713524661; cv=none; b=heWFUISITUPfnYbw57mJBSxISjbGRKWivMMomSV5meVWRqVV5h4vEfLiah2Rtq8H/Q9wYbIOp6PGDxKG8kOhqspK01VrEs9kgqi8oKQfOkRn/8vTbk64g67Tx6eqOFZ/jAjMryCU4pTxsb/DLRvh44HQG4VEyfeSwS7se+oqX9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713524661; c=relaxed/simple;
	bh=0yhk0PH7gzpnbmxZQwhxskyGfXkQgNrt8p5cptGxQ7s=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=b3ivbc35jKxeNVg2nWgitCNnMKz1lwMB6tyYTNaf6NfU1Z+Ao1bZXE26sDmSL+NJxchZDzrBEj7vyiIFbCwXnEZ4TVWYNFouey8zo/hG7aaowedbfo51WKXB4zXJXJukcLVyVD7+wDwRD+6wbJBZVP0nvOsjh5RDfKO7vl2ikPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; arc=none smtp.client-ip=144.6.53.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
	id 1rxm2Q-003sbz-Sg; Fri, 19 Apr 2024 19:04:15 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Fri, 19 Apr 2024 19:04:32 +0800
Date: Fri, 19 Apr 2024 19:04:32 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Eric Biggers <ebiggers@kernel.org>
Cc: linux-crypto@vger.kernel.org, x86@kernel.org,
	linux-kernel@vger.kernel.org, chang.seok.bae@intel.com
Subject: Re: [PATCH] crypto: x86/aesni-xts - deduplicate aesni_xts_enc() and
 aesni_xts_dec()
Message-ID: <ZiJPwLN6yZPVOxm4@gondor.apana.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240413000947.67988-1-ebiggers@kernel.org>
X-Newsgroups: apana.lists.os.linux.cryptoapi,apana.lists.os.linux.kernel

Eric Biggers <ebiggers@kernel.org> wrote:
> From: Eric Biggers <ebiggers@google.com>
> 
> Since aesni_xts_enc() and aesni_xts_dec() are very similar, generate
> them from a macro that's passed an argument enc=1 or enc=0.  This
> reduces the length of aesni-intel_asm.S by 112 lines while still
> producing the exact same object file in both 32-bit and 64-bit mode.
> 
> Signed-off-by: Eric Biggers <ebiggers@google.com>
> ---
> arch/x86/crypto/aesni-intel_asm.S | 270 +++++++++---------------------
> 1 file changed, 79 insertions(+), 191 deletions(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

