Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51EB87E4CC6
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 00:23:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344370AbjKGXXS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 18:23:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344401AbjKGXXD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 18:23:03 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46AB41987;
        Tue,  7 Nov 2023 15:22:51 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9374C433C8;
        Tue,  7 Nov 2023 23:22:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699399370;
        bh=ODQxPb0cYVskkQLSAD6mZtDs/FHqTQTDlp2qY4AN6q4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pytPkoxTH3hjdYoReL+MSy487bPyPBvnNmaECthBNTVdt04Xn2nGhEOjso60URjCa
         cCAJ6pmnS04NBHJUtNH1r6FEt9j11lL0QytgJDsCzRRG7gsAZH5+5zg5/dujDitC0w
         0zLZ/OzgW8fvaDW2CB00qNujOSBp3Ik7FbDzn51VE5O790kOhzIAmGUFF9GInLFwY4
         RohamHVVsUgzxJQTzTvcUX+T5alBw2uCyUO8VnmWpqq62E34sfkZCvlwIPhACHcisE
         uv4RaNVbf6SkixuJbH/kvaMQm2Uf2Z9aT7JJYSk4vNONT+E/TwxroFupfHyNY38EkS
         vf82GO8i8KmoQ==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Niklas Schnelle <schnelle@linux.ibm.com>,
        Arnd Bergmann <arnd@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>, mathias.nyman@intel.com,
        stern@rowland.harvard.edu, Basavaraj.Natikar@amd.com,
        linux-usb@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 09/18] usb: pci-quirks: handle HAS_IOPORT dependency for AMD quirk
Date:   Tue,  7 Nov 2023 18:22:03 -0500
Message-ID: <20231107232231.3775605-9-sashal@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231107232231.3775605-1-sashal@kernel.org>
References: <20231107232231.3775605-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Niklas Schnelle <schnelle@linux.ibm.com>

[ Upstream commit 52e24f8c0a102ac76649c6b71224fadcc82bd5da ]

In a future patch HAS_IOPORT=n will result in inb()/outb() and friends
not being declared. In the pci-quirks case the I/O port acceses are
used in the quirks for several AMD south bridges, Add a config option
for the AMD quirks to depend on HAS_IOPORT and #ifdef the quirk code.

Co-developed-by: Arnd Bergmann <arnd@kernel.org>
Signed-off-by: Arnd Bergmann <arnd@kernel.org>
Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
Link: https://lore.kernel.org/r/20230911125653.1393895-3-schnelle@linux.ibm.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/Kconfig           | 10 ++++++++++
 drivers/usb/core/hcd-pci.c    |  3 +--
 drivers/usb/host/pci-quirks.c |  2 ++
 drivers/usb/host/pci-quirks.h | 30 ++++++++++++++++++++++--------
 include/linux/usb/hcd.h       | 17 +++++++++++++++++
 5 files changed, 52 insertions(+), 10 deletions(-)

diff --git a/drivers/usb/Kconfig b/drivers/usb/Kconfig
index 7f33bcc315f27..abf8c6cdea9ea 100644
--- a/drivers/usb/Kconfig
+++ b/drivers/usb/Kconfig
@@ -91,6 +91,16 @@ config USB_PCI
 	  If you have such a device you may say N here and PCI related code
 	  will not be built in the USB driver.
 
+config USB_PCI_AMD
+	bool "AMD PCI USB host support"
+	depends on USB_PCI && HAS_IOPORT
+	default X86 || MACH_LOONGSON64 || PPC_PASEMI
+	help
+	  Enable workarounds for USB implementation quirks in SB600/SB700/SB800
+	  and later south bridge implementations. These are common on x86 PCs
+	  with AMD CPUs but rarely used elsewhere, with the exception of a few
+	  powerpc and mips desktop machines.
+
 if USB
 
 source "drivers/usb/core/Kconfig"
diff --git a/drivers/usb/core/hcd-pci.c b/drivers/usb/core/hcd-pci.c
index 990280688b254..ee3156f495338 100644
--- a/drivers/usb/core/hcd-pci.c
+++ b/drivers/usb/core/hcd-pci.c
@@ -206,8 +206,7 @@ int usb_hcd_pci_probe(struct pci_dev *dev, const struct hc_driver *driver)
 		goto free_irq_vectors;
 	}
 
-	hcd->amd_resume_bug = (usb_hcd_amd_remote_wakeup_quirk(dev) &&
-			driver->flags & (HCD_USB11 | HCD_USB3)) ? 1 : 0;
+	hcd->amd_resume_bug = usb_hcd_amd_resume_bug(dev, driver);
 
 	if (driver->flags & HCD_MEMORY) {
 		/* EHCI, OHCI */
diff --git a/drivers/usb/host/pci-quirks.c b/drivers/usb/host/pci-quirks.c
index 5e06fad82a228..10813096d00c6 100644
--- a/drivers/usb/host/pci-quirks.c
+++ b/drivers/usb/host/pci-quirks.c
@@ -76,6 +76,7 @@
 #define USB_INTEL_USB3_PSSEN   0xD8
 #define USB_INTEL_USB3PRM      0xDC
 
+#ifdef CONFIG_USB_PCI_AMD
 /* AMD quirk use */
 #define	AB_REG_BAR_LOW		0xe0
 #define	AB_REG_BAR_HIGH		0xe1
@@ -587,6 +588,7 @@ bool usb_amd_pt_check_port(struct device *device, int port)
 	return !(value & BIT(port_shift));
 }
 EXPORT_SYMBOL_GPL(usb_amd_pt_check_port);
