Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A3777A8CD1
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 21:28:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230166AbjITT25 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 15:28:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230161AbjITT2v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 15:28:51 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3BB6182;
        Wed, 20 Sep 2023 12:28:35 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id 38308e7fff4ca-2c00c0f11b2so2598101fa.1;
        Wed, 20 Sep 2023 12:28:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695238113; x=1695842913; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FcE22L1gZlo+3hTGWgJEFMaEq2Hv0fi5fdl2Fwo2OJ8=;
        b=X1ZyVkZyMtshuDAhuknVrGLMXBwDrm2c5bj3aimVSzDvfNgOLxsROxYtujbShr1DYp
         6TuPO462BggEfiP5QPS++Un0MU8Gun1TGVOH/oX8cMoNvPWRdpFe2kKeYWB5IfvLf6gi
         FRKU5T8gUmHU81MLpOnrU4C9oTyvRSjX0F7wYK9il7d1UmNr7A6sWNlhMNdEbjq6tTZK
         F5EdN/aDLKoGNjlMNnXcHosLgM4qLS7Ms31N+Y7itJ+8xuAwceEIlFTFIsf+z0APNp9s
         QiAbzVbixxgxWxX63h5uW+pJ0h1Hq4cdifeRzUqOIfB7Qngkw4Ffj5WNfwUotuzNmaWU
         Ahjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695238113; x=1695842913;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FcE22L1gZlo+3hTGWgJEFMaEq2Hv0fi5fdl2Fwo2OJ8=;
        b=Fr6d+oiQ0G3jtvfMtmXjAUWDDVNU+pO5rGgSy5GAuA7cW61Hsmo5mQMBCym20xSz2l
         KpPt9IAgrBI5RzajEkJTQENKO9N/tyS/ukNYaAr1HZjHcwUUiowRctYacQ+iBrU+Xf4L
         B2KWzs78w6Jt7GFXvzRbDqZThYabF9DH//wUjrD014J0DnGmg67Rtt4ylAub9Ywp6Lk0
         FgCkYvBuKG7d6meYIQc9mKXxTO3kHoqPlrjRyql6Zbz534tcn6Jl6B0jZWX6fAlZPp1R
         EWCXnKhocwjcf6hPJEou49rypUF1wZ7Q/013n5OVwcccZRwp9NHjlKjXseApSkdNcTz1
         l9gQ==
X-Gm-Message-State: AOJu0Yx0C5E1D31zZNDe5BeXa1cwdc3EJutQwZdz7pTAcxMIBC1MPivj
        Ax4RN0GyAppfNJKk7d+Wjlw=
X-Google-Smtp-Source: AGHT+IGiKZmJrEyWUj9IUt/0uAtjUF2FJ30VYmmzKUPIOz+867IhCz6JlP56yZK2hIC7esXYv4AdjQ==
X-Received: by 2002:a2e:90d5:0:b0:2bf:ff17:811b with SMTP id o21-20020a2e90d5000000b002bfff17811bmr2917213ljg.3.1695238113260;
        Wed, 20 Sep 2023 12:28:33 -0700 (PDT)
Received: from localhost ([178.176.83.40])
        by smtp.gmail.com with ESMTPSA id x18-20020a2e9c92000000b002b6cb25e3f1sm3065569lji.108.2023.09.20.12.28.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Sep 2023 12:28:32 -0700 (PDT)
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
Subject: [PATCH v4 05/18] EDAC/synopsys: Add DDRC basic parameters infrastructure
Date:   Wed, 20 Sep 2023 22:26:50 +0300
Message-ID: <20230920192806.29960-6-fancer.lancer@gmail.com>
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

Currently the driver supports a single DW uMCTL2 DDRC IP-core: 64-bit DQ
bus, ECC SEC/DED with always on Scrub (HW-src scrub). This makes the
driver application being very limited. In addition to that lacking of any
controller capabilities/parameters infrastructure makes it harder to add
optional features support. Let's overcome all of that by adding a simple
DW uMCTL2 DDRC IP-core parameters infrastructure. It's made of the
snps_ddrc_info structure and a new method snps_get_ddrc_info() introduced
to fill the structure fields in. The structure contains the IP-core
parameters needed to create a more comprehensive driver and will be used
in the driver to activate/de-activate various features:
- ECC Mode: SEC/DED or Advanced X4/X8 ECC features. (Currently SEC/DED is
  only supported.)
- SDRAM mode: (LP)DDR[2-4] memory interfaces. (Required for the HIF/SDRAM
  address translation.)
