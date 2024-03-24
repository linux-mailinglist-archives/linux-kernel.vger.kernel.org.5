Return-Path: <linux-kernel+bounces-116157-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D52928899D2
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 11:17:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 894A51F33B58
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 10:17:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B8372827DD;
	Mon, 25 Mar 2024 03:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dzFR8A29"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 245B117B4FB;
	Sun, 24 Mar 2024 23:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711323724; cv=none; b=ib6f2naLsQYcXCRY+sfVhrIWxXryqEEcSaYoZI4nYimv3fqVWea6K4ekA6YyvCO8Xd7KhrwgM7I17xsjbHAILtTG2Ti9MUGsE8xZXpUvwQmjqjSbCB2opOn6nAuL2gzsXqyI5fbjVorN+sLMQLwcfmwNkhHc86Nuuh/XOSTh5IE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711323724; c=relaxed/simple;
	bh=EWdZk2t0N8dwccaXvhhlbSDrH2hjfcC9HGHEuRAS7cM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qeUQrehLQI+aH6/gHFc1mrxYEcBrBq08BjKM61xd5J8LPpLta38qcqiNiU1mVAY+b/e3i7Bwggeh/jSl62KuRQBCvkOy167QNGFHlPCS7r2nb8RJSrHT/f4B51yshBTt0bRlSF+OklU0QqDdjSStxWT6GHPYJFJSnNknF3gVlbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dzFR8A29; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B253C433C7;
	Sun, 24 Mar 2024 23:42:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711323723;
	bh=EWdZk2t0N8dwccaXvhhlbSDrH2hjfcC9HGHEuRAS7cM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dzFR8A29vSyrNFSMX3aONdAqnpNEgXWVBPOdzOZJjmL+xAaBqmJHl4hR4q1n2mP1+
	 DvA8WyiXZAgTOQOHcACGZWbcjch7WtOFi9ydM9LdXLOeP0eC87wOEEMXEpW3ncD3OH
	 jg+gGeSE6TmbcNV3wN1R5EsH7gUKBuobKiSzm7slidiNKnWip0o/EFdh0XuL05Jvm9
	 Q8rsjETMfkYU2HQie7zfHvtDZxXrmyiBczjRr8p2V5DluvLCTnURQa29sFaMINHAGv
	 gR6Or4sS/iq8EIw515OyAVmzaBS0oaKn+2KGMdqx5loiU1T0eJ52awWKI4aku+soLu
	 LLqabG4Fs8yBQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Jie Wang <wangjie125@huawei.com>,
	Jijie Shao <shaojijie@huawei.com>,
	"David S . Miller" <davem@davemloft.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 096/238] net: hns3: fix port duplex configure error in IMP reset
Date: Sun, 24 Mar 2024 19:38:04 -0400
Message-ID: <20240324234027.1354210-97-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324234027.1354210-1-sashal@kernel.org>
References: <20240324234027.1354210-1-sashal@kernel.org>
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
index deba485ced1bd..c14c391a0cec6 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
@@ -2723,7 +2723,10 @@ static int hclge_mac_init(struct hclge_dev *hdev)
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


