Return-Path: <linux-kernel+bounces-94058-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2FAC873938
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 15:33:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 00D451C219F6
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 14:33:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3F03133439;
	Wed,  6 Mar 2024 14:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Cd7hp7DQ"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 601DD7FBDC;
	Wed,  6 Mar 2024 14:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709735610; cv=none; b=aJTUjoTYR4Kn6LcXW3d1+HmYS3UPhRMgTsBoFakAU1aqZJH13sgYCWPUb2HQ/alJ3W+84HiPVxZcd+VDG8jjZ+45rtxaMTp7qMLeEkJLPOsESCxf+soFiLTi+l9Ob7LRXS5kh0HUNRNmw12fR9RinePFtCCovor8IQxGlFjPEfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709735610; c=relaxed/simple;
	bh=HUrdNo04SJI+Qhl7X0wlBzlTLUsv8zfi8LaV6ct1kuI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RJ4FdfK++teFzmKAw3klgXw16MHOimOvsm8FWWZjD4kvotboTE1Ufzs0Kd/LQgHNWiaIGHqi9b1bq3LZkmuwyX0ZbihA63lGhStavUXsfTaf7POiwsOME3Bi8txjPNBvJkvAypjEBmBpgzpkc3Q5vGP6J+qGJKTvH6JQN39pbI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Cd7hp7DQ; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709735610; x=1741271610;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=HUrdNo04SJI+Qhl7X0wlBzlTLUsv8zfi8LaV6ct1kuI=;
  b=Cd7hp7DQooPf1BSDPTCi/5jKPf5WaCgjdtyPUeoMEBQOcJK8Fra+eQFw
   7Dn79nfa2orn3MdsrsVGoAqjiLgLKtp4kMtJYypko5CLvHS93vO2K/G8g
   7vINF/IQ4/JBDF0q/RbNEbnPqnydM90pP5w+0NHjrxRLy+fFc+heUmr0R
   qe88cE2QFeLJVN2s0ulfXlzMxmBUoeT32siyIzTRiJdAG79dzVwqc01+C
   L1Rz44XilVJycZ1aZXXTk5pjiwCp/2pVQf63AHeiahZH9Ti0b6FHYiFHd
   CxHrAQ3kH/ITA8g8PEcapk2c6SsY2RVw+YEyQmBUcxaGCj1hafIB1gTuc
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11004"; a="4464017"
X-IronPort-AV: E=Sophos;i="6.06,208,1705392000"; 
   d="scan'208";a="4464017"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2024 06:33:29 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11004"; a="937045010"
