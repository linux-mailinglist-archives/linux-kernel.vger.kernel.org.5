Return-Path: <linux-kernel+bounces-101953-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 409A387AD09
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 18:24:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D44B6B23C97
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 17:24:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CB8113791A;
	Wed, 13 Mar 2024 16:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T+uOunmh"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54B1613959F;
	Wed, 13 Mar 2024 16:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710348162; cv=none; b=lSkOrkYOe3SzVx1L4XgEpgZgcaXIVWsJ8nUf77g8cG8pP8RUottDEeaBxH/gLio1yyKPQDVUQkXAseUXzSE9qKlw3ZM4PVE9Hrqblotud74e7guodI8isG8z8GQ8DJyd7KHXOoPgaH3QHRNF25ECjfvOXfVfUyPMnzC5q3cpHuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710348162; c=relaxed/simple;
	bh=Y0qmczXQKt4PXOHrKH1s+dGEO4SYk47hEsGX3+xvWyE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=g4rF44fsxpl8UdWfQIPLXeta0t8rqRIWFzJXFGIFzIPV9EliEitobdCLqjGztL+a6AKS1UFcxkFP56UYviIVHFvIT4AFxIAtF1H2BKrK5JHMsO4VvBAplJm0I2Aumx/B1Pi1xiLPfm88tob2Hz+ijGvOXJrzA9NxRlZEUaFZppY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T+uOunmh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18798C433F1;
	Wed, 13 Mar 2024 16:42:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710348161;
	bh=Y0qmczXQKt4PXOHrKH1s+dGEO4SYk47hEsGX3+xvWyE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=T+uOunmh59+FrDYBvW8rwzXVJbF0P7BpwU4OI0sQqDxTKE+UqOhw+ziJ/tJlDuxW1
	 wR5WbxfWmprNotTfvmuhymljoL2i4/WSRJArGLpFBIhOp4numjh6DfG9qAFZPjUJMV
	 dfVKUZ9g8nT6IeN/p5GqzEmb99FNu/VSNZVQ0yTDf5IZNpOCIr+hRISl5xM7MDp4X4
	 xVWY32W5rXD6MxbZlPjMbk0irDW3jjB+TdOzz8bAPeRI72p+VWjFgytdTmYf/eG6o+
	 MhjwHNK0hudGt6dHvXSRoIod9bKzsVvXm/NnNI8++UzXt1PFadCO4l69xMPwEimH9V
	 3rNPjT5GECqpg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Florian Westphal <fw@strlen.de>,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 13/76] netfilter: nft_ct: fix l3num expectations with inet pseudo family
Date: Wed, 13 Mar 2024 12:41:20 -0400
Message-ID: <20240313164223.615640-14-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240313164223.615640-1-sashal@kernel.org>
References: <20240313164223.615640-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.152-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-5.15.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 5.15.152-rc1
X-KernelTest-Deadline: 2024-03-15T16:42+00:00
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
index 7c667629c5149..69214993b5a2c 100644
--- a/net/netfilter/nft_ct.c
+++ b/net/netfilter/nft_ct.c
@@ -1192,14 +1192,13 @@ static int nft_ct_expect_obj_init(const struct nft_ctx *ctx,
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


