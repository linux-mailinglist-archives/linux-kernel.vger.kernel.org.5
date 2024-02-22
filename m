Return-Path: <linux-kernel+bounces-77085-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CCA33860101
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 19:21:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F059F1C22C2B
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 18:21:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EEB271729;
	Thu, 22 Feb 2024 18:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BDZ7ktcP"
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB0AB54918;
	Thu, 22 Feb 2024 18:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708625698; cv=none; b=Qep2Mnc2dqSzk4GKXYsWxUSMIinoLFgjzyq4+TWXeqPnhW4f22KPfzBbhytWXwRtQ5dXvLJ5YnvmPT945kc5P0eX1b5J23OFMqh6BIuVyyCh8NuCoNAJGLATLxuuRE9nG2xbROhWaIh4we4faCQ+ZwKO+JsXgrztjQtRwDkN82U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708625698; c=relaxed/simple;
	bh=RIEKLsCs9J/lNhe0663QNjIAp+kSFCJbrKFd+uEoLvw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GRKsbuuWFXynIHoFZ7S2u9e9bdYl6VdPHIwiZJq5Eu80QxezXiEHbuEVmC7hGllhZWwIdSCN6sDAc26tIH5TvbySHziK09MWb5bx0+d6voqX7DjEDcyoNItP7kmY3D3n5rA+y4ysCm5T4I8e2SoWSw7H7zbzb9nFvcWSxsx9Pxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BDZ7ktcP; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-512b29f82d1so105770e87.1;
        Thu, 22 Feb 2024 10:14:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708625694; x=1709230494; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X1gagcZMEXzd9ETmOtwHx7GZqRUhrIVl6MciINJPufo=;
        b=BDZ7ktcPxS2FPr3oW3v34efV9J7tTzwtNUkXuO/l1P/e3x55OUMRPV+mRXeka9MrdL
         yGa+Bo1PnAwgnlJL+bZgQByJlvB395gHyMXwXNp0pE7WKCMrswoELx9NtOfWdI1PAv37
         2XMfVEKHM94/z7/xcYNpAJ/ZV931Ijn42jJ24tJ2nxeFJ1JRG6PHOATbUVYpygMAzBs8
         Ai7lYc21HbdMJ5zMGVtpF5pgVwWaBdHX460I8s/SCHLZg/4R5cNRP5nTsB3ErjGWH51i
         wbjjGkcT0bvQQVCCUZtrOozMGBmbYOF1luz4hFZLCLtS2YgnbBFJlq+R1h46bDg56q5e
         /QvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708625694; x=1709230494;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X1gagcZMEXzd9ETmOtwHx7GZqRUhrIVl6MciINJPufo=;
        b=gUq4eRBWNtRkN3ECZz2/EhlyiiJ29Mrpls4ZygejlmyMQqlOvbJlWOJ6ioFy0RSPfL
         xgxkrsLnZASJQQcPdu+tiBNzjuVoo8NHqCsT3rsvlSN3/SCZDYd/vbTeKZ7TegNZhCXw
         +Uc2VqqY8e58niQXMNC+NrwkVd3ECYCoSHpt2Oozvz6HLWBXvDelNehNuHVW/1mq9xO8
         O/1pqbUaCtAMFPJbwxycIIrOnMhAB6Ua5kHOzaoZWoV1FwKDx0clil2kYjoPv4b/dUvb
         D/egdmfxlVEB2zEK6i1qaMA0yfzpYs7rYzZ1q10zn+7LnDPLV07qFWlSNcB/ghC+WLF2
         YfRA==
X-Forwarded-Encrypted: i=1; AJvYcCVzddlyBYShpRbzzytVOWQgu/MzwW4jS+kEorE2n7zm78m24xjSJhKlF8y3CBSxt438mjPQ2nOwkjb0sGT4NcMo/3WhYZbsxrRQbYOK+ThK7QXtzApcCiHbo+fLqGej5d8s3Dxkyv5EQQ==
X-Gm-Message-State: AOJu0YwsslIeZSPmmFYm29E9QsMPu27/Gpg4ta7S9eeEA7r6Whr6VRM+
	JP5aMJieat+j0JbJ5FbI03uaOY0gudaLRbCd3ddHjyEO63F/iaGGrdZp0dOMcAw=
