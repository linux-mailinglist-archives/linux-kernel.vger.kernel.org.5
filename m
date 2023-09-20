Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06DC37A8D5B
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 21:58:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230355AbjITT6s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 15:58:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230235AbjITT63 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 15:58:29 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 046D2F3;
        Wed, 20 Sep 2023 12:58:21 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id 38308e7fff4ca-2c00b37ad84so3324011fa.0;
        Wed, 20 Sep 2023 12:58:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695239899; x=1695844699; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YHXZQwjThe58ElR9KDC4d5zhuY4eW8lfmL1mNO1Tyx8=;
        b=HHZ1eSiAk5fhQAI1n+JCyJk9Pyt0E8PYWNzhUI8fKpikJB4WdCutucXg3HAC44rPhO
         SdvWPWIa4x48W3P7/jDNHLuS8LChyz46pqK/45qQsLd8g1kF6atVCwHtmuO6g/ah9Xfk
         mO9BvyvBUeovDAJCE6fTvuGArZLRSEL0qJMypxKBiz24CEEn0rAh7QUrG/qTPaVe+J7V
         oDymlRMbpZwoutDBwyXwR0APsPRoeR/31gj/9qi4dnfaof9qG3dKggTzWSxo+F1BoL8x
         VyERetBI0594ihR9GzRgosYaFvjBY7+oDCjGMwIGJQj8R7bo4kd1xoB/v/GQEt/efz6i
         OelQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695239899; x=1695844699;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YHXZQwjThe58ElR9KDC4d5zhuY4eW8lfmL1mNO1Tyx8=;
        b=GsXKQtKgrDTdd6FZMlHYfm0/WzQhE9Ufxd+90ThLF4tSnKxgKkn9rB62vm+JZSz6jn
         faXMjkMhFjvf8JzZ0+L92xgY7b35JRjl313qFA93mZz0ZOsPmVdGw8euPR0D6K5U8TF9
         URlxFnSJTlvXzI1ix6ToFdx4yACffpF2s7//Dg0535KCMSk0i+ZXyaePp8HbxZ1S79hZ
         ScWnVVV4I3AT3pMnBQTJz1u82MIqcX6KlVFqCTaJcBP2BvhkmIGrEII4r70Z9WsuEieC
         tmFMSnfM/0jAnrwa8ez3yYYzUODuyWu+H9wTFwLM5Sig4afm0a8q6zhLVvrHsGESpFcn
         ZZoQ==
X-Gm-Message-State: AOJu0YwyJAT1lnwzoLjvzfeyL4sdXXJluaRsuQ5vdWgtM5Ayg95CrRGg
        RiE8MTTKNWX+ajAdDAJ1Gvc=
X-Google-Smtp-Source: AGHT+IG6HdwR7k3s+jPl1G74XWMoiocVOIUGqxfhNxmmMH8KyLTG7kZ7+vlF4uyHUg4LRPaCdOTmaQ==
X-Received: by 2002:a2e:90d5:0:b0:2c0:297d:a678 with SMTP id o21-20020a2e90d5000000b002c0297da678mr3044821ljg.8.1695239899041;
        Wed, 20 Sep 2023 12:58:19 -0700 (PDT)
Received: from localhost ([178.176.81.142])
        by smtp.gmail.com with ESMTPSA id e17-20020a2e8ed1000000b002bb95815f92sm314304ljl.115.2023.09.20.12.58.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Sep 2023 12:58:18 -0700 (PDT)
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Michal Simek <michal.simek@amd.com>,
        Alexander Stein <alexander.stein@ew.tq-group.com>,
        Borislav Petkov <bp@alien8.de>,
        Tony Luck <tony.luck@intel.com>,
        James Morse <james.morse@arm.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Robert Richter <rric@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Serge Semin <fancer.lancer@gmail.com>,
        Punnaiah Choudary Kalluri 
        <punnaiah.choudary.kalluri@xilinx.com>,
        Dinh Nguyen <dinguyen@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 10/13] EDAC/synopsys: Add reference clocks support
