Return-Path: <linux-kernel+bounces-113786-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ACDE888E89
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 06:21:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C7E131F32B55
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 05:21:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D29814D2AA;
	Sun, 24 Mar 2024 23:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nVvsha7b"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 422161E4A11;
	Sun, 24 Mar 2024 22:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320809; cv=none; b=PGlyahLKUQY/XFYorYCbhV6+BeFjvL9guyNoqZ6HiHdGk9nN2q/XEGR9WoaHUJ9isJZCDfjnvNpUzpmjiLegzeTPEFYUeHFKB9GT0bSY3/fvsD/lGMSEcOhRVBDBLSEraTQPYGHJG4VBQagB8k/9dUc95u8futzW20bONJm1b2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320809; c=relaxed/simple;
	bh=cfO/pSwv8DvtXWRMznN57ZBsrXBoyZbOV1j5gmASnTI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hJNCVT0GmdSLecb+alNflvDdff+oIuRcSLCd+HpSsFA76RMJYCE6AbJWNh2ds6GxsGYAhAHmXiAeQzSL8I0/zW0g2ejXfPfOomazQr9Dw8tx5zaYe6vxtv8K+V+zrJLEI5N295z+bHSQi4ZI5SjT8gTJVmXB9H84e8KiHn7hMuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nVvsha7b; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 331EEC43143;
	Sun, 24 Mar 2024 22:53:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320807;
	bh=cfO/pSwv8DvtXWRMznN57ZBsrXBoyZbOV1j5gmASnTI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nVvsha7b+54JT/u/tHZdx0Eo2FwiSnsPMQx7ppIA9XhO56FW0WT/rYz4GwXJs2XaK
	 Sm1KMZA8eaR8RSpbtMNZTY2SZQHjrFoSi7xNeL6+pAagEYTpyiWvQDD0/HvZvxEzUA
	 mmSwhuvDJPH1ZWNy+4cmL1Kli5to/O+MCPPLB/qg6fwkoUsIuWdQYaEHZgNBR8vvoM
	 g0MBiNDlaHSpVjZVgyeCFou3tpVYWZaaAID2LQ3v76pS53Yi8oBpWr+tEIePVf2HO0
	 BD1QBHCZQskRu+gqM8Yc6pQEBi6u5tUssgGPjq7+KStcXjOorpKNtI/1nz8vbrCWh2
	 o2Dm435WyEpHg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Jie Wang <wangjie125@huawei.com>,
	Jijie Shao <shaojijie@huawei.com>,
	"David S . Miller" <davem@davemloft.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 372/713] net: hns3: fix port duplex configure error in IMP reset
Date: Sun, 24 Mar 2024 18:41:38 -0400
Message-ID: <20240324224720.1345309-373-sashal@kernel.org>
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
index 5ea9e59569eff..609d3799d7738 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
@@ -2890,7 +2890,10 @@ static int hclge_mac_init(struct hclge_dev *hdev)
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


