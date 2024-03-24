Return-Path: <linux-kernel+bounces-115376-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6904E889B2C
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 11:45:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 08C281F36FF0
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 10:45:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07CD71F30CA;
	Mon, 25 Mar 2024 02:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c6rzQ1jR"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC08784047;
	Sun, 24 Mar 2024 22:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320640; cv=none; b=gGHcfEvNYImP0BxpJiae8apxLkqHY/rZmMW/wZ7uUjI9hcrA/b05pMCBxmEtiJahiFQsUy9n/7jgKz/3X92aFmGuTp1NF30ZdCS45PJeNdqPliaQ+0diXdNmTo4PKx0KTb9iHH/NKnLga+XCNpcjshOJQjk/+W1CuYFIjYTbSVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320640; c=relaxed/simple;
	bh=LvtZg5e0VQtOBT+DmVlIpjevxUc7VebV46SOEb3fPHw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QLycyzcAHw2g+7HBhA2V1TqYkE1CFYFMBZZ2+VmvtkcJkzKLika3pC86tEyFjWiVXWeL/yA9BptKmT3edTxVyXh//xpQeUmaNv/sG55HggYWceJVQlP8Ak2FFzsp72wlaGq2Tbs3RfIK3DATGS3z5whTUHHb0u7PkAnyc0hTfIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c6rzQ1jR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EA7CC433B1;
	Sun, 24 Mar 2024 22:50:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320639;
	bh=LvtZg5e0VQtOBT+DmVlIpjevxUc7VebV46SOEb3fPHw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=c6rzQ1jR/j6Vu8Q+oh0JhB39hL4yDo1aSIY6nbM0kQ8x39AS3E8KH7LA8ndcsZaL0
	 jr//6Y5XWid0P5XjFTNjxAVMdKKinnM9ytLNwU1WyHeurmx5lfb5lrrXGwQorart63
	 xXrzIUmu7rJcDgw3LscaFi1o8Cd1B8EDgX3kpLOM6R00jS4UjxDrIRb1dhP6uhXE9k
	 a8mXgDc2BCSw1Yxw6IjSc2vDGW6tOr5yRPE3b/GNnSD6XJANLw4eCATzevNArVXxdZ
	 lG0oaM+PxHeaL/B8x+Mj3568TtlOYrdAAZRvx4lnv4i5KXrCDggD2LhmwLYIzdXyZN
	 218peJjY5qAJg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Breno Leitao <leitao@debian.org>,
	Jiri Pirko <jiri@nvidia.com>,
	"David S . Miller" <davem@davemloft.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 201/713] net: blackhole_dev: fix build warning for ethh set but not used
Date: Sun, 24 Mar 2024 18:38:47 -0400
Message-ID: <20240324224720.1345309-202-sashal@kernel.org>
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


