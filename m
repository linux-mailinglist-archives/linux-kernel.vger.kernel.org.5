Return-Path: <linux-kernel+bounces-109665-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 68AA3881C34
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 06:50:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F37BE1F22128
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 05:50:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F12AD38DE5;
	Thu, 21 Mar 2024 05:50:21 +0000 (UTC)
Received: from smtpbgbr1.qq.com (smtpbgbr1.qq.com [54.207.19.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C672436B01;
	Thu, 21 Mar 2024 05:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.207.19.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711000221; cv=none; b=W1k2RHh41s6JOHwT/TQCTSS28EE/n+lsbL73ja95k2pxzcSndntaUPh5GpIIJpYFIR2zVKSqRA0MJrVLwHwccb7H18U/S9uJyqk5CAU5iw+cg8MHrJyjO/DUhv/zPkByd/imfy/gd4oOcTgfn4oM9krb22g9UjUtPXYdB35jKiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711000221; c=relaxed/simple;
	bh=7uv8EFsVh7eD440OGZc6ICNreyiuWzQg5NM6zsJpeoU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=q3jOkQt+DOFEMZOM+9nE//UiGxy/fybtqrbBIQZj/zfQI+MVqADKYUd00JZHa5cctfHmdOAp2PzOtW0YrVvVmJch/uumFiXGml6T6smmYZ8WhCz1IK3r4YLHaguzWIkI44RDv/g/pPW+2bwCygTgMA7Y2zkHgjKXLplakLzMZxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=net-swift.com; spf=pass smtp.mailfrom=net-swift.com; arc=none smtp.client-ip=54.207.19.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=net-swift.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=net-swift.com
X-QQ-mid: bizesmtp80t1711000124tyj6iq9w
X-QQ-Originating-IP: gkeWOB6qFOzeF55h0f+CCTlDbmDaFXzFjd1PI+Urf84=
Received: from localhost.trustnetic.com ( [36.20.53.11])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 21 Mar 2024 13:48:42 +0800 (CST)
X-QQ-SSF: 01400000000000E0E000000A0000000
X-QQ-FEAT: cbY9MYqwEzQOQyJIFOUy+5ECy2FnumCbv3yfGCTMujzKOet49rVF+vFOHkQb+
	/8DMw85bwEOnE/7kmbgjeTQnDl6Hj0Hgd0LgTM2Odm5Iyq4luCLVte+Bh9MzsBGYVF9UiW9
	A014SqgMO37KR5G6939B37xPFJFvnBvqWILbAyW1NtPJI4+ahaYZofVUqlIVSQc5NgOtKxD
	x+coD7H8g0TmEfqI7oQQmy1RuWxSB/ltirZ3O9MmjI+RRGossHUQ0Y2sqbgY1kXaXjAOTwG
	h/uQiR6X5ONko7/9Z9kOqlybxaXpvwTvzWpvowvBSEq1TpIMzZ1QyhXw4eTNVEPmlLa/Opc
	69GIbKLzA8w+5TtoY0nooChX9X1cig3Sdbeu/tt9TrEi8zFYeJ9EFLZ/atk4FC/K5zw3jeq
	V06AMJSX2ufwXNjqYOLcjQ==
X-QQ-GoodBg: 2
X-BIZMAIL-ID: 13230281604160527593
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
Subject: [PATCH net v4] net: txgbe: fix i2c dev name cannot match clkdev
Date: Thu, 21 Mar 2024 13:47:42 +0800
Message-Id: <20240321054742.446481-1-duanqiangwen@net-swift.com>
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


