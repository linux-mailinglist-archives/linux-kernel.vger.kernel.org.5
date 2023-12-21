Return-Path: <linux-kernel+bounces-7757-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0458A81ACB4
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 03:43:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B4EB9287C17
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 02:43:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDC664685;
	Thu, 21 Dec 2023 02:43:02 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7D044416;
	Thu, 21 Dec 2023 02:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
	id 1rG91K-00DGnB-B3; Thu, 21 Dec 2023 10:42:47 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Thu, 21 Dec 2023 10:42:57 +0800
Date: Thu, 21 Dec 2023 10:42:57 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: syzbot <syzbot+8ffb0839a24e9c6bfa76@syzkaller.appspotmail.com>
Cc: davem@davemloft.net, linux-crypto@vger.kernel.org,
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
	Edward Adam Davis <eadavis@qq.com>
Subject: [PATCH] crypto: skcipher - Pass statesize for simple lskcipher
 instances
Message-ID: <ZYOmMW9bwehnl+NT@gondor.apana.org.au>
References: <000000000000d52e14060cc9c551@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000000000000d52e14060cc9c551@google.com>

On Mon, Dec 18, 2023 at 06:43:27AM -0800, syzbot wrote:
> 
> syzbot found the following issue on:
> 
> HEAD commit:    17cb8a20bde6 Add linux-next specific files for 20231215
> git tree:       linux-next
> console+strace: https://syzkaller.appspot.com/x/log.txt?x=1129f3b6e80000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=ec104439b5dbc583
> dashboard link: https://syzkaller.appspot.com/bug?extid=8ffb0839a24e9c6bfa76
> compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17d23c01e80000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14cfe021e80000

---8<---
When ecb is used to wrap an lskcipher, the statesize isn't set
correctly.  Fix this by making the simple instance creator set
the statesize.

Reported-by: syzbot+8ffb0839a24e9c6bfa76@syzkaller.appspotmail.com
Reported-by: Edward Adam Davis <eadavis@qq.com>
Fixes: 662ea18d089b ("crypto: skcipher - Make use of internal state")
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>

diff --git a/crypto/lskcipher.c b/crypto/lskcipher.c
index a06008e112f3..0b6dd8aa21f2 100644
--- a/crypto/lskcipher.c
+++ b/crypto/lskcipher.c
@@ -642,6 +642,7 @@ struct lskcipher_instance *lskcipher_alloc_instance_simple(
 	inst->alg.co.min_keysize = cipher_alg->co.min_keysize;
 	inst->alg.co.max_keysize = cipher_alg->co.max_keysize;
 	inst->alg.co.ivsize = cipher_alg->co.base.cra_blocksize;
+	inst->alg.co.statesize = cipher_alg->co.statesize;
 
 	/* Use struct crypto_lskcipher * by default, can be overridden */
 	inst->alg.co.base.cra_ctxsize = sizeof(struct crypto_lskcipher *);
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