X-IronPort-AV: E=Sophos;i="6.06,208,1705392000"; 
   d="scan'208";a="937045010"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 06 Mar 2024 06:33:26 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id B4C453F1; Wed,  6 Mar 2024 16:33:25 +0200 (EET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Cc: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Subject: [PATCH v1 1/1] serial: 8250_dw: Replace ACPI device check by a quirk
Date: Wed,  6 Mar 2024 16:33:22 +0200
Message-ID: <20240306143322.3291123-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1.gbec44491f096
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Instead of checking for APMC0D08 ACPI device presence,
use a quirk based on driver data.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/tty/serial/8250/8250_dw.c | 51 ++++++++++++++++---------------
 1 file changed, 26 insertions(+), 25 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_dw.c b/drivers/tty/serial/8250/8250_dw.c
index 9ac4be748596..a3acbf0f5da1 100644
--- a/drivers/tty/serial/8250/8250_dw.c
+++ b/drivers/tty/serial/8250/8250_dw.c
@@ -9,7 +9,6 @@
  * LCR is written whilst busy.  If it is, then a busy detect interrupt is
  * raised, the LCR needs to be rewritten and the uart status register read.
  */
-#include <linux/acpi.h>
 #include <linux/clk.h>
 #include <linux/delay.h>
 #include <linux/device.h>
@@ -55,6 +54,7 @@
 #define DW_UART_QUIRK_ARMADA_38X	BIT(1)
 #define DW_UART_QUIRK_SKIP_SET_RATE	BIT(2)
 #define DW_UART_QUIRK_IS_DMA_FC		BIT(3)
+#define DW_UART_QUIRK_APMC0D08		BIT(4)
 
 static inline struct dw8250_data *clk_to_dw8250_data(struct notifier_block *nb)
 {
@@ -444,33 +444,29 @@ static void dw8250_prepare_rx_dma(struct uart_8250_port *p)
 
 static void dw8250_quirks(struct uart_port *p, struct dw8250_data *data)
 {
-	struct device_node *np = p->dev->of_node;
-
-	if (np) {
-		unsigned int quirks = data->pdata->quirks;
+	unsigned int quirks = data->pdata ? data->pdata->quirks : 0;
 
 #ifdef CONFIG_64BIT
-		if (quirks & DW_UART_QUIRK_OCTEON) {
-			p->serial_in = dw8250_serial_inq;
-			p->serial_out = dw8250_serial_outq;
-			p->flags = UPF_SKIP_TEST | UPF_SHARE_IRQ | UPF_FIXED_TYPE;
-			p->type = PORT_OCTEON;
-			data->skip_autocfg = true;
-		}
+	if (quirks & DW_UART_QUIRK_OCTEON) {
+		p->serial_in = dw8250_serial_inq;
+		p->serial_out = dw8250_serial_outq;
+		p->flags = UPF_SKIP_TEST | UPF_SHARE_IRQ | UPF_FIXED_TYPE;
+		p->type = PORT_OCTEON;
+		data->skip_autocfg = true;
+	}
 #endif
 
-		if (quirks & DW_UART_QUIRK_ARMADA_38X)
-			p->serial_out = dw8250_serial_out38x;
-		if (quirks & DW_UART_QUIRK_SKIP_SET_RATE)
-			p->set_termios = dw8250_do_set_termios;
-		if (quirks & DW_UART_QUIRK_IS_DMA_FC) {
-			data->data.dma.txconf.device_fc = 1;
-			data->data.dma.rxconf.device_fc = 1;
-			data->data.dma.prepare_tx_dma = dw8250_prepare_tx_dma;
-			data->data.dma.prepare_rx_dma = dw8250_prepare_rx_dma;
-		}
-
-	} else if (acpi_dev_present("APMC0D08", NULL, -1)) {
+	if (quirks & DW_UART_QUIRK_ARMADA_38X)
+		p->serial_out = dw8250_serial_out38x;
+	if (quirks & DW_UART_QUIRK_SKIP_SET_RATE)
+		p->set_termios = dw8250_do_set_termios;
+	if (quirks & DW_UART_QUIRK_IS_DMA_FC) {
+		data->data.dma.txconf.device_fc = 1;
+		data->data.dma.rxconf.device_fc = 1;
+		data->data.dma.prepare_tx_dma = dw8250_prepare_tx_dma;
+		data->data.dma.prepare_rx_dma = dw8250_prepare_rx_dma;
+	}
+	if (quirks & DW_UART_QUIRK_APMC0D08) {
 		p->iotype = UPIO_MEM32;
 		p->regshift = 2;
 		p->serial_in = dw8250_serial_in32;
@@ -750,13 +746,18 @@ static const struct of_device_id dw8250_of_match[] = {
 };
 MODULE_DEVICE_TABLE(of, dw8250_of_match);
 
+static const struct dw8250_platform_data dw8250_apmc0d08 = {
+	.usr_reg = DW_UART_USR,
+	.quirks = DW_UART_QUIRK_APMC0D08,
+};
+
 static const struct acpi_device_id dw8250_acpi_match[] = {
 	{ "80860F0A", (kernel_ulong_t)&dw8250_dw_apb },
 	{ "8086228A", (kernel_ulong_t)&dw8250_dw_apb },
 	{ "AMD0020", (kernel_ulong_t)&dw8250_dw_apb },
 	{ "AMDI0020", (kernel_ulong_t)&dw8250_dw_apb },
 	{ "AMDI0022", (kernel_ulong_t)&dw8250_dw_apb },
-	{ "APMC0D08", (kernel_ulong_t)&dw8250_dw_apb},
+	{ "APMC0D08", (kernel_ulong_t)&dw8250_apmc0d08 },
 	{ "BRCM2032", (kernel_ulong_t)&dw8250_dw_apb },
 	{ "HISI0031", (kernel_ulong_t)&dw8250_dw_apb },
 	{ "INT33C4", (kernel_ulong_t)&dw8250_dw_apb },
-- 
2.43.0.rc1.1.gbec44491f096


