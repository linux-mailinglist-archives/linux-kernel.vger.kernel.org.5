Return-Path: <linux-kernel+bounces-16195-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 47875823A78
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 03:03:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D60CB1F262CC
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 02:03:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C1CC1FB4;
	Thu,  4 Jan 2024 02:03:12 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26828185B;
	Thu,  4 Jan 2024 02:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
	id 1rLD4Q-00GebV-PX; Thu, 04 Jan 2024 10:02:55 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Thu, 04 Jan 2024 10:03:06 +0800
Date: Thu, 4 Jan 2024 10:03:06 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: David Howells <dhowells@redhat.com>
Cc: Shigeru Yoshida <syoshida@redhat.com>, davem@davemloft.net,
	linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] crypto: af_alg/hash: Fix uninit-value access in
 af_alg_free_sg()
Message-ID: <ZZYR2qcc2Fmaxqq0@gondor.apana.org.au>
References: <ZYUFs1MumRFf3mnv@gondor.apana.org.au>
 <20231211135949.689204-1-syoshida@redhat.com>
 <386306.1704296211@warthog.procyon.org.uk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <386306.1704296211@warthog.procyon.org.uk>

On Wed, Jan 03, 2024 at 03:36:51PM +0000, David Howells wrote:
> Hmmm...  Is that going to get you a potential memory leak?
> 
> ctx->sgl.sgt.sgl could (in theory) point to an allocated table.  I guess that
> would be cleaned up by af_alg_free_areq_sgls(), so there's probably no leak
> there.

The SG list is only setup in this function, and gets freed before
we return.  There should be no SG list on entry.  It's only because
you added the special case for a zero-length hash that we hit the
bogus free.  So we should fix this by not freeing the SG list in
the zero-length case, as it was never allocated.

> OTOH, af_alg_free_areq_sgls() is going to call af_alg_free_sg(), so maybe we
> want to initialise sgl->sgt.sgl to NULL as well.

That has nothing to do with this.  This SG list is specific to
algif_hash and has nothing to do with the shared SG list used
by aead and skcipher.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

