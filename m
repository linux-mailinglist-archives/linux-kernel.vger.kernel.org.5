Return-Path: <linux-kernel+bounces-36386-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FAE0839FE9
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 04:07:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 009351F2BBDD
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 03:07:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D43931427B;
	Wed, 24 Jan 2024 03:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="EPvVJ+KN"
Received: from mail-oi1-f225.google.com (mail-oi1-f225.google.com [209.85.167.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B99AF4FD
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 03:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706065542; cv=none; b=py+iElduq1zk/G3U6MvLVKLK4tnRSnejU6Y0nqIbd5Qt0CkHW+XxCAuG/D35L3Ip+VSRLZvceOga8wQSQlblylR6QMLE7e62nV2rM6NKZbzt9fghOff6wT4pus6v4BTIQcOmcf7Ehkq7uxgpVJx1KEsOszKTSWSf1uQ9MyOeZeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706065542; c=relaxed/simple;
	bh=hzbG4OoPjAXRYBBpDTMlTNqRfUzJM+dhcP+1ZDzniQM=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=X4rIjWG9/7s8k9ev9/7BXAGCLqPncSUgewCRy3mYY5WPwY56N1JLM452WbPPAhUBNc/1VVvfcRWCWHulvannUkK6IjX4OZyEvYU6FkrZMBT9mVx/HC3YJ3OrvM1xfUocOukrH6aaMpi/IfIHe4LEOP/Z5fdek+1A0I1XAK60mck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=EPvVJ+KN; arc=none smtp.client-ip=209.85.167.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-oi1-f225.google.com with SMTP id 5614622812f47-3bd5c4cffefso4953900b6e.1
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 19:05:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1706065540; x=1706670340; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ynywjXfyuUDyBEky1TbYS2FW4j63gm4kdZM9CH++EkQ=;
        b=EPvVJ+KN4j1iLZiICIl7aaRHoGsoQB1LZU/f05uvVQKhJvAwdpH/8azrRz6Lfl8HdN
         DDoGlSEUzbtLDkNYA+xgK8qIADSLhzm01kb1IPGJ1AMVgJNh8AaioSZWqMsjOHaGucba
         hZp3eJlcvQ4K0c6P/B1SYVQhkE5g4lJj9SJ7o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706065540; x=1706670340;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ynywjXfyuUDyBEky1TbYS2FW4j63gm4kdZM9CH++EkQ=;
        b=vOOcEk3FqOftdL842Ojz58xBjQkjTsxRCRz7PF/6MvU165FnigD66+wlzu0BwxRsWl
         QF4jWYImxiP+lJjiXEUPWQtIkh2cdmTc0kIlC76RNW6x8/w7Tb+O09N3LBaZ5nY0pOyg
         mcWD+aDkpf2FrwH+OP/PLa2r6Wj0g0GzdjnOWwqk7mxRQfzD8FRJTwcq0R9nioGfd72T
         EPFKiQ+ai+rKeU2svE8l9ZnktBZTdIDhjd1UlUeyOJx9IMVBIafrftH2lI0jEvYhpU3K
         AUFQDmr/WFwsj9kEq84QXq0D7w27l6KBz540ZE+cxPY58ag53xKP9Xb+cq0l7TsKQQVA
         hiFQ==
X-Gm-Message-State: AOJu0YyN22uiRWLhZIs5KLgKeIjZUlRTX3qvmqEL6IEGH2JOz2+3BcGa
	3PBU+t41nJW5LtcjrKel4USn6c0JDDiWGDY4p2yHhB2SImitqP38K1mt3nvlsk7nvQDOifcrsbI
	1HwrbR6eje5RcSawU6Srs4x6cGgC19A==
X-Google-Smtp-Source: AGHT+IFK/2w2iG1AZMvtjj1jtWThPpJ7sawSzLyPn2mzN4taB1JWwBEzC/CVEwcbMMV+JpYCODWXvertPG7F
X-Received: by 2002:a05:6871:3319:b0:213:84f3:b21a with SMTP id nf25-20020a056871331900b0021384f3b21amr2242246oac.61.1706065540433;
        Tue, 23 Jan 2024 19:05:40 -0800 (PST)
Received: from bcacpedev-irv-3.lvn.broadcom.net ([192.19.161.250])
        by smtp-relay.gmail.com with ESMTPS id c22-20020a056830349600b006dc7502beabsm455320otu.3.2024.01.23.19.05.38
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Jan 2024 19:05:40 -0800 (PST)
X-Relaying-Domain: broadcom.com
From: David Regan <dregan@broadcom.com>
To: dregan@broadcom.com,
	dregan@mail.com,
	miquel.raynal@bootlin.com,
	richard@nod.at,
	vigneshr@ti.com,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	computersforpeace@gmail.com,
	kdasu.kdev@gmail.com,
	linux-mtd@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	joel.peshkin@broadcom.com,
	tomer.yacoby@broadcom.com,
	dan.beygelman@broadcom.com,
	william.zhang@broadcom.com,
	anand.gore@broadcom.com,
	kursad.oney@broadcom.com,
	florian.fainelli@broadcom.com,
	rafal@milecki.pl,
	bcm-kernel-feedback-list@broadcom.com,
	andre.przywara@arm.com,
	baruch@tkos.co.il,
	linux-arm-kernel@lists.infradead.org,
	dan.carpenter@linaro.org
Subject: [PATCH v3 06/10] mtd: rawnand: brcmnand: Add support for getting ecc setting from strap
Date: Tue, 23 Jan 2024 19:04:54 -0800
Message-Id: <20240124030458.98408-7-dregan@broadcom.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20240124030458.98408-1-dregan@broadcom.com>
References: <20240124030458.98408-1-dregan@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: William Zhang <william.zhang@broadcom.com>

BCMBCA broadband SoC based board design does not specify ecc setting in
dts but rather use the SoC NAND strap info to obtain the ecc strength
and spare area size setting. Add brcm,nand-ecc-use-strap dts propety for
this purpose and update driver to support this option.

The generic nand ecc settings still take precedence over this flag. For
example, if nand-ecc-strength is set in the dts, the driver ignores the
strap setting and falls back to original behavior. This makes sure that
the existing BCMBCA board dts still works the old way even the strap
flag is set in the BCMBCA chip dtsi.

Signed-off-by: William Zhang <william.zhang@broadcom.com>
Reviewed-by: David Regan <dregan@broadcom.com>
---
Changes in v3: None
---
Changes in v2:
- Minor cosmetic fixes
---
 drivers/mtd/nand/raw/brcmnand/brcmnand.c | 83 ++++++++++++++++++++++--
 1 file changed, 76 insertions(+), 7 deletions(-)

diff --git a/drivers/mtd/nand/raw/brcmnand/brcmnand.c b/drivers/mtd/nand/raw/brcmnand/brcmnand.c
index 73fdf7ce21aa..869ea64e9189 100644
--- a/drivers/mtd/nand/raw/brcmnand/brcmnand.c
+++ b/drivers/mtd/nand/raw/brcmnand/brcmnand.c
@@ -1038,6 +1038,19 @@ static inline int brcmnand_sector_1k_shift(struct brcmnand_controller *ctrl)
 		return -1;
 }
 
+static int brcmnand_get_sector_size_1k(struct brcmnand_host *host)
+{
+	struct brcmnand_controller *ctrl = host->ctrl;
+	int shift = brcmnand_sector_1k_shift(ctrl);
+	u16 acc_control_offs = brcmnand_cs_offset(ctrl, host->cs,
+						  BRCMNAND_CS_ACC_CONTROL);
+
+	if (shift < 0)
+		return 0;
+
+	return (nand_readreg(ctrl, acc_control_offs) >> shift) & 0x1;
+}
+
 static void brcmnand_set_sector_size_1k(struct brcmnand_host *host, int val)
 {
 	struct brcmnand_controller *ctrl = host->ctrl;
@@ -1055,6 +1068,38 @@ static void brcmnand_set_sector_size_1k(struct brcmnand_host *host, int val)
 	nand_writereg(ctrl, acc_control_offs, tmp);
 }
 
+static int brcmnand_get_spare_size(struct brcmnand_host *host)
+{
+	struct brcmnand_controller *ctrl = host->ctrl;
+	u16 acc_control_offs = brcmnand_cs_offset(ctrl, host->cs,
+						  BRCMNAND_CS_ACC_CONTROL);
+	u32 acc = nand_readreg(ctrl, acc_control_offs);
+
+	return (acc & brcmnand_spare_area_mask(ctrl));
+}
+
+static int brcmnand_get_ecc_strength(struct brcmnand_host *host)
+{
+	struct brcmnand_controller *ctrl = host->ctrl;
+	u16 acc_control_offs = brcmnand_cs_offset(ctrl, host->cs,
+						  BRCMNAND_CS_ACC_CONTROL);
+	int sector_size_1k = brcmnand_get_sector_size_1k(host);
+	int spare_area_size, ecc_level, ecc_strength;
+	u32 acc;
+
+	spare_area_size = brcmnand_get_spare_size(host);
+	acc = nand_readreg(ctrl, acc_control_offs);
+	ecc_level = (acc & brcmnand_ecc_level_mask(ctrl)) >> ctrl->ecc_level_shift;
+	if (sector_size_1k)
+		ecc_strength = ecc_level * 2;
+	else if (spare_area_size == 16 && ecc_level == 15)
+		ecc_strength = 1; /* hamming */
+	else
+		ecc_strength = ecc_level;
+
+	return ecc_strength;
+}
+
 /***********************************************************************
  * CS_NAND_SELECT
  ***********************************************************************/
@@ -2622,19 +2667,43 @@ static int brcmnand_setup_dev(struct brcmnand_host *host)
 		nanddev_get_memorg(&chip->base);
 	struct brcmnand_controller *ctrl = host->ctrl;
 	struct brcmnand_cfg *cfg = &host->hwcfg;
-	char msg[128];
+	struct device_node *np = nand_get_flash_node(chip);
 	u32 offs, tmp, oob_sector;
-	int ret;
+	int ret, sector_size_1k = 0;
+	bool use_strap = false;
+	char msg[128];
 
 	memset(cfg, 0, sizeof(*cfg));
+	use_strap = of_property_read_bool(np, "brcm,nand-ecc-use-strap");
 
-	ret = of_property_read_u32(nand_get_flash_node(chip),
-				   "brcm,nand-oob-sector-size",
+	/*
+	 * Set ECC size and strength based on hw configuration from strap
+	 * if device tree does not specify them and use strap property is set
+	 * If ecc strength is set in dts, don't use strap setting.
+	 */
+	if (chip->ecc.strength)
+		use_strap = 0;
+
+	if (use_strap) {
+		chip->ecc.strength = brcmnand_get_ecc_strength(host);
+		sector_size_1k = brcmnand_get_sector_size_1k(host);
+		if (chip->ecc.size == 0) {
+			if (sector_size_1k < 0)
+				chip->ecc.size = 512;
+			else
+				chip->ecc.size = 512 << sector_size_1k;
+		}
+	}
+
+	ret = of_property_read_u32(np, "brcm,nand-oob-sector-size",
 				   &oob_sector);
 	if (ret) {
-		/* Use detected size */
-		cfg->spare_area_size = mtd->oobsize /
-					(mtd->writesize >> FC_SHIFT);
+		if (use_strap)
+			cfg->spare_area_size = brcmnand_get_spare_size(host);
+		else
+			/* Use detected size */
+			cfg->spare_area_size = mtd->oobsize /
+						(mtd->writesize >> FC_SHIFT);
 	} else {
 		cfg->spare_area_size = oob_sector;
 	}
-- 
2.37.3


