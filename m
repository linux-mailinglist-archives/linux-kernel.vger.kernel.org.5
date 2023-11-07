Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0FF37E4D51
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 00:27:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344533AbjKGX1w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 18:27:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234794AbjKGX1U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 18:27:20 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E58C830EF;
        Tue,  7 Nov 2023 15:24:50 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A365AC433C7;
        Tue,  7 Nov 2023 23:24:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699399490;
        bh=CFAgoRgt7eqVcwIWQzZivT9lXnA6Y5jzyCwEU5PvkgQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=d1VhClsDZ9x7tqXd0pIkamfGwFoA3rKvT/Om3SUfN2bwDOj329VU/b/VHQhKLSSfz
         nWYQ3WWcs273NFeiNkW4W4T6V06gOcLe4uK7STNROnwBTl7bzKSPBW1Ba14fxiRip8
         0k7NWcz18CwQNe7K/1p5Z5vGBk2TcMCLRtKLWD/pPPSpCKsvC8xf/qTlkbgFIsxgwn
         mCTu5o9e0sGbkwjZLOCuaroYIMo30BUgAYjWFEDEiUg8D2EPEPF1+KS7hWIjnnue/7
         LTFJm+dgc/exJBGOxjEKzigMchXR3KB0O7eERKejdogv/oHQb427eRIwHm1Hsc3Zuv
         J/bRvCl6Zauhg==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Niklas Schnelle <schnelle@linux.ibm.com>,
        Arnd Bergmann <arnd@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>, mathias.nyman@intel.com,
        linux-usb@vger.kernel.org
Subject: [PATCH AUTOSEL 5.15 2/6] usb: pci-quirks: group AMD specific quirk code together
Date:   Tue,  7 Nov 2023 18:24:38 -0500
Message-ID: <20231107232446.3776662-2-sashal@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231107232446.3776662-1-sashal@kernel.org>
References: <20231107232446.3776662-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.137
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Niklas Schnelle <schnelle@linux.ibm.com>

[ Upstream commit 7ca9f9ba8aa7380dee5dd8346b57bbaf198b075a ]

A follow on patch will introduce CONFIG_USB_PCI_AMD governing the AMD
quirk and adding its compile time dependency on HAS_IOPORT. In order to
minimize the number of #ifdefs in C files and make that patch easier
to read first group the code together. This is pure code movement
no functional change is intended.

Co-developed-by: Arnd Bergmann <arnd@kernel.org>
Signed-off-by: Arnd Bergmann <arnd@kernel.org>
Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
Link: https://lore.kernel.org/r/20230911125653.1393895-2-schnelle@linux.ibm.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/host/pci-quirks.c | 119 +++++++++++++++++-----------------
 drivers/usb/host/pci-quirks.h |  14 ++--
 2 files changed, 68 insertions(+), 65 deletions(-)

diff --git a/drivers/usb/host/pci-quirks.c b/drivers/usb/host/pci-quirks.c
index ef08d68b97149..4b0e344916ebc 100644
--- a/drivers/usb/host/pci-quirks.c
+++ b/drivers/usb/host/pci-quirks.c
@@ -60,6 +60,22 @@
 #define EHCI_USBLEGCTLSTS	4		/* legacy control/status */
 #define EHCI_USBLEGCTLSTS_SOOE	(1 << 13)	/* SMI on ownership change */
 
+/* ASMEDIA quirk use */
+#define ASMT_DATA_WRITE0_REG	0xF8
+#define ASMT_DATA_WRITE1_REG	0xFC
+#define ASMT_CONTROL_REG	0xE0
+#define ASMT_CONTROL_WRITE_BIT	0x02
+#define ASMT_WRITEREG_CMD	0x10423
+#define ASMT_FLOWCTL_ADDR	0xFA30
+#define ASMT_FLOWCTL_DATA	0xBA
+#define ASMT_PSEUDO_DATA	0
+
+/* Intel quirk use */
+#define USB_INTEL_XUSB2PR      0xD0
+#define USB_INTEL_USB2PRM      0xD4
+#define USB_INTEL_USB3_PSSEN   0xD8
+#define USB_INTEL_USB3PRM      0xDC
+
 /* AMD quirk use */
 #define	AB_REG_BAR_LOW		0xe0
 #define	AB_REG_BAR_HIGH		0xe1
