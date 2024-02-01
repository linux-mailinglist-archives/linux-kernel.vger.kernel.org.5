Return-Path: <linux-kernel+bounces-47667-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0926C8450FB
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 06:49:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8E5F0B2511C
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 05:49:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3A7D762D6;
	Thu,  1 Feb 2024 05:49:08 +0000 (UTC)
Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B89A612EA;
	Thu,  1 Feb 2024 05:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.6.53.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706766548; cv=none; b=l1x230ku1eUCy5dsZyD6Q8+6tNzYjAq4jrSIgCx3e0Fbm8HNwry2eDh9I9+GDuC6X1rVeFFxniFJtR1OKUMk5/AEzpjm1fhq2sun1azV1jAqd8P7vx5AWHBVvMJ15OjoHv6nVrEC5tJq5otZEY23pvbbJoJZvPHEDttH4pd1Lsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706766548; c=relaxed/simple;
	bh=g+miW4xaziDnTHMMQnZVcFcFV04N5hZMmlNvrm0fOdQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y+WBvjDxzljsInXn1WmsNSYnXteJ7ZVEmGi9Guh0AqrvR5DRE34Llqc8iaxhCVxJTbg+lfG7T/Oq8vWlSwlFWp9j72b4/YkXze6QO2EbC6p9aVPcMhsobYrIk/EzhF2wS0qsdoL6d780LvmIvj0RVLckLl1IaS5FZ+miov/5DCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; arc=none smtp.client-ip=144.6.53.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
	id 1rVPwV-008UXG-RV; Thu, 01 Feb 2024 13:48:56 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Thu, 01 Feb 2024 13:49:09 +0800
Date: Thu, 1 Feb 2024 13:49:09 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: xingwei lee <xrivendell7@gmail.com>
Cc: syzbot+3266db0c26d1fbbe3abb@syzkaller.appspotmail.com,
	davem@davemloft.net, linux-crypto@vger.kernel.org,
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Subject: [PATCH] crypto: algif_hash - Remove bogus SGL free on zero-length
 error path
Message-ID: <Zbsw1WDUg8mJ5s9e@gondor.apana.org.au>
References: <CABOYnLx_8_TpFHS-nkrvF5dG_Ev6tgMi1dj_+4sSydM1wmD1XA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABOYnLx_8_TpFHS-nkrvF5dG_Ev6tgMi1dj_+4sSydM1wmD1XA@mail.gmail.com>

On Fri, Jan 26, 2024 at 09:11:39PM +0800, xingwei lee wrote:
> This bug is the same bug that is mentioned in
> https://lore.kernel.org/all/20231211135949.689204-1-syoshida@redhat.com/.
> And I also reproduced it with repro.c in
> https://lore.kernel.org/all/CABOYnLxaHBEaSRaEU+kDsHF8a=9AokO1ZUEVtpeT9ddL8giw3A@mail.gmail.com/
> also see in https://gist.github.com/xrivendell7/b10745f297bd2d12a2e48155920996d2
> and also a simple root cause analysis.

Thanks for the reminder.  I was waiting for an updated patch but
I'll apply the following instead:

---8<---
When a zero-length message is hashed by algif_hash, and an error
is triggered, it tries to free an SG list that was never allocated
in the first place.  Fix this by not freeing the SG list on the
zero-length error path.

Reported-by: Shigeru Yoshida <syoshida@redhat.com>
Reported-by: xingwei lee <xrivendell7@gmail.com>
Fixes: b6d972f68983 ("crypto: af_alg/hash: Fix recvmsg() after sendmsg(MSG_MORE)")
Cc: <stable@vger.kernel.org>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>

diff --git a/crypto/algif_hash.c b/crypto/algif_hash.c
index 82c44d4899b9..e24c829d7a01 100644
--- a/crypto/algif_hash.c
+++ b/crypto/algif_hash.c
@@ -91,13 +91,13 @@ static int hash_sendmsg(struct socket *sock, struct msghdr *msg,
 		if (!(msg->msg_flags & MSG_MORE)) {
 			err = hash_alloc_result(sk, ctx);
 			if (err)
-				goto unlock_free;
+				goto unlock_free_result;
 			ahash_request_set_crypt(&ctx->req, NULL,
 						ctx->result, 0);
 			err = crypto_wait_req(crypto_ahash_final(&ctx->req),
 					      &ctx->wait);
 			if (err)
-				goto unlock_free;
+				goto unlock_free_result;
 		}
 		goto done_more;
 	}
@@ -170,6 +170,7 @@ static int hash_sendmsg(struct socket *sock, struct msghdr *msg,
 
 unlock_free:
 	af_alg_free_sg(&ctx->sgl);
+unlock_free_result:
 	hash_free_result(sk, ctx);
 	ctx->more = false;
 	goto unlock;
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

