Return-Path: <linux-kernel+bounces-114514-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 37767889039
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 07:14:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 68B041C2C0F4
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 06:14:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C4F9229BEB;
	Sun, 24 Mar 2024 23:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rxLD+vRr"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35EFC229D85;
	Sun, 24 Mar 2024 23:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711322143; cv=none; b=ZAR8brKzUzjWNhCbxFl77VYnGKqcVseQC4/qVvzS1k4YOrNEoIkzMa8nZcplKu0ZeK172LSe/Tyg6lyTMloMyaPsPPkcuayw5spjN1Oi2i5xi0SBdIYsSvTvzzX+5GSb3Aot9GaFwYnkyMpsAiIb5O+Ty9rBFNZEqwCJlrjqy1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711322143; c=relaxed/simple;
	bh=RbD9e7IJmjYwo4QiNYnlwratIpiMv1lUhUm+t2thTYE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e/1S9NMPswsH4c+mMBkgaknsHg5bmw1kLt5fmfU3b8SWA08EpX7zZyM6cv3HjTEUrAzCi8/ZVeeFrwPykVHTBhhOrkGxdY8/w9yM3T/86BrEGMZo38533MK5V03ZokSur2RmWAMs+CxRqc3cYgmkhndrb9N5P+axFWZ52qfkLLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rxLD+vRr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FC00C433C7;
	Sun, 24 Mar 2024 23:15:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711322141;
	bh=RbD9e7IJmjYwo4QiNYnlwratIpiMv1lUhUm+t2thTYE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rxLD+vRr/VNtLkgZAqznN7+w3LHgHI0rNHg57uDzHuzMrr8acEgW6AFnStaCLUprJ
	 jl7xK1vusVHtG6Cpi+Xj1uIvfqYRDgg/m6O+NdoFJrM7Ro8TMYjVvATKujytvyCgJv
	 7z3TCeYVUcUdFEjBLssxfA7+mqC1pqPduRugeCjkFUMpzDAMiGmhFcPmaBriB8tuBl
	 xDqr1qnDjTBBM1+tlb52Jq+C4zoYqh/D5DLSPaIAkD7UdmFQ7IqT/1dX+fLuWo5zVn
	 tugHjUDe4KJeML1+DfJHhXrhvaw29zPPzZv3ACn2ASE1UonR2F/fH8+44XkDCdtjNQ
	 s1QCDVSVWWLiw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Jie Wang <wangjie125@huawei.com>,
	Jijie Shao <shaojijie@huawei.com>,
	"David S . Miller" <davem@davemloft.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 218/451] net: hns3: fix port duplex configure error in IMP reset
Date: Sun, 24 Mar 2024 19:08:14 -0400
Message-ID: <20240324231207.1351418-219-sashal@kernel.org>
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
index 48b0cb5ec5d29..27037ce795902 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
@@ -2990,7 +2990,10 @@ static int hclge_mac_init(struct hclge_dev *hdev)
 	int ret;
 
 	hdev->support_sfp_query = true;
-	hdev->hw.mac.duplex = HCLGE_MAC_FULL;
+
+	if (!test_bit(HCLGE_STATE_RST_HANDLING, &hdev->state))
+		hdev->hw.mac.duplex = HCLGE_MAC_FULL;
+
 	ret = hclge_cfg_mac_speed_dup_hw(hdev, hdev->hw.mac.speed,
 					 hdev->hw.mac.duplex, hdev->hw.mac.lane_num);
 	if (ret)
-- 
2.43.0


