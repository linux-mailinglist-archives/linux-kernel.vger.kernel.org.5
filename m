Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE30175422C
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 20:05:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236441AbjGNSE3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 14:04:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236406AbjGNSEZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 14:04:25 -0400
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 052EB3ABA;
        Fri, 14 Jul 2023 11:04:00 -0700 (PDT)
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-668730696a4so1507297b3a.1;
        Fri, 14 Jul 2023 11:03:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689357740; x=1691949740;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=v+dvAcOgxDmgmtJaKkp391KUSnHq6CxLLiwJgC4XldE=;
        b=EMwEHR6dEuaA6Ip0IBg4ktqvU6EaqzxOaqAnIAoAyTvO2LCLlLwYeFhJ65j860BVim
         RlYG905ec7R8145pHfc/hAcRSnq7R6RiVayYLAsI+PGWqqXREw72XNe7zCh2ZXbr1p2n
         pa3TGnox3rQahSRciTKy8WNi6j+kYQmbTNEv+tcxZW1QXbqiVbCxrceB4o4srd70xpA2
         OAD2m49ysFKHrZub+rdxE2xQxM6c16krcQHFA1VBN+1yPEu/FaF0c+I8Gza8h+T0LBeu
         +ERFb0K5EVQ7Oy1YAQVExajGFEF8KJbEjzls2ecD+BqqPNBsrsXXVvTWPmd0yYKl1/y9
         RSCg==
X-Gm-Message-State: ABy/qLYjRKeeoNHs+WUpexkgTGQ+z2tGWUdq4vF4Zs4oht6wOUZM5nnT
        TQhiVu2c7vCVJI1j/SE8OQu+E2yk4s4P
X-Google-Smtp-Source: APBJJlHohBxe7Qp0+ZNeCvGssF6Gz6tQJIdtFT2lCWyZlAxy09JjZeeEjqhLOZQKLkUtF1Hiy/Gi/A==
X-Received: by 2002:a5d:9810:0:b0:783:72d4:8c38 with SMTP id a16-20020a5d9810000000b0078372d48c38mr5516566iol.13.1689357128804;
        Fri, 14 Jul 2023 10:52:08 -0700 (PDT)
Received: from robh_at_kernel.org ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id cg5-20020a056602254500b0078335414ddesm2866650iob.26.2023.07.14.10.52.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jul 2023 10:52:08 -0700 (PDT)
Received: (nullmailer pid 4067402 invoked by uid 1000);
        Fri, 14 Jul 2023 17:51:33 -0000
From:   Rob Herring <robh@kernel.org>
To:     Li Yang <leoyang.li@nxp.com>, Qiang Zhao <qiang.zhao@nxp.com>
Cc:     devicetree@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] soc: fsl: Explicitly include correct DT includes
Date:   Fri, 14 Jul 2023 11:51:31 -0600
Message-Id: <20230714175131.4067339-1-robh@kernel.org>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
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
 drivers/soc/fsl/dpaa2-console.c | 3 ++-
 drivers/soc/fsl/qe/qe_common.c  | 1 -
 drivers/soc/fsl/qe/qe_tdm.c     | 4 +---
 3 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/soc/fsl/dpaa2-console.c b/drivers/soc/fsl/dpaa2-console.c
index 53917410f2bd..1dca693b6b38 100644
--- a/drivers/soc/fsl/dpaa2-console.c
+++ b/drivers/soc/fsl/dpaa2-console.c
@@ -9,9 +9,10 @@
 #define pr_fmt(fmt) "dpaa2-console: " fmt
 
 #include <linux/module.h>
-#include <linux/of_device.h>
+#include <linux/of.h>
 #include <linux/of_address.h>
 #include <linux/miscdevice.h>
+#include <linux/platform_device.h>
 #include <linux/uaccess.h>
 #include <linux/slab.h>
 #include <linux/fs.h>
diff --git a/drivers/soc/fsl/qe/qe_common.c b/drivers/soc/fsl/qe/qe_common.c
index a0cb8e746879..9729ce86db59 100644
--- a/drivers/soc/fsl/qe/qe_common.c
+++ b/drivers/soc/fsl/qe/qe_common.c
@@ -16,7 +16,6 @@
 #include <linux/genalloc.h>
 #include <linux/init.h>
 #include <linux/list.h>
-#include <linux/of_device.h>
 #include <linux/spinlock.h>
 #include <linux/export.h>
 #include <linux/of.h>
diff --git a/drivers/soc/fsl/qe/qe_tdm.c b/drivers/soc/fsl/qe/qe_tdm.c
index 7d7d78d3ee50..a3b691875c8e 100644
--- a/drivers/soc/fsl/qe/qe_tdm.c
+++ b/drivers/soc/fsl/qe/qe_tdm.c
@@ -9,9 +9,7 @@
  */
 #include <linux/io.h>
 #include <linux/kernel.h>
-#include <linux/of_address.h>
-#include <linux/of_irq.h>
-#include <linux/of_platform.h>
+#include <linux/of.h>
 #include <soc/fsl/qe/qe_tdm.h>
 
 static int set_tdm_framer(const char *tdm_framer_type)
-- 
2.40.1

