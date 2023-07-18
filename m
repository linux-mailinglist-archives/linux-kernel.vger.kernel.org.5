Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE01175714A
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 03:16:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230377AbjGRBQH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 21:16:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229790AbjGRBQF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 21:16:05 -0400
Received: from SHSQR01.spreadtrum.com (mx1.unisoc.com [222.66.158.135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52C55ED;
        Mon, 17 Jul 2023 18:16:03 -0700 (PDT)
Received: from dlp.unisoc.com ([10.29.3.86])
        by SHSQR01.spreadtrum.com with ESMTP id 36I1Fh0f083467;
        Tue, 18 Jul 2023 09:15:43 +0800 (+08)
        (envelope-from Wenchao.Chen@unisoc.com)
Received: from SHDLP.spreadtrum.com (shmbx05.spreadtrum.com [10.29.1.56])
        by dlp.unisoc.com (SkyGuard) with ESMTPS id 4R4gw56j5sz2MZTl1;
        Tue, 18 Jul 2023 09:14:29 +0800 (CST)
Received: from xm9614pcu.spreadtrum.com (10.13.2.29) by shmbx05.spreadtrum.com
 (10.29.1.56) with Microsoft SMTP Server (TLS) id 15.0.1497.23; Tue, 18 Jul
 2023 09:15:41 +0800
From:   Wenchao Chen <wenchao.chen@unisoc.com>
To:     <ulf.hansson@linaro.org>, <adrian.hunter@intel.com>
CC:     <linux-mmc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <wenchao.chen666@gmail.com>, <zhenxiong.lai@unisoc.com>,
        <chunyan.zhang@unisoc.com>, <yuelin.tang@unisoc.com>,
        Wenchao Chen <wenchao.chen@unisoc.com>
Subject: [PATCH] mmc: core: Remove FW revision from CID check
Date:   Tue, 18 Jul 2023 09:15:04 +0800
Message-ID: <20230718011504.10947-1-wenchao.chen@unisoc.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.13.2.29]
X-ClientProxiedBy: SHCAS01.spreadtrum.com (10.0.1.201) To
 shmbx05.spreadtrum.com (10.29.1.56)
X-MAIL: SHSQR01.spreadtrum.com 36I1Fh0f083467
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the card is reset, mmc_card_init() will check if this
card is the previous card by comparing the CID.

If the firmware is upgraded, the product version may change,
so we remove the product version from the CID check.

Signed-off-by: Wenchao Chen <wenchao.chen@unisoc.com>
---
 drivers/mmc/core/mmc.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
index 89cd48fcec79..32a73378d5c3 100644
--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -32,6 +32,9 @@
 #define MIN_CACHE_EN_TIMEOUT_MS 1600
 #define CACHE_FLUSH_TIMEOUT_MS 30000 /* 30s */
 
+#define MMC_CID_PRV_MASK GENMASK(23, 16)
+#define MMC_CID_CRC_MASK GENMASK(7, 0)
+
 static const unsigned int tran_exp[] = {
 	10000,		100000,		1000000,	10000000,
 	0,		0,		0,		0
@@ -126,6 +129,19 @@ static int mmc_decode_cid(struct mmc_card *card)
 	return 0;
 }
 
+static int mmc_check_cid(u32 *cid, u32 *raw_cid)
+{
+	/*
+	 * When comparing CID, we need to remove the product
+	 * version (Field PRV, offset 55:48) and CRC. Because
+	 * the product version will change when the firmware
+	 * is upgraded. Also, the new CRC is different.
+	 */
+	return cid[0] != raw_cid[0] || cid[1] != raw_cid[1] ||
+		(cid[2] & ~MMC_CID_PRV_MASK) != (raw_cid[2] & ~MMC_CID_PRV_MASK) ||
+		(cid[3] & ~MMC_CID_CRC_MASK) != (raw_cid[3] & ~MMC_CID_CRC_MASK);
+}
+
 static void mmc_set_erase_size(struct mmc_card *card)
 {
 	if (card->ext_csd.erase_group_def & 1)
@@ -1640,7 +1656,7 @@ static int mmc_init_card(struct mmc_host *host, u32 ocr,
 		goto err;
 
 	if (oldcard) {
-		if (memcmp(cid, oldcard->raw_cid, sizeof(cid)) != 0) {
+		if (mmc_check_cid(cid, oldcard->raw_cid)) {
 			pr_debug("%s: Perhaps the card was replaced\n",
 				mmc_hostname(host));
 			err = -ENOENT;
-- 
2.17.1

