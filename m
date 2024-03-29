Return-Path: <linux-kernel+bounces-124782-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 843E1891C80
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 14:51:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D4EADB26FF7
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 13:50:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D001187889;
	Fri, 29 Mar 2024 12:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g6L83uDw"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B849E18766D;
	Fri, 29 Mar 2024 12:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711716133; cv=none; b=pIW2rMg+5oFG7xl7PwiqftH4IVDZlMxksZNlhGmrzAPjyaR9rMEMWd0q2esuB/Emvqk+0uY+JLLQPBZ3YLxdnrq7aKirvPYoUtjU/xtwIvJvse/JtDF4LF1URXjimbbpEB3tQtESsiUVPONaGcXND3U2uUzYlmzrLFCQZmsfFp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711716133; c=relaxed/simple;
	bh=d5irRUJ+Xrb90VdHOxAtw9bB+4PWO4IFVtpurXE1w/c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aMKEl3XQQp6SEL7rbkXzN6iL2Ec2svdw128LXVyW5/Wu0rUszX8qruqwxchxYTsg8UsmafkpjqAPjBQThEoZAqyXgTQaiLiAnUwIDRPupndHa2btUsUl3yUiqkqP2BXMVyWFH1H0V8RC7ROgwp9voF0az/4A0wQZJloxAzxFjU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g6L83uDw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD403C433C7;
	Fri, 29 Mar 2024 12:42:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711716133;
	bh=d5irRUJ+Xrb90VdHOxAtw9bB+4PWO4IFVtpurXE1w/c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=g6L83uDwfq6omjp+H+zrXtr6H3j/MB1Re51BbZ9lUpyHgZpp9iHE+zZxuPRy0Mrwz
	 3tUJR+RTS7qKp0l12Wk9n+S5ztgYnIyizp5TxdJws2uYu/NuAtMNpOf1cxkcMHp+ek
	 RepnQ1RnT6TBYRILm/dgD5Cxh72y5JXhi/sg/UxlCtRHqiCE0/OqFyj6XM+5F5NRDl
	 f8/c9HFxNfVe3rF11w/nUsT7CN4ZJRbLedMg70yuOdCtRNGfnyYxOwHuMZmkLAGcGi
	 M4cyvM9s8XjaHBfjoKBavL+LopyC5wJji0dmGozeZ15z3rnI7amQ5udEnYUwwsQky6
	 fb+522WLNtGkw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Tom Zanussi <tom.zanussi@linux.intel.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Sasha Levin <sashal@kernel.org>,
	davem@davemloft.net,
	linux-crypto@vger.kernel.org
Subject: [PATCH AUTOSEL 6.8 72/98] crypto: iaa - Fix async_disable descriptor leak
Date: Fri, 29 Mar 2024 08:37:43 -0400
Message-ID: <20240329123919.3087149-72-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240329123919.3087149-1-sashal@kernel.org>
References: <20240329123919.3087149-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.8.2
Content-Transfer-Encoding: 8bit

From: Tom Zanussi <tom.zanussi@linux.intel.com>

[ Upstream commit 262534ddc88dfea7474ed18adfecf856e4fbe054 ]

The disable_async paths of iaa_compress/decompress() don't free idxd
descriptors in the async_disable case. Currently this only happens in
the testcases where req->dst is set to null. Add a test to free them
in those paths.

Signed-off-by: Tom Zanussi <tom.zanussi@linux.intel.com>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/crypto/intel/iaa/iaa_crypto_main.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/crypto/intel/iaa/iaa_crypto_main.c b/drivers/crypto/intel/iaa/iaa_crypto_main.c
index dfd3baf0a8d87..afa4eacdd8701 100644
--- a/drivers/crypto/intel/iaa/iaa_crypto_main.c
+++ b/drivers/crypto/intel/iaa/iaa_crypto_main.c
@@ -1324,7 +1324,7 @@ static int iaa_compress(struct crypto_tfm *tfm,	struct acomp_req *req,
 
 	*compression_crc = idxd_desc->iax_completion->crc;
 
-	if (!ctx->async_mode)
+	if (!ctx->async_mode || disable_async)
 		idxd_free_desc(wq, idxd_desc);
 out:
 	return ret;
@@ -1570,7 +1570,7 @@ static int iaa_decompress(struct crypto_tfm *tfm, struct acomp_req *req,
 
 	*dlen = req->dlen;
 
-	if (!ctx->async_mode)
+	if (!ctx->async_mode || disable_async)
 		idxd_free_desc(wq, idxd_desc);
 
 	/* Update stats */
-- 
2.43.0


