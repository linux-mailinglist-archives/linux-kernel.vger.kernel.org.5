Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69E7C7541D3
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 19:55:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236737AbjGNRx4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 13:53:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236730AbjGNRxl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 13:53:41 -0400
Received: from mail-io1-f42.google.com (mail-io1-f42.google.com [209.85.166.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A6B03C18;
        Fri, 14 Jul 2023 10:53:04 -0700 (PDT)
Received: by mail-io1-f42.google.com with SMTP id ca18e2360f4ac-78362f574c9so85313739f.3;
        Fri, 14 Jul 2023 10:53:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689357114; x=1691949114;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oUCqimK49P5lCTFGeVnbSOLxdP8E41cIVWFQaRpK1M0=;
        b=WvHZxPB6Toq8YBWo2lYxH5nOQNBRQ9OM70rQDXgf7hOTwQBNDjhKyFli+e5ccljpjv
         wn42tEkErTUf6keuVkL4HAfQGBgiZzClwN4FczLpDZsr/gIHfsH9BdrbFQ7yW5Fylt5f
         ykjzLVTpAA/9AUtbGDXdcqGjCy9Bkqu4SOu9BUNnOsB3izBnjbjkUC89v0KzbVVT4KM0
         bMyiv3jZZYAGohEjRZiAGLHjjM3In9dlSYytDgXYNzG/1rn3Se/zUC6fLANeOMoQ7t5z
         4Z2DBIo+afmEDsXwMJ+yRMakW1DCJl2QQzTGs1xfPlZ9PXVWsjgoLHlwR0UpesWzbctz
         B+EQ==
X-Gm-Message-State: ABy/qLY6gVCDiC1NrE8oGTL5GqWzewWshglPPeV3pSBMEmERTuSaM4wd
        R/QkfuQWLPIe1LgePrWkdQ==
X-Google-Smtp-Source: APBJJlFzoEK9PmbtG2MQODYrV/Oe3Doi0vguK88EKVP/4XKRmVMrTImpsbwYn/ziQ4UgVO7VYuWb2A==
X-Received: by 2002:a92:c842:0:b0:346:2b9f:1fb with SMTP id b2-20020a92c842000000b003462b9f01fbmr5504145ilq.22.1689357114500;
        Fri, 14 Jul 2023 10:51:54 -0700 (PDT)
Received: from robh_at_kernel.org ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id m19-20020a056638225300b0042b6ae47f0esm2756207jas.108.2023.07.14.10.51.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jul 2023 10:51:53 -0700 (PDT)
Received: (nullmailer pid 4067875 invoked by uid 1000);
        Fri, 14 Jul 2023 17:51:43 -0000
From:   Rob Herring <robh@kernel.org>
To:     Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] soc: qcom: Explicitly include correct DT includes
Date:   Fri, 14 Jul 2023 11:51:41 -0600
Message-Id: <20230714175142.4067795-1-robh@kernel.org>
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
 drivers/soc/qcom/cpr.c                | 1 -
 drivers/soc/qcom/icc-bwmon.c          | 2 +-
 drivers/soc/qcom/ice.c                | 2 ++
 drivers/soc/qcom/llcc-qcom.c          | 1 -
 drivers/soc/qcom/ocmem.c              | 3 ++-
 drivers/soc/qcom/pmic_glink.c         | 2 +-
 drivers/soc/qcom/pmic_glink_altmode.c | 1 +
 drivers/soc/qcom/rpmhpd.c             | 1 -
 drivers/soc/qcom/rpmpd.c              | 1 -
 drivers/soc/qcom/spm.c                | 2 --
 drivers/soc/qcom/wcnss_ctrl.c         | 1 +
 11 files changed, 8 insertions(+), 9 deletions(-)

diff --git a/drivers/soc/qcom/cpr.c b/drivers/soc/qcom/cpr.c
index 144ea68e0920..94a3f0977212 100644
--- a/drivers/soc/qcom/cpr.c
+++ b/drivers/soc/qcom/cpr.c
@@ -15,7 +15,6 @@
 #include <linux/bitops.h>
 #include <linux/slab.h>
 #include <linux/of.h>
-#include <linux/of_device.h>
 #include <linux/platform_device.h>
 #include <linux/pm_domain.h>
 #include <linux/pm_opp.h>
diff --git a/drivers/soc/qcom/icc-bwmon.c b/drivers/soc/qcom/icc-bwmon.c
index 40068a285913..1fd77cdb40d6 100644
--- a/drivers/soc/qcom/icc-bwmon.c
+++ b/drivers/soc/qcom/icc-bwmon.c
@@ -12,7 +12,7 @@
 #include <linux/io.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
-#include <linux/of_device.h>
+#include <linux/of.h>
 #include <linux/platform_device.h>
 #include <linux/pm_opp.h>
 #include <linux/regmap.h>
diff --git a/drivers/soc/qcom/ice.c b/drivers/soc/qcom/ice.c
index a6123ea96272..fbab7fe5c652 100644
--- a/drivers/soc/qcom/ice.c
+++ b/drivers/soc/qcom/ice.c
@@ -11,7 +11,9 @@
 #include <linux/clk.h>
 #include <linux/delay.h>
 #include <linux/iopoll.h>
+#include <linux/of.h>
 #include <linux/of_platform.h>
+#include <linux/platform_device.h>
 
 #include <linux/firmware/qcom/qcom_scm.h>
 
diff --git a/drivers/soc/qcom/llcc-qcom.c b/drivers/soc/qcom/llcc-qcom.c
index 67c19ed2219a..e32a4161a8d0 100644
--- a/drivers/soc/qcom/llcc-qcom.c
+++ b/drivers/soc/qcom/llcc-qcom.c
@@ -13,7 +13,6 @@
 #include <linux/module.h>
 #include <linux/mutex.h>
 #include <linux/of.h>
-#include <linux/of_device.h>
 #include <linux/regmap.h>
 #include <linux/sizes.h>
 #include <linux/slab.h>
diff --git a/drivers/soc/qcom/ocmem.c b/drivers/soc/qcom/ocmem.c
index aaddc3cc53b7..5031ce9476ab 100644
--- a/drivers/soc/qcom/ocmem.c
+++ b/drivers/soc/qcom/ocmem.c
@@ -14,7 +14,8 @@
 #include <linux/io.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
-#include <linux/of_device.h>
+#include <linux/of.h>
+#include <linux/of_platform.h>
 #include <linux/platform_device.h>
 #include <linux/firmware/qcom/qcom_scm.h>
 #include <linux/sizes.h>
diff --git a/drivers/soc/qcom/pmic_glink.c b/drivers/soc/qcom/pmic_glink.c
index c87056769ebd..264e63493bfe 100644
--- a/drivers/soc/qcom/pmic_glink.c
+++ b/drivers/soc/qcom/pmic_glink.c
@@ -4,8 +4,8 @@
  * Copyright (c) 2022, Linaro Ltd
  */
 #include <linux/auxiliary_bus.h>
-#include <linux/of_device.h>
 #include <linux/module.h>
+#include <linux/of.h>
 #include <linux/platform_device.h>
 #include <linux/rpmsg.h>
 #include <linux/slab.h>
diff --git a/drivers/soc/qcom/pmic_glink_altmode.c b/drivers/soc/qcom/pmic_glink_altmode.c
index df48fbea4b68..1dedacc52aea 100644
--- a/drivers/soc/qcom/pmic_glink_altmode.c
+++ b/drivers/soc/qcom/pmic_glink_altmode.c
@@ -6,6 +6,7 @@
 #include <linux/auxiliary_bus.h>
 #include <linux/bitfield.h>
 #include <linux/module.h>
+#include <linux/of.h>
 #include <linux/of_device.h>
 #include <linux/mutex.h>
 #include <linux/property.h>
diff --git a/drivers/soc/qcom/rpmhpd.c b/drivers/soc/qcom/rpmhpd.c
index 63c35a32065b..2cae1d0aef48 100644
--- a/drivers/soc/qcom/rpmhpd.c
+++ b/drivers/soc/qcom/rpmhpd.c
@@ -9,7 +9,6 @@
 #include <linux/pm_domain.h>
 #include <linux/slab.h>
 #include <linux/of.h>
-#include <linux/of_device.h>
 #include <linux/platform_device.h>
 #include <linux/pm_opp.h>
 #include <soc/qcom/cmd-db.h>
diff --git a/drivers/soc/qcom/rpmpd.c b/drivers/soc/qcom/rpmpd.c
index 99b017fd76b7..bccaff942130 100644
--- a/drivers/soc/qcom/rpmpd.c
+++ b/drivers/soc/qcom/rpmpd.c
@@ -8,7 +8,6 @@
 #include <linux/mutex.h>
 #include <linux/pm_domain.h>
 #include <linux/of.h>
-#include <linux/of_device.h>
 #include <linux/platform_device.h>
 #include <linux/pm_opp.h>
 #include <linux/soc/qcom/smd-rpm.h>
diff --git a/drivers/soc/qcom/spm.c b/drivers/soc/qcom/spm.c
index a6cbeb40831b..77b90da04894 100644
--- a/drivers/soc/qcom/spm.c
+++ b/drivers/soc/qcom/spm.c
@@ -12,8 +12,6 @@
 #include <linux/module.h>
 #include <linux/slab.h>
 #include <linux/of.h>
-#include <linux/of_address.h>
-#include <linux/of_device.h>
 #include <linux/err.h>
 #include <linux/platform_device.h>
 #include <soc/qcom/spm.h>
diff --git a/drivers/soc/qcom/wcnss_ctrl.c b/drivers/soc/qcom/wcnss_ctrl.c
index 2a06d631e415..ad9942412c58 100644
--- a/drivers/soc/qcom/wcnss_ctrl.c
+++ b/drivers/soc/qcom/wcnss_ctrl.c
@@ -7,6 +7,7 @@
 #include <linux/module.h>
 #include <linux/slab.h>
 #include <linux/io.h>
+#include <linux/of.h>
 #include <linux/of_platform.h>
 #include <linux/platform_device.h>
 #include <linux/rpmsg.h>
-- 
2.40.1

