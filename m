Return-Path: <linux-kernel+bounces-65622-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D2EC854F83
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 18:11:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 976001F29645
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 17:11:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78FE9612C9;
	Wed, 14 Feb 2024 17:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="T0TZ4zlh"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48FFD60DC4;
	Wed, 14 Feb 2024 17:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707930656; cv=none; b=N1M7lGuHvoG37VWEoRS4j1IaBzhXrS1GhviKrFFJ8Ugn5WCCpSOGW8p2DnJbczVCTXZNFOrWk+1dUSlnjLE6qLHj6o3DAiOq5keZdW+y0TdpUpfmcan9n9PMyfb0n8Facw0oRIROXFpWQs8LQqLHcM8m2OUqPBP/ONZRyyy/IR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707930656; c=relaxed/simple;
	bh=iqu0R7URicehdQ5woAZiYQWwq+ZkriMjICQ++/Ppr5c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KRFI8oGMOxNbQjSLKk1Zlwbdl8Yof16nm4EctETbmpzjDKhD3npOsEAoiYCfoEBnrJ2WO7FfWigLhvRpC8eGnu8P7pEvMq/eXmvOXU5UpqMXGbvpnCZTEPPZVWwHKJGTWf6/W9mkhNZV5pDBvakMUou0mDDXZ1fIxqRDKJ3Ocj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=T0TZ4zlh; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707930656; x=1739466656;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=iqu0R7URicehdQ5woAZiYQWwq+ZkriMjICQ++/Ppr5c=;
  b=T0TZ4zlhTdZqL4/snzN9WRUlMxCUYyNKHjTS266XxMmsVLSYiB29zRFk
   n0qdWk6YSnTQf+rooH/XsPU8MDKCLCLKM3x9Lvu5C27RxQAFIU2f819X3
   PbeIz8PP/zBzBYbwdXPnGWCa4zo0qMTKWFnukdkLQz4utYgZc6u0QLUJx
   2K6p5ClAiOql5RcK3RrqtpfLBLnVQk4ur2XS0XbTX7WZ63hUKtJ8J4y1M
   q5F8GFKDJ1vPMlwSau0kJrhNB7YGSSzXwREauiqvpW7QXsnHujzeLuOcR
   Ng1BpQAYiiARiFv5ofOGhXxKsHJ/nWgo4O9/iU35XNn0ql8BzYAKKgHr+
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10984"; a="24458029"
X-IronPort-AV: E=Sophos;i="6.06,160,1705392000"; 
   d="scan'208";a="24458029"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2024 09:10:53 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10984"; a="935617218"
X-IronPort-AV: E=Sophos;i="6.06,160,1705392000"; 
   d="scan'208";a="935617218"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 14 Feb 2024 09:10:49 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id C6A572E9; Wed, 14 Feb 2024 19:10:48 +0200 (EET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 4/5] serial: 8250_exar: Use 8250 PCI library to map and assign resources
Date: Wed, 14 Feb 2024 19:09:37 +0200
Message-ID: <20240214171044.3551032-5-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1.gbec44491f096
In-Reply-To: <20240214171044.3551032-1-andriy.shevchenko@linux.intel.com>
References: <20240214171044.3551032-1-andriy.shevchenko@linux.intel.com>
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
 drivers/tty/serial/8250/8250_exar.c | 10 +++++-----
 drivers/tty/serial/8250/Kconfig     |  1 +
 2 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_exar.c b/drivers/tty/serial/8250/8250_exar.c
index fa750c586b1f..3913b8a99161 100644
--- a/drivers/tty/serial/8250/8250_exar.c
+++ b/drivers/tty/serial/8250/8250_exar.c
@@ -24,6 +24,7 @@
 #include <asm/byteorder.h>
 
 #include "8250.h"
+#include "8250_pcilib.h"
 
 #define PCI_DEVICE_ID_ACCESSIO_COM_2S		0x1052
 #define PCI_DEVICE_ID_ACCESSIO_COM_4S		0x105d
@@ -230,13 +231,12 @@ static int default_setup(struct exar8250 *priv, struct pci_dev *pcidev,
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
diff --git a/drivers/tty/serial/8250/Kconfig b/drivers/tty/serial/8250/Kconfig
index a5eb2657f279..52d8589f1dbe 100644
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


