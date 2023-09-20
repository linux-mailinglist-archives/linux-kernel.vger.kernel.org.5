Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CF9F7A8C70
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 21:12:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230149AbjITTM6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 15:12:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229975AbjITTMi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 15:12:38 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9656ECC3;
        Wed, 20 Sep 2023 12:12:15 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id 2adb3069b0e04-502e6d632b6so357887e87.0;
        Wed, 20 Sep 2023 12:12:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695237133; x=1695841933; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PfDjZiE6WtfVCxrr3EXQZanb/Ejq/36l5KB3TsJFTIM=;
        b=HvQRQYi/wB8Q3kXV3dDb3PT813cQNHpA2ltHlNkxSSxL1QemBs+xX+XP8HPCXer4i/
         P6VeKSPBVccDTKkabXDO1LmbENDGCHXWOiiN6aLorC84z88jt60XmBPh6qMkpYfqYoAJ
         ec6sYPR4ztPD+jvtZRstHitujrSut0y074o76Rp5xnWY/XpArhMV11/iGkxbvI3S2n/l
         FG65CU/86N4Jqa1aEWB4t97GyK7fCJI4w60YBNALYbQHRgTHafwHHyL833jr+6ErsaCE
         Z74BdzeprTWAu2qvhde4ZRTudvbgqB0E7dQduwsnjCCL5JemR2rU03lV2Ck9U02rLGJk
         yxyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695237133; x=1695841933;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PfDjZiE6WtfVCxrr3EXQZanb/Ejq/36l5KB3TsJFTIM=;
        b=mOVfWUQ4FnxTUUKBGLNlw8z6koiVdoVoNjB53qa0h7QJo34NWk+DFQb/HKwf3sn1BL
         uD63SK67varfz2LmKUHXVeUdf9HMpm7XgbRwVTqUndhNylQ127st4RL2f3hTwX1boHWs
         lQbAXYJcQ6zScuPCQ6QBIDao3CpUASt1JSOsyTCFuN/bE3XlGu8MlChDKbB/df7ZqdzG
         vnoDoUB4fn/u41WYr5jjYyBqe069hrYJXq9ERg459dJewXbCrQPbn+v4DLP4mMlJqj32
         d79BnJAjQbhT/hqlfjoIqvh7sZtaAeMaHnw80if/dXiUUGxJPYMrDRe8QrO9l1bLBrs2
         2WWg==
X-Gm-Message-State: AOJu0YwIlrmo/zqfEus2c5ZLABvubF+g7+bHLglW5lcECdPi1+rkAjcR
        7DdHUR7Cr9UXBrkJGxrjTM8=
X-Google-Smtp-Source: AGHT+IFc77pdxqYaa3//QG1cW7NlwjcqhnHNVu8spHDBF+/4ohNLl6Xv+wwmPG65dAU5vudlDAwKTw==
X-Received: by 2002:a05:6512:3702:b0:503:3644:4a99 with SMTP id z2-20020a056512370200b0050336444a99mr2961627lfr.51.1695237133277;
        Wed, 20 Sep 2023 12:12:13 -0700 (PDT)
Received: from localhost ([178.176.81.142])
        by smtp.gmail.com with ESMTPSA id f9-20020ac251a9000000b00501c1794883sm2812658lfk.251.2023.09.20.12.12.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Sep 2023 12:12:12 -0700 (PDT)
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Michal Simek <michal.simek@amd.com>,
        Alexander Stein <alexander.stein@ew.tq-group.com>,
        Borislav Petkov <bp@alien8.de>,
        Tony Luck <tony.luck@intel.com>,
        James Morse <james.morse@arm.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Robert Richter <rric@kernel.org>
Cc:     Serge Semin <fancer.lancer@gmail.com>,
        Punnaiah Choudary Kalluri 
        <punnaiah.choudary.kalluri@xilinx.com>,
        Dinh Nguyen <dinguyen@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-arm-kernel@lists.infradead.org, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 17/20] EDAC/synopsys: Drop unused platform-specific setup API
Date:   Wed, 20 Sep 2023 22:10:41 +0300
Message-ID: <20230920191059.28395-18-fancer.lancer@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230920191059.28395-1-fancer.lancer@gmail.com>
References: <20230920191059.28395-1-fancer.lancer@gmail.com>
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

