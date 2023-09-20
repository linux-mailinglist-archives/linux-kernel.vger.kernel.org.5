Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B268E7A8D54
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 21:58:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230247AbjITT6a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 15:58:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230238AbjITT6Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 15:58:25 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF84AEB;
        Wed, 20 Sep 2023 12:58:13 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id 38308e7fff4ca-2c12ae20a5cso2593911fa.2;
        Wed, 20 Sep 2023 12:58:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695239892; x=1695844692; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7q4RipS6b15lvYflfFa1+Nk3GxKwtj41DmLwRyxQ6s0=;
        b=hAiTTAkisLTIDWsFsQ0Ut46ivw/HVSXbvmH6TEYh1s3OZUl33j/ONtYMbjKRH9tha3
         woQYoM5Ni71n3b9ik2sU+YLxyQA44ynlLSslTx2TgmRoGrf4KHBGYDSvFu4gTFFC3+2g
         J5x0EUNQh81bQPiPC0V396RJgPeZuqXZ8wuiOBDerjGgCCCWszqna2Xp+8yzKE90I3ul
         mCvI5EtqF3TO6GyMqqDrp5Rt2wCdUM/Iu0GfxSeYw8YxoI+YfF3D5aQop72NQm20GsED
         bLz1irtFzvzIre/0ePYIbnFYYMk+CgWHCfwdxZLRiyQBXCckwiNhnKH/T8CJzTNM3K/E
         xX8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695239892; x=1695844692;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7q4RipS6b15lvYflfFa1+Nk3GxKwtj41DmLwRyxQ6s0=;
        b=fUzqAPg6MfTKL+NOhxyn33MrjSxI7zRtrNi8xq87/Cme87T2QC0QWyVn7GdLxESBWf
         43o6go5gbjwcxzitGsURuU1xIyFfMKEiHn8PR9PxPK8r5lyEh611MQh702m6Gpkx95tl
         /2zK6FfxLfK5P6/p497PHu3DCjhXQ1IPT1IeBuibsZKLGe3qKtUbvetFd17LSCYZbbfo
         4X59PCh0DuBbUbmaFPXd+QppCdBwZYj2fPNkDLYdEiCW+H4zUXMaM79R29bEfbd+z7CE
         HtW0eAXW8feLsFQVv6mZggXJqM0EalNNi6lRK1ZFduV36127SI7fs7VHUxltYanBHcjP
         2iZg==
X-Gm-Message-State: AOJu0YztUEzDCrMwyfRwZ+Y4lui6CfuGC3BHfY6Y0rDSlo0gqW3QAgAV
        Dmd3WdIovo85K3y42aK5YiM=
X-Google-Smtp-Source: AGHT+IFHx5Yw4O9uMU48g+3diw3Npe99J5F+vLRI25HvD9/mvj/uyV4pbAxCfxNnPr3blo4UfBevkg==
X-Received: by 2002:a05:651c:237:b0:2c0:a2:77e1 with SMTP id z23-20020a05651c023700b002c000a277e1mr3278163ljn.4.1695239892018;
        Wed, 20 Sep 2023 12:58:12 -0700 (PDT)
Received: from localhost ([178.176.85.138])
        by smtp.gmail.com with ESMTPSA id a14-20020a2ebe8e000000b002bffb3f8cebsm2010374ljr.54.2023.09.20.12.58.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Sep 2023 12:58:11 -0700 (PDT)
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
Subject: [PATCH v4 07/13] EDAC/synopsys: Split up ECC UE/CE IRQs handler
Date:   Wed, 20 Sep 2023 22:56:38 +0300
Message-ID: <20230920195720.32047-8-fancer.lancer@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230920195720.32047-1-fancer.lancer@gmail.com>
References: <20230920195720.32047-1-fancer.lancer@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DW uMCTL2 DDRC IP-core doesn't have common IRQ line. Instead it provides
individual IRQ output signals for each controller events like: corrected
error, uncorrected error, DFI parity error, address protection, scrubber
done, and so on. So the common IRQ handler implemented in the Synopsys
EDAC driver isn't device-specific but is a particular platform specific.
Obviously it won't be suitable for the generic devices which are added to
the platforms with the original individual IRQs.

