Return-Path: <linux-kernel+bounces-116223-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 548948895B8
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 09:36:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 85D651C2128D
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 08:36:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7B343BFFC1;
	Mon, 25 Mar 2024 03:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i7SvjVa9"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1BB417DC3F;
	Sun, 24 Mar 2024 23:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711323852; cv=none; b=rR+e3id2kFgbvgTtu6pwwV+ImHpSBS+9QIJ37CNgIszfF6UE920KYUnzKvv+tadeX0T8nH82CeLbJGjVbGa5WSED56KwFp2wZOZKZQKCjkFVvylXsWLmJA0kPHp17sWuJ+l2FkYQb6rSBz6lt6oEKxh1q4CoYMfgTarS6NnTLjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711323852; c=relaxed/simple;
	bh=5+hdcCy5NUJAL46bniLz2w4EeDTmKteFOedaHnQJd5c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CV0NpGQfQ0fXgQsXyAkc7o4DJ7OT9xiOOK3826TfYCrO2lhtoxUnP2470oRWEVoTcB8jIPY38pv4oauNK8gSsSLNRBHOKEKACazKPq6Qs5LcQBKiVsUmV/XXwV63e3z9+xykF5jLlNQALAxobRw2g5EkJmI9G2KFy1Tt7x8VFwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i7SvjVa9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD3A9C433F1;
	Sun, 24 Mar 2024 23:44:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711323852;
	bh=5+hdcCy5NUJAL46bniLz2w4EeDTmKteFOedaHnQJd5c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=i7SvjVa9rzRBUbMcI0j2Rc5jFqfeEyUDIEbPlj4597G3zN07DWAWsdkT5L5CV9Zl+
	 DDiF9b2sOowTuS1WBtfGVUbYXimHp5DBmrXWaMlN3hYwvyWnG283e75fOG1yy8AMm5
	 mA7QC9sU5U2FMsbapY6K4ua7l2B116f5A2+GF7KeomUK3IuNHdc6O11NBp9Z/03bGO
	 /G3s3uowFTcbbJpgGi2dfTZ9kbYoVyT1YmgEbt6P4mcRGwO28V1uCmfJcA53jLwY+U
	 HbTuYX42teXGTuI0myDTjmHtF/1ZbW5NPPBHYNrC3jsZ2PrMQ2QLXODPHlPuSpXLVD
	 zAc8LeJz33Vog==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Pablo Neira Ayuso <pablo@netfilter.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 230/238] netfilter: nft_set_pipapo: release elements in clone only from destroy path
Date: Sun, 24 Mar 2024 19:40:18 -0400
Message-ID: <20240324234027.1354210-231-sashal@kernel.org>
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

[ Upstream commit b0e256f3dd2ba6532f37c5c22e07cb07a36031ee ]

Clone already always provides a current view of the lookup table, use it
to destroy the set, otherwise it is possible to destroy elements twice.

This fix requires:

 212ed75dc5fb ("netfilter: nf_tables: integrate pipapo into commit protocol")

which came after:

 9827a0e6e23b ("netfilter: nft_set_pipapo: release elements in clone from abort path").

Fixes: 9827a0e6e23b ("netfilter: nft_set_pipapo: release elements in clone from abort path")
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/netfilter/nft_set_pipapo.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/net/netfilter/nft_set_pipapo.c b/net/netfilter/nft_set_pipapo.c
index 70a59a35d1761..b9682e085fcef 100644
--- a/net/netfilter/nft_set_pipapo.c
+++ b/net/netfilter/nft_set_pipapo.c
@@ -2226,8 +2226,6 @@ static void nft_pipapo_destroy(const struct nft_ctx *ctx,
 	if (m) {
 		rcu_barrier();
 
-		nft_set_pipapo_match_destroy(ctx, set, m);
-
 		for_each_possible_cpu(cpu)
 			pipapo_free_scratch(m, cpu);
 		free_percpu(m->scratch);
@@ -2239,8 +2237,7 @@ static void nft_pipapo_destroy(const struct nft_ctx *ctx,
 	if (priv->clone) {
 		m = priv->clone;
 
-		if (priv->dirty)
-			nft_set_pipapo_match_destroy(ctx, set, m);
+		nft_set_pipapo_match_destroy(ctx, set, m);
 
 		for_each_possible_cpu(cpu)
 			pipapo_free_scratch(priv->clone, cpu);
-- 
2.43.0


