Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED4F2798D38
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 20:20:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238650AbjIHSUk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 14:20:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229587AbjIHSTN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 14:19:13 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E355D1FFD;
        Fri,  8 Sep 2023 11:18:39 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CCB1C3277B;
        Fri,  8 Sep 2023 18:17:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694197022;
        bh=MaYCL40TNC+JgOFwtRYiX20EhwwqpGGhLX6YIcj6Fcc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=H83y1caxxrGl9GNcUV9B852NgCLqjmx6WFJXLqS1PYYNJIAp0Kbg+Ot4l03ZhXkjz
         mLPOqN0AksRlxy6ERMMwSOi1VmeCc4pKP7s+8GF0jUqOkGzoWVtrnm0PYSCRjuMRgr
         qJyJqZz4+euLr8SsrH/8xA4WcW3h4C2zy3amqSBuzJqwZXj/QXGEhIvi6IVkUNmhYf
         0RnGhZbLj9dFtGY9Jbgqluz+vmztWs5tp6yIGC6gvBZJfK3Mu4mk+7J77EGNyW/58I
         XXgg/plugTmXKL3QTgxM00J5sF4C0TRYMa9lEOkXQIW13aPoLG+6mlda4gyS4pHht3
         EhD7adYovuiiQ==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Giulio Benetti <giulio.benetti@benettiengineering.com>,
        Jim Reinhart <jimr@tekvox.com>,
        James Autry <jautry@tekvox.com>,
        Matthew Maron <matthewm@tekvox.com>,
        Haibo Chen <haibo.chen@nxp.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Sasha Levin <sashal@kernel.org>, shawnguo@kernel.org,
        linux-imx@nxp.com, linux-mmc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH AUTOSEL 6.4 26/41] mmc: sdhci-esdhc-imx: improve ESDHC_FLAG_ERR010450
Date:   Fri,  8 Sep 2023 14:15:40 -0400
Message-Id: <20230908181555.3459640-26-sashal@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230908181555.3459640-1-sashal@kernel.org>
References: <20230908181555.3459640-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.4.15
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Giulio Benetti <giulio.benetti@benettiengineering.com>

[ Upstream commit 5ae4b0d8875caa44946e579420c7fd5740d58653 ]

Errata ERR010450 only shows up if voltage is 1.8V, but if the device is
supplied by 3v3 the errata can be ignored. So let's check for if quirk
SDHCI_QUIRK2_NO_1_8_V is defined or not before limiting the frequency.

Cc: Jim Reinhart <jimr@tekvox.com>
Cc: James Autry <jautry@tekvox.com>
Cc: Matthew Maron <matthewm@tekvox.com>
Signed-off-by: Giulio Benetti <giulio.benetti@benettiengineering.com>
Acked-by: Haibo Chen <haibo.chen@nxp.com>
Acked-by: Adrian Hunter <adrian.hunter@intel.com>
Link: https://lore.kernel.org/r/20230811214853.8623-1-giulio.benetti@benettiengineering.com
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/mmc/host/sdhci-esdhc-imx.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
index eebf94604a7fd..cddecc1e1ac2f 100644
--- a/drivers/mmc/host/sdhci-esdhc-imx.c
+++ b/drivers/mmc/host/sdhci-esdhc-imx.c
@@ -171,8 +171,8 @@
 #define ESDHC_FLAG_HS400		BIT(9)
 /*
  * The IP has errata ERR010450
- * uSDHC: Due to the I/O timing limit, for SDR mode, SD card clock can't
- * exceed 150MHz, for DDR mode, SD card clock can't exceed 45MHz.
+ * uSDHC: At 1.8V due to the I/O timing limit, for SDR mode, SD card
+ * clock can't exceed 150MHz, for DDR mode, SD card clock can't exceed 45MHz.
  */
 #define ESDHC_FLAG_ERR010450		BIT(10)
 /* The IP supports HS400ES mode */
@@ -961,7 +961,8 @@ static inline void esdhc_pltfm_set_clock(struct sdhci_host *host,
 		| ESDHC_CLOCK_MASK);
 	sdhci_writel(host, temp, ESDHC_SYSTEM_CONTROL);
 
-	if (imx_data->socdata->flags & ESDHC_FLAG_ERR010450) {
+	if ((imx_data->socdata->flags & ESDHC_FLAG_ERR010450) &&
+	    (!(host->quirks2 & SDHCI_QUIRK2_NO_1_8_V))) {
 		unsigned int max_clock;
 
 		max_clock = imx_data->is_ddr ? 45000000 : 150000000;
-- 
2.40.1