So split up the common IRQ handler into two ones handling ECC corrected
and uncorrected errors. It won't be that hard since both sub-methods it
calls are already logically divided into two CE/UE parts. It just implies
moving these parts into the dedicated methods and redefining the local
variables a bit. The new methods will be simply called from the common
IRQs handler if one is utilized on the particular platform. Otherwise each
new IRQ handler will be called on particular interrupt request (the IRQ
handlers registration will be added a bit later).

Note the snps_ecc_status structure is no longer unneeded since the error
data is collected and reported now within a single method. So drop it.

Signed-off-by: Serge Semin <fancer.lancer@gmail.com>
---
 drivers/edac/synopsys_edac.c | 273 ++++++++++++++++++-----------------
 1 file changed, 137 insertions(+), 136 deletions(-)

diff --git a/drivers/edac/synopsys_edac.c b/drivers/edac/synopsys_edac.c
index 3735c784fac9..9dde43636199 100644
--- a/drivers/edac/synopsys_edac.c
+++ b/drivers/edac/synopsys_edac.c
@@ -231,7 +231,6 @@
 /* ZynqMP DDR QOS Interrupt register definitions */
 #define ZYNQMP_DDR_QOS_UE_MASK		BIT(2)
 #define ZYNQMP_DDR_QOS_CE_MASK		BIT(1)
