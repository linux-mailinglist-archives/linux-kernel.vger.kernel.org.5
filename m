Return-Path: <linux-kernel+bounces-77065-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 509578600D0
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 19:16:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 71A0B1C22E0B
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 18:16:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CFED15B0E6;
	Thu, 22 Feb 2024 18:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TppdV5Xa"
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70F2915A4B5;
	Thu, 22 Feb 2024 18:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708625675; cv=none; b=JsDxbPDWjI2rPxapdXBDLCLHvLnVzRP8eOdwI7LsN1jjC9MMSSEhzVUrmgbUXeYI86sPzBKGD0kNLTqGlrDG8ZekPDbznK2SgVlSLfvo7dnZ7tPLWTzpn953Chf/MZ5Q/1bJ1B1FlN3C5fnUHK2wIypuw3hlUb5yjrkzoBcttFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708625675; c=relaxed/simple;
	bh=kXbQACB+KFkeMCvTaXVUn5Y5yi2y3yQkWWEwhZ9kGvM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NJ84kzUNs0B8+FVUcvauHMo2tG+XJ5YxMEoOAjUj8g3VXCvVRU5ynF411WZQAzESCzvDXrjbvUDamWIfVa+6WwbBT12Rw0dHAQteDdJMn/FNGWS2GaVVCKU0eN375vtSU5biFFoWrkhW0To4N0J4gP9wcWAlNTnKoKdMHVUwZ+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TppdV5Xa; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2d23d301452so1069631fa.1;
        Thu, 22 Feb 2024 10:14:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708625672; x=1709230472; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FxFAh3uoI4mzu17nUzZOceQCxF3v8VnFVlLwfRIN1G8=;
        b=TppdV5Xa4Sk1qMpCRXmr4SidaOc5WZExBTT5AaW7Y48krUGYcGIKztfdSGxgR5j+Ng
         zcASqyyXGblHwAEN4Ul6hM4Xj5qGx3qHOC7qND1EU4PVSwPQbYJqZ6vRL4Ym8MWRiqld
         I2bu6weF8NTJyJf9onzhL4qy6hpPFNaIX7r1N6W3+42lwM4SdFB2XlIFarySZDx5NGIh
         UMwO62TK6L2LM/aR2YTKlr2PEuOyuwifmLW1/4mzA9UOCnCqBYbBKtRr1CbvAxJzRvSG
         a/l7F7/BAgNNM5iX16djOXJZl9Yt28zdq8m4nLsqttVpnKMmBkep7z6HyuXa+0J0eq5v
         Sqaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708625672; x=1709230472;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FxFAh3uoI4mzu17nUzZOceQCxF3v8VnFVlLwfRIN1G8=;
        b=hIgyDGdkh36jgVYgzptU5YF073mrCq3MaYmiRqk+K1ubIp26JKOIQ9GI3HvGWU6pT8
         g01tJ5K1eUaqjQac86gwQHyFJeT+hb+USsuyWcfriQdaAg0RfnHlbeJfG3GNn8LMyE44
         M1ofYQvi+cZgU2ilduExOx0Z69knbP+ZfSDAkyDfGYI8vlfTtifr2lirAEH+nOYfj0yC
         LsSsgxbnduF6S9LUX5pTBa4NRUD3QxCOblttXeENI2EAtwnAjhLkX0sZReiTYC+L87tF
         bbsXcuyP9d8+RKxDDeVuDheFypxlxp+kKm2hE5aBfUyuO9cC/WSApV9zbU379BkIwk4D
         MFxA==
X-Forwarded-Encrypted: i=1; AJvYcCVMGNLJ1rNbmtGlDIgaQnLdsxkFVgZmMGeIG35ZTPuv2Xgqp5w0Y3/dOkpcu/DxOapZ0miBlyQQO22kwYsjAqfJeIzf9sBuPh1C8nRL0VT0fdaaI9hqjz4MxquoSxNoTws6FihONGSzBQ==
X-Gm-Message-State: AOJu0YyrkaO2ySINUWl0/yz+UE/a9ELM2FwO+QDuwk3LsUY6SWy5sA5r
	Fp0pakmIeKrbSI+o87T5yLogmafguw5qaqucEHJKi49Okoj58Fdu
X-Google-Smtp-Source: AGHT+IEBxM0SCQ/qh7iQYAnlf4bfAWyykcK2D4qRb34ypGnhSJishMItFlRhuHiRMAC1rEyOZCuebA==
X-Received: by 2002:a05:651c:1311:b0:2d2:373b:5b15 with SMTP id u17-20020a05651c131100b002d2373b5b15mr7681787lja.43.1708625671643;
        Thu, 22 Feb 2024 10:14:31 -0800 (PST)
Received: from localhost ([178.176.56.174])
        by smtp.gmail.com with ESMTPSA id z8-20020a2e3508000000b002d0d5373290sm2350157ljz.4.2024.02.22.10.14.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Feb 2024 10:14:31 -0800 (PST)
