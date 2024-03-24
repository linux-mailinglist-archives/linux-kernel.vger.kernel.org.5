Return-Path: <linux-kernel+bounces-113599-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F25C88859C
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 02:12:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 156E81F225ED
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 01:12:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC2D61CDE01;
	Sun, 24 Mar 2024 22:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fLXfxWkc"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DA651CDDE8;
	Sun, 24 Mar 2024 22:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320402; cv=none; b=BDcnoy2NTTZ7oWXLRZFkXqnpGJZ2PKrHdPJpa/4NgG9kaYt8Nf2V5WJJyjlGjimeylGLmllmZdLWrNxD5epuNVvX8oQlvgiDRZD63g6+cccv8vArfbQEui1UUKX7BiFO8fk8zQhfKDnHw+WPiR2Qj4lvECP7fNpdpU4BwxMyMoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320402; c=relaxed/simple;
	bh=0xJ+qloyoX7no++YWtVrlTrA5iVh3b8gZloLuJhdlI4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CThoWpLomvlEEABkvErk4qF38WSECujDCQJE3iYXQ01Hno2d0qZopB1dkekYZPUhWlHRQYqjwNZKR+6E0oC47nnjz5+P7PHfEc0lG1CbEzhpnPWKVQNckZ64jyL4T+bKVqYxngQGgV4NnXiA9txu7R0dka2SQwe4J2tRsE4oXZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fLXfxWkc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BAC3C433C7;
	Sun, 24 Mar 2024 22:46:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320401;
	bh=0xJ+qloyoX7no++YWtVrlTrA5iVh3b8gZloLuJhdlI4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fLXfxWkcsx07pX/pwUaHgqAKNZ7bqmhELJu1LNuiR8XxVP6d6fSVXtpGIMcp8DBpr
	 Gs4CnQykJgekqsbtiW6zOirXAbxnKoUvaY3vvWAIUPumxnNsRO6/avtM+Md5rhzt9k
	 TwfZ+1QUcEqxu4qTEIL9eLG6V6CF8LZ9Pt08qDzyUd5LF2y3axnXThUSffxpFhG/fa
	 xz+Hyp3q7VmtdhXAgwpWqDRbW8GEG4x8Ko+JJWIeQ+8a7GuvbfQn2W3NsuK3R5q9da
	 G3QhtB+rOFKvzgJs7gDF+0qH78RgM807z80AsiXm8P8KOpGevZLbAh268zkDLS6k0m
	 u6hbbcgL/hi6A==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Quan Tian <tianquan23@gmail.com>,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 708/715] netfilter: nf_tables: Fix a memory leak in nf_tables_updchain
Date: Sun, 24 Mar 2024 18:34:47 -0400
Message-ID: <20240324223455.1342824-709-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324223455.1342824-1-sashal@kernel.org>
References: <20240324223455.1342824-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Quan Tian <tianquan23@gmail.com>

[ Upstream commit 7eaf837a4eb5f74561e2486972e7f5184b613f6e ]

If nft_netdev_register_hooks() fails, the memory associated with
nft_stats is not freed, causing a memory leak.

This patch fixes it by moving nft_stats_alloc() down after
nft_netdev_register_hooks() succeeds.

Fixes: b9703ed44ffb ("netfilter: nf_tables: support for adding new devices to an existing netdev chain")
Signed-off-by: Quan Tian <tianquan23@gmail.com>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/netfilter/nf_tables_api.c | 27 ++++++++++++++-------------
 1 file changed, 14 insertions(+), 13 deletions(-)

diff --git a/net/netfilter/nf_tables_api.c b/net/netfilter/nf_tables_api.c
index 0fe2abf27d12f..6873c9815cd31 100644
--- a/net/netfilter/nf_tables_api.c
+++ b/net/netfilter/nf_tables_api.c
@@ -2619,19 +2619,6 @@ static int nf_tables_updchain(struct nft_ctx *ctx, u8 genmask, u8 policy,
 		}
 	}
 
-	if (nla[NFTA_CHAIN_COUNTERS]) {
-		if (!nft_is_base_chain(chain)) {
-			err = -EOPNOTSUPP;
-			goto err_hooks;
-		}
-
-		stats = nft_stats_alloc(nla[NFTA_CHAIN_COUNTERS]);
-		if (IS_ERR(stats)) {
-			err = PTR_ERR(stats);
-			goto err_hooks;
-		}
-	}
-
 	if (!(table->flags & NFT_TABLE_F_DORMANT) &&
 	    nft_is_base_chain(chain) &&
 	    !list_empty(&hook.list)) {
@@ -2646,6 +2633,20 @@ static int nf_tables_updchain(struct nft_ctx *ctx, u8 genmask, u8 policy,
 	}
 
 	unregister = true;
+
+	if (nla[NFTA_CHAIN_COUNTERS]) {
+		if (!nft_is_base_chain(chain)) {
+			err = -EOPNOTSUPP;
+			goto err_hooks;
+		}
+
+		stats = nft_stats_alloc(nla[NFTA_CHAIN_COUNTERS]);
+		if (IS_ERR(stats)) {
+			err = PTR_ERR(stats);
+			goto err_hooks;
+		}
+	}
+
 	err = -ENOMEM;
 	trans = nft_trans_alloc(ctx, NFT_MSG_NEWCHAIN,
 				sizeof(struct nft_trans_chain));
-- 
2.43.0


