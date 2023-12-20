Return-Path: <linux-kernel+bounces-7413-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3596081A799
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 21:28:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E0B9F286C08
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 20:28:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 099DB48CCA;
	Wed, 20 Dec 2023 20:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="nlrADYT5"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C73B0487B4
	for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 20:28:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-781048954d9so922085a.1
        for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 12:28:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1703104126; x=1703708926; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=P6vFHsPeq14cIqL7DrTAKLDC/8hRUDzvN2wp3VY992g=;
        b=nlrADYT5RNwoPCbRrA7CjOmp5bVru//KuBkfat9TXRRzcaxhkUsMKxNsMLz+h7aYxI
         bNcx7BRmvjVS2xcS5fwe4g6+I3P8hZnu6S6kOEcfWnrMSSs97naEEe/FWOXSRqlr4CFr
         zQtebu46VknkuT+rlzdZ4qcjliKSuVoeMLKTc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703104126; x=1703708926;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=P6vFHsPeq14cIqL7DrTAKLDC/8hRUDzvN2wp3VY992g=;
        b=vsfReeKRvb8K+IW8L8B/F5cXpX/E6z21ovxiGMMzcWvTfveWfR1LalFml/BaJ9169R
         bWrqKBwCR3LO0Z8Dkox7hgdd1DIYSKQdJVrscUTGaa3WqY8YYIbTB5mq+jfE0OrI96/A
         DmH9njrO4ncnij2S5XoSr+HE8LfUBHN6bhp+CahQnjDFszYJGok8dd0gXdQHWxW3QiYe
         h2oqS0HaOz5rz4EPqcMfr4DtDfE6oreHfqyg2NeYj+uGpmM0WoxIbgDRhCArAKwHVxFp
         QfG8KvW+uiM47ax2GOE45sgf1pO/sE10ag6QNmizj03uwVnIP6mDPe+swRlNYMWfKzVL
         xNCQ==
X-Gm-Message-State: AOJu0YwwR6PU0zn3HGPmwQir3YSpyPQCa0/LkN8CKjvaGIF3eiW63Pyl
	HHnUBPkTsynI48UbfMfK1VvM/ZDb59ML6ek1ym0=
X-Google-Smtp-Source: AGHT+IGPYpHFC5bPPr4wTlEBDURM4e8EgyIpmVBCtMIk0Sz5KE+bWmGlPHxq4zuHo53IT42ivQZEyA==
X-Received: by 2002:a05:620a:6222:b0:77f:9fa3:ea4f with SMTP id ou34-20020a05620a622200b0077f9fa3ea4fmr12362907qkn.104.1703104125695;
        Wed, 20 Dec 2023 12:28:45 -0800 (PST)
Received: from eshimanovich.nyc.corp.google.com ([2620:0:1003:314:c2ca:221b:b9cd:1ae7])
        by smtp.gmail.com with ESMTPSA id p16-20020a05620a22f000b0076efaec147csm175383qki.45.2023.12.20.12.28.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Dec 2023 12:28:45 -0800 (PST)
From: Esther Shimanovich <eshimanovich@chromium.org>
Date: Wed, 20 Dec 2023 15:28:32 -0500
Subject: [PATCH v3] PCI: Relabel JHL6540 on Lenovo X1 Carbon 7,8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231220-thunderbolt-pci-patch-4-v3-1-056fd1717d06@chromium.org>
X-B4-Tracking: v=1; b=H4sIAG9Og2UC/43NTQ6CMBCG4auQrq2hP6bgynsYF6Ud6CRCSVsaD
 eHuFpZudPl+yTyzkggBIZJrtZIAGSP6qYQ4VcQ4PQ1A0ZYmvOaCcdbS5JbJQuj8M9HZIJ11Mo5
 KChYUM10jhJGkXM8Benwd8v1R2mFMPryPR5nt628zM8qohAaEUqKvdXszLvgRl/Hsw0B2NvM/K
 V4oMNwq3cuLbrsvatu2Dxw1Q3QMAQAA
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Rajat Jain <rajatja@google.com>, 
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
 Esther Shimanovich <eshimanovich@chromium.org>
X-Mailer: b4 0.12.3

On Lenovo X1 Carbon Gen 7/8 devices, when a platform enables a policy to
distrust removable PCI devices, the build-in USB-C ports stop working at
all.
This happens because these X1 Carbon models have a unique feature; a
Thunderbolt controller that is discrete from the SoC. The software sees
this controller, and incorrectly assumes it is a removable PCI device,
even though it is fixed to the computer and is wired to the computer's
own USB-C ports.

Relabel all the components of the JHL6540 controller as DEVICE_FIXED,
and where applicable, external_facing.

Ensure that the security policy to distrust external PCI devices works
as intended, and that the device's USB-C ports are able to enumerate
even when the policy is enabled.

Signed-off-by: Esther Shimanovich <eshimanovich@chromium.org>
---
Changes in v3:
- removed redundant dmi check, as the subsystem vendor check is
  sufficient
- switched to PCI_VENDOR_ID_LENOVO instead of hex code
- Link to v2: https://lore.kernel.org/r/20231219-thunderbolt-pci-patch-4-v2-1-ec2d7af45a9b@chromium.org

Changes in v2:
- nothing new, v1 was just a test run to see if the ASCII diagram would
  be rendered properly in mutt and k-9
- for folks using gmail, make sure to select "show original" on the top
  right, as otherwise the diagram will be garbled by the standard
  non-monospace font
