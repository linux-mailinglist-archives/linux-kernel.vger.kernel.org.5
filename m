Return-Path: <linux-kernel+bounces-114217-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D454888927
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 03:46:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 12B771F2D515
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 02:46:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 937122519B4;
	Sun, 24 Mar 2024 23:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tnn4/sOL"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 579F91384A4;
	Sun, 24 Mar 2024 23:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321591; cv=none; b=jrWmfn9ZszeSLoZQBkVAlvuG2OxPsx1oGH8+fn9/hKJ4I97u4Z23iLt0iCjyK4OqASG5sdGhJcBadMVeaa0q7aTK8CPdQOZkfPBXghcXrrYAyUQNU0sU66LUZbn1BXDQ7J1L8CPnqQ+cfqpOrgfBbUiOl9f0V7aMODLHwkBWagc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321591; c=relaxed/simple;
	bh=pNcFH+ooFkIv/Gh6pWZygMrI9+wZ6KT5OyHzXrzdBTc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bzFBD9qbto6mH6AVyXtaPG+FCNyd3rg2DVatPBWZggN9mrLz9XBalL17KjXJR/IQ1Fjedgw9PvQ0WKwHNr48f92346cEz/mSRZCqYJWvFdpo8HR+VC15w4afDK7tRYIGFhsiuBh6VPyLqUiQd4PD70/Kmk4xsads3LznXYg2UZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tnn4/sOL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6AE0DC43394;
	Sun, 24 Mar 2024 23:06:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321590;
	bh=pNcFH+ooFkIv/Gh6pWZygMrI9+wZ6KT5OyHzXrzdBTc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Tnn4/sOL7KL4cJd+v3EhqAY8yProSz0cshrbEAbjXF5Ffo+EtVVr1v6u4pPfnacdM
	 mpXccYSSMoTiYVk0hik5HEmBrWtKLfYGD0KQwB70nMPoFAiuNgpRWML9gwTnl03whh
	 j2URncIDoC5Po5aH/076HLdSl4xvMROsmHiWre5a7QB57PLRpGxo16sCfmUNsmwSXN
	 VdE6VtOjZTxvrg2mJmvoY7OoRJOXpNxin9Z1CKYJxHGvs57EPC86aqfLOe2paE4cWd
	 XwlTBi1I/HCePYoOH3x6j02MHGG22W+HFwSelWvZF0FGdU5Du/wrENKbv0Dp60nSkr
	 DHKQIS9aQyQjQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Shiming Cheng <shiming.cheng@mediatek.com>,
	Lena Wang <lena.wang@mediatek.com>,
	David Ahern <dsahern@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 320/638] ipv6: fib6_rules: flush route cache when rule is changed
Date: Sun, 24 Mar 2024 18:55:57 -0400
Message-ID: <20240324230116.1348576-321-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324230116.1348576-1-sashal@kernel.org>
References: <20240324230116.1348576-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Shiming Cheng <shiming.cheng@mediatek.com>

[ Upstream commit c4386ab4f6c600f75fdfd21143f89bac3e625d0d ]

When rule policy is changed, ipv6 socket cache is not refreshed.
The sock's skb still uses a outdated route cache and was sent to
a wrong interface.

To avoid this error we should update fib node's version when
rule is changed. Then skb's route will be reroute checked as
route cache version is already different with fib node version.
The route cache is refreshed to match the latest rule.

Fixes: 101367c2f8c4 ("[IPV6]: Policy Routing Rules")
Signed-off-by: Shiming Cheng <shiming.cheng@mediatek.com>
Signed-off-by: Lena Wang <lena.wang@mediatek.com>
Reviewed-by: David Ahern <dsahern@kernel.org>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/ipv6/fib6_rules.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/net/ipv6/fib6_rules.c b/net/ipv6/fib6_rules.c
index 7c20038330104..be52b18e08a6b 100644
--- a/net/ipv6/fib6_rules.c
+++ b/net/ipv6/fib6_rules.c
@@ -449,6 +449,11 @@ static size_t fib6_rule_nlmsg_payload(struct fib_rule *rule)
 	       + nla_total_size(16); /* src */
 }
 
+static void fib6_rule_flush_cache(struct fib_rules_ops *ops)
+{
+	rt_genid_bump_ipv6(ops->fro_net);
+}
+
 static const struct fib_rules_ops __net_initconst fib6_rules_ops_template = {
 	.family			= AF_INET6,
 	.rule_size		= sizeof(struct fib6_rule),
@@ -461,6 +466,7 @@ static const struct fib_rules_ops __net_initconst fib6_rules_ops_template = {
 	.compare		= fib6_rule_compare,
 	.fill			= fib6_rule_fill,
 	.nlmsg_payload		= fib6_rule_nlmsg_payload,
+	.flush_cache		= fib6_rule_flush_cache,
 	.nlgroup		= RTNLGRP_IPV6_RULE,
 	.owner			= THIS_MODULE,
 	.fro_net		= &init_net,
-- 
2.43.0


