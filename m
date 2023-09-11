Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C96BB79B6B5
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 02:05:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233034AbjIKUwF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 16:52:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237542AbjIKM5M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 08:57:12 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F5CDE4D;
        Mon, 11 Sep 2023 05:57:07 -0700 (PDT)
Received: from pps.filterd (m0353727.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38BCrWI9011971;
        Mon, 11 Sep 2023 12:56:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=z6iXJSAk8VmaOLsZImHUbYEz4LKyvswZEgeBjuY2lOI=;
 b=lxV1STxlQCwhkR+GYRo7z8ppSxeh8odjuUE92fkORbV+R4DqShFJnrK/xvssTHxYVgET
 JFEmnpDBNE7QgOnOvpYbZRMiIXjvYleyVNuuett1MnNEU3I+xZdj49H/a4h7oDsTVE6q
 5ME/Eg9SuPf9zgYfHHYZI+hCkiPf3NVImI+k+mys6KO+s6NfZfvVSc7VhMPhD9eZCcN2
 lGj2/GGcXp4oF5PP4ms80UkvRdoW+Bu135npUzbaGR5HOeOWCCcD4u9k1QqVk+/v4RkM
 1NRNKXV2u8zTLK0lIetIIaf8spNOEQsdhaU824/BAiyu7ci4nLmeYG4xyj95dCKkImfm yQ== 
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3t23a1g2rk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 11 Sep 2023 12:56:58 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
        by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 38BAcuVX002755;
        Mon, 11 Sep 2023 12:56:57 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
        by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3t14hkjd2w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 11 Sep 2023 12:56:56 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
        by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 38BCureb36045154
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 11 Sep 2023 12:56:54 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CECBC20040;
        Mon, 11 Sep 2023 12:56:53 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A14FE20043;
        Mon, 11 Sep 2023 12:56:53 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Mon, 11 Sep 2023 12:56:53 +0000 (GMT)
From:   Niklas Schnelle <schnelle@linux.ibm.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mathias Nyman <mathias.nyman@intel.com>
Cc:     Alan Stern <stern@rowland.harvard.edu>,
        Niklas Schnelle <schnelle@linux.ibm.com>,
        Basavaraj Natikar <Basavaraj.Natikar@amd.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Heiko Carstens <hca@linux.ibm.com>
Subject: [PATCH 2/3] usb: pci-quirks: handle HAS_IOPORT dependency for AMD quirk
Date:   Mon, 11 Sep 2023 14:56:52 +0200
Message-Id: <20230911125653.1393895-3-schnelle@linux.ibm.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230911125653.1393895-1-schnelle@linux.ibm.com>
References: <20230911125653.1393895-1-schnelle@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: TkT6YA5maFBUQff1ElDBk_pHcG0Aq2vS
X-Proofpoint-ORIG-GUID: TkT6YA5maFBUQff1ElDBk_pHcG0Aq2vS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-11_06,2023-09-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxlogscore=705
 clxscore=1015 priorityscore=1501 spamscore=0 malwarescore=0
 lowpriorityscore=0 mlxscore=0 suspectscore=0 phishscore=0 bulkscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309110114
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In a future patch HAS_IOPORT=n will result in inb()/outb() and friends
not being declared. In the pci-quirks case the I/O port acceses are
used in the quirks for several AMD south bridges, Add a config option
for the AMD quirks to depend on HAS_IOPORT and #ifdef the quirk code.

Co-developed-by: Arnd Bergmann <arnd@kernel.org>
Signed-off-by: Arnd Bergmann <arnd@kernel.org>
Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
---
 drivers/usb/Kconfig           | 10 ++++++++++
 drivers/usb/core/hcd-pci.c    |  3 +--
 drivers/usb/host/pci-quirks.c |  2 ++
 drivers/usb/host/pci-quirks.h | 34 ++++++++++++++++++++++++----------
 include/linux/usb/hcd.h       | 17 +++++++++++++++++
 5 files changed, 54 insertions(+), 12 deletions(-)

diff --git a/drivers/usb/Kconfig b/drivers/usb/Kconfig
index 7f33bcc315f2..abf8c6cdea9e 100644
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
index 990280688b25..ee3156f49533 100644
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
index 5e06fad82a22..10813096d00c 100644
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
index cde2263a9d2e..a5230b0b9e91 100644
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
@@ -12,7 +12,30 @@ void usb_amd_quirk_pll_disable(void);
 void usb_amd_quirk_pll_enable(void);
 void sb800_prefetch(struct device *dev, int on);
 bool usb_amd_pt_check_port(struct device *device, int port);
+#else
+static inline bool usb_amd_hang_symptom_quirk(void)
+{
+	return false;
+};
+static inline bool usb_amd_prefetch_quirk(void)
+{
+	return false;
+}
+static inline void usb_amd_quirk_pll_disable(void) {}
+static inline void usb_amd_quirk_pll_enable(void) {}
+static inline void usb_amd_dev_put(void) {}
+static inline bool usb_amd_quirk_pll_check(void)
+{
+	return false;
+}
+static inline void sb800_prefetch(struct device *dev, int on) {}
+static inline bool usb_amd_pt_check_port(struct device *device, int port)
+{
+	return false;
+}
+#endif /* CONFIG_USB_PCI_AMD */
 
+#ifdef CONFIG_USB_PCI
 void uhci_reset_hc(struct pci_dev *pdev, unsigned long base);
 int uhci_check_and_reset_hc(struct pci_dev *pdev, unsigned long base);
 void usb_asmedia_modifyflowcontrol(struct pci_dev *pdev);
@@ -20,15 +43,6 @@ void usb_enable_intel_xhci_ports(struct pci_dev *xhci_pdev);
 void usb_disable_xhci_ports(struct pci_dev *xhci_pdev);
 #else
 struct pci_dev;
-static inline void usb_amd_quirk_pll_disable(void) {}
-static inline void usb_amd_quirk_pll_enable(void) {}
-static inline void usb_amd_dev_put(void) {}
-static inline void sb800_prefetch(struct device *dev, int on) {}
-static inline bool usb_amd_pt_check_port(struct device *device, int port)
-{
-	return false;
-}
-
 static inline void usb_asmedia_modifyflowcontrol(struct pci_dev *pdev) {}
 static inline void usb_disable_xhci_ports(struct pci_dev *xhci_pdev) {}
 #endif  /* CONFIG_USB_PCI */
diff --git a/include/linux/usb/hcd.h b/include/linux/usb/hcd.h
index 61d4f0b793dc..00724b4f6e12 100644
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
2.39.2

