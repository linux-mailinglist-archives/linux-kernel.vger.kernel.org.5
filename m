Return-Path: <linux-kernel+bounces-113223-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0851F888270
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 00:48:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2F7CA1C2289A
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 23:48:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50AD5181CE7;
	Sun, 24 Mar 2024 22:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pwAvBi8m"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CC90181491;
	Sun, 24 Mar 2024 22:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320024; cv=none; b=T0t9eq7aOUm1G2HG8kFteZNKNCa5jsp7ihWaoFa53Ef4j6JpC8q5Cm7osDMCLy2+OovSl/mYU2OgRvOiKqZHyCpW7/L+tVCYepcQeLzlaM+VUHJjzHr43DId1Rns6BN5PdEe3hVJ18I1QD7GWLxTLXW4VDm8hCoELCNYihxdZGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320024; c=relaxed/simple;
	bh=cfO/pSwv8DvtXWRMznN57ZBsrXBoyZbOV1j5gmASnTI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UWMGizT+tdqPY4gEHVF6mYU1ePYHjDJJmWdLZBOUZCqIeUm7Hngs5yUNrdg4ZVMH9SwRrbInd9G3IOc1uuqBdt9xCruMRNKUBk5kfBy7y6GK4u+9Ucj1xCWjo4eir72e3a01QwmNohtwmdMgzTVY+fU2HeFOo6kLYsIo55ijTws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pwAvBi8m; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95B63C43399;
	Sun, 24 Mar 2024 22:40:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320024;
	bh=cfO/pSwv8DvtXWRMznN57ZBsrXBoyZbOV1j5gmASnTI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pwAvBi8mwyAEr9PaNyJTzK48Uc39QYZfwEXIoQcM4KhYEpdMJkW881yaicuKoYyqQ
	 Bw/LbFlLFgO5qjcKMvViLYkjXWmo2AXUHv3MRNtJrI2RBJlyW8w3KkxH3xMOs0vQHT
	 mEhqC8JvIHna+/XdbeOF0mfat6JID07o0ffHCnOt2dGEaKEkg0rzB4eTskichmTAND
	 BBlgWSnqd/3ObeGDHJaJvc+0X8jUbupCbsMww4pEe9R2xp8Z1dUWCLqgPfhatLo5k+
	 1iBI5BivAGHDYNcyOkgRwtSoH99Wv7vmRRRmZsBQuaJhItiV+Qx0CA0R/O/CtQWLu5
	 WdqZg8LmDZJfw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Jie Wang <wangjie125@huawei.com>,
	Jijie Shao <shaojijie@huawei.com>,
	"David S . Miller" <davem@davemloft.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 332/715] net: hns3: fix port duplex configure error in IMP reset
Date: Sun, 24 Mar 2024 18:28:31 -0400
Message-ID: <20240324223455.1342824-333-sashal@kernel.org>
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


