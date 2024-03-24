Return-Path: <linux-kernel+bounces-115630-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 33B92889CED
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 12:32:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 645391C23C74
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 11:32:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58D962023A7;
	Mon, 25 Mar 2024 02:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lKOVa0SV"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B560220371E;
	Sun, 24 Mar 2024 23:04:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321455; cv=none; b=mOF9M7dsvE4XC5tB8hR5S6Rl0sJe+SabZPhFSfYiDP9G/6CE6tP6fDibbXqxjIAli3wgtVoX4xO8t/ohlorcNF821Cv7Df3nUdphJgDEZx+QIhUpiQvOOvhhAnV1a2gDzRTkgjwudzV1G3M3ZMwZVYV29K2WvWGXqZk/b0ZW6u0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321455; c=relaxed/simple;
	bh=LvtZg5e0VQtOBT+DmVlIpjevxUc7VebV46SOEb3fPHw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e6Rx81wQxlHrEaGoqjpTgGnz7YRYwuBzxHViHZPuTcDxiaZBR/29LuTDL3D1FjRb7xpYUEecwmZkIi8R/X05LCWITNohHuoEQYgb4Pjb6KirlQKKdQnG7uAqTsU23kHJzUVZ0zVjM0qUiC1n+nuwu7zusibQYC2F/bnxZWh59bU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lKOVa0SV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFE0CC43394;
	Sun, 24 Mar 2024 23:04:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321454;
	bh=LvtZg5e0VQtOBT+DmVlIpjevxUc7VebV46SOEb3fPHw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lKOVa0SVcBY7l0tlsQLT6FtEeU+Efg5RNfuMennxuVC2PN6FwFVwz7kWg8Nz07Zvp
	 mtWipfFyV9WuhFyjthcZXsAS/FLi64bfIEE7SML4nSVzulTOF9blm24BEFgjeOD0SM
	 Xor9zuuMgYBuKyfRjfwaXs16UulrGnqYgN2Q6H2ufdKFyHhEwEkrhR0auk6cWMlwev
	 pgf278jfnFwQU/nXYP46x4yPuwzbQMGlIfqEgtSmQJIT+nbUc/WKfs41aRkBF1gRqD
	 0QoowKLSmBVJGXhvK/TpSPFJV5z2HMn2u1ZjzAvrTT5g6Po3wsWYf23nxdruwxNM6w
	 UbEiN8LEwwqBA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Breno Leitao <leitao@debian.org>,
	Jiri Pirko <jiri@nvidia.com>,
	"David S . Miller" <davem@davemloft.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 179/638] net: blackhole_dev: fix build warning for ethh set but not used
Date: Sun, 24 Mar 2024 18:53:36 -0400
Message-ID: <20240324230116.1348576-180-sashal@kernel.org>
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

From: Breno Leitao <leitao@debian.org>

[ Upstream commit 843a8851e89e2e85db04caaf88d8554818319047 ]

lib/test_blackhole_dev.c sets a variable that is never read, causing
this following building warning:

	lib/test_blackhole_dev.c:32:17: warning: variable 'ethh' set but not used [-Wunused-but-set-variable]

Remove the variable struct ethhdr *ethh, which is unused.

Fixes: 509e56b37cc3 ("blackhole_dev: add a selftest")
Signed-off-by: Breno Leitao <leitao@debian.org>
Reviewed-by: Jiri Pirko <jiri@nvidia.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 lib/test_blackhole_dev.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/lib/test_blackhole_dev.c b/lib/test_blackhole_dev.c
index 4c40580a99a36..f247089d63c08 100644
--- a/lib/test_blackhole_dev.c
+++ b/lib/test_blackhole_dev.c
@@ -29,7 +29,6 @@ static int __init test_blackholedev_init(void)
 {
 	struct ipv6hdr *ip6h;
 	struct sk_buff *skb;
-	struct ethhdr *ethh;
 	struct udphdr *uh;
 	int data_len;
 	int ret;
@@ -61,7 +60,7 @@ static int __init test_blackholedev_init(void)
 	ip6h->saddr = in6addr_loopback;
 	ip6h->daddr = in6addr_loopback;
 	/* Ether */
-	ethh = (struct ethhdr *)skb_push(skb, sizeof(struct ethhdr));
+	skb_push(skb, sizeof(struct ethhdr));
 	skb_set_mac_header(skb, 0);
 
 	skb->protocol = htons(ETH_P_IPV6);
-- 
2.43.0


