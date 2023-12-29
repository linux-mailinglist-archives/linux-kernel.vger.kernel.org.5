Return-Path: <linux-kernel+bounces-13125-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A4495820009
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Dec 2023 15:52:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C73CA1C218A8
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Dec 2023 14:52:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8576611C9E;
	Fri, 29 Dec 2023 14:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Yv+1D9+x"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ED1C11C8B;
	Fri, 29 Dec 2023 14:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703861563; x=1735397563;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=jcb3d1Eurdn7JoSDwWMgzToJsi8wV219/OcIstMM8H4=;
  b=Yv+1D9+xExQnxR2A9GjWlNjNuXDTyNyqfWzLSnXpUsZbQHqjx6STDj7g
   apjJpRzQCJPy/RY7cUvp9e6qej516P4nwh47rD6ZTovBDhcmgeW8Im+fD
   1I9H5sppwU5nC8KinKGtrbHPwCP8d5diclmQJ4j6d78JUph3LnRYfJvBE
   WADnk7gNzVRgToQFuxrkXDvd8hAGlnxObbYzVC6Ak0gEpzisQzvYt6fTF
   V3B1HEw13lQMKc7e2L0lpCKcIzZfNSwEGDHH6fuKbCHfUWXW5oGYldwF/
   xskcjIC1wkrT0pFKyTnd6TMUtmxO4GhV2zx5Fm+9vW0gEn1aIGj/QfDX2
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10938"; a="396379422"
X-IronPort-AV: E=Sophos;i="6.04,315,1695711600"; 
   d="scan'208";a="396379422"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Dec 2023 06:52:42 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,315,1695711600"; 
   d="scan'208";a="20888995"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.246.48.133])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Dec 2023 06:52:39 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Ray Jui <rjui@broadcom.com>,
	Scott Branden <sbranden@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	netdev@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 1/1] net: mdio: mux-bcm-iproc: Use alignment helpers and SZ_4K
Date: Fri, 29 Dec 2023 16:52:32 +0200
Message-Id: <20231229145232.6163-1-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Instead of open coding, use IS_ALIGNED() and ALIGN_DOWN() when dealing
with alignment. Replace also literals with SZ_4K.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/net/mdio/mdio-mux-bcm-iproc.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/net/mdio/mdio-mux-bcm-iproc.c b/drivers/net/mdio/mdio-mux-bcm-iproc.c
index a750bd4c77a0..1ce7d67ba72e 100644
--- a/drivers/net/mdio/mdio-mux-bcm-iproc.c
+++ b/drivers/net/mdio/mdio-mux-bcm-iproc.c
@@ -2,6 +2,7 @@
 /*
  * Copyright 2016 Broadcom
  */
+#include <linux/align.h>
 #include <linux/clk.h>
 #include <linux/delay.h>
 #include <linux/device.h>
@@ -11,6 +12,7 @@
 #include <linux/of_mdio.h>
 #include <linux/phy.h>
 #include <linux/platform_device.h>
+#include <linux/sizes.h>
 
 #define MDIO_RATE_ADJ_EXT_OFFSET	0x000
 #define MDIO_RATE_ADJ_INT_OFFSET	0x004
@@ -220,12 +222,12 @@ static int mdio_mux_iproc_probe(struct platform_device *pdev)
 	md->base = devm_platform_get_and_ioremap_resource(pdev, 0, &res);
 	if (IS_ERR(md->base))
 		return PTR_ERR(md->base);
-	if (res->start & 0xfff) {
+	if (!IS_ALIGNED(res->start, SZ_4K)) {
 		/* For backward compatibility in case the
 		 * base address is specified with an offset.
 		 */
 		dev_info(&pdev->dev, "fix base address in dt-blob\n");
-		res->start &= ~0xfff;
+		res->start = ALIGN_DOWN(res->start, SZ_4K);
 		res->end = res->start + MDIO_REG_ADDR_SPACE_SIZE - 1;
 	}
 
-- 
2.39.2


