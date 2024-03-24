Return-Path: <linux-kernel+bounces-113592-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D2B9188858E
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 02:10:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0FA071C24DDF
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 01:10:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6C531CC5FC;
	Sun, 24 Mar 2024 22:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QlGJemNe"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D3591CADB7;
	Sun, 24 Mar 2024 22:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320395; cv=none; b=XJUzNDxWalvECHTGnBMx0b2dWiH6rmyvOPNc2DXNpEp8jZ0CKEKhMbg6XV0XNObauoUL3FwDqxPZ0AVfbSCUYQgwTZ/TYFD/6dMv7tDphhoeUvAJYyZ74yXGlO6htCCzRKoOevzQWQ9b1PXO2ipXy7XCLzFpWKgAdqIQZ5VQW48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320395; c=relaxed/simple;
	bh=3cugA918L+ok7yRN6AhqP9YapzoDWyzLrD3lHQaYdFM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KvzPUnTxOVEQr2hJyYMvDWV6/FoUASR3cqCL3/6Xy5+7zvcyXXpDCZ5Yt9iJBLekCTt0pmgZCIXMn3IxHJFzByFb24P6RI+gD9Bpw9YymtB3AER9LG6x/VU9s25MnamU0nLzY4k3kWhqOVSOtPYi7Y9U5orSNlBG6jZhOLLIoG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QlGJemNe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 810A2C43399;
	Sun, 24 Mar 2024 22:46:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320395;
	bh=3cugA918L+ok7yRN6AhqP9YapzoDWyzLrD3lHQaYdFM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QlGJemNeYiJAG1YE2ydlnckwhtJL6tGvaTYF7GLASwEPsC7T3BKX/WAuTwzl9Dv1g
	 yj50NqxlVu4Y2sVI7b2OzHHRQLGGMQD+Yy0uTpiSWzoKpaHVCpRJDELD6COCDn8G13
	 jlsnzstX+mclmQ6GiOeInVzGE7od/aMc6aLXayTEtYch8nzSKW3t2ERj0Uy+QorK8R
	 8CFrcKzn2z3Cyx0Hogxnk+VPbLZ9f59TjBzDBM1mBsXy+F7fCLYTwxvw/Kkt1oYXE0
	 XNUPO3ZWQSrGd0QJIAU/2Oyj+GbYeDnkG7Js+AIWXfs1B6ZIbKXFXCIQTZkImz6RVl
	 ANqlBcv8WajyQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Pablo Neira Ayuso <pablo@netfilter.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 701/715] netfilter: nft_set_pipapo: release elements in clone only from destroy path
Date: Sun, 24 Mar 2024 18:34:40 -0400
Message-ID: <20240324223455.1342824-702-sashal@kernel.org>
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
index aa1d9e93a9a04..b3b282de802de 100644
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


