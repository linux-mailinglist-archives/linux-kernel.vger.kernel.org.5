Return-Path: <linux-kernel+bounces-74370-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 62DE685D324
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 10:12:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F17221F223B5
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 09:12:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCEDB3DBBC;
	Wed, 21 Feb 2024 09:10:43 +0000 (UTC)
Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BED443DB92;
	Wed, 21 Feb 2024 09:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.6.53.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708506643; cv=none; b=RrUVba2Vr7YGSf7/qgMgEdfVwt3QUVz4U3wsYLfYDgxbHV2EWlu5CMnrcNd/bZPlCag5UuevCFGEOo3x/E5cLre7vNvAfnCwP9Xw8WIRM6f3C6jLhPBNgiOzKWjpdNjC3mWp3Ip8i2e+K0jVsf6ikptZQr1sAIfVr2nEkJeCgOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708506643; c=relaxed/simple;
	bh=KjpoedeNb7Zngx+JZi7/7eN5vwhr8MINxhAkzC2Vi/M=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IdVs0MJnSGjHELBf94a5l0Pq1FIFqSSmlMZFu0DUG/z1UDEDfNsfKm1SzJ4qm0Bm9ld0AEhMiYoSC1JqzqiRlSHgRrLZ10uVUbs+glx7AKwxiBIy/SfOgmK5XJ5EIeRhC4R2InpNqYe/58BJFAPV+xfe1LhGdS+rEG3+H5rGnyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; arc=none smtp.client-ip=144.6.53.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
	id 1rcicb-00G0sb-La; Wed, 21 Feb 2024 17:10:34 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Wed, 21 Feb 2024 17:10:48 +0800
Date: Wed, 21 Feb 2024 17:10:48 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Linus Torvalds <torvalds@linux-foundation.org>,
	"David S. Miller" <davem@davemloft.net>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Crypto Mailing List <linux-crypto@vger.kernel.org>
Subject: [GIT PULL] Crypto Fixes for 6.8
Message-ID: <ZdW+GCkO4s3MSeLX@gondor.apana.org.au>
References: <Yzv0wXi4Uu2WND37@gondor.apana.org.au>
 <Y5mGGrBJaDL6mnQJ@gondor.apana.org.au>
 <Y/MDmL02XYfSz8XX@gondor.apana.org.au>
 <ZEYLC6QsKnqlEQzW@gondor.apana.org.au>
 <ZJ0RSuWLwzikFr9r@gondor.apana.org.au>
 <ZOxnTFhchkTvKpZV@gondor.apana.org.au>
 <ZUNIBcBJ0VeZRmT9@gondor.apana.org.au>
 <ZZ3F/Pp1pxkdqfiD@gondor.apana.org.au>
 <ZbstBewmaIfrFocE@gondor.apana.org.au>
 <ZcRYwZHASH4Cv5Bn@gondor.apana.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZcRYwZHASH4Cv5Bn@gondor.apana.org.au>

Hi Linus:

The following changes since commit 24c890dd712f6345e382256cae8c97abb0406b70:

  crypto: algif_hash - Remove bogus SGL free on zero-length error path (2024-02-02 18:08:12 +0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/herbert/crypto-2.6.git v6.8-p4 

for you to fetch changes up to c0ec2a712daf133d9996a8a1b7ee2d4996080363:

  crypto: virtio/akcipher - Fix stack overflow on memcpy (2024-02-09 12:55:53 +0800)

----------------------------------------------------------------
This push fixes a stack overflow in virtio.
----------------------------------------------------------------

zhenwei pi (1):
      crypto: virtio/akcipher - Fix stack overflow on memcpy

 drivers/crypto/virtio/virtio_crypto_akcipher_algs.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

