Return-Path: <linux-kernel+bounces-116300-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 61D728895E0
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 09:41:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 02C891F2FFA1
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 08:41:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 213CF28FA8C;
	Mon, 25 Mar 2024 03:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MFzZcTn/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AB76182F0F;
	Sun, 24 Mar 2024 23:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711324190; cv=none; b=FQETYQEV1YDgoW1S2GHQ33iSkz3aZP/9wX+UU+l2woSWPQYLwj1mvSn4K4P0ULXgjKjx9fHVX6T9MtSf/XEevw2LQP3UmxXqksssgA9457wdeUuBZw2j2tCzfe3yyvaHu/FpzUHEZ4SBWvf2OBXJQvPiRr6F2Q56m8Gi+X38yU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711324190; c=relaxed/simple;
	bh=harBe5+ycWcpGaaRXQex1N/DCMhWycMN9uszLnw1iR0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AH3duVF6UeDa6Gb4U8YJ+FFioH+E1wj4X3O92C2p6CTU1/cCb9BcGfUMnN7DTEJjaFjt3jRyVJHTQQHafH7QAXUfo1PRLFm3uHaGYE6REytkexHmoVPt1bE+XN4xXIRUN65Y5/JYqkpxwpS161o7NDNKKU8Z/VrRV0DFHTCvP6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MFzZcTn/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56B6CC433C7;
	Sun, 24 Mar 2024 23:49:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711324188;
	bh=harBe5+ycWcpGaaRXQex1N/DCMhWycMN9uszLnw1iR0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MFzZcTn/xjGWWXfbIXc78apaQ9ewiZfz4SqlNXfWY5o2lZScsdcrtO6hY7WE5L2bR
	 hfh+xsy60ohsON8FBsLaTxWu1kK2GWarSvLF0XeJ4suzJmFrLQCVJTtXc17byHvwVd
	 JIsdY1SULoTKrppEZIW9TUprL8YLK5klLZ2pFaRn3ua5Fx9bPwv2R4bMrjgrJHvybj
	 +YSwdA5HaTjxdQ3+0sYeyzYCiHTcScylXkPvXFSrv1W8XBToSJE55WWoI51IgtTIaH
	 Cz7MIY9LQnx1ceJafGFFwS4CXHVQN1AIiFdc7yQgIsZm981S/W/8Eyr17TOxn96VVp
	 cGTx5CXP7OLvQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Pablo Neira Ayuso <pablo@netfilter.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 178/183] netfilter: nf_tables: do not compare internal table flags on updates
Date: Sun, 24 Mar 2024 19:46:31 -0400
Message-ID: <20240324234638.1355609-179-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324234638.1355609-1-sashal@kernel.org>
References: <20240324234638.1355609-1-sashal@kernel.org>
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
index c5dbb950822fd..2d372d5fcbfaa 100644
--- a/net/netfilter/nf_tables_api.c
+++ b/net/netfilter/nf_tables_api.c
@@ -916,7 +916,7 @@ static int nf_tables_updtable(struct nft_ctx *ctx)
 	if (flags & ~NFT_TABLE_F_DORMANT)
 		return -EINVAL;
 
-	if (flags == ctx->table->flags)
+	if (flags == (ctx->table->flags & NFT_TABLE_F_MASK))
 		return 0;
 
 	/* No dormant off/on/off/on games in single transaction */
-- 
2.43.0


