Return-Path: <linux-kernel+bounces-101994-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 352B387AD6B
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 18:34:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C95621F2A4B6
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 17:34:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 993F114A087;
	Wed, 13 Mar 2024 16:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UjNRm4gq"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD1D614939D;
	Wed, 13 Mar 2024 16:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710348206; cv=none; b=uQbcMOtDphg/HUXiRCweZEYwvg7Devi7q2Aqygd/6NGxX/q2JLagDMHpJZJ9qXcQZsXT+B7+khRwceEMkccAoFxrK/w1uZxnyGD0kPYcSZdbA+2KYj8f1k69/N2ABu+Y4FWviN/S9IWO5Ncd2RlqxFifk4cRiKgo66cpVz+W3u4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710348206; c=relaxed/simple;
	bh=OjueRW/qxdue+0tSTD6SIsf+rLllHpSewjOCIhIb3wo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EN0bhnuN6OX8ASTHLvIqr8NA/ENJsiROyGMctjESkK+55xlpx2O/jw1DGB5ouTQqQxu9xdZ95wVrlyHoP08JRe644YJGHs2I1niZgkubXUa9s87acNTgos/NY8FEZz8LuLxfTGDcdJEusFv7bILPjyzXJ7Ud4+N8Sez1wUKXchw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UjNRm4gq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B784C43390;
	Wed, 13 Mar 2024 16:43:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710348206;
	bh=OjueRW/qxdue+0tSTD6SIsf+rLllHpSewjOCIhIb3wo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UjNRm4gqwNbdC1tsoXR7q+nBqE4Fwe0TqRPx8QM8sjxpdVnK8k9NQeg+/SkDbKcet
	 qy7bZQWkyRyvTCc2xwCpFdp/iJcU1PyJBfVnqrLv9ZeA1Fbg0QLD9lDkmsdkR65Fjo
	 FfDxHvH+L2wzg74BqRyWz77wI28rA32HDPbshY+HvczXO4JREVK3E/JBQrMZyiVVgV
	 99ojejf3tuOx1C8DuutFUGcRzONEo7v9a0+aCSxpNW7grVwEP4cdrBJ7LvKad1eHpu
	 pf7Xl9xwWmrSyF62W5TjEdh2vRV/7B/pqXxDQfcnDriXbOP+H9Do1J7rX3GhTKvxTB
	 5F+1QNVBU9QvA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Juhee Kang <claudiajkang@gmail.com>,
	"David S . Miller" <davem@davemloft.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 54/76] hv_netvsc: use netif_is_bond_master() instead of open code
Date: Wed, 13 Mar 2024 12:42:01 -0400
Message-ID: <20240313164223.615640-55-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240313164223.615640-1-sashal@kernel.org>
References: <20240313164223.615640-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.152-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-5.15.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 5.15.152-rc1
X-KernelTest-Deadline: 2024-03-15T16:42+00:00
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
index 25b65450cbb99..a7d1304466880 100644
--- a/drivers/net/hyperv/netvsc_drv.c
+++ b/drivers/net/hyperv/netvsc_drv.c
@@ -2784,8 +2784,7 @@ static int netvsc_netdev_event(struct notifier_block *this,
 		return NOTIFY_DONE;
 
 	/* Avoid Bonding master dev with same MAC registering as VF */
-	if ((event_dev->priv_flags & IFF_BONDING) &&
-	    (event_dev->flags & IFF_MASTER))
+	if (netif_is_bond_master(event_dev))
 		return NOTIFY_DONE;
 
 	switch (event) {
-- 
2.43.0


