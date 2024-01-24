Return-Path: <linux-kernel+bounces-36385-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 89FBB839FE7
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 04:06:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F1AFFB243D0
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 03:06:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05104F9C6;
	Wed, 24 Jan 2024 03:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="LZta96gY"
Received: from mail-ot1-f99.google.com (mail-ot1-f99.google.com [209.85.210.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97F35DF4C
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 03:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706065541; cv=none; b=JKSyyWlsZtqM5yw38lAqQpnUFlGYlkyfJjwWE6E6bWZ2MozWi3Usd3urqMoFC4Rfu++kvUl1n7aGOZdOTwaxiSmSP5j3p2jOzI17iSVAO149H4w8iYe+jJX9YQIEer4Puvo4UoCnpMh9W76Nw9vnTFsDYvA2bE8uE4YYLlyl+5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706065541; c=relaxed/simple;
	bh=KbPF/xPqazPFkDjQKd9eZBFY0txuBpXYRvWB0T5xYFs=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CcKqVvBfQQ3YBmsnZNOb6UJJyDH73CIMny3wCuRvvEvhzpkW5+9uRPCc55amuOpKBJnWogJK1yYGquLo83cT4M8abVqof1geigsqVaQly5QBKqfqfFx5qThsfYmXL5hwXCzuRrONtYZSK5Pj4cCdtMHwlX5ypS+B/h21xUqlrUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=LZta96gY; arc=none smtp.client-ip=209.85.210.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-ot1-f99.google.com with SMTP id 46e09a7af769-6dde1f23060so3183675a34.2
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 19:05:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1706065539; x=1706670339; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PwegdSybI33Nmb+F9DKKGVukdHc03A/AUPX3yW5tWW0=;
        b=LZta96gYH/juOdI4NKKrxhnKUtFUP6vA5EZasHjGZO1KDjHqmSufsy4umy1yLOmhIz
         ixWEYw/xkwwiR7JLgmWEwBYfjc6NVCJNcXMPWBir6sUjhgkf/Ga00Ixa47Qttv92XSkO
         H5fkXGpdB6aVnknywx8Dm6XYagroDmw4sj2sQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706065539; x=1706670339;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PwegdSybI33Nmb+F9DKKGVukdHc03A/AUPX3yW5tWW0=;
        b=ZgGoksyC3YwElHqKe5I759WM4bVQ9q/V/B8wFQWQ0U4IeDdVvebwGWQLEE5lGw6DjW
         lLvufj6wZR25raziK4Gk4TIR+rpYzTsanqiWdCC961Ro/mSBHZ+Gohw1uSpFVKrFi6fa
         Gu0LH9GSjx9hpVQBOw8EwRrS/J4duFZ2Tfxb9ThesmEx2wgPZLMCCoS4DB7/qmvZ+9A+
         mhGP+EzcFFyinzgRSthGZ6aQh7KyJiSaE+i2Q0V/3IxW+FClioyKs9qonxKka34r5aym
         4AGHwFdQ++m57VFy1K+NWolwaVighFaq1tfTI0/RbVUpNsujEhkMIXh/fzI96zpDRQLA
         cD4A==
X-Gm-Message-State: AOJu0Yx2iBH1gXwz4IDJUCclGpG6Ewc9ZAmrgdOPxYcqY0YLByvgn9a5
	fhZ61n+gtTBCQJ0KTo5x7vT8fObwGGOzmJlQHHVtChuP4DER+kMWuTxEDSLj0Zrl85vaYVNfPBA
	AZUw9JgX3o7K6k2TgulKMxmw934GcjA==
X-Google-Smtp-Source: AGHT+IFVKxA8y/gg9xufz6NOdEljs2B3vozRSVt/ENRpavZMC/Sj/xdFXZbx377gJMdUwpQqG0oqZkroTdnV
X-Received: by 2002:a05:6830:22f8:b0:6db:ffb0:7a4d with SMTP id t24-20020a05683022f800b006dbffb07a4dmr958490otc.45.1706065538813;
        Tue, 23 Jan 2024 19:05:38 -0800 (PST)
Received: from bcacpedev-irv-3.lvn.broadcom.net ([192.19.161.250])
        by smtp-relay.gmail.com with ESMTPS id c22-20020a056830349600b006dc7502beabsm455320otu.3.2024.01.23.19.05.37
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Jan 2024 19:05:38 -0800 (PST)
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
Subject: [PATCH v3 05/10] mtd: rawnand: brcmnand: Add BCMBCA read data bus interface
Date: Tue, 23 Jan 2024 19:04:53 -0800
Message-Id: <20240124030458.98408-6-dregan@broadcom.com>
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

The BCMBCA broadband SoC integrates the NAND controller differently than
STB, iProc and other SoCs.  It has different endianness for NAND cache
data.

Add a SoC read data bus shim for BCMBCA to meet the specific SoC need
and performance improvement using the optimized memcpy function on NAND
cache memory.

Signed-off-by: William Zhang <william.zhang@broadcom.com>
Reviewed-by: David Regan <dregan@broadcom.com>
---
Changes in v3:
- Updated bcmbca_read_data_bus comment
---
Changes in v2:
- Drop the is_param argument to the read data bus function now that we
have the exec_op API to read the parameter page and ONFI data
- Remove be32_to_cpu from brcmnand_read_data_bus
---
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
index 8faca43ae1ff..73fdf7ce21aa 100644
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
index 928114c0be5e..7261a69989fe 100644
--- a/drivers/mtd/nand/raw/brcmnand/brcmnand.h
+++ b/drivers/mtd/nand/raw/brcmnand/brcmnand.h
@@ -24,6 +24,8 @@ struct brcmnand_soc {
 	void (*ctlrdy_set_enabled)(struct brcmnand_soc *soc, bool en);
 	void (*prepare_data_bus)(struct brcmnand_soc *soc, bool prepare,
 				 bool is_param);
+	void (*read_data_bus)(struct brcmnand_soc *soc, void __iomem *flash_cache,
+				  u32 *buffer, int fc_words);
 	const struct brcmnand_io_ops *ops;
 };
 
-- 
2.37.3


