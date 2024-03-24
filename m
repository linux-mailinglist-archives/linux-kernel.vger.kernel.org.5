Return-Path: <linux-kernel+bounces-115203-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 00AFC888DB7
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 05:56:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 31B641C2AAF9
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 04:56:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8EE6294E0B;
	Mon, 25 Mar 2024 01:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VK9yMqPi"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14FB022C640;
	Sun, 24 Mar 2024 23:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711324281; cv=none; b=do8qpehv9UCmeW3TbHmwGWBO3arymnE+QV4CxhAzNijo948WgkLRhIgj3pq7NxmDUaKKfDB/Pzn/Fe4wpQjgyQfqPAB2Lx15TO3KyKUEhGNjlBVpYBKysxlXiZnutvZTEiCdGtKd/jol5YwUrVrvDoKwzD6Dyqu6BcK5ulk/Aa0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711324281; c=relaxed/simple;
	bh=qC98P5/GrlglsIhfMpYTW+QmAAft/+8E9Zd4Pkn3EbQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZM8ayQGUbkA65O9r77m2S11bSxvXQG3wMdU9NJGdB+b1QpW4XvulRLwrTIXQscjdh8MFTvpALEgQomL5JTNnOf8RO7CWAUuqavI+WPR5oadePFU/sKXe2ZapjXBs/iZPWPVYkLZ9xt1hWT7CoR9x3mRJvtwo4S7ni1MMDkc2fVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VK9yMqPi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5CA4C43394;
	Sun, 24 Mar 2024 23:51:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711324279;
	bh=qC98P5/GrlglsIhfMpYTW+QmAAft/+8E9Zd4Pkn3EbQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VK9yMqPiZHuPUHmlf7Tn/nk5WGN32LN0GFvu8UIc8J6rMMHeOTffiJEYC/ZqdrX0w
	 nY9g646qK6s2UoIaFM43tOSQQ9jYm0CFJEMRC8PoOf8vldpX5+enPl2gW6mf8jfCLM
	 kMXdsN8SAA1Ff/zxMr+aSmDD/6L5ux3waUid+EXek2bL1sSB2jCC5UegOs2CKiC9wy
	 /SUVKF2fiUcYugwO3prxqXVCiYKAulW27tHz/65T19C56o3WuHrrQXVb8dmWYV9sAI
	 WdL7vgH0CJJGcd61t72+8zuDSh9zr+m5DWSS8b0ib3Sp7BpXECb+OcA2eqpizkP7CQ
	 oyeiuVsHZMvgg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Shiming Cheng <shiming.cheng@mediatek.com>,
	Lena Wang <lena.wang@mediatek.com>,
	David Ahern <dsahern@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 057/148] ipv6: fib6_rules: flush route cache when rule is changed
Date: Sun, 24 Mar 2024 19:48:41 -0400
Message-ID: <20240324235012.1356413-58-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324235012.1356413-1-sashal@kernel.org>
References: <20240324235012.1356413-1-sashal@kernel.org>
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
index f590446595d8b..1913801f4273c 100644
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


