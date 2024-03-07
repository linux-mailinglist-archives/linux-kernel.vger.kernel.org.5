Return-Path: <linux-kernel+bounces-95454-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 382B5874DCE
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 12:44:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DCED51F21A2C
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 11:44:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B38B1292CD;
	Thu,  7 Mar 2024 11:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ki8nLuQj"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B43A12A156;
	Thu,  7 Mar 2024 11:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709811769; cv=none; b=eBhfjJ9EZyR9wuxtZ36NYMxDZPuZN3KicGz6rwpfFWU6AjzcJGeHHyO9pbBUZVL9s3k7srRowdazz1lRZ76pjTu4sGzQVx+V2DugfK6rPB21L9qsO88FgdUvPsDxKCxEhaeY9Itb4I9AVC0vLhSpGAXuVPNRnt/Z11GmFiFJAKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709811769; c=relaxed/simple;
	bh=eyprLHFR1EiVFsCGdQ/GNrh/FyDMORPPriQDhRlU+Yk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=I6LjFO1NFO3dLZkey+Z3T/TQtkb+wkeCWi+Rg/lYCa4MYrXt/rdp2t8bKNFSqD49M7jACAOBkA0fBaekZVgUBh0hAp2owOXDI/0V6mhZvR6aUeeZE265GVE/0bsHMPPd0rrd5oVzYwK1YdkoFMHEEdYLPZdnuLknBiYeA6olp+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ki8nLuQj; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709811768; x=1741347768;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=eyprLHFR1EiVFsCGdQ/GNrh/FyDMORPPriQDhRlU+Yk=;
  b=ki8nLuQjhkBWELQaGww8nhzcQQTyp7m4IWE6GS2jAuyubSkUlsL5wo22
   wi4b51KJwRx36bvD1hUDvCIbfrA+lePW66HnmKfVcToqf2K+t6vSNNXA0
   rfGiKAklEdhusLe9Bee+sl1vpYDvjmqHNNPk4Ntx+L71NfjSY1wZOFixD
   5pMsLtOcU6BhZ9kzMIhLfAZfPy3BHzptVovzZhWAZoM2v/tOKqyJUmt1W
   XCohe8DA9pmnS39GXD0R4v3uzP3tbD527eq03DdvPXk9WcTSE4EMrroDS
   /Yng6XyFSzneUHWmMQeMWuj/VQ3FdJLYQ7+Fc134tpfEJxq6JHl4jEvxc
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11005"; a="15119775"
X-IronPort-AV: E=Sophos;i="6.07,211,1708416000"; 
   d="scan'208";a="15119775"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2024 03:42:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11005"; a="937045879"
X-IronPort-AV: E=Sophos;i="6.07,211,1708416000"; 
   d="scan'208";a="937045879"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 07 Mar 2024 03:42:46 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id F401C193; Thu,  7 Mar 2024 13:42:44 +0200 (EET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Cc: Jiri Slaby <jirislaby@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/1] serial: pic32_uart: Replace of_gpio.h by proper one
Date: Thu,  7 Mar 2024 13:42:43 +0200
Message-ID: <20240307114243.3642832-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1.gbec44491f096
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

of_gpio.h is deprecated and subject to remove.
The driver doesn't use it directly, replace it
with what is really being used.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/tty/serial/pic32_uart.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/pic32_uart.c b/drivers/tty/serial/pic32_uart.c
index bbb46e6e98a2..1619186e158e 100644
--- a/drivers/tty/serial/pic32_uart.c
+++ b/drivers/tty/serial/pic32_uart.c
@@ -8,11 +8,11 @@
  *   Sorin-Andrei Pistirica <andrei.pistirica@microchip.com>
  */
 
+#include <linux/gpio/consumer.h>
 #include <linux/kernel.h>
 #include <linux/platform_device.h>
 #include <linux/of.h>
 #include <linux/of_irq.h>
-#include <linux/of_gpio.h>
 #include <linux/init.h>
 #include <linux/module.h>
 #include <linux/slab.h>
-- 
2.43.0.rc1.1.gbec44491f096


