Return-Path: <linux-kernel+bounces-115581-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 49FE4889C86
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 12:22:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F2D3C1F35875
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 11:22:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAD5734110B;
	Mon, 25 Mar 2024 02:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hK3xDRtk"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B89AF14BF8A;
	Sun, 24 Mar 2024 22:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321137; cv=none; b=iutDTwrbv+17/Tazq9byk4eNunM9DHjzWU44e2N2932idI7bwpyiVa3tTe8Oh/dOO7mM7fDFOjfydDFzEOXnVoFQ/AfNN1/i9QPYpRE1qo5sTU2j+NS1Ym92fXUWL+1SgwMh0sj/Dh8aUJ9a4d8JaAQxh2GEXj6GP8P+O/62k3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321137; c=relaxed/simple;
	bh=EIhiavJ7/U+ClqzyWUkS3UyMZcurrx/Dl/X6S8ZR980=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K2dpNvOJeNjYmzOsgI3BQkyXUN6ZmT3MtN0lj17hxrf0orVUmkyM+i2enw5dcO8yy3LnnsqWzHWTFK6rZZmUyY08TWjnqEDU8bI/ePauYIkTEqUn/sLz76xvYaF+yerslyDRI2TYKprbX+jaNKjADzY12cIE5T5vhxN1iHKQ1ic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hK3xDRtk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17395C43394;
	Sun, 24 Mar 2024 22:58:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321137;
	bh=EIhiavJ7/U+ClqzyWUkS3UyMZcurrx/Dl/X6S8ZR980=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hK3xDRtkw2cC6ZTnioF2gqSxmyad9vm6i85xu6+24wg2OH7em52bcPE5ues7F1RWk
	 jiJPkBaQCiAw8y42FURRN/ACry8rTkPM4PtjCiLoQ/0fmTWeWHPJUBKHr9inNkVjdJ
	 pcGq5jRBEHuZhjLv1oQyo1d6BRTBYOWJuDDt7zl0d4uM3DFU8sFc9q6IiFfvQBvYsq
	 eq7VnC3bb6OBhJERU/1dRTkZmLGLKsmAnF5e6cEcJIfmV8qHM+quIpTS5klykk0+Hb
	 vN2aLFR0zFIS8QRTPyRhMLIiKsjRiI7XjtPn+MoDGCqU9Chj78EDPDs+yffXcnycyb
	 buwP0wZZnSLpw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Pablo Neira Ayuso <pablo@netfilter.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 699/713] netfilter: nft_set_pipapo: release elements in clone only from destroy path
Date: Sun, 24 Mar 2024 18:47:05 -0400
Message-ID: <20240324224720.1345309-700-sashal@kernel.org>
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
index 3089c4ca8fff3..abf659cb2d91f 100644
--- a/net/netfilter/nft_set_pipapo.c
+++ b/net/netfilter/nft_set_pipapo.c
@@ -2244,8 +2244,6 @@ static void nft_pipapo_destroy(const struct nft_ctx *ctx,
 	if (m) {
 		rcu_barrier();
 
-		nft_set_pipapo_match_destroy(ctx, set, m);
-
 		for_each_possible_cpu(cpu)
 			pipapo_free_scratch(m, cpu);
 		free_percpu(m->scratch);
@@ -2257,8 +2255,7 @@ static void nft_pipapo_destroy(const struct nft_ctx *ctx,
 	if (priv->clone) {
 		m = priv->clone;
 
-		if (priv->dirty)
-			nft_set_pipapo_match_destroy(ctx, set, m);
+		nft_set_pipapo_match_destroy(ctx, set, m);
 
 		for_each_possible_cpu(cpu)
 			pipapo_free_scratch(priv->clone, cpu);
-- 
2.43.0


