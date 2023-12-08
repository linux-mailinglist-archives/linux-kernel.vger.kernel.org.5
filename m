Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A15C809C3A
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 07:12:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233182AbjLHGMZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 01:12:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232926AbjLHGMV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 01:12:21 -0500
Received: from SHSQR01.spreadtrum.com (mx1.unisoc.com [222.66.158.135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B434610FC
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 22:12:26 -0800 (PST)
Received: from dlp.unisoc.com ([10.29.3.86])
        by SHSQR01.spreadtrum.com with ESMTP id 3B86C7if084216;
        Fri, 8 Dec 2023 14:12:07 +0800 (+08)
        (envelope-from Yanxin.Huang@unisoc.com)
Received: from SHDLP.spreadtrum.com (shmbx06.spreadtrum.com [10.0.1.11])
        by dlp.unisoc.com (SkyGuard) with ESMTPS id 4Smgcl3pKgz2PBJ7g;
        Fri,  8 Dec 2023 14:06:15 +0800 (CST)
Received: from xm9614pcu.spreadtrum.com (10.13.2.29) by shmbx06.spreadtrum.com
 (10.0.1.11) with Microsoft SMTP Server (TLS) id 15.0.1497.23; Fri, 8 Dec 2023
 14:12:06 +0800
From:   Yanxin Huang <yanxin.huang@unisoc.com>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>
CC:     <linux-kernel@vger.kernel.org>,
        huang yanxin <yanxin.huang07@gmail.com>,
        Wenming Wu <wenming.wu@unisoc.com>
Subject: [PATCH 3/3] nvmem: sprd: Remove the lock operation to support customers being able to program efuse multiple times
Date:   Fri, 8 Dec 2023 14:11:34 +0800
Message-ID: <20231208061134.26354-3-yanxin.huang@unisoc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20231208061134.26354-1-yanxin.huang@unisoc.com>
References: <20231208061134.26354-1-yanxin.huang@unisoc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.13.2.29]
X-ClientProxiedBy: SHCAS03.spreadtrum.com (10.0.1.207) To
 shmbx06.spreadtrum.com (10.0.1.11)
X-MAIL: SHSQR01.spreadtrum.com 3B86C7if084216
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The customer uses the efuse interface to program efuse based on block
size. Each time a part of the content is programmed, according to the
original code logic, as long as the bytes parameter is equal to the block
size, the block will be locked, which will result in the efuse block
being unable to program multiple times.

This patch removes the efuse block locking operation, as the unisoc efuse
driver supports customers to program the same block multiple times.If you
need to lock a block, you can directly program the lock bit of the block.

Signed-off-by: Yanxin Huang <yanxin.huang@unisoc.com>
---
 drivers/nvmem/sprd-efuse.c | 57 ++------------------------------------
 1 file changed, 2 insertions(+), 55 deletions(-)

diff --git a/drivers/nvmem/sprd-efuse.c b/drivers/nvmem/sprd-efuse.c
index f0880f8fc56d..5220fd680f47 100644
--- a/drivers/nvmem/sprd-efuse.c
+++ b/drivers/nvmem/sprd-efuse.c
@@ -143,30 +143,6 @@ static void sprd_efuse_set_read_power(struct sprd_efuse *efuse, bool en)
 	usleep_range(1000, 1200);
 }
 
-static void sprd_efuse_set_prog_lock(struct sprd_efuse *efuse, bool en)
-{
-	u32 val = readl(efuse->base + SPRD_EFUSE_ENABLE);
-
-	if (en)
-		val |= SPRD_EFUSE_LOCK_WR_EN;
-	else
-		val &= ~SPRD_EFUSE_LOCK_WR_EN;
-
-	writel(val, efuse->base + SPRD_EFUSE_ENABLE);
-}
-
-static void sprd_efuse_set_auto_check(struct sprd_efuse *efuse, bool en)
-{
-	u32 val = readl(efuse->base + SPRD_EFUSE_ENABLE);
-
-	if (en)
-		val |= SPRD_EFUSE_AUTO_CHECK_EN;
-	else
-		val &= ~SPRD_EFUSE_AUTO_CHECK_EN;
-
-	writel(val, efuse->base + SPRD_EFUSE_ENABLE);
-}
-
 static void sprd_efuse_set_data_double(struct sprd_efuse *efuse, bool en)
 {
 	u32 val = readl(efuse->base + SPRD_EFUSE_ENABLE);
@@ -191,8 +167,7 @@ static void sprd_efuse_set_prog_en(struct sprd_efuse *efuse, bool en)
 	writel(val, efuse->base + SPRD_EFUSE_PW_SWT);
 }
 
-static int sprd_efuse_raw_prog(struct sprd_efuse *efuse, u32 blk, bool doub,
-			       bool lock, u32 *data)
+static int sprd_efuse_raw_prog(struct sprd_efuse *efuse, u32 blk, bool doub, u32 *data)
 {
 	u32 status;
 	int ret = 0;
@@ -213,18 +188,8 @@ static int sprd_efuse_raw_prog(struct sprd_efuse *efuse, u32 blk, bool doub,
 	sprd_efuse_set_prog_en(efuse, true);
 	sprd_efuse_set_data_double(efuse, doub);
 
-	/*
-	 * Enable the auto-check function to validate if the programming is
-	 * successful.
-	 */
-	if (lock)
-		sprd_efuse_set_auto_check(efuse, true);
-
 	writel(*data, efuse->base + SPRD_EFUSE_MEM(blk));
 
-	/* Disable auto-check and data double after programming */
-	if (lock)
-		sprd_efuse_set_auto_check(efuse, false);
 	sprd_efuse_set_data_double(efuse, false);
 
 	/*
@@ -239,10 +204,6 @@ static int sprd_efuse_raw_prog(struct sprd_efuse *efuse, u32 blk, bool doub,
 		writel(SPRD_EFUSE_ERR_CLR_MASK,
 		       efuse->base + SPRD_EFUSE_ERR_CLR);
 		ret = -EBUSY;
-	} else if (lock) {
-		sprd_efuse_set_prog_lock(efuse, lock);
-		writel(0, efuse->base + SPRD_EFUSE_MEM(blk));
-		sprd_efuse_set_prog_lock(efuse, false);
 	}
 
 	sprd_efuse_set_prog_power(efuse, false);
@@ -327,7 +288,6 @@ static int sprd_efuse_write(void *context, u32 offset, void *val, size_t bytes)
 	struct sprd_efuse *efuse = context;
 	bool blk_double = efuse->data->blk_double;
 	u32 index = offset / SPRD_EFUSE_BLOCK_WIDTH + efuse->data->blk_offset;
-	bool lock;
 	int ret;
 
 	ret = sprd_efuse_lock(efuse);
@@ -338,20 +298,7 @@ static int sprd_efuse_write(void *context, u32 offset, void *val, size_t bytes)
 	if (ret)
 		goto unlock;
 
-	/*
-	 * If the writing bytes are equal with the block width, which means the
-	 * whole block will be programmed. For this case, we should not allow
-	 * this block to be programmed again by locking this block.
-	 *
-	 * If the block was programmed partially, we should allow this block to
-	 * be programmed again.
-	 */
-	if (bytes < SPRD_EFUSE_BLOCK_WIDTH)
-		lock = false;
-	else
-		lock = true;
-
-	ret = sprd_efuse_raw_prog(efuse, index, blk_double, lock, val);
+	ret = sprd_efuse_raw_prog(efuse, index, blk_double, val);
 
 	clk_disable_unprepare(efuse->clk);
 
-- 
2.17.1

