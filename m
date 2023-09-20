Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 014F47A8C57
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 21:12:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229980AbjITTMC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 15:12:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229931AbjITTLw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 15:11:52 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4818412D;
        Wed, 20 Sep 2023 12:11:38 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id 2adb3069b0e04-5029ace4a28so1528915e87.1;
        Wed, 20 Sep 2023 12:11:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695237096; x=1695841896; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g/PgPh5sPZyXwcbz4sY57Qw/OU8U8ZUgcMaSG4iKyvE=;
        b=nB4AXPrddujuNKy5jQLUYyUI9hMdAmumQexWqbDSQlf6EIHBsjNuPjiuNqSB5SiGW0
         3r4MttnunEe8WoL3YDnX4a55wMNleW04TLvb6ncCmWto7aGmWGXHdveksYusdBvAXfPb
         EaHqLWZGPEedYHUC15u/d06BuOgrka6w5ExLhaGavSiQZ4kjVTlL2fSEPE//q08pG0pQ
         CC1bLqVlLCGN7vKqMK5mGa3CZum4uG/xc7E53sFiTNNgn4CoUrksQV2X8ZYaoQf1vIJ6
         ibL0Hx3tdM6apS9A4i6B46lGZvy7YsKZyg5lFww3GSTEsBH6l4OKeEt5iqFK44JDlSD9
         ajtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695237096; x=1695841896;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g/PgPh5sPZyXwcbz4sY57Qw/OU8U8ZUgcMaSG4iKyvE=;
        b=kVxVRnvUT9uF35rc/f0QoJ9FZzIA3VQGrW+16gNkIjVJKFdcXyxPBz/8SpJ73hywdl
         Bmroi0Ci4gl+R1Lq6Twrg2rNZKj3r7KjD6M7OPKgWvwH857rUc1xhe2r5cmAidgMeeK8
         DPOCBTx/IIStyw1zGte9u0mgrJxF7My/n87BnPV3Njr/nrjpa7d1wuC6MP8cF3G0a7Zv
         6jYsVcdT7vqIj6KoT7O6CZchPgvge3wfUPuLe7N+h19EwlS0XtW5nVhHY8RRTMFbIo74
         3yRQBUiMT3xh9XqamNWHxnLRfiDr7AVYzbx04SkNw45kxFVbO9WSh2OuaybsBburfah3
         oeag==
X-Gm-Message-State: AOJu0Yw8WFkgmOPIuLAJk17N115TGKDIALSv64B20mI0zwSuaYC3VQsC
        yML5rBCXm6J0TNKYuYl5VfQ=
X-Google-Smtp-Source: AGHT+IEDIiDK7CgmtB4B+46SFZtMQjWuYlM6G02VWa53gldppwcj2pHHhHCKaonmqX8XKSUDgAKvfw==
X-Received: by 2002:a19:ca06:0:b0:4f9:dac6:2f3d with SMTP id a6-20020a19ca06000000b004f9dac62f3dmr1187010lfg.13.1695237096386;
        Wed, 20 Sep 2023 12:11:36 -0700 (PDT)
Received: from localhost ([85.26.233.163])
        by smtp.gmail.com with ESMTPSA id v12-20020ac2592c000000b005041e5023f4sm269084lfi.307.2023.09.20.12.11.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Sep 2023 12:11:35 -0700 (PDT)
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
Subject: [PATCH v4 06/20] EDAC/synopsys: Fix misleading IRQ self-cleared quirk flag
Date:   Wed, 20 Sep 2023 22:10:30 +0300
Message-ID: <20230920191059.28395-7-fancer.lancer@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230920191059.28395-1-fancer.lancer@gmail.com>
References: <20230920191059.28395-1-fancer.lancer@gmail.com>
MIME-Version: 1.0
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

The DDR_ECC_INTR_SELF_CLEAR quirk flag was initially added in the commit
f7824ded4149 ("EDAC/synopsys: Add support for version 3 of the Synopsys
EDAC DDR") in order to distinguish the ZynqMP DDRC (based on DW uMCTL2
DDRC v2.40a) and the announced in that commit Synopsys DDR controller
v3.80a. The selected name is misleading for the next reasons:

1. None of the Synopsys DW uMCTL2 DDR IP-core has the UE/CE IRQs
auto or self cleared. The IRQ signals (ecc_corrected_err_intr and
ecc_uncorrected_err_intr) are cleared together with the rest of the ECC
error data by means of writing 1's to the respective ECCCLR bits. It
worked like that in DW uMCTL2 DDRC v2.x IP-core and it's still true for
the modern DW uMCTL2 DDRC v3.x.

2. The IRQ-related registers accessed unless the denoted quirk is
specified are actually Xilinx Zynq-specific. None of the Synopsys DW uMCTL
DDRC IP-core have any registers at the offsets 0x20200/0x20208/0x2020C.
The most modern DW uMCTL2 DDRC v3.91a IP-core available has CSRs space end
at the 0x43dc offset. The older IP-cores have even smaller registers
space.

3. What was actually introduced in the DW uMCTL2 DDRC v3.10 by Synopsys is
the IRQ enable flags which older DW uMCTL2 DDRC IP-core didn't have. They
were added to the ECCCLR register (the CSR was also renamed to ECCCTL in
the v3.10 IP-core HW databook). So since then there have been no point in
having a vendor-specific IRQs masking solution like described in 2. and
the IRQ signal can be now shared even for the native DW uMCTL2 DDR
controllers.

