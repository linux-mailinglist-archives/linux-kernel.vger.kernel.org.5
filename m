Return-Path: <linux-kernel+bounces-109556-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B8C57881AC9
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 02:54:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 58A021F21D19
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 01:54:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3BEC6FC5;
	Thu, 21 Mar 2024 01:54:11 +0000 (UTC)
Received: from smtpbg151.qq.com (smtpbg151.qq.com [18.169.211.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C5EC1877;
	Thu, 21 Mar 2024 01:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.169.211.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710986051; cv=none; b=YyB8JhzIofVz97AVX+mYri6SKgxRWSLD1+ZFQ6+d+MjUxPohkfx455ulhctQWujUh74UnaN2DvMKA/lx7ov0Nm5kZIOWDtKSjIS8XPaZLGtdk78NZotXjmyWAhATlaVwb1DiF6PPa5sin8V6v7J1dKY/Iw1sHfEP4llT8sXeF8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710986051; c=relaxed/simple;
	bh=OAXe9PQlq17asOfDjShl9e6DBsvArHfVr7liqKH+XE4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Ikd+8rlxoQpEm4Scw90CIqfNPgS8vEH7ClQIRrg/TgvCXJTqQdQc1IhWIDRPFJkznvYbUvuLz4i1ucl3SUpQcBYMPAvhl8CqwK9YSR0DyvaFk+WAkQG/UoTu++FsEkrs2V9EHtOiNfAdUkUqPl+Kfzunz2nc75PyP0uDnwdFwZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=net-swift.com; spf=pass smtp.mailfrom=net-swift.com; arc=none smtp.client-ip=18.169.211.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=net-swift.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=net-swift.com
X-QQ-mid: bizesmtp81t1710985960ta4oe8mn
X-QQ-Originating-IP: K4MtTSgi3savbGAI3VMA7OWxK9HTgOYQ4VuiXRtMf1I=
Received: from localhost.trustnetic.com ( [36.20.53.11])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 21 Mar 2024 09:52:38 +0800 (CST)
X-QQ-SSF: 01400000000000E0E000000A0000000
X-QQ-FEAT: C46Rb8GPIEchRFcWlJ3D+/pMFI1tYLcQ65M7g5F56loHd2jqUJPGDlT9j4vlG
	I07JNSdxYIPUXeDUVAGtFih0CdL1XYmCwMoNyFnaJrI9AZazMcAue/USHZF3qZGkqZC2QY1
	RbJDIPSmSXtqOcqjGTM93OGHambdSVfZ2biOJxSQOrMeAuL3S9m1eoOZbkS0drwHgMgOC8M
	Vfda0gpGhlT5BFLzcaKTP95wcY+8NgsMSkQSzzz6eaFlhcm0ku9dRRg7YJGRV1PXxbsqJBM
	Qo12YmPsmhc/r2+vngTLaYVMEWcJyMYs752Zx5Db+07ktsHZ1EcYQHffKxABQQ3KEAwqo7G
	0gK4Jf7CBBB1+ovcNN2Jn3WOneuh+dI5otp6icXYa7WJDBDipLN9kQAlm0Z2o17vg4ffsnu
	Ukqwoor4Elc=
X-QQ-GoodBg: 2
X-BIZMAIL-ID: 11865926464332669648
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
Subject: [PATCH net v2] net: txgbe: fix i2c dev name cannot match clkdev
Date: Thu, 21 Mar 2024 09:51:39 +0800
Message-Id: <20240321015139.437376-1-duanqiangwen@net-swift.com>
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
 drivers/net/ethernet/wangxun/txgbe/txgbe_phy.c | 6 +++---
 drivers/net/ethernet/wangxun/txgbe/txgbe_phy.h | 2 ++
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
diff --git a/drivers/net/ethernet/wangxun/txgbe/txgbe_phy.h b/drivers/net/ethernet/wangxun/txgbe/txgbe_phy.h
index 8a026d804fe2..c7f2157f3d95 100644
--- a/drivers/net/ethernet/wangxun/txgbe/txgbe_phy.h
+++ b/drivers/net/ethernet/wangxun/txgbe/txgbe_phy.h
@@ -4,6 +4,8 @@
 #ifndef _TXGBE_PHY_H_
 #define _TXGBE_PHY_H_
 
+#define TXGBE_I2C_CLK_DEV_NAME "i2c_dw"
+
 irqreturn_t txgbe_gpio_irq_handler(int irq, void *data);
 void txgbe_reinit_gpio_intr(struct wx *wx);
 irqreturn_t txgbe_link_irq_handler(int irq, void *data);
-- 
2.27.0


