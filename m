Return-Path: <linux-kernel+bounces-142149-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A53E8A281E
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 09:32:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0F7DD1F2234D
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 07:32:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A160C4D9FB;
	Fri, 12 Apr 2024 07:31:45 +0000 (UTC)
Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 713721C6B6;
	Fri, 12 Apr 2024 07:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.6.53.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712907105; cv=none; b=Jbh4cH6WNSX51KdXqkIYl3Qx63hXnvptJfaFVLofdAIEoi/21fGHRsgArtym3zy9RSDpnheoCTuG051zQt/Pw6BJW7bP4eErMo5fAiMHBlaoUoxeV76iZ8CIk8u0mi/5Fw69MStptSDvIOMxhCJ4mi+OKShuQn54toeL73pyXTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712907105; c=relaxed/simple;
	bh=Ka9bocoV3z1Rqz9gdaa1Yi1ILRquOLH+4MaHJLVNmwE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cOCwf7gQ7ZOzByOR8D0eLdeZIOmuBASA5eMb7ghK41F0s2LoypTgpfqPbxUEczqEUHlUY8LKDIdbOtHrmHP+6vObVum5lGGeUnrW+BHxp35HOuKdOHoPz8L2SQorE36uE0l/gfaekdOcv64LQtYzZXUdgSk/+6WJphyIX0nitAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; arc=none smtp.client-ip=144.6.53.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
	id 1rvBNn-000lkG-GJ; Fri, 12 Apr 2024 15:31:36 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Fri, 12 Apr 2024 15:31:53 +0800
Date: Fri, 12 Apr 2024 15:31:53 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Stefan Berger <stefanb@linux.ibm.com>
Cc: keyrings@vger.kernel.org, linux-crypto@vger.kernel.org,
	davem@davemloft.net, linux-kernel@vger.kernel.org,
	saulo.alessandre@tse.jus.br, lukas@wunner.de, bbhushan2@marvell.com,
	jarkko@kernel.org
Subject: Re: [PATCH v8 00/13] Add support for NIST P521 to ecdsa
Message-ID: <ZhjjaTwo8dYFY6Ky@gondor.apana.org.au>
References: <20240404141856.2399142-1-stefanb@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240404141856.2399142-1-stefanb@linux.ibm.com>

On Thu, Apr 04, 2024 at 10:18:43AM -0400, Stefan Berger wrote:
> This series adds support for the NIST P521 curve to the ecdsa module
> to enable signature verification with it.
> 
> An issue with the current code in ecdsa is that it assumes that input
> arrays providing key coordinates for example, are arrays of digits
> (a 'digit' is a 'u64'). This works well for all currently supported
> curves, such as NIST P192/256/384, but does not work for NIST P521 where
> coordinates are 8 digits + 2 bytes long. So some of the changes deal with
> converting byte arrays to digits and adjusting tests on input byte
> array lengths to tolerate arrays not providing multiples of 8 bytes.
> 
> Regards,
>    Stefan
> 
> v8:
>  - Changed nbits from unsigned int to u32 (5/13)
>  - Added MODULE_ALIAS_CRYPTO("ecdsa-nist-p521") (11/13)
>  - Applied R-b & T-b tags from Jarkko
>  - Rebased on master branch at
>    https://git.kernel.org/pub/scm/linux/kernel/git/herbert/cryptodev-2.6.git
> 
> v7:
>  - Applied T-b tag from Christian to all patches
>  - Applied R-b tag from Jarkko to some patches
>  - Rephrased some patch descriptions per Jarkko's request
> 
> v6:
>  - Use existing #defines for number of digits rather than plain numbers
>    (1/13, 6/13) following Bharat's suggestion
>  - Initialize result from lowest 521 bits of product rather than going
>    through tmp variable (6/13)
> 
> v5:
>  - Simplified ecc_digits_from_bytes as suggested by Lukas (1/12)
>  - Using nbits == 521 to detect NIST P521 curve rather than strcmp()
>    (5,6/12)
>  - Nits in patch description and comments (11/12)
> 
> v4:
>  - Followed suggestions by Lukas Wummer (1,5,8/12)
>  - Use nbits rather than ndigits where needed (8/12)
>  - Renaming 'keylen' variablest to bufsize where necessary (9/12)
>  - Adjust signature size calculation for NIST P521 (11/12)
> 
> v3:
>  - Dropped ecdh support
>  - Use ecc_get_curve_nbits for getting number of bits in NIST P521 curve
>    in ecc_point_mult (7/10)
> 
> v2:
>  - Reformulated some patch descriptions
>  - Fixed issue detected by krobot
>  - Some other small changes to the code
> 
> 
> Stefan Berger (13):
>   crypto: ecc - Use ECC_CURVE_NIST_P192/256/384_DIGITS where possible
>   crypto: ecdsa - Convert byte arrays with key coordinates to digits
>   crypto: ecdsa - Adjust tests on length of key parameters
>   crypto: ecdsa - Extend res.x mod n calculation for NIST P521
>   crypto: ecc - Add nbits field to ecc_curve structure
>   crypto: ecc - Implement vli_mmod_fast_521 for NIST p521
>   crypto: ecc - Add special case for NIST P521 in ecc_point_mult
>   crypto: ecc - Add NIST P521 curve parameters
>   crypto: ecdsa - Replace ndigits with nbits where precision is needed
>   crypto: ecdsa - Rename keylen to bufsize where necessary
>   crypto: ecdsa - Register NIST P521 and extend test suite
>   crypto: asymmetric_keys - Adjust signature size calculation for NIST
>     P521
>   crypto: x509 - Add OID for NIST P521 and extend parser for it
> 
>  crypto/asymmetric_keys/public_key.c       |  14 ++-
>  crypto/asymmetric_keys/x509_cert_parser.c |   3 +
>  crypto/ecc.c                              |  44 +++++--
>  crypto/ecc_curve_defs.h                   |  49 ++++++++
>  crypto/ecdsa.c                            |  63 +++++++---
>  crypto/ecrdsa_defs.h                      |   5 +
>  crypto/testmgr.c                          |   7 ++
>  crypto/testmgr.h                          | 146 ++++++++++++++++++++++
>  include/crypto/ecc_curve.h                |   2 +
>  include/crypto/ecdh.h                     |   1 +
>  include/crypto/internal/ecc.h             |  24 +++-
>  include/linux/oid_registry.h              |   1 +
>  12 files changed, 336 insertions(+), 23 deletions(-)
> 
> 
> base-commit: a9a72140536fe02d98bce72a608ccf3ba9008a71
> -- 
> 2.43.0

All applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

