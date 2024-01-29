Return-Path: <linux-kernel+bounces-42879-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C1A4840813
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 15:19:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4156B1F249C2
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 14:19:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D83267E83;
	Mon, 29 Jan 2024 14:17:13 +0000 (UTC)
Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB99367E71;
	Mon, 29 Jan 2024 14:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.6.53.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706537832; cv=none; b=EXrwNeYormoOsHI7sE+b1ehTOWqdEOmoDajxvX9leSMpEvwHZMCXbZFlnfhIEwQLmIBnwG5aWmtFFy3ghPvi0s6TlWo/yQjn3wSo/sC0EiUQWJBjS5YHiDIF8XTliXx/SiPAy69LGvixwVms4s+eHHMtUuhpPNY50U1yTkbMk5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706537832; c=relaxed/simple;
	bh=xVPMeLuc5Lqup8/7g891YqwIQGt3iZ+gxRfFH6Ik2FE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PdiLJbH2oqpRh7rjY52R/QpaDUc/RUikVgnuHyDWeKVgn8tGyOPvGXSQHriPb8smkP5gGS5ttWw7xdx1xRAy1xKWdA3N8yfW3NKy46jkO9U4brnvoA+WedmoQ88OwabrbGFnpufasU4GW+kVvQgA36KS2++92QnmusHSHUAoIFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; arc=none smtp.client-ip=144.6.53.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
	id 1rUSRW-007C3j-Nu; Mon, 29 Jan 2024 22:16:59 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Mon, 29 Jan 2024 22:17:11 +0800
Date: Mon, 29 Jan 2024 22:17:11 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: syzbot <syzbot+050eeedd6c285d8c42f2@syzkaller.appspotmail.com>
Cc: davem@davemloft.net, linux-crypto@vger.kernel.org,
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Subject: [PATCH] crypto: cbc - Ensure statesize is zero
Message-ID: <ZbezZ/BV+DfMEEHB@gondor.apana.org.au>
References: <00000000000018273706101529cf@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <00000000000018273706101529cf@google.com>

On Mon, Jan 29, 2024 at 04:55:30AM -0800, syzbot wrote:
> 
> HEAD commit:    3a5879d495b2 Merge tag 'ata-6.8-rc2' of git://git.kernel.o..
> git tree:       upstream
> console+strace: https://syzkaller.appspot.com/x/log.txt?x=1683b6bbe80000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=bc36d99546fe9035
> dashboard link: https://syzkaller.appspot.com/bug?extid=050eeedd6c285d8c42f2

Thanks for the report.  This is actually caused by the construction
of cbc(arc4), which wasn't possible previously.  Let's make it
impossible again:

---8<---
The cbc template should not be applied on stream ciphers, especially
ones that have internal state.  Enforce this by checking the state
size when the instance is created.

Reported-by: syzbot+050eeedd6c285d8c42f2@syzkaller.appspotmail.com
Fixes: 47309ea13591 ("crypto: arc4 - Add internal state")
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>

diff --git a/crypto/cbc.c b/crypto/cbc.c
index eedddef9ce40..e81918ca68b7 100644
--- a/crypto/cbc.c
+++ b/crypto/cbc.c
@@ -148,6 +148,9 @@ static int crypto_cbc_create(struct crypto_template *tmpl, struct rtattr **tb)
 	if (!is_power_of_2(inst->alg.co.base.cra_blocksize))
 		goto out_free_inst;
 
+	if (inst->alg.co.statesize)
+		goto out_free_inst;
+
 	inst->alg.encrypt = crypto_cbc_encrypt;
 	inst->alg.decrypt = crypto_cbc_decrypt;
 
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

