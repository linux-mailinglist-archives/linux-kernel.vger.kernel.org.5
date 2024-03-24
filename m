Return-Path: <linux-kernel+bounces-114000-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8BF18887DC
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 03:12:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 06BE31C26C7F
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 02:12:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 487C5157497;
	Sun, 24 Mar 2024 23:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FibJrN1F"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB74F12D77B;
	Sun, 24 Mar 2024 22:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321144; cv=none; b=W6mrwaLD/CdJi+tmy5le0l5FLe6MwVuAYCmRvIs++jfZDLGAFbowPG0KI8HADa1WZXARDkjK9J/qVGFU1xo0qUVlX/4EDr005cUnfLmCUtJ547rFr4hKYYBttnGfyfM6unNOojdC1e7YJbC2SH6algA0AApuzJWIpCSwOGZU/7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321144; c=relaxed/simple;
	bh=N31omVZd97UQiQbjKJexFx66JX16bowjHtmJcLEmGtg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jj9p668Qy7CxQUTSojRQi6glyXijVhbMBff2j2n4bPcvX1EMtUKI8Yn3qSecB/qfLUNZa8TCzBOs7WxDN9Nc15EMl5wFvRom9g2y3jU1Ix2KcR2Xw4eEki2jlvG46MOXazkXWUzqnTGHWdfWpeHztRJKC0FKxA2xm/65E8svuIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FibJrN1F; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5D48C43394;
	Sun, 24 Mar 2024 22:59:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321144;
	bh=N31omVZd97UQiQbjKJexFx66JX16bowjHtmJcLEmGtg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FibJrN1FK6LoX7Mi37hUiVbUH9xhhZo2WglOHVVtX9MUW6X+Bcy+5XtO0O4Zxrzdn
	 QdUFS+8uUh4RpcOmsaeIRFi8xpzGvf2h3Ola7LVMq0134syI7Q5E14M+9JZb/k4WT/
	 UV7BYSjmWhJ6rm5mjyN0SGIaiUsohHQS0oG0yorqt9SAn0ANjUAozyOHXpWP4ZiXIB
	 zfSI1wRpeqT3ANwfcZb7v3AltF8xrbCQZFuYiRgyTNXUV5L8JBPk5OTpCA96BiLhsF
	 riYAV/wOVMCWb/uTjD7KcPQ0u3/Bnyrhb0AFTcN0Ea4m9DCHUMgxBDIabIe6LtJDlL
	 +q8EFAMV7UT2A==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Quan Tian <tianquan23@gmail.com>,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 706/713] netfilter: nf_tables: Fix a memory leak in nf_tables_updchain
Date: Sun, 24 Mar 2024 18:47:12 -0400
Message-ID: <20240324224720.1345309-707-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324224720.1345309-1-sashal@kernel.org>
References: <20240324224720.1345309-1-sashal@kernel.org>
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
index 85d9e1394330c..0130c2782cdc7 100644
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


