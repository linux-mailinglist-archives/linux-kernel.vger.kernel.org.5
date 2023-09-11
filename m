Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 020E079B847
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 02:08:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353916AbjIKVvd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 17:51:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236300AbjIKKMH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 06:12:07 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A630E5F;
        Mon, 11 Sep 2023 03:12:01 -0700 (PDT)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38B97olv031543;
        Mon, 11 Sep 2023 10:11:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=2PMXF7xCyEnPAiLN6sfOXhE+KPKwpxCRYQ1TraqbuI4=;
 b=bRfkUJox+qNCFoA6WyHDVOYtZGkEnwHzg1zca+kqX7HGfDYTyciQkKjL0syE4hZFW98M
 PS0cTHuuV1Bf12YYxFnu64/fzEoZCrlAdwKkAQ8ukkp5It25Eyt1F6j+MH34kyyhFhJx
 Kg52w0qB4+Y49hNsrvgxH8wF5ySZ8DMhLQBq/ArpuDRrn8MPIDd3CBn3TRp6SgKbszvt
 waGKOFlG1ulBNsm62FDYvH8yNfhjCvkOvUbGABrJjpdGHsSYbMv7UopHy5GJ32LSKw8s
 sfYXe6uoj2hoA9gkAvdkymv+8YCrfnZFKhz8BzT+oMK6WHWCbHNyb3F9Jt6b5bIrEfzc ig== 
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3t1m3pfbuv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 11 Sep 2023 10:11:53 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
        by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 38B8BkEY002779;
        Mon, 11 Sep 2023 10:11:52 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
        by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3t14hkhg8v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 11 Sep 2023 10:11:52 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
        by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 38BABo5q14025298
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 11 Sep 2023 10:11:50 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 501C42004F;
        Mon, 11 Sep 2023 10:11:50 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 285EA2004E;
        Mon, 11 Sep 2023 10:11:50 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Mon, 11 Sep 2023 10:11:50 +0000 (GMT)
From:   Niklas Schnelle <schnelle@linux.ibm.com>
To:     Arnd Bergmann <arnd@arndb.de>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Heiko Carstens <hca@linux.ibm.com>,
        Arnd Bergmann <arnd@kernel.org>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] usb: pci-quirks: group AMD specific quirk code together
Date:   Mon, 11 Sep 2023 12:11:47 +0200
Message-Id: <20230911101149.4113303-2-schnelle@linux.ibm.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230911101149.4113303-1-schnelle@linux.ibm.com>
References: <20230911101149.4113303-1-schnelle@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: Oad3IIvAlTCszKJeSPXEFuRupQGXd1d9
X-Proofpoint-GUID: Oad3IIvAlTCszKJeSPXEFuRupQGXd1d9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-11_06,2023-09-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 spamscore=0
 clxscore=1011 impostorscore=0 priorityscore=1501 malwarescore=0
 phishscore=0 mlxlogscore=660 suspectscore=0 lowpriorityscore=0
 adultscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309110092
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A follow on patch will introduce CONFIG_USB_PCI_AMD governing the AMD
quirk and adding its compile time dependency on HAS_IOPORT. In order to
minimize the number of #ifdefs in C files and make that patch easier
to read first group the code together. This is pure code movement
no functional change is intended.

Co-developed-by: Arnd Bergmann <arnd@kernel.org>
Signed-off-by: Arnd Bergmann <arnd@kernel.org>
Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
---
 drivers/usb/host/pci-quirks.c | 119 +++++++++++++++++-----------------
 drivers/usb/host/pci-quirks.h |  14 ++--
 2 files changed, 68 insertions(+), 65 deletions(-)

diff --git a/drivers/usb/host/pci-quirks.c b/drivers/usb/host/pci-quirks.c
index 2665832f9add..5e06fad82a22 100644
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
@@ -458,50 +459,6 @@ void usb_amd_quirk_pll_disable(void)
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
@@ -631,6 +588,50 @@ bool usb_amd_pt_check_port(struct device *device, int port)
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
index e729de21fad7..cde2263a9d2e 100644
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
2.39.2

