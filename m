Return-Path: <linux-kernel+bounces-102131-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CE52887AEAD
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 19:05:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6F0571F2EF3D
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 18:05:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB9F56EB62;
	Wed, 13 Mar 2024 17:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kCNrrKKy"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAA436EB50;
	Wed, 13 Mar 2024 17:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710349348; cv=none; b=iD0JDwgo/AXuTyg27DG+BA8EuflwlEyunz9ofgur+BuDR7/PerzShotODf5zZnBEXw4Jo8jEsR4f23p8pgQuj6EXPuTvEezlMpE/UV+x0Urplpu1iiDhj7KWUNxwEmUhdpDHyY/gl4Uiv3V/1Y/BiWBqWvuuN0Eu9BDTlhfkI3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710349348; c=relaxed/simple;
	bh=sxaJh8N6w1+moSiX2K+oKU9iYmRfqg3p03xuyHagoQA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YnG9cQSERRTkSQMPQosMq1Ay5gvGd2yjExDb5SJ/j5MKOYkS0EPqBqDy0k6uFjacddjMOjyZ5l8UWjfgvdq4D7Xk+rWmPZuS299jVJoPqQmaGHOkOQtGdfk+MLTKct1hwKiRy32uWx86CuKJO8/L5xtUa8CggE8OO7ysppG2950=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kCNrrKKy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D26CCC43394;
	Wed, 13 Mar 2024 17:02:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710349347;
	bh=sxaJh8N6w1+moSiX2K+oKU9iYmRfqg3p03xuyHagoQA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kCNrrKKyRfXi6ZkPPhffbmTtESsWnB5/MQ8RVqfW8PH7pCrmb2MhTomJPS21zX0VK
	 4Kp41b3mXxBl9EKdbtkiXxqxfHjyoPhoUZalOQsvfaSs7uBxTOANz1eNJv4rG7DPC6
	 Bina2Lg5NDQ414rpS78ALacfyA3y8S4gULYcdQl4AD+4jpCBnTdVoWLs27VITFcMNY
	 cBij6LjQioR9Bvgt+ETijb/n+QxhYm4weiIK0LvK3POvn2UEFnl7+F1BY2FqqwqnE2
	 4GOKupGzrjhGDtuCZ/0Sgo+Bdks8jOAaT//DZej29rwyEQ+B+MBxr3A2YfMz1lPNoL
	 NuPM+0NnZuuMw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Florian Westphal <fw@strlen.de>,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 11/51] netfilter: nft_ct: fix l3num expectations with inet pseudo family
Date: Wed, 13 Mar 2024 13:01:32 -0400
Message-ID: <20240313170212.616443-12-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240313170212.616443-1-sashal@kernel.org>
References: <20240313170212.616443-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.4.272-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-5.4.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 5.4.272-rc1
X-KernelTest-Deadline: 2024-03-15T17:02+00:00
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
index 161c4fd715fa5..0c7f091d7d54d 100644
--- a/net/netfilter/nft_ct.c
+++ b/net/netfilter/nft_ct.c
@@ -1180,14 +1180,13 @@ static int nft_ct_expect_obj_init(const struct nft_ctx *ctx,
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


