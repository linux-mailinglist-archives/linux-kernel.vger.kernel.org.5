Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBFFC7A8CD2
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 21:28:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230093AbjITT27 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 15:28:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230086AbjITT2w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 15:28:52 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12F72DC;
        Wed, 20 Sep 2023 12:28:38 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id 2adb3069b0e04-503012f4e71so1568236e87.0;
        Wed, 20 Sep 2023 12:28:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695238116; x=1695842916; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AdGvtIhnrYM49qOF0XUq1B70UdgD51RskmRPZFchMpY=;
        b=FBt9uxSi91J33FLj5glMQTZgds5i3ryEoDg4Xl57+ubzdKGL7/3C3+P19ty+qzCHrY
         XAS7Yln49MYlKGaoGxKmc+fjJbUkhbq818tm9Sskh62tPtv4bxIwO7QE7STeGpW82kNG
         1f9oWOeU4DWqQidERbrkYhKQ+EjLhCBgPjTRgc9jvHsZgmFZcGbtNIahAX4wSL6EMWNg
         hgE4dG3RijF8wcJhKr6XzRQ2HCvlI5x1okZnq8g7BXRQClAGhzH7s3P8b98E5+ja3n/b
         GlYUP9OUJqn0G15oUHTxRVhPgO7mq2Fovv5CRRy6k2BEcjGnPnnAY0CN8KL4NZjDGkH9
         uRag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695238116; x=1695842916;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AdGvtIhnrYM49qOF0XUq1B70UdgD51RskmRPZFchMpY=;
        b=szeJF7nu3CrGcmjKF3nrTzWw/rkiQG156MkM46i2y1vWbb2ObFccJRSre17oBMCEjw
         2NJxIKWVBWaADv7pEZD9ImS0hrdEutq1x5yCjgSEh8w15IfTWj4m1io5lTk6OMyI6ixp
         JrcHwCb95mikApFTZZoCC/7BFE02fTGHsrWzUTrSay/dxp5/Bu0a8QPvZL5Vh21ESLuM
         Ug6AG8iqPrxRL5Nskvd1GbPuHF85LFMr51KKZxo21TCRpCj9Gr1L5FGYhN2fo3+ArSBg
         glrccTpHCbN/jgKmwu/SFMSCSvY1tEZdG9xcrVQKFW0+c7v1aFjcNsYXAPDBR5+HfucQ
         CjiA==
X-Gm-Message-State: AOJu0Yw5A/VhRdRGJsERO6VYGlK94d9Q6qNzDwtp5fKiDqlcUYMuuufI
        hAAC/UPO4wx3afH/2E2dVko=
X-Google-Smtp-Source: AGHT+IGvY2WjckLrqKF2TZ5J4zmwaRfWiTj3OXCSDcx1z66FZOZ2M7wBbipUU8euAtyWN4c2zI6iZQ==
X-Received: by 2002:a05:6512:3d29:b0:502:d973:3206 with SMTP id d41-20020a0565123d2900b00502d9733206mr3053467lfv.6.1695238116092;
        Wed, 20 Sep 2023 12:28:36 -0700 (PDT)
Received: from localhost ([85.140.0.70])
        by smtp.gmail.com with ESMTPSA id p21-20020a19f015000000b00500a14a6659sm2769277lfc.51.2023.09.20.12.28.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Sep 2023 12:28:35 -0700 (PDT)
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
Subject: [PATCH v4 06/18] EDAC/synopsys: Convert plat-data to plat-init function
Date:   Wed, 20 Sep 2023 22:26:51 +0300
Message-ID: <20230920192806.29960-7-fancer.lancer@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230920192806.29960-1-fancer.lancer@gmail.com>
References: <20230920192806.29960-1-fancer.lancer@gmail.com>
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

Since DW uMCTL2 device info and capabilities infrastructure is now
available there is no point in supporting an additional abstraction like
platform quirks. Instead convert the already defined ZynqMP quirk to the
ZynqMP-specific capability and add the platform-specific initialization
function support. This function will be called after the device parameters
are detected and thus fixing some of them if required.

