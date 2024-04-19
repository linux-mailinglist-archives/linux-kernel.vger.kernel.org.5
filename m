Return-Path: <linux-kernel+bounces-151337-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 058878AAD2A
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 12:59:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3ED58B2209A
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 10:59:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BFF68004B;
	Fri, 19 Apr 2024 10:59:05 +0000 (UTC)
Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 541677BAE5;
	Fri, 19 Apr 2024 10:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.6.53.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713524344; cv=none; b=NcMZSvWSb1BUNnYFZG/YrKv1tuI7D2NwUc0QXNrKJ3tA9jE3qzRjuTfe81uF+9N0eJhZF4sjKwav95E2KlP3dCXSqfrYEvsNYtvChjE5m14sew4R1cAZCSWgsP/xlFZRa3J4KRw4+rkK89sk8Oe4ocRz1B3k3FXnbT0i8A+sZWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713524344; c=relaxed/simple;
	bh=jwlmuSqSNqXwX8m6R2BV8Zy1F4p2DQDQfybZ+MCvIHg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=InHVRn6jc59VSyj7S3IgvQ4VcBg0NghrLk3lMPbyoSuPoNDYTQ+Z7Z7pIhdXSWGKHCCd5GUH+M9bP++4Sl4YJMlArlOUqA/sIJdfPttA0l1bCuy8TWdtRqOhFRpac3n7JVWar2ES/eOkbrvuPxFmgAwS9NuMThPdbT++h+37uBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; arc=none smtp.client-ip=144.6.53.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
	id 1rxlxJ-003sQx-MF; Fri, 19 Apr 2024 18:58:58 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Fri, 19 Apr 2024 18:59:15 +0800
Date: Fri, 19 Apr 2024 18:59:15 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Eric Biggers <ebiggers@kernel.org>
Cc: linux-crypto@vger.kernel.org, x86@kernel.org,
	linux-kernel@vger.kernel.org, chang.seok.bae@intel.com,
	stefan.kanthak@nexgo.de
Subject: Re: [PATCH] crypto: x86/aes-xts - access round keys using
 single-byte offsets
Message-ID: <ZiJOg9Z+ActP4u0E@gondor.apana.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240409000154.29799-1-ebiggers@kernel.org>
X-Newsgroups: apana.lists.os.linux.cryptoapi,apana.lists.os.linux.kernel

Eric Biggers <ebiggers@kernel.org> wrote:
> From: Eric Biggers <ebiggers@google.com>
> 
> Access the AES round keys using offsets -7*16 through 7*16, instead of
> 0*16 through 14*16.  This allows VEX-encoded instructions to address all
> round keys using 1-byte offsets, whereas before some needed 4-byte
> offsets.  This decreases the code size of aes-xts-avx-x86_64.o by 4.2%.
> 
> Signed-off-by: Eric Biggers <ebiggers@google.com>
> ---
> arch/x86/crypto/aes-xts-avx-x86_64.S | 81 +++++++++++++++-------------
> 1 file changed, 44 insertions(+), 37 deletions(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

