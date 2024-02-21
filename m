Return-Path: <linux-kernel+bounces-74368-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 357DE85D321
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 10:12:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6647C1C22C00
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 09:12:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4CA93D96E;
	Wed, 21 Feb 2024 09:07:45 +0000 (UTC)
Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CBFF3C6B3;
	Wed, 21 Feb 2024 09:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.6.53.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708506465; cv=none; b=KI2I4bRh/z3Q7wniEjMtjb0w+I1d+PGvqlbwCP/PVGp7GLsn+5dpSczHt/q3HN2sP37LR+lx8K4XpL6FZX8ob1VfRCnhX45BsfaHdonOgp6xdZT3XHMS3M16Udyvvhiy7s5Oy7SCNZ0MILfxGkkKCtcrNBVW/KWGFxeplkmpq6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708506465; c=relaxed/simple;
	bh=Cw0vjSxZd4BozTwPlM6pL0uP35pHBxORm59HXV+iY1U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KGi0PGgmEmyTBH6kwXAk57nq8gXjHjC5mzPoclPoU9MvC0UfiZy1XEptk/mO9JjKdpAb5BesCBFrfVbQ6DnGSqqjbYvUXEHrJB2SF0vUGs4BWsbO9MIt80m2omvOf0Y+bKeKUBGMnVd8rxd0+gkBVqzKPg4HS+NmFAK6AkUQqe4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; arc=none smtp.client-ip=144.6.53.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
	id 1rciZd-00G0nc-TZ; Wed, 21 Feb 2024 17:07:30 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Wed, 21 Feb 2024 17:07:44 +0800
Date: Wed, 21 Feb 2024 17:07:44 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: syzbot <syzbot+b90b904ef6bdfdafec1d@syzkaller.appspotmail.com>
Cc: davem@davemloft.net, linux-crypto@vger.kernel.org,
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Subject: [PATCH] crypto: lskcipher - Copy IV in lskcipher glue code always
Message-ID: <ZdW9YBgTtaXo7DGQ@gondor.apana.org.au>
References: <00000000000097f7f90611d1370c@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <00000000000097f7f90611d1370c@google.com>

The lskcipher glue code for skcipher needs to copy the IV every
time rather than only on the first and last request.  Otherwise
those algorithms that use IV to perform chaining may break, e.g.,
CBC.

This is because crypto_skcipher_import/export do not include the
IV as part of the saved state.

Reported-by: syzbot+b90b904ef6bdfdafec1d@syzkaller.appspotmail.com
Fixes: 662ea18d089b ("crypto: skcipher - Make use of internal state")
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>

diff --git a/crypto/lskcipher.c b/crypto/lskcipher.c
index 0b6dd8aa21f2..0f1bd7dcde24 100644
--- a/crypto/lskcipher.c
+++ b/crypto/lskcipher.c
@@ -212,13 +212,12 @@ static int crypto_lskcipher_crypt_sg(struct skcipher_request *req,
 
 	ivsize = crypto_lskcipher_ivsize(tfm);
 	ivs = PTR_ALIGN(ivs, crypto_skcipher_alignmask(skcipher) + 1);
+	memcpy(ivs, req->iv, ivsize);
 
 	flags = req->base.flags & CRYPTO_TFM_REQ_MAY_SLEEP;
 
 	if (req->base.flags & CRYPTO_SKCIPHER_REQ_CONT)
 		flags |= CRYPTO_LSKCIPHER_FLAG_CONT;
-	else
-		memcpy(ivs, req->iv, ivsize);
 
 	if (!(req->base.flags & CRYPTO_SKCIPHER_REQ_NOTFINAL))
 		flags |= CRYPTO_LSKCIPHER_FLAG_FINAL;
@@ -234,8 +233,7 @@ static int crypto_lskcipher_crypt_sg(struct skcipher_request *req,
 		flags |= CRYPTO_LSKCIPHER_FLAG_CONT;
 	}
 
-	if (flags & CRYPTO_LSKCIPHER_FLAG_FINAL)
-		memcpy(req->iv, ivs, ivsize);
+	memcpy(req->iv, ivs, ivsize);
 
 	return err;
 }
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

