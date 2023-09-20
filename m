Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AF9C7A8D57
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 21:58:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230316AbjITT6g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 15:58:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230253AbjITT61 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 15:58:27 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0744182;
        Wed, 20 Sep 2023 12:58:18 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id 2adb3069b0e04-50317080342so452427e87.2;
        Wed, 20 Sep 2023 12:58:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695239897; x=1695844697; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rqEe+qJgx61qRBdp0o0EWDtgMqHxW6fXEHdd+fQxFOk=;
        b=IGJ+E1bKtCyxY50MOTnxFEyMHrXQmz2uBl0bCxTHi9QIvTGqFT7WXDmBFa2pfitUQ4
         azX+ufZ6gzwUjJSZA3JBX1fqRRAhvRN8mOd36z2zbz9WozjQb5NUapoqUCZeOU3ca6P4
         dLKWGha/07RO1S7+OBdhCSEQsNoZAHztGArcnZUhEysIS8wgYIiuXZw1KchDCWfBaFoo
         xvqpm47J21+7NOq2HxVgiKrk8bWwzp9Zk4IPPvZKePAKhXLX6KGG9HmEDyzxpv21Y5XH
         YN+EF4Al3ZgkEqebHXdoImK0XEeUKa6aVH8tJYGM4rpneLDnLFSL9vE21dtEJwAcbDt6
         5fuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695239897; x=1695844697;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rqEe+qJgx61qRBdp0o0EWDtgMqHxW6fXEHdd+fQxFOk=;
        b=HrzQk9pTCY53ZFfv1yOcHdbE3Nv/fWrNKMnuSK28GuWUBe3UWD7U6qzZCvhzD/iLqI
         EL5dp5GTgFAG7zQa/nxYG99QitmwD3290od1VvP3pLBz2grvvb0NLeRhpHkuIU0gazwA
         5njvKU2c1nZvukp68UPjRn8vHVVWSpGklbrj6jGCWLGrMyxHTyg6VMqdHtOsd4JqRHBZ
         VTBl2MklfCIR6OyF6ui2Yr0+AUtJrljdTK3GGsS+HndNCDGHeW9bxveBg1BVDsLrmCm/
         7CgOptNQeVyW/nmjYh6BNn4ApTtkCFgoxqXuNY1hAdSOcPN13TCvX9/BPnlnHBCp4RvI
         llTg==
X-Gm-Message-State: AOJu0Yy3E39FF9yw87ya5h0QcB2zlGjK5g2oEPHgc7LgLt1d5gjZjt7a
        /ayVmONeZrUCaci/tFro0ZQ=
X-Google-Smtp-Source: AGHT+IGwY8u6l1p0TGV3JPIkKcZKiKXWZjFlTGcyVkMLtSsxwqdocI2ws1Dp/Q1id6zbm9iA/Ghwfw==
X-Received: by 2002:a05:6512:1186:b0:503:8fa:da21 with SMTP id g6-20020a056512118600b0050308fada21mr2891153lfr.43.1695239896763;
        Wed, 20 Sep 2023 12:58:16 -0700 (PDT)
Received: from localhost ([85.26.234.143])
        by smtp.gmail.com with ESMTPSA id q12-20020ac25a0c000000b004fb7359ab83sm2806302lfn.80.2023.09.20.12.58.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Sep 2023 12:58:16 -0700 (PDT)
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
Subject: [PATCH v4 09/13] EDAC/synopsys: Add DFI alert_n IRQ support
Date:   Wed, 20 Sep 2023 22:56:40 +0300
Message-ID: <20230920195720.32047-10-fancer.lancer@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230920195720.32047-1-fancer.lancer@gmail.com>
References: <20230920195720.32047-1-fancer.lancer@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In accordance with [1] DW uMCTL2 DDR controller can generate an IRQ in
case if an attached SDRAM detects a CRC/Parity error. That capability is
mainly applicable for the DDR4 memory which has an additional signals
PARITY/ALERT_n indicating the even SDRAM address/command parity signal and
alert if the parity turns to be not even. But in accordance with [1] at
least the SDRAM address/command parity is calculated irrespective of the
memory protocol and then sent out by means of the dfi_parity_n signal
further to the DDR PHY. So depending on the DDR protocol and the DDR PHY
implementation the CRC/Parity error can be checked at some point
independently from the DDR devices type and then signaled via the
dfi_alert_n line. In anycase it would be very much useful to catch the
event and at least warn the user about problems with the DFI/SDRAM signals
integrity.