So let's harmonize the quirked IRQs code based on the statements above:
rename the DDR_ECC_INTR_SELF_CLEAR quirk flag to SYNPS_ZYNQMP_IRQ_REGS
thus indicating the ZynqMP-specific IRQ CSRs; add the new quirk flag to
the ZynqMP platform data; drop the misleading comments about the
auto-cleared ue/ce flags; add a comment about the new IRQ enable flags
added in v3.10 IP-core.

Signed-off-by: Serge Semin <fancer.lancer@gmail.com>

---

Changelog v4:
- This is a new patch detached from
  [PATCH v3 01/17] EDAC/synopsys: Fix native uMCTL2 IRQs handling procedure
---
 drivers/edac/synopsys_edac.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/edac/synopsys_edac.c b/drivers/edac/synopsys_edac.c
index fff4b07ff6ac..6b81ac9dda8b 100644
--- a/drivers/edac/synopsys_edac.c
+++ b/drivers/edac/synopsys_edac.c
@@ -89,7 +89,7 @@
 /* DDR ECC Quirks */
 #define DDR_ECC_INTR_SUPPORT		BIT(0)
 #define DDR_ECC_DATA_POISON_SUPPORT	BIT(1)
-#define DDR_ECC_INTR_SELF_CLEAR		BIT(2)
+#define SYNPS_ZYNQMP_IRQ_REGS		BIT(2)
 
 /* ZynqMP Enhanced DDR memory controller registers that are relevant to ECC */
 /* ECC Configuration Registers */
@@ -527,7 +527,7 @@ static void enable_intr(struct synps_edac_priv *priv)
 	unsigned long flags;
 
 	/* Enable UE/CE Interrupts */
-	if (!(priv->p_data->quirks & DDR_ECC_INTR_SELF_CLEAR)) {
+	if (priv->p_data->quirks & SYNPS_ZYNQMP_IRQ_REGS) {
 		writel(DDR_QOSUE_MASK | DDR_QOSCE_MASK,
 		       priv->baseaddr + DDR_QOS_IRQ_EN_OFST);
 
@@ -536,6 +536,10 @@ static void enable_intr(struct synps_edac_priv *priv)
 
 	spin_lock_irqsave(&priv->reglock, flags);
 
+	/*
+	 * IRQs Enable/Disable flags have been available since v3.10a.
+	 * This is noop for the older controllers.
+	 */
 	writel(DDR_UE_MASK | DDR_CE_MASK,
 	       priv->baseaddr + ECC_CLR_OFST);
 
@@ -547,7 +551,7 @@ static void disable_intr(struct synps_edac_priv *priv)
 	unsigned long flags;
 
 	/* Disable UE/CE Interrupts */
-	if (!(priv->p_data->quirks & DDR_ECC_INTR_SELF_CLEAR)) {
+	if (priv->p_data->quirks & SYNPS_ZYNQMP_IRQ_REGS) {
 		writel(DDR_QOSUE_MASK | DDR_QOSCE_MASK,
 		       priv->baseaddr + DDR_QOS_IRQ_DB_OFST);
 
@@ -578,11 +582,7 @@ static irqreturn_t intr_handler(int irq, void *dev_id)
 	priv = mci->pvt_info;
 	p_data = priv->p_data;
 
-	/*
-	 * v3.0 of the controller has the ce/ue bits cleared automatically,
-	 * so this condition does not apply.
-	 */
-	if (!(priv->p_data->quirks & DDR_ECC_INTR_SELF_CLEAR)) {
+	if (priv->p_data->quirks & SYNPS_ZYNQMP_IRQ_REGS) {
 		regval = readl(priv->baseaddr + DDR_QOS_IRQ_STAT_OFST);
 		regval &= (DDR_QOSCE_MASK | DDR_QOSUE_MASK);
 		if (!(regval & ECC_CE_UE_INTR_MASK))
@@ -599,8 +599,8 @@ static irqreturn_t intr_handler(int irq, void *dev_id)
 
 	edac_dbg(3, "Total error count CE %d UE %d\n",
 		 priv->ce_cnt, priv->ue_cnt);
-	/* v3.0 of the controller does not have this register */
-	if (!(priv->p_data->quirks & DDR_ECC_INTR_SELF_CLEAR))
+
+	if (priv->p_data->quirks & SYNPS_ZYNQMP_IRQ_REGS)
 		writel(regval, priv->baseaddr + DDR_QOS_IRQ_STAT_OFST);
 
 	return IRQ_HANDLED;
@@ -914,7 +914,7 @@ static const struct synps_platform_data zynqmp_edac_def = {
 	.get_mtype	= zynqmp_get_mtype,
 	.get_dtype	= zynqmp_get_dtype,
 	.get_ecc_state	= zynqmp_get_ecc_state,
-	.quirks         = (DDR_ECC_INTR_SUPPORT
+	.quirks         = (DDR_ECC_INTR_SUPPORT | SYNPS_ZYNQMP_IRQ_REGS
 #ifdef CONFIG_EDAC_DEBUG
 			  | DDR_ECC_DATA_POISON_SUPPORT
 #endif
@@ -926,7 +926,7 @@ static const struct synps_platform_data synopsys_edac_def = {
 	.get_mtype	= zynqmp_get_mtype,
 	.get_dtype	= zynqmp_get_dtype,
 	.get_ecc_state	= zynqmp_get_ecc_state,
-	.quirks         = (DDR_ECC_INTR_SUPPORT | DDR_ECC_INTR_SELF_CLEAR
+	.quirks         = (DDR_ECC_INTR_SUPPORT
 #ifdef CONFIG_EDAC_DEBUG
 			  | DDR_ECC_DATA_POISON_SUPPORT
 #endif
-- 
2.41.0