- Memory Device config: Memory chips detected on the platform. (Applicable
  for DDR4 setups only.)
- DQ-bus width: Maximal DQ-bus width utilized by the device. (Required for
  the Application/HIF address translation.)
- DQ-bus mode: Actual DQ-bus width used to access the memory devices.
  (Required for the HIF/SDRAM address translation and ECC grain calc.)
- HIF/SDRAM burst length. (Required for the Scrubber bandwidth
  calculation.)
- HIF/SDRAM frequency ratio. (Required for the SDRAM bandwidth
  calculation.)
- SDRAM ranks number. (Required for the Application/HIF address
  translation.)

The list can be easily updated should any additional features support is
required to be added in future, but at this stage the driver is fixed in a
few places to have the new infrastructure utilized: SDRAM column address
mapper, MCI csrows initialization.

Note getting all of these parameters in a single method is very suitable
from two perspectives. First it localizes the IP-core parameters detection
thus improving the code readability and maintainability. Second it's very
suitable for the platform-specific quirks implementation. Since some of
the IP-core parameters can't be auto-detected at run-time, they will be
able to be fixed right in the parameters getter by means of the platform
quirks.

Signed-off-by: Serge Semin <fancer.lancer@gmail.com>
---
 drivers/edac/synopsys_edac.c | 268 +++++++++++++++++++++++++++--------
 1 file changed, 211 insertions(+), 57 deletions(-)

diff --git a/drivers/edac/synopsys_edac.c b/drivers/edac/synopsys_edac.c
index e177a36646c0..b830e4b4292d 100644
--- a/drivers/edac/synopsys_edac.c
+++ b/drivers/edac/synopsys_edac.c
@@ -12,6 +12,7 @@
 #include <linux/fs.h>
 #include <linux/module.h>
 #include <linux/platform_device.h>
+#include <linux/seq_file.h>
 #include <linux/spinlock.h>
 #include <linux/interrupt.h>
 #include <linux/of.h>
@@ -87,6 +88,11 @@
 /* DDR Software Control Register */
 #define DDR_SWCTL			0x320
 
+/* ECC Poison Pattern Registers */
+#define ECC_POISONPAT0_OFST		0x37C
+#define ECC_POISONPAT1_OFST		0x380
+#define ECC_POISONPAT2_OFST		0x384
+
 /* ZynqMP DDR QOS Registers */
 #define ZYNQMP_DDR_QOS_IRQ_STAT_OFST	0x20200
 #define ZYNQMP_DDR_QOS_IRQ_EN_OFST	0x20208
@@ -98,10 +104,10 @@
 #define DDR_MSTR_DEV_X8			1
 #define DDR_MSTR_DEV_X16		2
 #define DDR_MSTR_DEV_X32		3
+#define DDR_MSTR_ACT_RANKS_MASK		GENMASK(27, 24)
+#define DDR_MSTR_FREQ_RATIO11		BIT(22)
+#define DDR_MSTR_BURST_RDWR		GENMASK(19, 16)
 #define DDR_MSTR_BUSWIDTH_MASK		GENMASK(13, 12)
-#define DDR_MSTR_BUSWIDTH_16		2
-#define DDR_MSTR_BUSWIDTH_32		1
-#define DDR_MSTR_BUSWIDTH_64		0
 #define DDR_MSTR_MEM_MASK		GENMASK(5, 0)
 #define DDR_MSTR_MEM_LPDDR4		BIT(5)
 #define DDR_MSTR_MEM_DDR4		BIT(4)
@@ -113,7 +119,6 @@
 
 /* ECC CFG0 register definitions */
 #define ECC_CFG0_MODE_MASK		GENMASK(2, 0)
-#define ECC_CFG0_MODE_SECDED		0x4
 
 /* ECC status register definitions */
 #define ECC_STAT_UE_MASK		GENMASK(23, 16)
@@ -208,6 +213,91 @@
 #define ZYNQMP_DDR_QOS_CE_MASK		BIT(1)
 #define ZYNQMP_DDR_QOS_IRQ_MASK		(ZYNQMP_DDR_QOS_UE_MASK | ZYNQMP_DDR_QOS_CE_MASK)
 
