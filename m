Return-Path: <linux-kernel+bounces-116042-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 37F0388954E
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 09:25:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3FBF4B3B671
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 08:18:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC7D1272964;
	Mon, 25 Mar 2024 03:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YKhrZt4F"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBB5417653A;
	Sun, 24 Mar 2024 23:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711323434; cv=none; b=pYuZXn6zXpUKXJot3H4C6PijyywL6XWFZpkQP1+k5669R0pqW/Kw7T812IvzYP5S/l6TRO99+TTm1/1kZ91yBa30gGMtUwQcRmJVGVvlJKnOilssJ0OgAun3TZ4p6c2Kp5liE+3jrlGZydhfOYb0SW0cGXQOYJC64roaYkQ5GEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711323434; c=relaxed/simple;
	bh=vHQWxmR2KBzDLTijSawxGqzNKDYiaWW7CDZBDWPM3Bs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W05YbJGq8ITQMQ+gVvTtZ4uQpZX5252+S7izWX11lANLo9NLXrFsDL1Zq7w11pitxnkPfVjiHBMb3TmaHH6rrFS70ooVTE81fJ+ektESHa94mHV4/EI3el7DLLPQY7VqffndvQd2hTMS+ECW0XpUVFFMQvjJRwhFgyg6pKhfrJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YKhrZt4F; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06CF5C433C7;
	Sun, 24 Mar 2024 23:37:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711323433;
	bh=vHQWxmR2KBzDLTijSawxGqzNKDYiaWW7CDZBDWPM3Bs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YKhrZt4FPrPUQ6J0QvQ9l+4plGds6Xv6AaHs2fmNhlEUMVN206neUIeU3NJruTPYP
	 ywjsIuzCW82oey6YqQO46UAMHjbmLelvCF70aTI6ck5hJtz0nS/KUh7qFvuMpM7v1r
	 a58gOiBptHfBkKP0qoRAIRUiWOLAMNULIiCnwcaOvjQw/5hotM3fW21u8hUdDwp6z2
	 wiBRv9bauvfDyrnN6FFv9WrXoxJQKIAPQIM1rOmrRZUDRP46TBRHzzbEAD/K0LW1KX
	 v1K6lKY4pp2kIhBQztaAwvlF0YyecPisAX88Y5m6sLSgK7RGqLUoRE6sbz3fzNjda4
	 WnxealhnLxN/g==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Shiming Cheng <shiming.cheng@mediatek.com>,
	Lena Wang <lena.wang@mediatek.com>,
	David Ahern <dsahern@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 136/317] ipv6: fib6_rules: flush route cache when rule is changed
Date: Sun, 24 Mar 2024 19:31:56 -0400
Message-ID: <20240324233458.1352854-137-sashal@kernel.org>
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
index dcedfe29d9d93..8e9e80eb0f329 100644
--- a/net/ipv6/fib6_rules.c
+++ b/net/ipv6/fib6_rules.c
@@ -446,6 +446,11 @@ static size_t fib6_rule_nlmsg_payload(struct fib_rule *rule)
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
@@ -458,6 +463,7 @@ static const struct fib_rules_ops __net_initconst fib6_rules_ops_template = {
 	.compare		= fib6_rule_compare,
 	.fill			= fib6_rule_fill,
 	.nlmsg_payload		= fib6_rule_nlmsg_payload,
+	.flush_cache		= fib6_rule_flush_cache,
 	.nlgroup		= RTNLGRP_IPV6_RULE,
 	.policy			= fib6_rule_policy,
 	.owner			= THIS_MODULE,
-- 
2.43.0