X-Google-Smtp-Source: AGHT+IGkBNOYhd1JS2L9Kps9qop3w6ZZqgdoNMIixKVJidLIwVObqR0EQ9xiiebcC8E+nC/VNSgxhw==
X-Received: by 2002:a05:6512:308d:b0:512:a8bd:4bee with SMTP id z13-20020a056512308d00b00512a8bd4beemr10777912lfd.45.1708625693842;
        Thu, 22 Feb 2024 10:14:53 -0800 (PST)
Received: from localhost ([178.176.56.174])
        by smtp.gmail.com with ESMTPSA id m15-20020a19520f000000b00512c8ef474asm1043015lfb.270.2024.02.22.10.14.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Feb 2024 10:14:53 -0800 (PST)
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
Subject: [PATCH v5 18/20] EDAC/synopsys: Unify CSRs macro declarations
Date: Thu, 22 Feb 2024 21:13:03 +0300
Message-ID: <20240222181324.28242-19-fancer.lancer@gmail.com>
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

Originally the device CSR macros were supposed to be defined following the
next local convention: first CSR offsets are listed, then their fields and
flags are described in the same order; CSRs offset macros are supposed to
have _OFST suffix; ECC-related macros shall have ECC_ prefix, generic
DDR-related macros - DDR_ prefix. After all the years the driver has been
living in kernel the CSRs macros have turned to be partly deviated away
from the denoted convention. Fix all the related inconsistencies: move
several CSRs offset macros to be defined before the CSRs fields and flags
macros; replace OFFSET suffix with OFST; replace DDRC_ prefix with DDR_
and ECC_ with DDR_ where it's appropriate; group DDR_MSTR and ECC_CTRL
(ECC_CLR) sibling fields macros together and make sure their prefixes
match to the CSRs offset macros. In addition to that drop _MASK suffix
from the macros which aren't used as masks and add ZYNQMP_ prefix to the
ZYNQMP-specific macros to distinguish them from the generic Synopsys
memory controller macros.

Signed-off-by: Serge Semin <fancer.lancer@gmail.com>

---

Changelog v4:
- This is a new patch collected from the rest of the series to simplify
  the review process.
---
 drivers/edac/synopsys_edac.c | 134 +++++++++++++++++------------------
 1 file changed, 66 insertions(+), 68 deletions(-)

diff --git a/drivers/edac/synopsys_edac.c b/drivers/edac/synopsys_edac.c
index 1cd02859e2b9..1de9f3f86d5a 100644
--- a/drivers/edac/synopsys_edac.c
+++ b/drivers/edac/synopsys_edac.c
@@ -77,20 +77,34 @@
 #define ECC_POISON0_OFST		0xB8
 #define ECC_POISON1_OFST		0xBC
 
-#define ECC_ADDRMAP0_OFFSET		0x200
-
-/* Control register bitfield definitions */
-#define ECC_CTRL_CLR_CE_ERR		BIT(0)
-#define ECC_CTRL_CLR_UE_ERR		BIT(1)
-#define ECC_CTRL_CLR_CE_ERRCNT		BIT(2)
-#define ECC_CTRL_CLR_UE_ERRCNT		BIT(3)
-
-/* DDR Control Register width definitions  */
+/* DDR Address Map Registers */
+#define DDR_ADDRMAP0_OFST		0x200
+
+/* DDR Software Control Register */
+#define DDR_SWCTL			0x320
+
+/* ZynqMP DDR QOS Registers */
+#define ZYNQMP_DDR_QOS_IRQ_STAT_OFST	0x20200
+#define ZYNQMP_DDR_QOS_IRQ_EN_OFST	0x20208
+#define ZYNQMP_DDR_QOS_IRQ_DB_OFST	0x2020C
+
+/* DDR Master register definitions */
+#define DDR_MSTR_DEV_CFG_MASK		0xC0000000
+#define DDR_MSTR_DEV_CFG_SHIFT		30
+#define DDR_MSTR_DEV_X4			0
+#define DDR_MSTR_DEV_X8			1
+#define DDR_MSTR_DEV_X16		2
+#define DDR_MSTR_DEV_X32		3
 #define DDR_MSTR_BUSWIDTH_MASK		0x3000
 #define DDR_MSTR_BUSWIDTH_SHIFT		12
