Return-Path: <linux-kernel+bounces-77088-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC43C86010B
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 19:22:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 70977284B44
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 18:22:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4147573F39;
	Thu, 22 Feb 2024 18:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cYXySXGO"
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BB3971723;
	Thu, 22 Feb 2024 18:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708625701; cv=none; b=fkwsYwRspO+qrztrsRVUcP79oTUfGwzVCCOfGyTK8rXT6hK2Ctt0FRpumJKOh+qADsYOU6dZz6/oiN1KK19AegSOvENThuYgF8uaX7ky7yQngdEPc0JL6x6BTaJNNN5+ii1Z4tXmoQWFi7QMes4IYhwQHIiHoWN77N/80vUOfRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708625701; c=relaxed/simple;
	bh=XZ3hPjbqhYGZGR7TR4kumiFW8lcRz2dIo4KkSn2iKxk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OgzM0QnHwLRyYg2AbCvP8pxdqPLJw1JWTO/lpW1UTQbW+iI+nOMm5lkQZQIR4Q9btmYOKIIq4wpP2wehYho0jBa3DUW3pdR71Zx3S37X4lfEow5lvzP07EfA3V1Rdrjuu9quRWnr6f1kUaDpYDFkhZ28tTJPrIKmiOwUbvnX3eM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cYXySXGO; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-51197ca63f5so121401e87.1;
        Thu, 22 Feb 2024 10:14:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708625697; x=1709230497; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6+6eluhzIXzdxVu9lwksRYlR6Z+Jeq9cMOHs7DzxPZ0=;
        b=cYXySXGOUmoOYwx7UGq/Q1upbYBjfQXFyGSqJElBan1Kk5sMYALwyevmoafv5IqbNg
         kG7CNPzpzkSeTooChsuY/Zr8uFJBXB9FZu+k+xbttg4fAwc8Iqq255QLYL/lp7WGLsf5
         KAQadN1gmhNEKZhA39QwMp89zNWau8lbeO/vU+B4mdHaeZa0gVH5X/wP9XTZW6r9nED/
         0PEPk29mQUeS6Ps6oWcJk110bbZ4fylkHjDrC0qANvfb8kHMuAmn4CQiTINgHDcge1KK
         DOIbdooX+eW0mcg9V7aaJUghBhYkB22y3k4vzkB1lpdYONpOQkUTmKxZYIBqNpdOkfZG
         DFew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708625697; x=1709230497;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6+6eluhzIXzdxVu9lwksRYlR6Z+Jeq9cMOHs7DzxPZ0=;
        b=HMCiM1xXCfA8zrSPgVW1EltGTgIJPM4UNw1s3ywGu+UWjLfPmxLcl2QuhL0sq1dGSE
         RN9uTtZKwkyLBElDL13fuaYgvEhTzhG7VVWFqU0iFrc/4lms2QH84fx8UpgcoAQrRAlN
         aqlC6EHgfrVTj03woZNSxthN/JA8X1vG1f+761IWrnkMewA7n4eGIbZQZPyverJRr9EF
         UoD1PFmSfSHgh4Mq4pCWyMMI3JUjGT2zgIfOAFHnaLstBt6QhThbFzM50gTrbOtFvsKX
         TvyzHgtYP2rGFQuTHZMKWXKcVERfslPy2nnrx3VyIwnmK/LD/Qin/e/EGhDeoZPQYUs3
         7uOw==
X-Forwarded-Encrypted: i=1; AJvYcCXdLm8XQhjW+8J3Fw6NKQTsLHuGqAlURdmijpjKFdEiDIIozqcJLsdsUYawaNHDdFxMRkWwgxjE9kw3P81SLXyvbg6D4WxbQrMLbLUTzbNhpfiHTcZtgA1vZulIU2aKwA5sOMlu79YKcQ==
X-Gm-Message-State: AOJu0Yxl+Sl/BkYmAnPBf0dJYxsu/jLIzeFhxlXh1jB67zhETtP5Yuva
	DxFWrmj4kLqkSoQA+FQ+zdbm17rwQthnWFCt3IPiG2/pmgphbTWr
