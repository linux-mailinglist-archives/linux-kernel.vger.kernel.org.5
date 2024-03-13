Return-Path: <linux-kernel+bounces-102053-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2111587AE02
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 18:47:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D20B0281EFB
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 17:47:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B4B91552F3;
	Wed, 13 Mar 2024 16:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N0tC3uQo"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B2CB154456;
	Wed, 13 Mar 2024 16:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710348432; cv=none; b=NekLuWCEamkj0lXc6bfQFxTSaoXnL6hS9/1jSJZyM3xN2Fifn+eNBQZkHgOJi33g500ULq0b3ei6WQbZ8wpp04OpIF9NLiZAaPQ62fXM+U6yVTU9xLhoh5lzEM3/r7x+zbZpSPrPo5tU5XRA7eM9w77ctAtuWINu24zwCCyhMIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710348432; c=relaxed/simple;
	bh=hVyrczuiZJbLaXd3dR/x2S4Q0HwmjvVXsmFzKXbIcuE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bM5LvjcfdtQY2OU3yqMaKniOFR9Allgs1sz4EbbK1VsBJjY5HH0Ccj7Xm//MIPRNB6nTAd/N7QeFQxpl6YwuDyRysxiwoI2X+o7HvKqNfGVLK88ZaVGgHogS6vFvEM1F5rLLg90m6DlRSJQYhgDKMGHQScFG2a6zVjG/itSapuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N0tC3uQo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5698FC433B1;
	Wed, 13 Mar 2024 16:47:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710348432;
	bh=hVyrczuiZJbLaXd3dR/x2S4Q0HwmjvVXsmFzKXbIcuE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=N0tC3uQo2HdtBMWm1SYSTSpUdeNoEPmyF3nGt9+4Ms4TJUteKcZ96T0D8P94j5pGe
	 81f3KA5mJ9s/RsbHlwIWp2JV1qFoYZTXGlQ58hvwCA7YPJceCM1LBmzv4RW/FA0A8P
	 j71J1cLibUcEtbC6YbZGhRwUEZcbhNxDHaPyjc9OaGTophiYg2DE72OMy4DgXpVsVu
	 w25NkZhUps4iMoZ9+9qiCOmGSO/1/ovg6IAITiAY9nc1yn5/gNdQpGao2CPwWl3cAB
	 XesDVfqUmgXgaqoOt/127s3UQwZK9MmbNxzj7RVNP9jJY16J6SPYKaeWfHJG8JPaIC
	 ybKqMoLEssPsA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Jason Xing <kernelxing@tencent.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 27/73] netrom: Fix a data-race around sysctl_netrom_routing_control
Date: Wed, 13 Mar 2024 12:45:54 -0400
Message-ID: <20240313164640.616049-28-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240313164640.616049-1-sashal@kernel.org>
References: <20240313164640.616049-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.10.213-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-5.10.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 5.10.213-rc1
X-KernelTest-Deadline: 2024-03-15T16:46+00:00
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Jason Xing <kernelxing@tencent.com>

[ Upstream commit b5dffcb8f71bdd02a4e5799985b51b12f4eeaf76 ]

We need to protect the reader reading the sysctl value because the
value can be changed concurrently.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Jason Xing <kernelxing@tencent.com>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/netrom/nr_route.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/netrom/nr_route.c b/net/netrom/nr_route.c
index 8a5375e1dcc77..88c59bd0f7397 100644
--- a/net/netrom/nr_route.c
+++ b/net/netrom/nr_route.c
@@ -777,7 +777,7 @@ int nr_route_frame(struct sk_buff *skb, ax25_cb *ax25)
 		return ret;
 	}
 
-	if (!sysctl_netrom_routing_control && ax25 != NULL)
+	if (!READ_ONCE(sysctl_netrom_routing_control) && ax25 != NULL)
 		return 0;
 
 	/* Its Time-To-Live has expired */
-- 
2.43.0


