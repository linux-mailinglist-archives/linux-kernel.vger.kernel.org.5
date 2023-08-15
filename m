Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFD9077C53C
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 03:42:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233886AbjHOBmO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 21:42:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233915AbjHOBlw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 21:41:52 -0400
Received: from SHSQR01.spreadtrum.com (unknown [222.66.158.135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B67CD1986;
        Mon, 14 Aug 2023 18:41:48 -0700 (PDT)
Received: from dlp.unisoc.com ([10.29.3.86])
        by SHSQR01.spreadtrum.com with ESMTP id 37F1fS8M005127;
        Tue, 15 Aug 2023 09:41:28 +0800 (+08)
        (envelope-from Wenchao.Chen@unisoc.com)
Received: from SHDLP.spreadtrum.com (shmbx05.spreadtrum.com [10.29.1.56])
        by dlp.unisoc.com (SkyGuard) with ESMTPS id 4RPv7r2T2Mz2P8CXW;
        Tue, 15 Aug 2023 09:39:20 +0800 (CST)
Received: from xm9614pcu.spreadtrum.com (10.13.2.29) by shmbx05.spreadtrum.com
 (10.29.1.56) with Microsoft SMTP Server (TLS) id 15.0.1497.23; Tue, 15 Aug
 2023 09:41:25 +0800
From:   Wenchao Chen <wenchao.chen@unisoc.com>
To:     <ulf.hansson@linaro.org>, <adrian.hunter@intel.com>
CC:     <linux-mmc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <wenchao.chen666@gmail.com>, <zhenxiong.lai@unisoc.com>,
        <chunyan.zhang@unisoc.com>, <yuelin.tang@unisoc.com>,
        Wenchao Chen <wenchao.chen@unisoc.com>
Subject: [PATCH V2 1/2] mmc: core: Add host specific tuning support for SD HS mode
Date:   Tue, 15 Aug 2023 09:40:56 +0800
Message-ID: <20230815014057.13589-2-wenchao.chen@unisoc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230815014057.13589-1-wenchao.chen@unisoc.com>
References: <20230815014057.13589-1-wenchao.chen@unisoc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.13.2.29]
X-ClientProxiedBy: SHCAS03.spreadtrum.com (10.0.1.207) To
 shmbx05.spreadtrum.com (10.29.1.56)
X-MAIL: SHSQR01.spreadtrum.com 37F1fS8M005127
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Added .prepare_hs_tuning and .execute_hs_tuning host callbacks to
support host-specific tuning for SD high speed mode.

Signed-off-by: Wenchao Chen <wenchao.chen@unisoc.com>
---
 drivers/mmc/core/sd.c    | 12 ++++++++++++
 include/linux/mmc/host.h |  6 ++++++
 2 files changed, 18 insertions(+)

diff --git a/drivers/mmc/core/sd.c b/drivers/mmc/core/sd.c
index 246ce027ae0a..ac2da8f2fbce 100644
--- a/drivers/mmc/core/sd.c
+++ b/drivers/mmc/core/sd.c
@@ -1518,6 +1518,12 @@ static int mmc_sd_init_card(struct mmc_host *host, u32 ocr,
 		 */
 		mmc_set_clock(host, mmc_sd_get_max_clock(card));
 
+		if (host->ops->prepare_hs_tuning) {
+			err = host->ops->prepare_hs_tuning(host, card);
+			if (err)
+				goto free_card;
+		}
+
 		/*
 		 * Switch to wider bus (if supported).
 		 */
@@ -1529,6 +1535,12 @@ static int mmc_sd_init_card(struct mmc_host *host, u32 ocr,
 
 			mmc_set_bus_width(host, MMC_BUS_WIDTH_4);
 		}
+
+		if (host->ops->execute_hs_tuning) {
+			err = host->ops->execute_hs_tuning(host, card);
+			if (err)
+				goto free_card;
+		}
 	}
 cont:
 	if (!oldcard) {
diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
index 461d1543893b..13cf894b9e3c 100644
--- a/include/linux/mmc/host.h
+++ b/include/linux/mmc/host.h
@@ -184,6 +184,12 @@ struct mmc_host_ops {
 	/* Execute HS400 tuning depending host driver */
 	int	(*execute_hs400_tuning)(struct mmc_host *host, struct mmc_card *card);
 
+	/* Prepare HS tuning depending host driver */
+	int	(*prepare_hs_tuning)(struct mmc_host *host, struct mmc_card *card);
+
+	/* Execute HS tuning depending host driver */
+	int	(*execute_hs_tuning)(struct mmc_host *host, struct mmc_card *card);
+
 	/* Prepare switch to DDR during the HS400 init sequence */
 	int	(*hs400_prepare_ddr)(struct mmc_host *host);
 
-- 
2.17.1