X-Google-Smtp-Source: AGHT+IGViWdTRMiTTkc5ZBZ6Oe/2Vf9SZKO55IAHmMniONZyEa0q+s5UPxtDimTkeKhEFaUSr/qKnA==
X-Received: by 2002:a05:6512:2190:b0:512:c508:b8c8 with SMTP id b16-20020a056512219000b00512c508b8c8mr5788854lft.4.1708625697367;
        Thu, 22 Feb 2024 10:14:57 -0800 (PST)
Received: from localhost ([178.176.56.174])
        by smtp.gmail.com with ESMTPSA id g38-20020a0565123ba600b00511767de71bsm2134577lfv.291.2024.02.22.10.14.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Feb 2024 10:14:56 -0800 (PST)
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
Subject: [PATCH v5 20/20] EDAC/synopsys: Convert to using BIT/GENMASK/FIELD_x macros
Date: Thu, 22 Feb 2024 21:13:05 +0300
Message-ID: <20240222181324.28242-21-fancer.lancer@gmail.com>
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

Instead of using the very handy helpers denoted in the subject the driver
has been created with the open-coded {mask,shift} statements. It makes the
code bulky, prone to mistakes and much harder to read. Seeing there are
many places in the driver implementing the CSR fields get/set pattern use
the FIELD_GET()/FIELD_PREP() macros introduced in the kernel specifically
for that case. In addition use the BIT() and GENMASK() macros to generate
the CSR flags/masks. While at it unify the row, column, rank, bank and
bank group macros names to be having a suffix similar to the
snps_ecc_error_info structure fields name.

Signed-off-by: Serge Semin <fancer.lancer@gmail.com>
---
 drivers/edac/synopsys_edac.c | 137 +++++++++++++++++------------------
 1 file changed, 67 insertions(+), 70 deletions(-)

diff --git a/drivers/edac/synopsys_edac.c b/drivers/edac/synopsys_edac.c
index c46cee035c0d..f181cd7b4447 100644
--- a/drivers/edac/synopsys_edac.c
+++ b/drivers/edac/synopsys_edac.c
@@ -6,6 +6,8 @@
  * Copyright (C) 2012 - 2014 Xilinx, Inc.
  */
 
+#include <linux/bitfield.h>
+#include <linux/bits.h>
 #include <linux/edac.h>
 #include <linux/module.h>
 #include <linux/platform_device.h>
@@ -89,33 +91,29 @@
 #define ZYNQMP_DDR_QOS_IRQ_DB_OFST	0x2020C
 
 /* DDR Master register definitions */
-#define DDR_MSTR_DEV_CFG_MASK		0xC0000000
-#define DDR_MSTR_DEV_CFG_SHIFT		30
+#define DDR_MSTR_DEV_CFG_MASK		GENMASK(31, 30)
 #define DDR_MSTR_DEV_X4			0
 #define DDR_MSTR_DEV_X8			1
 #define DDR_MSTR_DEV_X16		2
 #define DDR_MSTR_DEV_X32		3
-#define DDR_MSTR_BUSWIDTH_MASK		0x3000
-#define DDR_MSTR_BUSWIDTH_SHIFT		12
+#define DDR_MSTR_BUSWIDTH_MASK		GENMASK(13, 12)
 #define DDR_MSTR_BUSWIDTH_16		2
 #define DDR_MSTR_BUSWIDTH_32		1
 #define DDR_MSTR_BUSWIDTH_64		0
-#define DDR_MSTR_MEM_LPDDR4		0x20
-#define DDR_MSTR_MEM_DDR4		0x10
-#define DDR_MSTR_MEM_LPDDR3		0x8
-#define DDR_MSTR_MEM_DDR2		0x4
-#define DDR_MSTR_MEM_DDR3		0x1
+#define DDR_MSTR_MEM_LPDDR4		BIT(5)
+#define DDR_MSTR_MEM_DDR4		BIT(4)
+#define DDR_MSTR_MEM_LPDDR3		BIT(3)
+#define DDR_MSTR_MEM_DDR2		BIT(2)
+#define DDR_MSTR_MEM_DDR3		BIT(0)
 
 /* ECC CFG0 register definitions */
-#define ECC_CFG0_MODE_MASK		0x7
+#define ECC_CFG0_MODE_MASK		GENMASK(2, 0)
 #define ECC_CFG0_MODE_SECDED		0x4
 
 /* ECC status register definitions */
