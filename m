Return-Path: <linux-kernel+bounces-114703-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A2968890BE
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 07:26:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4095D1F2B337
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 06:26:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E57712BAA79;
	Mon, 25 Mar 2024 00:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hhjSiVY2"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 431C615FA81;
	Sun, 24 Mar 2024 23:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711322356; cv=none; b=tKqsHfWo5zcBufy6CYkPoK5xKC/GjBhjmM2vc1X1WKH+Qt/vIjKZe2iHKZGx9mrkmBvSB5gTur3ZSjOSiRIn8B+RaR6rPM1PvYCa43Lj2pvVjVqsL9nrVZXUXKbWfoE28B+Cu/BaI6NyPBVIrgnFF0xgauE82ymeqL0cOGMkkwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711322356; c=relaxed/simple;
	bh=D/U6K3wYlUvCX0zIlRt82+95pj2oHpt2nOXoNWzTP38=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BATgHTTBeJh+GsxassOQ3u6V3/fSyKY5LdKkjuC/tpzSjHQCJ7mSFbKFg6fKa30RBs8RwK+mYO3wnPv8NseYe/uZ2qRAZ+wl6cAqBFxawdmnL7N5Zjqs7L6g4wOl90p8Nv5ZGykHdz2oKkuwmj6LlXCB5rJsrcLz188lMk5/nCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hhjSiVY2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96E1FC433C7;
	Sun, 24 Mar 2024 23:19:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711322355;
	bh=D/U6K3wYlUvCX0zIlRt82+95pj2oHpt2nOXoNWzTP38=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hhjSiVY2jexQR88vNcbq7U3eSNJt4lRjZk1sqqZs7JRdpsEfBbG8XICh72gfEdyRU
	 9lLMcq9kVZefcCiaOoEqIDPbZLXzVcqpKHDjqBZUbFPYD9jKlIHI7ITOQvhBlxIYeJ
	 Wn3q0yMfNDR2xbjtElHek7axXS/Qh5Dot4GxP0Z61mcuRSVbhAUdyRXFL3S4f7FU/N
	 9wnPSFBhtHZXMdmvEMq5p4s9qVYFr05dF2P7pIkFo3ffcSoAm8B5HGwu6tgAaeTcbd
	 Zp99bWUbolXf+yTStDn4i9qzs+0pYiRUwDR76XBpKhgoMMQ55G5dL5scBcMPlx8asF
	 a+SRUI4NjfHKQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Pablo Neira Ayuso <pablo@netfilter.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 437/451] netfilter: nft_set_pipapo: release elements in clone only from destroy path
Date: Sun, 24 Mar 2024 19:11:53 -0400
Message-ID: <20240324231207.1351418-438-sashal@kernel.org>
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
index e1969209b3abb..58eca26162735 100644
--- a/net/netfilter/nft_set_pipapo.c
+++ b/net/netfilter/nft_set_pipapo.c
@@ -2240,8 +2240,6 @@ static void nft_pipapo_destroy(const struct nft_ctx *ctx,
 	if (m) {
 		rcu_barrier();
 
-		nft_set_pipapo_match_destroy(ctx, set, m);
-
 		for_each_possible_cpu(cpu)
 			pipapo_free_scratch(m, cpu);
 		free_percpu(m->scratch);
@@ -2253,8 +2251,7 @@ static void nft_pipapo_destroy(const struct nft_ctx *ctx,
 	if (priv->clone) {
 		m = priv->clone;
 
-		if (priv->dirty)
-			nft_set_pipapo_match_destroy(ctx, set, m);
+		nft_set_pipapo_match_destroy(ctx, set, m);
 
 		for_each_possible_cpu(cpu)
 			pipapo_free_scratch(priv->clone, cpu);
-- 
2.43.0


