Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C26A97540A6
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 19:42:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235873AbjGNRl7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 13:41:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235879AbjGNRlY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 13:41:24 -0400
Received: from mail-io1-f50.google.com (mail-io1-f50.google.com [209.85.166.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBC183AB0;
        Fri, 14 Jul 2023 10:41:05 -0700 (PDT)
Received: by mail-io1-f50.google.com with SMTP id ca18e2360f4ac-786f25bcb40so89929639f.3;
        Fri, 14 Jul 2023 10:41:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689356465; x=1691948465;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jvH/xBkXYXN6/K450AN+5qOLcf+Sdzymd3fxSPq2/UQ=;
        b=UQSLMxWntPAiwRN/zYrJNvWs72NOlmmY80jMT8PWkOzQS3HkbXBDndqbD+XoFuHCRs
         rWNbb/XapjlsMt+Tl7/eer+T4G/zfpWJCEYtn3QcoyOYY3Wp/4JI7P4pXAQjOIIlUQXy
         Y76MX15TlofgL8Hbzlmlu/4130TDU9UaXzQn7bzMJbWj3BQP9J8oS0vzQZOuQOHZOlKq
         UlnvSsbqLNRGUzcoPlYMVMEkhsgx3QEfhazd1F0smbXLMQShpboTC++y3Okdg7A5Mq1O
         uKojN5yfl9VERWnWcXh+GjZ9KdF2h28tnModPd5MFVCVLG1yK4UWXeZx9lCRnokzkrL6
         ji5Q==
X-Gm-Message-State: ABy/qLaGP+6Y9EOiFNwFc9gZraRNYLw+1TFGZQ3yut7+5fnNTc98o9lF
        R16RqQXn2I8Frjg1gwAvfJ0FSUkqLw==
X-Google-Smtp-Source: APBJJlH2E07jplU1Y05sDq+mSOgHO2BAN1bDFdu6LnbWD+LtqaqqGQaQeLLjYL0oIYxFqxIYRPxlEw==
X-Received: by 2002:a05:6e02:933:b0:346:50ce:d602 with SMTP id o19-20020a056e02093300b0034650ced602mr4840601ilt.1.1689356464806;
        Fri, 14 Jul 2023 10:41:04 -0700 (PDT)
Received: from robh_at_kernel.org ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id b3-20020a92db03000000b00345e3a04f2dsm2887897iln.62.2023.07.14.10.41.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jul 2023 10:41:04 -0700 (PDT)
Received: (nullmailer pid 4041242 invoked by uid 1000);
        Fri, 14 Jul 2023 17:41:01 -0000
From:   Rob Herring <robh@kernel.org>
To:     Stuart Yoder <stuyoder@gmail.com>,
        Laurentiu Tudor <laurentiu.tudor@nxp.com>,
        Jay Fang <f.fangjian@huawei.com>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev
Subject: [PATCH] bus: Explicitly include correct DT includes
Date:   Fri, 14 Jul 2023 11:40:59 -0600
Message-Id: <20230714174100.4041178-1-robh@kernel.org>
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
 drivers/bus/fsl-mc/fsl-mc-bus.c | 1 +
 drivers/bus/fsl-mc/fsl-mc-msi.c | 2 --
 drivers/bus/hisi_lpc.c          | 2 +-
 drivers/bus/omap_l3_smx.c       | 1 -
 drivers/bus/simple-pm-bus.c     | 2 ++
 drivers/bus/sunxi-rsb.c         | 2 +-
 drivers/bus/ti-pwmss.c          | 2 +-
 7 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/bus/fsl-mc/fsl-mc-bus.c b/drivers/bus/fsl-mc/fsl-mc-bus.c
index 4352745a923c..7c57e7d2ff55 100644
--- a/drivers/bus/fsl-mc/fsl-mc-bus.c
+++ b/drivers/bus/fsl-mc/fsl-mc-bus.c
@@ -14,6 +14,7 @@
 #include <linux/of_device.h>
 #include <linux/of_address.h>
 #include <linux/ioport.h>
+#include <linux/platform_device.h>
 #include <linux/slab.h>
 #include <linux/limits.h>
 #include <linux/bitops.h>
diff --git a/drivers/bus/fsl-mc/fsl-mc-msi.c b/drivers/bus/fsl-mc/fsl-mc-msi.c
index f3f8af9426c9..82cd69f7884c 100644
--- a/drivers/bus/fsl-mc/fsl-mc-msi.c
+++ b/drivers/bus/fsl-mc/fsl-mc-msi.c
@@ -7,8 +7,6 @@
  *
  */
 
-#include <linux/of_device.h>
-#include <linux/of_address.h>
 #include <linux/of_irq.h>
 #include <linux/irq.h>
 #include <linux/irqdomain.h>
diff --git a/drivers/bus/hisi_lpc.c b/drivers/bus/hisi_lpc.c
index 5b65a48f17e7..cdc4e38c113e 100644
--- a/drivers/bus/hisi_lpc.c
+++ b/drivers/bus/hisi_lpc.c
@@ -13,9 +13,9 @@
 #include <linux/logic_pio.h>
 #include <linux/module.h>
 #include <linux/of.h>
-#include <linux/of_address.h>
 #include <linux/of_platform.h>
 #include <linux/pci.h>
+#include <linux/platform_device.h>
 #include <linux/serial_8250.h>
 #include <linux/slab.h>
 
diff --git a/drivers/bus/omap_l3_smx.c b/drivers/bus/omap_l3_smx.c
index bb1606f5ce2d..9ba18c39c671 100644
--- a/drivers/bus/omap_l3_smx.c
+++ b/drivers/bus/omap_l3_smx.c
@@ -15,7 +15,6 @@
 #include <linux/io.h>
 #include <linux/module.h>
 #include <linux/of.h>
-#include <linux/of_device.h>
 
 #include "omap_l3_smx.h"
 
diff --git a/drivers/bus/simple-pm-bus.c b/drivers/bus/simple-pm-bus.c
index 4da77ca7b75a..aafcc481de91 100644
--- a/drivers/bus/simple-pm-bus.c
+++ b/drivers/bus/simple-pm-bus.c
@@ -11,6 +11,8 @@
 
 #include <linux/clk.h>
 #include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
 #include <linux/of_platform.h>
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
diff --git a/drivers/bus/sunxi-rsb.c b/drivers/bus/sunxi-rsb.c
index 696c0aefb0ca..cae64cf5a387 100644
--- a/drivers/bus/sunxi-rsb.c
+++ b/drivers/bus/sunxi-rsb.c
@@ -39,7 +39,7 @@
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/of_irq.h>
-#include <linux/of_platform.h>
+#include <linux/of_device.h>
 #include <linux/platform_device.h>
 #include <linux/pm.h>
 #include <linux/pm_runtime.h>
diff --git a/drivers/bus/ti-pwmss.c b/drivers/bus/ti-pwmss.c
index e9c26c94251b..480a4de76cd4 100644
--- a/drivers/bus/ti-pwmss.c
+++ b/drivers/bus/ti-pwmss.c
@@ -10,7 +10,7 @@
 #include <linux/io.h>
 #include <linux/err.h>
 #include <linux/pm_runtime.h>
-#include <linux/of_device.h>
+#include <linux/of_platform.h>
 
 static const struct of_device_id pwmss_of_match[] = {
 	{ .compatible	= "ti,am33xx-pwmss" },
-- 
2.40.1

