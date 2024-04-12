Return-Path: <linux-kernel+bounces-142153-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DF8728A282C
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 09:34:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1C2011C23C58
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 07:34:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E22BB4D9F0;
	Fri, 12 Apr 2024 07:34:03 +0000 (UTC)
Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFFD22C683;
	Fri, 12 Apr 2024 07:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.6.53.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712907243; cv=none; b=i1HYxDtkrwku6CRdhPKCyANpfCciw2lLONnvm9IhfOVZY+Dw2ndTI9k7SDbq+IhghYz+cAa73Up5sObmiIqkHV+WO7E6+k2ei/haGfMiXWKY1YtS29X2rZeIzQVhVhvh2ls9RkE0Z9q669flqiuj7N+uKu3fvLoG5C0gtPuA7b4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712907243; c=relaxed/simple;
	bh=GNZf4ZMmtPLFmZQP81XNKQV7onvRSXivTLOXU1L2RDA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=Konsr5N00Z3hapi9ldGlVAlOrVw9AzC6otxkvr/QtGDrEBuAzA6N9ado2uqWFOW3EdtGj/qn1NW9NcqD5NZC9e2U9012lsv9czritj+9FbGdB9E8eGshIUM9A/fRLHTOao0/KkAyZm7D6jHxW2+DDtwYR6ilVQWgC1WKXpQ9gD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; arc=none smtp.client-ip=144.6.53.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
	id 1rvBQ5-000lxK-JK; Fri, 12 Apr 2024 15:33:58 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Fri, 12 Apr 2024 15:34:15 +0800
Date: Fri, 12 Apr 2024 15:34:15 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Eric Biggers <ebiggers@kernel.org>
Cc: linux-crypto@vger.kernel.org, x86@kernel.org,
	linux-kernel@vger.kernel.org, ardb@kernel.org, luto@kernel.org,
	chang.seok.bae@intel.com
Subject: Re: [PATCH] crypto: x86/aes-xts - make non-AVX implementation use
 new glue code
Message-ID: <Zhjj97HevVmll+gz@gondor.apana.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240407212231.41781-1-ebiggers@kernel.org>
X-Newsgroups: apana.lists.os.linux.cryptoapi,apana.lists.os.linux.kernel

Eric Biggers <ebiggers@kernel.org> wrote:
> From: Eric Biggers <ebiggers@google.com>
> 
> Make the non-AVX implementation of AES-XTS (xts-aes-aesni) use the new
> glue code that was introduced for the AVX implementations of AES-XTS.
> This reduces code size, and it improves the performance of xts-aes-aesni
> due to the optimization for messages that don't span page boundaries.
> 
> This required moving the new glue functions higher up in the file and
> allowing the IV encryption function to be specified by the caller.
> 
> Signed-off-by: Eric Biggers <ebiggers@google.com>
> ---
> arch/x86/crypto/aes-xts-avx-x86_64.S |   2 +-
> arch/x86/crypto/aesni-intel_asm.S    |  16 +-
> arch/x86/crypto/aesni-intel_glue.c   | 317 +++++++++++----------------
> 3 files changed, 132 insertions(+), 203 deletions(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