Note the new approach will provide a very flexible interface of the
platform-specific setups. The platform-specific init() callback can be
used not only for the capabilities flags modification, but for example for
the resources requests or custom CSRs alterations.

Signed-off-by: Serge Semin <fancer.lancer@gmail.com>
---
 drivers/edac/synopsys_edac.c | 68 +++++++++++++++++++-----------------
 1 file changed, 35 insertions(+), 33 deletions(-)

diff --git a/drivers/edac/synopsys_edac.c b/drivers/edac/synopsys_edac.c
index b830e4b4292d..b77bc84c0bb0 100644
--- a/drivers/edac/synopsys_edac.c
+++ b/drivers/edac/synopsys_edac.c
@@ -34,8 +34,8 @@
 #define SNPS_EDAC_MOD_STRING		"snps_edac"
 #define SNPS_EDAC_MOD_VER		"1"
 
-/* DDR ECC Quirks */
-#define SNPS_ZYNQMP_IRQ_REGS		BIT(0)
+/* DDR capabilities */
+#define SNPS_CAP_ZYNQMP			BIT(31)
 
 /* Synopsys uMCTL2 DDR controller registers that are relevant to ECC */
 
@@ -338,7 +338,6 @@ struct snps_ecc_status {
  * @reglock:		Concurrent CSRs access lock.
  * @message:		Buffer for framing the event specific info.
  * @stat:		ECC status information.
- * @p_data:		Platform data.
  * @poison_addr:	Data poison address.
  * @row_shift:		Bit shifts for row bit.
  * @col_shift:		Bit shifts for column bit.
@@ -353,7 +352,6 @@ struct snps_edac_priv {
 	spinlock_t reglock;
 	char message[SNPS_EDAC_MSG_SIZE];
 	struct snps_ecc_status stat;
-	const struct snps_platform_data *p_data;
 #ifdef CONFIG_EDAC_DEBUG
 	ulong poison_addr;
 	u32 row_shift[18];
@@ -364,14 +362,6 @@ struct snps_edac_priv {
 #endif
 };
 
-/**
- * struct snps_platform_data - Synopsys uMCTL2 DDRC platform data.
- * @quirks:	IP-core specific quirks.
- */
-struct snps_platform_data {
-	u32 quirks;
-};
-
 /**
  * snps_get_error_info - Get the current ECC error info.
  * @priv:	DDR memory controller private instance data.
@@ -485,7 +475,7 @@ static void snps_enable_irq(struct snps_edac_priv *priv)
 	unsigned long flags;
 
 	/* Enable UE/CE Interrupts */
-	if (priv->p_data->quirks & SNPS_ZYNQMP_IRQ_REGS) {
+	if (priv->info.caps & SNPS_CAP_ZYNQMP) {
 		writel(ZYNQMP_DDR_QOS_UE_MASK | ZYNQMP_DDR_QOS_CE_MASK,
 		       priv->baseaddr + ZYNQMP_DDR_QOS_IRQ_EN_OFST);
 
@@ -509,7 +499,7 @@ static void snps_disable_irq(struct snps_edac_priv *priv)
 	unsigned long flags;
 
 	/* Disable UE/CE Interrupts */
-	if (priv->p_data->quirks & SNPS_ZYNQMP_IRQ_REGS) {
+	if (priv->info.caps & SNPS_CAP_ZYNQMP) {
 		writel(ZYNQMP_DDR_QOS_UE_MASK | ZYNQMP_DDR_QOS_CE_MASK,
 		       priv->baseaddr + ZYNQMP_DDR_QOS_IRQ_DB_OFST);
 
@@ -538,7 +528,7 @@ static irqreturn_t snps_irq_handler(int irq, void *dev_id)
 
 	priv = mci->pvt_info;
 
-	if (priv->p_data->quirks & SNPS_ZYNQMP_IRQ_REGS) {
+	if (priv->info.caps & SNPS_CAP_ZYNQMP) {
 		regval = readl(priv->baseaddr + ZYNQMP_DDR_QOS_IRQ_STAT_OFST);
 		regval &= (ZYNQMP_DDR_QOS_CE_MASK | ZYNQMP_DDR_QOS_UE_MASK);
 		if (!(regval & ZYNQMP_DDR_QOS_IRQ_MASK))
@@ -551,7 +541,7 @@ static irqreturn_t snps_irq_handler(int irq, void *dev_id)
 
 	snps_handle_error(mci, &priv->stat);
 
-	if (priv->p_data->quirks & SNPS_ZYNQMP_IRQ_REGS)
+	if (priv->info.caps & SNPS_CAP_ZYNQMP)
 		writel(regval, priv->baseaddr + ZYNQMP_DDR_QOS_IRQ_STAT_OFST);
 
 	return IRQ_HANDLED;
@@ -575,16 +565,26 @@ static struct snps_edac_priv *snps_create_data(struct platform_device *pdev)
 	if (IS_ERR(priv->baseaddr))
 		return ERR_CAST(priv->baseaddr);
 
-	priv->p_data = of_device_get_match_data(&pdev->dev);
-	if (!priv->p_data)
-		return ERR_PTR(-ENODEV);
-
 	priv->pdev = pdev;
 	spin_lock_init(&priv->reglock);
 
 	return priv;
 }
 
+/*
+ * zynqmp_init_plat - ZynqMP-specific platform initialization.
+ * @priv:	DDR memory controller private data.
+ *
+ * Return: always zero.
+ */
+static int zynqmp_init_plat(struct snps_edac_priv *priv)
+{
+	priv->info.caps |= SNPS_CAP_ZYNQMP;
+	priv->info.dq_width = SNPS_DQ_64;
+
+	return 0;
+}
+
 /**
  * snps_get_dtype - Return the controller memory width.
  * @mstr:	Master CSR value.
@@ -718,7 +718,10 @@ static int snps_get_ddrc_info(struct snps_edac_priv *priv)
 
 	writel(1, priv->baseaddr + DDR_SWCTL);
 
-	return 0;
+	/* Apply platform setups after all the configs auto-detection */
+	init_plat = device_get_match_data(&priv->pdev->dev);
+
+	return init_plat ? init_plat(priv) : 0;
 }
 
 /**
@@ -822,8 +825,6 @@ static void snps_mc_free(struct mem_ctl_info *mci)
 	edac_mc_free(mci);
 }
 
-
-
 static int snps_setup_irq(struct mem_ctl_info *mci)
 {
 	struct snps_edac_priv *priv = mci->pvt_info;
@@ -882,6 +883,15 @@ static int snps_ddrc_info_show(struct seq_file *s, void *data)
 		   priv->info.ecc_mode == SNPS_ECC_ADVX4X8 ? "Advanced X4/X8" :
 		   "Unknown");
 
+	seq_puts(s, "Caps:");
+	if (priv->info.caps) {
+		if (priv->info.caps & SNPS_CAP_ZYNQMP)
+			seq_puts(s, " +ZynqMP");
+	} else {
+		seq_puts(s, " -");
+	}
+	seq_putc(s, '\n');
+
 	return 0;
 }
 
@@ -1345,17 +1355,9 @@ static int snps_mc_remove(struct platform_device *pdev)
 	return 0;
 }
 
-static const struct snps_platform_data zynqmp_edac_def = {
-	.quirks = SNPS_ZYNQMP_IRQ_REGS,
-};
-
-static const struct snps_platform_data snps_edac_def = {
-	.quirks = 0,
-};
-
 static const struct of_device_id snps_edac_match[] = {
-	{ .compatible = "xlnx,zynqmp-ddrc-2.40a", .data = &zynqmp_edac_def },
-	{ .compatible = "snps,ddrc-3.80a", .data = &snps_edac_def },
+	{ .compatible = "xlnx,zynqmp-ddrc-2.40a", .data = zynqmp_init_plat },
+	{ .compatible = "snps,ddrc-3.80a" },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, snps_edac_match);
-- 
2.41.0

