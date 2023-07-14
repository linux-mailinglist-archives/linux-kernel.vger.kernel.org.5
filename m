Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6F497540D3
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 19:46:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236301AbjGNRpP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 13:45:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236195AbjGNRpH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 13:45:07 -0400
Received: from mail-io1-f54.google.com (mail-io1-f54.google.com [209.85.166.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1901E271F;
        Fri, 14 Jul 2023 10:44:41 -0700 (PDT)
Received: by mail-io1-f54.google.com with SMTP id ca18e2360f4ac-77acb04309dso90333139f.2;
        Fri, 14 Jul 2023 10:44:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689356681; x=1691948681;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OV9Da8S/o+GcXZDxCrzxUGI5PHKINHHUjNM42LhtDVI=;
        b=eFnPaf1Ap3BWm0ll98t4pDmTA7wF3EPlCf4Cf6mgRWoDSXsCxJMhJjDQQC0Gc1QpqH
         Q/WSR2y85oDoFWgfpxO7kpJ06oV2IC3rdQzO13xHWwJzMOG1hDolzytaaDiMAG61+ajC
         Xhwk1eDsGiaBWvy371Iz6c1VR57gU3M+ww5NEsxUyTucdQJ6cnGBvzLaR5nvuwVp4j2g
         3q8ShSrS10qjORTz7XOWQD88WrmP67+zgA3Kvk70LPw+71C8ltG/UuG0BTG502HYy9mt
         RXw0XjzzVKMHcbRCYL70UWyx5h1OTyLPjVSIRlVBokAWL3WxBzGPOY0PAx5AkgRn5Fo3
         SxCg==
X-Gm-Message-State: ABy/qLYAyF59jgp9u0r/RpzAnwCAF3sv7/ayeuAUXMlh4rdYpzvldXjy
        ptDv/Ks6NQJODFb9KRvUNg==
X-Google-Smtp-Source: APBJJlGlFtyf4Tie/h8dCIM7jryLsyrObgUhLDCFK/NgH9zG9diy+SFgnTmnsvaGmL9uZCjfxqHyPA==
X-Received: by 2002:a92:dc92:0:b0:340:8cb1:aaa8 with SMTP id c18-20020a92dc92000000b003408cb1aaa8mr5022077iln.21.1689356681136;
        Fri, 14 Jul 2023 10:44:41 -0700 (PDT)
Received: from robh_at_kernel.org ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id d13-20020a92d78d000000b00345d3f2bb6asm2861052iln.56.2023.07.14.10.44.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jul 2023 10:44:40 -0700 (PDT)
Received: (nullmailer pid 4054811 invoked by uid 1000);
        Fri, 14 Jul 2023 17:44:37 -0000
From:   Rob Herring <robh@kernel.org>
To:     York Sun <york.sun@nxp.com>, Borislav Petkov <bp@alien8.de>,
        Tony Luck <tony.luck@intel.com>,
        James Morse <james.morse@arm.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Robert Richter <rric@kernel.org>,
        Andre Przywara <andre.przywara@arm.com>,
        Johannes Thumshirn <morbidrsa@gmail.com>,
        Avi Fishman <avifishman70@gmail.com>,
        Tomer Maimon <tmaimon77@gmail.com>,
        Tali Perry <tali.perry1@gmail.com>,
        Patrick Venture <venture@google.com>,
        Nancy Yuen <yuenn@google.com>,
        Benjamin Fair <benjaminfair@google.com>,
        Marvin Lin <kflin@nuvoton.com>,
        Stanley Chu <yschu@nuvoton.com>,
        Michal Simek <michal.simek@amd.com>
Cc:     devicetree@vger.kernel.org, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org, openbmc@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH] EDAC: Explicitly include correct DT includes
Date:   Fri, 14 Jul 2023 11:44:34 -0600
Message-Id: <20230714174434.4054728-1-robh@kernel.org>
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
 drivers/edac/fsl_ddr_edac.c     | 3 +--
 drivers/edac/highbank_l2_edac.c | 3 ++-
 drivers/edac/highbank_mc_edac.c | 3 ++-
 drivers/edac/mpc85xx_edac.c     | 3 +--
 drivers/edac/npcm_edac.c        | 3 ++-
 drivers/edac/synopsys_edac.c    | 1 -
 6 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/edac/fsl_ddr_edac.c b/drivers/edac/fsl_ddr_edac.c
index ac2102b25706..b81757555a8a 100644
--- a/drivers/edac/fsl_ddr_edac.c
+++ b/drivers/edac/fsl_ddr_edac.c
@@ -22,8 +22,7 @@
 #include <linux/smp.h>
 #include <linux/gfp.h>
 
-#include <linux/of_platform.h>
-#include <linux/of_device.h>
+#include <linux/of.h>
 #include <linux/of_address.h>
 #include "edac_module.h"
 #include "fsl_ddr_edac.h"
diff --git a/drivers/edac/highbank_l2_edac.c b/drivers/edac/highbank_l2_edac.c
index c4549cec788b..140d4431bd0d 100644
--- a/drivers/edac/highbank_l2_edac.c
+++ b/drivers/edac/highbank_l2_edac.c
@@ -7,8 +7,9 @@
 #include <linux/ctype.h>
 #include <linux/edac.h>
 #include <linux/interrupt.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
 #include <linux/platform_device.h>
-#include <linux/of_platform.h>
 
 #include "edac_module.h"
 
diff --git a/drivers/edac/highbank_mc_edac.c b/drivers/edac/highbank_mc_edac.c
index 19fba258ae10..a0c04a7f95e9 100644
--- a/drivers/edac/highbank_mc_edac.c
+++ b/drivers/edac/highbank_mc_edac.c
@@ -7,8 +7,9 @@
 #include <linux/ctype.h>
 #include <linux/edac.h>
 #include <linux/interrupt.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
 #include <linux/platform_device.h>
-#include <linux/of_platform.h>
 #include <linux/uaccess.h>
 
 #include "edac_module.h"
diff --git a/drivers/edac/mpc85xx_edac.c b/drivers/edac/mpc85xx_edac.c
index 55320546c174..2b5703e5066e 100644
--- a/drivers/edac/mpc85xx_edac.c
+++ b/drivers/edac/mpc85xx_edac.c
@@ -22,8 +22,7 @@
 #include <linux/gfp.h>
 #include <linux/fsl/edac.h>
 
-#include <linux/of_platform.h>
-#include <linux/of_device.h>
+#include <linux/of.h>
 #include <linux/of_address.h>
 #include <linux/of_irq.h>
 #include "edac_module.h"
diff --git a/drivers/edac/npcm_edac.c b/drivers/edac/npcm_edac.c
index 12b95be3e989..6d15c1550263 100644
--- a/drivers/edac/npcm_edac.c
+++ b/drivers/edac/npcm_edac.c
@@ -3,7 +3,8 @@
 
 #include <linux/debugfs.h>
 #include <linux/iopoll.h>
-#include <linux/of_device.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
 #include <linux/regmap.h>
 #include "edac_module.h"
 
diff --git a/drivers/edac/synopsys_edac.c b/drivers/edac/synopsys_edac.c
index f7d37c282819..c4fc64cbecd0 100644
--- a/drivers/edac/synopsys_edac.c
+++ b/drivers/edac/synopsys_edac.c
@@ -11,7 +11,6 @@
 #include <linux/platform_device.h>
 #include <linux/interrupt.h>
 #include <linux/of.h>
-#include <linux/of_device.h>
 
 #include "edac_module.h"
 
-- 
2.40.1