Date:   Wed, 20 Sep 2023 22:56:41 +0300
Message-ID: <20230920195720.32047-11-fancer.lancer@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230920195720.32047-1-fancer.lancer@gmail.com>
References: <20230920195720.32047-1-fancer.lancer@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently the driver doesn't support any clock-related resources request
and handling, fairly assuming that all of them are supposed to be enabled
anyway in order for the system to work correctly. It's true for the Core
and AXI Ports reference clocks, but the CSR (APB) and Scrubber clocks
might still be disabled in case if the system firmware doesn't imply any
other software touching the DDR controller internals. Since the DW uMCTL2
DDRC driver does access the controller registers at the very least the
driver needs to make sure the APB clock is enabled.

So add the reference clocks support then. First the driver will request
all the clocks possibly defined for the controller (Core, AXI, APB and
Scrubber). Second the APB clock will be enabled/disabled only since the
Scrubber is currently unsupported by the driver. Since the Core and AXI
clocks feed the critical system parts they left untouched to avoid a risk
to de-stabilize the system memory. Please note the clocks connection IDs
have been chosen in accordance with the DT-bindings.

Signed-off-by: Serge Semin <fancer.lancer@gmail.com>
---
 drivers/edac/synopsys_edac.c | 101 +++++++++++++++++++++++++++++++++--
 1 file changed, 98 insertions(+), 3 deletions(-)

diff --git a/drivers/edac/synopsys_edac.c b/drivers/edac/synopsys_edac.c
index a91b048facb6..ab4c7cc2daf5 100644
--- a/drivers/edac/synopsys_edac.c
+++ b/drivers/edac/synopsys_edac.c
@@ -8,6 +8,7 @@
 
 #include <linux/bitfield.h>
 #include <linux/bits.h>
+#include <linux/clk.h>
 #include <linux/edac.h>
 #include <linux/fs.h>
 #include <linux/log2.h>
@@ -303,6 +304,25 @@ enum snps_ecc_mode {
 	SNPS_ECC_ADVX4X8 = 5,
 };
 
+/**
+ * enum snps_ref_clk - DW uMCTL2 DDR controller clocks.
+ * @SNPS_CSR_CLK:	CSR/APB interface clock.
+ * @SNPS_AXI_CLK:	AXI (AHB) Port reference clock.
+ * @SNPS_CORE_CLK:	DDR controller (including DFI) clock. SDRAM clock
+ *			matches runs with this freq in 1:1 ratio mode and
+ *			with twice of this freq in case of 1:2 ratio mode.
+ * @SNPS_SBR_CLK:	Scrubber port reference clock (synchronous to
+ *			the core clock).
+ * @SNPS_MAX_NCLK:	Total number of clocks.
+ */
+enum snps_ref_clk {
+	SNPS_CSR_CLK,
+	SNPS_AXI_CLK,
+	SNPS_CORE_CLK,
+	SNPS_SBR_CLK,
+	SNPS_MAX_NCLK
+};
+
 /**
  * struct snps_ddrc_info - DDR controller platform parameters.
  * @caps:		DDR controller capabilities.
@@ -410,6 +430,7 @@ struct snps_ecc_error_info {
  * @pdev:		Platform device.
  * @baseaddr:		Base address of the DDR controller.
  * @reglock:		Concurrent CSRs access lock.
+ * @clks:		Controller reference clocks.
  * @message:		Buffer for framing the event specific info.
  */
 struct snps_edac_priv {
@@ -419,6 +440,7 @@ struct snps_edac_priv {
 	struct platform_device *pdev;
 	void __iomem *baseaddr;
 	spinlock_t reglock;
+	struct clk_bulk_data clks[SNPS_MAX_NCLK];
 	char message[SNPS_EDAC_MSG_SIZE];
 };
 
@@ -985,6 +1007,60 @@ static struct snps_edac_priv *snps_create_data(struct platform_device *pdev)
 	return priv;
 }
 
