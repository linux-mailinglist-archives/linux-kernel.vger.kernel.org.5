Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7FCD77C5F7
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 04:36:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234281AbjHOCfv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 22:35:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234265AbjHOCfU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 22:35:20 -0400
Received: from SHSQR01.spreadtrum.com (unknown [222.66.158.135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7CC210C1;
        Mon, 14 Aug 2023 19:35:18 -0700 (PDT)
Received: from dlp.unisoc.com ([10.29.3.86])
        by SHSQR01.spreadtrum.com with ESMTP id 37F2Ythv067477;
        Tue, 15 Aug 2023 10:34:55 +0800 (+08)
        (envelope-from Jiansheng.Wu@unisoc.com)
Received: from SHDLP.spreadtrum.com (shmbx05.spreadtrum.com [10.29.1.56])
        by dlp.unisoc.com (SkyGuard) with ESMTPS id 4RPwKW3cwjz2PgxhY;
        Tue, 15 Aug 2023 10:32:47 +0800 (CST)
Received: from xm9614pcu.spreadtrum.com (10.13.2.29) by shmbx05.spreadtrum.com
 (10.29.1.56) with Microsoft SMTP Server (TLS) id 15.0.1497.23; Tue, 15 Aug
 2023 10:34:52 +0800
From:   Jiansheng Wu <jiansheng.wu@unisoc.com>
To:     Mark Brown <broonie@kernel.org>, Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>
CC:     <linux-spi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <yongzhi.chen@unisoc.com>, <xiaoqing.wu@unisoc.com>,
        <jianshengwu16@gmail.com>
Subject: [PATCH 5/8] Spi: sprd-adi: Checking panic reason from sml
Date:   Tue, 15 Aug 2023 10:34:23 +0800
Message-ID: <20230815023426.15076-5-jiansheng.wu@unisoc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230815023426.15076-1-jiansheng.wu@unisoc.com>
References: <20230815023426.15076-1-jiansheng.wu@unisoc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.13.2.29]
X-ClientProxiedBy: SHCAS03.spreadtrum.com (10.0.1.207) To
 shmbx05.spreadtrum.com (10.29.1.56)
X-MAIL: SHSQR01.spreadtrum.com 37F2Ythv067477
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Checking panic reason from sml and recording reboot mode to pmic's reg.
It used to check reboot reason on next boot.

Signed-off-by: XiaoQing Wu <xiaoqing.wu@unisoc.com>
Signed-off-by: Jiansheng Wu <jiansheng.wu@unisoc.com>
---
 drivers/spi/spi-sprd-adi.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-sprd-adi.c b/drivers/spi/spi-sprd-adi.c
index eea64d20279e..c31035fffe4c 100644
--- a/drivers/spi/spi-sprd-adi.c
+++ b/drivers/spi/spi-sprd-adi.c
@@ -119,6 +119,7 @@
 /* Definition of PMIC reset status register */
 #define HWRST_STATUS_SECURITY		0x02
 #define HWRST_STATUS_SECBOOT		0x03
+#define HWRST_STATUS_SML_PANIC          0x04
 #define HWRST_STATUS_RECOVERY		0x20
 #define HWRST_STATUS_NORMAL		0x40
 #define HWRST_STATUS_ALARM		0x50
@@ -410,7 +411,7 @@ static int sprd_adi_restart_handler(struct notifier_block *this, unsigned long m
 {
 	struct sprd_adi *sadi = container_of(this, struct sprd_adi,
 					     restart_handler);
-	u32 val, reboot_mode = 0;
+	u32 val = 0, reboot_mode = 0, sml_mode;
 
 	if (!cmd) {
 		if (strlen(panic_reason)) {
@@ -453,9 +454,12 @@ static int sprd_adi_restart_handler(struct notifier_block *this, unsigned long m
 
 	/* Record the reboot mode */
 	sprd_adi_read(sadi, sadi->data->rst_sts, &val);
-	val &= ~0xFF;
-	val |= reboot_mode;
-	sprd_adi_write(sadi, sadi->data->rst_sts, val);
+	sml_mode = val & 0xFF;
+	if (sml_mode != HWRST_STATUS_SML_PANIC && sml_mode != HWRST_STATUS_SECURITY) {
+		val &= ~0xFF;
+		val |= reboot_mode;
+		sprd_adi_write(sadi, sadi->data->rst_sts, val);
+	}
 
 	/*enable register reboot mode*/
 	sprd_adi_read(sadi, sadi->data->swrst_base, &val);
-- 
2.17.1

