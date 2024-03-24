Return-Path: <linux-kernel+bounces-115935-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E52C8894DF
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 09:11:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 34E9B296715
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 08:11:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 910C42669F0;
	Mon, 25 Mar 2024 03:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dGJUUAzd"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5DCA15ADAF;
	Sun, 24 Mar 2024 23:15:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711322137; cv=none; b=RzLCRSuK8aGQdYw6sxPvWoIRLe7NxxkAr5US/nM415u4VCGpHC9ys3q+gGKLWK0Wh3ZDShNyAYmGpUPWJBIYHcxjliltZKRz8w3Dg6O+OQMaYD9PNRf7FSrY480Y0KPrHl2uzK7Am8IUH/E4brjWVXg1gxMPqnyIr14IQx/PqUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711322137; c=relaxed/simple;
	bh=pNcFH+ooFkIv/Gh6pWZygMrI9+wZ6KT5OyHzXrzdBTc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gHNLKW9D6Ffl0cInj/mIGZe7s6C90ckPicejyT1+7j05X4UhVqhgtzR1Cw1L6Z9BcoTibLuk7wLYeunHmOHjBayZee67CTamq3Wx+o0dSOAtmOxRHbTOvAFnz6DxvJGTG7Lb19ObLtcdg/rojrUY4BoIeWO2xbXJ73wq8h97czs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dGJUUAzd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E148AC433F1;
	Sun, 24 Mar 2024 23:15:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711322136;
	bh=pNcFH+ooFkIv/Gh6pWZygMrI9+wZ6KT5OyHzXrzdBTc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dGJUUAzdMFkWyyteNhsCzKqNfrMyldmEqzu0XDFmgjfLh2LQmgp7hiFGVJxySLzKm
	 FlQzhUpmVfWd/fIo0bx/DEVk7pY8DYUXHmYulW+PfLCJQ/RR4E/YIelVwHJYKppoa2
	 byIKM1tGmrKU4UYxIKC2prFlO/O1/QTJ5ErvMcs6z6ra/sMazvdO+nk+hbWJkmxwWg
	 2yLho7ZWBcDniN3/YQDUJI7u6wezmnM51rEBuJx/+6//O7VbapXHF44IiUPZvsT8GM
	 l0OCkDBApzGTNljWA4TuRO/y6FrZSD0FoS1iNC51itqaAncYp3nWt6XXdDEIvN2Tv9
	 9GYSNspQxL+4A==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Shiming Cheng <shiming.cheng@mediatek.com>,
	Lena Wang <lena.wang@mediatek.com>,
	David Ahern <dsahern@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 213/451] ipv6: fib6_rules: flush route cache when rule is changed
Date: Sun, 24 Mar 2024 19:08:09 -0400
Message-ID: <20240324231207.1351418-214-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324231207.1351418-1-sashal@kernel.org>
References: <20240324231207.1351418-1-sashal@kernel.org>
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


