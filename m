Return-Path: <linux-kernel+bounces-113789-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C356388869D
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 02:38:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 64853B218A6
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 01:38:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E24C314D70E;
	Sun, 24 Mar 2024 23:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FoVDj5uc"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68F69128386;
	Sun, 24 Mar 2024 22:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320803; cv=none; b=n+6uBUephKNVbHKs5IYMlfin7mLH908JlQ+7kcqOiWphvdyWCoutqkVlhjwuIhVvHttjhG5ajYtwIYpZUyGdwK/LRXIDOrzpP269zbFCl64+Xt3F1BG5hju4T4uMazTS44afkhAB3lHuK5GUJKzUoabybfLODAqCgYnYmqYOWPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320803; c=relaxed/simple;
	bh=pNcFH+ooFkIv/Gh6pWZygMrI9+wZ6KT5OyHzXrzdBTc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AL0z8MZNdvDrci1u91pWPVHFV/Q+LD5mVvU76MfyL2ZrjgNI/IPAWFuGD4rSyipuIY8iaxBS0R3eRshUBadS3cOHWqez0mZweMFyqN2zh8ebMCu+DC3VmVKdzjZNfqkrR8wDsVR66reQVds6c351cOGuTr0TT4jiTkcCsyqgAy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FoVDj5uc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 300AAC43390;
	Sun, 24 Mar 2024 22:53:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320802;
	bh=pNcFH+ooFkIv/Gh6pWZygMrI9+wZ6KT5OyHzXrzdBTc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FoVDj5ucybIRw2upv0FYUE+cgNdYdi233/uv4k6aimRQYceA0G9mdpUzyY+hP2TcS
	 vjKIy9AJ7e3mye97sm8teDH5WlA8SaRjvOUzn9gjCLgPzXXYe55MDCXw7vmneTrGLS
	 QIvjhLxlHB3RwKeV2WDhtpZp0N5kTnKPrGpHRnXJLWQILGeKHAVwS4yCHZSQ3vgWQn
	 biE3QcrRaWbZ58f3HNrIGirb0ONAUVU6Wy6l3GA4rDcIvi3BN2nrWSpW/Y99six3G7
	 FpDL85meQI3txfoFlkJE5MWRoSd1F8sJXtQ/DcD4T2CUTQiiFXA45A2gMi7u2jY+/u
	 l7/5Vi9Kly6Og==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Shiming Cheng <shiming.cheng@mediatek.com>,
	Lena Wang <lena.wang@mediatek.com>,
	David Ahern <dsahern@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 366/713] ipv6: fib6_rules: flush route cache when rule is changed
Date: Sun, 24 Mar 2024 18:41:32 -0400
Message-ID: <20240324224720.1345309-367-sashal@kernel.org>
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