-#define DDRCTL_EWDTH_16			2
-#define DDRCTL_EWDTH_32			1
-#define DDRCTL_EWDTH_64			0
+#define DDR_MSTR_BUSWIDTH_16		2
+#define DDR_MSTR_BUSWIDTH_32		1
+#define DDR_MSTR_BUSWIDTH_64		0
+#define DDR_MSTR_MEM_LPDDR4		0x20
+#define DDR_MSTR_MEM_DDR4		0x10
+#define DDR_MSTR_MEM_LPDDR3		0x8
+#define DDR_MSTR_MEM_DDR2		0x4
+#define DDR_MSTR_MEM_DDR3		0x1
 
 /* ECC CFG0 register definitions */
 #define ECC_CFG0_MODE_MASK		0x7
@@ -103,23 +117,19 @@
 #define ECC_STAT_CECNT_SHIFT		8
 #define ECC_STAT_BITNUM_MASK		0x7F
 
+/* ECC control/clear register definitions */
+#define ECC_CTRL_CLR_CE_ERR		BIT(0)
+#define ECC_CTRL_CLR_UE_ERR		BIT(1)
+#define ECC_CTRL_CLR_CE_ERRCNT		BIT(2)
+#define ECC_CTRL_CLR_UE_ERRCNT		BIT(3)
+#define ECC_CTRL_EN_CE_IRQ		BIT(8)
+#define ECC_CTRL_EN_UE_IRQ		BIT(9)
+
 /* ECC error count register definitions */
 #define ECC_ERRCNT_UECNT_MASK		0xFFFF0000
 #define ECC_ERRCNT_UECNT_SHIFT		16
 #define ECC_ERRCNT_CECNT_MASK		0xFFFF
 
-/* DDR QOS Interrupt register definitions */
-#define DDR_QOS_IRQ_STAT_OFST		0x20200
-#define DDR_QOSUE_MASK			0x4
-#define	DDR_QOSCE_MASK			0x2
-#define	ECC_CE_UE_INTR_MASK		0x6
-#define DDR_QOS_IRQ_EN_OFST		0x20208
-#define DDR_QOS_IRQ_DB_OFST		0x2020C
-
-/* DDR QOS Interrupt register definitions */
-#define DDR_UE_MASK			BIT(9)
-#define DDR_CE_MASK			BIT(8)
-
 /* ECC Corrected Error Register Mask and Shifts*/
 #define ECC_CEADDR0_RW_MASK		0x3FFFF
 #define ECC_CEADDR0_RNK_MASK		BIT(24)
@@ -141,28 +151,11 @@
 #define ECC_POISON1_ROW_SHIFT		0
 #define ECC_POISON1_ROW_MASK		0x3FFFF
 
-/* DDR Memory type defines */
-#define MEM_TYPE_DDR3			0x1
-#define MEM_TYPE_LPDDR3			0x8
-#define MEM_TYPE_DDR2			0x4
-#define MEM_TYPE_DDR4			0x10
-#define MEM_TYPE_LPDDR4			0x20
-
-/* DDRC Software control register */
-#define DDRC_SWCTL			0x320
-
 /* DDRC ECC CE & UE poison mask */
 #define ECC_CEPOISON_MASK		0x3
 #define ECC_UEPOISON_MASK		0x1
 
-/* DDRC Device config masks */
-#define DDRC_MSTR_CFG_MASK		0xC0000000
-#define DDRC_MSTR_CFG_SHIFT		30
-#define DDRC_MSTR_CFG_X4_MASK		0x0
-#define DDRC_MSTR_CFG_X8_MASK		0x1
-#define DDRC_MSTR_CFG_X16_MASK		0x2
-#define DDRC_MSTR_CFG_X32_MASK		0x3
-
+/* DDRC Device config shifts/masks */
 #define DDR_MAX_ROW_SHIFT		18
 #define DDR_MAX_COL_SHIFT		14
 #define DDR_MAX_BANK_SHIFT		3
@@ -215,6 +208,11 @@
 
 #define RANK_B0_BASE			6
 
+/* ZynqMP DDR QOS Interrupt register definitions */
+#define ZYNQMP_DDR_QOS_UE_MASK		0x4
+#define ZYNQMP_DDR_QOS_CE_MASK		0x2
+#define ZYNQMP_DDR_QOS_IRQ_MASK		0x6
+
 /**
  * struct ecc_error_info - ECC error log information.
  * @row:	Row number.
@@ -397,8 +395,8 @@ static void enable_intr(struct synps_edac_priv *priv)
 
 	/* Enable UE/CE Interrupts */
 	if (priv->p_data->quirks & SYNPS_ZYNQMP_IRQ_REGS) {
-		writel(DDR_QOSUE_MASK | DDR_QOSCE_MASK,
-		       priv->baseaddr + DDR_QOS_IRQ_EN_OFST);
+		writel(ZYNQMP_DDR_QOS_UE_MASK | ZYNQMP_DDR_QOS_CE_MASK,
+		       priv->baseaddr + ZYNQMP_DDR_QOS_IRQ_EN_OFST);
 
 		return;
 	}
