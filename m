Return-Path: <linux-kernel+bounces-129309-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76E3A896863
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 10:24:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2767E2836A6
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 08:24:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA76713340D;
	Wed,  3 Apr 2024 08:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sBb1RJYo"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 289896FE0A;
	Wed,  3 Apr 2024 08:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712131930; cv=none; b=WnzPsbCTxnBkY5HT+ybPVm/UWxsh82qa6XRCguWXGlN5D1JcWaY+63pF91JaW28y30y+bn1729JAqBd1WnmsMSSeJGFKir9XlO2s0fVtza3/COkI1zXRWgHMmVgfbP4i+EGu3U7q5rjhDU0hTGB9bl0/MrVJ3BGhs3Ybrj6KXlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712131930; c=relaxed/simple;
	bh=52e1Ac39U71liESsFrSjezSk4ZT9m1vPZPh5VYUBnRc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=A7SMnPjGG1U1BiujacU06+erruG2SKvm+QrnIgg/Z5JhZI68G68CdZtRTwqmHH8tH/V/j7rMzAr+AQRZ9G9TujIqgOhbsu/4vh/tIWAmf5HWYcHh1qGwgLnDZ/FKxGEzOstUtK/UE94WafPhQWoHqgbfmVMDxL4R5x+ahsnGUds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sBb1RJYo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0DEEC433F1;
	Wed,  3 Apr 2024 08:12:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712131930;
	bh=52e1Ac39U71liESsFrSjezSk4ZT9m1vPZPh5VYUBnRc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sBb1RJYoR9VON/ie8xfuzugs666kkvQHoadEHobYWvOq+CDHvYKaMZ7g+DE0vjM4W
	 e3bQ6ek/kFPpvSRJQhKBHj2VH5syEl4r0BikNhoeX1WrRaQ6rbT3EMCfv5d9YYuMv5
	 OISlqn3gt6/qn5XR+eTLI36T1gQDNemNJhCiHdI6ur7BRAa6uhuiftt6poJmMYcqj3
	 LNZmCrIAh4S9rU2j3z3EhnIBAtK2X0lPDXcHe9QJfvyWQTccR90Ta6VPP2ebyRf4Fl
	 zpwdQl3hmHK4pfVxXKyoY9sAfB/+gVAD1VmYbwI0LbxLJzLt2cQo07Pzq/TmpfLbH7
	 PznqRuMaBJtpQ==
From: Arnd Bergmann <arnd@kernel.org>
To: linux-kernel@vger.kernel.org,
	Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>,
	Saeed Bishara <saeed@ubuntu-saeed.il.marvell.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Ma Ke <make_ruc2021@163.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	Sergey Shtylyov <s.shtylyov@omp.ru>,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Jeff Garzik <jeff@garzik.org>,
	linux-ide@vger.kernel.org
Subject: [PATCH 30/34] sata: mv: drop unnecessary #ifdef checks
Date: Wed,  3 Apr 2024 10:06:48 +0200
Message-Id: <20240403080702.3509288-31-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240403080702.3509288-1-arnd@kernel.org>
References: <20240403080702.3509288-1-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

Building with W=1 shows a warning for an unused variable when CONFIG_PCI
is diabled:

drivers/ata/sata_mv.c:790:35: error: unused variable 'mv_pci_tbl' [-Werror,-Wunused-const-variable]
static const struct pci_device_id mv_pci_tbl[] = {

Move the table into the same block that containsn the pci_driver
definition.

Fixes: 7bb3c5290ca0 ("sata_mv: Remove PCI dependency")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/ata/sata_mv.c | 64 +++++++++++++++++++++----------------------
 1 file changed, 32 insertions(+), 32 deletions(-)

diff --git a/drivers/ata/sata_mv.c b/drivers/ata/sata_mv.c
index e82786c63fbd..697063890f5d 100644
--- a/drivers/ata/sata_mv.c
+++ b/drivers/ata/sata_mv.c
@@ -787,37 +787,6 @@ static const struct ata_port_info mv_port_info[] = {
 	},
 };
 
