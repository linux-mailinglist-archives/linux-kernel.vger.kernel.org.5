Return-Path: <linux-kernel+bounces-116222-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B55B88A5CD
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 16:07:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E0FE2BA1325
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 11:49:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AE883BFFBB;
	Mon, 25 Mar 2024 03:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DtEa6oHo"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49A57131BA2;
	Sun, 24 Mar 2024 23:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711323856; cv=none; b=MZpP9aXFS953NGBMCvhob5I0lFMv7CL9foOoE5+dnWWq/c+QzBQxsZqzvxvb9o8jY5HV30pC5tkjrv6U+IiDbVuHQM8X0SarmeYEr16nJi4zUvJtLkB5RajiIRZlWgtckOtIcDPbBrf1QAZkzaMAlt1AcnUUnIg3MnwvskcTeek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711323856; c=relaxed/simple;
	bh=HFdAVBCshBhE8RfYVfDJNWySv+TBfnv031oELRS2nQk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WUDGAy1TAaXHfam1CbXGJKPm/OJGtbHBF+tOoHVmjvIIzIfDzkkMP9SUk23KcSiTGh0RxKWuiMtsC//X93MQc68g+UnyA+1wzA7GHnfoz8cBeB1JDH54xI/Omo4VjvR868Wzxs/c0Q2qIalJeLaI3wMDOVpBqyaOTJlcf/Y4tOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DtEa6oHo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 953B7C43390;
	Sun, 24 Mar 2024 23:44:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711323855;
	bh=HFdAVBCshBhE8RfYVfDJNWySv+TBfnv031oELRS2nQk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DtEa6oHopPTxkqp8YD5Qnubf8qkYHdfdyGMUHeO52MGomUJhhy7Lu/PqnJJHpmZIx
	 f243u9HdaivS7yGB6OJ408EnuqbHV/4UR8PZTfBslbG8DtOt1F8yTVgpZ/ItCnkHiM
	 nn6VlnCi0DHrUdgJShpWlfDeLW2jifbo8e0BeF0r61K/UT94nl6zyqErH/7FZwr6pE
	 JUYB4NRdB3m+JmXPCAtoXgbx3K0PTIDl5jFjrkkL7VUrT6yL2uGvikKI3WEg4qOvZq
	 Q195W1JOoTmLBD0huRaG90QC3XjTGHBaXVam1yeBLEY3VfzKc9EqsW9gcmjrAiiUaB
	 jhjwYcVgdzKhw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Pablo Neira Ayuso <pablo@netfilter.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 233/238] netfilter: nf_tables: do not compare internal table flags on updates
Date: Sun, 24 Mar 2024 19:40:21 -0400
Message-ID: <20240324234027.1354210-234-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324234027.1354210-1-sashal@kernel.org>
References: <20240324234027.1354210-1-sashal@kernel.org>
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
index 73b0a6925304c..8d4472b127e41 100644
--- a/net/netfilter/nf_tables_api.c
+++ b/net/netfilter/nf_tables_api.c
@@ -1097,7 +1097,7 @@ static int nf_tables_updtable(struct nft_ctx *ctx)
 	if (flags & ~NFT_TABLE_F_DORMANT)
 		return -EINVAL;
 
-	if (flags == ctx->table->flags)
+	if (flags == (ctx->table->flags & NFT_TABLE_F_MASK))
 		return 0;
 
 	/* No dormant off/on/off/on games in single transaction */
-- 
2.43.0