- Link to v1: https://lore.kernel.org/r/20231219-thunderbolt-pci-patch-4-v1-1-4e8e3773f0a9@chromium.org
---
 drivers/pci/quirks.c | 106 +++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 106 insertions(+)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index ea476252280a..3e6e5fa94d99 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -3873,6 +3873,112 @@ DECLARE_PCI_FIXUP_SUSPEND_LATE(PCI_VENDOR_ID_INTEL,
 			       quirk_apple_poweroff_thunderbolt);
 #endif
 
+/*
+ * On most ThinkPad Carbon 7/8s, JHL6540 Thunderbolt 3 bridges are set
+ * incorrectly as DEVICE_REMOVABLE despite being built into the device.
+ * This is the side effect of a unique hardware configuration.
+ *
+ * Normally, Thunderbolt functionality is integrated to the SoC and
+ * its root ports.
+ *
+ *                          Most devices:
+ *                    root port --> USB-C port
+ *
+ * But X1 Carbon Gen 7/8 uses Whiskey Lake and Comet Lake SoC, which
+ * don't come with Thunderbolt functionality. Therefore, a discrete
+ * Thunderbolt Host PCI controller was added between the root port and
+ * the USB-C port.
+ *
+ *                        Thinkpad Carbon 7/8s
+ *                 (w/ Whiskey Lake and Comet Lake SoC):
+ *                root port -->  JHL6540   --> USB-C port
+ *
+ * Because the root port is labeled by FW as "ExternalFacingPort", as
+ * required by the DMAR ACPI spec, the JHL6540 chip is inaccurately
+ * labeled as DEVICE_REMOVABLE by the kernel pci driver.
+ * Therefore, the built-in USB-C ports do not enumerate when policies
+ * forbidding external pci devices are enforced.
+ *
+ * This fix relabels the pci components in the built-in JHL6540 chip as
+ * DEVICE_FIXED, ensuring that the built-in USB-C ports always enumerate
+ * properly as intended.
+ *
+ * This fix also labels the external facing components of the JHL6540 as
+ * external_facing, so that the pci attach policy works as intended.
+ *
+ * The ASCII diagram below describes the pci layout of the JHL6540 chip.
+ *
+ *                         Root Port
+ *                 [8086:02b4] or [8086:9db4]
+ *                             |
+ *                        JHL6540 Chip
+ *     __________________________________________________
+ *    |                      Bridge                      |
+ *    |        PCI ID ->  [8086:15d3]                    |
+ *    |         DEVFN ->      (00)                       |
+ *    |       _________________|__________________       |
+ *    |      |           |            |           |      |
+ *    |    Bridge     Bridge        Bridge      Bridge   |
+ *    | [8086:15d3] [8086:15d3]  [8086:15d3] [8086:15d3] |
+ *    |    (00)        (08)         (10)        (20)     |
+ *    |      |           |            |           |      |
+ *    |     NHI          |     USB Controller     |      |
+ *    | [8086:15d2]      |       [8086:15d4]      |      |
+ *    |    (00)          |          (00)          |      |
+ *    |      |___________|            |___________|      |
+ *    |____________|________________________|____________|
+ *                 |                        |
+ *             USB-C Port               USB-C Port
+ *
+ *
+ * Based on what a JHL6549 pci component's pci id, subsystem device id
+ * and devfn are, we can infer if it is fixed and if it faces a usb port;
+ * which would mean it is external facing.
+ * This quirk uses these values to identify the pci components and set the
+ * properties accordingly.
+ */
+static void carbon_X1_fixup_relabel_alpine_ridge(struct pci_dev *dev)
+{
+	/* Is this JHL6540 PCI component embedded in a Lenovo device? */
+	if (dev->subsystem_vendor != PCI_VENDOR_ID_LENOVO)
+		return;
+
+	/* Is this JHL6540 PCI component embedded in an X1 Carbon Gen 7/8? */
+	if (dev->subsystem_device != 0x22be && // Gen 8
+	    dev->subsystem_device != 0x2292) { // Gen 7
+		return;
+	}
+
+	dev_set_removable(&dev->dev, DEVICE_FIXED);
+
+	/* Not all 0x15d3 components are external facing */
+	if (dev->device == 0x15d3 &&
+	    dev->devfn != 0x08 &&
+	    dev->devfn != 0x20) {
+		return;
+	}
+
+	dev->external_facing = true;
+}
+
+/*
+ * We also need to relabel the root port as a consequence of changing
+ * the JHL6540's PCIE hierarchy.
+ */
+static void carbon_X1_fixup_rootport_not_removable(struct pci_dev *dev)
+{
+	if (!dmi_match(DMI_PRODUCT_FAMILY, "ThinkPad X1 Carbon 7th") &&
+	    !dmi_match(DMI_PRODUCT_FAMILY, "ThinkPad X1 Carbon Gen 8"))
+		return;
+
+	dev->external_facing = false;
+}
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x15d3, carbon_X1_fixup_relabel_alpine_ridge);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x15d2, carbon_X1_fixup_relabel_alpine_ridge);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x15d4, carbon_X1_fixup_relabel_alpine_ridge);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x02b4, carbon_X1_fixup_rootport_not_removable);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x9db4, carbon_X1_fixup_rootport_not_removable);
+
 /*
  * Following are device-specific reset methods which can be used to
  * reset a single function if other methods (e.g. FLR, PM D0->D3) are

---
base-commit: b85ea95d086471afb4ad062012a4d73cd328fa86
change-id: 20231219-thunderbolt-pci-patch-4-ede71cb833c4

Best regards,
-- 
Esther Shimanovich <eshimanovich@chromium.org>


