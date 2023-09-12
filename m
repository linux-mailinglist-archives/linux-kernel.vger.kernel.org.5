Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3DB079DBA2
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 00:09:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236289AbjILWJw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 18:09:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234892AbjILWJs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 18:09:48 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C43E810DD
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 15:09:44 -0700 (PDT)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38CM70n7019789;
        Tue, 12 Sep 2023 22:09:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=PmA/KdIC2gcxVInk7Cl+AY2muSadRtEaiYAplGFxvmM=;
 b=KWX/ZisjfZzzlBj0JlV2HJjjziqjGe4wyyJbt6uuggMOPGxDWhiC/e17Y06QjCmyv9H5
 eWuLYfk5OwtDCZu70vsmTmZysJnL0ZbPqKWAHc4cKgfw+KotHBElMfVyNo+hJs5znDpJ
 Mo9PTdEr3DjX56tDZ9Bq9jW/K8yF8ZcfUPtdRIyLfw3h03ys93hZ0TkWb5YLXouuVzHL
 X2XequX/XHJB8ifxS22HFM2yrn7mY9XYtiqXhyA5t2716HXVqNR1+SDhA0u0DMHc8IeS
 igdwS8kcExvnCawxPHcOQj/wwfQ9EM2r3QQTem8NHP3eeVTDb7qwzc22LOqyeFqckGnO FQ== 
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3t2yjj9581-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 12 Sep 2023 22:09:30 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
        by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 38CKC2At022958;
        Tue, 12 Sep 2023 22:09:29 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
        by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3t141npg6b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 12 Sep 2023 22:09:29 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com [10.241.53.103])
        by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 38CM9STi58524050
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Sep 2023 22:09:28 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0865E58056;
        Tue, 12 Sep 2023 22:09:28 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B84455805A;
        Tue, 12 Sep 2023 22:09:27 +0000 (GMT)
Received: from gfwa153.aus.stglabs.ibm.com (unknown [9.3.84.127])
        by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
        Tue, 12 Sep 2023 22:09:27 +0000 (GMT)
From:   Ninad Palsule <ninad@linux.ibm.com>
To:     joel@jms.id.au, andrew@aj.id.au, eajames@linux.ibm.com
Cc:     Ninad Palsule <ninad@linux.ibm.com>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org
Subject: [PATCH v3 1/2] soc/aspeed: Add host side BMC device driver
Date:   Tue, 12 Sep 2023 17:09:22 -0500
Message-Id: <20230912220923.3701688-2-ninad@linux.ibm.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230912220923.3701688-1-ninad@linux.ibm.com>
References: <20230912220923.3701688-1-ninad@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: LKhstPAQ1fWqrYq8R2ZVfpe3XCT1vauq
X-Proofpoint-ORIG-GUID: LKhstPAQ1fWqrYq8R2ZVfpe3XCT1vauq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-12_21,2023-09-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 adultscore=0 bulkscore=0 impostorscore=0 suspectscore=0 spamscore=0
 clxscore=1015 mlxscore=0 phishscore=0 mlxlogscore=999 malwarescore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309120187
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Taken from ASPEED's 5.15 SDK kernel.

The AST2600 supports 2 VUARTs over LPC bus and 2 over PCIe bus. This
patch adds host side driver for PCIe based VUARTs.

Testing:
  - This is tested on IBM rainier system with BMC. It requires BMC side
    BMC device driver which is available in the ASPEED's 5.15 SDK
    kernel. Also it is working only with legacy interrupt. TODO: MSI
    interrupt handling.
[    1.313775][  T985] ASPEED BMC DEVICE 0002:02:01.0: enabling device (0140 -> 0142)
[    1.314381][  T985] 0002:02:01.0: ttyS0 at MMIO 0x600c100100fe0 (irq = 91, base_baud = 115200) is a 16550A
[    1.314607][  T985] 0002:02:01.0: ttyS1 at MMIO 0x600c100100be0 (irq = 91, base_baud = 115200) is a 16550A

  - The host is loaded through IBM openpower petitboot boot loaded.
  - Character echoed from BMC tty device seen on the host side tty device
    and vice versa.
    - BMC side
    root@p10bmc:~# echo "123" > /dev/ttyPCIVUART0
    root@p10bmc:~# echo "Hello" > /dev/ttyPCIVUART0

    - Host side
    # cat /dev/ttyS0
    123
    Hello

