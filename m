Return-Path: <linux-kernel+bounces-101838-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F126B87AC07
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 17:56:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC7F6287279
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 16:56:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23EBF6024B;
	Wed, 13 Mar 2024 16:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D5Qjsk66"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C5AC6F53A;
	Wed, 13 Mar 2024 16:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710347874; cv=none; b=fv5n++KEdOGIekouhdEjF/tNy9o+/8DwGHKNYK24cUdYsEc/b0vcENfeWxBpkgrZg/oat6L5tGT4m3XM/bG/6n+h/A4+XDkP271JadYeEr8VmFnC1zqYgVBz+nfo376fddAewx6TBtdsGRlxHIVxalJKqCXi85iVMhtR46aDAhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710347874; c=relaxed/simple;
	bh=9vQrnnejhIN2O38VyFzgPFbVVMiM3I4ozD7eswGJBvE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OI2dEZXULMc/qwqg+YmM+wejdASBgut2RI7qidZYQj4Lf4uBHZCM8YqxjsDRgfSsiIYtRu9/DsJYuxK1myprW0v4Eri8s3W3FsmATwnugAv/OeLsa9V62i1mKgmkHj2mdTJqnrNc6SvsWUriJwqil/CPbDBJCL/aMdqckOR0HEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D5Qjsk66; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DB9EC43394;
	Wed, 13 Mar 2024 16:37:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710347873;
	bh=9vQrnnejhIN2O38VyFzgPFbVVMiM3I4ozD7eswGJBvE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=D5Qjsk66Nv6KChPviEpN+A4BdJqPLBZSY+8WP4j6ebfhJZ6MOu8XX/fhvFdSERE5I
	 XhOG8OjSVvhzd3v0AP4/+VJ38rEDmXLBjxDsljuozgOJ/n5nLhkO1BTOxIqpdtGvTu
	 bP1gsWs1M7xkMWC9HFFqnf86BWMFRO+Nlm1PvTtMmXG2D1MpJPfX/TcFbX+HvuhbWT
	 FSFg59WAt/DUkiK/CaTgwerLmcoxpiGiKKivqEv49BsUOWgyEFrXrhcyImTfJI1eHI
	 hbwA9WMOa4/UrPHfI3TxWfx4J9Kk1owIKHWmXprWBMeRVweSp1/UbcPiUkMkBD4t30
	 VrS2/l2LRIDTw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Florian Westphal <fw@strlen.de>,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 35/60] netfilter: nft_ct: fix l3num expectations with inet pseudo family
Date: Wed, 13 Mar 2024 12:36:42 -0400
Message-ID: <20240313163707.615000-36-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240313163707.615000-1-sashal@kernel.org>
References: <20240313163707.615000-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.22-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-6.6.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 6.6.22-rc1
X-KernelTest-Deadline: 2024-03-15T16:36+00:00
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Florian Westphal <fw@strlen.de>

[ Upstream commit 99993789966a6eb4f1295193dc543686899892d3 ]

Following is rejected but should be allowed:

table inet t {
        ct expectation exp1 {
                [..]
                l3proto ip

Valid combos are:
table ip t, l3proto ip
table ip6 t, l3proto ip6
table inet t, l3proto ip OR l3proto ip6

Disallow inet pseudeo family, the l3num must be a on-wire protocol known
to conntrack.

Retain NFPROTO_INET case to make it clear its rejected
intentionally rather as oversight.

Fixes: 8059918a1377 ("netfilter: nft_ct: sanitize layer 3 and 4 protocol number in custom expectations")
Signed-off-by: Florian Westphal <fw@strlen.de>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/netfilter/nft_ct.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/net/netfilter/nft_ct.c b/net/netfilter/nft_ct.c
index bfd3e5a14dab6..255640013ab84 100644
--- a/net/netfilter/nft_ct.c
+++ b/net/netfilter/nft_ct.c
@@ -1256,14 +1256,13 @@ static int nft_ct_expect_obj_init(const struct nft_ctx *ctx,
 	switch (priv->l3num) {
 	case NFPROTO_IPV4:
 	case NFPROTO_IPV6:
-		if (priv->l3num != ctx->family)
-			return -EINVAL;
+		if (priv->l3num == ctx->family || ctx->family == NFPROTO_INET)
+			break;
 
-		fallthrough;
-	case NFPROTO_INET:
-		break;
+		return -EINVAL;
+	case NFPROTO_INET: /* tuple.src.l3num supports NFPROTO_IPV4/6 only */
 	default:
-		return -EOPNOTSUPP;
+		return -EAFNOSUPPORT;
 	}
 
 	priv->l4proto = nla_get_u8(tb[NFTA_CT_EXPECT_L4PROTO]);
-- 
2.43.0


