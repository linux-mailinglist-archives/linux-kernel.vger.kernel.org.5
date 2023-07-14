Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1261F754226
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 20:05:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236072AbjGNSCc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 14:02:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236693AbjGNSCP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 14:02:15 -0400
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 758E94213;
        Fri, 14 Jul 2023 11:01:43 -0700 (PDT)
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1b8b4749013so16533885ad.2;
        Fri, 14 Jul 2023 11:01:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689357640; x=1691949640;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=m91Fe28mbDN6J06I/qqMHBHYZy2UCCGYOh2MW5zdC+Q=;
        b=jKGZRPteLem8aPVqXAse0pFA6AbYL3ychgif66hgR7mtc64BnvzIxapELdaqMiVkXO
         nMwFAOOXC8b86jKK9Sdj1u71bPCPO6hQi+HkbkBC2sXSTTL1q3gVl6NTiHrCg5HTCXzI
         jC8hTPKdnjGj4Ai3w7uZakf0ph+ncswl01QJ9Oa2YVg41LebFII9wIPjauwn7s2Ryg05
         6PWQyaOw4iDz4EzO0pKnR0BqweJfHFHhAu/z35uvE1u2qMtQ7/xMYq8w6YIun45Pbty4
         3Lc4jpZFRXoetvFcZNSdjBi40bcv8n7OxBU5tyCVAN0KW0sC5Im2iUSkFNDv+NdDwjZr
         ivAw==
X-Gm-Message-State: ABy/qLY9HHP0G5j7eJuyGgCWgTTzPFY5BwUhjhjgoBgOUtkhXIVMkCrS
        TBPK8qZaQwlfpMNBFIueaDe+bjPeqIym
X-Google-Smtp-Source: APBJJlFxyacMEQ+zYcQJoIRVORvhjrZEoUI6Phmqd6hkSdWntbiciQEOL75GGQ5pnb5KOIWFxqGRbg==
X-Received: by 2002:a05:6602:2114:b0:783:65ba:8614 with SMTP id x20-20020a056602211400b0078365ba8614mr5483685iox.10.1689357116538;
        Fri, 14 Jul 2023 10:51:56 -0700 (PDT)
Received: from robh_at_kernel.org ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id ep9-20020a0566384e0900b0042b326ed1ebsm2758360jab.48.2023.07.14.10.51.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jul 2023 10:51:55 -0700 (PDT)
Received: (nullmailer pid 4067642 invoked by uid 1000);
        Fri, 14 Jul 2023 17:51:38 -0000
From:   Rob Herring <robh@kernel.org>
To:     Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH] soc: mediatek: Explicitly include correct DT includes
Date:   Fri, 14 Jul 2023 11:51:35 -0600
Message-Id: <20230714175136.4067557-1-robh@kernel.org>
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
 drivers/soc/mediatek/mtk-cmdq-helper.c | 1 +
 drivers/soc/mediatek/mtk-devapc.c      | 2 +-
 drivers/soc/mediatek/mtk-mmsys.c       | 2 +-
 drivers/soc/mediatek/mtk-mutex.c       | 3 +--
 drivers/soc/mediatek/mtk-pm-domains.c  | 2 +-
 drivers/soc/mediatek/mtk-pmic-wrap.c   | 3 ++-
 drivers/soc/mediatek/mtk-scpsys.c      | 2 +-
 7 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/soc/mediatek/mtk-cmdq-helper.c b/drivers/soc/mediatek/mtk-cmdq-helper.c
index c1837a468267..b0cd071c4719 100644
--- a/drivers/soc/mediatek/mtk-cmdq-helper.c
+++ b/drivers/soc/mediatek/mtk-cmdq-helper.c
@@ -7,6 +7,7 @@
 #include <linux/dma-mapping.h>
 #include <linux/module.h>
 #include <linux/mailbox_controller.h>
+#include <linux/of.h>
 #include <linux/soc/mediatek/mtk-cmdq.h>
 
 #define CMDQ_WRITE_ENABLE_MASK	BIT(0)
