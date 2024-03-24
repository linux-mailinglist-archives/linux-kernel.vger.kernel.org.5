Return-Path: <linux-kernel+bounces-113027-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D163A8880E2
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 00:07:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 874141F21D80
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 23:07:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C34713A253;
	Sun, 24 Mar 2024 22:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VNe2Mdz1"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 845B9139598;
	Sun, 24 Mar 2024 22:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711319837; cv=none; b=YJgY30Y7zfHWqfbOSAOsMNJEMuQw5wtZxVrBsgkjqnDrAtP23kmBzvgjwBA7kzRW4d84pXr/UmBiiFIP1fh4N7UvINEhnpbp+/MR/UfpwUxgNQtXcvN2L1x4hYJX4hKB1mpDeVTPKCI2CXTPrlgcAN3Qx/QAU8Q/xTZJrbL0BVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711319837; c=relaxed/simple;
	bh=LvtZg5e0VQtOBT+DmVlIpjevxUc7VebV46SOEb3fPHw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fvCqL+XsYQbWLR1yyAr7lBuiyKLQfnMqt20sDVOCO/wZ29ch5uJ1rwzgR50lhIUNl2qePuRg1EIoohiezFizgS0+rsw3PrPc7fw3FNRv0Ahx6FG8yiphBYQn+B8eLIHTEZGZcxhDksaCwq/YiKPHb3tM1HQiDBk8yzSHKgV+VP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VNe2Mdz1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B22C7C43399;
	Sun, 24 Mar 2024 22:37:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711319837;
	bh=LvtZg5e0VQtOBT+DmVlIpjevxUc7VebV46SOEb3fPHw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VNe2Mdz1jvhZOmL7v1IPHuiyWCxz63U/aYYx5JF6xWunGCVq1rvvs7u5mZt7+LuKI
	 BItTsXj0C4k0l5tukM8NohfMu7080GmIE2ZrvWKr4EVk7QWSmFt7i4V/svrd99gRxs
	 PEEpZROTzHKFm5D3SASvhiarC9ZPQnrWbi0FS5e3vJf6XdHHqRpg+CyTNaIkE28YRs
	 C0u2KZ51pf6x18K2X+EApNineXoN98P1Od4PlsETxe6/biYzTbTi4Wtgiz/q2F8GX2
	 vMpSKYOQf/MsL90OYd6HqS1dc4yf5JsLA2AzM6Epalxdg0Sm4bk4YLdsaeRxsm6eLD
	 Pcerybp3Dfbsw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Breno Leitao <leitao@debian.org>,
	Jiri Pirko <jiri@nvidia.com>,
	"David S . Miller" <davem@davemloft.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 140/715] net: blackhole_dev: fix build warning for ethh set but not used
Date: Sun, 24 Mar 2024 18:25:19 -0400
Message-ID: <20240324223455.1342824-141-sashal@kernel.org>
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


