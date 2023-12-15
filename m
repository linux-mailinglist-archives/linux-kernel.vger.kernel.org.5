Return-Path: <linux-kernel+bounces-1193-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 899AA814B86
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 16:17:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 41A0B286E39
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 15:17:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CBF941862;
	Fri, 15 Dec 2023 15:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="EFoV7NEp"
X-Original-To: linux-kernel@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08663405FB;
	Fri, 15 Dec 2023 15:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1702653246; x=1734189246;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=feg3wYP3Qi/hSMSiQ+43nA6SDwvIyFsSh3WcC1SXaHg=;
  b=EFoV7NEpVtcLDdRhVihCReH4Q3t8issK19YVdZHIxIT6gdFOmyvPZiLt
   LsSObscq42Ao8czp+FZDYUJCqeFRY+pp6JhEV5iIcETl9cyEDNFe7Azzf
   vH/y3lbJ8XwkIQA4/7DcjeBvSKuPyRSpF8YwyklIvD176LK0Jh+ROEUxR
   fw3MZziXpiyTa5SxXjP31isAYbw/bBCisFJsmhbGahc7jIdRvcUGjY5g7
   USZwKJV7rTapH860SwbSWKF0TQHRTCkoOQSUPZL0x/21wY34q5wJTxKMJ
   tZnJRGkA0GPdIzKZ1Xy+qLNK6AsKSf3veqAfFvSEy4o0q908zNbI3gIfh
   w==;
X-CSE-ConnectionGUID: /L4ES2eBSEOMitxzIzm9kg==
X-CSE-MsgGUID: VDSYNS+9SUOiPlegNtIkIA==
X-ThreatScanner-Verdict: Negative
X-IronPort-AV: E=Sophos;i="6.04,279,1695711600"; 
   d="scan'208";a="13359832"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 15 Dec 2023 08:14:04 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 15 Dec 2023 08:13:20 -0700
Received: from che-dk-ungapp03lx.microchip.com (10.10.85.11) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Fri, 15 Dec 2023 08:13:17 -0700
From: Rengarajan S <rengarajan.s@microchip.com>
To: <kumaravel.thiagarajan@microchip.com>,
	<tharunkumar.pasumarthi@microchip.com>, <gregkh@linuxfoundation.org>,
	<jirislaby@kernel.org>, <keescook@chromium.org>, <gustavoars@kernel.org>,
	<linux-serial@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-hardening@vger.kernel.org>
CC: <unglinuxdriver@microchip.com>
Subject: [PATCH v1 tty-next 2/4] 8250: microchip: pci1xxxx: Add Syslock support for reading UART system registers
Date: Fri, 15 Dec 2023 20:41:21 +0530
Message-ID: <20231215151123.41812-3-rengarajan.s@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231215151123.41812-1-rengarajan.s@microchip.com>
References: <20231215151123.41812-1-rengarajan.s@microchip.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

Different Host drivers can attempt to access system registers
simultaneously from different memory spaces at the same time. The
syslock mechanism provides a safe option for reading UART system
registers and prevents conflicts by serializing access. Added
three padding bytes in the structure for memory alignment.

Signed-off-by: Rengarajan S <rengarajan.s@microchip.com>
---
 drivers/tty/serial/8250/8250_pci1xxxx.c | 63 +++++++++++++++++++++++++
 1 file changed, 63 insertions(+)

diff --git a/drivers/tty/serial/8250/8250_pci1xxxx.c b/drivers/tty/serial/8250/8250_pci1xxxx.c
index 48bd2f3a287d..6b6f3731307f 100644
--- a/drivers/tty/serial/8250/8250_pci1xxxx.c
+++ b/drivers/tty/serial/8250/8250_pci1xxxx.c
@@ -9,15 +9,21 @@
 
 #include <linux/bitfield.h>
 #include <linux/bitops.h>
+#include <linux/delay.h>
 #include <linux/io.h>
+#include <linux/iopoll.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/pci.h>
 #include <linux/serial_core.h>
+#include <linux/serial_reg.h>
+#include <linux/serial_8250.h>
 #include <linux/slab.h>
 #include <linux/string.h>
 #include <linux/units.h>
 #include <linux/tty.h>