@@ -93,21 +109,6 @@
 #define	NB_PIF0_PWRDOWN_0	0x01100012
 #define	NB_PIF0_PWRDOWN_1	0x01100013
 
-#define USB_INTEL_XUSB2PR      0xD0
-#define USB_INTEL_USB2PRM      0xD4
-#define USB_INTEL_USB3_PSSEN   0xD8
-#define USB_INTEL_USB3PRM      0xDC
-
-/* ASMEDIA quirk use */
-#define ASMT_DATA_WRITE0_REG	0xF8
-#define ASMT_DATA_WRITE1_REG	0xFC
-#define ASMT_CONTROL_REG	0xE0
-#define ASMT_CONTROL_WRITE_BIT	0x02
-#define ASMT_WRITEREG_CMD	0x10423
-#define ASMT_FLOWCTL_ADDR	0xFA30
-#define ASMT_FLOWCTL_DATA	0xBA
-#define ASMT_PSEUDO_DATA	0
-
 /*
  * amd_chipset_gen values represent AMD different chipset generations
  */
@@ -460,50 +461,6 @@ void usb_amd_quirk_pll_disable(void)
 }
 EXPORT_SYMBOL_GPL(usb_amd_quirk_pll_disable);
 
-static int usb_asmedia_wait_write(struct pci_dev *pdev)
-{
-	unsigned long retry_count;
-	unsigned char value;
-
-	for (retry_count = 1000; retry_count > 0; --retry_count) {
-
-		pci_read_config_byte(pdev, ASMT_CONTROL_REG, &value);
-
-		if (value == 0xff) {
-			dev_err(&pdev->dev, "%s: check_ready ERROR", __func__);
-			return -EIO;
-		}
-
-		if ((value & ASMT_CONTROL_WRITE_BIT) == 0)
-			return 0;
-
-		udelay(50);
-	}
-
-	dev_warn(&pdev->dev, "%s: check_write_ready timeout", __func__);
-	return -ETIMEDOUT;
-}
-
-void usb_asmedia_modifyflowcontrol(struct pci_dev *pdev)
-{
-	if (usb_asmedia_wait_write(pdev) != 0)
-		return;
-
-	/* send command and address to device */
-	pci_write_config_dword(pdev, ASMT_DATA_WRITE0_REG, ASMT_WRITEREG_CMD);
-	pci_write_config_dword(pdev, ASMT_DATA_WRITE1_REG, ASMT_FLOWCTL_ADDR);
-	pci_write_config_byte(pdev, ASMT_CONTROL_REG, ASMT_CONTROL_WRITE_BIT);
-
-	if (usb_asmedia_wait_write(pdev) != 0)
-		return;
-
-	/* send data to device */
-	pci_write_config_dword(pdev, ASMT_DATA_WRITE0_REG, ASMT_FLOWCTL_DATA);
-	pci_write_config_dword(pdev, ASMT_DATA_WRITE1_REG, ASMT_PSEUDO_DATA);
-	pci_write_config_byte(pdev, ASMT_CONTROL_REG, ASMT_CONTROL_WRITE_BIT);
-}
-EXPORT_SYMBOL_GPL(usb_asmedia_modifyflowcontrol);
-
 void usb_amd_quirk_pll_enable(void)
 {
 	usb_amd_quirk_pll(0);
@@ -633,6 +590,50 @@ bool usb_amd_pt_check_port(struct device *device, int port)
 }
 EXPORT_SYMBOL_GPL(usb_amd_pt_check_port);
 
