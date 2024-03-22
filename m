Return-Path: <linux-kernel+bounces-111101-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94DBA8867EC
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 09:07:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C696A1C22050
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 08:07:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 531EE16428;
	Fri, 22 Mar 2024 08:06:58 +0000 (UTC)
Received: from smtpbgsg1.qq.com (smtpbgsg1.qq.com [54.254.200.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4A4114AAE;
	Fri, 22 Mar 2024 08:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.254.200.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711094817; cv=none; b=Pu67heYFRuTS22PG5kZeNpJZmTLIV0uEr2Ysu6qwyRZbkmApl37X4TZoDo6Q6Mh/iKse5Yx2f/RxdRdw86Zov0tL14ygnmkqq7oEH4CnOBwp7n6eV4YogqwGoxjiLrl9Qh2HYcQqVuPT1hCjlwi1HOJDS7xSlfc6ld19ry9UqUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711094817; c=relaxed/simple;
	bh=zeEyzkGVsnYT+UEL/kKr4eYf2sxQMgOT0Az3cEDXNQg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=RjiX+YXIYu4/k0MfSGx69euOhN76lwp7+rIKTHiuPllM6aQT7GXCcb+/RpUHvzTObxz1I+hdy2rrtoC9pX6gfvrnvZFO7Ac6Ngk78Wb0dyL2GxdH4ENDhmDyFbG5LD2qXpV0rvQOp/4VY96UYXLJ+NE5epn2IxPBGzOI7APj/18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=net-swift.com; spf=pass smtp.mailfrom=net-swift.com; arc=none smtp.client-ip=54.254.200.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=net-swift.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=net-swift.com
X-QQ-mid: bizesmtp86t1711094719tskd1b4r
X-QQ-Originating-IP: 6/spgvc5G+FNS3fcq5kQX1slQ/CH+qbDWACeJxyYghs=
Received: from localhost.trustnetic.com ( [183.159.169.46])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 22 Mar 2024 16:05:17 +0800 (CST)
X-QQ-SSF: 01400000000000E0E000000A0000000
X-QQ-FEAT: q+yjhizk/eKkPiEx3g0rTO1cZf/nFOdAGzzaWF1yIEfzYx7KehWAxm3MDQ52i
	dDgGud7Zr33pGI5ZtyN6g5WuhNPzvwa+8pcVPfPqqrX0C8PcQisqBGSRf6Negv1nw0HH9h2
	PSkBb/N3wX8U16X5dhCBU6CkZnPs7Vexi+S1OipUcLBeMkhFJetxvxdPwJLhMVZkiuItfPS
	NGL7grd5+IMQotNmLp0Gqgam4tWODxgaUgwLhh3qYZgSObjgMcv3mKo9G62CE3SieyKv0dJ
	pWoIoUezwQXnnDcjarlHRvAPPqcbVolRvRTlwKuy5jmCalg6DjocFh+NTZFsQWScfsJbtmX
	AyZVhzDw+0nRGpMNwoggnBZbMHFhbpiyglJN/OsSlEMFGSbUubRIChQ7CDyhxufvDUHFiZa
	HwAAxn+eQnQ=
X-QQ-GoodBg: 2
X-BIZMAIL-ID: 18032392528168127567
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
	linux-kernel@vger.kernel.org,
	michal.kubiak@intel.com
Cc: Duanqiang Wen <duanqiangwen@net-swift.com>
Subject: [PATCH net v5] net: txgbe: fix i2c dev name cannot match clkdev
Date: Fri, 22 Mar 2024 16:04:16 +0800
Message-Id: <20240322080416.470517-1-duanqiangwen@net-swift.com>
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
clock.

Change log:
v4-v5: address comments:
	Jiri Pirko:
	Well, since it is used in txgbe_phy.c, it should be probably
	rather defined locally in txgbe_phy.c.
v3->v4: address comments:
	Jakub Kicinski:
	No empty lines between Fixes and Signed-off... please.
v2->v3: address comments:
	Jiawen Wu:
	Please add the define in txgbe_type.h

Fixes: e30cef001da2 ("net: txgbe: fix clk_name exceed MAX_DEV_ID limits")
Signed-off-by: Duanqiang Wen <duanqiangwen@net-swift.com>
---
 drivers/net/ethernet/wangxun/txgbe/txgbe_phy.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/wangxun/txgbe/txgbe_phy.c b/drivers/net/ethernet/wangxun/txgbe/txgbe_phy.c
index 5b5d5e4310d1..2fa511227eac 100644
--- a/drivers/net/ethernet/wangxun/txgbe/txgbe_phy.c
+++ b/drivers/net/ethernet/wangxun/txgbe/txgbe_phy.c
@@ -20,6 +20,8 @@
 #include "txgbe_phy.h"
 #include "txgbe_hw.h"
 
+#define TXGBE_I2C_CLK_DEV_NAME "i2c_dw"
+
 static int txgbe_swnodes_register(struct txgbe *txgbe)
 {
 	struct txgbe_nodes *nodes = &txgbe->nodes;
@@ -571,8 +573,8 @@ static int txgbe_clock_register(struct txgbe *txgbe)
 	char clk_name[32];
 	struct clk *clk;
 
-	snprintf(clk_name, sizeof(clk_name), "i2c_dw.%d",
-		 pci_dev_id(pdev));
+	snprintf(clk_name, sizeof(clk_name), "%s.%d",
+		 TXGBE_I2C_CLK_DEV_NAME, pci_dev_id(pdev));
 
 	clk = clk_register_fixed_rate(NULL, clk_name, NULL, 0, 156250000);
 	if (IS_ERR(clk))
@@ -634,7 +636,7 @@ static int txgbe_i2c_register(struct txgbe *txgbe)
 
 	info.parent = &pdev->dev;
 	info.fwnode = software_node_fwnode(txgbe->nodes.group[SWNODE_I2C]);
-	info.name = "i2c_designware";
+	info.name = TXGBE_I2C_CLK_DEV_NAME;
 	info.id = pci_dev_id(pdev);
 
 	info.res = &DEFINE_RES_IRQ(pdev->irq);
-- 
2.27.0


