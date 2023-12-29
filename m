Return-Path: <linux-kernel+bounces-13123-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 667D0820005
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Dec 2023 15:51:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 152861F228CD
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Dec 2023 14:51:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 472EF11C8E;
	Fri, 29 Dec 2023 14:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="epBXIWDp"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B51F11C81
	for <linux-kernel@vger.kernel.org>; Fri, 29 Dec 2023 14:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703861469; x=1735397469;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=dvIUAGYDbpNOrkJuEoFIYV3Hi7P1WdKlCDuxuKOr/z0=;
  b=epBXIWDpUHuANL1KjiLA9vvuW+Pz4fjdJFrXtXIzRpS52jvrmvGC9umm
   S/Hv/BxNecmSSGdeC+8Ir50/uYXitKtUNjGK0qpfxFcBr26EyKD+rv5Zi
   jcsQq6yEQPVyEE4ty6DLXnPrDYYjhKiN2aL/z1FMVJVAV2EHA/pXmCdkb
   KeTJOmNxEDjiX22+MuaYXewkmqN4T5k8ZcyZv8yhsHG4aesmv9ZNoW9z3
   Yh2cKJDRZdus8j2uoSEQRfdMZwJi44vuTxDA/IUIU8HtYEbgyCP4S/2xM
   Kh56/zt20rFgPz+Yj+hLkQ9QLzwK1/AAKTLnshH3rca7CQ+MgtmwYe+yT
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10938"; a="3727766"
X-IronPort-AV: E=Sophos;i="6.04,315,1695711600"; 
   d="scan'208";a="3727766"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Dec 2023 06:51:08 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,315,1695711600"; 
   d="scan'208";a="13303267"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.246.48.133])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Dec 2023 06:51:05 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: Peter Tyser <ptyser@xes-inc.com>,
	Lee Jones <lee@kernel.org>,
	linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 1/1] mfd: lpc_ich: Use ALIGN_DOWN()
Date: Fri, 29 Dec 2023 16:50:59 +0200
Message-Id: <20231229145059.6138-1-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Instead of open coding, use ALIGN_DOWN() for alignment.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/mfd/lpc_ich.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/mfd/lpc_ich.c b/drivers/mfd/lpc_ich.c
index 73a0e7f9bd31..f14901660147 100644
--- a/drivers/mfd/lpc_ich.c
+++ b/drivers/mfd/lpc_ich.c
@@ -38,6 +38,7 @@
 
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
+#include <linux/align.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/errno.h>
@@ -1321,7 +1322,7 @@ static int lpc_ich_init_spi(struct pci_dev *dev)
 	case INTEL_SPI_BYT:
 		pci_read_config_dword(dev, SPIBASE_BYT, &spi_base);
 		if (spi_base & SPIBASE_BYT_EN) {
-			res->start = spi_base & ~(SPIBASE_BYT_SZ - 1);
+			res->start = ALIGN_DOWN(spi_base, SPIBASE_BYT_SZ);
 			res->end = res->start + SPIBASE_BYT_SZ - 1;
 
 			info->set_writeable = lpc_ich_byt_set_writeable;
-- 
2.39.2