So add the DFI CRC/Parity IRQs handling support in the next manner. First
the IRQ line is requested by the name "dfi_e" (defined in the DT-bindings)
and register its handler in case of the platform with the individual DW
uMCTL2 DDRC IRQs. If individual IRQs are unavailable the common IRQ
handler will call the DFI CRC/Parity event handler. Note the handler just
checks the IRQ status, reads the number of errors, reports the fatal error
to the MCI core and clears the IRQ status. Alas neither the erroneous
SDRAM address nor the executed command are available in this case. Second
the DFI CRC/Parity IRQ is enabled/disabled together with the ECC CE/UE
interrupts in the controller probe procedure. Finally the CRC/Parity
capability is advertised by the EDAC controller capabilities flags.

[1] DesignWare® Cores Enhanced Universal DDR Memory Controller (uMCTL2)
    Databook, Version 3.91a, October 2020, p.131-132

Signed-off-by: Serge Semin <fancer.lancer@gmail.com>
---
 drivers/edac/synopsys_edac.c | 78 +++++++++++++++++++++++++++++++++++-
 1 file changed, 76 insertions(+), 2 deletions(-)

diff --git a/drivers/edac/synopsys_edac.c b/drivers/edac/synopsys_edac.c
index 19b7bce06e13..a91b048facb6 100644
--- a/drivers/edac/synopsys_edac.c
+++ b/drivers/edac/synopsys_edac.c
@@ -80,6 +80,12 @@
 #define ECC_POISON0_OFST		0xB8
 #define ECC_POISON1_OFST		0xBC
 
+/* DDR CRC/Parity Registers */
+#define DDR_CRCPARCTL0_OFST		0xC0
+#define DDR_CRCPARCTL1_OFST		0xC4
+#define DDR_CRCPARCTL2_OFST		0xC8
+#define DDR_CRCPARSTAT_OFST		0xCC
+
 /* DDR Address Map Registers */
 #define DDR_ADDRMAP0_OFST		0x200
 
@@ -151,6 +157,13 @@
 #define ECC_CEADDR1_BANK_MASK		GENMASK(23, 16)
 #define ECC_CEADDR1_COL_MASK		GENMASK(11, 0)
 
+/* DDR CRC/Parity register definitions */
+#define DDR_CRCPARCTL0_CLR_ALRT_ERRCNT	BIT(2)
+#define DDR_CRCPARCTL0_CLR_ALRT_ERR	BIT(1)
+#define DDR_CRCPARCTL0_EN_ALRT_IRQ	BIT(0)
+#define DDR_CRCPARSTAT_ALRT_ERR		BIT(16)
+#define DDR_CRCPARSTAT_ALRT_CNT_MASK	GENMASK(15, 0)
+
 /* ECC Poison register definitions */
 #define ECC_POISON0_RANK_MASK		GENMASK(27, 24)
 #define ECC_POISON0_COL_MASK		GENMASK(11, 0)
@@ -835,6 +848,48 @@ static irqreturn_t snps_ue_irq_handler(int irq, void *dev_id)
 	return IRQ_HANDLED;
 }
 
