Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12FFE7A6B6A
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 21:20:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232782AbjISTUP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 15:20:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232400AbjISTUJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 15:20:09 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFBBDEC
        for <linux-kernel@vger.kernel.org>; Tue, 19 Sep 2023 12:20:03 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id af79cd13be357-773ce896ae9so164421085a.1
        for <linux-kernel@vger.kernel.org>; Tue, 19 Sep 2023 12:20:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=hefring-com.20230601.gappssmtp.com; s=20230601; t=1695151203; x=1695756003; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fCY81i+nseXrrFOhCCMbEZ9jSIB5L2BqWxrjnhtX0k0=;
        b=krSms9Rbt4TOhSjIrOpHHLtRzESDIL2wzQoBcldrnzjzX0TeSFxvrlwMkIPpOBy27R
         Lmj64y8V/Z+0k4b4a2Da9RM3fHZZbhZWWcBSrxfzKgtAPtXT5d8M6FLwo3FfCs7/lBas
         ud9ZVffJb0PiueIDvAOkKJvCF4O1LPb2X65P9dkTE2vPouRrl15AkfaBXNonUIHjjluN
         iJzPGnqyYoaNDceawytqq/FT24jfeMnDDcRlupmVtwgTaHSBxokBoRvkTmLXhy9ZYVil
         RwdQW5Yqe1t4VpwAK/rna78HmmkUnt1J7aRjEu2FFDf5tIsZJ9PnHrdgyxRrURtjyO5d
         svZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695151203; x=1695756003;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fCY81i+nseXrrFOhCCMbEZ9jSIB5L2BqWxrjnhtX0k0=;
        b=eQ2HmLReuMFh6N1rvt3etiRzGfG8dUy24EeaGDtPPxGjMYpeWHISG01Ig2ZIBepUhD
         yB1ead6ZCmIhCYZmrLkmfEA1ktl4SxhZYOd1sklF3INRZNBB+qJp9A+SlWJpzF2ko9Qe
         2QWZl6R9h5VmB0JVJMN8KJcFwNgM5P5nnI9vibhPL4SH3GgpGwUSGuY/eqYFuYc/jOAI
         X1QE5NePaZ0UlnNFS6fS49AhxHpJ49Db6spGZCMgVTJ6cJ1pGEHIRwWbhwgaqtZTlaXF
         YdTezbPl7onY3QLRt7fujywCjCsNMyAfyEXRkHB+tKju/zerPW/rmwTVQakagLUOSgbW
         CRag==
X-Gm-Message-State: AOJu0YwO07o2/y5I99z8ltWHQ+k7hzuHlIpFE8kLWBfQA2n7JWEgYLwz
        U3eBfog1jS++URbf0NubFxmtLg==
X-Google-Smtp-Source: AGHT+IEiK0fjP9NmWWu/r8rCHgd3P7ehoSIOSkTPV4Wj0AIazIHRILRyy1BeOefIMr+wNBb2I6i4ow==
X-Received: by 2002:a05:620a:2ac4:b0:772:6384:e749 with SMTP id bn4-20020a05620a2ac400b007726384e749mr619554qkb.20.1695151202974;
        Tue, 19 Sep 2023 12:20:02 -0700 (PDT)
Received: from dell-precision-5540.lan ([2601:18c:8002:3d40:df77:9915:c17e:79])
        by smtp.gmail.com with ESMTPSA id x12-20020ae9f80c000000b0076c60b95b87sm4179704qkh.96.2023.09.19.12.20.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Sep 2023 12:20:02 -0700 (PDT)
From:   Ben Wolsieffer <ben.wolsieffer@hefring.com>
To:     linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org
Cc:     Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Christophe Roullier <christophe.roullier@st.com>,
        Ben Wolsieffer <ben.wolsieffer@hefring.com>
Subject: [PATCH 2/2] net: stmmac: dwmac-stm32: refactor clock config
Date:   Tue, 19 Sep 2023 12:45:36 -0400
Message-ID: <20230919164535.128125-4-ben.wolsieffer@hefring.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230919164535.128125-2-ben.wolsieffer@hefring.com>
References: <20230919164535.128125-2-ben.wolsieffer@hefring.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, clock configuration is spread throughout the driver and
partially duplicated for the STM32MP1 and STM32 MCU variants. This makes
it difficult to keep track of which clocks need to be enabled or disabled
in various scenarios.

This patch adds symmetric stm32_dwmac_clk_enable/disable() functions
that handle all clock configuration, including quirks required while
suspending or resuming. syscfg_clk and clk_eth_ck are not present on
STM32 MCUs, but it is fine to try to configure them anyway since NULL
clocks are ignored.

