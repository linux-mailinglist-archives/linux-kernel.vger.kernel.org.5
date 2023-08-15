Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A9C477C5F9
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 04:36:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234313AbjHOCfz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 22:35:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234323AbjHOCf1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 22:35:27 -0400
Received: from SHSQR01.spreadtrum.com (unknown [222.66.158.135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28D6010D0;
        Mon, 14 Aug 2023 19:35:26 -0700 (PDT)
Received: from dlp.unisoc.com ([10.29.3.86])
        by SHSQR01.spreadtrum.com with ESMTP id 37F2YvbZ067529;
        Tue, 15 Aug 2023 10:34:57 +0800 (+08)
        (envelope-from Jiansheng.Wu@unisoc.com)
Received: from SHDLP.spreadtrum.com (shmbx05.spreadtrum.com [10.29.1.56])
        by dlp.unisoc.com (SkyGuard) with ESMTPS id 4RPwKY5TqTz2P8CXW;
        Tue, 15 Aug 2023 10:32:49 +0800 (CST)
Received: from xm9614pcu.spreadtrum.com (10.13.2.29) by shmbx05.spreadtrum.com
 (10.29.1.56) with Microsoft SMTP Server (TLS) id 15.0.1497.23; Tue, 15 Aug
 2023 10:34:55 +0800
From:   Jiansheng Wu <jiansheng.wu@unisoc.com>
To:     Mark Brown <broonie@kernel.org>, Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>
CC:     <linux-spi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <yongzhi.chen@unisoc.com>, <xiaoqing.wu@unisoc.com>,
        <jianshengwu16@gmail.com>
Subject: [PATCH 7/8] Spi: sprd-adi: Waiting write_cmd is finished
Date:   Tue, 15 Aug 2023 10:34:25 +0800
Message-ID: <20230815023426.15076-7-jiansheng.wu@unisoc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230815023426.15076-1-jiansheng.wu@unisoc.com>
References: <20230815023426.15076-1-jiansheng.wu@unisoc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.13.2.29]
X-ClientProxiedBy: SHCAS03.spreadtrum.com (10.0.1.207) To
 shmbx05.spreadtrum.com (10.29.1.56)
X-MAIL: SHSQR01.spreadtrum.com 37F2YvbZ067529
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Checeking state on write_cmd, and return flag of result. It is a new
function on UMS9620 to verify that the data transfer is complete.

Signed-off-by: XiaoQing Wu <xiaoqing.wu@unisoc.com>
Signed-off-by: Jiansheng Wu <jiansheng.wu@unisoc.com>
---
 drivers/spi/spi-sprd-adi.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/drivers/spi/spi-sprd-adi.c b/drivers/spi/spi-sprd-adi.c
index 0b20c228e119..8c518c227549 100644
--- a/drivers/spi/spi-sprd-adi.c
+++ b/drivers/spi/spi-sprd-adi.c
@@ -48,6 +48,7 @@
 #define RD_ADDR_MASK			GENMASK(30, 16)
 
 /* Bits definitions for register REG_ADI_ARM_FIFO_STS */
+#define BIT_ARM_WR_FREQ			BIT(31)
 #define BIT_FIFO_FULL			BIT(11)
 #define BIT_FIFO_EMPTY			BIT(10)
 
@@ -78,6 +79,7 @@
 
 #define ADI_FIFO_DRAIN_TIMEOUT		1000
 #define ADI_READ_TIMEOUT		2000
+#define ADI_WRITE_TIMEOUT		2000
 
 /*
  * Read back address from REG_ADI_RD_DATA bit[30:16] which maps to:
@@ -150,6 +152,7 @@
 struct sprd_adi_data {
 	u32 slave_offset;
 	u32 slave_addr_size;
+	int (*write_wait)(void __iomem *adi_base);
 	int (*read_check)(u32 val, u32 reg);
 	u32 rst_sts;
 	u32 swrst_base;
@@ -247,6 +250,22 @@ static int sprd_adi_read_check(u32 val, u32 addr)
 	return 0;
 }
 
+static int sprd_adi_write_wait(void __iomem *adi_base)
+{
+	unsigned int write_timeout = ADI_WRITE_TIMEOUT;
+	u32 val;
+
+	do {
+		val = readl_relaxed(adi_base + REG_ADI_ARM_FIFO_STS);
+		if (!(val & BIT_ARM_WR_FREQ))
+			return 0;
+		cpu_relax();
+	} while (--write_timeout);
+
+	pr_err("ADI write fail, sts = 0x%02x\n", val);
+	return -EBUSY;
+}
+
 static int sprd_adi_read_check_r2(u32 val, u32 reg)
 {
 	return sprd_adi_read_check(val, reg & RDBACK_ADDR_MASK_R2);
@@ -365,8 +384,12 @@ static int sprd_adi_write(struct sprd_adi *sadi, u32 reg, u32 val)
 	if (timeout == 0) {
 		dev_err(sadi->dev, "write fifo is full\n");
 		ret = -EBUSY;
+		goto out;
 	}
 
+	if (sadi->data->write_wait)
+		ret = sadi->data->write_wait(sadi->base);
+
 out:
 	if (sadi->hwlock)
 		hwspin_unlock_irqrestore(sadi->hwlock, &flags);
@@ -691,6 +714,7 @@ static struct sprd_adi_data ums512_data = {
 };
 
 static struct sprd_adi_data ums9620_data = {
+	.write_wait = sprd_adi_write_wait,
 	.slave_offset = ADI_15BIT_SLAVE_OFFSET,
 	.slave_addr_size = ADI_15BIT_SLAVE_ADDR_SIZE,
 	.rst_sts = UMP9620_RST_STATUS,
-- 
2.17.1

