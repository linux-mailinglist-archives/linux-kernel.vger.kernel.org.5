Return-Path: <linux-kernel+bounces-88840-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D38786E773
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 18:39:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8827DB2E222
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 17:35:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D8151170D;
	Fri,  1 Mar 2024 17:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Oc+DiUx3"
Received: from relay.smtp-ext.broadcom.com (unknown [192.19.166.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 059AC39FF7
	for <linux-kernel@vger.kernel.org>; Fri,  1 Mar 2024 17:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.19.166.231
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709314419; cv=none; b=I+xpusp8SfyLE/umaWBNNmAIjQiiUsb1RLj6anEZM98RVHb5biEKASSs3cnNMLsv0x1XbQoUvAUPov2dd9cXbdXZeErh1FnAxPgBtn33HJ/cyRuR8BJLBJD1tSHkHhS6evfB83SuXJfL0g9hHRFn/QgNMOSY2ztxRSRro5LgF7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709314419; c=relaxed/simple;
	bh=6C7kUWjoZj+bDBVzxj0XxvUNYCpEIU3ZAbUZhUfTY7s=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=DBi+Fo86KDSXlu2CGyg3sfHJm44bpzbZ01AJZFmhymTWrW8CsrANJmltNoOAHfBksWv985XqJO3+cAE+AUtL3iIHfy2WVJjfHQCUkhWoO1aZdD8o7dpeiOObmdIZ+F3LvBthRP19bs8YAqtYMhAMbqsLz9xW7na/WBq8pgPNnz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=Oc+DiUx3; arc=none smtp.client-ip=192.19.166.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: from mail-lvn-it-01.lvn.broadcom.net (mail-lvn-it-01.lvn.broadcom.net [10.36.132.253])
	by relay.smtp-ext.broadcom.com (Postfix) with ESMTP id 6970FC001BE3;
	Fri,  1 Mar 2024 09:33:31 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 relay.smtp-ext.broadcom.com 6970FC001BE3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
	s=dkimrelay; t=1709314411;
	bh=6C7kUWjoZj+bDBVzxj0XxvUNYCpEIU3ZAbUZhUfTY7s=;
	h=From:To:Cc:Subject:Date:From;
	b=Oc+DiUx3upQyGnYCXF5R8QY4m108L92oXeUVTSXMT8Ftt5uEWCuz6bBxlr9MNpi2H
	 7j8k7Pv9f2sgRSVumab94vpUDzIoNyUJ4N2W8okEmgf1zx8XE+b3puc3Ek4t64TG6J
	 Sr/eBB9WXozgkm+VqVdXj5VVK1BfLrnZPRJqJx5c=
Received: from bcacpedev-irv-3.lvn.broadcom.net (bcacpedev-irv-3.lvn.broadcom.net [10.173.232.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail-lvn-it-01.lvn.broadcom.net (Postfix) with ESMTPSA id D363318041CAC4;
	Fri,  1 Mar 2024 09:33:29 -0800 (PST)
From: William Zhang <william.zhang@broadcom.com>
To: Linux MTD List <linux-mtd@lists.infradead.org>,
	Linux ARM List <linux-arm-kernel@lists.infradead.org>,
	Broadcom Kernel List <bcm-kernel-feedback-list@broadcom.com>
Cc: f.fainelli@gmail.com,
	kursad.oney@broadcom.com,
	joel.peshkin@broadcom.com,
	miquel.raynal@bootlin.com,
	anand.gore@broadcom.com,
	dregan@mail.com,
	kamal.dasu@broadcom.com,
	tomer.yacoby@broadcom.com,
	dan.beygelman@broadcom.com,
	William Zhang <william.zhang@broadcom.com>,
	David Regan <dregan@broadcom.com>,
	linux-kernel@vger.kernel.org,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Brian Norris <computersforpeace@gmail.com>,
	Richard Weinberger <richard@nod.at>
Subject: [PATCH v8] mtd: rawnand: brcmnand: Add support for getting ecc setting from strap
Date: Fri,  1 Mar 2024 09:33:07 -0800
Message-Id: <20240301173308.226004-1-william.zhang@broadcom.com>
X-Mailer: git-send-email 2.37.3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

BCMBCA broadband SoC based board design does not specify ecc setting in
dts but rather use the SoC NAND strap info to obtain the ecc strength
and spare area size setting. Add brcm,nand-ecc-use-strap dts propety for
this purpose and update driver to support this option. However these two
options can not be used at the same time.

Signed-off-by: William Zhang <william.zhang@broadcom.com>
Reviewed-by: David Regan <dregan@broadcom.com>

---

Changes in v8:
- Remove the patch revision info from the commit log

Changes in v7:
- Simply the logic for sector size detection
- Update the error message

Changes in v6:
- Combine the ecc step size and ecc strength into one get function
- Treat it as error condition if both brcm,nand-ecc-use-strap and nand
ecc dts properties are set
- Add intermediate steps to get the sector size bitfield

Changes in v4:
- Update the comments for ecc setting selection

Changes in v2:
- Minor cosmetic fixes

 drivers/mtd/nand/raw/brcmnand/brcmnand.c | 83 ++++++++++++++++++++++--
 1 file changed, 77 insertions(+), 6 deletions(-)

diff --git a/drivers/mtd/nand/raw/brcmnand/brcmnand.c b/drivers/mtd/nand/raw/brcmnand/brcmnand.c
index ef7d340475be..8a26ff97c8e2 100644
--- a/drivers/mtd/nand/raw/brcmnand/brcmnand.c
+++ b/drivers/mtd/nand/raw/brcmnand/brcmnand.c
@@ -1038,6 +1038,22 @@ static inline int brcmnand_sector_1k_shift(struct brcmnand_controller *ctrl)
 		return -1;
 }
 
+static bool brcmnand_get_sector_size_1k(struct brcmnand_host *host)
+{
+	struct brcmnand_controller *ctrl = host->ctrl;
+	int sector_size_bit = brcmnand_sector_1k_shift(ctrl);
+	u16 acc_control_offs = brcmnand_cs_offset(ctrl, host->cs,
+						  BRCMNAND_CS_ACC_CONTROL);
+	u32 acc_control;
+
+	if (sector_size_bit < 0)
+		return false;
+
+	acc_control = nand_readreg(ctrl, acc_control_offs);
+
+	return ((acc_control & BIT(sector_size_bit)) != 0);
+}
+
 static void brcmnand_set_sector_size_1k(struct brcmnand_host *host, int val)
 {
 	struct brcmnand_controller *ctrl = host->ctrl;
@@ -1055,6 +1071,43 @@ static void brcmnand_set_sector_size_1k(struct brcmnand_host *host, int val)
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
+static void brcmnand_get_ecc_settings(struct brcmnand_host *host, struct nand_chip *chip)
+{
+	struct brcmnand_controller *ctrl = host->ctrl;
+	u16 acc_control_offs = brcmnand_cs_offset(ctrl, host->cs,
+						  BRCMNAND_CS_ACC_CONTROL);
+	bool sector_size_1k = brcmnand_get_sector_size_1k(host);
+	int spare_area_size, ecc_level;
+	u32 acc;
+
+	spare_area_size = brcmnand_get_spare_size(host);
+	acc = nand_readreg(ctrl, acc_control_offs);
+	ecc_level = (acc & brcmnand_ecc_level_mask(ctrl)) >> ctrl->ecc_level_shift;
+	if (sector_size_1k)
+		chip->ecc.strength = ecc_level * 2;
+	else if (spare_area_size == 16 && ecc_level == 15)
+		chip->ecc.strength = 1; /* hamming */
+	else
+		chip->ecc.strength = ecc_level;
+
+	if (chip->ecc.size == 0) {
+		if (sector_size_1k)
+			chip->ecc.size = 1024;
+		else
+			chip->ecc.size = 512;
+	}
+}
+
 /***********************************************************************
  * CS_NAND_SELECT
  ***********************************************************************/
@@ -2625,19 +2678,37 @@ static int brcmnand_setup_dev(struct brcmnand_host *host)
 		nanddev_get_memorg(&chip->base);
 	struct brcmnand_controller *ctrl = host->ctrl;
 	struct brcmnand_cfg *cfg = &host->hwcfg;
-	char msg[128];
+	struct device_node *np = nand_get_flash_node(chip);
 	u32 offs, tmp, oob_sector;
+	bool use_strap = false;
+	char msg[128];
 	int ret;
 
 	memset(cfg, 0, sizeof(*cfg));
+	use_strap = of_property_read_bool(np, "brcm,nand-ecc-use-strap");
 
-	ret = of_property_read_u32(nand_get_flash_node(chip),
-				   "brcm,nand-oob-sector-size",
+	/*
+	 * Either nand-ecc-xxx or brcm,nand-ecc-use-strap can be set. Error out
+	 * if both exist.
+	 */
+	if (chip->ecc.strength && use_strap) {
+		dev_err(ctrl->dev,
+			"ECC strap and DT ECC configuration properties are mutually exclusive\n");
+		return -EINVAL;
+	}
+
+	if (use_strap)
+		brcmnand_get_ecc_settings(host, chip);
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