diff --git a/drivers/soc/mediatek/mtk-devapc.c b/drivers/soc/mediatek/mtk-devapc.c
index bad139cb117e..b28feb967540 100644
--- a/drivers/soc/mediatek/mtk-devapc.c
+++ b/drivers/soc/mediatek/mtk-devapc.c
@@ -8,7 +8,7 @@
 #include <linux/iopoll.h>
 #include <linux/module.h>
 #include <linux/platform_device.h>
-#include <linux/of_device.h>
+#include <linux/of.h>
 #include <linux/of_irq.h>
 #include <linux/of_address.h>
 
diff --git a/drivers/soc/mediatek/mtk-mmsys.c b/drivers/soc/mediatek/mtk-mmsys.c
index 9619faa796e8..ffb75711a1da 100644
--- a/drivers/soc/mediatek/mtk-mmsys.c
+++ b/drivers/soc/mediatek/mtk-mmsys.c
@@ -8,7 +8,7 @@
 #include <linux/device.h>
 #include <linux/io.h>
 #include <linux/module.h>
-#include <linux/of_device.h>
+#include <linux/of.h>
 #include <linux/platform_device.h>
 #include <linux/reset-controller.h>
 #include <linux/soc/mediatek/mtk-mmsys.h>
diff --git a/drivers/soc/mediatek/mtk-mutex.c b/drivers/soc/mediatek/mtk-mutex.c
index 4aa0913817ae..9d9f5ae578ac 100644
--- a/drivers/soc/mediatek/mtk-mutex.c
+++ b/drivers/soc/mediatek/mtk-mutex.c
@@ -6,8 +6,7 @@
 #include <linux/clk.h>
 #include <linux/iopoll.h>
 #include <linux/module.h>
-#include <linux/of_device.h>
-#include <linux/of_address.h>
+#include <linux/of.h>
 #include <linux/platform_device.h>
 #include <linux/regmap.h>
 #include <linux/soc/mediatek/mtk-mmsys.h>
diff --git a/drivers/soc/mediatek/mtk-pm-domains.c b/drivers/soc/mediatek/mtk-pm-domains.c
index 354249cc1b12..ee962804b830 100644
--- a/drivers/soc/mediatek/mtk-pm-domains.c
+++ b/drivers/soc/mediatek/mtk-pm-domains.c
@@ -8,8 +8,8 @@
 #include <linux/io.h>
 #include <linux/iopoll.h>
 #include <linux/mfd/syscon.h>
+#include <linux/of.h>
 #include <linux/of_clk.h>
-#include <linux/of_device.h>
 #include <linux/platform_device.h>
 #include <linux/pm_domain.h>
 #include <linux/regmap.h>
diff --git a/drivers/soc/mediatek/mtk-pmic-wrap.c b/drivers/soc/mediatek/mtk-pmic-wrap.c
index 11095b8de71a..efd9cae212dc 100644
--- a/drivers/soc/mediatek/mtk-pmic-wrap.c
+++ b/drivers/soc/mediatek/mtk-pmic-wrap.c
@@ -8,7 +8,8 @@
 #include <linux/io.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
-#include <linux/of_device.h>
+#include <linux/of.h>
+#include <linux/of_platform.h>
 #include <linux/platform_device.h>
 #include <linux/regmap.h>
 #include <linux/reset.h>
diff --git a/drivers/soc/mediatek/mtk-scpsys.c b/drivers/soc/mediatek/mtk-scpsys.c
index 7a668888111c..b374d01fdac7 100644
--- a/drivers/soc/mediatek/mtk-scpsys.c
+++ b/drivers/soc/mediatek/mtk-scpsys.c
@@ -7,7 +7,7 @@
 #include <linux/io.h>
 #include <linux/iopoll.h>
 #include <linux/mfd/syscon.h>
-#include <linux/of_device.h>
+#include <linux/of.h>
 #include <linux/platform_device.h>
 #include <linux/pm_domain.h>
 #include <linux/regulator/consumer.h>
-- 
2.40.1

