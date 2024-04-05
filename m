Return-Path: <linux-kernel+bounces-132609-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 38F3F899738
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 09:58:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E3E831F2194B
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 07:58:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75AB1143862;
	Fri,  5 Apr 2024 07:57:51 +0000 (UTC)
Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4503514291D;
	Fri,  5 Apr 2024 07:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.6.53.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712303871; cv=none; b=D99VpamlfObRhPL5M74YAl8J+hgPT972BXmezN4DO6nIvrmWRblOPTrp32w9cz1IHo9Y60wyF2czySQnkhqMHEqIFLt2ApuFTQ9TvmY/ZfimtnQpmnK71VGC/cQWxYWqvg199H9oka2Jiu4XoltZB/3QpYTAJBJO/NSJoWdA95A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712303871; c=relaxed/simple;
	bh=mxCQfRzszfWYnwK4g0fSWiEg42A5tFJ0IhDbUgekfjo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=lbJFWFCE4CC8sG2GwLfdGs3onIaPfic5GZVPcD4Mt+9nr3816rz8tSt9re397vSq7Sl/a+WHYwHyuWy7x8Jx/sctHbMlRxLzTPmVtz+PC2MnwA/4QpJXsWorSHLt3TSoi4PGWAeHdNjsVeL5og2bBQzuS5SwV2Y6VbU5ye/D7o8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; arc=none smtp.client-ip=144.6.53.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
	id 1rseSH-00FUEJ-3o; Fri, 05 Apr 2024 15:57:46 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Fri, 05 Apr 2024 15:58:02 +0800
Date: Fri, 5 Apr 2024 15:58:02 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Eric Biggers <ebiggers@kernel.org>
Cc: linux-crypto@vger.kernel.org, x86@kernel.org,
	linux-kernel@vger.kernel.org, ardb@kernel.org, luto@kernel.org,
	chang.seok.bae@intel.com
Subject: Re: [PATCH 0/6] Faster AES-XTS on modern x86_64 CPUs
Message-ID: <Zg+vCsQ++CVJ5m3Y@gondor.apana.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240326080305.402382-1-ebiggers@kernel.org>
X-Newsgroups: apana.lists.os.linux.cryptoapi,apana.lists.os.linux.kernel

Eric Biggers <ebiggers@kernel.org> wrote:
> This patchset adds new AES-XTS implementations that accelerate disk and
> file encryption on modern x86_64 CPUs.
> 
> The largest improvements are seen on CPUs that support the VAES
> extension: Intel Ice Lake (2019) and later, and AMD Zen 3 (2020) and
> later.  However, an implementation using plain AESNI + AVX is also added
> and provides a small boost on older CPUs too.
> 
> To try to handle the mess that is x86 SIMD, the code for all the new
> AES-XTS implementations is generated from an assembly macro.  This makes
> it so that we e.g. don't have to have entirely different source code
> just for different vector lengths (xmm, ymm, zmm).
> 
> To avoid downclocking effects, zmm registers aren't used on certain
> Intel CPU models such as Ice Lake.  These CPU models default to an
> implementation using ymm registers instead.
> 
> This patchset increases the throughput of AES-256-XTS decryption by the
> following amounts on the following CPUs:
>                            
>                          | 4096-byte messages | 512-byte messages |
>    ----------------------+--------------------+-------------------+
>    Intel Skylake         |        1%          |       11%         |
>    Intel Ice Lake        |        92%         |       59%         |
>    Intel Sapphire Rapids |       115%         |       78%         |
>    AMD Zen 1             |        25%         |       20%         |
>    AMD Zen 2             |        26%         |       20%         |
>    AMD Zen 3             |        82%         |       40%         |
>    AMD Zen 4             |       118%         |       48%         |
> 
> (The results for encryption are very similar to decryption.  I just tend
> to measure decryption because decryption performance is more important.)
> 
> There's no separate kconfig option for the new AES-XTS implementations,
> as they are included in the existing option CONFIG_CRYPTO_AES_NI_INTEL.
> 
> To make testing easier, all four new AES-XTS implementations are
> registered separately with the crypto API.  They are prioritized
> appropriately so that the best one for the CPU is used by default.
> 
> Open questions:
> 
> - Is the policy that I implemented for preferring ymm registers to zmm
>  registers the right one?  arch/x86/crypto/poly1305_glue.c thinks that
>  only Skylake has the bad downclocking.  My current proposal is a bit
>  more conservative; it also excludes Ice Lake and Tiger Lake.  Those
>  CPUs supposedly still have some downclocking, though not as much.
> 
> - Should the policy on the use of zmm registers be in a centralized
>  place?  It probably doesn't make sense to have random different
>  policies for different crypto algorithms (AES, Poly1305, ARIA, etc.).
> 
> - Are there any other known issues with using AVX512 in kernel mode?  It
>  seems to work, and technically it's not new because Poly1305 and ARIA
>  already use AVX512, including the mask registers and zmm registers up
>  to 31.  So if there was a major issue, like the new registers not
>  being properly saved and restored, it probably would have already been
>  found.  But AES-XTS support would introduce a wider use of it.
> 
> Eric Biggers (6):
>  x86: add kconfig symbols for assembler VAES and VPCLMULQDQ support
>  crypto: x86/aes-xts - add AES-XTS assembly macro for modern CPUs
>  crypto: x86/aes-xts - wire up AESNI + AVX implementation
>  crypto: x86/aes-xts - wire up VAES + AVX2 implementation
>  crypto: x86/aes-xts - wire up VAES + AVX10/256 implementation
>  crypto: x86/aes-xts - wire up VAES + AVX10/512 implementation
> 
> arch/x86/Kconfig.assembler           |  10 +
> arch/x86/crypto/Makefile             |   3 +-
> arch/x86/crypto/aes-xts-avx-x86_64.S | 796 +++++++++++++++++++++++++++
> arch/x86/crypto/aesni-intel_glue.c   | 263 ++++++++-
> 4 files changed, 1070 insertions(+), 2 deletions(-)
> create mode 100644 arch/x86/crypto/aes-xts-avx-x86_64.S
> 
> 
> base-commit: 4cece764965020c22cff7665b18a012006359095

All applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