-#define ECC_STAT_UECNT_MASK		0xF0000
-#define ECC_STAT_UECNT_SHIFT		16
-#define ECC_STAT_CECNT_MASK		0xF00
-#define ECC_STAT_CECNT_SHIFT		8
-#define ECC_STAT_BITNUM_MASK		0x7F
+#define ECC_STAT_UE_MASK		GENMASK(23, 16)
+#define ECC_STAT_CE_MASK		GENMASK(15, 8)
+#define ECC_STAT_BITNUM_MASK		GENMASK(6, 0)
 
 /* ECC control/clear register definitions */
 #define ECC_CTRL_CLR_CE_ERR		BIT(0)
@@ -126,34 +124,26 @@
 #define ECC_CTRL_EN_UE_IRQ		BIT(9)
 
 /* ECC error count register definitions */
-#define ECC_ERRCNT_UECNT_MASK		0xFFFF0000
-#define ECC_ERRCNT_UECNT_SHIFT		16
-#define ECC_ERRCNT_CECNT_MASK		0xFFFF
-
-/* ECC Corrected Error Register Mask and Shifts*/
-#define ECC_CEADDR0_RW_MASK		0x3FFFF
-#define ECC_CEADDR0_RNK_MASK		BIT(24)
-#define ECC_CEADDR1_BNKGRP_MASK		0x3000000
-#define ECC_CEADDR1_BNKNR_MASK		0x70000
-#define ECC_CEADDR1_COL_MASK		0xFFF
-#define ECC_CEADDR1_BNKGRP_SHIFT	24
-#define ECC_CEADDR1_BNKNR_SHIFT		16
-
-/* ECC Poison register shifts */
-#define ECC_POISON0_RANK_SHIFT		24
-#define ECC_POISON0_RANK_MASK		BIT(24)
-#define ECC_POISON0_COLUMN_SHIFT	0
-#define ECC_POISON0_COLUMN_MASK		0xFFF
-#define ECC_POISON1_BG_SHIFT		28
-#define ECC_POISON1_BG_MASK		0x30000000
-#define ECC_POISON1_BANKNR_SHIFT	24
-#define ECC_POISON1_BANKNR_MASK		0x7000000
-#define ECC_POISON1_ROW_SHIFT		0
-#define ECC_POISON1_ROW_MASK		0x3FFFF
+#define ECC_ERRCNT_UECNT_MASK		GENMASK(31, 16)
+#define ECC_ERRCNT_CECNT_MASK		GENMASK(15, 0)
+
+/* ECC Corrected Error register definitions */
+#define ECC_CEADDR0_RANK_MASK		GENMASK(27, 24)
+#define ECC_CEADDR0_ROW_MASK		GENMASK(17, 0)
+#define ECC_CEADDR1_BANKGRP_MASK	GENMASK(25, 24)
+#define ECC_CEADDR1_BANK_MASK		GENMASK(23, 16)
+#define ECC_CEADDR1_COL_MASK		GENMASK(11, 0)
+
+/* ECC Poison register definitions */
+#define ECC_POISON0_RANK_MASK		GENMASK(27, 24)
+#define ECC_POISON0_COL_MASK		GENMASK(11, 0)
+#define ECC_POISON1_BANKGRP_MASK	GENMASK(29, 28)
+#define ECC_POISON1_BANK_MASK		GENMASK(26, 24)
+#define ECC_POISON1_ROW_MASK		GENMASK(17, 0)
 
 /* DDRC ECC CE & UE poison mask */
-#define ECC_CEPOISON_MASK		0x3
-#define ECC_UEPOISON_MASK		0x1
+#define ECC_CEPOISON_MASK		GENMASK(1, 0)
+#define ECC_UEPOISON_MASK		BIT(0)
 
 /* DDRC Device config shifts/masks */
 #define DDR_MAX_ROW_SHIFT		18
@@ -209,9 +199,9 @@
 #define RANK_B0_BASE			6
 
 /* ZynqMP DDR QOS Interrupt register definitions */