+/**
+ * snps_dfi_irq_handler - DFI CRC/Parity error interrupt handler.
+ * @irq:        IRQ number.
+ * @dev_id:     Device ID.
+ *
+ * Return: IRQ_NONE, if interrupt not set or IRQ_HANDLED otherwise.
+ */
+static irqreturn_t snps_dfi_irq_handler(int irq, void *dev_id)
+{
+	struct mem_ctl_info *mci = dev_id;
+	struct snps_edac_priv *priv = mci->pvt_info;
+	unsigned long flags;
+	u32 regval;
+	u16 ecnt;
+
+	/* Make sure IRQ is caused by an DFI alert error */
+	regval = readl(priv->baseaddr + DDR_CRCPARSTAT_OFST);
+	if (!(regval & DDR_CRCPARSTAT_ALRT_ERR))
+		return IRQ_NONE;
+
+	/* Just a number of CRC/Parity errors is available */
+	ecnt = FIELD_GET(DDR_CRCPARSTAT_ALRT_CNT_MASK, regval);
+
+	/* Report the detected errors with just the custom message */
+	snprintf(priv->message, SNPS_EDAC_MSG_SIZE,
+		 "DFI CRC/Parity error detected on dfi_alert_n");
+
+	edac_mc_handle_error(HW_EVENT_ERR_FATAL, mci, ecnt,
+			     0, 0, 0, 0, 0, -1, priv->message, "");
+
+	/* Make sure the DFI alert IRQ status is cleared */
+	spin_lock_irqsave(&priv->reglock, flags);
+
+	regval = readl(priv->baseaddr + DDR_CRCPARCTL0_OFST) |
+		 DDR_CRCPARCTL0_CLR_ALRT_ERR | DDR_CRCPARCTL0_CLR_ALRT_ERRCNT;
+	writel(regval, priv->baseaddr + DDR_CRCPARCTL0_OFST);
+
+	spin_unlock_irqrestore(&priv->reglock, flags);
+
+	return IRQ_HANDLED;
+}
+
 /**
  * snps_com_irq_handler - Interrupt IRQ signal handler.
  * @irq:        IRQ number.
@@ -850,6 +905,8 @@ static irqreturn_t snps_com_irq_handler(int irq, void *dev_id)
 
 	rc |= snps_ue_irq_handler(irq, dev_id);
 
+	rc |= snps_dfi_irq_handler(irq, dev_id);
+
 	return rc;
 }
 
@@ -874,6 +931,13 @@ static void snps_enable_irq(struct snps_edac_priv *priv)
 	writel(ECC_CTRL_EN_CE_IRQ | ECC_CTRL_EN_UE_IRQ,
 	       priv->baseaddr + ECC_CLR_OFST);
 
+	/*
+	 * CRC/Parity interrupts control has been available since v2.10a.
+	 * This is noop for the older controllers.
+	 */
+	writel(DDR_CRCPARCTL0_EN_ALRT_IRQ,
+	       priv->baseaddr + DDR_CRCPARCTL0_OFST);
+
 	spin_unlock_irqrestore(&priv->reglock, flags);
 }
 
@@ -892,6 +956,7 @@ static void snps_disable_irq(struct snps_edac_priv *priv)
 	spin_lock_irqsave(&priv->reglock, flags);
 
 	writel(0, priv->baseaddr + ECC_CLR_OFST);
+	writel(0, priv->baseaddr + DDR_CRCPARCTL0_OFST);
 
 	spin_unlock_irqrestore(&priv->reglock, flags);
 }
@@ -1492,7 +1557,8 @@ static struct mem_ctl_info *snps_mc_create(struct snps_edac_priv *priv)
 	mci->mtype_cap = MEM_FLAG_LPDDR | MEM_FLAG_DDR2 | MEM_FLAG_LPDDR2 |
 			 MEM_FLAG_DDR3 | MEM_FLAG_LPDDR3 |
 			 MEM_FLAG_DDR4 | MEM_FLAG_LPDDR4;
-	mci->edac_ctl_cap = EDAC_FLAG_NONE | EDAC_FLAG_SECDED;
+	mci->edac_ctl_cap = EDAC_FLAG_NONE | EDAC_FLAG_SECDED | EDAC_FLAG_PARITY;
+	mci->edac_cap = mci->edac_ctl_cap;
 
 	if (priv->info.caps & SNPS_CAP_ECC_SCRUB) {
 		mci->scrub_mode = SCRUB_HW_SRC;
@@ -1502,7 +1568,6 @@ static struct mem_ctl_info *snps_mc_create(struct snps_edac_priv *priv)
 		mci->scrub_cap = SCRUB_FLAG_SW_SRC;
 	}
 
-	mci->edac_cap = EDAC_FLAG_SECDED;
 	mci->ctl_name = "snps_umctl2_ddrc";
 	mci->dev_name = SNPS_EDAC_MOD_STRING;
 	mci->mod_name = SNPS_EDAC_MOD_VER;
@@ -1568,6 +1633,15 @@ static int snps_request_ind_irq(struct mem_ctl_info *mci)
 		return rc;
 	}
 
+	irq = platform_get_irq_byname_optional(priv->pdev, "dfi_e");
+	if (irq > 0) {
+		rc = devm_request_irq(dev, irq, snps_dfi_irq_handler, 0, "dfi_e", mci);
+		if (rc) {
+			edac_printk(KERN_ERR, EDAC_MC, "Failed to request DFI IRQ\n");
+			return rc;
+		}
+	}
+
 	return 0;
 }
 
-- 
2.41.0