-#define ZYNQMP_DDR_QOS_IRQ_MASK		(ZYNQMP_DDR_QOS_UE_MASK | ZYNQMP_DDR_QOS_CE_MASK)
 
 /**
  * enum snps_dq_width - SDRAM DQ bus width (ECC capable).
@@ -373,6 +372,8 @@ struct snps_sdram_addr {
 
 /**
  * struct snps_ecc_error_info - ECC error log information.
+ * @ecnt:	Number of detected errors.
+ * @syndrome:	Error syndrome.
  * @sdram:	SDRAM address.
  * @syndrome:	Error syndrome.
  * @bitpos:	Bit position.
@@ -380,6 +381,7 @@ struct snps_sdram_addr {
  * @ecc:	Data ECC.
  */
 struct snps_ecc_error_info {
+	u16 ecnt;
 	struct snps_sdram_addr sdram;
 	u32 syndrome;
 	u32 bitpos;
@@ -387,20 +389,6 @@ struct snps_ecc_error_info {
 	u32 ecc;
 };
 
-/**
- * struct snps_ecc_status - ECC status information to report.
- * @ce_cnt:	Correctable error count.
- * @ue_cnt:	Uncorrectable error count.
- * @ceinfo:	Correctable error log information.
- * @ueinfo:	Uncorrectable error log information.
- */
-struct snps_ecc_status {
-	u32 ce_cnt;
-	u32 ue_cnt;
-	struct snps_ecc_error_info ceinfo;
-	struct snps_ecc_error_info ueinfo;
-};
-
 /**
  * struct snps_edac_priv - DDR memory controller private data.
  * @info:		DDR controller config info.
@@ -410,7 +398,6 @@ struct snps_ecc_status {
  * @baseaddr:		Base address of the DDR controller.
  * @reglock:		Concurrent CSRs access lock.
  * @message:		Buffer for framing the event specific info.
- * @stat:		ECC status information.
  */
 struct snps_edac_priv {
 	struct snps_ddrc_info info;
@@ -420,7 +407,6 @@ struct snps_edac_priv {
 	void __iomem *baseaddr;
 	spinlock_t reglock;
 	char message[SNPS_EDAC_MSG_SIZE];
-	struct snps_ecc_status stat;
 };
 
 /**
@@ -692,130 +678,179 @@ static inline u32 snps_get_bitpos(u32 syndrome, enum snps_dq_width dq_width)
 }
 
 /**
- * snps_get_error_info - Get the current ECC error info.
- * @priv:	DDR memory controller private instance data.
+ * snps_ce_irq_handler - Corrected error interrupt handler.
+ * @irq:        IRQ number.
+ * @dev_id:     Device ID.
  *
- * Return: one if there is no error otherwise returns zero.
+ * Return: IRQ_NONE, if interrupt not set or IRQ_HANDLED otherwise.
  */
-static int snps_get_error_info(struct snps_edac_priv *priv)
+static irqreturn_t snps_ce_irq_handler(int irq, void *dev_id)
 {
-	struct snps_ecc_status *p;
-	u32 regval, clearval;
+	struct mem_ctl_info *mci = dev_id;
+	struct snps_edac_priv *priv = mci->pvt_info;
+	struct snps_ecc_error_info einfo;
 	unsigned long flags;
-	void __iomem *base;
-
-	base = priv->baseaddr;
-	p = &priv->stat;
+	u32 qosval, regval;
+	dma_addr_t sys;
 
-	regval = readl(base + ECC_STAT_OFST);
-	if (!regval)
-		return 1;
+	/* Make sure IRQ is caused by a corrected ECC error */
+	if (priv->info.caps & SNPS_CAP_ZYNQMP) {
+		qosval = readl(priv->baseaddr + ZYNQMP_DDR_QOS_IRQ_STAT_OFST);
+		if (!(qosval & ZYNQMP_DDR_QOS_CE_MASK))
+			return IRQ_NONE;
 
-	p->ceinfo.syndrome = FIELD_GET(ECC_STAT_BITNUM_MASK, regval);
+		qosval &= ZYNQMP_DDR_QOS_CE_MASK;
+	}
 
-	regval = readl(base + ECC_ERRCNT_OFST);
-	p->ce_cnt = FIELD_GET(ECC_ERRCNT_CECNT_MASK, regval);
-	p->ue_cnt = FIELD_GET(ECC_ERRCNT_UECNT_MASK, regval);
-	if (!p->ce_cnt)
-		goto ue_err;
+	regval = readl(priv->baseaddr + ECC_STAT_OFST);
+	if (!FIELD_GET(ECC_STAT_CE_MASK, regval))
+		return IRQ_NONE;
 
-	p->ceinfo.bitpos = snps_get_bitpos(p->ceinfo.syndrome, priv->info.dq_width);
+	/* Read error info like syndrome, bit position, SDRAM address, data */
+	einfo.syndrome = FIELD_GET(ECC_STAT_BITNUM_MASK, regval);
 
-	regval = readl(base + ECC_CEADDR0_OFST);
-	p->ceinfo.sdram.rank = FIELD_GET(ECC_CEADDR0_RANK_MASK, regval);
-	p->ceinfo.sdram.row = FIELD_GET(ECC_CEADDR0_ROW_MASK, regval);
+	einfo.bitpos = snps_get_bitpos(einfo.syndrome, priv->info.dq_width);
 
-	regval = readl(base + ECC_CEADDR1_OFST);
-	p->ceinfo.sdram.bankgrp = FIELD_GET(ECC_CEADDR1_BANKGRP_MASK, regval);
-	p->ceinfo.sdram.bank = FIELD_GET(ECC_CEADDR1_BANK_MASK, regval);
-	p->ceinfo.sdram.col = FIELD_GET(ECC_CEADDR1_COL_MASK, regval);
+	regval = readl(priv->baseaddr + ECC_ERRCNT_OFST);
+	einfo.ecnt = FIELD_GET(ECC_ERRCNT_CECNT_MASK, regval);
 
-	p->ceinfo.data = readl(base + ECC_CSYND0_OFST);
-	if (priv->info.dq_width == SNPS_DQ_64)
-		p->ceinfo.data |= (u64)readl(base + ECC_CSYND1_OFST) << 32;
+	regval = readl(priv->baseaddr + ECC_CEADDR0_OFST);
+	einfo.sdram.rank = FIELD_GET(ECC_CEADDR0_RANK_MASK, regval);
+	einfo.sdram.row = FIELD_GET(ECC_CEADDR0_ROW_MASK, regval);
 
-	p->ceinfo.ecc = readl(base + ECC_CSYND2_OFST);
+	regval = readl(priv->baseaddr + ECC_CEADDR1_OFST);
+	einfo.sdram.bankgrp = FIELD_GET(ECC_CEADDR1_BANKGRP_MASK, regval);
+	einfo.sdram.bank = FIELD_GET(ECC_CEADDR1_BANK_MASK, regval);
+	einfo.sdram.col = FIELD_GET(ECC_CEADDR1_COL_MASK, regval);
 
-ue_err:
-	if (!p->ue_cnt)
-		goto out;
+	einfo.data = readl(priv->baseaddr + ECC_CSYND0_OFST);
+	if (priv->info.dq_width == SNPS_DQ_64)
+		einfo.data |= (u64)readl(priv->baseaddr + ECC_CSYND1_OFST) << 32;
 
-	regval = readl(base + ECC_UEADDR0_OFST);
-	p->ueinfo.sdram.rank = FIELD_GET(ECC_CEADDR0_RANK_MASK, regval);
-	p->ueinfo.sdram.row = FIELD_GET(ECC_CEADDR0_ROW_MASK, regval);
+	einfo.ecc = readl(priv->baseaddr + ECC_CSYND2_OFST);
 
-	regval = readl(base + ECC_UEADDR1_OFST);
-	p->ueinfo.sdram.bankgrp = FIELD_GET(ECC_CEADDR1_BANKGRP_MASK, regval);
-	p->ueinfo.sdram.bank = FIELD_GET(ECC_CEADDR1_BANK_MASK, regval);
-	p->ueinfo.sdram.col = FIELD_GET(ECC_CEADDR1_COL_MASK, regval);
+	/* Report the detected errors with the corresponding sys address */
+	snps_map_sdram_to_sys(priv, &einfo.sdram, &sys);
 
-	p->ueinfo.data = readl(base + ECC_UESYND0_OFST);
-	if (priv->info.dq_width == SNPS_DQ_64)
-		p->ueinfo.data |= (u64)readl(base + ECC_UESYND1_OFST) << 32;
+	snprintf(priv->message, SNPS_EDAC_MSG_SIZE,
+		 "Row %hu Col %hu Bank %hhu Bank Group %hhu Rank %hhu Bit %d Data 0x%08llx:0x%02x",
+		 einfo.sdram.row, einfo.sdram.col, einfo.sdram.bank,
+		 einfo.sdram.bankgrp, einfo.sdram.rank,
+		 einfo.bitpos, einfo.data, einfo.ecc);
 
-	p->ueinfo.ecc = readl(base + ECC_UESYND2_OFST);
+	edac_mc_handle_error(HW_EVENT_ERR_CORRECTED, mci, einfo.ecnt,
+			     PHYS_PFN(sys), offset_in_page(sys),
+			     einfo.syndrome, einfo.sdram.rank, 0, -1,
+			     priv->message, "");
 
-out:
+	/* Make sure the CE IRQ status is cleared */
 	spin_lock_irqsave(&priv->reglock, flags);
 
-	clearval = readl(base + ECC_CLR_OFST) |
-		   ECC_CTRL_CLR_CE_ERR | ECC_CTRL_CLR_CE_ERRCNT |
-		   ECC_CTRL_CLR_UE_ERR | ECC_CTRL_CLR_UE_ERRCNT;
-	writel(clearval, base + ECC_CLR_OFST);
+	regval = readl(priv->baseaddr + ECC_CLR_OFST) |
+		 ECC_CTRL_CLR_CE_ERR | ECC_CTRL_CLR_CE_ERRCNT;
+	writel(regval, priv->baseaddr + ECC_CLR_OFST);
 
 	spin_unlock_irqrestore(&priv->reglock, flags);
 
-	return 0;
+	if (priv->info.caps & SNPS_CAP_ZYNQMP)
+		writel(qosval, priv->baseaddr + ZYNQMP_DDR_QOS_IRQ_STAT_OFST);
+
+	return IRQ_HANDLED;
 }
 
 /**
- * snps_handle_error - Handle Correctable and Uncorrectable errors.
- * @mci:	EDAC memory controller instance.
- * @p:		Synopsys ECC status structure.
+ * snps_ue_irq_handler - Uncorrected error interrupt handler.
+ * @irq:        IRQ number.
+ * @dev_id:     Device ID.
  *
- * Handles ECC correctable and uncorrectable errors.
+ * Return: IRQ_NONE, if interrupt not set or IRQ_HANDLED otherwise.
  */
-static void snps_handle_error(struct mem_ctl_info *mci, struct snps_ecc_status *p)
+static irqreturn_t snps_ue_irq_handler(int irq, void *dev_id)
 {
+	struct mem_ctl_info *mci = dev_id;
 	struct snps_edac_priv *priv = mci->pvt_info;
-	struct snps_ecc_error_info *pinf;
+	struct snps_ecc_error_info einfo;
+	unsigned long flags;
+	u32 qosval, regval;
 	dma_addr_t sys;
 
-	if (p->ce_cnt) {
-		pinf = &p->ceinfo;
+	/* Make sure IRQ is caused by an uncorrected ECC error */
+	if (priv->info.caps & SNPS_CAP_ZYNQMP) {
+		qosval = readl(priv->baseaddr + ZYNQMP_DDR_QOS_IRQ_STAT_OFST);
+		if (!(regval & ZYNQMP_DDR_QOS_UE_MASK))
+			return IRQ_NONE;
 
-		snps_map_sdram_to_sys(priv, &pinf->sdram, &sys);
+		qosval &= ZYNQMP_DDR_QOS_UE_MASK;
+	}
 
-		snprintf(priv->message, SNPS_EDAC_MSG_SIZE,
-			 "Row %hu Col %hu Bank %hhu Bank Group %hhu Rank %hhu Bit %d Data 0x%08llx:0x%02x",
-			 pinf->sdram.row, pinf->sdram.col, pinf->sdram.bank,
-			 pinf->sdram.bankgrp, pinf->sdram.rank,
-			 pinf->bitpos, pinf->data, pinf->ecc);
+	regval = readl(priv->baseaddr + ECC_STAT_OFST);
+	if (!FIELD_GET(ECC_STAT_UE_MASK, regval))
+		return IRQ_NONE;
 
-		edac_mc_handle_error(HW_EVENT_ERR_CORRECTED, mci, p->ce_cnt,
-				     PHYS_PFN(sys), offset_in_page(sys),
-				     pinf->syndrome, pinf->sdram.rank, 0, -1,
-				     priv->message, "");
-	}
+	/* Read error info like SDRAM address, data and syndrome */
+	regval = readl(priv->baseaddr + ECC_ERRCNT_OFST);
+	einfo.ecnt = FIELD_GET(ECC_ERRCNT_UECNT_MASK, regval);
 
-	if (p->ue_cnt) {
-		pinf = &p->ueinfo;
+	regval = readl(priv->baseaddr + ECC_UEADDR0_OFST);
+	einfo.sdram.rank = FIELD_GET(ECC_CEADDR0_RANK_MASK, regval);
+	einfo.sdram.row = FIELD_GET(ECC_CEADDR0_ROW_MASK, regval);
 
-		snps_map_sdram_to_sys(priv, &pinf->sdram, &sys);
+	regval = readl(priv->baseaddr + ECC_UEADDR1_OFST);
+	einfo.sdram.bankgrp = FIELD_GET(ECC_CEADDR1_BANKGRP_MASK, regval);
+	einfo.sdram.bank = FIELD_GET(ECC_CEADDR1_BANK_MASK, regval);
+	einfo.sdram.col = FIELD_GET(ECC_CEADDR1_COL_MASK, regval);
 
-		snprintf(priv->message, SNPS_EDAC_MSG_SIZE,
-			 "Row %hu Col %hu Bank %hhu Bank Group %hhu Rank %hhu Data 0x%08llx:0x%02x",
-			 pinf->sdram.row, pinf->sdram.col, pinf->sdram.bank,
-			 pinf->sdram.bankgrp, pinf->sdram.rank,
-			 pinf->data, pinf->ecc);
+	einfo.data = readl(priv->baseaddr + ECC_UESYND0_OFST);
+	if (priv->info.dq_width == SNPS_DQ_64)
+		einfo.data |= (u64)readl(priv->baseaddr + ECC_UESYND1_OFST) << 32;
 
-		edac_mc_handle_error(HW_EVENT_ERR_UNCORRECTED, mci, p->ue_cnt,
-				     PHYS_PFN(sys), offset_in_page(sys),
-				     0, pinf->sdram.rank, 0, -1,
-				     priv->message, "");
-	}
+	einfo.ecc = readl(priv->baseaddr + ECC_UESYND2_OFST);
+
+	/* Report the detected errors with the corresponding sys address */
+	snps_map_sdram_to_sys(priv, &einfo.sdram, &sys);
+
+	snprintf(priv->message, SNPS_EDAC_MSG_SIZE,
+		 "Row %hu Col %hu Bank %hhu Bank Group %hhu Rank %hhu Data 0x%08llx:0x%02x",
+		 einfo.sdram.row, einfo.sdram.col, einfo.sdram.bank,
+		 einfo.sdram.bankgrp, einfo.sdram.rank,
+		 einfo.data, einfo.ecc);
+
+	edac_mc_handle_error(HW_EVENT_ERR_UNCORRECTED, mci, einfo.ecnt,
+			     PHYS_PFN(sys), offset_in_page(sys),
+			     0, einfo.sdram.rank, 0, -1,
+			     priv->message, "");
+
+	/* Make sure the UE IRQ status is cleared */
+	spin_lock_irqsave(&priv->reglock, flags);
 
-	memset(p, 0, sizeof(*p));
+	regval = readl(priv->baseaddr + ECC_CLR_OFST) |
+		 ECC_CTRL_CLR_UE_ERR | ECC_CTRL_CLR_UE_ERRCNT;
+	writel(regval, priv->baseaddr + ECC_CLR_OFST);
+
+	spin_unlock_irqrestore(&priv->reglock, flags);
+
+	if (priv->info.caps & SNPS_CAP_ZYNQMP)
+		writel(qosval, priv->baseaddr + ZYNQMP_DDR_QOS_IRQ_STAT_OFST);
+
+	return IRQ_HANDLED;
+}
+
+/**
+ * snps_com_irq_handler - Interrupt IRQ signal handler.
+ * @irq:        IRQ number.
+ * @dev_id:     Device ID.
+ *
+ * Return: IRQ_NONE, if interrupts not set or IRQ_HANDLED otherwise.
+ */
+static irqreturn_t snps_com_irq_handler(int irq, void *dev_id)
+{
+	irqreturn_t rc = IRQ_NONE;
+
+	rc |= snps_ce_irq_handler(irq, dev_id);
+
+	rc |= snps_ue_irq_handler(irq, dev_id);
+
+	return rc;
 }
 
 static void snps_enable_irq(struct snps_edac_priv *priv)
@@ -861,40 +896,6 @@ static void snps_disable_irq(struct snps_edac_priv *priv)
 	spin_unlock_irqrestore(&priv->reglock, flags);
 }
 
-/**
- * snps_irq_handler - Interrupt Handler for ECC interrupts.
- * @irq:        IRQ number.
- * @dev_id:     Device ID.
- *
- * Return: IRQ_NONE, if interrupt not set or IRQ_HANDLED otherwise.
- */
-static irqreturn_t snps_irq_handler(int irq, void *dev_id)
-{
-	struct mem_ctl_info *mci = dev_id;
-	struct snps_edac_priv *priv;
-	int status, regval;
-
-	priv = mci->pvt_info;
-
-	if (priv->info.caps & SNPS_CAP_ZYNQMP) {
-		regval = readl(priv->baseaddr + ZYNQMP_DDR_QOS_IRQ_STAT_OFST);
-		regval &= (ZYNQMP_DDR_QOS_CE_MASK | ZYNQMP_DDR_QOS_UE_MASK);
-		if (!(regval & ZYNQMP_DDR_QOS_IRQ_MASK))
-			return IRQ_NONE;
-	}
-
-	status = snps_get_error_info(priv);
-	if (status)
-		return IRQ_NONE;
-
-	snps_handle_error(mci, &priv->stat);
-
-	if (priv->info.caps & SNPS_CAP_ZYNQMP)
-		writel(regval, priv->baseaddr + ZYNQMP_DDR_QOS_IRQ_STAT_OFST);
-
-	return IRQ_HANDLED;
-}
-
 /**
  * snps_create_data - Create private data.
  * @pdev:	platform device.
@@ -1544,7 +1545,7 @@ static int snps_setup_irq(struct mem_ctl_info *mci)
 		return irq;
 	}
 
-	ret = devm_request_irq(&priv->pdev->dev, irq, snps_irq_handler,
+	ret = devm_request_irq(&priv->pdev->dev, irq, snps_com_irq_handler,
 			       0, dev_name(&priv->pdev->dev), mci);
 	if (ret < 0) {
 		edac_printk(KERN_ERR, EDAC_MC, "Failed to request IRQ\n");
-- 
2.41.0