+static int usb_asmedia_wait_write(struct pci_dev *pdev)
+{
+	unsigned long retry_count;
+	unsigned char value;
+
+	for (retry_count = 1000; retry_count > 0; --retry_count) {
+
+		pci_read_config_byte(pdev, ASMT_CONTROL_REG, &value);
+
+		if (value == 0xff) {
+			dev_err(&pdev->dev, "%s: check_ready ERROR", __func__);
+			return -EIO;
+		}
+
+		if ((value & ASMT_CONTROL_WRITE_BIT) == 0)
+			return 0;
+
+		udelay(50);
+	}
+
+	dev_warn(&pdev->dev, "%s: check_write_ready timeout", __func__);
+	return -ETIMEDOUT;
+}
+
+void usb_asmedia_modifyflowcontrol(struct pci_dev *pdev)
+{
+	if (usb_asmedia_wait_write(pdev) != 0)
+		return;
+
+	/* send command and address to device */
+	pci_write_config_dword(pdev, ASMT_DATA_WRITE0_REG, ASMT_WRITEREG_CMD);
+	pci_write_config_dword(pdev, ASMT_DATA_WRITE1_REG, ASMT_FLOWCTL_ADDR);
+	pci_write_config_byte(pdev, ASMT_CONTROL_REG, ASMT_CONTROL_WRITE_BIT);
+
+	if (usb_asmedia_wait_write(pdev) != 0)
+		return;
+
+	/* send data to device */
+	pci_write_config_dword(pdev, ASMT_DATA_WRITE0_REG, ASMT_FLOWCTL_DATA);
+	pci_write_config_dword(pdev, ASMT_DATA_WRITE1_REG, ASMT_PSEUDO_DATA);
+	pci_write_config_byte(pdev, ASMT_CONTROL_REG, ASMT_CONTROL_WRITE_BIT);
+}
+EXPORT_SYMBOL_GPL(usb_asmedia_modifyflowcontrol);
+
 /*
  * Make sure the controller is completely inactive, unable to
  * generate interrupts or do DMA.
diff --git a/drivers/usb/host/pci-quirks.h b/drivers/usb/host/pci-quirks.h
index e729de21fad7a..cde2263a9d2e4 100644
--- a/drivers/usb/host/pci-quirks.h
+++ b/drivers/usb/host/pci-quirks.h
@@ -3,8 +3,6 @@
 #define __LINUX_USB_PCI_QUIRKS_H
 
 #ifdef CONFIG_USB_PCI
-void uhci_reset_hc(struct pci_dev *pdev, unsigned long base);
-int uhci_check_and_reset_hc(struct pci_dev *pdev, unsigned long base);
 int usb_hcd_amd_remote_wakeup_quirk(struct pci_dev *pdev);
 bool usb_amd_hang_symptom_quirk(void);
 bool usb_amd_prefetch_quirk(void);
@@ -12,23 +10,27 @@ void usb_amd_dev_put(void);
 bool usb_amd_quirk_pll_check(void);
 void usb_amd_quirk_pll_disable(void);
 void usb_amd_quirk_pll_enable(void);
+void sb800_prefetch(struct device *dev, int on);
+bool usb_amd_pt_check_port(struct device *device, int port);
+
+void uhci_reset_hc(struct pci_dev *pdev, unsigned long base);
+int uhci_check_and_reset_hc(struct pci_dev *pdev, unsigned long base);
 void usb_asmedia_modifyflowcontrol(struct pci_dev *pdev);
 void usb_enable_intel_xhci_ports(struct pci_dev *xhci_pdev);
 void usb_disable_xhci_ports(struct pci_dev *xhci_pdev);
-void sb800_prefetch(struct device *dev, int on);
-bool usb_amd_pt_check_port(struct device *device, int port);
 #else
 struct pci_dev;
 static inline void usb_amd_quirk_pll_disable(void) {}
 static inline void usb_amd_quirk_pll_enable(void) {}
-static inline void usb_asmedia_modifyflowcontrol(struct pci_dev *pdev) {}
 static inline void usb_amd_dev_put(void) {}
-static inline void usb_disable_xhci_ports(struct pci_dev *xhci_pdev) {}
 static inline void sb800_prefetch(struct device *dev, int on) {}
 static inline bool usb_amd_pt_check_port(struct device *device, int port)
 {
 	return false;
 }
+
+static inline void usb_asmedia_modifyflowcontrol(struct pci_dev *pdev) {}
+static inline void usb_disable_xhci_ports(struct pci_dev *xhci_pdev) {}
 #endif  /* CONFIG_USB_PCI */
 
 #endif  /*  __LINUX_USB_PCI_QUIRKS_H  */
-- 
2.42.0

