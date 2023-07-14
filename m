Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44F1A7541C3
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 19:55:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236798AbjGNRyR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 13:54:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236688AbjGNRxt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 13:53:49 -0400
Received: from mail-il1-f171.google.com (mail-il1-f171.google.com [209.85.166.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66D2A420A;
        Fri, 14 Jul 2023 10:53:22 -0700 (PDT)
Received: by mail-il1-f171.google.com with SMTP id e9e14a558f8ab-3465bd756afso10354755ab.3;
        Fri, 14 Jul 2023 10:53:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689357142; x=1691949142;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lJcWC43cD/9SsXEQvSrRqfi2CqM3UgGHs6NA6sVYd3Y=;
        b=bJL3b0b0gphzcdpv/z/QN5ibVB5Z2uDrbUp+NYtgh6Dj5rCWAZU08pbQMTHk7pRHL6
         dFnCB+M26XpFHu6BAHqkeKDCw0CNlpEkZRlUKWYLAM3+CTFrotJlrzJ0jMD1c59aJjPh
         iGHjAPpNKqCXnTvXtxIvuo3FVyNs06YMmd4ZdHiVsOFmSgLDD/gUGGl+eEB10+7XYVod
         nYa5OZZ2tGlTw2Cm9C6e8g63knZM6Ksrjf2p2pVtP+gaMJbYPH+MIB0UbZwc1qfmoR/t
         MWcP/ov9LrGCR5I4gMRCmFeT2ekBV+6DjxjfFCv9cUGkYi0bRtXftBoSautxS+8NCQbp
         iXoA==
X-Gm-Message-State: ABy/qLanpTStO0KI9KPMNLQ6wpAdRSoCdkC8FvhVC1r4Ni+lxGCaTvvt
        1y7KAKXEdr1Z5g9+MhNnjw==
X-Google-Smtp-Source: APBJJlEDSAHCvIPQn6EAFq14AsVnsARyQ87BXXYqgfVFOKApVjQdRSvfB0lcuzOYGXdy+wmHg3B/nw==
X-Received: by 2002:a92:d48e:0:b0:345:d583:5c64 with SMTP id p14-20020a92d48e000000b00345d5835c64mr5330603ilg.24.1689357142591;
        Fri, 14 Jul 2023 10:52:22 -0700 (PDT)
Received: from robh_at_kernel.org ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id l18-20020a056638221200b0041d73d0a412sm2784361jas.19.2023.07.14.10.52.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jul 2023 10:52:21 -0700 (PDT)
Received: (nullmailer pid 4068109 invoked by uid 1000);
        Fri, 14 Jul 2023 17:51:48 -0000
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] soc: samsung: Explicitly include correct DT includes
Date:   Fri, 14 Jul 2023 11:51:46 -0600
Message-Id: <20230714175147.4068046-1-robh@kernel.org>
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
 drivers/soc/samsung/exynos-chipid.c | 1 -
 drivers/soc/samsung/exynos-pmu.c    | 2 +-
 drivers/soc/samsung/pm_domains.c    | 3 ++-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/soc/samsung/exynos-chipid.c b/drivers/soc/samsung/exynos-chipid.c
index 0fb3631e7346..7ba45c4aff97 100644
--- a/drivers/soc/samsung/exynos-chipid.c
+++ b/drivers/soc/samsung/exynos-chipid.c
@@ -17,7 +17,6 @@
 #include <linux/mfd/syscon.h>
 #include <linux/module.h>
 #include <linux/of.h>
-#include <linux/of_device.h>
 #include <linux/platform_device.h>
 #include <linux/regmap.h>
 #include <linux/slab.h>
diff --git a/drivers/soc/samsung/exynos-pmu.c b/drivers/soc/samsung/exynos-pmu.c
index 5b2664da9853..250537d7cfd6 100644
--- a/drivers/soc/samsung/exynos-pmu.c
+++ b/drivers/soc/samsung/exynos-pmu.c
@@ -7,9 +7,9 @@
 
 #include <linux/of.h>
 #include <linux/of_address.h>
-#include <linux/of_device.h>
 #include <linux/mfd/core.h>
 #include <linux/mfd/syscon.h>
+#include <linux/of_platform.h>
 #include <linux/platform_device.h>
 #include <linux/delay.h>
 
diff --git a/drivers/soc/samsung/pm_domains.c b/drivers/soc/samsung/pm_domains.c
index d07f3c9d6903..9b502e8751d1 100644
--- a/drivers/soc/samsung/pm_domains.c
+++ b/drivers/soc/samsung/pm_domains.c
@@ -11,11 +11,12 @@
 
 #include <linux/io.h>
 #include <linux/err.h>
+#include <linux/platform_device.h>
 #include <linux/slab.h>
 #include <linux/pm_domain.h>
 #include <linux/delay.h>
+#include <linux/of.h>
 #include <linux/of_address.h>
-#include <linux/of_platform.h>
 #include <linux/pm_runtime.h>
 
 struct exynos_pm_domain_config {
-- 
2.40.1