Co-developed-by: Joel Stanley <joel@jms.id.au>
Signed-off-by: Joel Stanley <joel@jms.id.au>
Signed-off-by: Ninad Palsule <ninad@linux.ibm.com>
Tested-by: Ninad Palsule <ninad@linux.ibm.com>
---
V2:
- Incorporated review comments from Andrew Lunn
- Fixed warning reported by kernel test robot.
- Fixed crashed in the error recovery path
---
V3:
- Add PCI dependency in the Kconfig to fix issue reported by kernel test
  robot.
- Fixed wanring indicated by checkpatch script.
---
 drivers/soc/aspeed/Kconfig               |  11 +
 drivers/soc/aspeed/Makefile              |   1 +
 drivers/soc/aspeed/aspeed-host-bmc-dev.c | 250 +++++++++++++++++++++++
 3 files changed, 262 insertions(+)
 create mode 100644 drivers/soc/aspeed/aspeed-host-bmc-dev.c

diff --git a/drivers/soc/aspeed/Kconfig b/drivers/soc/aspeed/Kconfig
index f579ee0b5afa..8a4f096d84cd 100644
--- a/drivers/soc/aspeed/Kconfig
+++ b/drivers/soc/aspeed/Kconfig
@@ -52,6 +52,17 @@ config ASPEED_SOCINFO
 	help
 	  Say yes to support decoding of ASPEED BMC information.
 
+config ASPEED_HOST_BMC_DEV
+	bool "ASPEED SoC Host BMC device driver"
+	select SOC_BUS
+	default ARCH_ASPEED
+	depends on PCI
+	help
+	  Say yes to support PCIe based VUARTs from the host side. The end to
+          end VUART communication between host and BMC requires BMC side driver
+	  to activate VUART functionality. This is a driver for the BMC device
+          on host.
+
 endmenu
 
 endif
diff --git a/drivers/soc/aspeed/Makefile b/drivers/soc/aspeed/Makefile
index b35d74592964..db6acff9fa52 100644
--- a/drivers/soc/aspeed/Makefile
+++ b/drivers/soc/aspeed/Makefile
@@ -4,3 +4,4 @@ obj-$(CONFIG_ASPEED_LPC_SNOOP)		+= aspeed-lpc-snoop.o
 obj-$(CONFIG_ASPEED_UART_ROUTING)	+= aspeed-uart-routing.o
 obj-$(CONFIG_ASPEED_P2A_CTRL)		+= aspeed-p2a-ctrl.o
 obj-$(CONFIG_ASPEED_SOCINFO)		+= aspeed-socinfo.o
