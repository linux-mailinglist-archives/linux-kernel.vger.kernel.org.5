Return-Path: <linux-kernel+bounces-113216-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B7E4C888262
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 00:46:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 53C261F21E1B
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 23:46:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC2481802A5;
	Sun, 24 Mar 2024 22:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PTc0FlSN"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFD9813C830;
	Sun, 24 Mar 2024 22:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320018; cv=none; b=UEhOgKao/FgvPpXZiIhSiEf62kMCYUknlP5Wb82uOIwURuGCtLPCWscM+fBdAHcAU2mWKoRIudP9rptp9x5/XBCcdxczxqIny0jgUAPx54N3wOtfL2yOPKrhh2d3mPsC4j/g8YZdXjfbkH/5f4PfSP3y2pfFHAWv7j4h5tQQuJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320018; c=relaxed/simple;
	bh=eH0vhInP9O3buHkVrLjIuiVn8EvjiIiqgfKW7ScCJVE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=afGpopiv3GYEGnaJ3j9ltRI/3ULuh3mGfiuV/Q8Kygz6LyEMT7jRTSivNpiQ5zcxw5vM7YtTJcuRyIaPRIv0pZPdszESP914ltZmKMKTydtkhjUGi3Z5J6K1SfawIVNZs9DqQ2VLxqTBL3BgFIuQAfjsOoWK7m9w4EwFwQV2Fvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PTc0FlSN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 938D2C433C7;
	Sun, 24 Mar 2024 22:40:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320017;
	bh=eH0vhInP9O3buHkVrLjIuiVn8EvjiIiqgfKW7ScCJVE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PTc0FlSNYyrVKXU9FFcy4Zp9BY/vOH9yx6Pr8B90yWPYwWlkBQ2K5hBSIJQ3vmhko
	 t4wigHqcQBEfnw/FnEhvWlBKlSqERSmdsPecadspG9w9tEQTJfvQ83xAT6vN9zR0Ds
	 4TcHkS1HG0G3rZPP3TytcbwA2fvxg1cbe27X2v7WSDc6ypLKMsKjAznOkhUCxRvHDk
	 dGeXxc4+HI6IvIwurDM7KEkOtFyWJdcnw6BrVISOHPN4aMUC57wgaD5h2JK6lyypZY
	 rEt3hxCu7AOfmm42RYLFmI0s0LTY2fM2TqTOUyBLoJI7XtGpnPFrmbXLTB2P0Dhkut
	 4Wo62UzDvMqYw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Shiming Cheng <shiming.cheng@mediatek.com>,
	Lena Wang <lena.wang@mediatek.com>,
	David Ahern <dsahern@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 325/715] ipv6: fib6_rules: flush route cache when rule is changed
Date: Sun, 24 Mar 2024 18:28:24 -0400
Message-ID: <20240324223455.1342824-326-sashal@kernel.org>
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
index 7523c4baef35e..52c04f0ac4981 100644
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


