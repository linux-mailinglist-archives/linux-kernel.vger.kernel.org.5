Return-Path: <linux-kernel+bounces-59002-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CD71C84EFB3
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 06:01:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0BCF01C2368B
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 05:01:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7841C5467C;
	Fri,  9 Feb 2024 05:00:57 +0000 (UTC)
Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C55E53813;
	Fri,  9 Feb 2024 05:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.6.53.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707454857; cv=none; b=UMGxzIN4OD35wbV3Ot3aRYQwyVjGXSkpLqVxmFvU7642wIn8p3f17pjBrGauo7rBP/q8poBxRdkEvMX8cpzZfmM6pVJpHdP+cKUjE2/DtfhKUqJHGiJaIQKvLmFTWjE6E9Vl/Ekkn9F39Cr+VtfmpluZrB6sBPGRHo2BVRKMrgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707454857; c=relaxed/simple;
	bh=zObVotpymnKKnFxHAN7EY6F1gWS/OkIVec0U3+tUSfY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qQLLd2lWVjAGwLpdc2UGibpeVunJUbiZM+KwEgaPBLmvc5oAxhksHFlCXBZZYFm8pBM/4VD4/bd9dBWHgpJQdNYZZ2y8Ski7CxsZ2bUWzrSIlscbqCI18po8e2Hd6GvU6gITSOppJJWVT8LKPPPNkl6+piKQ52pO4zE+0mMiL60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; arc=none smtp.client-ip=144.6.53.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
	id 1rYJ03-00BhgQ-HO; Fri, 09 Feb 2024 13:00:32 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Fri, 09 Feb 2024 13:00:45 +0800
Date: Fri, 9 Feb 2024 13:00:45 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: zhenwei pi <pizhenwei@bytedance.com>
Cc: arei.gonglei@huawei.com, mst@redhat.com, jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com, virtualization@lists.linux.dev,
	nathan@kernel.org, linux-crypto@vger.kernel.org,
	linux-kernel@vger.kernel.org, davem@davemloft.net
Subject: Re: [PATCH] crypto: virtio/akcipher - Fix stack overflow on memcpy
Message-ID: <ZcWxfRvhF002qLb/@gondor.apana.org.au>
References: <20240130112740.882183-1-pizhenwei@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240130112740.882183-1-pizhenwei@bytedance.com>

On Tue, Jan 30, 2024 at 07:27:40PM +0800, zhenwei pi wrote:
> sizeof(struct virtio_crypto_akcipher_session_para) is less than
> sizeof(struct virtio_crypto_op_ctrl_req::u), copying more bytes from
> stack variable leads stack overflow. Clang reports this issue by
> commands:
> make -j CC=clang-14 mrproper >/dev/null 2>&1
> make -j O=/tmp/crypto-build CC=clang-14 allmodconfig >/dev/null 2>&1
> make -j O=/tmp/crypto-build W=1 CC=clang-14 drivers/crypto/virtio/
>   virtio_crypto_akcipher_algs.o
> 
> Fixes: 59ca6c93387d ("virtio-crypto: implement RSA algorithm")
> Link: https://lore.kernel.org/all/0a194a79-e3a3-45e7-be98-83abd3e1cb7e@roeck-us.net/
> Signed-off-by: zhenwei pi <pizhenwei@bytedance.com>
> ---
>  drivers/crypto/virtio/virtio_crypto_akcipher_algs.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

