Return-Path: <linux-kernel+bounces-114705-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 867F48890C0
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 07:27:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B75801C25475
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 06:27:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6FFD18E06;
	Mon, 25 Mar 2024 00:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WKQX+Y0g"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 092E01509BD;
	Sun, 24 Mar 2024 23:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711322357; cv=none; b=FrQwLV4kLOp+lIpmc3OB2mSb7RhC8kN5wNajV/4JXVG1rhQ3ZQ8VB3xLjgo/wm3IZ5z5Ni6SFUFlxDn9hezjful/r1b5L/p+IhgO/oIcy7ju40InXTetNasRE0uQP12NMTAeQzxLTkdAJLI6cxWZhCpAXjY6xHqKH3g9k56aIWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711322357; c=relaxed/simple;
	bh=l9CF472xzA5Sds7a3d5p9A9eJDKLLEW/h/YvlFUgIUM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CS6sNQvfzXvmKsPtZJ7JsKWdnDzQwk9u/+ADoFNeEMk1G7pQvn3Q3uCurHKWL2LhttKE3aXezeVS4U/zWjjJVdxZxGSbreTVqfvLVxqa6Xa1OXbHUiNbedr5V9/4NEeLL4C3aIWdctueQLJMDO3gQ8YxhP2v6dMY/rMNzBEhu3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WKQX+Y0g; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6354EC433F1;
	Sun, 24 Mar 2024 23:19:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711322355;
	bh=l9CF472xzA5Sds7a3d5p9A9eJDKLLEW/h/YvlFUgIUM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WKQX+Y0gmPZP7Y7QCE5aK/u+PUvbJZDiewcUfZMHvBZtMgYYsLLhH9ZXHa+INXv3I
	 x9GDhCWY2e73hsEi5m9ECWMYRoHMa7oWcUpQ6yDJCdVAsBjQaymZtngvm+Fys3PEtF
	 ZWPkalEs4Rc1R/KdA1fq1LQLOWnhMWuXheAJaaKtQhQ8/pM984dyqshg/ZUWLfDNq+
	 DbKKfIQhXOg5N9YTAXxOCA741q2a2EFN0U2g7FwlG4tIlP4udpjnkNT0wSJvo95zzS
	 wUHzA6TlU7JlFC+ERDIccGZX05FAzftBlmbPZipOucfwVm83F/eZERyd3oLvWxGJsW
	 SOpqc9EGtzc3Q==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Pablo Neira Ayuso <pablo@netfilter.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 438/451] netfilter: nf_tables: do not compare internal table flags on updates
Date: Sun, 24 Mar 2024 19:11:54 -0400
Message-ID: <20240324231207.1351418-439-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324231207.1351418-1-sashal@kernel.org>
References: <20240324231207.1351418-1-sashal@kernel.org>
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
index d3ba947f43761..0a86c019a75de 100644
--- a/net/netfilter/nf_tables_api.c
+++ b/net/netfilter/nf_tables_api.c
@@ -1205,7 +1205,7 @@ static int nf_tables_updtable(struct nft_ctx *ctx)
 	if (flags & ~NFT_TABLE_F_MASK)
 		return -EOPNOTSUPP;
 
-	if (flags == ctx->table->flags)
+	if (flags == (ctx->table->flags & NFT_TABLE_F_MASK))
 		return 0;
 
 	if ((nft_table_has_owner(ctx->table) &&
-- 
2.43.0