From: Serge Semin <fancer.lancer@gmail.com>
To: Michal Simek <michal.simek@amd.com>,
	Alexander Stein <alexander.stein@ew.tq-group.com>,
	Borislav Petkov <bp@alien8.de>,
	Tony Luck <tony.luck@intel.com>,
	James Morse <james.morse@arm.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Robert Richter <rric@kernel.org>
Cc: Serge Semin <fancer.lancer@gmail.com>,
	Punnaiah Choudary Kalluri <punnaiah.choudary.kalluri@xilinx.com>,
	Dinh Nguyen <dinguyen@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v5 06/20] EDAC/synopsys: Fix misleading IRQ self-cleared quirk flag
Date: Thu, 22 Feb 2024 21:12:51 +0300
Message-ID: <20240222181324.28242-7-fancer.lancer@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240222181324.28242-1-fancer.lancer@gmail.com>
References: <20240222181324.28242-1-fancer.lancer@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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
index fbaf3d9ad517..9f79f14e57b2 100644
--- a/drivers/edac/synopsys_edac.c
+++ b/drivers/edac/synopsys_edac.c
@@ -88,7 +88,7 @@
 /* DDR ECC Quirks */
 #define DDR_ECC_INTR_SUPPORT		BIT(0)
 #define DDR_ECC_DATA_POISON_SUPPORT	BIT(1)
-#define DDR_ECC_INTR_SELF_CLEAR		BIT(2)
+#define SYNPS_ZYNQMP_IRQ_REGS		BIT(2)
 
 /* ZynqMP Enhanced DDR memory controller registers that are relevant to ECC */
 /* ECC Configuration Registers */
@@ -526,7 +526,7 @@ static void enable_intr(struct synps_edac_priv *priv)
 	unsigned long flags;
 
 	/* Enable UE/CE Interrupts */
-	if (!(priv->p_data->quirks & DDR_ECC_INTR_SELF_CLEAR)) {
+	if (priv->p_data->quirks & SYNPS_ZYNQMP_IRQ_REGS) {
 		writel(DDR_QOSUE_MASK | DDR_QOSCE_MASK,
 		       priv->baseaddr + DDR_QOS_IRQ_EN_OFST);
 
@@ -535,6 +535,10 @@ static void enable_intr(struct synps_edac_priv *priv)
 
 	spin_lock_irqsave(&priv->reglock, flags);
 
+	/*
+	 * IRQs Enable/Disable flags have been available since v3.10a.
+	 * This is noop for the older controllers.
+	 */
 	writel(DDR_UE_MASK | DDR_CE_MASK,
 	       priv->baseaddr + ECC_CLR_OFST);
 
@@ -546,7 +550,7 @@ static void disable_intr(struct synps_edac_priv *priv)
 	unsigned long flags;
 
 	/* Disable UE/CE Interrupts */
-	if (!(priv->p_data->quirks & DDR_ECC_INTR_SELF_CLEAR)) {
+	if (priv->p_data->quirks & SYNPS_ZYNQMP_IRQ_REGS) {
 		writel(DDR_QOSUE_MASK | DDR_QOSCE_MASK,
 		       priv->baseaddr + DDR_QOS_IRQ_DB_OFST);
 
@@ -577,11 +581,7 @@ static irqreturn_t intr_handler(int irq, void *dev_id)
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
@@ -598,8 +598,8 @@ static irqreturn_t intr_handler(int irq, void *dev_id)
 
 	edac_dbg(3, "Total error count CE %d UE %d\n",
 		 priv->ce_cnt, priv->ue_cnt);
-	/* v3.0 of the controller does not have this register */
-	if (!(priv->p_data->quirks & DDR_ECC_INTR_SELF_CLEAR))
+
+	if (priv->p_data->quirks & SYNPS_ZYNQMP_IRQ_REGS)
 		writel(regval, priv->baseaddr + DDR_QOS_IRQ_STAT_OFST);
 
 	return IRQ_HANDLED;
@@ -913,7 +913,7 @@ static const struct synps_platform_data zynqmp_edac_def = {
 	.get_mtype	= zynqmp_get_mtype,
 	.get_dtype	= zynqmp_get_dtype,
 	.get_ecc_state	= zynqmp_get_ecc_state,
-	.quirks         = (DDR_ECC_INTR_SUPPORT
+	.quirks         = (DDR_ECC_INTR_SUPPORT | SYNPS_ZYNQMP_IRQ_REGS
 #ifdef CONFIG_EDAC_DEBUG
 			  | DDR_ECC_DATA_POISON_SUPPORT
 #endif
@@ -925,7 +925,7 @@ static const struct synps_platform_data synopsys_edac_def = {
 	.get_mtype	= zynqmp_get_mtype,
 	.get_dtype	= zynqmp_get_dtype,
 	.get_ecc_state	= zynqmp_get_ecc_state,
-	.quirks         = (DDR_ECC_INTR_SUPPORT | DDR_ECC_INTR_SELF_CLEAR
+	.quirks         = (DDR_ECC_INTR_SUPPORT
 #ifdef CONFIG_EDAC_DEBUG
 			  | DDR_ECC_DATA_POISON_SUPPORT
 #endif
-- 
2.43.0