+/**
+ * snps_get_res - Get platform device resources.
+ * @priv:	DDR memory controller private instance data.
+ *
+ * It's supposed to request all the controller resources available for the
+ * particular platform and enable all the required for the driver normal
+ * work. Note only the CSR and Scrubber clocks are supposed to be switched
+ * on/off by the driver.
+ *
+ * Return: negative errno if failed to get the resources, otherwise - zero.
+ */
+static int snps_get_res(struct snps_edac_priv *priv)
+{
+	const char * const ids[] = {
+		[SNPS_CSR_CLK] = "pclk",
+		[SNPS_AXI_CLK] = "aclk",
+		[SNPS_CORE_CLK] = "core",
+		[SNPS_SBR_CLK] = "sbr",
+	};
+	int i, rc;
+
+	for (i = 0; i < SNPS_MAX_NCLK; i++)
+		priv->clks[i].id = ids[i];
+
+	rc = devm_clk_bulk_get_optional(&priv->pdev->dev, SNPS_MAX_NCLK,
+					priv->clks);
+	if (rc) {
+		edac_printk(KERN_INFO, EDAC_MC, "Failed to get ref clocks\n");
+		return rc;
+	}
+
+	/*
+	 * Don't touch the Core and AXI clocks since they are critical for the
+	 * stable system functioning and are supposed to have been enabled
+	 * anyway.
+	 */
+	rc = clk_prepare_enable(priv->clks[SNPS_CSR_CLK].clk);
+	if (rc) {
+		edac_printk(KERN_INFO, EDAC_MC, "Couldn't enable CSR clock\n");
+		return rc;
+	}
+
+	return 0;
+}
+
+/**
+ * snps_put_res - Put platform device resources.
+ * @priv:	DDR memory controller private instance data.
+ */
+static void snps_put_res(struct snps_edac_priv *priv)
+{
+	clk_disable_unprepare(priv->clks[SNPS_CSR_CLK].clk);
+}
+
 /*
  * zynqmp_init_plat - ZynqMP-specific platform initialization.
  * @priv:	DDR memory controller private data.
@@ -1718,9 +1794,17 @@ static int snps_ddrc_info_show(struct seq_file *s, void *data)
 {
 	struct mem_ctl_info *mci = s->private;
 	struct snps_edac_priv *priv = mci->pvt_info;
+	unsigned long rate;
 
 	seq_printf(s, "SDRAM: %s\n", edac_mem_types[priv->info.sdram_mode]);
 
+	rate = clk_get_rate(priv->clks[SNPS_CORE_CLK].clk);
+	if (rate) {
+		rate = rate / HZ_PER_MHZ;
+		seq_printf(s, "Clock: Core %luMHz SDRAM %luMHz\n",
+			   rate, priv->info.freq_ratio * rate);
+	}
+
 	seq_printf(s, "DQ bus: %u/%s\n", (BITS_PER_BYTE << priv->info.dq_width),
 		   priv->info.dq_mode == SNPS_DQ_FULL ? "Full" :
 		   priv->info.dq_mode == SNPS_DQ_HALF ? "Half" :
@@ -2029,15 +2113,21 @@ static int snps_mc_probe(struct platform_device *pdev)
 	if (IS_ERR(priv))
 		return PTR_ERR(priv);
 
-	rc = snps_get_ddrc_info(priv);
+	rc = snps_get_res(priv);
 	if (rc)
 		return rc;
 
+	rc = snps_get_ddrc_info(priv);
+	if (rc)
+		goto put_res;
+
 	snps_get_addr_map(priv);
 
 	mci = snps_mc_create(priv);
-	if (IS_ERR(mci))
-		return PTR_ERR(mci);
+	if (IS_ERR(mci)) {
+		rc = PTR_ERR(mci);
+		goto put_res;
+	}
 
 	rc = snps_setup_irq(mci);
 	if (rc)
@@ -2057,6 +2147,9 @@ static int snps_mc_probe(struct platform_device *pdev)
 free_edac_mc:
 	snps_mc_free(mci);
 
+put_res:
+	snps_put_res(priv);
+
 	return rc;
 }
 
@@ -2077,6 +2170,8 @@ static int snps_mc_remove(struct platform_device *pdev)
 
 	snps_mc_free(mci);
 
+	snps_put_res(priv);
+
 	return 0;
 }
 
-- 
2.41.0