The driver now works with the Synopsys DW uMCTL2 DDRC IP-core-based
devices only (Xilinx Zynq A05 DDRC support has been moved to the separate
driver). All the currently available IP-core revisions have got almost the
same ECC and main part of the DDR-config CSRs map. Thus there is no point
in supporting the no longer used internal abstraction layer like the
callbacks responsible for getting the ECC errors info, memory and device
types, ECC state. All of that data can be retrieved in the same way from
all the Synopys DW uMCTL2 DDR controller versions. Similarly there is no
longer need in the DDR_ECC_INTR_SUPPORT and DDR_ECC_DATA_POISON_SUPPORT
quirk flags since DW uMCTL2 always supports IRQs and data poisoning (as
long as the ECC is supported). Drop that infrastructure for good then.

While at it move the module device table to being defined at the bottom of
the file, above the platform driver descriptor definition.

Signed-off-by: Serge Semin <fancer.lancer@gmail.com>

---

Changelog v2:
- Drop the no longer used "priv" pointer from the mc_init() function.
  (@tbot)
---
 drivers/edac/synopsys_edac.c | 192 ++++++++++-------------------------
 1 file changed, 51 insertions(+), 141 deletions(-)

diff --git a/drivers/edac/synopsys_edac.c b/drivers/edac/synopsys_edac.c
index 783a4df7eeac..655a32792883 100644
--- a/drivers/edac/synopsys_edac.c
+++ b/drivers/edac/synopsys_edac.c
@@ -31,9 +31,7 @@
 #define SYNPS_EDAC_MOD_VER		"1"
 
 /* DDR ECC Quirks */
-#define DDR_ECC_INTR_SUPPORT		BIT(0)
-#define DDR_ECC_DATA_POISON_SUPPORT	BIT(1)
-#define SYNPS_ZYNQMP_IRQ_REGS		BIT(2)
+#define SYNPS_ZYNQMP_IRQ_REGS		BIT(0)
 
 /* Synopsys DDR memory controller registers that are relevant to ECC */
 
@@ -281,28 +279,20 @@ struct synps_edac_priv {
 };
 
 /**
- * struct synps_platform_data -  synps platform data structure.
- * @get_error_info:	Get EDAC error info.
- * @get_mtype:		Get mtype.
- * @get_dtype:		Get dtype.
- * @get_ecc_state:	Get ECC state.
- * @quirks:		To differentiate IPs.
+ * struct synps_platform_data - Synopsys uMCTL2 DDRC platform data.
+ * @quirks:	IP-core specific quirks.
  */
 struct synps_platform_data {
-	int (*get_error_info)(struct synps_edac_priv *priv);
-	enum mem_type (*get_mtype)(const void __iomem *base);
-	enum dev_type (*get_dtype)(const void __iomem *base);
-	bool (*get_ecc_state)(void __iomem *base);
-	int quirks;
+	u32 quirks;
 };
 
 /**
- * zynqmp_get_error_info - Get the current ECC error info.
+ * synps_get_error_info - Get the current ECC error info.
  * @priv:	DDR memory controller private instance data.
  *
  * Return: one if there is no error otherwise returns zero.
  */
