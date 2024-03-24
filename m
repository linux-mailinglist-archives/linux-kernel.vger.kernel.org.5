Return-Path: <linux-kernel+bounces-113593-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E1953888590
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 02:10:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D359284E74
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 01:10:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAC421CC61D;
	Sun, 24 Mar 2024 22:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WSurhNFf"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DB9C1CC5FE;
	Sun, 24 Mar 2024 22:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320396; cv=none; b=OTYzZOGzhezXmGtmraygkDUCwX3Hq+hprnc9B9OrmddpfQcDGC66n6lR3TAXeejaANV8C/hHCSo2pf57P/tqhwUxerb4oN3u9iOEdTzkVcdeNf1rttSD3VU+WoR7V7utAN0Eg+6RLP0YMryE4AS9e3lQ0jRxpl+pfbFYGwPwLQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320396; c=relaxed/simple;
	bh=pn4y5dbLBF481EEZQxNbzho2TeYcoLbqwNeJkaBporg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PYyIEHSEpf+dU0L2yLAQijECvRqg5BjlEarl3Cpwvb+UWuX2unKx+5tTgnX1TI1AasBAek4qFRcpMSKcBVORcOqeVxhJ9gtmy47+R4Gx1dlOcVNnjir0/RSBA0ziejLNYTeN7LBCP6CfLG82ZFKatZTvbZ54OWhQ7fo1Ktz3c8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WSurhNFf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53234C433B2;
	Sun, 24 Mar 2024 22:46:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320395;
	bh=pn4y5dbLBF481EEZQxNbzho2TeYcoLbqwNeJkaBporg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WSurhNFfWDp/daMgSMw0CazKgBNW6qHQsjniPMf8xKle51XNkxKa+o4fu37+wLnzq
	 2cqL+vfu3nCdyqCSYswNhBr04bfXGOy/LQimRzmIC85XnMp4N3nZqio1eB62NHQTl7
	 8qhBmareYa/v6+trqL8HuxV6ZIOKg8CiIMvaA8TUKCeyg+yHtediHh+M4SGMZs7C4L
	 vLLYufTg58KJvspveznlS5l44O6w8R5Ya7VULMjgs5mq1K49kkZyaRi9aCWt2ZAeTh
	 uk90LDUkbM6fSU9FRDNTJmNE3ugtVp96dQA58N77xEYtoiOYcYQMxyeIjl9rXN6NXp
	 ThR2b7cr82bhA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Pablo Neira Ayuso <pablo@netfilter.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 702/715] netfilter: nf_tables: do not compare internal table flags on updates
Date: Sun, 24 Mar 2024 18:34:41 -0400
Message-ID: <20240324223455.1342824-703-sashal@kernel.org>
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

From: Pablo Neira Ayuso <pablo@netfilter.org>

[ Upstream commit 4a0e7f2decbf9bd72461226f1f5f7dcc4b08f139 ]

Restore skipping transaction if table update does not modify flags.

Fixes: 179d9ba5559a ("netfilter: nf_tables: fix table flag updates")
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/netfilter/nf_tables_api.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/netfilter/nf_tables_api.c b/net/netfilter/nf_tables_api.c
index 1683dc196b592..0fe2abf27d12f 100644
--- a/net/netfilter/nf_tables_api.c
+++ b/net/netfilter/nf_tables_api.c
@@ -1211,7 +1211,7 @@ static int nf_tables_updtable(struct nft_ctx *ctx)
 	if (flags & ~NFT_TABLE_F_MASK)
 		return -EOPNOTSUPP;
 
-	if (flags == ctx->table->flags)
+	if (flags == (ctx->table->flags & NFT_TABLE_F_MASK))
 		return 0;
 
 	if ((nft_table_has_owner(ctx->table) &&
-- 
2.43.0


