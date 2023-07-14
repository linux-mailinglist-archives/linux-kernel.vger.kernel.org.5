Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DEFA75417F
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 19:55:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236783AbjGNRyI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 13:54:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236627AbjGNRxn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 13:53:43 -0400
Received: from mail-io1-f41.google.com (mail-io1-f41.google.com [209.85.166.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 921823A8F;
        Fri, 14 Jul 2023 10:53:13 -0700 (PDT)
Received: by mail-io1-f41.google.com with SMTP id ca18e2360f4ac-7836272f36eso89730839f.1;
        Fri, 14 Jul 2023 10:53:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689357131; x=1691949131;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KMGMhhBOKvrqzG6Chm/OfzHX4ABY4AlZjMg+WBLKLoE=;
        b=CnkRYubZ8QS9nYtO5F/7uVbii1E0Py6K9L8H/7jcQbFwF1/1jTXSNiGUydPAwFiLnN
         zM2ZxYIV+pgocnfjhfrlXNbYGFGJIouZHdlYkQ8LSqEZbxHwisLD0U3RW/tCcKgK/YpM
         ntMlkFp4iew62EZKHlu784qjdXSxYg36xiLMQP96KC4KYhF7zbA2AsQgEx6PRWG9VEsp
         gvYO66FxFXFjZu33lCjDFU7K38gb3ddESd9hCHC/6zbXoQP7yZfn5cuumI+vvYWnK49C
         hI71Qd2C3hI8aKQK2L8XUkq1OmMc07ptxa9MJBmKTXeUUcUl8f2zrQUpgDEbtDS2D/uF
         3Yug==
X-Gm-Message-State: ABy/qLYiJRpKgu8JK1vrHt0UxWBo7pSqnYO3s3YlJkihT52JYN+c2OuS
        4/Fs27U4OmnZe0UmQq8vRw==
X-Google-Smtp-Source: APBJJlHu3NIRVjvAZ/pfhV3+K4CCko9L3P0cR+tv4RaJ/uCVtQQlLvb7trU3TpwNL6wsZqD4Kgd/Mw==
X-Received: by 2002:a6b:5b04:0:b0:783:4f8d:4484 with SMTP id v4-20020a6b5b04000000b007834f8d4484mr5964377ioh.2.1689357130978;
        Fri, 14 Jul 2023 10:52:10 -0700 (PDT)
Received: from robh_at_kernel.org ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id a1-20020a5d9581000000b007836a9ca101sm2823607ioo.22.2023.07.14.10.52.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jul 2023 10:52:10 -0700 (PDT)
Received: (nullmailer pid 4067514 invoked by uid 1000);
        Fri, 14 Jul 2023 17:51:35 -0000
From:   Rob Herring <robh@kernel.org>
To:     Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] soc: imx: Explicitly include correct DT includes
Date:   Fri, 14 Jul 2023 11:51:33 -0600
Message-Id: <20230714175134.4067445-1-robh@kernel.org>
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
 drivers/soc/imx/gpcv2.c           | 2 +-
 drivers/soc/imx/imx8m-blk-ctrl.c  | 3 ++-
 drivers/soc/imx/imx8mp-blk-ctrl.c | 2 +-
 drivers/soc/imx/imx93-blk-ctrl.c  | 2 +-
 drivers/soc/imx/imx93-pd.c        | 2 +-
 5 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/soc/imx/gpcv2.c b/drivers/soc/imx/gpcv2.c
index 4b3300b090a8..fbd3d92f8cd8 100644
--- a/drivers/soc/imx/gpcv2.c
+++ b/drivers/soc/imx/gpcv2.c
@@ -9,7 +9,7 @@
  */
 
 #include <linux/clk.h>
-#include <linux/of_device.h>
+#include <linux/of.h>
 #include <linux/platform_device.h>
 #include <linux/pm_domain.h>
 #include <linux/pm_runtime.h>
diff --git a/drivers/soc/imx/imx8m-blk-ctrl.c b/drivers/soc/imx/imx8m-blk-ctrl.c
index afbca0d48c14..cc5ef6e2f0a8 100644
--- a/drivers/soc/imx/imx8m-blk-ctrl.c
+++ b/drivers/soc/imx/imx8m-blk-ctrl.c
@@ -8,7 +8,8 @@
 #include <linux/device.h>
 #include <linux/interconnect.h>
 #include <linux/module.h>
-#include <linux/of_device.h>
+#include <linux/of.h>
+#include <linux/of_platform.h>
 #include <linux/platform_device.h>
 #include <linux/pm_domain.h>
 #include <linux/pm_runtime.h>
diff --git a/drivers/soc/imx/imx8mp-blk-ctrl.c b/drivers/soc/imx/imx8mp-blk-ctrl.c
index 870aecc0202a..5a9f5ece43d9 100644
--- a/drivers/soc/imx/imx8mp-blk-ctrl.c
+++ b/drivers/soc/imx/imx8mp-blk-ctrl.c
@@ -10,7 +10,7 @@
 #include <linux/device.h>
 #include <linux/interconnect.h>
 #include <linux/module.h>
-#include <linux/of_device.h>
+#include <linux/of.h>
 #include <linux/platform_device.h>
 #include <linux/pm_domain.h>
 #include <linux/pm_runtime.h>
diff --git a/drivers/soc/imx/imx93-blk-ctrl.c b/drivers/soc/imx/imx93-blk-ctrl.c
index 2c600329436c..a734889b67ce 100644
--- a/drivers/soc/imx/imx93-blk-ctrl.c
+++ b/drivers/soc/imx/imx93-blk-ctrl.c
@@ -6,7 +6,7 @@
 #include <linux/clk.h>
 #include <linux/device.h>
 #include <linux/module.h>
-#include <linux/of_device.h>
+#include <linux/of.h>
 #include <linux/platform_device.h>
 #include <linux/pm_domain.h>
 #include <linux/pm_runtime.h>
diff --git a/drivers/soc/imx/imx93-pd.c b/drivers/soc/imx/imx93-pd.c
index 832deeed8fd6..b9e60d136875 100644
--- a/drivers/soc/imx/imx93-pd.c
+++ b/drivers/soc/imx/imx93-pd.c
@@ -5,8 +5,8 @@
 
 #include <linux/clk.h>
 #include <linux/delay.h>
-#include <linux/of_device.h>
 #include <linux/iopoll.h>
+#include <linux/mod_devicetable.h>
 #include <linux/module.h>
 #include <linux/platform_device.h>
 #include <linux/pm_domain.h>
-- 
2.40.1

