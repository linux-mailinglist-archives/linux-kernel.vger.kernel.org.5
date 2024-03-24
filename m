Return-Path: <linux-kernel+bounces-114780-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 88400889126
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 07:35:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B0FF41C2D065
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 06:35:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CBEC1B3FC9;
	Mon, 25 Mar 2024 00:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pW4Q6luP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7719C2762A3;
	Sun, 24 Mar 2024 23:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711323384; cv=none; b=eEqOYluGbhlkWqMPuVxyR12AIbHqADyS/jS4H9gCTzqt2q763CDPtoEmrBiN/uqjgrqYCsk4n3f5uEt7NYKsBQj5CHDFfOuHLHL5lLguKVwgO51UfXAKfNOeuXtO9Jjf8gp+6tO07/2dxq9YX9fUfPD9lO+QzLXX4rQUYBG+xOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711323384; c=relaxed/simple;
	bh=LvtZg5e0VQtOBT+DmVlIpjevxUc7VebV46SOEb3fPHw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rJnDq29VePLFwTreV2iJd+SL8iq6Fm6fpLeODuzh7vtpsaScLPO0gklOJvwCLCZBxRjnFVkcjgzxLppVfSGQIgbvaWxLiVDZwXh4AMiKMxfjx7pgeXhLeqS7kfRfxERCF8s6ZOQLUBpq+L3ItM8gqKbhSt/Ivzjh+q/Wq/tekCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pW4Q6luP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1DDBC433A6;
	Sun, 24 Mar 2024 23:36:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711323384;
	bh=LvtZg5e0VQtOBT+DmVlIpjevxUc7VebV46SOEb3fPHw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pW4Q6luPYaAQ26nYDDHXb3l//kenFn5SbXy3T3oK3fSLzp3yOECwk6oov2CMJrBRD
	 2rqYc8iqNGo8qXUvuJh7Uqsl3MROPfXHXvYcaZmnQZBugQE6FpDMEeYxGbEAWqWB4s
	 Hc9dCIF6yv35bzxb+ztlAKmlLORAElI22pYq39IV+ETmtp4y8kc1mobzyR8CXHaAZl
	 yIgP0yyLBopG72WD22YIIvYClH70j7VIbtrARl/XTcMhCgNnYYYvpvXZYJMm6V4Arw
	 z/xgIXfRIciD86baKXyiV95lLSdfUs4VPxjNnOzd9JrD3xEkBsPlXfmcA8MvYI1uXS
	 XBOJRwMYl44Ow==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Breno Leitao <leitao@debian.org>,
	Jiri Pirko <jiri@nvidia.com>,
	"David S . Miller" <davem@davemloft.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 084/317] net: blackhole_dev: fix build warning for ethh set but not used
Date: Sun, 24 Mar 2024 19:31:04 -0400
Message-ID: <20240324233458.1352854-85-sashal@kernel.org>
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


