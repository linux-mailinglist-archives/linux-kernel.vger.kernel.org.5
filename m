Return-Path: <linux-kernel+bounces-114925-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EAC56888C01
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 05:06:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 83E151F28A37
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 04:06:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E9632D66B5;
	Mon, 25 Mar 2024 00:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z66d35yJ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0BBE27F0A2;
	Sun, 24 Mar 2024 23:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711323601; cv=none; b=PipDXCmQzSlPQEH6men/gxaH0c7yEliy7ZKq7c5l14LLyd+4/OnslHwGsFDWZxBR87ubsewCe0XoXlgdAfAp/pAqRsJ8/UzbdhwmRJzgAjSc2cU2vpaE4D4MjfU+JlT68aKxOmTg5wcuWF1irxUfW7OF4V+/j+mV5dpQrtAgGig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711323601; c=relaxed/simple;
	bh=LR7iGJyYi/cz2ejQNfwXZZ+iJ39IZ1LD1F4qK1nR8C8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uV7vk3JTy2B33cdL8C6Hb0Fb3XHLUmMG3nJ7gqPFKHguQggs5171QVNSBkz5DJ8wixYiPGnN0QL+V1d3yp9y9PcFgsuSuoV2swYq2HEZFGe8GGZEgcBzCXNqFJxu+liO/zh816VmK8Kxy6w0Fh7tB8V/t3I8tJahw2ZgQRy6X1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z66d35yJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11886C43394;
	Sun, 24 Mar 2024 23:39:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711323600;
	bh=LR7iGJyYi/cz2ejQNfwXZZ+iJ39IZ1LD1F4qK1nR8C8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Z66d35yJY5cIKn+D3BkXh0KH0n6lMBAPkwAkFYSMGO0sG0dGFn4kQy481y4P04wdx
	 mvuKfAFsd71Dhda0EsiDl/SSz+3NLCTRbBch+9lKcl2gTAj14C8aeVEQole2WdU0JH
	 M320Jh5ML2hSUz70Vvjh2lfCwIJa5Fg9kQcYO0hUZQrFIU5HbSlj0EIVltbptpsCXg
	 Akdu5qorGvQTliHpPYRJ1jj8UcDHsld4PKjGpugp0gHIXB0V1tAVIcVMpFpG0Hizhm
	 S0CB6SOpzcYoUaMdQA88Opi+mnHQqz/83zBOee3LycBMd2X7ngXtg/9htLCKgkUsjx
	 t3IZmceXR7AHw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Pablo Neira Ayuso <pablo@netfilter.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 307/317] netfilter: nf_tables: do not compare internal table flags on updates
Date: Sun, 24 Mar 2024 19:34:47 -0400
Message-ID: <20240324233458.1352854-308-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324233458.1352854-1-sashal@kernel.org>
References: <20240324233458.1352854-1-sashal@kernel.org>
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
index a5e1468cac5ed..42bf83a20cb52 100644
--- a/net/netfilter/nf_tables_api.c
+++ b/net/netfilter/nf_tables_api.c
@@ -1152,7 +1152,7 @@ static int nf_tables_updtable(struct nft_ctx *ctx)
 	if (flags & ~NFT_TABLE_F_MASK)
 		return -EOPNOTSUPP;
 
-	if (flags == ctx->table->flags)
+	if (flags == (ctx->table->flags & NFT_TABLE_F_MASK))
 		return 0;
 
 	if ((nft_table_has_owner(ctx->table) &&
-- 
2.43.0