+/**
+ * enum snps_dq_width - SDRAM DQ bus width (ECC capable).
+ * SNPS_DQ_32:	32-bit memory data width.
+ * SNPS_DQ_64:	64-bit memory data width.
+ */
+enum snps_dq_width {
+	SNPS_DQ_32 = 2,
+	SNPS_DQ_64 = 3,
+};
+
+/**
+ * enum snps_dq_mode - SDRAM DQ bus mode.
+ * @SNPS_DQ_FULL:	Full DQ bus width.
+ * @SNPS_DQ_HALF:	Half DQ bus width.
+ * @SNPS_DQ_QRTR:	Quarter DQ bus width.
+ */
+enum snps_dq_mode {
+	SNPS_DQ_FULL = 0,
+	SNPS_DQ_HALF = 1,
+	SNPS_DQ_QRTR = 2,
+};
+
+/**
+ * enum snps_burst_length - HIF/SDRAM burst transactions length.
+ * @SNPS_DDR_BL2:	Burst length 2xSDRAM-words.
+ * @SNPS_DDR_BL4:	Burst length 4xSDRAM-words.
+ * @SNPS_DDR_BL8:	Burst length 8xSDRAM-words.
+ * @SNPS_DDR_BL16:	Burst length 16xSDRAM-words.
+ */
+enum snps_burst_length {
+	SNPS_DDR_BL2 = 2,
+	SNPS_DDR_BL4 = 4,
+	SNPS_DDR_BL8 = 8,
+	SNPS_DDR_BL16 = 16,
+};
+
+/**
+ * enum snps_freq_ratio - HIF:SDRAM frequency ratio mode.
+ * @SNPS_FREQ_RATIO11:	1:1 frequency mode.
+ * @SNPS_FREQ_RATIO12:	1:2 frequency mode.
+ */
+enum snps_freq_ratio {
+	SNPS_FREQ_RATIO11 = 1,
+	SNPS_FREQ_RATIO12 = 2,
+};
+
+/**
+ * enum snps_ecc_mode - ECC mode.
+ * @SNPS_ECC_DISABLED:	ECC is disabled/unavailable.
+ * @SNPS_ECC_SECDED:	SEC/DED over 1 beat ECC (SideBand/Inline).
+ * @SNPS_ECC_ADVX4X8:	Advanced ECC X4/X8 (SideBand).
+ */
+enum snps_ecc_mode {
+	SNPS_ECC_DISABLED = 0,
+	SNPS_ECC_SECDED = 4,
+	SNPS_ECC_ADVX4X8 = 5,
+};
+
+/**
+ * struct snps_ddrc_info - DDR controller platform parameters.
+ * @caps:		DDR controller capabilities.
+ * @sdram_mode:		Current SDRAM mode selected.
+ * @dev_cfg:		Current memory device config (if applicable).
+ * @dq_width:		Memory data bus width (width of the DQ signals
+ *			connected to SDRAM chips).
+ * @dq_mode:		Proportion of the DQ bus utilized to access SDRAM.
+ * @sdram_burst_len:	SDRAM burst transaction length.
+ * @hif_burst_len:	HIF burst transaction length (Host Interface).
+ * @freq_ratio:		HIF/SDRAM frequency ratio mode.
+ * @ecc_mode:		ECC mode enabled for the DDR controller (SEC/DED, etc).
+ * @ranks:		Number of ranks enabled to access DIMM (1, 2 or 4).
+ */
+struct snps_ddrc_info {
+	unsigned int caps;
+	enum mem_type sdram_mode;
+	enum dev_type dev_cfg;
+	enum snps_dq_width dq_width;
+	enum snps_dq_mode dq_mode;
+	enum snps_burst_length sdram_burst_len;
+	enum snps_burst_length hif_burst_len;
+	enum snps_freq_ratio freq_ratio;
+	enum snps_ecc_mode ecc_mode;
+	unsigned int ranks;
+};
+
 /**
  * struct snps_ecc_error_info - ECC error log information.
  * @row:	Row number.
@@ -242,6 +332,7 @@ struct snps_ecc_status {
 
 /**
  * struct snps_edac_priv - DDR memory controller private data.
+ * @info:		DDR controller config info.
  * @pdev:		Platform device.
  * @baseaddr:		Base address of the DDR controller.
  * @reglock:		Concurrent CSRs access lock.
@@ -256,6 +347,7 @@ struct snps_ecc_status {
  * @rank_shift:		Bit shifts for rank bit.
  */
 struct snps_edac_priv {
+	struct snps_ddrc_info info;
 	struct platform_device *pdev;
 	void __iomem *baseaddr;
 	spinlock_t reglock;
@@ -495,23 +587,19 @@ static struct snps_edac_priv *snps_create_data(struct platform_device *pdev)
 
 /**
  * snps_get_dtype - Return the controller memory width.
- * @base:	DDR memory controller base address.
+ * @mstr:	Master CSR value.
  *
  * Get the EDAC device type width appropriate for the current controller
  * configuration.
  *
  * Return: a device type width enumeration.
  */
-static enum dev_type snps_get_dtype(const void __iomem *base)
+static inline enum dev_type snps_get_dtype(u32 mstr)
 {
-	u32 regval;
-
-	regval = readl(base + DDR_MSTR_OFST);
-	if (!(regval & DDR_MSTR_MEM_DDR4))
+	if (!(mstr & DDR_MSTR_MEM_DDR4))
 		return DEV_UNKNOWN;
 
-	regval = FIELD_GET(DDR_MSTR_DEV_CFG_MASK, regval);
-	switch (regval) {
+	switch (FIELD_GET(DDR_MSTR_DEV_CFG_MASK, mstr)) {
 	case DDR_MSTR_DEV_X4:
 		return DEV_X4;
 	case DDR_MSTR_DEV_X8:
@@ -525,24 +613,6 @@ static enum dev_type snps_get_dtype(const void __iomem *base)
 	return DEV_UNKNOWN;
 }
 
-/**
- * snps_get_ecc_state - Return the controller ECC enable/disable status.
- * @base:	DDR memory controller base address.
- *
- * Get the ECC enable/disable status for the controller.
- *
- * Return: a ECC status boolean i.e true/false - enabled/disabled.
- */
-static bool snps_get_ecc_state(void __iomem *base)
-{
-	u32 regval;
-
-	regval = readl(base + ECC_CFG0_OFST);
-	regval = FIELD_GET(ECC_CFG0_MODE_MASK, regval);
-
-	return (regval == ECC_CFG0_MODE_SECDED);
-}
-
 /**
  * snps_get_memsize - Read the size of the attached memory device.
  *
@@ -559,21 +629,16 @@ static u32 snps_get_memsize(void)
 
 /**
  * snps_get_mtype - Returns controller memory type.
- * @base:	Synopsys ECC status structure.
+ * @mstr:	Master CSR value.
  *
  * Get the EDAC memory type appropriate for the current controller
  * configuration.
  *
  * Return: a memory type enumeration.
  */
-static enum mem_type snps_get_mtype(const void __iomem *base)
+static inline enum mem_type snps_get_mtype(u32 mstr)
 {
-	u32 regval;
-
-	regval = readl(base + DDR_MSTR_OFST);
-	regval = FIELD_GET(DDR_MSTR_MEM_MASK, regval);
-
-	switch (regval) {
+	switch (FIELD_GET(DDR_MSTR_MEM_MASK, mstr)) {
 	case DDR_MSTR_MEM_DDR2:
 		return MEM_DDR2;
 	case DDR_MSTR_MEM_DDR3:
@@ -593,6 +658,69 @@ static enum mem_type snps_get_mtype(const void __iomem *base)
 	return MEM_RESERVED;
 }
 
+/**
+ * snps_get_ddrc_info - Get the DDR controller config data.
+ * @priv:	DDR memory controller private data.
+ *
+ * Return: negative errno if no ECC detected, otherwise - zero.
+ */
+static int snps_get_ddrc_info(struct snps_edac_priv *priv)
+{
+	int (*init_plat)(struct snps_edac_priv *priv);
+	u32 regval;
+
+	/* Before getting the DDRC parameters make sure ECC is enabled */
+	regval = readl(priv->baseaddr + ECC_CFG0_OFST);
+
+	priv->info.ecc_mode = FIELD_GET(ECC_CFG0_MODE_MASK, regval);
+	if (priv->info.ecc_mode != SNPS_ECC_SECDED) {
+		edac_printk(KERN_INFO, EDAC_MC, "SEC/DED ECC not enabled\n");
+		return -ENXIO;
+	}
+
+	/* Auto-detect the basic HIF/SDRAM bus parameters */
+	regval = readl(priv->baseaddr + DDR_MSTR_OFST);
+
+	priv->info.sdram_mode = snps_get_mtype(regval);
+	priv->info.dev_cfg = snps_get_dtype(regval);
+
+	priv->info.dq_mode = FIELD_GET(DDR_MSTR_BUSWIDTH_MASK, regval);
+
+	/*
+	 * Assume HIF burst length matches the SDRAM burst length since it's
+	 * not auto-detectable
+	 */
+	priv->info.sdram_burst_len = FIELD_GET(DDR_MSTR_BURST_RDWR, regval) << 1;
+	priv->info.hif_burst_len = priv->info.sdram_burst_len;
+
+	/* Retrieve the current HIF/SDRAM frequency ratio: 1:1 vs 1:2 */
+	priv->info.freq_ratio = !(regval & DDR_MSTR_FREQ_RATIO11) + 1;
+
+	/* Activated ranks field: set bit corresponds to populated rank */
+	priv->info.ranks = FIELD_GET(DDR_MSTR_ACT_RANKS_MASK, regval);
+	priv->info.ranks = hweight_long(priv->info.ranks);
+
+	/* Auto-detect the DQ bus width by using the ECC-poison pattern CSR */
+	writel(0, priv->baseaddr + DDR_SWCTL);
+
+	/*
+	 * If poison pattern [32:64] is changeable then DQ is 64-bit wide.
+	 * Note the feature has been available since IP-core v2.51a.
+	 */
+	regval = readl(priv->baseaddr + ECC_POISONPAT1_OFST);
+	writel(~regval, priv->baseaddr + ECC_POISONPAT1_OFST);
+	if (regval != readl(priv->baseaddr + ECC_POISONPAT1_OFST)) {
+		priv->info.dq_width = SNPS_DQ_64;
+		writel(regval, priv->baseaddr + ECC_POISONPAT1_OFST);
+	} else {
+		priv->info.dq_width = SNPS_DQ_32;
+	}
+
+	writel(1, priv->baseaddr + DDR_SWCTL);
+
+	return 0;
+}
+
 /**
  * snps_init_csrows - Initialize the csrow data.
  * @mci:	EDAC memory controller instance.
@@ -615,10 +743,10 @@ static void snps_init_csrows(struct mem_ctl_info *mci)
 		for (j = 0; j < csi->nr_channels; j++) {
 			dimm		= csi->channels[j]->dimm;
 			dimm->edac_mode	= EDAC_SECDED;
-			dimm->mtype	= snps_get_mtype(priv->baseaddr);
+			dimm->mtype	= priv->info.sdram_mode;
 			dimm->nr_pages	= (size >> PAGE_SHIFT) / csi->nr_channels;
 			dimm->grain	= SNPS_EDAC_ERR_GRAIN;
-			dimm->dtype	= snps_get_dtype(priv->baseaddr);
+			dimm->dtype	= priv->info.dev_cfg;
 		}
 	}
 }
@@ -732,6 +860,33 @@ static int snps_setup_irq(struct mem_ctl_info *mci)
 
 #define SNPS_DBGFS_BUF_LEN 128
 
+static int snps_ddrc_info_show(struct seq_file *s, void *data)
+{
+	struct mem_ctl_info *mci = s->private;
+	struct snps_edac_priv *priv = mci->pvt_info;
+
+	seq_printf(s, "SDRAM: %s\n", edac_mem_types[priv->info.sdram_mode]);
+
+	seq_printf(s, "DQ bus: %u/%s\n", (BITS_PER_BYTE << priv->info.dq_width),
+		   priv->info.dq_mode == SNPS_DQ_FULL ? "Full" :
+		   priv->info.dq_mode == SNPS_DQ_HALF ? "Half" :
+		   priv->info.dq_mode == SNPS_DQ_QRTR ? "Quarter" :
+		   "Unknown");
+	seq_printf(s, "Burst: SDRAM %u HIF %u\n", priv->info.sdram_burst_len,
+		   priv->info.hif_burst_len);
+
+	seq_printf(s, "Ranks: %u\n", priv->info.ranks);
+
+	seq_printf(s, "ECC: %s\n",
+		   priv->info.ecc_mode == SNPS_ECC_SECDED ? "SEC/DED" :
+		   priv->info.ecc_mode == SNPS_ECC_ADVX4X8 ? "Advanced X4/X8" :
+		   "Unknown");
+
+	return 0;
+}
+
+DEFINE_SHOW_ATTRIBUTE(snps_ddrc_info);
+
 /**
  * snps_data_poison_setup - Update poison registers.
  * @priv:		DDR memory controller private instance data.
@@ -853,12 +1008,8 @@ static void snps_setup_row_address_map(struct snps_edac_priv *priv, u32 *addrmap
 
 static void snps_setup_column_address_map(struct snps_edac_priv *priv, u32 *addrmap)
 {
-	u32 width, memtype;
 	int index;
 
-	memtype = readl(priv->baseaddr + DDR_MSTR_OFST);
-	width = FIELD_GET(DDR_MSTR_BUSWIDTH_MASK, memtype);
-
 	priv->col_shift[0] = 0;
 	priv->col_shift[1] = 1;
 	priv->col_shift[2] = (addrmap[2] & COL_MAX_VAL_MASK) + COL_B2_BASE;
@@ -882,8 +1033,8 @@ static void snps_setup_column_address_map(struct snps_edac_priv *priv, u32 *addr
 	priv->col_shift[9] = (((addrmap[3] >> 24) & COL_MAX_VAL_MASK) ==
 			COL_MAX_VAL_MASK) ? 0 : (((addrmap[3] >> 24) &
 					COL_MAX_VAL_MASK) + COL_B9_BASE);
-	if (width == DDR_MSTR_BUSWIDTH_64) {
-		if (memtype & DDR_MSTR_MEM_LPDDR3) {
+	if (priv->info.dq_mode == SNPS_DQ_FULL) {
+		if (priv->info.sdram_mode == MEM_LPDDR3) {
 			priv->col_shift[10] = ((addrmap[4] &
 				COL_MAX_VAL_MASK) == COL_MAX_VAL_MASK) ? 0 :
 				((addrmap[4] & COL_MAX_VAL_MASK) +
@@ -902,8 +1053,8 @@ static void snps_setup_column_address_map(struct snps_edac_priv *priv, u32 *addr
 				(((addrmap[4] >> 8) & COL_MAX_VAL_MASK) +
 				 COL_B11_BASE);
 		}
-	} else if (width == DDR_MSTR_BUSWIDTH_32) {
-		if (memtype & DDR_MSTR_MEM_LPDDR3) {
+	} else if (priv->info.dq_mode == SNPS_DQ_HALF) {
+		if (priv->info.sdram_mode == MEM_LPDDR3) {
 			priv->col_shift[10] = (((addrmap[3] >> 24) &
 				COL_MAX_VAL_MASK) == COL_MAX_VAL_MASK) ? 0 :
 				(((addrmap[3] >> 24) & COL_MAX_VAL_MASK) +
@@ -923,7 +1074,7 @@ static void snps_setup_column_address_map(struct snps_edac_priv *priv, u32 *addr
 				 COL_B10_BASE);
 		}
 	} else {
-		if (memtype & DDR_MSTR_MEM_LPDDR3) {
+		if (priv->info.sdram_mode == MEM_LPDDR3) {
 			priv->col_shift[10] = (((addrmap[3] >> 16) &
 				COL_MAX_VAL_MASK) == COL_MAX_VAL_MASK) ? 0 :
 				(((addrmap[3] >> 16) & COL_MAX_VAL_MASK) +
@@ -944,10 +1095,11 @@ static void snps_setup_column_address_map(struct snps_edac_priv *priv, u32 *addr
 		}
 	}
 
-	if (width) {
-		for (index = 9; index > width; index--) {
-			priv->col_shift[index] = priv->col_shift[index - width];
-			priv->col_shift[index - width] = 0;
+	if (priv->info.dq_mode) {
+		for (index = 9; index > priv->info.dq_mode; index--) {
+			priv->col_shift[index] =
+				priv->col_shift[index - priv->info.dq_mode];
+			priv->col_shift[index - priv->info.dq_mode] = 0;
 		}
 	}
 
@@ -1109,6 +1261,9 @@ static void snps_create_debugfs_nodes(struct mem_ctl_info *mci)
 
 	snps_setup_address_map(priv);
 
+	edac_debugfs_create_file("ddrc_info", 0400, mci->debugfs, mci,
+				 &snps_ddrc_info_fops);
+
 	edac_debugfs_create_file("inject_data_error", 0600, mci->debugfs, mci,
 				 &snps_inject_data_error);
 
@@ -1141,10 +1296,9 @@ static int snps_mc_probe(struct platform_device *pdev)
 	if (IS_ERR(priv))
 		return PTR_ERR(priv);
 
-	if (!snps_get_ecc_state(baseaddr)) {
-		edac_printk(KERN_INFO, EDAC_MC, "ECC not enabled\n");
-		return -ENXIO;
-	}
+	rc = snps_get_ddrc_info(priv);
+	if (rc)
+		return rc;
 
 	mci = snps_mc_create(priv);
 	if (IS_ERR(mci))
-- 
2.41.0

