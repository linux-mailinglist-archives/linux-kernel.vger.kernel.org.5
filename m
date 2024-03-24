Return-Path: <linux-kernel+bounces-114924-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 104BB888C02
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 05:06:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 375741C298C6
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 04:06:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 591582D66B6;
	Mon, 25 Mar 2024 00:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HLCZBELk"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E24CD27F09D;
	Sun, 24 Mar 2024 23:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711323601; cv=none; b=kD6dc63YKaBsthQM/2oYwe18EGXAzuLDUwoZtRgvuBNLawFA29t1YBXKl9izKI33s/0uOt8J6ft4qDLJMwgV3TgfhzOnWUtgMLW7m1n/TBkhv+VAKAwDFFvEKeJgXKFtnGDNCdGiWLpcyWrVRBRHjlOa0hkGwkP8hMJtfmMrop0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711323601; c=relaxed/simple;
	bh=D/U6K3wYlUvCX0zIlRt82+95pj2oHpt2nOXoNWzTP38=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DKi0qFKaMQLjzfQd85CY0iIP+xyBWa9XL2iuotdGuQ6MGVfY9bNACpm5AJeJgKE9wraIAIBR0/LfEI7QPJuFdEdOtnkk/HwPEkJ6QKlvxKxoGca3kDIKrXUguY09vsX5wNz4iNN8tjjCAitrZXnVI06GzkIFtdrzsk8683OYrcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HLCZBELk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43F71C43390;
	Sun, 24 Mar 2024 23:39:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711323599;
	bh=D/U6K3wYlUvCX0zIlRt82+95pj2oHpt2nOXoNWzTP38=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HLCZBELkoGSydkz1sXv1Dl+JemmUIlupMB8cB5cgrsEbku9xwtC6GhXts2bFUAjS/
	 qi+6uoaeMzvbgXNYBL2V1Mjmi8IM+CiXTIg/yLmfgHvJ3Fzezphfq68+SX+sZldtzS
	 5HLia9TwTcrlgsWoAA58MPgi/UylnsU/2iKhRZnay8mTg2wrTkLqih3j/Ckavct6eq
	 lDZLQULhy5NiW05xnjfj9g/yz/602DkALyHriqrFTRBtjFxswNmUWAJ54Gi2Pz0U1W
	 blTjgbtYtQE0dJM4sVRBhmspUgEOUa6JPPpEsZRq2+UqJqHglqxxnUtlf3fK8Q2ZXY
	 6DqcJoC/g1mdQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Pablo Neira Ayuso <pablo@netfilter.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 306/317] netfilter: nft_set_pipapo: release elements in clone only from destroy path
Date: Sun, 24 Mar 2024 19:34:46 -0400
Message-ID: <20240324233458.1352854-307-sashal@kernel.org>
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


