Return-Path: <linux-kernel+bounces-30537-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7ED6E832004
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 20:56:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 03B79282424
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 19:56:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8B6D32C8A;
	Thu, 18 Jan 2024 19:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="HyM2oou3"
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 463762EB04
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 19:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705607674; cv=none; b=uwa6CLosEGxzWhX6IiAcDb8Ydn9wIZCFW5XdmOSK6vVLHs1ouJcWmPC2F1RPmZZTxFRgVsUICAMiBUARYSdwf+Dj1mEbhIUQ+N7QgGgNroNgDXZk5SfNJHdoXH1mU162yHKKH1cLEjXyTk1GhzZ3iEqR8lQME+Gk1z+rZYixZqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705607674; c=relaxed/simple;
	bh=ieZnSP1HPayjVvCaS16c9Q3yOGYvGZsLpA9KG5wtdB0=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=f9tuq6X2zAPECoVJJR2xMESvmOTz/ng+yWQCR+Tw1dmpw7/1vU5Wg0AbFWe9EPSQNVX3NwtBDfzyeSIBSGBV3Pabke0Wgo9qQ9zdt0tvkUq2r7QI1OAGHNInQDpAPUKcU8WEASE4uVGCwYeRZDZ3g9ukTDzg35DaWYgc4JHeFjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=HyM2oou3; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-5cd8667c59eso28374a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 11:54:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1705607672; x=1706212472; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mHG/CBC8rn6ZfrmjB7OHI3uZq/Vu0lS8L/ATSVkqU0I=;
        b=HyM2oou3+umjlQs0MW7BI6A+9MjYXE8iP5kbJP79jLpkUlr0ZUThTUsSrnD4KrmwWj
         g+UmaS6GMo88Epq9A4OElOegC09g7Jciz5aUQxxUhoV2s/kTlKsZOmfxVrv5nfI7Vutm
         qvXijIK4qst791KLRzK/JAB8FcszvwhnJ08gk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705607672; x=1706212472;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mHG/CBC8rn6ZfrmjB7OHI3uZq/Vu0lS8L/ATSVkqU0I=;
        b=nLaA6/4tSus3szWySCwE2VG6A+ysvHEaXEB1iY04XXysWwZy3M/thCyOow+tEahVch
         FdPxYsmZlV80Faf5xIf9G3llPiq3bSKlvYSpbqfB8RBerIIoBeg1vBVoajzGKyJQHhc4
         oEVRKq/oZI3jWxpSXn/u1S8vQ1VW4+dym+3CfwZOFxCh88RKkRwoYOxAYI7D/9FGj6rX
         STttgggAQCrbHQY74kXa+FD3zCSYiFdnrAy7g9/FJvwi14zcKMurS1TYKPypU2kZ5VIe
         mD/cGSGb14i66t0c1kC9p1z1XkP0XG5I9Y2TIHDQEdThjzGnKauq5QyY9kODF2nLZjBT
         3QEg==
X-Gm-Message-State: AOJu0Yxc0o6A5Vi1xh+VzbMk1OCysRRLRx6d4rz3DcG4nYSLl0yeiwHZ
	Jpd8eYzJlxuEz+qLd/4FilrkobWfl+useR6GcQWSq3ZfF6EhcHoaFm/mA45V9w==
X-Google-Smtp-Source: AGHT+IGhfcEKMuaixl56xZn2ojB4l1QrXGrP4PaGBMLyQt8DPvX03FhtlIfLh5G35v/NPeIgeG6OAQ==
X-Received: by 2002:a17:90a:e557:b0:28e:7e16:6ff6 with SMTP id ei23-20020a17090ae55700b0028e7e166ff6mr1190925pjb.31.1705607672680;
        Thu, 18 Jan 2024 11:54:32 -0800 (PST)
Received: from bcacpedev-irv-3.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id rr12-20020a17090b2b4c00b0028d9b5d41edsm2263805pjb.38.2024.01.18.11.54.31
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Jan 2024 11:54:32 -0800 (PST)
From: dregan@broadcom.com
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
Subject: [PATCH v2 06/10] mtd: rawnand: brcmnand: Add support for getting ecc setting from strap
Date: Thu, 18 Jan 2024 11:53:52 -0800
Message-Id: <20240118195356.133391-7-dregan@broadcom.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20240118195356.133391-1-dregan@broadcom.com>
References: <20240118195356.133391-1-dregan@broadcom.com>
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