Signed-off-by: Ben Wolsieffer <ben.wolsieffer@hefring.com>
---
 .../net/ethernet/stmicro/stmmac/dwmac-stm32.c | 113 +++++++-----------
 1 file changed, 45 insertions(+), 68 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-stm32.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-stm32.c
index a0e276783e65..e53ca4111cbe 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-stm32.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-stm32.c
@@ -98,7 +98,6 @@ struct stm32_dwmac {
 
 struct stm32_ops {
 	int (*set_mode)(struct plat_stmmacenet_data *plat_dat);
-	int (*clk_prepare)(struct stm32_dwmac *dwmac, bool prepare);
 	int (*suspend)(struct stm32_dwmac *dwmac);
 	void (*resume)(struct stm32_dwmac *dwmac);
 	int (*parse_data)(struct stm32_dwmac *dwmac,
@@ -107,62 +106,55 @@ struct stm32_ops {
 	bool clk_rx_enable_in_suspend;
 };
 
-static int stm32_dwmac_init(struct plat_stmmacenet_data *plat_dat)
+static int stm32_dwmac_clk_enable(struct stm32_dwmac *dwmac, bool resume)
 {
-	struct stm32_dwmac *dwmac = plat_dat->bsp_priv;
 	int ret;
 
-	if (dwmac->ops->set_mode) {
-		ret = dwmac->ops->set_mode(plat_dat);
-		if (ret)
-			return ret;
-	}
-
 	ret = clk_prepare_enable(dwmac->clk_tx);
 	if (ret)
-		return ret;
+		goto err_clk_tx;
 
-	if (!dwmac->ops->clk_rx_enable_in_suspend ||
-	    !dwmac->dev->power.is_suspended) {
+	if (!dwmac->ops->clk_rx_enable_in_suspend || !resume) {
 		ret = clk_prepare_enable(dwmac->clk_rx);
-		if (ret) {
-			clk_disable_unprepare(dwmac->clk_tx);
-			return ret;
-		}
+		if (ret)
+			goto err_clk_rx;
 	}
 
-	if (dwmac->ops->clk_prepare) {
-		ret = dwmac->ops->clk_prepare(dwmac, true);
-		if (ret) {
-			clk_disable_unprepare(dwmac->clk_rx);
-			clk_disable_unprepare(dwmac->clk_tx);
-		}
+	ret = clk_prepare_enable(dwmac->syscfg_clk);
+	if (ret)
+		goto err_syscfg_clk;
+
+	if (dwmac->enable_eth_ck) {
+		ret = clk_prepare_enable(dwmac->clk_eth_ck);
+		if (ret)
+			goto err_clk_eth_ck;
 	}
 
 	return ret;
+
+err_clk_eth_ck:
+	clk_disable_unprepare(dwmac->syscfg_clk);
+err_syscfg_clk:
+	if (!dwmac->ops->clk_rx_enable_in_suspend || !resume)
+		clk_disable_unprepare(dwmac->clk_rx);
+err_clk_rx:
+	clk_disable_unprepare(dwmac->clk_tx);
+err_clk_tx:
+	return ret;
 }
 
-static int stm32mp1_clk_prepare(struct stm32_dwmac *dwmac, bool prepare)
+static int stm32_dwmac_init(struct plat_stmmacenet_data *plat_dat, bool resume)
 {
-	int ret = 0;
+	struct stm32_dwmac *dwmac = plat_dat->bsp_priv;
+	int ret;
 
-	if (prepare) {
-		ret = clk_prepare_enable(dwmac->syscfg_clk);
+	if (dwmac->ops->set_mode) {
+		ret = dwmac->ops->set_mode(plat_dat);
 		if (ret)
 			return ret;
-		if (dwmac->enable_eth_ck) {
-			ret = clk_prepare_enable(dwmac->clk_eth_ck);
-			if (ret) {
-				clk_disable_unprepare(dwmac->syscfg_clk);
-				return ret;
-			}
-		}
-	} else {
-		clk_disable_unprepare(dwmac->syscfg_clk);
-		if (dwmac->enable_eth_ck)
-			clk_disable_unprepare(dwmac->clk_eth_ck);
 	}
-	return ret;
+
+	return stm32_dwmac_clk_enable(dwmac, resume);
 }
 
 static int stm32mp1_set_mode(struct plat_stmmacenet_data *plat_dat)
@@ -252,13 +244,15 @@ static int stm32mcu_set_mode(struct plat_stmmacenet_data *plat_dat)
 				 dwmac->ops->syscfg_eth_mask, val << 23);
 }
 
-static void stm32_dwmac_clk_disable(struct stm32_dwmac *dwmac)
+static void stm32_dwmac_clk_disable(struct stm32_dwmac *dwmac, bool suspend)
 {
 	clk_disable_unprepare(dwmac->clk_tx);
-	clk_disable_unprepare(dwmac->clk_rx);
+	if (!dwmac->ops->clk_rx_enable_in_suspend || !suspend)
+		clk_disable_unprepare(dwmac->clk_rx);
 
-	if (dwmac->ops->clk_prepare)
-		dwmac->ops->clk_prepare(dwmac, false);
+	clk_disable_unprepare(dwmac->syscfg_clk);
+	if (dwmac->enable_eth_ck)
+		clk_disable_unprepare(dwmac->clk_eth_ck);
 }
 
 static int stm32_dwmac_parse_data(struct stm32_dwmac *dwmac,
@@ -400,7 +394,7 @@ static int stm32_dwmac_probe(struct platform_device *pdev)
 
 	plat_dat->bsp_priv = dwmac;
 
-	ret = stm32_dwmac_init(plat_dat);
+	ret = stm32_dwmac_init(plat_dat, false);
 	if (ret)
 		goto err_remove_config_dt;
 
@@ -411,7 +405,7 @@ static int stm32_dwmac_probe(struct platform_device *pdev)
 	return 0;
 
 err_clk_disable:
-	stm32_dwmac_clk_disable(dwmac);
+	stm32_dwmac_clk_disable(dwmac, false);
 err_remove_config_dt:
 	stmmac_remove_config_dt(pdev, plat_dat);
 
@@ -426,7 +420,7 @@ static void stm32_dwmac_remove(struct platform_device *pdev)
 
 	stmmac_dvr_remove(&pdev->dev);
 
-	stm32_dwmac_clk_disable(priv->plat->bsp_priv);
+	stm32_dwmac_clk_disable(dwmac, false);
 
 	if (dwmac->irq_pwr_wakeup >= 0) {
 		dev_pm_clear_wake_irq(&pdev->dev);
@@ -436,18 +430,7 @@ static void stm32_dwmac_remove(struct platform_device *pdev)
 
 static int stm32mp1_suspend(struct stm32_dwmac *dwmac)
 {
-	int ret = 0;
-
-	ret = clk_prepare_enable(dwmac->clk_ethstp);
-	if (ret)
-		return ret;
-
-	clk_disable_unprepare(dwmac->clk_tx);
-	clk_disable_unprepare(dwmac->syscfg_clk);
-	if (dwmac->enable_eth_ck)
-		clk_disable_unprepare(dwmac->clk_eth_ck);
-
-	return ret;
+	return clk_prepare_enable(dwmac->clk_ethstp);
 }
 
 static void stm32mp1_resume(struct stm32_dwmac *dwmac)
@@ -455,14 +438,6 @@ static void stm32mp1_resume(struct stm32_dwmac *dwmac)
 	clk_disable_unprepare(dwmac->clk_ethstp);
 }
 
-static int stm32mcu_suspend(struct stm32_dwmac *dwmac)
-{
-	clk_disable_unprepare(dwmac->clk_tx);
-	clk_disable_unprepare(dwmac->clk_rx);
-
-	return 0;
-}
-
 #ifdef CONFIG_PM_SLEEP
 static int stm32_dwmac_suspend(struct device *dev)
 {
@@ -473,6 +448,10 @@ static int stm32_dwmac_suspend(struct device *dev)
 	int ret;
 
 	ret = stmmac_suspend(dev);
+	if (ret)
+		return ret;
+
+	stm32_dwmac_clk_disable(dwmac, true);
 
 	if (dwmac->ops->suspend)
 		ret = dwmac->ops->suspend(dwmac);
@@ -490,7 +469,7 @@ static int stm32_dwmac_resume(struct device *dev)
 	if (dwmac->ops->resume)
 		dwmac->ops->resume(dwmac);
 
-	ret = stm32_dwmac_init(priv->plat);
+	ret = stm32_dwmac_init(priv->plat, true);
 	if (ret)
 		return ret;
 
@@ -505,13 +484,11 @@ static SIMPLE_DEV_PM_OPS(stm32_dwmac_pm_ops,
 
 static struct stm32_ops stm32mcu_dwmac_data = {
 	.set_mode = stm32mcu_set_mode,
-	.suspend = stm32mcu_suspend,
 	.syscfg_eth_mask = SYSCFG_MCU_ETH_MASK
 };
 
 static struct stm32_ops stm32mp1_dwmac_data = {
 	.set_mode = stm32mp1_set_mode,
-	.clk_prepare = stm32mp1_clk_prepare,
 	.suspend = stm32mp1_suspend,
 	.resume = stm32mp1_resume,
 	.parse_data = stm32mp1_parse_data,
-- 
2.42.0

