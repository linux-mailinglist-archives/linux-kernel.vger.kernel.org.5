Return-Path: <linux-kernel+bounces-109561-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EAB12881AD8
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 03:11:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7FD7C1F21C9E
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 02:11:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D60C65660;
	Thu, 21 Mar 2024 02:11:28 +0000 (UTC)
Received: from smtpbgbr2.qq.com (smtpbgbr2.qq.com [54.207.22.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E0111C17;
	Thu, 21 Mar 2024 02:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.207.22.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710987088; cv=none; b=tsvPOy+JdB120RRjlhAJ2sD/KIyY77gIFS8s32ZG9tBrTdABYU5kW8oZdTwSBsqWZj6vbo1HpUe54mZKWh58Y04trXv0U7BkPVgli+rpgaK/B69nWcyDNfWafTMuzXDjxxuIbDwaMXRyXq3sL+nJvfYPh6M+Xoerlkt4Nzt/MZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710987088; c=relaxed/simple;
	bh=4ITDb+8GVjoG5VsePRPsACbi95Rav0EAMwwDUxcdrvw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=BEqdjGm3J/c9E8Te6CdFPW1uIRKhWTkf+pzunEPLfjhjPPAQcXWURE1VY/8fu1NoE8rCUYNANT8ZvgDLFBS+1oFdEqNfgSjv8GkpNedOwchSdpmRNOhueJqWbgHK/XN4kKki3UOuMYffaWYQg+gHuTeimhtrC2tjJSvdJh55vGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=net-swift.com; spf=pass smtp.mailfrom=net-swift.com; arc=none smtp.client-ip=54.207.22.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=net-swift.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=net-swift.com
X-QQ-mid: bizesmtp65t1710987003tnioa00y
X-QQ-Originating-IP: H4Wm9edfG7DdwHkANWjFYU+xfguKST9S4SI4M5UujPA=
Received: from localhost.trustnetic.com ( [36.20.53.11])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 21 Mar 2024 10:10:01 +0800 (CST)
X-QQ-SSF: 01400000000000E0E000000A0000000
X-QQ-FEAT: C46Rb8GPIEf1JvmGOoWrNO1JWSfuelu3huhduuBOqNKQmLWMjraLn14xkAhHn
	daBqxKvRP5VoCycNFkPec3UxLvdjGalX1RRVly4VOFmzZVNKFBchLRLzYZqOfINyljoNRmr
	sKHPHlM4eLhFitlwgR5pBTaWLdOQsW3McEZ+XrqjxEhAnACjljmh1vngwn6VYIib2JBaGQX
	jPCqX2Z9IdS6ert8xPGQ9ZDTPY62x32LGgpVi5FnYkdvNxjgkVmbu5+M/YPtD31bmm5TZjF
	r0Mq3lgqSwBbGuOb/kUh2m47JKR7+PQ6cOOXLE1cetqylE2Hqz3nieh2+soJI0sd26Eewyg
	RLGA3KDfOldDj3N8l7zZS2eU8N0M++FZgf13D3fRYamYP2G26wDhy7p2gd7IqHeI53WyzlV
	WIq7SZxC/owXqFw0vmiwdg==
X-QQ-GoodBg: 2
X-BIZMAIL-ID: 9577786654492247915
From: Duanqiang Wen <duanqiangwen@net-swift.com>
To: netdev@vger.kernel.org,
	jiawenwu@trustnetic.com,
	mengyuanlou@net-swift.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	maciej.fijalkowski@intel.com,
	andrew@lunn.ch,
	wangxiongfeng2@huawei.com,
	linux-kernel@vger.kernel.org
Cc: Duanqiang Wen <duanqiangwen@net-swift.com>
Subject: [PATCH net v3] net: txgbe: fix i2c dev name cannot match clkdev
Date: Thu, 21 Mar 2024 10:09:01 +0800
Message-Id: <20240321020901.443642-1-duanqiangwen@net-swift.com>
X-Mailer: git-send-email 2.27.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:net-swift.com:qybglogicsvrsz:qybglogicsvrsz3a-1

txgbe clkdev shortened clk_name, so i2c_dev info_name
also need to shorten. Otherwise, i2c_dev cannot initialize
clock. And had "i2c_dw" string in a define.

Fixes: e30cef001da2 ("net: txgbe: fix clk_name exceed MAX_DEV_ID limits")

Signed-off-by: Duanqiang Wen <duanqiangwen@net-swift.com>
---
 drivers/net/ethernet/wangxun/txgbe/txgbe_phy.c  | 6 +++---
 drivers/net/ethernet/wangxun/txgbe/txgbe_type.h | 2 ++
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/wangxun/txgbe/txgbe_phy.c b/drivers/net/ethernet/wangxun/txgbe/txgbe_phy.c
index 5b5d5e4310d1..3f61f161f1ed 100644
--- a/drivers/net/ethernet/wangxun/txgbe/txgbe_phy.c
+++ b/drivers/net/ethernet/wangxun/txgbe/txgbe_phy.c
@@ -571,8 +571,8 @@ static int txgbe_clock_register(struct txgbe *txgbe)
 	char clk_name[32];
 	struct clk *clk;
 
-	snprintf(clk_name, sizeof(clk_name), "i2c_dw.%d",
-		 pci_dev_id(pdev));
+	snprintf(clk_name, sizeof(clk_name), "%s.%d",
+		 TXGBE_I2C_CLK_DEV_NAME, pci_dev_id(pdev));
 
 	clk = clk_register_fixed_rate(NULL, clk_name, NULL, 0, 156250000);
 	if (IS_ERR(clk))
@@ -634,7 +634,7 @@ static int txgbe_i2c_register(struct txgbe *txgbe)
 
 	info.parent = &pdev->dev;
 	info.fwnode = software_node_fwnode(txgbe->nodes.group[SWNODE_I2C]);
-	info.name = "i2c_designware";
+	info.name = TXGBE_I2C_CLK_DEV_NAME;
 	info.id = pci_dev_id(pdev);
 
 	info.res = &DEFINE_RES_IRQ(pdev->irq);
diff --git a/drivers/net/ethernet/wangxun/txgbe/txgbe_type.h b/drivers/net/ethernet/wangxun/txgbe/txgbe_type.h
index 1b4ff50d5857..de33313c475f 100644
--- a/drivers/net/ethernet/wangxun/txgbe/txgbe_type.h
+++ b/drivers/net/ethernet/wangxun/txgbe/txgbe_type.h
@@ -129,6 +129,8 @@
 
 #define TXGBE_MAX_EITR        GENMASK(11, 3)
 
+#define TXGBE_I2C_CLK_DEV_NAME "i2c_dw"
+
 extern char txgbe_driver_name[];
 
 void txgbe_down(struct wx *wx);
-- 
2.27.0


