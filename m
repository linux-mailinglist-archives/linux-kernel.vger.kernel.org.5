Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62B0D788364
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 11:19:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241618AbjHYJSx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 05:18:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238398AbjHYJSW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 05:18:22 -0400
Received: from SHSQR01.spreadtrum.com (mx1.unisoc.com [222.66.158.135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 120F31FC4;
        Fri, 25 Aug 2023 02:18:17 -0700 (PDT)
Received: from dlp.unisoc.com ([10.29.3.86])
        by SHSQR01.spreadtrum.com with ESMTP id 37P9HuWS015637;
        Fri, 25 Aug 2023 17:17:56 +0800 (+08)
        (envelope-from Wenchao.Chen@unisoc.com)
Received: from SHDLP.spreadtrum.com (shmbx05.spreadtrum.com [10.29.1.56])
        by dlp.unisoc.com (SkyGuard) with ESMTPS id 4RXDnX4R92z2QWLd0;
        Fri, 25 Aug 2023 17:15:28 +0800 (CST)
Received: from xm9614pcu.spreadtrum.com (10.13.2.29) by shmbx05.spreadtrum.com
 (10.29.1.56) with Microsoft SMTP Server (TLS) id 15.0.1497.23; Fri, 25 Aug
 2023 17:17:54 +0800
From:   Wenchao Chen <wenchao.chen@unisoc.com>
To:     <ulf.hansson@linaro.org>, <orsonzhai@gmail.com>,
        <baolin.wang@linux.alibaba.com>, <zhang.lyra@gmail.com>
CC:     <linux-mmc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <wenchao.chen666@gmail.com>, <zhenxiong.lai@unisoc.com>,
        <yuelin.tang@unisoc.com>, Wenchao Chen <wenchao.chen@unisoc.com>
Subject: [PATCH V3 1/2] mmc: core: Add host specific tuning support for SD HS mode
Date:   Fri, 25 Aug 2023 17:17:42 +0800
Message-ID: <20230825091743.15613-2-wenchao.chen@unisoc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230825091743.15613-1-wenchao.chen@unisoc.com>
References: <20230825091743.15613-1-wenchao.chen@unisoc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.13.2.29]
X-ClientProxiedBy: SHCAS03.spreadtrum.com (10.0.1.207) To
 shmbx05.spreadtrum.com (10.29.1.56)
X-MAIL: SHSQR01.spreadtrum.com 37P9HuWS015637
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Added .prepare_hs_tuning and .execute_hs_tuning host callbacks to
support host-specific tuning for SD high speed mode. Howerver, these
callbacks are optional, host specific - and that there is nothing
in the SD spec that mentions this.

Signed-off-by: Wenchao Chen <wenchao.chen@unisoc.com>
---
 drivers/mmc/core/sd.c     | 14 ++++++++++++++
 drivers/mmc/core/sd_ops.c |  1 +
 include/linux/mmc/host.h  |  8 ++++++++
 3 files changed, 23 insertions(+)

diff --git a/drivers/mmc/core/sd.c b/drivers/mmc/core/sd.c
index 246ce027ae0a..c3e554344c99 100644
--- a/drivers/mmc/core/sd.c
+++ b/drivers/mmc/core/sd.c
@@ -1518,6 +1518,13 @@ static int mmc_sd_init_card(struct mmc_host *host, u32 ocr,
 		 */
 		mmc_set_clock(host, mmc_sd_get_max_clock(card));
 
+		if (host->ios.timing == MMC_TIMING_SD_HS &&
+			host->ops->prepare_sd_hs_tuning) {
+			err = host->ops->prepare_sd_hs_tuning(host, card);
+			if (err)
+				goto free_card;
+		}
+
 		/*
 		 * Switch to wider bus (if supported).
 		 */
@@ -1529,6 +1536,13 @@ static int mmc_sd_init_card(struct mmc_host *host, u32 ocr,
 
 			mmc_set_bus_width(host, MMC_BUS_WIDTH_4);
 		}
+
+		if (host->ios.timing == MMC_TIMING_SD_HS &&
+			host->ops->execute_sd_hs_tuning) {
+			err = host->ops->execute_sd_hs_tuning(host, card);
+			if (err)
+				goto free_card;
+		}
 	}
 cont:
 	if (!oldcard) {
diff --git a/drivers/mmc/core/sd_ops.c b/drivers/mmc/core/sd_ops.c
index ef8d1dce5af1..a59cd592f06e 100644
--- a/drivers/mmc/core/sd_ops.c
+++ b/drivers/mmc/core/sd_ops.c
@@ -323,6 +323,7 @@ int mmc_sd_switch(struct mmc_card *card, int mode, int group,
 	return mmc_send_adtc_data(card, card->host, SD_SWITCH, cmd_args, resp,
 				  64);
 }
+EXPORT_SYMBOL_GPL(mmc_sd_switch);
 
 int mmc_app_sd_status(struct mmc_card *card, void *ssr)
 {
diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
index 461d1543893b..62a6847a3b6f 100644
--- a/include/linux/mmc/host.h
+++ b/include/linux/mmc/host.h
@@ -184,6 +184,12 @@ struct mmc_host_ops {
 	/* Execute HS400 tuning depending host driver */
 	int	(*execute_hs400_tuning)(struct mmc_host *host, struct mmc_card *card);
 
+	/* Optional callback to prepare for SD high-speed tuning */
+	int	(*prepare_sd_hs_tuning)(struct mmc_host *host, struct mmc_card *card);
+
+	/* Optional callback to execute SD high-speed tuning */
+	int	(*execute_sd_hs_tuning)(struct mmc_host *host, struct mmc_card *card);
+
 	/* Prepare switch to DDR during the HS400 init sequence */
 	int	(*hs400_prepare_ddr)(struct mmc_host *host);
 
@@ -665,6 +671,8 @@ static inline void mmc_debugfs_err_stats_inc(struct mmc_host *host,
 	host->err_stats[stat] += 1;
 }
 
+int mmc_sd_switch(struct mmc_card *card, int mode, int group, u8 value, u8 *resp);
+int mmc_send_status(struct mmc_card *card, u32 *status);
 int mmc_send_tuning(struct mmc_host *host, u32 opcode, int *cmd_error);
 int mmc_send_abort_tuning(struct mmc_host *host, u32 opcode);
 int mmc_get_ext_csd(struct mmc_card *card, u8 **new_ext_csd);
-- 
2.17.1

