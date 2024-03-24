Return-Path: <linux-kernel+bounces-116155-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91FC88899CD
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 11:16:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C3C931C3069E
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 10:16:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3FFB3B269C;
	Mon, 25 Mar 2024 03:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JaD5+qBa"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1990117B4F2;
	Sun, 24 Mar 2024 23:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711323720; cv=none; b=a4YvQcqHZRelowLXjJvAeZnfOCFsRG5JobvU9L3ccCHuQ97C5CCoxzhMyEY57QE0p7SuZFvQKrRRryK+/m3hJT8bW1NXqMKwQ5Z8ZHpjPfNIEmWKeuE4iiPxEre2DpCgyfIQB3nOFJhO3CGcf5X3R2Qm9e/DyHGgq2JuCrfNz0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711323720; c=relaxed/simple;
	bh=M5igGWHTOyNDupa/8vuugdNBXY6bKFjuOK6U+k+WEVw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NGLMASRq0suxidL9WUg4AkJmTA4RYekAYurHI/z+7gB9P1ZNW/gl8MD69DF65Gpl0LNaJZEED3ShbR3zvlmpJYPC9AHxKE86VAzPcmNHBKRnlVgKD5oRLKOnaY0PInGyuLS7NCBztJwdSvMSb5gxnCFu/0HG/vEJD0KD641k1M8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JaD5+qBa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27E88C41674;
	Sun, 24 Mar 2024 23:41:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711323720;
	bh=M5igGWHTOyNDupa/8vuugdNBXY6bKFjuOK6U+k+WEVw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JaD5+qBaVb3Fv1wvS7UXsEfr/qEHDjBRYXlHJkae7wb1KKIHo33+ueDn0uFvGhLWf
	 AdtAqzjjKXOxL3xErrDW3bpzDQV7csDpifcj6zYrad5WFNZJy8NFLs3Yaqo7oCaWuu
	 S0YwyPwO1/ybVxrfnrRuQINiLpFbKc6hsYf0gRP6EU3WJSLh5w25DYgH88SmzUl/X4
	 u2FYeWQNz+NQfuwBA8wSr2xoliF8/zk5fBWBeBdhg0SzO4odcOO/GXU7VbgKK3lFnG
	 KL7tmsJOLoXsxeTzWG641M+pbyw1Yp8afbK0kbJwaPIn+99KBCFF9YOSHYrcVAktmz
	 V4A1/GyhzUkSA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Shiming Cheng <shiming.cheng@mediatek.com>,
	Lena Wang <lena.wang@mediatek.com>,
	David Ahern <dsahern@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 093/238] ipv6: fib6_rules: flush route cache when rule is changed
Date: Sun, 24 Mar 2024 19:38:01 -0400
Message-ID: <20240324234027.1354210-94-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324234027.1354210-1-sashal@kernel.org>
References: <20240324234027.1354210-1-sashal@kernel.org>
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
index 3e4c87b29b115..55cd23b7a9357 100644
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


