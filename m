Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6A017A76C3
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 11:02:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234149AbjITJCc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 05:02:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233907AbjITJCM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 05:02:12 -0400
X-Greylist: delayed 475 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 20 Sep 2023 02:00:22 PDT
Received: from mail.tuxedocomputers.com (mail.tuxedocomputers.com [157.90.84.7])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 144E61FEB
        for <linux-kernel@vger.kernel.org>; Wed, 20 Sep 2023 02:00:22 -0700 (PDT)
Received: from wse.fritz.box (p5de45a8d.dip0.t-ipconnect.de [93.228.90.141])
        (Authenticated sender: wse@tuxedocomputers.com)
        by mail.tuxedocomputers.com (Postfix) with ESMTPA id 213F42FC00D1;
        Wed, 20 Sep 2023 10:52:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tuxedocomputers.com;
        s=default; t=1695199945;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=42LaC+Ki9kS2X5mr9P1WxGQwcv49odezsy0vgHHfVsw=;
        b=mv0T9T498iqueOpCOv40rVcUWk2+Ha5utGq1dUZye38ZUOBKjBTzWioTp5oV7/1VXUep0C
        Nz1tVqDZ0TCIjcYQdIa1gZP+RpuMN68XYrHHNzRVWxAgR3Ry/6PyrDYp7AF642pPn4Qjjn
        xMVGyHv+De0RuCec2o+hwsSpT01epTs=
Authentication-Results: mail.tuxedocomputers.com;
        auth=pass smtp.auth=wse@tuxedocomputers.com smtp.mailfrom=wse@tuxedocomputers.com
From:   Werner Sembach <wse@tuxedocomputers.com>
To:     Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>
Cc:     Georg Gottleuber <ggo@tuxedocomputers.com>,
        Werner Sembach <wse@tuxedocomputers.com>,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] nvme-pci: Add sleep quirk for Kingston drives
Date:   Wed, 20 Sep 2023 10:52:10 +0200
Message-Id: <20230920085210.22573-1-wse@tuxedocomputers.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Georg Gottleuber <ggo@tuxedocomputers.com>

Some Kingston NV1 and A2000 are wasting a lot of power on specific TUXEDO
platforms in s2idle sleep if 'Simple Suspend' is used.

This patch applies a new quirk 'Force No Simple Suspend' to achieve a
low power sleep without 'Simple Suspend'.

Signed-off-by: Werner Sembach <wse@tuxedocomputers.com>
Signed-off-by: Georg Gottleuber <ggo@tuxedocomputers.com>
Cc: <stable@vger.kernel.org>
---
 drivers/nvme/host/nvme.h |  5 +++++
 drivers/nvme/host/pci.c  | 16 +++++++++++++++-
 2 files changed, 20 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index f35647c470afa..74f74b459f5fa 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -156,6 +156,11 @@ enum nvme_quirks {
 	 * No temperature thresholds for channels other than 0 (Composite).
 	 */
 	NVME_QUIRK_NO_SECONDARY_TEMP_THRESH	= (1 << 19),
+
+	/*
+	 * Disables simple suspend/resume path.
+	 */
+	NVME_QUIRK_FORCE_NO_SIMPLE_SUSPEND	= (1 << 20),
 };
 
 /*
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 347cb5daebc3c..b4e6f0d21a44c 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -2903,6 +2903,18 @@ static unsigned long check_vendor_combination_bug(struct pci_dev *pdev)
 		if ((dmi_match(DMI_BOARD_VENDOR, "LENOVO")) &&
 		     dmi_match(DMI_BOARD_NAME, "LNVNB161216"))
 			return NVME_QUIRK_SIMPLE_SUSPEND;
+	} else if (pdev->vendor == 0x2646 && (pdev->device == 0x2263 ||
+		   pdev->device == 0x500f)) {
+		/*
+		 * Exclude some Kingston NV1 and A2000 devices from
+		 * NVME_QUIRK_SIMPLE_SUSPEND. Do a full suspend to save a
+		 * lot fo energy with s2idle sleep on some TUXEDO platforms.
+		 */
+		if (dmi_match(DMI_BOARD_NAME, "NS5X_NS7XAU") ||
+		    dmi_match(DMI_BOARD_NAME, "NS5x_7xAU") ||
+		    dmi_match(DMI_BOARD_NAME, "NS5x_7xPU") ||
+		    dmi_match(DMI_BOARD_NAME, "PH4PRX1_PH6PRX1"))
+			return NVME_QUIRK_FORCE_NO_SIMPLE_SUSPEND;
 	}
 
 	return 0;
@@ -2933,7 +2945,9 @@ static struct nvme_dev *nvme_pci_alloc_dev(struct pci_dev *pdev,
 	dev->dev = get_device(&pdev->dev);
 
 	quirks |= check_vendor_combination_bug(pdev);
-	if (!noacpi && acpi_storage_d3(&pdev->dev)) {
+	if (!noacpi &&
+	    !(quirks & NVME_QUIRK_FORCE_NO_SIMPLE_SUSPEND) &&
+	    acpi_storage_d3(&pdev->dev)) {
 		/*
 		 * Some systems use a bios work around to ask for D3 on
 		 * platforms that support kernel managed suspend.
-- 
2.34.1