-static int zynqmp_get_error_info(struct synps_edac_priv *priv)
+static int synps_get_error_info(struct synps_edac_priv *priv)
 {
 	struct synps_ecc_status *p;
 	u32 regval, clearval;
@@ -376,17 +366,11 @@ static void handle_error(struct mem_ctl_info *mci, struct synps_ecc_status *p)
 
 	if (p->ce_cnt) {
 		pinf = &p->ceinfo;
-		if (priv->p_data->quirks & DDR_ECC_INTR_SUPPORT) {
-			snprintf(priv->message, SYNPS_EDAC_MSG_SIZE,
-				 "Row %d Col %d Bank %d Bank Group %d Bit %d Data 0x%08x",
-				 pinf->row, pinf->col, pinf->bank, pinf->bankgrp,
-				 pinf->bitpos, pinf->data);
-		} else {
-			snprintf(priv->message, SYNPS_EDAC_MSG_SIZE,
-				 "Row %d Bank %d Col %d Bit: %d Data: 0x%08x",
-				 pinf->row, pinf->bank, pinf->col,
-				 pinf->bitpos, pinf->data);
-		}
+
+		snprintf(priv->message, SYNPS_EDAC_MSG_SIZE,
+			 "Row %d Col %d Bank %d Bank Group %d Bit %d Data 0x%08x",
+			 pinf->row, pinf->col, pinf->bank, pinf->bankgrp,
+			 pinf->bitpos, pinf->data);
 
 		edac_mc_handle_error(HW_EVENT_ERR_CORRECTED, mci,
 				     p->ce_cnt, 0, 0, 0, 0, 0, -1,
@@ -395,15 +379,10 @@ static void handle_error(struct mem_ctl_info *mci, struct synps_ecc_status *p)
 
 	if (p->ue_cnt) {
 		pinf = &p->ueinfo;
-		if (priv->p_data->quirks & DDR_ECC_INTR_SUPPORT) {
-			snprintf(priv->message, SYNPS_EDAC_MSG_SIZE,
-				 "Row %d Col %d Bank %d Bank Group %d",
-				 pinf->row, pinf->col, pinf->bank, pinf->bankgrp);
-		} else {
-			snprintf(priv->message, SYNPS_EDAC_MSG_SIZE,
-				 "Row %d Bank %d Col %d",
-				 pinf->row, pinf->bank, pinf->col);
-		}
+
+		snprintf(priv->message, SYNPS_EDAC_MSG_SIZE,
+			 "Row %d Col %d Bank %d Bank Group %d",
+			 pinf->row, pinf->col, pinf->bank, pinf->bankgrp);
 
 		edac_mc_handle_error(HW_EVENT_ERR_UNCORRECTED, mci,
 				     p->ue_cnt, 0, 0, 0, 0, 0, -1,
@@ -465,13 +444,11 @@ static void disable_intr(struct synps_edac_priv *priv)
  */
 static irqreturn_t intr_handler(int irq, void *dev_id)
 {
-	const struct synps_platform_data *p_data;
 	struct mem_ctl_info *mci = dev_id;
 	struct synps_edac_priv *priv;
 	int status, regval;
 
 	priv = mci->pvt_info;
-	p_data = priv->p_data;
 
 	if (priv->p_data->quirks & SYNPS_ZYNQMP_IRQ_REGS) {
 		regval = readl(priv->baseaddr + DDR_QOS_IRQ_STAT_OFST);
@@ -480,7 +457,7 @@ static irqreturn_t intr_handler(int irq, void *dev_id)
 			return IRQ_NONE;
 	}
 
-	status = p_data->get_error_info(priv);
+	status = synps_get_error_info(priv);
 	if (status)
 		return IRQ_NONE;
 
@@ -493,29 +470,7 @@ static irqreturn_t intr_handler(int irq, void *dev_id)
 }
 
 /**
- * check_errors - Check controller for ECC errors.
- * @mci:	EDAC memory controller instance.
- *
- * Check and post ECC errors. Called by the polling thread.
- */
-static void check_errors(struct mem_ctl_info *mci)
-{
-	const struct synps_platform_data *p_data;
-	struct synps_edac_priv *priv;
-	int status;
-
-	priv = mci->pvt_info;
-	p_data = priv->p_data;
-
-	status = p_data->get_error_info(priv);
-	if (status)
-		return;
-
-	handle_error(mci, &priv->stat);
-}
-
-/**
- * zynqmp_get_dtype - Return the controller memory width.
+ * synps_get_dtype - Return the controller memory width.
  * @base:	DDR memory controller base address.
  *
  * Get the EDAC device type width appropriate for the current controller
@@ -523,7 +478,7 @@ static void check_errors(struct mem_ctl_info *mci)
  *
  * Return: a device type width enumeration.
  */
-static enum dev_type zynqmp_get_dtype(const void __iomem *base)
+static enum dev_type synps_get_dtype(const void __iomem *base)
 {
 	u32 regval;
 
@@ -547,14 +502,14 @@ static enum dev_type zynqmp_get_dtype(const void __iomem *base)
 }
 
 /**
- * zynqmp_get_ecc_state - Return the controller ECC enable/disable status.
+ * synps_get_ecc_state - Return the controller ECC enable/disable status.
  * @base:	DDR memory controller base address.
  *
  * Get the ECC enable/disable status for the controller.
  *
  * Return: a ECC status boolean i.e true/false - enabled/disabled.
  */
-static bool zynqmp_get_ecc_state(void __iomem *base)
+static bool synps_get_ecc_state(void __iomem *base)
 {
 	u32 regval;
 
@@ -578,7 +533,7 @@ static u32 get_memsize(void)
 }
 
 /**
- * zynqmp_get_mtype - Returns controller memory type.
+ * synps_get_mtype - Returns controller memory type.
  * @base:	Synopsys ECC status structure.
  *
  * Get the EDAC memory type appropriate for the current controller
@@ -586,7 +541,7 @@ static u32 get_memsize(void)
  *
  * Return: a memory type enumeration.
  */
-static enum mem_type zynqmp_get_mtype(const void __iomem *base)
+static enum mem_type synps_get_mtype(const void __iomem *base)
 {
 	enum mem_type mt;
 	u32 memtype;
@@ -615,14 +570,11 @@ static enum mem_type zynqmp_get_mtype(const void __iomem *base)
 static void init_csrows(struct mem_ctl_info *mci)
 {
 	struct synps_edac_priv *priv = mci->pvt_info;
-	const struct synps_platform_data *p_data;
 	struct csrow_info *csi;
 	struct dimm_info *dimm;
 	u32 size, row;
 	int j;
 
-	p_data = priv->p_data;
-
 	for (row = 0; row < mci->nr_csrows; row++) {
 		csi = mci->csrows[row];
 		size = get_memsize();
@@ -630,10 +582,10 @@ static void init_csrows(struct mem_ctl_info *mci)
 		for (j = 0; j < csi->nr_channels; j++) {
 			dimm		= csi->channels[j]->dimm;
 			dimm->edac_mode	= EDAC_SECDED;
-			dimm->mtype	= p_data->get_mtype(priv->baseaddr);
+			dimm->mtype	= synps_get_mtype(priv->baseaddr);
 			dimm->nr_pages	= (size >> PAGE_SHIFT) / csi->nr_channels;
 			dimm->grain	= SYNPS_EDAC_ERR_GRAIN;
-			dimm->dtype	= p_data->get_dtype(priv->baseaddr);
+			dimm->dtype	= synps_get_dtype(priv->baseaddr);
 		}
 	}
 }
@@ -649,10 +601,7 @@ static void init_csrows(struct mem_ctl_info *mci)
  */
 static void mc_init(struct mem_ctl_info *mci, struct platform_device *pdev)
 {
-	struct synps_edac_priv *priv;
-
 	mci->pdev = &pdev->dev;
-	priv = mci->pvt_info;
 	platform_set_drvdata(pdev, mci);
 
 	/* Initialize controller capabilities and configuration */
@@ -666,12 +615,7 @@ static void mc_init(struct mem_ctl_info *mci, struct platform_device *pdev)
 	mci->dev_name = SYNPS_EDAC_MOD_STRING;
 	mci->mod_name = SYNPS_EDAC_MOD_VER;
 
-	if (priv->p_data->quirks & DDR_ECC_INTR_SUPPORT) {
-		edac_op_state = EDAC_OPSTATE_INT;
-	} else {
-		edac_op_state = EDAC_OPSTATE_POLL;
-		mci->edac_check = check_errors;
-	}
+	edac_op_state = EDAC_OPSTATE_INT;
 
 	mci->ctl_page_to_phys = NULL;
 
@@ -703,47 +647,6 @@ static int setup_irq(struct mem_ctl_info *mci,
 	return 0;
 }
 
-static const struct synps_platform_data zynqmp_edac_def = {
-	.get_error_info	= zynqmp_get_error_info,
-	.get_mtype	= zynqmp_get_mtype,
-	.get_dtype	= zynqmp_get_dtype,
-	.get_ecc_state	= zynqmp_get_ecc_state,
-	.quirks         = (DDR_ECC_INTR_SUPPORT | SYNPS_ZYNQMP_IRQ_REGS
-#ifdef CONFIG_EDAC_DEBUG
-			  | DDR_ECC_DATA_POISON_SUPPORT
-#endif
-			  ),
-};
-
-static const struct synps_platform_data synopsys_edac_def = {
-	.get_error_info	= zynqmp_get_error_info,
-	.get_mtype	= zynqmp_get_mtype,
-	.get_dtype	= zynqmp_get_dtype,
-	.get_ecc_state	= zynqmp_get_ecc_state,
-	.quirks         = (DDR_ECC_INTR_SUPPORT
-#ifdef CONFIG_EDAC_DEBUG
-			  | DDR_ECC_DATA_POISON_SUPPORT
-#endif
-			  ),
-};
-
-
-static const struct of_device_id synps_edac_match[] = {
-	{
-		.compatible = "xlnx,zynqmp-ddrc-2.40a",
-		.data = (void *)&zynqmp_edac_def
-	},
-	{
-		.compatible = "snps,ddrc-3.80a",
-		.data = (void *)&synopsys_edac_def
-	},
-	{
-		/* end of table */
-	}
-};
-
-MODULE_DEVICE_TABLE(of, synps_edac_match);
-
 #ifdef CONFIG_EDAC_DEBUG
 
 /**
@@ -1134,7 +1037,7 @@ static int mc_probe(struct platform_device *pdev)
 	if (!p_data)
 		return -ENODEV;
 
-	if (!p_data->get_ecc_state(baseaddr)) {
+	if (!synps_get_ecc_state(baseaddr)) {
 		edac_printk(KERN_INFO, EDAC_MC, "ECC not enabled\n");
 		return -ENXIO;
 	}
@@ -1161,11 +1064,9 @@ static int mc_probe(struct platform_device *pdev)
 
 	mc_init(mci, pdev);
 
-	if (priv->p_data->quirks & DDR_ECC_INTR_SUPPORT) {
-		rc = setup_irq(mci, pdev);
-		if (rc)
-			goto free_edac_mc;
-	}
+	rc = setup_irq(mci, pdev);
+	if (rc)
+		goto free_edac_mc;
 
 	rc = edac_mc_add_mc(mci);
 	if (rc) {
@@ -1175,17 +1076,13 @@ static int mc_probe(struct platform_device *pdev)
 	}
 
 #ifdef CONFIG_EDAC_DEBUG
-	if (priv->p_data->quirks & DDR_ECC_DATA_POISON_SUPPORT) {
-		rc = edac_create_sysfs_attributes(mci);
-		if (rc) {
-			edac_printk(KERN_ERR, EDAC_MC,
-					"Failed to create sysfs entries\n");
-			goto free_edac_mc;
-		}
+	rc = edac_create_sysfs_attributes(mci);
+	if (rc) {
+		edac_printk(KERN_ERR, EDAC_MC, "Failed to create sysfs entries\n");
+		goto free_edac_mc;
 	}
 
-	if (priv->p_data->quirks & DDR_ECC_INTR_SUPPORT)
-		setup_address_map(priv);
+	setup_address_map(priv);
 #endif
 
 	return rc;
@@ -1207,12 +1104,10 @@ static int mc_remove(struct platform_device *pdev)
 	struct mem_ctl_info *mci = platform_get_drvdata(pdev);
 	struct synps_edac_priv *priv = mci->pvt_info;
 
-	if (priv->p_data->quirks & DDR_ECC_INTR_SUPPORT)
-		disable_intr(priv);
+	disable_intr(priv);
 
 #ifdef CONFIG_EDAC_DEBUG
-	if (priv->p_data->quirks & DDR_ECC_DATA_POISON_SUPPORT)
-		edac_remove_sysfs_attributes(mci);
+	edac_remove_sysfs_attributes(mci);
 #endif
 
 	edac_mc_del_mc(&pdev->dev);
@@ -1221,6 +1116,21 @@ static int mc_remove(struct platform_device *pdev)
 	return 0;
 }
 
+static const struct synps_platform_data zynqmp_edac_def = {
+	.quirks = SYNPS_ZYNQMP_IRQ_REGS,
+};
+
+static const struct synps_platform_data synopsys_edac_def = {
+	.quirks = 0,
+};
+
+static const struct of_device_id synps_edac_match[] = {
+	{ .compatible = "xlnx,zynqmp-ddrc-2.40a", .data = &zynqmp_edac_def },
+	{ .compatible = "snps,ddrc-3.80a", .data = &synopsys_edac_def },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, synps_edac_match);
+
 static struct platform_driver synps_edac_mc_driver = {
 	.driver = {
 		   .name = "synopsys-edac",
-- 
2.41.0