+obj-$(CONFIG_ASPEED_HOST_BMC_DEV)	+= aspeed-host-bmc-dev.o
diff --git a/drivers/soc/aspeed/aspeed-host-bmc-dev.c b/drivers/soc/aspeed/aspeed-host-bmc-dev.c
new file mode 100644
index 000000000000..8d4efec85280
--- /dev/null
+++ b/drivers/soc/aspeed/aspeed-host-bmc-dev.c
@@ -0,0 +1,250 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+// Copyright (C) ASPEED Technology Inc.
+
+#include <linux/init.h>
+#include <linux/version.h>
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/errno.h>
+#include <linux/pci.h>
+#include <linux/interrupt.h>
+#include <linux/serial_core.h>
+#include <linux/serial_8250.h>
+
+#define BMC_MULTI_MSI	32
+#define BMC_MSI_IDX_BASE	4
+
+#define DRIVER_NAME "ASPEED BMC DEVICE"
+
+#define VUART_MAX_PARMS		2
+
+#define BAR_MEM 0
+#define BAR_MSG 1
+#define BAR_MAX 2
+
+struct bar {
+	unsigned long bar_base;
+	unsigned long bar_size;
+	void __iomem *bar_ioremap;
+};
+
+struct aspeed_pci_bmc_dev {
+	struct device *dev;
+
+	struct bar bars[BAR_MAX];
+	int lines[VUART_MAX_PARMS];
+
+	int legacy_irq;
+};
+
+static uint16_t vuart_ioport[VUART_MAX_PARMS];
+static uint16_t vuart_sirq[VUART_MAX_PARMS];
+
+static int aspeed_pci_host_bmc_device_probe(struct pci_dev *pdev,
+		const struct pci_device_id *ent)
+{
+	struct uart_8250_port uart;
+	struct device *dev = &pdev->dev;
+	struct aspeed_pci_bmc_dev *pci_bmc_dev;
+	int rc = 0;
+	int i = 0;
+	int nr_entries;
+	u16 config_cmd_val;
+
+	pci_bmc_dev = kzalloc(sizeof(*pci_bmc_dev), GFP_KERNEL);
+	if (!pci_bmc_dev) {
+		rc = -ENOMEM;
+		dev_err(dev, "kmalloc() returned NULL memory.\n");
+		goto out_err;
+	}
+
+	rc = pcim_enable_device(pdev);
+	if (rc != 0) {
+		dev_err(dev, "pcim_enable_device() returned error %d\n", rc);
+		goto out_free0;
+	}
+
+	/* set PCI host mastering  */
+	pci_set_master(pdev);
+
+	/*
+	 * Try to allocate max MSI. If multiple MSI is not possible then use
+	 * the legacy interrupt. Note: PowerPC doesn't support multiple MSI.
+	 */
+	nr_entries = pci_alloc_irq_vectors(pdev, 1, BMC_MULTI_MSI,
+				PCI_IRQ_MSIX | PCI_IRQ_MSI);
+	if (nr_entries < 0) {
+		pci_bmc_dev->legacy_irq = 1;
+		pci_read_config_word(pdev, PCI_COMMAND, &config_cmd_val);
+		config_cmd_val &= ~PCI_COMMAND_INTX_DISABLE;
+		pci_write_config_word((struct pci_dev *)pdev, PCI_COMMAND, config_cmd_val);
+
+	} else {
+		pci_bmc_dev->legacy_irq = 0;
+		pci_read_config_word(pdev, PCI_COMMAND, &config_cmd_val);
+		config_cmd_val |= PCI_COMMAND_INTX_DISABLE;
+		pci_write_config_word((struct pci_dev *)pdev, PCI_COMMAND, config_cmd_val);
+		rc = pci_irq_vector(pdev, BMC_MSI_IDX_BASE);
+		if (rc < 0) {
+			dev_err(dev, "pci_irq_vector() returned error %d msi=%u msix=%u\n",
+				-rc, pdev->msi_enabled, pdev->msix_enabled);
+			goto out_free1;
+		}
+		pdev->irq = rc;
+	}
+
+	/* Get access to the BARs */
+	for (i = 0; i < BAR_MAX; i++) {
+		rc = pci_request_region(pdev, i, DRIVER_NAME);
+		if (rc < 0) {
+			dev_err(dev, "pci_request_region(%d) returned error %d\n", i, rc);
+			goto out_unreg;
+		}
+
+		pci_bmc_dev->bars[i].bar_base = pci_resource_start(pdev, i);
+		pci_bmc_dev->bars[i].bar_size = pci_resource_len(pdev, i);
+		pci_bmc_dev->bars[i].bar_ioremap = pci_ioremap_bar(pdev, i);
+		if (pci_bmc_dev->bars[i].bar_ioremap == NULL) {
+			dev_err(dev, "pci_ioremap_bar(%d) failed\n", i);
+			rc = -ENOMEM;
+			goto out_unreg;
+		}
+	}
+
+	/* ERRTA40: dummy read */
+	(void)__raw_readl((void __iomem *)pci_bmc_dev->bars[BAR_MSG].bar_ioremap);
+
+	pci_set_drvdata(pdev, pci_bmc_dev);
+
+	for (i = 0; i < VUART_MAX_PARMS; i++)
+		pci_bmc_dev->lines[i] = -1;
+
+	/* setup VUART */
+	for (i = 0; i < VUART_MAX_PARMS; i++) {
+		memset(&uart, 0, sizeof(uart));
+		vuart_ioport[i] = 0x3F8 - (i * 0x100);
+		vuart_sirq[i] = 0x10 + 4 - i - BMC_MSI_IDX_BASE;
+		uart.port.flags = UPF_SKIP_TEST | UPF_BOOT_AUTOCONF | UPF_SHARE_IRQ;
+		uart.port.uartclk = 115200 * 16;
+
+		if (pci_bmc_dev->legacy_irq) {
+			uart.port.irq = pdev->irq;
+		} else {
+			rc = pci_irq_vector(pdev, vuart_sirq[i]);
+			if (rc < 0) {
+				dev_err(dev,
+					"pci_irq_vector() returned error %d msi=%u msix=%u\n",
+					-rc, pdev->msi_enabled, pdev->msix_enabled);
+				goto out_unreg;
+			}
+			uart.port.irq = rc;
+		}
+		uart.port.dev = dev;
+		uart.port.iotype = UPIO_MEM32;
+		uart.port.iobase = 0;
+		uart.port.mapbase =
+				pci_bmc_dev->bars[BAR_MSG].bar_base + (vuart_ioport[i] << 2);
+		uart.port.membase =
+				pci_bmc_dev->bars[BAR_MSG].bar_ioremap + (vuart_ioport[i] << 2);
+		uart.port.type = PORT_16550A;
+		uart.port.flags |= (UPF_IOREMAP | UPF_FIXED_PORT | UPF_FIXED_TYPE);
+		uart.port.regshift = 2;
+
+		rc = serial8250_register_8250_port(&uart);
+		if (rc < 0) {
+			dev_err(dev,
+				"cannot setup VUART@%xh over PCIe, rc=%d\n",
+				vuart_ioport[i], -rc);
+			goto out_unreg;
+		}
+		pci_bmc_dev->lines[i] = rc;
+	}
+
+	return 0;
+
+out_unreg:
+	for (i = 0; i < VUART_MAX_PARMS; i++) {
+		if (pci_bmc_dev->lines[i] >= 0)
+			serial8250_unregister_port(pci_bmc_dev->lines[i]);
+	}
+
+	pci_release_regions(pdev);
+out_free1:
+	if (pci_bmc_dev->legacy_irq)
+		free_irq(pdev->irq, pdev);
+	else
+		pci_free_irq_vectors(pdev);
+
+	pci_clear_master(pdev);
+out_free0:
+	kfree(pci_bmc_dev);
+out_err:
+
+	return rc;
+}
+
+static void aspeed_pci_host_bmc_device_remove(struct pci_dev *pdev)
+{
+	struct aspeed_pci_bmc_dev *pci_bmc_dev = pci_get_drvdata(pdev);
+	int i;
+
+	/* Unregister ports */
+	for (i = 0; i < VUART_MAX_PARMS; i++) {
+		if (pci_bmc_dev->lines[i] >= 0)
+			serial8250_unregister_port(pci_bmc_dev->lines[i]);
+	}
+
+	if (pci_bmc_dev->legacy_irq)
+		free_irq(pdev->irq, pdev);
+	else
+		pci_free_irq_vectors(pdev);
+
+	pci_release_regions(pdev);
+	pci_clear_master(pdev);
+	kfree(pci_bmc_dev);
+}
+
+/**
+ * This table holds the list of (VendorID,DeviceID) supported by this driver
+ *
+ */
+static struct pci_device_id aspeed_host_bmc_dev_pci_ids[] = {
+	{ PCI_DEVICE(0x1A03, 0x2402), },
+	{ 0, }
+};
+
+MODULE_DEVICE_TABLE(pci, aspeed_host_bmc_dev_pci_ids);
+
+static struct pci_driver aspeed_host_bmc_dev_driver = {
+	.name		= DRIVER_NAME,
+	.id_table	= aspeed_host_bmc_dev_pci_ids,
+	.probe		= aspeed_pci_host_bmc_device_probe,
+	.remove		= aspeed_pci_host_bmc_device_remove,
+};
+
+static int __init aspeed_host_bmc_device_init(void)
+{
+	int ret;
+
+	/* register pci driver */
+	ret = pci_register_driver(&aspeed_host_bmc_dev_driver);
+	if (ret < 0) {
+		pr_err("pci-driver: can't register pci driver\n");
+		return ret;
+	}
+
+	return 0;
+}
+
+static void aspeed_host_bmc_device_exit(void)
+{
+	/* unregister pci driver */
+	pci_unregister_driver(&aspeed_host_bmc_dev_driver);
+}
+
+late_initcall(aspeed_host_bmc_device_init);
+module_exit(aspeed_host_bmc_device_exit);
+
+MODULE_AUTHOR("Ryan Chen <ryan_chen@aspeedtech.com>");
+MODULE_DESCRIPTION("ASPEED Host BMC DEVICE Driver");
+MODULE_LICENSE("GPL");
-- 
2.39.2

