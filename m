Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0BAC809C38
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 07:12:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232971AbjLHGMU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 01:12:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232926AbjLHGMS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 01:12:18 -0500
Received: from SHSQR01.spreadtrum.com (unknown [222.66.158.135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7549810FC
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 22:12:23 -0800 (PST)
Received: from dlp.unisoc.com ([10.29.3.86])
        by SHSQR01.spreadtrum.com with ESMTP id 3B86Bwrb083429;
        Fri, 8 Dec 2023 14:11:58 +0800 (+08)
        (envelope-from Yanxin.Huang@unisoc.com)
Received: from SHDLP.spreadtrum.com (shmbx06.spreadtrum.com [10.0.1.11])
        by dlp.unisoc.com (SkyGuard) with ESMTPS id 4SmgcZ5Xrrz2PBJ7j;
        Fri,  8 Dec 2023 14:06:06 +0800 (CST)
Received: from xm9614pcu.spreadtrum.com (10.13.2.29) by shmbx06.spreadtrum.com
 (10.0.1.11) with Microsoft SMTP Server (TLS) id 15.0.1497.23; Fri, 8 Dec 2023
 14:11:57 +0800
From:   Yanxin Huang <yanxin.huang@unisoc.com>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>
CC:     <linux-kernel@vger.kernel.org>,
        huang yanxin <yanxin.huang07@gmail.com>,
        Wenming Wu <wenming.wu@unisoc.com>
Subject: [PATCH 2/3] nvmem: sprd: Fix programming errors in efuse caused by incorrect parameters
Date:   Fri, 8 Dec 2023 14:11:33 +0800
Message-ID: <20231208061134.26354-2-yanxin.huang@unisoc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20231208061134.26354-1-yanxin.huang@unisoc.com>
References: <20231208061134.26354-1-yanxin.huang@unisoc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.13.2.29]
X-ClientProxiedBy: SHCAS03.spreadtrum.com (10.0.1.207) To
 shmbx06.spreadtrum.com (10.0.1.11)
X-MAIL: SHSQR01.spreadtrum.com 3B86Bwrb083429
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,MAY_BE_FORGED,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The second argument to sprd_efuse_raw_prog() is the efuse index block
data, but the data passed in is the efuse block offset, which can cause
efuse to be programmed to the wrong block.

Fixes: 096030e7f449 ("nvmem: sprd: Add Spreadtrum SoCs eFuse support")
Signed-off-by: Yanxin Huang <yanxin.huang@unisoc.com>
---
 drivers/nvmem/sprd-efuse.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/nvmem/sprd-efuse.c b/drivers/nvmem/sprd-efuse.c
index 24b63620d217..f0880f8fc56d 100644
--- a/drivers/nvmem/sprd-efuse.c
+++ b/drivers/nvmem/sprd-efuse.c
@@ -326,6 +326,7 @@ static int sprd_efuse_write(void *context, u32 offset, void *val, size_t bytes)
 {
 	struct sprd_efuse *efuse = context;
 	bool blk_double = efuse->data->blk_double;
+	u32 index = offset / SPRD_EFUSE_BLOCK_WIDTH + efuse->data->blk_offset;
 	bool lock;
 	int ret;
 
@@ -350,7 +351,7 @@ static int sprd_efuse_write(void *context, u32 offset, void *val, size_t bytes)
 	else
 		lock = true;
 
-	ret = sprd_efuse_raw_prog(efuse, offset, blk_double, lock, val);
+	ret = sprd_efuse_raw_prog(efuse, index, blk_double, lock, val);
 
 	clk_disable_unprepare(efuse->clk);
 
-- 
2.17.1

