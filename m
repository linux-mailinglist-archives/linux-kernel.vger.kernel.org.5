Return-Path: <linux-kernel+bounces-101884-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B801387AC6C
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 18:07:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 56DBC1F2B6FB
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 17:07:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 507287A120;
	Wed, 13 Mar 2024 16:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mJVufpC3"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B5EB612DD;
	Wed, 13 Mar 2024 16:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710348019; cv=none; b=fOVu7RtxnbLuA/p2joBVKIB1fWk6/87af7sNBG9T0FUEYt79aGF29yzm++Ns/C862ER68vyKrxKx3SmN16Tshzr3DbzJvdtJppCFJsUP+FlDtUNY82RMfSTCruBEP1kivR0Ds5s7RWNmjQ+6/C2zREOj7izMcejH3yXKkIzFx/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710348019; c=relaxed/simple;
	bh=JdD7X77XnXeI4WBsramYDVw8WqQ9lSPm31vyCIfEuyE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SgDXw5d+TXY6L/M1Dm8u6EuhHv4wJuK7w8iNImAQQHzfv5wpz3qdJHDY/c6ygnttkHloZEM60hwxHnzCNSKXc+hqEHxcYOsUhp3m/iC++TP6JQ7JKy4lpXTIpUZOvhFGnX9ZRXrURdnSUWYOeKs5CjsoeuflpOA4nPzwA6Z9bcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mJVufpC3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB3ABC433F1;
	Wed, 13 Mar 2024 16:40:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710348019;
	bh=JdD7X77XnXeI4WBsramYDVw8WqQ9lSPm31vyCIfEuyE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mJVufpC3w5JiHKPkcoHutcZ8LIyi+bOBTqjTMHgaSQILHqmBzsacDpvHSD+vMKbRv
	 jbmvz+FumAIXp2FF0R8axX4iM2SlWXWflEI3zTNSJdsk63I1qZReOJohZzLPg9E1By
	 ZVz9VImW25yzCScU6D0fjiSUDQmc5PHld6++FTByRwwPXEsUV8hsBarnwzlyjWm+1S
	 TWVb4C42oJ21q6JPVWlW2hnfUyIMvdiYmxXOKZidYw2NcaTavPKep24fLZNWOsaQ9L
	 nhKtEHIdBIo8E6+tMtj74dtRRztr0DHMEEiVt2KM2ldiNiui2nhuQ38P/b5MhoC7Kv
	 kZqC6UqOWo6pg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Florian Westphal <fw@strlen.de>,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 16/71] netfilter: nft_ct: fix l3num expectations with inet pseudo family
Date: Wed, 13 Mar 2024 12:39:02 -0400
Message-ID: <20240313163957.615276-17-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240313163957.615276-1-sashal@kernel.org>
References: <20240313163957.615276-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.82-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-6.1.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 6.1.82-rc1
X-KernelTest-Deadline: 2024-03-15T16:39+00:00
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
index 8df7564f0611e..2bfe3cdfbd581 100644
--- a/net/netfilter/nft_ct.c
+++ b/net/netfilter/nft_ct.c
@@ -1237,14 +1237,13 @@ static int nft_ct_expect_obj_init(const struct nft_ctx *ctx,
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