@@ -409,7 +407,7 @@ static void enable_intr(struct synps_edac_priv *priv)
 	 * IRQs Enable/Disable flags have been available since v3.10a.
 	 * This is noop for the older controllers.
 	 */
-	writel(DDR_UE_MASK | DDR_CE_MASK,
+	writel(ECC_CTRL_EN_CE_IRQ | ECC_CTRL_EN_UE_IRQ,
 	       priv->baseaddr + ECC_CLR_OFST);
 
 	spin_unlock_irqrestore(&priv->reglock, flags);
@@ -421,8 +419,8 @@ static void disable_intr(struct synps_edac_priv *priv)
 
 	/* Disable UE/CE Interrupts */
 	if (priv->p_data->quirks & SYNPS_ZYNQMP_IRQ_REGS) {
-		writel(DDR_QOSUE_MASK | DDR_QOSCE_MASK,
-		       priv->baseaddr + DDR_QOS_IRQ_DB_OFST);
+		writel(ZYNQMP_DDR_QOS_UE_MASK | ZYNQMP_DDR_QOS_CE_MASK,
+		       priv->baseaddr + ZYNQMP_DDR_QOS_IRQ_DB_OFST);
 
 		return;
 	}
@@ -450,9 +448,9 @@ static irqreturn_t intr_handler(int irq, void *dev_id)
 	priv = mci->pvt_info;
 
 	if (priv->p_data->quirks & SYNPS_ZYNQMP_IRQ_REGS) {
-		regval = readl(priv->baseaddr + DDR_QOS_IRQ_STAT_OFST);
-		regval &= (DDR_QOSCE_MASK | DDR_QOSUE_MASK);
-		if (!(regval & ECC_CE_UE_INTR_MASK))
+		regval = readl(priv->baseaddr + ZYNQMP_DDR_QOS_IRQ_STAT_OFST);
+		regval &= (ZYNQMP_DDR_QOS_CE_MASK | ZYNQMP_DDR_QOS_UE_MASK);
+		if (!(regval & ZYNQMP_DDR_QOS_IRQ_MASK))
 			return IRQ_NONE;
 	}
 
@@ -463,7 +461,7 @@ static irqreturn_t intr_handler(int irq, void *dev_id)
 	handle_error(mci, &priv->stat);
 
 	if (priv->p_data->quirks & SYNPS_ZYNQMP_IRQ_REGS)
-		writel(regval, priv->baseaddr + DDR_QOS_IRQ_STAT_OFST);
+		writel(regval, priv->baseaddr + ZYNQMP_DDR_QOS_IRQ_STAT_OFST);
 
 	return IRQ_HANDLED;
 }
@@ -482,18 +480,18 @@ static enum dev_type synps_get_dtype(const void __iomem *base)
 	u32 regval;
 
 	regval = readl(base + DDR_MSTR_OFST);
-	if (!(regval & MEM_TYPE_DDR4))
+	if (!(regval & DDR_MSTR_MEM_DDR4))
 		return DEV_UNKNOWN;
 
-	regval = (regval & DDRC_MSTR_CFG_MASK) >> DDRC_MSTR_CFG_SHIFT;
+	regval = (regval & DDR_MSTR_DEV_CFG_MASK) >> DDR_MSTR_DEV_CFG_SHIFT;
 	switch (regval) {
-	case DDRC_MSTR_CFG_X4_MASK:
+	case DDR_MSTR_DEV_X4:
 		return DEV_X4;
-	case DDRC_MSTR_CFG_X8_MASK:
+	case DDR_MSTR_DEV_X8:
 		return DEV_X8;
-	case DDRC_MSTR_CFG_X16_MASK:
+	case DDR_MSTR_DEV_X16:
 		return DEV_X16;
-	case DDRC_MSTR_CFG_X32_MASK:
+	case DDR_MSTR_DEV_X32:
 		return DEV_X32;
 	}
 
@@ -547,11 +545,11 @@ static enum mem_type synps_get_mtype(const void __iomem *base)
 
 	memtype = readl(base + DDR_MSTR_OFST);
 
