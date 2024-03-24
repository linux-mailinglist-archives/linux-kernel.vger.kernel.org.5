Return-Path: <linux-kernel+bounces-114819-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B64CA88917A
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 07:42:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E82911C27DFD
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 06:41:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92B5D1B9DD2;
	Mon, 25 Mar 2024 00:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UEH/OA9U"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECD2617654A;
	Sun, 24 Mar 2024 23:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711323439; cv=none; b=QT2SQGxiXn1iXnMNlUviBxgc/QMa7lEten5kVI9BQh61Nq0/+iuG7jaUtftj4nEryzQ3B3LLbEIFdPsFoSWp/oSnfyIEZlrhwjFKgUeK45bo7iH4Uy73ImtotLhry92fDhH3eYelj4NqwnF09rD2aU7aClgdjUPdA2HVvgw1Qfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711323439; c=relaxed/simple;
	bh=pKvV0QKxpxf/tg28LprBCQUq4q21d7ZXWuuHGgSIFpU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Sc73BwPtztbvcZbJkRdBq1LZuFJhdBuK7y9nnrObEKqE2GwFJI4sBGmkJYsDYhAy0pED5oBpwIxwHid9sC0xdVLeRlVwXtfNUJJOBNxGN3fnLRFuXE1K0qhDYL1ZepudoJ24m3baV/pHwJ0DpvHk1jS+1kYaPPCyd+bohT4ft2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UEH/OA9U; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22259C433C7;
	Sun, 24 Mar 2024 23:37:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711323437;
	bh=pKvV0QKxpxf/tg28LprBCQUq4q21d7ZXWuuHGgSIFpU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UEH/OA9Uy78St5xPd3Yv6F4tMGkliWGc0/HMho5R/E2jZjh38uA16pADTTrJt1m0Q
	 ATXL991jD5kQ8DAAAy8rdPF55u+UU9BPsDrQXfoUNMdGkTrNsLDUQKBnxQhLPwJLY+
	 6TV4V6yzT5RCb7oIDGJoR2z0ZyRz0x4OaeF1yWLtoivMoO0hw189dv7+USc0GmSCZP
	 LgYX4RYWvSMEyyLAHPprd75U0f0rt86sMUoA2mElD2uvBeQxb5q/V9OrNslM/qjP6L
	 zfiMgtldK6FgdHvMs5fUmZodf820z0P1QK1MeGQjIqRQFvQba0TNuQfVOsW4CZizHl
	 rWDGQUzaJTdRA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Jie Wang <wangjie125@huawei.com>,
	Jijie Shao <shaojijie@huawei.com>,
	"David S . Miller" <davem@davemloft.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 140/317] net: hns3: fix port duplex configure error in IMP reset
Date: Sun, 24 Mar 2024 19:32:00 -0400
Message-ID: <20240324233458.1352854-141-sashal@kernel.org>
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

From: Jie Wang <wangjie125@huawei.com>

[ Upstream commit 11d80f79dd9f871a52feba4bf24b5ac39f448eb7 ]

Currently, the mac port is fixed to configured as full dplex mode in
hclge_mac_init() when driver initialization or reset restore. Users may
change the mode to half duplex with ethtool,  so it may cause the user
configuration dropped after reset.

To fix it, don't change the duplex mode when resetting.

Fixes: 2d03eacc0b7e ("net: hns3: Only update mac configuation when necessary")
Signed-off-by: Jie Wang <wangjie125@huawei.com>
Signed-off-by: Jijie Shao <shaojijie@huawei.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
index 12274c2b9feab..598da1be22ebe 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
@@ -2803,7 +2803,10 @@ static int hclge_mac_init(struct hclge_dev *hdev)
 	int ret;
 
 	hdev->support_sfp_query = true;
-	hdev->hw.mac.duplex = HCLGE_MAC_FULL;
+
+	if (!test_bit(HCLGE_STATE_RST_HANDLING, &hdev->state))
+		hdev->hw.mac.duplex = HCLGE_MAC_FULL;
+
 	ret = hclge_cfg_mac_speed_dup_hw(hdev, hdev->hw.mac.speed,
 					 hdev->hw.mac.duplex);
 	if (ret)
-- 
2.43.0


