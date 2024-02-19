Return-Path: <linux-kernel+bounces-71545-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 013FD85A6E8
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 16:07:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9505C1F23291
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 15:07:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5755A3C482;
	Mon, 19 Feb 2024 15:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VBFgojoN"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09BE439AEB;
	Mon, 19 Feb 2024 15:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708355198; cv=none; b=eGSwEG/9zOigdwygqg2gXv3SQBLHebPTnhpuui33PIW1ZCG1JFPAVGeSMvKydvc7f/SMvh6EIs0jgUAMCoTgjAjlscf5LJFHFYmmAz4vHHoLAMElMj4eGq4d/3ysnVau+Ta+rfKMuhiI1d31PopOh3vzK98gbjew4AUjChOaguU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708355198; c=relaxed/simple;
	bh=XhwsDorFFCDFsHo4F14gBApk9LhtQz1RvNmzKOWEAn8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lBBV+riIx1NOz/4VlvY0lk1aA+upB8KtwEb+s3cUUYnukJeaRrh2PL8cM3880kshlQ9fNfViYKcdchfOI6NLleeh4tO4ixBJ6xjk5mZQllhIx8V3KDr1PTFCvQUNLI4RuBjsT3a9w/W4qfXdQdt1h3dByUNKrV25l2AVKKMp1Z4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VBFgojoN; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708355197; x=1739891197;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=XhwsDorFFCDFsHo4F14gBApk9LhtQz1RvNmzKOWEAn8=;
  b=VBFgojoNeCZtFyl9GsHBi9ZivZcGZbUDzFwwaPHc1S8x+5qHisxxeMLb
   FV+I94GHi/hQUphR/DvYJY1mwhRClIzvZoay8EfSiBhOZ4iNV7GFW6Rk5
   tRgzCBztj2rDDXx6KAqKa+n2isj+JmGJvQVgPJGopeofz67vSKBnD8AWh
   qS313h+9AzBrQaLwxrsE89h7Lm01zTrPNkl6qW71p8E8wnOMJnLgIEZNZ
   HYp6D4NgZr8N9p4INkfDe6SLx3T7jJGVhg0qly5xCRHNiIwwip9YbbRMU
   yXiYTEq09uDZPO9JpobqS4XV64EQg3m/aJGcg3bUGRbwcLgGYR7s1cs5z
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10989"; a="2543791"
X-IronPort-AV: E=Sophos;i="6.06,170,1705392000"; 
   d="scan'208";a="2543791"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2024 07:06:34 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10989"; a="936302994"
X-IronPort-AV: E=Sophos;i="6.06,170,1705392000"; 
   d="scan'208";a="936302994"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 19 Feb 2024 07:06:32 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 2A45E456; Mon, 19 Feb 2024 17:06:29 +0200 (EET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Cc: Jiri Slaby <jirislaby@kernel.org>
Subject: [PATCH v2 6/7] serial: 8250_exar: Use 8250 PCI library to map and assign resources
Date: Mon, 19 Feb 2024 17:05:02 +0200
Message-ID: <20240219150627.2101198-7-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1.gbec44491f096
In-Reply-To: <20240219150627.2101198-1-andriy.shevchenko@linux.intel.com>
References: <20240219150627.2101198-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

8250 PCI library provides a common code to map and assign resources.
Use it in order to deduplicate existing code and support IO port
variants.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/tty/serial/8250/8250_exar.c | 11 ++++++-----
 drivers/tty/serial/8250/Kconfig     |  1 +
 2 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_exar.c b/drivers/tty/serial/8250/8250_exar.c
index 53c5ff49e83c..cf1abe2fc28a 100644
--- a/drivers/tty/serial/8250/8250_exar.c
+++ b/drivers/tty/serial/8250/8250_exar.c
@@ -24,6 +24,7 @@
 #include <asm/byteorder.h>
 
 #include "8250.h"
+#include "8250_pcilib.h"
 
 #define PCI_DEVICE_ID_ACCESSIO_COM_2S		0x1052
 #define PCI_DEVICE_ID_ACCESSIO_COM_4S		0x105d
@@ -219,13 +220,12 @@ static int default_setup(struct exar8250 *priv, struct pci_dev *pcidev,
 			 struct uart_8250_port *port)
 {
 	const struct exar8250_board *board = priv->board;
-	unsigned int bar = 0;
 	unsigned char status;
+	int err;
 
-	port->port.iotype = UPIO_MEM;
-	port->port.mapbase = pci_resource_start(pcidev, bar) + offset;
-	port->port.membase = priv->virt + offset;
-	port->port.regshift = board->reg_shift;
+	err = serial8250_pci_setup_port(pcidev, port, 0, offset, board->reg_shift);
+	if (err)
+		return err;
 
 	/*
 	 * XR17V35x UARTs have an extra divisor register, DLD that gets enabled
@@ -929,6 +929,7 @@ static struct pci_driver exar_pci_driver = {
 };
 module_pci_driver(exar_pci_driver);
 
+MODULE_IMPORT_NS(SERIAL_8250_PCI);
 MODULE_LICENSE("GPL");
 MODULE_DESCRIPTION("Exar Serial Driver");
 MODULE_AUTHOR("Sudip Mukherjee <sudip.mukherjee@codethink.co.uk>");
diff --git a/drivers/tty/serial/8250/Kconfig b/drivers/tty/serial/8250/Kconfig
index 8b9a2c4902e2..47ff50763c04 100644
--- a/drivers/tty/serial/8250/Kconfig
+++ b/drivers/tty/serial/8250/Kconfig
@@ -149,6 +149,7 @@ config SERIAL_8250_PCI
 config SERIAL_8250_EXAR
 	tristate "8250/16550 Exar/Commtech PCI/PCIe device support"
 	depends on SERIAL_8250 && PCI
+	select SERIAL_8250_PCILIB
 	default SERIAL_8250
 	help
 	  This builds support for XR17C1xx, XR17V3xx and some Commtech
-- 
2.43.0.rc1.1.gbec44491f096


