Return-Path: <linux-kernel+bounces-115809-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1072D8897FC
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 10:24:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 429F51C311B5
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 09:24:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67BCE373FD5;
	Mon, 25 Mar 2024 03:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MZDJslPA"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFFFA145FEE;
	Sun, 24 Mar 2024 23:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711322051; cv=none; b=o1xfu42ouK0D/SEFsU0/gsy9+htINN16UR3ks9kbUt4UtZHZtu4VdFRc6ThM7ISI30jNn+ad4b2Ku/G8lvK8suFIP4RuAF281x4ga8cGYpjsFciWbhhdjnj066JaoGVBLIiAPIc0JEYcelJKhi6LDtfokFosGR3ecYUnW+J/UV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711322051; c=relaxed/simple;
	bh=LvtZg5e0VQtOBT+DmVlIpjevxUc7VebV46SOEb3fPHw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UOKSo7AXZq+zzBzb7U3watXq0Zcbc4FMbUeQ9aTsfDOFcGXCgyLxn76k3JcyD7DuYB8bMnFQ5AzX0hGdbTjqLlI/JZxxvx8zt29sQs4kHqHyDgeXHSMF5huORY2yG7dGQMrkgeYPMZVUeSTbbutekFVYpFlqcauwDPIjK9ERAyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MZDJslPA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E34D6C433C7;
	Sun, 24 Mar 2024 23:14:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711322051;
	bh=LvtZg5e0VQtOBT+DmVlIpjevxUc7VebV46SOEb3fPHw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MZDJslPAkCrZagIK7XdfnOV7jltirdp4cCCrHLXkONgUcvun/eQ/0KPeRp5KmAtOQ
	 QnEYhChe4Y7PrYVHGCu3UOsnXcdwnnBGq7wFv97QH1WkOmEiz8+JkFK62//aa+9VRL
	 /7xYCberxRIQKQQJkd3fiyma7pUqrFZH8DzVq8Lbu8KM/BQf5jUFBmfnWTncXSl5Pr
	 HGZNNfexQWzr5JH+7f+cRL3I5lzfpLvPEgLx0fVyQ6Al7QBmQKRRveGN9thfbxqHav
	 9UyGtY9/IT2ObCvrjH2MAP0osGWKkHvm4672ZyzyWAzRsqWMDP2tGZ9liX2RXCEpez
	 7BMq4xm3G/kqQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Breno Leitao <leitao@debian.org>,
	Jiri Pirko <jiri@nvidia.com>,
	"David S . Miller" <davem@davemloft.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 124/451] net: blackhole_dev: fix build warning for ethh set but not used
Date: Sun, 24 Mar 2024 19:06:40 -0400
Message-ID: <20240324231207.1351418-125-sashal@kernel.org>
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