-static const struct pci_device_id mv_pci_tbl[] = {
-	{ PCI_VDEVICE(MARVELL, 0x5040), chip_504x },
-	{ PCI_VDEVICE(MARVELL, 0x5041), chip_504x },
-	{ PCI_VDEVICE(MARVELL, 0x5080), chip_5080 },
-	{ PCI_VDEVICE(MARVELL, 0x5081), chip_508x },
-	/* RocketRAID 1720/174x have different identifiers */
-	{ PCI_VDEVICE(TTI, 0x1720), chip_6042 },
-	{ PCI_VDEVICE(TTI, 0x1740), chip_6042 },
-	{ PCI_VDEVICE(TTI, 0x1742), chip_6042 },
-
-	{ PCI_VDEVICE(MARVELL, 0x6040), chip_604x },
-	{ PCI_VDEVICE(MARVELL, 0x6041), chip_604x },
-	{ PCI_VDEVICE(MARVELL, 0x6042), chip_6042 },
-	{ PCI_VDEVICE(MARVELL, 0x6080), chip_608x },
-	{ PCI_VDEVICE(MARVELL, 0x6081), chip_608x },
-
-	{ PCI_VDEVICE(ADAPTEC2, 0x0241), chip_604x },
-
-	/* Adaptec 1430SA */
-	{ PCI_VDEVICE(ADAPTEC2, 0x0243), chip_7042 },
-
-	/* Marvell 7042 support */
-	{ PCI_VDEVICE(MARVELL, 0x7042), chip_7042 },
-
-	/* Highpoint RocketRAID PCIe series */
-	{ PCI_VDEVICE(TTI, 0x2300), chip_7042 },
-	{ PCI_VDEVICE(TTI, 0x2310), chip_7042 },
-
-	{ }			/* terminate list */
-};
-
 static const struct mv_hw_ops mv5xxx_ops = {
 	.phy_errata		= mv5_phy_errata,
 	.enable_leds		= mv5_enable_leds,
@@ -4303,6 +4272,37 @@ static int mv_pci_init_one(struct pci_dev *pdev,
 static int mv_pci_device_resume(struct pci_dev *pdev);
 #endif
 
+static const struct pci_device_id mv_pci_tbl[] = {
+	{ PCI_VDEVICE(MARVELL, 0x5040), chip_504x },
+	{ PCI_VDEVICE(MARVELL, 0x5041), chip_504x },
+	{ PCI_VDEVICE(MARVELL, 0x5080), chip_5080 },
+	{ PCI_VDEVICE(MARVELL, 0x5081), chip_508x },
+	/* RocketRAID 1720/174x have different identifiers */
+	{ PCI_VDEVICE(TTI, 0x1720), chip_6042 },
+	{ PCI_VDEVICE(TTI, 0x1740), chip_6042 },
+	{ PCI_VDEVICE(TTI, 0x1742), chip_6042 },
+
+	{ PCI_VDEVICE(MARVELL, 0x6040), chip_604x },
+	{ PCI_VDEVICE(MARVELL, 0x6041), chip_604x },
+	{ PCI_VDEVICE(MARVELL, 0x6042), chip_6042 },
+	{ PCI_VDEVICE(MARVELL, 0x6080), chip_608x },
+	{ PCI_VDEVICE(MARVELL, 0x6081), chip_608x },
+
+	{ PCI_VDEVICE(ADAPTEC2, 0x0241), chip_604x },
+
+	/* Adaptec 1430SA */
+	{ PCI_VDEVICE(ADAPTEC2, 0x0243), chip_7042 },
+
+	/* Marvell 7042 support */
+	{ PCI_VDEVICE(MARVELL, 0x7042), chip_7042 },
+
+	/* Highpoint RocketRAID PCIe series */
+	{ PCI_VDEVICE(TTI, 0x2300), chip_7042 },
+	{ PCI_VDEVICE(TTI, 0x2310), chip_7042 },
+
+	{ }			/* terminate list */
+};
+
 
 static struct pci_driver mv_pci_driver = {
 	.name			= DRV_NAME,
@@ -4315,6 +4315,7 @@ static struct pci_driver mv_pci_driver = {
 #endif
 
 };
+MODULE_DEVICE_TABLE(pci, mv_pci_tbl);
 
 /**
  *      mv_print_info - Dump key info to kernel log for perusal.
@@ -4487,7 +4488,6 @@ static void __exit mv_exit(void)
 MODULE_AUTHOR("Brett Russ");
 MODULE_DESCRIPTION("SCSI low-level driver for Marvell SATA controllers");
 MODULE_LICENSE("GPL v2");
-MODULE_DEVICE_TABLE(pci, mv_pci_tbl);
 MODULE_VERSION(DRV_VERSION);
 MODULE_ALIAS("platform:" DRV_NAME);
 
-- 
2.39.2


