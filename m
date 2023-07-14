Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78FBE754214
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 20:01:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236574AbjGNR72 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 13:59:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236808AbjGNR7T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 13:59:19 -0400
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F213135B3;
        Fri, 14 Jul 2023 10:58:38 -0700 (PDT)
Received: by mail-io1-xd2e.google.com with SMTP id ca18e2360f4ac-78625caa702so86686539f.1;
        Fri, 14 Jul 2023 10:58:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689357154; x=1691949154;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2PMlpQ3HTjbAalenA/6PsIQNQ/0/DKmxFydQ8HAQJcY=;
        b=kL8v2zfcKCGYajGLlclpXodJrU2wSgEifGdTFo5m0gPbBrz0FWRxzPfrNxGQHNJnXb
         Owb2AMmQg5gTyrFaLco0m8PvpKztDRe5irdwzEe8VYvkGD6LAYPYNHkpOFX/u8U1gY32
         6wkM8TWPbntTZOJypIC4YlABYQAEQWracRGf6g+mMmQ9XQB4OmQ2GBpuJpP7mHfoMmyq
         dPAhcp0k1rrYfgIHJehWBcYsitr6uyZC47tVr+S15wJgOo6LwpUqsYTZ0TiWXYSbKdAE
         x/M2hbSYKNpycArzCtmYbDSvgwgBBtBYpAo5muFRC/45H+OpXM64y2svB1cIONW24xJD
         cs2A==
X-Gm-Message-State: ABy/qLb1vOqHz6fNuCnFvnSzEhfFAFegR0HS3oRrT+0ezJ2SyZtXn6wl
        f3XW7Eo5IjuaWzXGIOPE1A==
X-Google-Smtp-Source: APBJJlEcZ58gdu852hp7ZczyMh/1J/nOOMcSZ9qA+m6N6rWZLO3N0fP5UdtvbOX8MhGwZZyx/0Ez7w==
X-Received: by 2002:a92:d792:0:b0:345:b923:971a with SMTP id d18-20020a92d792000000b00345b923971amr5237014iln.0.1689357154565;
        Fri, 14 Jul 2023 10:52:34 -0700 (PDT)
Received: from robh_at_kernel.org ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id z1-20020a92d6c1000000b0033e23a5c730sm2843555ilp.88.2023.07.14.10.52.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jul 2023 10:52:33 -0700 (PDT)
Received: (nullmailer pid 4068641 invoked by uid 1000);
        Fri, 14 Jul 2023 17:52:01 -0000
From:   Rob Herring <robh@kernel.org>
To:     Nishanth Menon <nm@ti.com>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Tero Kristo <kristo@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH] soc: ti: Explicitly include correct DT includes
Date:   Fri, 14 Jul 2023 11:51:56 -0600
Message-Id: <20230714175156.4068520-1-robh@kernel.org>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
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
 drivers/soc/ti/k3-ringacc.c      | 1 -
 drivers/soc/ti/omap_prm.c        | 1 -
 drivers/soc/ti/pruss.c           | 4 +++-
 drivers/soc/ti/ti_sci_inta_msi.c | 3 ++-
 4 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/soc/ti/k3-ringacc.c b/drivers/soc/ti/k3-ringacc.c
index 8f131368a758..d6efa1f7a95e 100644
--- a/drivers/soc/ti/k3-ringacc.c
+++ b/drivers/soc/ti/k3-ringacc.c
@@ -9,7 +9,6 @@
 #include <linux/io.h>
 #include <linux/module.h>
 #include <linux/of.h>
-#include <linux/of_device.h>
 #include <linux/platform_device.h>
 #include <linux/sys_soc.h>
 #include <linux/dma/ti-cppi5.h>
diff --git a/drivers/soc/ti/omap_prm.c b/drivers/soc/ti/omap_prm.c
index ecd9a8bdd7c0..babc157c0109 100644
--- a/drivers/soc/ti/omap_prm.c
+++ b/drivers/soc/ti/omap_prm.c
@@ -13,7 +13,6 @@
 #include <linux/iopoll.h>
 #include <linux/module.h>
 #include <linux/of.h>
-#include <linux/of_device.h>
 #include <linux/platform_device.h>
 #include <linux/pm_clock.h>
 #include <linux/pm_domain.h>
diff --git a/drivers/soc/ti/pruss.c b/drivers/soc/ti/pruss.c
index 7fdefee1ed87..f49f8492dde5 100644
--- a/drivers/soc/ti/pruss.c
+++ b/drivers/soc/ti/pruss.c
@@ -14,8 +14,10 @@
 #include <linux/io.h>
 #include <linux/mfd/syscon.h>
 #include <linux/module.h>
+#include <linux/of.h>
 #include <linux/of_address.h>
-#include <linux/of_device.h>
+#include <linux/of_platform.h>
+#include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
 #include <linux/pruss_driver.h>
 #include <linux/regmap.h>
diff --git a/drivers/soc/ti/ti_sci_inta_msi.c b/drivers/soc/ti/ti_sci_inta_msi.c
index b9251e1d9a5c..c36364522157 100644
--- a/drivers/soc/ti/ti_sci_inta_msi.c
+++ b/drivers/soc/ti/ti_sci_inta_msi.c
@@ -9,9 +9,10 @@
 #include <linux/irq.h>
 #include <linux/irqdomain.h>
 #include <linux/msi.h>
+#include <linux/of.h>
 #include <linux/of_address.h>
-#include <linux/of_device.h>
 #include <linux/of_irq.h>
+#include <linux/platform_device.h>
 #include <linux/soc/ti/ti_sci_inta_msi.h>
 #include <linux/soc/ti/ti_sci_protocol.h>
 
-- 
2.40.1

