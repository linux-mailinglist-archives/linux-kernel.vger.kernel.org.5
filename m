Return-Path: <linux-kernel+bounces-115090-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 20542889325
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 08:21:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D212CB2F82F
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 07:18:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4A822F843B;
	Mon, 25 Mar 2024 01:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hF+WwWJS"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E8B7181303;
	Sun, 24 Mar 2024 23:47:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711324075; cv=none; b=NBxpR6WTEnYgREjsQCKcdQNOp8bh2C2IX9XYZoy1p+qHrE8cfujd7+yXPKcpUfsAW8CjDxVZc0PgbDLY6FFz+DiXbDTVzGPMzELJSSI2TNogBeLvGXCDGkPO4d7d+0nI+MRTVAlmYUwK2+NLnkuLxeL9YSegSy/DoTW9uVXIr+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711324075; c=relaxed/simple;
	bh=8dXL1NGG6IxVREHyDsFoctPuUt9MiE7fpvULh0eGgbw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R2tWlYN90Ex0KkAtHp3NW/HPeVh1UYsM9+QxEShMZB7Mdw5xGlZyqjfu23Vfvj1sW5cnLte5i+YZ9Kte+IbMojx703GnrWN1wAeLhEtuUo9RRXTLaMM3EWvwsbsC4prlgKXonqH3McdvTzUuby58Xre6/B2aZgqdKtLlJ5PcVWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hF+WwWJS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40526C43399;
	Sun, 24 Mar 2024 23:47:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711324074;
	bh=8dXL1NGG6IxVREHyDsFoctPuUt9MiE7fpvULh0eGgbw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hF+WwWJSzYltf+TXTLWJlbmHW+S/E2BTrnSOT/HJJS0kdu7LWmV2C72o5asCzNlS6
	 ZyN2cjx/kq9iDklRxOWuviq2LIUKOcQ0VeDVRCwkrPg70jvGY0WBwoyTHEfaQzovFi
	 iNA6Ob2EP2myv/0GHdm5SV7KcVflk9hjL0Lc92BZ027qSrwpdOONqtVgEQBjzg/ZGG
	 sCC7MkKM+fmKbS/Hh41r7U8Av/5c534TZRfxF/XUyPJNWSdYgGduGjPpGpca0Ahor6
	 +44G1+pMLeh/je3Z2NcTjSRzHDCe6JAD9jxSNUTlnqLFuDr6SSxxKf3usTxJJKzoo0
	 lJyaq5OQA18DA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Shiming Cheng <shiming.cheng@mediatek.com>,
	Lena Wang <lena.wang@mediatek.com>,
	David Ahern <dsahern@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 074/183] ipv6: fib6_rules: flush route cache when rule is changed
Date: Sun, 24 Mar 2024 19:44:47 -0400
Message-ID: <20240324234638.1355609-75-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324234638.1355609-1-sashal@kernel.org>
References: <20240324234638.1355609-1-sashal@kernel.org>
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
index 1727269396523..cdc8a49d7fc34 100644
--- a/net/ipv6/fib6_rules.c
+++ b/net/ipv6/fib6_rules.c
@@ -437,6 +437,11 @@ static size_t fib6_rule_nlmsg_payload(struct fib_rule *rule)
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
@@ -449,6 +454,7 @@ static const struct fib_rules_ops __net_initconst fib6_rules_ops_template = {
 	.compare		= fib6_rule_compare,
 	.fill			= fib6_rule_fill,
 	.nlmsg_payload		= fib6_rule_nlmsg_payload,
+	.flush_cache		= fib6_rule_flush_cache,
 	.nlgroup		= RTNLGRP_IPV6_RULE,
 	.policy			= fib6_rule_policy,
 	.owner			= THIS_MODULE,
-- 
2.43.0


