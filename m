Return-Path: <linux-kernel+bounces-113996-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DD23A8887D7
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 03:11:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9439C1F26642
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 02:11:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4C50223BB7;
	Sun, 24 Mar 2024 23:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZQgsHiEv"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8872D14BFAB;
	Sun, 24 Mar 2024 22:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321139; cv=none; b=J9laSQoLN0AYZe5XhSnjDgp16EdzyDoVdrmMmnzCHD9K6y5YVVXk7XjM/Y7MSjwfo0XLrBYJlFPb/6EEhGeQYtiVX+v56get63xl6EOcPqhCP1SGdMN7n621yplVJW7PB8gqhxy790ofptaHG2T26ERySZWry59FxDfjoCiqSIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321139; c=relaxed/simple;
	bh=Df4j8YPt95U0WVO6bw3LNOyLRz5OIHkPfVnpGdcNSHk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rnNYVpkTCvXjBxTm0PzPvDBah+UKuioriyKH6/P6Xq5V2qnEF06wioexEj83eYSERWmDDhCRul5oeT9qEa+Of/uvVcwuDT1mCWD+gCvVRzYOA4qbk3mJmdqPeovkjy3ciuEFZ6seKqcMaUhbTF7DeOsu+lq38npFfSX7zFaDUTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZQgsHiEv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC8F3C43399;
	Sun, 24 Mar 2024 22:58:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321138;
	bh=Df4j8YPt95U0WVO6bw3LNOyLRz5OIHkPfVnpGdcNSHk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZQgsHiEvzlQeI7BuUhoG3YKYZgmm3DOgVPAaNZ7AjBWihnZwh0IoOFFhEAELMONx8
	 0k/WwwKzn6890zmto/4Lv9xhBzhPrpMRybLG/67NOExr0JfxwiTc2AO5TiOVxUw1gQ
	 C8qINJs7fF59NyhRkOVasc/Z1ydOWjOjCQgznwxlft/Fi8FJjTnIqXDGpQzR+i3Wg8
	 FxAynMyTw7F1Rs+BcHHbmOrfzNXng9Rtw6CTF2sW8/qMyIxrJPmu+4m8EVM5qRznwY
	 tpEfePIOmesdmDEcX/Ehjfm3ZUF+wWTnSiPzrkENL/i7Imc4lJCbgZ0vooHmCnICMP
	 2ojGZX5iK2wLw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Pablo Neira Ayuso <pablo@netfilter.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 700/713] netfilter: nf_tables: do not compare internal table flags on updates
Date: Sun, 24 Mar 2024 18:47:06 -0400
Message-ID: <20240324224720.1345309-701-sashal@kernel.org>
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
index 79e088e6f103e..85d9e1394330c 100644
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