-#define ZYNQMP_DDR_QOS_UE_MASK		0x4
-#define ZYNQMP_DDR_QOS_CE_MASK		0x2
-#define ZYNQMP_DDR_QOS_IRQ_MASK		0x6
+#define ZYNQMP_DDR_QOS_UE_MASK		BIT(2)
+#define ZYNQMP_DDR_QOS_CE_MASK		BIT(1)
+#define ZYNQMP_DDR_QOS_IRQ_MASK		(ZYNQMP_DDR_QOS_UE_MASK | ZYNQMP_DDR_QOS_CE_MASK)
 
 /**
  * struct snps_ecc_error_info - ECC error log information.
@@ -303,38 +293,40 @@ static int snps_get_error_info(struct snps_edac_priv *priv)
 	if (!regval)
 		return 1;
 
-	p->ceinfo.bitpos = (regval & ECC_STAT_BITNUM_MASK);
+	p->ceinfo.bitpos = FIELD_GET(ECC_STAT_BITNUM_MASK, regval);
 
 	regval = readl(base + ECC_ERRCNT_OFST);
-	p->ce_cnt = regval & ECC_ERRCNT_CECNT_MASK;
-	p->ue_cnt = (regval & ECC_ERRCNT_UECNT_MASK) >> ECC_ERRCNT_UECNT_SHIFT;
+	p->ce_cnt = FIELD_GET(ECC_ERRCNT_CECNT_MASK, regval);
+	p->ue_cnt = FIELD_GET(ECC_ERRCNT_UECNT_MASK, regval);
 	if (!p->ce_cnt)
 		goto ue_err;
 
 	regval = readl(base + ECC_CEADDR0_OFST);
-	p->ceinfo.row = (regval & ECC_CEADDR0_RW_MASK);
+	p->ceinfo.row = FIELD_GET(ECC_CEADDR0_ROW_MASK, regval);
+
 	regval = readl(base + ECC_CEADDR1_OFST);
-	p->ceinfo.bank = (regval & ECC_CEADDR1_BNKNR_MASK) >>
-					ECC_CEADDR1_BNKNR_SHIFT;
-	p->ceinfo.bankgrp = (regval & ECC_CEADDR1_BNKGRP_MASK) >>
-					ECC_CEADDR1_BNKGRP_SHIFT;
-	p->ceinfo.col = (regval & ECC_CEADDR1_COL_MASK);
+	p->ceinfo.bank = FIELD_GET(ECC_CEADDR1_BANK_MASK, regval);
+	p->ceinfo.bankgrp = FIELD_GET(ECC_CEADDR1_BANKGRP_MASK, regval);
+	p->ceinfo.col = FIELD_GET(ECC_CEADDR1_COL_MASK, regval);
+
 	p->ceinfo.data = readl(base + ECC_CSYND0_OFST);
+
 	edac_dbg(2, "ECCCSYN0: 0x%08X ECCCSYN1: 0x%08X ECCCSYN2: 0x%08X\n",
 		 readl(base + ECC_CSYND0_OFST), readl(base + ECC_CSYND1_OFST),
 		 readl(base + ECC_CSYND2_OFST));
+
 ue_err:
 	if (!p->ue_cnt)
 		goto out;
 
 	regval = readl(base + ECC_UEADDR0_OFST);
-	p->ueinfo.row = (regval & ECC_CEADDR0_RW_MASK);
+	p->ueinfo.row = FIELD_GET(ECC_CEADDR0_ROW_MASK, regval);
+
 	regval = readl(base + ECC_UEADDR1_OFST);
-	p->ueinfo.bankgrp = (regval & ECC_CEADDR1_BNKGRP_MASK) >>
-					ECC_CEADDR1_BNKGRP_SHIFT;
-	p->ueinfo.bank = (regval & ECC_CEADDR1_BNKNR_MASK) >>
-					ECC_CEADDR1_BNKNR_SHIFT;
-	p->ueinfo.col = (regval & ECC_CEADDR1_COL_MASK);
+	p->ueinfo.bankgrp = FIELD_GET(ECC_CEADDR1_BANKGRP_MASK, regval);
+	p->ueinfo.bank = FIELD_GET(ECC_CEADDR1_BANK_MASK, regval);
+	p->ueinfo.col = FIELD_GET(ECC_CEADDR1_COL_MASK, regval);
+
 	p->ueinfo.data = readl(base + ECC_UESYND0_OFST);
 out:
 	spin_lock_irqsave(&priv->reglock, flags);
@@ -483,7 +475,7 @@ static enum dev_type snps_get_dtype(const void __iomem *base)
 	if (!(regval & DDR_MSTR_MEM_DDR4))
 		return DEV_UNKNOWN;
 
-	regval = (regval & DDR_MSTR_DEV_CFG_MASK) >> DDR_MSTR_DEV_CFG_SHIFT;
+	regval = FIELD_GET(DDR_MSTR_DEV_CFG_MASK, regval);
 	switch (regval) {
 	case DDR_MSTR_DEV_X4:
 		return DEV_X4;
@@ -510,7 +502,8 @@ static bool snps_get_ecc_state(void __iomem *base)
 {
 	u32 regval;
 
-	regval = readl(base + ECC_CFG0_OFST) & ECC_CFG0_MODE_MASK;
+	regval = readl(base + ECC_CFG0_OFST);
+	regval = FIELD_GET(ECC_CFG0_MODE_MASK, regval);
 
 	return (regval == ECC_CFG0_MODE_SECDED);
 }
@@ -697,13 +690,13 @@ static void snps_data_poison_setup(struct snps_edac_priv *priv)
 	if (priv->rank_shift[0])
 		rank = (hif_addr >> priv->rank_shift[0]) & BIT(0);
 
-	regval = (rank << ECC_POISON0_RANK_SHIFT) & ECC_POISON0_RANK_MASK;
-	regval |= (col << ECC_POISON0_COLUMN_SHIFT) & ECC_POISON0_COLUMN_MASK;
+	regval = FIELD_PREP(ECC_POISON0_RANK_MASK, rank) |
+		 FIELD_PREP(ECC_POISON0_COL_MASK, col);
 	writel(regval, priv->baseaddr + ECC_POISON0_OFST);
 
-	regval = (bankgrp << ECC_POISON1_BG_SHIFT) & ECC_POISON1_BG_MASK;
-	regval |= (bank << ECC_POISON1_BANKNR_SHIFT) & ECC_POISON1_BANKNR_MASK;
-	regval |= (row << ECC_POISON1_ROW_SHIFT) & ECC_POISON1_ROW_MASK;
+	regval = FIELD_PREP(ECC_POISON1_BANKGRP_MASK, bankgrp) |
+		 FIELD_PREP(ECC_POISON1_BANK_MASK, bank) |
+		 FIELD_PREP(ECC_POISON1_ROW_MASK, row);
 	writel(regval, priv->baseaddr + ECC_POISON1_OFST);
 }
 
@@ -742,10 +735,14 @@ static ssize_t inject_data_poison_show(struct device *dev,
 {
 	struct mem_ctl_info *mci = to_mci(dev);
 	struct snps_edac_priv *priv = mci->pvt_info;
+	const char *errstr;
+	u32 regval;
+
+	regval = readl(priv->baseaddr + ECC_CFG1_OFST);
+	errstr = FIELD_GET(ECC_CEPOISON_MASK, regval) == ECC_CEPOISON_MASK ?
+		 "Correctable Error" : "UnCorrectable Error";
 
-	return sprintf(data, "Data Poisoning: %s\n\r",
-			(((readl(priv->baseaddr + ECC_CFG1_OFST)) & 0x3) == 0x3)
-			? ("Correctable Error") : ("UnCorrectable Error"));
+	return sprintf(data, "Data Poisoning: %s\n\r", errstr);
 }
 
 static ssize_t inject_data_poison_store(struct device *dev,
@@ -852,7 +849,7 @@ static void snps_setup_column_address_map(struct snps_edac_priv *priv, u32 *addr
 	int index;
 
 	memtype = readl(priv->baseaddr + DDR_MSTR_OFST);
-	width = (memtype & DDR_MSTR_BUSWIDTH_MASK) >> DDR_MSTR_BUSWIDTH_SHIFT;
+	width = FIELD_GET(DDR_MSTR_BUSWIDTH_MASK, memtype);
 
 	priv->col_shift[0] = 0;
 	priv->col_shift[1] = 1;
-- 
2.43.0


