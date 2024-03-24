Return-Path: <linux-kernel+bounces-115095-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01349888D13
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 05:38:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B01AE285ED7
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 04:38:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF79E2F8BF3;
	Mon, 25 Mar 2024 01:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HxppQbLQ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DA23181302;
	Sun, 24 Mar 2024 23:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711324077; cv=none; b=WNaqzmV+AEh/Z2I2eMt+G94RmNh3jHGohx9mTlrvBPL9ZaNmEQMcqmYmbw86XXMXOKkD1+DiY/fm/vMQh+prOZ8tTwLy8Omsd/H7EohWlQX9Bw2PJM7EagFL+cwzpQGQqjCpJ85qlGaGE39/YymKANsQDm0r8DZyaI4oDWd2YlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711324077; c=relaxed/simple;
	bh=3ntt01VQiuE0yhafQTxukKbAj9C/9BPACE20hDFacTk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lAxfEbCOwjAOkZlX9MRIxbe38SvjGAYYCiQoQ/ufrDhYVpsIZMZQJm3kp0k47Sqaa30JdieRR33Lnjn8sst9SgNNKXxdxHcMvgJ0uIuannMxBdbOtiq9nm6KVNrTIOTyeJrCB+QN1a/Szn9wcZNGcMtEEh2S9ENWRd8Y8e53mNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HxppQbLQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65A87C433C7;
	Sun, 24 Mar 2024 23:47:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711324076;
	bh=3ntt01VQiuE0yhafQTxukKbAj9C/9BPACE20hDFacTk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HxppQbLQLQGgnAZD6vcXYegi8PxuKP/e8mwVsPzWpZzJaQS8PJlXWVp7FKoMpOteU
	 6LdlpcY7MotgU/UrgOuwH3rXIqBkh2NtbZeL65PDu60Th5Ved7EMpgJ9uQhkFeXm8x
	 ahQcPOSOtzpbaTino5f++wGwZV7DU6wO4NKpdrYMYe8fwL5bSchcbtD3zodAb1ZAoi
	 b23ofniRS0IhMyzlurUUTq5TyrGE2O6v06nrGCRKP5+l1MA7ES0jNVZzI/XJusfGDl
	 x3u3/bhwZAFPPmqYihecGaetobnqTZ2hn0bLR7HvcS3k8aPn/3blqN+kYj79II8lf/
	 vqzuSBlnqsrlA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Jie Wang <wangjie125@huawei.com>,
	Jijie Shao <shaojijie@huawei.com>,
	"David S . Miller" <davem@davemloft.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 076/183] net: hns3: fix port duplex configure error in IMP reset
Date: Sun, 24 Mar 2024 19:44:49 -0400
Message-ID: <20240324234638.1355609-77-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324234638.1355609-1-sashal@kernel.org>
References: <20240324234638.1355609-1-sashal@kernel.org>
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
index 6b2d54c972b7c..f5956977fe39a 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
@@ -2588,7 +2588,10 @@ static int hclge_mac_init(struct hclge_dev *hdev)
 	int ret;
 
 	hdev->support_sfp_query = true;
-	hdev->hw.mac.duplex = HCLGE_MAC_FULL;
+
+	if (!test_bit(HCLGE_STATE_RST_HANDLING, &hdev->state))
+		hdev->hw.mac.duplex = HCLGE_MAC_FULL;
+
 	ret = hclge_cfg_mac_speed_dup_hw(hdev, hdev->hw.mac.speed,
 					 hdev->hw.mac.duplex);
 	if (ret) {
-- 
2.43.0


