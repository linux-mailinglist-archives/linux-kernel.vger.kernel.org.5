Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 174037541A1
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 19:55:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236621AbjGNRxO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 13:53:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236616AbjGNRw4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 13:52:56 -0400
Received: from mail-il1-f177.google.com (mail-il1-f177.google.com [209.85.166.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0D4C1BEB;
        Fri, 14 Jul 2023 10:52:25 -0700 (PDT)
Received: by mail-il1-f177.google.com with SMTP id e9e14a558f8ab-3459baa237bso10154565ab.3;
        Fri, 14 Jul 2023 10:52:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689357084; x=1691949084;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tcj+Lu95WaGqdnXjawPzrjgbPdO2x3dd2CTCL5XV5kg=;
        b=O4UINdKJa253+8ufOmZWod/iL1nOBr6Pu6wq+u9HLD2Y+UURFKwr0aj6Nf1aaEK6hj
         PiCt2KOPZpDsARyDrO/n14+NQjBmjEBqy2HZuWd897tXDzENcbRethSXp85XzAHBUgOm
         74NRfYrJj+48/8V2C+5gpjMHUO4RGOgaxpMzrSt+JGRfsJlTGrSb2wNM4YRA8cH0x0MP
         uPi8p3s/NGQkJo+TMENtOIOYNfHSVGLQYLc/Q5d4QHZIUFQNLGGctYCnYuSy/jg3GhNd
         3e8rRVNv/Gy7ayTCxLc2lzAfS4BtfFjlVfkVIShxzM8/XT5So/IAp+2MTuPmawCVtE5R
         racw==
X-Gm-Message-State: ABy/qLbfYFaKAVZMA8rKW7309qvB1HKoPp5V2xmpKKTBoQrmMdFbMcTG
        iGfYZOk8hYcc8dBoVHW4dSZ2x9nyUroN
X-Google-Smtp-Source: APBJJlFpv7R3DclrHg1OXYuEl/PqL2pjxrt8slL0QvhD4Vhw9TW52BD+nTiDb0dGW+2l5tBDMhjUdQ==
X-Received: by 2002:a92:de46:0:b0:346:5e1c:f01e with SMTP id e6-20020a92de46000000b003465e1cf01emr5194777ilr.5.1689357084378;
        Fri, 14 Jul 2023 10:51:24 -0700 (PDT)
Received: from robh_at_kernel.org ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id s9-20020a02c509000000b0042b4b55f46fsm2630872jam.117.2023.07.14.10.51.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jul 2023 10:51:23 -0700 (PDT)
Received: (nullmailer pid 4066092 invoked by uid 1000);
        Fri, 14 Jul 2023 17:50:51 -0000
From:   Rob Herring <robh@kernel.org>
To:     "David S. Miller" <davem@davemloft.net>
Cc:     devicetree@vger.kernel.org, sparclinux@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] sbus: Explicitly include correct DT includes
Date:   Fri, 14 Jul 2023 11:50:48 -0600
Message-Id: <20230714175048.4066006-1-robh@kernel.org>
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
 drivers/sbus/char/bbc_envctrl.c | 2 +-
 drivers/sbus/char/bbc_i2c.c     | 3 ++-
 drivers/sbus/char/bbc_i2c.h     | 1 -
 drivers/sbus/char/display7seg.c | 2 +-
 drivers/sbus/char/envctrl.c     | 2 +-
 drivers/sbus/char/flash.c       | 2 +-
 drivers/sbus/char/uctrl.c       | 2 +-
 7 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/sbus/char/bbc_envctrl.c b/drivers/sbus/char/bbc_envctrl.c
index 4f2dd21e44a0..23af4edd295b 100644
--- a/drivers/sbus/char/bbc_envctrl.c
+++ b/drivers/sbus/char/bbc_envctrl.c
@@ -9,8 +9,8 @@
 #include <linux/kmod.h>
 #include <linux/reboot.h>
 #include <linux/of.h>
+#include <linux/platform_device.h>
 #include <linux/slab.h>
-#include <linux/of_device.h>
 #include <asm/oplib.h>
 
 #include "bbc_i2c.h"
diff --git a/drivers/sbus/char/bbc_i2c.c b/drivers/sbus/char/bbc_i2c.c
index 537e55cd038d..1c76e27d527a 100644
--- a/drivers/sbus/char/bbc_i2c.c
+++ b/drivers/sbus/char/bbc_i2c.c
@@ -14,7 +14,8 @@
 #include <linux/delay.h>
 #include <linux/interrupt.h>
 #include <linux/of.h>
-#include <linux/of_device.h>
+#include <linux/of_platform.h>
+#include <linux/platform_device.h>
 #include <asm/bbc.h>
 #include <asm/io.h>
 
diff --git a/drivers/sbus/char/bbc_i2c.h b/drivers/sbus/char/bbc_i2c.h
index c2d066d3fa41..7ffe908c62dc 100644
--- a/drivers/sbus/char/bbc_i2c.h
+++ b/drivers/sbus/char/bbc_i2c.h
@@ -3,7 +3,6 @@
 #define _BBC_I2C_H
 
 #include <linux/of.h>
-#include <linux/of_device.h>
 #include <linux/list.h>
 
 struct bbc_i2c_client {
diff --git a/drivers/sbus/char/display7seg.c b/drivers/sbus/char/display7seg.c
index 5368b6ba2884..18e6f84e754f 100644
--- a/drivers/sbus/char/display7seg.c
+++ b/drivers/sbus/char/display7seg.c
@@ -16,7 +16,7 @@
 #include <linux/slab.h>
 #include <linux/mutex.h>
 #include <linux/of.h>
-#include <linux/of_device.h>
+#include <linux/platform_device.h>
 #include <linux/atomic.h>
 #include <linux/uaccess.h>		/* put_/get_user			*/
 #include <asm/io.h>
diff --git a/drivers/sbus/char/envctrl.c b/drivers/sbus/char/envctrl.c
index ea914a7eaa7f..3dd7274cb0a3 100644
--- a/drivers/sbus/char/envctrl.c
+++ b/drivers/sbus/char/envctrl.c
@@ -28,7 +28,7 @@
 #include <linux/reboot.h>
 #include <linux/slab.h>
 #include <linux/of.h>
-#include <linux/of_device.h>
+#include <linux/platform_device.h>
 
 #include <linux/uaccess.h>
 #include <asm/envctrl.h>
diff --git a/drivers/sbus/char/flash.c b/drivers/sbus/char/flash.c
index 3adfef210d8e..ea2d903ba673 100644
--- a/drivers/sbus/char/flash.c
+++ b/drivers/sbus/char/flash.c
@@ -14,7 +14,7 @@
 #include <linux/spinlock.h>
 #include <linux/mm.h>
 #include <linux/of.h>
-#include <linux/of_device.h>
+#include <linux/platform_device.h>
 
 #include <linux/uaccess.h>
 #include <asm/io.h>
diff --git a/drivers/sbus/char/uctrl.c b/drivers/sbus/char/uctrl.c
index 05de0ce79cb9..0660425e3a5a 100644
--- a/drivers/sbus/char/uctrl.c
+++ b/drivers/sbus/char/uctrl.c
@@ -15,7 +15,7 @@
 #include <linux/miscdevice.h>
 #include <linux/mm.h>
 #include <linux/of.h>
-#include <linux/of_device.h>
+#include <linux/platform_device.h>
 
 #include <asm/openprom.h>
 #include <asm/oplib.h>
-- 
2.40.1

