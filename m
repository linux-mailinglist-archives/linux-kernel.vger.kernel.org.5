Return-Path: <linux-kernel+bounces-115174-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DE1B88933F
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 08:24:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC5B5295C73
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 07:24:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D0E2307078;
	Mon, 25 Mar 2024 01:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KZjJGZJF"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8064722BF90;
	Sun, 24 Mar 2024 23:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711324233; cv=none; b=D5uFm20JihbRb0UCJ7J37VwrDLUV765j1sokGVErnKIoaX+YNWB5Cx2hAxAW+z9xjhJWjhO8toUoAobVAOkcgWlB8SGH50xWCdlF9HuTtl6WLv2XFyyq9HspkU7ZUuRi1LotmKZFQCQ64WfThGhTPWvd9iEIKz8Rga/oPUE23Hw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711324233; c=relaxed/simple;
	bh=QMhrV214RLPZ2ZrKumKQA+aTfeZeVAws8l4YnWi2/c8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bVvcPtK7JVMCHehPMUMROjbllDhlL39PVgZKK+JVuVUznEsiOJcrUjrsUnWbi2AHCW3Sz0umLZWD1PlDRPKEazFUCxgtiPVU/XvpSRMiAMKz1QIWMF9HQc0MAPxMi7krANVZmqjGeeXEiLvwbdCj4C8wUPZDifX6g6DGzciBLMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KZjJGZJF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BADCC43390;
	Sun, 24 Mar 2024 23:50:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711324232;
	bh=QMhrV214RLPZ2ZrKumKQA+aTfeZeVAws8l4YnWi2/c8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KZjJGZJFqiMO36edUgziFClUgUPtsW6w/AgWHjBnZiN2jD6NPX2D7204w6NSB/ZTC
	 KmFXw8vHdSN8CnI2A4p6HGk5dRAVcsYeIQ/wCdQIoSkcrFkNFFnTWMC9UspxdIEmgo
	 do51sN1Ujexsl2YwgvsGiX4FTtqyxrJ/iNn0HXLW7Aouaa29BYyK/tZ5oDx4XccOsr
	 xHLpEbXDbavvb30TXQj3KkGRkJIfzIlYgyv31WJePEA7RPlF6h56fNB9FqH5B2TLqo
	 FSVR/zvjw6YKMNyF8ArkgU0v2SXQx7n5Z496+pBq9sEhSh4IfCKuNcicK5iJIqRenf
	 xJfOHzrhnk2fA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Ondrej Mosnacek <omosnace@redhat.com>,
	Stephan Mueller <smueller@chronox.de>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 015/148] crypto: algif_aead - fix uninitialized ctx->init
Date: Sun, 24 Mar 2024 19:47:59 -0400
Message-ID: <20240324235012.1356413-16-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324235012.1356413-1-sashal@kernel.org>
References: <20240324235012.1356413-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Ondrej Mosnacek <omosnace@redhat.com>

[ Upstream commit 21dfbcd1f5cbff9cf2f9e7e43475aed8d072b0dd ]

In skcipher_accept_parent_nokey() the whole af_alg_ctx structure is
cleared by memset() after allocation, so add such memset() also to
aead_accept_parent_nokey() so that the new "init" field is also
initialized to zero. Without that the initial ctx->init checks might
randomly return true and cause errors.

While there, also remove the redundant zero assignments in both
functions.

Found via libkcapi testsuite.

Cc: Stephan Mueller <smueller@chronox.de>
Fixes: f3c802a1f300 ("crypto: algif_aead - Only wake up when ctx->more is zero")
Suggested-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 crypto/algif_aead.c     | 6 ------
 crypto/algif_skcipher.c | 7 +------
 2 files changed, 1 insertion(+), 12 deletions(-)

diff --git a/crypto/algif_aead.c b/crypto/algif_aead.c
index 182783801ffa6..4cb2b12175490 100644
--- a/crypto/algif_aead.c
+++ b/crypto/algif_aead.c
@@ -563,12 +563,6 @@ static int aead_accept_parent_nokey(void *private, struct sock *sk)
 
 	INIT_LIST_HEAD(&ctx->tsgl_list);
 	ctx->len = len;
-	ctx->used = 0;
-	atomic_set(&ctx->rcvused, 0);
-	ctx->more = 0;
-	ctx->merge = 0;
-	ctx->enc = 0;
-	ctx->aead_assoclen = 0;
 	crypto_init_wait(&ctx->wait);
 
 	ask->private = ctx;
diff --git a/crypto/algif_skcipher.c b/crypto/algif_skcipher.c
index 9d2e9783c0d4e..af08fc18a4926 100644
--- a/crypto/algif_skcipher.c
+++ b/crypto/algif_skcipher.c
@@ -337,6 +337,7 @@ static int skcipher_accept_parent_nokey(void *private, struct sock *sk)
 	ctx = sock_kmalloc(sk, len, GFP_KERNEL);
 	if (!ctx)
 		return -ENOMEM;
+	memset(ctx, 0, len);
 
 	ctx->iv = sock_kmalloc(sk, crypto_skcipher_ivsize(tfm),
 			       GFP_KERNEL);
@@ -344,16 +345,10 @@ static int skcipher_accept_parent_nokey(void *private, struct sock *sk)
 		sock_kfree_s(sk, ctx, len);
 		return -ENOMEM;
 	}
-
 	memset(ctx->iv, 0, crypto_skcipher_ivsize(tfm));
 
 	INIT_LIST_HEAD(&ctx->tsgl_list);
 	ctx->len = len;
-	ctx->used = 0;
-	atomic_set(&ctx->rcvused, 0);
-	ctx->more = 0;
-	ctx->merge = 0;
-	ctx->enc = 0;
 	crypto_init_wait(&ctx->wait);
 
 	ask->private = ctx;
-- 
2.43.0


