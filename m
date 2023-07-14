Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03F417540F1
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 19:46:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236293AbjGNRpg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 13:45:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235555AbjGNRpe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 13:45:34 -0400
Received: from mail-io1-f41.google.com (mail-io1-f41.google.com [209.85.166.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 952004211;
        Fri, 14 Jul 2023 10:44:58 -0700 (PDT)
Received: by mail-io1-f41.google.com with SMTP id ca18e2360f4ac-77a62a84855so87543239f.1;
        Fri, 14 Jul 2023 10:44:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689356697; x=1691948697;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PqfHU9/jof2n+eltFOXNaUlea7YTW9U5AL0XDRpcvbQ=;
        b=DSKpWn5A6mtOjq7RVrcNMIjIRYLeABfPuf3q0vX4fGaPKhUKNw30VLti00uShyFPFo
         juAqumcRrT0/2rBi8TeZM70Gi59ar7NnH+AtNrlBWhsPhv5NjkQfiqAT5FVZ6o2o5V45
         4S+QwZgRVvnt4YojSp+9dTaGwiZ0Mv6C+dAvm+yzFgUNQBi2SN3I3BfLoxVAGNGPGM20
         6wKqk0a0HjUw9WUyuTwUB1DoJeN7Vj897g34NW84QsbZax9HqPeeZXdqhML9rVZM5Z9T
         zXLqoBNd9isMpeqBHXjpwQbAd71N9+fV44rExftJyQDe5WhYIDLTB7iVSq573gMzkfQ6
         P8IA==
X-Gm-Message-State: ABy/qLb9F+Jt8Mm0Ciy/1tmMuxNTxugl/E4vlkA3fj0t5fadq+HNQA6B
        yfPc0McC9EU4DSorrk3B1Q==
X-Google-Smtp-Source: APBJJlGqidc7FR4pp1OFipkVAh6jg4XeFaJZWlf6SWayCHN6GNVV5PeDvJ4WqDNSobo6mLD6zaMjDg==
X-Received: by 2002:a6b:760e:0:b0:787:f94:5133 with SMTP id g14-20020a6b760e000000b007870f945133mr4908622iom.2.1689356697247;
        Fri, 14 Jul 2023 10:44:57 -0700 (PDT)
Received: from robh_at_kernel.org ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id c4-20020a6bec04000000b00786f50d6bf5sm2683997ioh.19.2023.07.14.10.44.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jul 2023 10:44:56 -0700 (PDT)
Received: (nullmailer pid 4055297 invoked by uid 1000);
        Fri, 14 Jul 2023 17:44:55 -0000
From:   Rob Herring <robh@kernel.org>
To:     Moritz Fischer <mdf@kernel.org>, Wu Hao <hao.wu@intel.com>,
        Xu Yilun <yilun.xu@intel.com>, Tom Rix <trix@redhat.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        Vladimir Georgiev <v.georgiev@metrotek.ru>
Cc:     devicetree@vger.kernel.org, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] fpga: Explicitly include correct DT includes
Date:   Fri, 14 Jul 2023 11:44:48 -0600
Message-Id: <20230714174449.4055156-1-robh@kernel.org>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The DT of_device.h and of_platform.h date back to the separate
of_platform_bus_type before it as merged into the regular platform bus.
As part of that merge prepping Arm DT support 13 years ago, they
"temporarily" include each other. They also include platform_device.h
and of.h. As a result, there's a pretty much random mix of those include
files used throughout the tree. In order to detangle these headers and
replace the implicit includes with struct declarations, users need to
explicitly include the correct includes.

Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/fpga/altera-fpga2sdram.c      | 2 +-
 drivers/fpga/altera-freeze-bridge.c   | 7 +++----
 drivers/fpga/altera-pr-ip-core-plat.c | 3 ++-
 drivers/fpga/microchip-spi.c          | 2 +-
 drivers/fpga/of-fpga-region.c         | 2 ++
 drivers/fpga/stratix10-soc.c          | 1 +
 6 files changed, 10 insertions(+), 7 deletions(-)

diff --git a/drivers/fpga/altera-fpga2sdram.c b/drivers/fpga/altera-fpga2sdram.c
index ff3a646fd9e3..1fa2ccc321ab 100644
--- a/drivers/fpga/altera-fpga2sdram.c
+++ b/drivers/fpga/altera-fpga2sdram.c
@@ -27,7 +27,7 @@
 #include <linux/kernel.h>
 #include <linux/mfd/syscon.h>
 #include <linux/module.h>
-#include <linux/of_platform.h>
+#include <linux/of.h>
 #include <linux/regmap.h>
 
 #define ALT_SDR_CTL_FPGAPORTRST_OFST		0x80
diff --git a/drivers/fpga/altera-freeze-bridge.c b/drivers/fpga/altera-freeze-bridge.c
index 445f4b011167..db5977725a51 100644
--- a/drivers/fpga/altera-freeze-bridge.c
+++ b/drivers/fpga/altera-freeze-bridge.c
@@ -7,8 +7,9 @@
 #include <linux/delay.h>
 #include <linux/io.h>
 #include <linux/kernel.h>
-#include <linux/of_device.h>
+#include <linux/mod_devicetable.h>
 #include <linux/module.h>
+#include <linux/platform_device.h>
 #include <linux/fpga/fpga-bridge.h>
 
 #define FREEZE_CSR_STATUS_OFFSET		0
@@ -198,13 +199,11 @@ static const struct fpga_bridge_ops altera_freeze_br_br_ops = {
 	.enable_show = altera_freeze_br_enable_show,
 };
 
-#ifdef CONFIG_OF
 static const struct of_device_id altera_freeze_br_of_match[] = {
 	{ .compatible = "altr,freeze-bridge-controller", },
 	{},
 };
 MODULE_DEVICE_TABLE(of, altera_freeze_br_of_match);
-#endif
 
 static int altera_freeze_br_probe(struct platform_device *pdev)
 {
@@ -270,7 +269,7 @@ static struct platform_driver altera_freeze_br_driver = {
 	.remove = altera_freeze_br_remove,
 	.driver = {
 		.name	= "altera_freeze_br",
-		.of_match_table = of_match_ptr(altera_freeze_br_of_match),
+		.of_match_table = altera_freeze_br_of_match,
 	},
 };
 
diff --git a/drivers/fpga/altera-pr-ip-core-plat.c b/drivers/fpga/altera-pr-ip-core-plat.c
index b008a6b8d2d3..b1244ca182e4 100644
--- a/drivers/fpga/altera-pr-ip-core-plat.c
+++ b/drivers/fpga/altera-pr-ip-core-plat.c
@@ -9,7 +9,8 @@
  */
 #include <linux/fpga/altera-pr-ip-core.h>
 #include <linux/module.h>
-#include <linux/of_device.h>
+#include <linux/mod_devicetable.h>
+#include <linux/platform_device.h>
 
 static int alt_pr_platform_probe(struct platform_device *pdev)
 {
diff --git a/drivers/fpga/microchip-spi.c b/drivers/fpga/microchip-spi.c
index d6070e7f5205..2a82c726d6e5 100644
--- a/drivers/fpga/microchip-spi.c
+++ b/drivers/fpga/microchip-spi.c
@@ -8,7 +8,7 @@
 #include <linux/fpga/fpga-mgr.h>
 #include <linux/iopoll.h>
 #include <linux/module.h>
-#include <linux/of_device.h>
+#include <linux/of.h>
 #include <linux/spi/spi.h>
 
 #define	MPF_SPI_ISC_ENABLE	0x0B
diff --git a/drivers/fpga/of-fpga-region.c b/drivers/fpga/of-fpga-region.c
index ae82532fc127..a6affd83f275 100644
--- a/drivers/fpga/of-fpga-region.c
+++ b/drivers/fpga/of-fpga-region.c
@@ -12,7 +12,9 @@
 #include <linux/kernel.h>
 #include <linux/list.h>
 #include <linux/module.h>
+#include <linux/of.h>
 #include <linux/of_platform.h>
+#include <linux/platform_device.h>
 #include <linux/slab.h>
 #include <linux/spinlock.h>
 
diff --git a/drivers/fpga/stratix10-soc.c b/drivers/fpga/stratix10-soc.c
index f7f01982a512..cacb9cc5757e 100644
--- a/drivers/fpga/stratix10-soc.c
+++ b/drivers/fpga/stratix10-soc.c
@@ -10,6 +10,7 @@
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/of_platform.h>
+#include <linux/platform_device.h>
 
 /*
  * FPGA programming requires a higher level of privilege (EL3), per the SoC
-- 
2.40.1

