Return-Path: <linux-kernel+bounces-9296-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 803F481C398
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 04:42:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 22C87B2344B
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 03:42:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 854A720FB;
	Fri, 22 Dec 2023 03:42:46 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDC8017D3;
	Fri, 22 Dec 2023 03:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
	id 1rGWQi-00DgwM-Sq; Fri, 22 Dec 2023 11:42:33 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Fri, 22 Dec 2023 11:42:43 +0800
Date: Fri, 22 Dec 2023 11:42:43 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Shigeru Yoshida <syoshida@redhat.com>
Cc: davem@davemloft.net, dhowells@redhat.com, linux-crypto@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] crypto: af_alg/hash: Fix uninit-value access in
 af_alg_free_sg()
Message-ID: <ZYUFs1MumRFf3mnv@gondor.apana.org.au>
References: <20231211135949.689204-1-syoshida@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231211135949.689204-1-syoshida@redhat.com>

On Mon, Dec 11, 2023 at 10:59:49PM +0900, Shigeru Yoshida wrote:
>
> Fixes: c662b043cdca ("crypto: af_alg/hash: Support MSG_SPLICE_PAGES")

I think it should actually be

	b6d972f6898308fbe7e693bf8d44ebfdb1cd2dc4
	crypto: af_alg/hash: Fix recvmsg() after sendmsg(MSG_MORE)

Anyway, I think we should fix it by adding a new goto label that
does not free the SG list:

unlock_free:
	af_alg_free_sg(&ctx->sgl);
<--- Add new label here
	hash_free_result(sk, ctx);
	ctx->more = false;
	goto unlock;

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

