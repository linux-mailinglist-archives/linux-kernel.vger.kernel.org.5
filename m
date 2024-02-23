Return-Path: <linux-kernel+bounces-77736-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C294860992
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 04:50:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DF3651F25F27
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 03:50:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12C7E168C4;
	Fri, 23 Feb 2024 03:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="qsjSA6Y+"
Received: from relay.smtp-ext.broadcom.com (unknown [192.19.166.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89769125D1
	for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 03:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.19.166.231
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708660115; cv=none; b=Q7aJAMTE5BYbM2K90C8SZSKbbLS0bMqOPj33anyaDNZmPqSposfi9kiCw3o5LJWvYLyBq6N3zLjW1PGxdsKYIK8aazM892XT3xPvIo2Fx38NiqgyhGpqNXBlt4gidgOiNMyfS9ITCMlF6Kx4VQfoG0hKG7OnVvzFKnULTrdXwPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708660115; c=relaxed/simple;
	bh=ig15Aoje6UB9lmYtH7+7slD4QP7mgW8tuGW4LKGdWhA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=I8O8wz5+hATKaV80x48ra7GEzDzyn2hFHGBZ8v9cPs3rr/Wp4KV3ga9aHzcTcPoiV8m88wGNyZeT21VUfz1WsTipJ1Yyc/8HtiZgn2Uu9DYl0W6GqioWW+ko7CBwVVW1ZlAUzNffHKcGeKuGW/e467JEP2DgkphufpufydADHf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=qsjSA6Y+; arc=none smtp.client-ip=192.19.166.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: from mail-lvn-it-01.lvn.broadcom.net (mail-lvn-it-01.lvn.broadcom.net [10.36.132.253])
	by relay.smtp-ext.broadcom.com (Postfix) with ESMTP id F1E62C001C13;
	Thu, 22 Feb 2024 19:48:32 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 relay.smtp-ext.broadcom.com F1E62C001C13
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
	s=dkimrelay; t=1708660113;
	bh=ig15Aoje6UB9lmYtH7+7slD4QP7mgW8tuGW4LKGdWhA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qsjSA6Y+7GXJIAxM78iptjlsQ0jaHeqmZnL9zLJqKnPEuJURQAy6FPqI8VB/YaF/N
	 ecGxX79wEZ6hcqHfOn7clJNq75PZPbeV8KszT9WWIuKEajjWAS7nnzNqWXQ2xdOVY2
	 MzSiqso9Ms7n3wnoQRGpA15j8fpB8V7sHS9S3X+Q=
Received: from bcacpedev-irv-3.lvn.broadcom.net (bcacpedev-irv-3.lvn.broadcom.net [10.173.232.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail-lvn-it-01.lvn.broadcom.net (Postfix) with ESMTPSA id 8561618041CAC4;
	Thu, 22 Feb 2024 19:48:31 -0800 (PST)
From: William Zhang <william.zhang@broadcom.com>
To: Linux MTD List <linux-mtd@lists.infradead.org>,
	Linux ARM List <linux-arm-kernel@lists.infradead.org>,
	Broadcom Kernel List <bcm-kernel-feedback-list@broadcom.com>
Cc: f.fainelli@gmail.com,
	kursad.oney@broadcom.com,
	joel.peshkin@broadcom.com,
	anand.gore@broadcom.com,
	dregan@mail.com,
	kamal.dasu@broadcom.com,
	tomer.yacoby@broadcom.com,
	dan.beygelman@broadcom.com,
	William Zhang <william.zhang@broadcom.com>,
	David Regan <dregan@broadcom.com>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	linux-kernel@vger.kernel.org,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Brian Norris <computersforpeace@gmail.com>,
	Richard Weinberger <richard@nod.at>,
	=?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>,
	Florian Fainelli <florian.fainelli@broadcom.com>
Subject: [PATCH v6 11/13] mtd: rawnand: brcmnand: Add BCMBCA read data bus interface
Date: Thu, 22 Feb 2024 19:47:56 -0800
Message-Id: <20240223034758.13753-12-william.zhang@broadcom.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20240223034758.13753-1-william.zhang@broadcom.com>
References: <20240223034758.13753-1-william.zhang@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The BCMBCA broadband SoC integrates the NAND controller differently than
STB, iProc and other SoCs.  It has different endianness for NAND cache
data.

Add a SoC read data bus shim for BCMBCA to meet the specific SoC need
and performance improvement using the optimized memcpy function on NAND
cache memory.

Signed-off-by: William Zhang <william.zhang@broadcom.com>
Reviewed-by: David Regan <dregan@broadcom.com>

---

Changes in v6:
- Fix style issue

Changes in v5: None
Changes in v4: None
Changes in v3:
- Updated bcmbca_read_data_bus comment

Changes in v2:
- Drop the is_param argument to the read data bus function now that we
have the exec_op API to read the parameter page and ONFI data
- Remove be32_to_cpu from brcmnand_read_data_bus

 drivers/mtd/nand/raw/brcmnand/bcmbca_nand.c | 27 +++++++++++++++++++++
 drivers/mtd/nand/raw/brcmnand/brcmnand.c    | 20 ++++++++++++---
 drivers/mtd/nand/raw/brcmnand/brcmnand.h    |  2 ++
 3 files changed, 46 insertions(+), 3 deletions(-)

diff --git a/drivers/mtd/nand/raw/brcmnand/bcmbca_nand.c b/drivers/mtd/nand/raw/brcmnand/bcmbca_nand.c
index 3e2f3b79788d..7ad3e7a98f97 100644
--- a/drivers/mtd/nand/raw/brcmnand/bcmbca_nand.c
+++ b/drivers/mtd/nand/raw/brcmnand/bcmbca_nand.c
@@ -26,6 +26,18 @@ enum {
 	BCMBCA_CTLRDY		= BIT(4),
 };
 
+#if defined(CONFIG_ARM64)
+#define ALIGN_REQ		8
+#else
+#define ALIGN_REQ		4
+#endif
+
+static inline bool bcmbca_nand_is_buf_aligned(void *flash_cache,  void *buffer)
+{
+	return IS_ALIGNED((uintptr_t)buffer, ALIGN_REQ) &&
+				IS_ALIGNED((uintptr_t)flash_cache, ALIGN_REQ);
+}
+
 static bool bcmbca_nand_intc_ack(struct brcmnand_soc *soc)
 {
 	struct bcmbca_nand_soc *priv =
@@ -56,6 +68,20 @@ static void bcmbca_nand_intc_set(struct brcmnand_soc *soc, bool en)
 	brcmnand_writel(val, mmio);
 }
 
+static void bcmbca_read_data_bus(struct brcmnand_soc *soc,
+				 void __iomem *flash_cache,  u32 *buffer, int fc_words)
+{
+	/*
+	 * memcpy can do unaligned aligned access depending on source
+	 * and dest address, which is incompatible with nand cache. Fallback
+	 * to the memcpy_fromio in such case
+	 */
+	if (bcmbca_nand_is_buf_aligned((void *)flash_cache, buffer))
+		memcpy((void *)buffer, (void *)flash_cache, fc_words * 4);
+	else
+		memcpy_fromio((void *)buffer, flash_cache, fc_words * 4);
+}
+
 static int bcmbca_nand_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
@@ -73,6 +99,7 @@ static int bcmbca_nand_probe(struct platform_device *pdev)
 
 	soc->ctlrdy_ack = bcmbca_nand_intc_ack;
 	soc->ctlrdy_set_enabled = bcmbca_nand_intc_set;
+	soc->read_data_bus = bcmbca_read_data_bus;
 
 	return brcmnand_probe(pdev, soc);
 }
diff --git a/drivers/mtd/nand/raw/brcmnand/brcmnand.c b/drivers/mtd/nand/raw/brcmnand/brcmnand.c
index f1f0de50b5f7..ef7d340475be 100644
--- a/drivers/mtd/nand/raw/brcmnand/brcmnand.c
+++ b/drivers/mtd/nand/raw/brcmnand/brcmnand.c
@@ -851,6 +851,20 @@ static inline u32 edu_readl(struct brcmnand_controller *ctrl,
 	return brcmnand_readl(ctrl->edu_base + offs);
 }
 
+static inline void brcmnand_read_data_bus(struct brcmnand_controller *ctrl,
+					  void __iomem *flash_cache, u32 *buffer, int fc_words)
+{
+	struct brcmnand_soc *soc = ctrl->soc;
+	int i;
+
+	if (soc->read_data_bus) {
+		soc->read_data_bus(soc, flash_cache, buffer, fc_words);
+	} else {
+		for (i = 0; i < fc_words; i++)
+			buffer[i] = brcmnand_read_fc(ctrl, i);
+	}
+}
+
 static void brcmnand_clear_ecc_addr(struct brcmnand_controller *ctrl)
 {
 
@@ -1975,7 +1989,7 @@ static int brcmnand_read_by_pio(struct mtd_info *mtd, struct nand_chip *chip,
 {
 	struct brcmnand_host *host = nand_get_controller_data(chip);
 	struct brcmnand_controller *ctrl = host->ctrl;
-	int i, j, ret = 0;
+	int i, ret = 0;
 
 	brcmnand_clear_ecc_addr(ctrl);
 
@@ -1988,8 +2002,8 @@ static int brcmnand_read_by_pio(struct mtd_info *mtd, struct nand_chip *chip,
 		if (likely(buf)) {
 			brcmnand_soc_data_bus_prepare(ctrl->soc, false);
 
-			for (j = 0; j < FC_WORDS; j++, buf++)
-				*buf = brcmnand_read_fc(ctrl, j);
+			brcmnand_read_data_bus(ctrl, ctrl->nand_fc, buf, FC_WORDS);
+			buf += FC_WORDS;
 
 			brcmnand_soc_data_bus_unprepare(ctrl->soc, false);
 		}
diff --git a/drivers/mtd/nand/raw/brcmnand/brcmnand.h b/drivers/mtd/nand/raw/brcmnand/brcmnand.h
index 928114c0be5e..9f171252a2ae 100644
--- a/drivers/mtd/nand/raw/brcmnand/brcmnand.h
+++ b/drivers/mtd/nand/raw/brcmnand/brcmnand.h
@@ -24,6 +24,8 @@ struct brcmnand_soc {
 	void (*ctlrdy_set_enabled)(struct brcmnand_soc *soc, bool en);
 	void (*prepare_data_bus)(struct brcmnand_soc *soc, bool prepare,
 				 bool is_param);
+	void (*read_data_bus)(struct brcmnand_soc *soc, void __iomem *flash_cache,
+			      u32 *buffer, int fc_words);
 	const struct brcmnand_io_ops *ops;
 };
 
-- 
2.37.3


