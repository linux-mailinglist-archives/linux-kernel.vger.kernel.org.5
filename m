Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BB3D77C5F1
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 04:35:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234308AbjHOCfX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 22:35:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234266AbjHOCfK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 22:35:10 -0400
Received: from SHSQR01.spreadtrum.com (mx1.unisoc.com [222.66.158.135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79C3D10C1;
        Mon, 14 Aug 2023 19:35:09 -0700 (PDT)
Received: from dlp.unisoc.com ([10.29.3.86])
        by SHSQR01.spreadtrum.com with ESMTP id 37F2Ym7u067138;
        Tue, 15 Aug 2023 10:34:48 +0800 (+08)
        (envelope-from Jiansheng.Wu@unisoc.com)
Received: from SHDLP.spreadtrum.com (shmbx05.spreadtrum.com [10.29.1.56])
        by dlp.unisoc.com (SkyGuard) with ESMTPS id 4RPwKN1bytz2P8CXW;
        Tue, 15 Aug 2023 10:32:40 +0800 (CST)
Received: from xm9614pcu.spreadtrum.com (10.13.2.29) by shmbx05.spreadtrum.com
 (10.29.1.56) with Microsoft SMTP Server (TLS) id 15.0.1497.23; Tue, 15 Aug
 2023 10:34:45 +0800
From:   Jiansheng Wu <jiansheng.wu@unisoc.com>
To:     Mark Brown <broonie@kernel.org>, Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>
CC:     <linux-spi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <yongzhi.chen@unisoc.com>, <xiaoqing.wu@unisoc.com>,
        <jianshengwu16@gmail.com>
Subject: [PATCH 3/8] Spi: sprd-adi: Added the cause of reboot
Date:   Tue, 15 Aug 2023 10:34:21 +0800
Message-ID: <20230815023426.15076-3-jiansheng.wu@unisoc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230815023426.15076-1-jiansheng.wu@unisoc.com>
References: <20230815023426.15076-1-jiansheng.wu@unisoc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.13.2.29]
X-ClientProxiedBy: SHCAS03.spreadtrum.com (10.0.1.207) To
 shmbx05.spreadtrum.com (10.29.1.56)
X-MAIL: SHSQR01.spreadtrum.com 37F2Ym7u067138
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Added the silent and dmverity methods to reboot mode that the system
need enter the silent or secboot mode after restarting system.

Signed-off-by: Jiansheng Wu <jiansheng.wu@unisoc.com>
---
 drivers/spi/spi-sprd-adi.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/spi/spi-sprd-adi.c b/drivers/spi/spi-sprd-adi.c
index 734245492680..569a66943e8d 100644
--- a/drivers/spi/spi-sprd-adi.c
+++ b/drivers/spi/spi-sprd-adi.c
@@ -118,6 +118,7 @@
 
 /* Definition of PMIC reset status register */
 #define HWRST_STATUS_SECURITY		0x02
+#define HWRST_STATUS_SECBOOT		0x03
 #define HWRST_STATUS_RECOVERY		0x20
 #define HWRST_STATUS_NORMAL		0x40
 #define HWRST_STATUS_ALARM		0x50
@@ -129,6 +130,7 @@
 #define HWRST_STATUS_AUTODLOADER	0xa0
 #define HWRST_STATUS_IQMODE		0xb0
 #define HWRST_STATUS_SPRDISK		0xc0
+#define HWRST_STATUS_SILENT             0xd0
 #define HWRST_STATUS_FACTORYTEST	0xe0
 #define HWRST_STATUS_WATCHDOG		0xf0
 
@@ -438,8 +440,12 @@ static int sprd_adi_restart_handler(struct notifier_block *this, unsigned long m
 		reboot_mode = HWRST_STATUS_SPRDISK;
 	else if (!strncmp(cmd, "tospanic", 8))
 		reboot_mode = HWRST_STATUS_SECURITY;
+	else if (!strncmp(cmd, "dm-verity", 9))
+		reboot_mode = HWRST_STATUS_SECBOOT;
 	else if (!strncmp(cmd, "factorytest", 11))
 		reboot_mode = HWRST_STATUS_FACTORYTEST;
+	else if (!strncmp(cmd, "silent", 6))
+		reboot_mode = HWRST_STATUS_SILENT;
 	else
 		reboot_mode = HWRST_STATUS_NORMAL;
 
-- 
2.17.1

