Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF49B7C41F3
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 22:57:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234609AbjJJU5Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 16:57:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231998AbjJJU5V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 16:57:21 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E831FD7;
        Tue, 10 Oct 2023 13:57:19 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2B19C433C8;
        Tue, 10 Oct 2023 20:57:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696971439;
        bh=cCteUb8D2I1xDoWK9+STDEO+WMzXSJubNGNWzLPq7Ow=;
        h=From:To:Cc:Subject:Date:From;
        b=pIcC06h1SGM7wsPVSwHIUfPES7HwoNJauoXWa8piTdcR74OcqlDGqxvroongF68qz
         mhsIV192z93osXXVNFMYnv8I5EGnslJK7Hyhihr0MfE9vKhQnVggO9iRrtPHS2B7aJ
         mBBJ46s1wtlvEHLo6Y6NiJZ0Q4CJrybV0MLt32UXLmic1H9PDsB4giVp2TRtYDpoBV
         IMqqFfWJBV6xV10ev2uSJ32zy6GC97m1oMGe2tdpZcw6+WRHG7VnE8uf3GM5akEWA0
         RmmhKu8GzKyoOcr3lgXdocoxIvE9Wo/PiH2o4uLO4+C8vu/JcBqI2KaOpr7mBbt3RR
         DCzHtBInSwmgg==
Received: (nullmailer pid 1585423 invoked by uid 1000);
        Tue, 10 Oct 2023 20:57:17 -0000
From:   Rob Herring <robh@kernel.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] clk: qcom: Replace of_device.h with explicit includes
Date:   Tue, 10 Oct 2023 15:57:10 -0500
Message-ID: <20231010205710.1585232-1-robh@kernel.org>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The DT of_device.h and of_platform.h date back to the separate
of_platform_bus_type before it as merged into the regular platform bus.
As part of that merge prepping Arm DT support 13 years ago, they
"temporarily" include each other and pull in various other headers. In
preparation to fix this, adjust the includes for what is actually needed.

of_device.h isn't needed, but mod_devicetable.h and platform_device.h were
implicitly included by it.

Signed-off-by: Rob Herring <robh@kernel.org>
---
Note these were added in the merge window and missed the last round.
---
 drivers/clk/qcom/camcc-sm8550.c | 3 ++-
 drivers/clk/qcom/gcc-ipq5018.c  | 3 ++-
 drivers/clk/qcom/gcc-sm4450.c   | 3 ++-
 3 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/clk/qcom/camcc-sm8550.c b/drivers/clk/qcom/camcc-sm8550.c
index 2133e768b891..dd51ba4ea757 100644
--- a/drivers/clk/qcom/camcc-sm8550.c
+++ b/drivers/clk/qcom/camcc-sm8550.c
@@ -4,8 +4,9 @@
  */
 
 #include <linux/clk-provider.h>
+#include <linux/mod_devicetable.h>
 #include <linux/module.h>
-#include <linux/of_device.h>
+#include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
 #include <linux/regmap.h>
 
diff --git a/drivers/clk/qcom/gcc-ipq5018.c b/drivers/clk/qcom/gcc-ipq5018.c
index 19dc2b71cacf..70f6ade3ac2a 100644
--- a/drivers/clk/qcom/gcc-ipq5018.c
+++ b/drivers/clk/qcom/gcc-ipq5018.c
@@ -3,8 +3,9 @@
  * Copyright (c) 2023, The Linux Foundation. All rights reserved.
  */
 #include <linux/clk-provider.h>
+#include <linux/mod_devicetable.h>
 #include <linux/module.h>
-#include <linux/of_device.h>
+#include <linux/platform_device.h>
 #include <linux/regmap.h>
 
 #include <dt-bindings/clock/qcom,gcc-ipq5018.h>
diff --git a/drivers/clk/qcom/gcc-sm4450.c b/drivers/clk/qcom/gcc-sm4450.c
index 41c6357d09bc..31abe2775fc8 100644
--- a/drivers/clk/qcom/gcc-sm4450.c
+++ b/drivers/clk/qcom/gcc-sm4450.c
@@ -4,8 +4,9 @@
  */
 
 #include <linux/clk-provider.h>
+#include <linux/mod_devicetable.h>
 #include <linux/module.h>
-#include <linux/of_device.h>
+#include <linux/platform_device.h>
 #include <linux/regmap.h>
 
 #include <dt-bindings/clock/qcom,sm4450-gcc.h>
-- 
2.42.0