+#include <linux/tty_flip.h>
+#include <linux/8250_pci.h>
 
 #include <asm/byteorder.h>
 
@@ -52,6 +58,14 @@
 #define PCI_SUBDEVICE_ID_EFAR_PCI11400		PCI_DEVICE_ID_EFAR_PCI11400
 #define PCI_SUBDEVICE_ID_EFAR_PCI11414		PCI_DEVICE_ID_EFAR_PCI11414
 
+#define UART_SYSTEM_ADDR_BASE			0x1000
+#define UART_DEV_REV_REG			(UART_SYSTEM_ADDR_BASE + 0x00)
+#define UART_DEV_REV_MASK			GENMASK(7, 0)
+#define UART_SYSLOCK_REG			(UART_SYSTEM_ADDR_BASE + 0xA0)
+#define UART_SYSLOCK				BIT(2)
+#define SYSLOCK_SLEEP_TIMEOUT			100
+#define SYSLOCK_RETRY_CNT			1000
+
 #define UART_ACTV_REG				0x11
 #define UART_BLOCK_SET_ACTIVE			BIT(0)
 
@@ -87,6 +101,8 @@
 
 struct pci1xxxx_8250 {
 	unsigned int nr;
+	u8 dev_rev;
+	u8 pad[3];
 	void __iomem *membase;
 	int line[] __counted_by(nr);
 };
@@ -98,6 +114,27 @@ static const struct serial_rs485 pci1xxxx_rs485_supported = {
 	/* Delay RTS before send is not supported */
 };
 
+static int pci1xxxx_set_sys_lock(struct pci1xxxx_8250 *port)
+{
+	writel(UART_SYSLOCK, port->membase + UART_SYSLOCK_REG);
+	return readl(port->membase + UART_SYSLOCK_REG);
+}
+
+static int pci1xxxx_acquire_sys_lock(struct pci1xxxx_8250 *port)
+{
+	u32 regval;
+
+	return readx_poll_timeout(pci1xxxx_set_sys_lock, port, regval,
+				  (regval & UART_SYSLOCK),
+				  SYSLOCK_SLEEP_TIMEOUT,
+				  SYSLOCK_RETRY_CNT * SYSLOCK_SLEEP_TIMEOUT);
+}
+
+static void pci1xxxx_release_sys_lock(struct pci1xxxx_8250 *port)
+{
+	writel(0x0, port->membase + UART_SYSLOCK_REG);
+}
+
 static const int logical_to_physical_port_idx[][MAX_PORTS] = {
 	{0,  1,  2,  3}, /* PCI12000, PCI11010, PCI11101, PCI11400, PCI11414 */
 	{0,  1,  2,  3}, /* PCI4p */
@@ -370,6 +407,27 @@ static int pci1xxxx_logical_to_physical_port_translate(int subsys_dev, int port)
 	return logical_to_physical_port_idx[0][port];
 }
 
+static int pci1xxxx_get_device_revision(struct pci1xxxx_8250 *priv)
+{
+	u32 regval;
+	int ret;
+
+	/*
+	 * DEV REV is a system register, HW Syslock bit
+	 * should be acquired before accessing the register
+	 */
+	ret = pci1xxxx_acquire_sys_lock(priv);
+	if (ret)
+		return ret;
+
+	regval = readl(priv->membase + UART_DEV_REV_REG);
+	priv->dev_rev = regval & UART_DEV_REV_MASK;
+
+	pci1xxxx_release_sys_lock(priv);
+
+	return 0;
+}
+
 static int pci1xxxx_serial_probe(struct pci_dev *pdev,
 				 const struct pci_device_id *id)
 {
@@ -381,6 +439,7 @@ static int pci1xxxx_serial_probe(struct pci_dev *pdev,
 	int num_vectors;
 	int subsys_dev;
 	int port_idx;
+	int ret;
 	int rc;
 
 	rc = pcim_enable_device(pdev);
@@ -397,6 +456,10 @@ static int pci1xxxx_serial_probe(struct pci_dev *pdev,
 	if (!priv->membase)
 		return -ENOMEM;
 
+	ret = pci1xxxx_get_device_revision(priv);
+	if (ret)
+		return ret;
+
 	pci_set_master(pdev);
 
 	priv->nr = nr_ports;
-- 
2.25.1


