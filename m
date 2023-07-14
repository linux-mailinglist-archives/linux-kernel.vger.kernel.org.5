Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7DCB754109
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 19:49:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236374AbjGNRs4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 13:48:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236018AbjGNRrp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 13:47:45 -0400
Received: from mail-io1-f47.google.com (mail-io1-f47.google.com [209.85.166.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EF9A271F;
        Fri, 14 Jul 2023 10:47:25 -0700 (PDT)
Received: by mail-io1-f47.google.com with SMTP id ca18e2360f4ac-7836272f36eso89521139f.1;
        Fri, 14 Jul 2023 10:47:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689356806; x=1691948806;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tJHdTuW6K/JMm302E5042Fy6Gfq2JzeP0VeTTGMNa/E=;
        b=Nu146PJoDbzDHx8cJ6oOcNZlGKcmHPmWFj8g3yBWKejANjO50aSc19tRLlRE2+BXKv
         OmKmGRfHaNokVyDNn+AKZ57DYkFa2vh2heLEuqLmpAZh73294YS/jq3+9+MDviu2K9RW
         o7eZcDKqGqI/u1Xprv3QhT4AC0W8YL8U7IBEPYaOs5hzvHNAd4UxCDVjzZl4+FOvlshY
         4YQtBr2+7y8IVjYTq21nPDb6AwQgfkphMRNAG6YZ4RXl7N8TzzOyb87eLJ87Y/CGxli+
         Ikj/uPwurpmT+PuW3uAkr7er2TIVt52FkICIoG+Dr8y1+dJ+cZV2tKO7uesfc3hoVtmP
         1n9w==
X-Gm-Message-State: ABy/qLaYCaQ9IZjwrkHMHzHTebCkLWhUIJsIoTvd0d/DUjx4Y2YiLiJS
        O4MKgszF3pPR1Bkz6KysWQ==
X-Google-Smtp-Source: APBJJlFMTzdChYrg1EY1mjWK7DfeEYXAaYjpG3av2LG7K82WeR9AZZFvgqFl2nPjbs/2wRDPMr3kbQ==
X-Received: by 2002:a6b:f101:0:b0:787:1d0a:ce81 with SMTP id e1-20020a6bf101000000b007871d0ace81mr5975387iog.13.1689356806084;
        Fri, 14 Jul 2023 10:46:46 -0700 (PDT)
Received: from robh_at_kernel.org ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id i10-20020a02b68a000000b0042b3dcb1106sm2801125jam.47.2023.07.14.10.46.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jul 2023 10:46:45 -0700 (PDT)
Received: (nullmailer pid 4058503 invoked by uid 1000);
        Fri, 14 Jul 2023 17:46:43 -0000
From:   Rob Herring <robh@kernel.org>
To:     Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        Rob Clark <robdclark@gmail.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Krishna Reddy <vdumpa@nvidia.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-tegra@vger.kernel.org,
        virtualization@lists.linux-foundation.org
Subject: [PATCH] iommu: Explicitly include correct DT includes
Date:   Fri, 14 Jul 2023 11:46:39 -0600
Message-Id: <20230714174640.4058404-1-robh@kernel.org>
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
 drivers/iommu/arm/arm-smmu/arm-smmu-qcom-debug.c | 2 +-
 drivers/iommu/arm/arm-smmu/arm-smmu.c            | 1 -
 drivers/iommu/arm/arm-smmu/qcom_iommu.c          | 3 +--
 drivers/iommu/ipmmu-vmsa.c                       | 1 -
 drivers/iommu/sprd-iommu.c                       | 1 +
 drivers/iommu/tegra-smmu.c                       | 2 +-
 drivers/iommu/virtio-iommu.c                     | 2 +-
 7 files changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom-debug.c b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom-debug.c
index b5b14108e086..bb89d49adf8d 100644
--- a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom-debug.c
+++ b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom-debug.c
@@ -3,7 +3,7 @@
  * Copyright (c) 2022 Qualcomm Innovation Center, Inc. All rights reserved.
  */
 
-#include <linux/of_device.h>
+#include <linux/device.h>
 #include <linux/firmware/qcom/qcom_scm.h>
 #include <linux/ratelimit.h>
 
diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu.c b/drivers/iommu/arm/arm-smmu/arm-smmu.c
index a86acd76c1df..d6d1a2a55cc0 100644
--- a/drivers/iommu/arm/arm-smmu/arm-smmu.c
+++ b/drivers/iommu/arm/arm-smmu/arm-smmu.c
@@ -29,7 +29,6 @@
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/of_address.h>
-#include <linux/of_device.h>
 #include <linux/pci.h>
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
diff --git a/drivers/iommu/arm/arm-smmu/qcom_iommu.c b/drivers/iommu/arm/arm-smmu/qcom_iommu.c
index a503ed758ec3..cc3f68a3516c 100644
--- a/drivers/iommu/arm/arm-smmu/qcom_iommu.c
+++ b/drivers/iommu/arm/arm-smmu/qcom_iommu.c
@@ -22,8 +22,7 @@
 #include <linux/init.h>
 #include <linux/mutex.h>
 #include <linux/of.h>
-#include <linux/of_address.h>
-#include <linux/of_device.h>
+#include <linux/of_platform.h>
 #include <linux/platform_device.h>
 #include <linux/pm.h>
 #include <linux/pm_runtime.h>
diff --git a/drivers/iommu/ipmmu-vmsa.c b/drivers/iommu/ipmmu-vmsa.c
index 9f64c5c9f5b9..0aeedd3e1494 100644
--- a/drivers/iommu/ipmmu-vmsa.c
+++ b/drivers/iommu/ipmmu-vmsa.c
@@ -17,7 +17,6 @@
 #include <linux/io-pgtable.h>
 #include <linux/iommu.h>
 #include <linux/of.h>
-#include <linux/of_device.h>
 #include <linux/of_platform.h>
 #include <linux/platform_device.h>
 #include <linux/sizes.h>
diff --git a/drivers/iommu/sprd-iommu.c b/drivers/iommu/sprd-iommu.c
index 39e34fdeccda..51144c232474 100644
--- a/drivers/iommu/sprd-iommu.c
+++ b/drivers/iommu/sprd-iommu.c
@@ -14,6 +14,7 @@
 #include <linux/mfd/syscon.h>
 #include <linux/module.h>
 #include <linux/of_platform.h>
+#include <linux/platform_device.h>
 #include <linux/regmap.h>
 #include <linux/slab.h>
 
diff --git a/drivers/iommu/tegra-smmu.c b/drivers/iommu/tegra-smmu.c
index 1cbf063ccf14..e445f80d0226 100644
--- a/drivers/iommu/tegra-smmu.c
+++ b/drivers/iommu/tegra-smmu.c
@@ -9,7 +9,7 @@
 #include <linux/iommu.h>
 #include <linux/kernel.h>
 #include <linux/of.h>
-#include <linux/of_device.h>
+#include <linux/of_platform.h>
 #include <linux/pci.h>
 #include <linux/platform_device.h>
 #include <linux/slab.h>
diff --git a/drivers/iommu/virtio-iommu.c b/drivers/iommu/virtio-iommu.c
index 3551ed057774..17dcd826f5c2 100644
--- a/drivers/iommu/virtio-iommu.c
+++ b/drivers/iommu/virtio-iommu.c
@@ -13,7 +13,7 @@
 #include <linux/interval_tree.h>
 #include <linux/iommu.h>
 #include <linux/module.h>
-#include <linux/of_platform.h>
+#include <linux/of.h>
 #include <linux/pci.h>
 #include <linux/virtio.h>
 #include <linux/virtio_config.h>
-- 
2.40.1

