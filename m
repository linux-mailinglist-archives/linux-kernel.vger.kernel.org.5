Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FDB779D6EF
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 18:56:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237203AbjILQ4X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 12:56:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237194AbjILQ4Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 12:56:16 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6233110;
        Tue, 12 Sep 2023 09:56:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694537772; x=1726073772;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=pV99F/DxJsfDjodvyOfXHlYZI7zldMz95G0ynqOMMX4=;
  b=PcjcwyiCusHpqFmZaruy9mCTfi4eVXAeqP5t3rS6vX6OPa/GNuiZBAYx
   rRBCpxrK00bPeTjBXHczudTPDVv97NOB+5KiH1Hv1Gj93pB4vym0NlZcb
   4KRTQapPp4Naovn2hTMmqO8iy96tRqD/ZZrb2ts8KlWA/BcnFHpDe8XdW
   kH/DF9b5ppONmKk22Fvu1Bre2gpbnPWwip6XJ5HVREc1HvJoSqhoV/TSn
   g2qFZG/094L/MuBWuS2SkL5jZA4TmuiK2pDtn85GXbFq4v3p4cZVN6QTj
   X2VM/O96Ys9ea4NxWql5UjH9BoQrFkQgDG8fijgFvqHzSWPkOrxR27XxH
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10831"; a="363469835"
X-IronPort-AV: E=Sophos;i="6.02,139,1688454000"; 
   d="scan'208";a="363469835"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2023 09:56:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10831"; a="809349527"
X-IronPort-AV: E=Sophos;i="6.02,139,1688454000"; 
   d="scan'208";a="809349527"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga008.fm.intel.com with ESMTP; 12 Sep 2023 09:56:10 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id B7E2F248; Tue, 12 Sep 2023 19:56:08 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
Subject: [PATCH v1 1/1] serial: 8250_of: Use dev_err_probe() instead of dev_warn()
Date:   Tue, 12 Sep 2023 19:56:07 +0300
Message-Id: <20230912165607.402580-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.40.0.1.gaa8946217a0b
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The probe process may generate EPROBE_DEFER. In this case
dev_err_probe() can still record err information. Otherwise
it may pollute logs on that occasion.

This also helps simplifing code and standardizing the error output.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/tty/serial/8250/8250_of.c | 20 ++++++++------------
 1 file changed, 8 insertions(+), 12 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_of.c b/drivers/tty/serial/8250/8250_of.c
index 51329625c48a..8c61ed25a8e4 100644
--- a/drivers/tty/serial/8250/8250_of.c
+++ b/drivers/tty/serial/8250/8250_of.c
@@ -33,7 +33,8 @@ static int of_platform_serial_setup(struct platform_device *ofdev,
 			struct of_serial_info *info)
 {
 	struct resource resource;
-	struct device_node *np = ofdev->dev.of_node;
+	struct device *dev = &ofdev->dev;
+	struct device_node *np = dev->of_node;
 	struct uart_port *port = &up->port;
 	u32 clk, spd, prop;
 	int ret, irq;
@@ -48,10 +49,7 @@ static int of_platform_serial_setup(struct platform_device *ofdev,
 		/* Get clk rate through clk driver if present */
 		info->clk = devm_clk_get(&ofdev->dev, NULL);
 		if (IS_ERR(info->clk)) {
-			ret = PTR_ERR(info->clk);
-			if (ret != -EPROBE_DEFER)
-				dev_warn(&ofdev->dev,
-					 "failed to get clock: %d\n", ret);
+			ret = dev_err_probe(dev, PTR_ERR(info->clk), "failed to get clock\n");
 			goto err_pmruntime;
 		}
 
@@ -67,7 +65,7 @@ static int of_platform_serial_setup(struct platform_device *ofdev,
 
 	ret = of_address_to_resource(np, 0, &resource);
 	if (ret) {
-		dev_warn(&ofdev->dev, "invalid address\n");
+		dev_err_probe(dev, ret, "invalid address\n");
 		goto err_unprepare;
 	}
 
@@ -85,9 +83,8 @@ static int of_platform_serial_setup(struct platform_device *ofdev,
 		/* Check for shifted address mapping */
 		if (of_property_read_u32(np, "reg-offset", &prop) == 0) {
 			if (prop >= port->mapsize) {
-				dev_warn(&ofdev->dev, "reg-offset %u exceeds region size %pa\n",
-					 prop, &port->mapsize);
-				ret = -EINVAL;
+				ret = dev_err_probe(dev, -EINVAL, "reg-offset %u exceeds region size %pa\n",
+						    prop, &port->mapsize);
 				goto err_unprepare;
 			}
 
@@ -109,9 +106,8 @@ static int of_platform_serial_setup(struct platform_device *ofdev,
 					       UPIO_MEM32BE : UPIO_MEM32;
 				break;
 			default:
-				dev_warn(&ofdev->dev, "unsupported reg-io-width (%d)\n",
-					 prop);
-				ret = -EINVAL;
+				ret = dev_err_probe(dev, -EINVAL, "unsupported reg-io-width (%u)\n",
+						    prop);
 				goto err_unprepare;
 			}
 		}
-- 
2.40.0.1.gaa8946217a0b

