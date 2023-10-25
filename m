Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D4327D6FFB
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 16:54:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344178AbjJYOvV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 10:51:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344379AbjJYOvT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 10:51:19 -0400
Received: from mx.gpxsee.org (mx.gpxsee.org [37.205.14.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D7771137;
        Wed, 25 Oct 2023 07:51:15 -0700 (PDT)
Received: from mgb4.digiteq.red (unknown [62.77.71.229])
        by mx.gpxsee.org (Postfix) with ESMTPSA id A855956681;
        Wed, 25 Oct 2023 16:51:13 +0200 (CEST)
From:   tumic@gpxsee.org
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Martin=20T=C5=AFma?= <martin.tuma@digiteqautomotive.com>
Subject: [PATCH] media: mgb4: Added support for T200 card variant
Date:   Wed, 25 Oct 2023 18:51:47 +0200
Message-Id: <20231025165147.1316-1-tumic@gpxsee.org>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Martin Tůma <martin.tuma@digiteqautomotive.com>

T200 card variants use the XC7A200T FPGA instead of XC7A100T. The SPI FLASH
memory layout is different as the FPGA requires bigger FW images.

Signed-off-by: Martin Tůma <martin.tuma@digiteqautomotive.com>
---
 drivers/media/pci/mgb4/mgb4_core.c | 20 +++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

diff --git a/drivers/media/pci/mgb4/mgb4_core.c b/drivers/media/pci/mgb4/mgb4_core.c
index 3efb33fbf40c..5bfb8a06202e 100644
--- a/drivers/media/pci/mgb4/mgb4_core.c
+++ b/drivers/media/pci/mgb4/mgb4_core.c
@@ -42,6 +42,10 @@
 
 #define MGB4_USER_IRQS 16
 
+#define DIGITEQ_VID 0x1ed8
+#define T100_DID    0x0101
+#define T200_DID    0x0201
+
 ATTRIBUTE_GROUPS(mgb4_pci);
 
 static int flashid;
@@ -151,7 +155,7 @@ static struct spi_master *get_spi_adap(struct platform_device *pdev)
 	return dev ? container_of(dev, struct spi_master, dev) : NULL;
 }
 
-static int init_spi(struct mgb4_dev *mgbdev)
+static int init_spi(struct mgb4_dev *mgbdev, u32 devid)
 {
 	struct resource spi_resources[] = {
 		{
@@ -213,8 +217,13 @@ static int init_spi(struct mgb4_dev *mgbdev)
 	snprintf(mgbdev->fw_part_name, sizeof(mgbdev->fw_part_name),
 		 "mgb4-fw.%d", flashid);
 	mgbdev->partitions[0].name = mgbdev->fw_part_name;
-	mgbdev->partitions[0].size = 0x400000;
-	mgbdev->partitions[0].offset = 0x400000;
+	if (devid == T200_DID) {
+		mgbdev->partitions[0].size = 0x950000;
+		mgbdev->partitions[0].offset = 0x1000000;
+	} else {
+		mgbdev->partitions[0].size = 0x400000;
+		mgbdev->partitions[0].offset = 0x400000;
+	}
 	mgbdev->partitions[0].mask_flags = 0;
 
 	snprintf(mgbdev->data_part_name, sizeof(mgbdev->data_part_name),
@@ -551,7 +560,7 @@ static int mgb4_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 		goto err_video_regs;
 
 	/* SPI FLASH */
-	rv = init_spi(mgbdev);
+	rv = init_spi(mgbdev, id->device);
 	if (rv < 0)
 		goto err_cmt_regs;
 
@@ -666,7 +675,8 @@ static void mgb4_remove(struct pci_dev *pdev)
 }
 
 static const struct pci_device_id mgb4_pci_ids[] = {
-	{ PCI_DEVICE(0x1ed8, 0x0101), },
+	{ PCI_DEVICE(DIGITEQ_VID, T100_DID), },
+	{ PCI_DEVICE(DIGITEQ_VID, T200_DID), },
 	{ 0, }
 };
 MODULE_DEVICE_TABLE(pci, mgb4_pci_ids);

base-commit: 19e67e01eb1e84f3529770d084b93f16a4894c42
-- 
2.40.1

