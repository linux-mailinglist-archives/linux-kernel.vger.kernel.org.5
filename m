Return-Path: <linux-kernel+bounces-114477-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 81A4E888BAE
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 04:56:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2C529B2E443
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 03:25:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE23F17DC38;
	Sun, 24 Mar 2024 23:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hxMbhxUM"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37E39222872;
	Sun, 24 Mar 2024 23:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321902; cv=none; b=KVz2pCrSATeqaxrJEi8OOrni53w4XiSfgCRzWKRFWT8pD8oI8jnY922bXKZirhwvbBKR/0PiNODVMxfOEWMsRjwaDyTYH10ME4Xbi+tyBr7VtwgpCCTxveyS9puguZCkPJcTZFCOi/fOfKOOmguU48R1agZmkdfqNTN8nsY2Dwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321902; c=relaxed/simple;
	bh=+hxgvdJ2+1MSlyqNmrgZT/0q4+fK8qwgjG+1JQuvSPY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Vb0BcW4QJjSfsQD0YP+zUwWAz/VatipaLGCD3UmIzSIIxWHCcNsxRcrR6u+uz96QK4FEeP1na0dAfFSmRIA3V+UCNkBLGdLgO2oDYfE8s1HNzpfNR91wuBA7WPl6KToXdD7yJDmeMgcn93SCITA3ZelbzNnPnNMOk17J1UpU+gc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hxMbhxUM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77FBCC43390;
	Sun, 24 Mar 2024 23:11:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321902;
	bh=+hxgvdJ2+1MSlyqNmrgZT/0q4+fK8qwgjG+1JQuvSPY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hxMbhxUMRPt8wSnVsOrXugKEe7XNJUi2l8BLk9HkzXmsQerIBM20TCoWP2jGd8H6s
	 EHso9X/QwvMHULWaLZlwieuDs6SAzHHwQyYw/gW+mFd8ydnadQ9Oi1SczRf0nfaFhb
	 9rsvdKXxK/Sg6XSVi+4NmMtMnaGTLdNIfOvhi5M3c129ag5HYv89Zw2JFHb7mmH6S7
	 fypsInnJ/5PPyyjqC943NAhojtYZtS2Tv0nd4ArGCh9PjSxqSLbHO2sxRvQ0adC+ql
	 ntvhiZAvrfTjrZhxmzPgBqzhV9M/WteWtvIgI6K73S2DjQRBi0a5Yh1gD0vHa4yTE2
	 ZjphHLxGHBHVQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Quan Tian <tianquan23@gmail.com>,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 631/638] netfilter: nf_tables: Fix a memory leak in nf_tables_updchain
Date: Sun, 24 Mar 2024 19:01:08 -0400
Message-ID: <20240324230116.1348576-632-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324230116.1348576-1-sashal@kernel.org>
References: <20240324230116.1348576-1-sashal@kernel.org>
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
index a7f10941a935a..25945090d5288 100644
--- a/net/netfilter/nf_tables_api.c
+++ b/net/netfilter/nf_tables_api.c
@@ -2621,19 +2621,6 @@ static int nf_tables_updchain(struct nft_ctx *ctx, u8 genmask, u8 policy,
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
@@ -2648,6 +2635,20 @@ static int nf_tables_updchain(struct nft_ctx *ctx, u8 genmask, u8 policy,
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


