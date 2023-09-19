Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7EAD7A6BE3
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 21:55:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233039AbjISTzg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 15:55:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232873AbjISTze (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 15:55:34 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4583AEA;
        Tue, 19 Sep 2023 12:55:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695153328; x=1726689328;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=a6PhYNTUQquDvVfYHQT2pj1ZLWbdtCtwP6SEs5rehog=;
  b=eiD/8zsv4P4/QFMZVxOeAzvrzdH/1J5wC0l9Cx+KNyjQMiWfPnm1gr1h
   64wo7B97OGhHONdx8gilw+UqXZS2yPh0hRc/SAPctL8lNv8gWSmR7VgPD
   f2cpBRXgvk1dr21/ngebRaaFL8kcib0/W6Eo4RTdACv+Kr5sg2Wt4yo3E
   0ZKwpGtx5inXubPxxDDDb5LfyQQmvKa3GnIGHtz+/mGRzCrbk8B6KJtW7
   PttkeJigDAiF8fT1WudKSIwuTHcME/LzIJD+RQ5bRrMsP1Zippl5DBU1d
   L5jl/FZfqagkuO894c+dWpx+DlWOt0daJok6bjul3wohy7qnN67HOebiw
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10838"; a="383874609"
X-IronPort-AV: E=Sophos;i="6.02,160,1688454000"; 
   d="scan'208";a="383874609"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2023 12:55:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10838"; a="746355086"
X-IronPort-AV: E=Sophos;i="6.02,160,1688454000"; 
   d="scan'208";a="746355086"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga002.jf.intel.com with ESMTP; 19 Sep 2023 12:55:22 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 6996C45B; Tue, 19 Sep 2023 22:55:21 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Andi Shyti <andi.shyti@linux.intel.com>
Subject: [PATCH v1 1/1] serial: 8250_of: Use devm_clk_get_enabled()
Date:   Tue, 19 Sep 2023 22:55:19 +0300
Message-Id: <20230919195519.3197963-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.40.0.1.gaa8946217a0b
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use devm_clk_get_enabled() to simplify the code.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Reviewed-by: Andi Shyti <andi.shyti@linux.intel.com>
---
 drivers/tty/serial/8250/8250_of.c | 24 ++++++++----------------
 1 file changed, 8 insertions(+), 16 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_of.c b/drivers/tty/serial/8250/8250_of.c
index 8c61ed25a8e4..ef3e745bd09c 100644
--- a/drivers/tty/serial/8250/8250_of.c
+++ b/drivers/tty/serial/8250/8250_of.c
@@ -47,16 +47,12 @@ static int of_platform_serial_setup(struct platform_device *ofdev,
 	if (of_property_read_u32(np, "clock-frequency", &clk)) {
 
 		/* Get clk rate through clk driver if present */
-		info->clk = devm_clk_get(&ofdev->dev, NULL);
+		info->clk = devm_clk_get_enabled(dev, NULL);
 		if (IS_ERR(info->clk)) {
 			ret = dev_err_probe(dev, PTR_ERR(info->clk), "failed to get clock\n");
 			goto err_pmruntime;
 		}
 
-		ret = clk_prepare_enable(info->clk);
-		if (ret < 0)
-			goto err_pmruntime;
-
 		clk = clk_get_rate(info->clk);
 	}
 	/* If current-speed was set, then try not to change it. */
@@ -66,7 +62,7 @@ static int of_platform_serial_setup(struct platform_device *ofdev,
 	ret = of_address_to_resource(np, 0, &resource);
 	if (ret) {
 		dev_err_probe(dev, ret, "invalid address\n");
-		goto err_unprepare;
+		goto err_pmruntime;
 	}
 
 	port->flags = UPF_SHARE_IRQ | UPF_BOOT_AUTOCONF | UPF_FIXED_PORT |
@@ -85,7 +81,7 @@ static int of_platform_serial_setup(struct platform_device *ofdev,
 			if (prop >= port->mapsize) {
 				ret = dev_err_probe(dev, -EINVAL, "reg-offset %u exceeds region size %pa\n",
 						    prop, &port->mapsize);
-				goto err_unprepare;
+				goto err_pmruntime;
 			}
 
 			port->mapbase += prop;
@@ -108,7 +104,7 @@ static int of_platform_serial_setup(struct platform_device *ofdev,
 			default:
 				ret = dev_err_probe(dev, -EINVAL, "unsupported reg-io-width (%u)\n",
 						    prop);
-				goto err_unprepare;
+				goto err_pmruntime;
 			}
 		}
 		port->flags |= UPF_IOREMAP;
@@ -135,7 +131,7 @@ static int of_platform_serial_setup(struct platform_device *ofdev,
 	if (irq < 0) {
 		if (irq == -EPROBE_DEFER) {
 			ret = -EPROBE_DEFER;
-			goto err_unprepare;
+			goto err_pmruntime;
 		}
 		/* IRQ support not mandatory */
 		irq = 0;
@@ -146,12 +142,12 @@ static int of_platform_serial_setup(struct platform_device *ofdev,
 	info->rst = devm_reset_control_get_optional_shared(&ofdev->dev, NULL);
 	if (IS_ERR(info->rst)) {
 		ret = PTR_ERR(info->rst);
-		goto err_unprepare;
+		goto err_pmruntime;
 	}
 
 	ret = reset_control_deassert(info->rst);
 	if (ret)
-		goto err_unprepare;
+		goto err_pmruntime;
 
 	port->type = type;
 	port->uartclk = clk;
@@ -169,7 +165,7 @@ static int of_platform_serial_setup(struct platform_device *ofdev,
 	case PORT_RT2880:
 		ret = rt288x_setup(port);
 		if (ret)
-			goto err_unprepare;
+			goto err_pmruntime;
 		break;
 	}
 
@@ -181,8 +177,6 @@ static int of_platform_serial_setup(struct platform_device *ofdev,
 	}
 
 	return 0;
-err_unprepare:
-	clk_disable_unprepare(info->clk);
 err_pmruntime:
 	pm_runtime_put_sync(&ofdev->dev);
 	pm_runtime_disable(&ofdev->dev);
@@ -249,7 +243,6 @@ static int of_platform_serial_probe(struct platform_device *ofdev)
 	irq_dispose_mapping(port8250.port.irq);
 	pm_runtime_put_sync(&ofdev->dev);
 	pm_runtime_disable(&ofdev->dev);
-	clk_disable_unprepare(info->clk);
 err_free:
 	kfree(info);
 	return ret;
@@ -267,7 +260,6 @@ static int of_platform_serial_remove(struct platform_device *ofdev)
 	reset_control_assert(info->rst);
 	pm_runtime_put_sync(&ofdev->dev);
 	pm_runtime_disable(&ofdev->dev);
-	clk_disable_unprepare(info->clk);
 	kfree(info);
 	return 0;
 }
-- 
2.40.0.1.gaa8946217a0b