-	if ((memtype & MEM_TYPE_DDR3) || (memtype & MEM_TYPE_LPDDR3))
+	if ((memtype & DDR_MSTR_MEM_DDR3) || (memtype & DDR_MSTR_MEM_LPDDR3))
 		mt = MEM_DDR3;
-	else if (memtype & MEM_TYPE_DDR2)
+	else if (memtype & DDR_MSTR_MEM_DDR2)
 		mt = MEM_RDDR2;
-	else if ((memtype & MEM_TYPE_LPDDR4) || (memtype & MEM_TYPE_DDR4))
+	else if ((memtype & DDR_MSTR_MEM_LPDDR4) || (memtype & DDR_MSTR_MEM_DDR4))
 		mt = MEM_DDR4;
 	else
 		mt = MEM_EMPTY;
@@ -756,12 +754,12 @@ static ssize_t inject_data_poison_store(struct device *dev,
 	struct mem_ctl_info *mci = to_mci(dev);
 	struct synps_edac_priv *priv = mci->pvt_info;
 
-	writel(0, priv->baseaddr + DDRC_SWCTL);
+	writel(0, priv->baseaddr + DDR_SWCTL);
 	if (strncmp(data, "CE", 2) == 0)
 		writel(ECC_CEPOISON_MASK, priv->baseaddr + ECC_CFG1_OFST);
 	else
 		writel(ECC_UEPOISON_MASK, priv->baseaddr + ECC_CFG1_OFST);
-	writel(1, priv->baseaddr + DDRC_SWCTL);
+	writel(1, priv->baseaddr + DDR_SWCTL);
 
 	return count;
 }
@@ -878,8 +876,8 @@ static void setup_column_address_map(struct synps_edac_priv *priv, u32 *addrmap)
 	priv->col_shift[9] = (((addrmap[3] >> 24) & COL_MAX_VAL_MASK) ==
 			COL_MAX_VAL_MASK) ? 0 : (((addrmap[3] >> 24) &
 					COL_MAX_VAL_MASK) + COL_B9_BASE);
-	if (width == DDRCTL_EWDTH_64) {
-		if (memtype & MEM_TYPE_LPDDR3) {
+	if (width == DDR_MSTR_BUSWIDTH_64) {
+		if (memtype & DDR_MSTR_MEM_LPDDR3) {
 			priv->col_shift[10] = ((addrmap[4] &
 				COL_MAX_VAL_MASK) == COL_MAX_VAL_MASK) ? 0 :
 				((addrmap[4] & COL_MAX_VAL_MASK) +
@@ -898,8 +896,8 @@ static void setup_column_address_map(struct synps_edac_priv *priv, u32 *addrmap)
 				(((addrmap[4] >> 8) & COL_MAX_VAL_MASK) +
 				 COL_B11_BASE);
 		}
-	} else if (width == DDRCTL_EWDTH_32) {
-		if (memtype & MEM_TYPE_LPDDR3) {
+	} else if (width == DDR_MSTR_BUSWIDTH_32) {
+		if (memtype & DDR_MSTR_MEM_LPDDR3) {
 			priv->col_shift[10] = (((addrmap[3] >> 24) &
 				COL_MAX_VAL_MASK) == COL_MAX_VAL_MASK) ? 0 :
 				(((addrmap[3] >> 24) & COL_MAX_VAL_MASK) +
@@ -919,7 +917,7 @@ static void setup_column_address_map(struct synps_edac_priv *priv, u32 *addrmap)
 				 COL_B10_BASE);
 		}
 	} else {
-		if (memtype & MEM_TYPE_LPDDR3) {
+		if (memtype & DDR_MSTR_MEM_LPDDR3) {
 			priv->col_shift[10] = (((addrmap[3] >> 16) &
 				COL_MAX_VAL_MASK) == COL_MAX_VAL_MASK) ? 0 :
 				(((addrmap[3] >> 16) & COL_MAX_VAL_MASK) +
@@ -994,7 +992,7 @@ static void setup_address_map(struct synps_edac_priv *priv)
 	for (index = 0; index < 12; index++) {
 		u32 addrmap_offset;
 
-		addrmap_offset = ECC_ADDRMAP0_OFFSET + (index * 4);
+		addrmap_offset = DDR_ADDRMAP0_OFST + (index * 4);
 		addrmap[index] = readl(priv->baseaddr + addrmap_offset);
 	}
 
-- 
2.43.0