+#endif /* CONFIG_USB_PCI_AMD */
 
 static int usb_asmedia_wait_write(struct pci_dev *pdev)
 {
diff --git a/drivers/usb/host/pci-quirks.h b/drivers/usb/host/pci-quirks.h
index cde2263a9d2e4..a5230b0b9e913 100644
--- a/drivers/usb/host/pci-quirks.h
+++ b/drivers/usb/host/pci-quirks.h
@@ -2,7 +2,7 @@
 #ifndef __LINUX_USB_PCI_QUIRKS_H
 #define __LINUX_USB_PCI_QUIRKS_H
 
-#ifdef CONFIG_USB_PCI
+#ifdef CONFIG_USB_PCI_AMD
 int usb_hcd_amd_remote_wakeup_quirk(struct pci_dev *pdev);
 bool usb_amd_hang_symptom_quirk(void);
 bool usb_amd_prefetch_quirk(void);
@@ -12,23 +12,37 @@ void usb_amd_quirk_pll_disable(void);
 void usb_amd_quirk_pll_enable(void);
 void sb800_prefetch(struct device *dev, int on);
 bool usb_amd_pt_check_port(struct device *device, int port);
-
-void uhci_reset_hc(struct pci_dev *pdev, unsigned long base);
-int uhci_check_and_reset_hc(struct pci_dev *pdev, unsigned long base);
-void usb_asmedia_modifyflowcontrol(struct pci_dev *pdev);
-void usb_enable_intel_xhci_ports(struct pci_dev *xhci_pdev);
-void usb_disable_xhci_ports(struct pci_dev *xhci_pdev);
 #else
-struct pci_dev;
+static inline bool usb_amd_hang_symptom_quirk(void)
+{
+	return false;
+};
+static inline bool usb_amd_prefetch_quirk(void)
+{
+	return false;
+}
 static inline void usb_amd_quirk_pll_disable(void) {}
 static inline void usb_amd_quirk_pll_enable(void) {}
 static inline void usb_amd_dev_put(void) {}
+static inline bool usb_amd_quirk_pll_check(void)
+{
+	return false;
+}
 static inline void sb800_prefetch(struct device *dev, int on) {}
 static inline bool usb_amd_pt_check_port(struct device *device, int port)
 {
 	return false;
 }
+#endif /* CONFIG_USB_PCI_AMD */
 
+#ifdef CONFIG_USB_PCI
+void uhci_reset_hc(struct pci_dev *pdev, unsigned long base);
+int uhci_check_and_reset_hc(struct pci_dev *pdev, unsigned long base);
+void usb_asmedia_modifyflowcontrol(struct pci_dev *pdev);
+void usb_enable_intel_xhci_ports(struct pci_dev *xhci_pdev);
+void usb_disable_xhci_ports(struct pci_dev *xhci_pdev);
+#else
+struct pci_dev;
 static inline void usb_asmedia_modifyflowcontrol(struct pci_dev *pdev) {}
 static inline void usb_disable_xhci_ports(struct pci_dev *xhci_pdev) {}
 #endif  /* CONFIG_USB_PCI */
diff --git a/include/linux/usb/hcd.h b/include/linux/usb/hcd.h
index 61d4f0b793dcd..00724b4f6e122 100644
--- a/include/linux/usb/hcd.h
+++ b/include/linux/usb/hcd.h
@@ -484,8 +484,25 @@ extern int usb_hcd_pci_probe(struct pci_dev *dev,
 extern void usb_hcd_pci_remove(struct pci_dev *dev);
 extern void usb_hcd_pci_shutdown(struct pci_dev *dev);
 
+#ifdef CONFIG_USB_PCI_AMD
 extern int usb_hcd_amd_remote_wakeup_quirk(struct pci_dev *dev);
 
+static inline bool usb_hcd_amd_resume_bug(struct pci_dev *dev,
+					  const struct hc_driver *driver)
+{
+	if (!usb_hcd_amd_remote_wakeup_quirk(dev))
+		return false;
+	if (driver->flags & (HCD_USB11 | HCD_USB3))
+		return true;
+	return false;
+}
+#else /* CONFIG_USB_PCI_AMD */
+static inline bool usb_hcd_amd_resume_bug(struct pci_dev *dev,
+					  const struct hc_driver *driver)
+{
+	return false;
+}
+#endif
 extern const struct dev_pm_ops usb_hcd_pci_pm_ops;
 #endif /* CONFIG_USB_PCI */
 
-- 
2.42.0

