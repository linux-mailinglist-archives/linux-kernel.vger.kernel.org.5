Return-Path: <linux-kernel+bounces-102217-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC6E887AF81
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 19:26:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AC0841C259F1
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 18:26:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E5AB1A16EB;
	Wed, 13 Mar 2024 17:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j4FlB73F"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FCF676C72;
	Wed, 13 Mar 2024 17:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710349511; cv=none; b=LOgHkTUYeLkXzRYSVXjEPMp/6dY8v5eZ0VpKtCY8Jnl3sws661lPEH2Y5lSjR71gme8MrccS7JHajHB1jw0v+UvPi8LdkgzGvmnuNLgXI2A7JJVJCnY9mTowJt5tCUyGNLvOvjnsYWHR7EMyXTNZhhPUCItTWZFfC1P9ENaIRl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710349511; c=relaxed/simple;
	bh=ZOqp/fXGfohcv3G3cxDdBtf9efWk2VsY/682ju0ztfU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PTOdcZuaBGtuYG/xFZ5NE7e/3QZpgw+0M2KWNT0xVMcwIrB3cWkXNglU8IGFoIYRFL99PIJexpWeHkP99qTnYcM3cVBZgRZB2u6NGTuH4CChk2mY16yap6OfwalapLmU+MQM9+sOmcthFZgNy7u8nArm71gA2OJQQhgz+GQ5C4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j4FlB73F; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AB3DC433B2;
	Wed, 13 Mar 2024 17:05:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710349511;
	bh=ZOqp/fXGfohcv3G3cxDdBtf9efWk2VsY/682ju0ztfU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=j4FlB73FAcX18ghz/6tC7MKcLL/egMSEk9j/3ZxI3SxRlw1F+/ktzPrebws3s65AO
	 bMjVTYQ+rQYmyzvioRck/IIlF6gRiobL+UVs1J+ZgBncSKWeGZLf4ec2p0fBvWgDdh
	 ZJ09BE9UWTtEHR03+HwUZEg/emLBFmlg1Cjl1ufRTF4/81q4pINzf5BGSCR4lK3Zcj
	 P2ZyXTtqojq0mY8ePhvdcODJRXGPvaEuokCiYhfYL7RznOXp89BAhI37CJY3Uy4O7E
	 UtOePTcNfoUuOtMIYwwhRIBC7rDkv9WWHfvF84pac55i4c5e1KTW9yLtMV8B5p45Bn
	 SDGqgwxCa619w==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Juhee Kang <claudiajkang@gmail.com>,
	"David S . Miller" <davem@davemloft.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 30/41] hv_netvsc: use netif_is_bond_master() instead of open code
Date: Wed, 13 Mar 2024 13:04:24 -0400
Message-ID: <20240313170435.616724-31-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240313170435.616724-1-sashal@kernel.org>
References: <20240313170435.616724-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.19.310-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-4.19.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 4.19.310-rc1
X-KernelTest-Deadline: 2024-03-15T17:04+00:00
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Juhee Kang <claudiajkang@gmail.com>

[ Upstream commit c60882a4566a0a62dc3a40c85131103aad83dcb3 ]

Use netif_is_bond_master() function instead of open code, which is
((event_dev->priv_flags & IFF_BONDING) && (event_dev->flags & IFF_MASTER)).
This patch doesn't change logic.

Signed-off-by: Juhee Kang <claudiajkang@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Stable-dep-of: 9cae43da9867 ("hv_netvsc: Register VF in netvsc_probe if NET_DEVICE_REGISTER missed")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/hyperv/netvsc_drv.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/hyperv/netvsc_drv.c b/drivers/net/hyperv/netvsc_drv.c
index fcf89ee5080f1..2d1c6f10d4e19 100644
--- a/drivers/net/hyperv/netvsc_drv.c
+++ b/drivers/net/hyperv/netvsc_drv.c
@@ -2497,8 +2497,7 @@ static int netvsc_netdev_event(struct notifier_block *this,
 		return NOTIFY_DONE;
 
 	/* Avoid Bonding master dev with same MAC registering as VF */
-	if ((event_dev->priv_flags & IFF_BONDING) &&
-	    (event_dev->flags & IFF_MASTER))
+	if (netif_is_bond_master(event_dev))
 		return NOTIFY_DONE;
 
 	switch (event) {
-- 
2.43.0


