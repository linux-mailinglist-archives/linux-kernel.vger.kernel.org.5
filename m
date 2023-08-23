Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E205E785350
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 10:59:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235310AbjHWI7b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 04:59:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234909AbjHWIzk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 04:55:40 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24BB81FF5
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 01:52:04 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id 2adb3069b0e04-5008d16cc36so2559192e87.2
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 01:52:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692780723; x=1693385523;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S71Z3v1GQlAhT0GgnhlVdV4En9/oMRjgvUgf9fiW+Sw=;
        b=ib27ZO4E07FOfYBGN14Puwk9lz2/GWy4Wvey+Tlrr7cVpa3c84dBMsQaSDoRPPhvVm
         mIQ9rw9dk/YIGQif9ketvd7SnBTYEEN+aOapjlfjfW2QHjD1+MSlhvypLHHoRpEqnLe5
         A7etlYUsIYLfNXR0VkQgb0x0DlSlvk8bVnPGIJsXeG3oFkoQZzzF35Y3g/FQMmGT9R2f
         U3uL5D9hQcblL0w8l1uHAhZW7wMLGKyc8L+61xzNulm2KMS/iJcig9Q7JG9PqJZrjgog
         82eUzCO4H6xn36SCYguYgyf251UvMgE005JIaeoFHVbCce7MDlXIMtB+i0LwT3mwpdY7
         qZsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692780723; x=1693385523;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S71Z3v1GQlAhT0GgnhlVdV4En9/oMRjgvUgf9fiW+Sw=;
        b=lAwIG7hCE5aV/fZDpXa4lWIeZd/VPnewV68k2NpCXByv3pnyNbeKn8S3aDD7iJjZw0
         N9YqbOftOlALV80mO5MTB9YeFGSQ50CmWlPsAwLtg/0M+aW7Yan1pQO8WcG57zHT10a+
         aF3zrdo+FvFZDV7UBg1IN6gnjSOI0bwgtY2h1zEnCJIpE029aH1IYLC5i4sUdW8l9n50
         1UdGk4CQhm00Y4kHDrWjqLqoU6JyOQvU7QRU6dWnGl/2lB+RG4ssE9IO4nkcaR8+AZ2U
         g2Ucp/Wef1NN8P+K9VcVXOcXaSkuLh6foCcSYPXbbwo3HUrU+yJGV6kVrsLxh6Iy3M4n
         RJaw==
X-Gm-Message-State: AOJu0YzrBtpQLlFQamh8U0o232yH07qUvA9PvZQ+Tu/RmK7CBfw/BEdT
        wM4APMRzRcqCbKlddM8sXdFGEA==
X-Google-Smtp-Source: AGHT+IG3y2We8LvW8xzNm5Xdrybkzoznuv7gHdEdg9zgd8UZXnFHJjxnBaAgk/U/actn9j4zztQjyA==
X-Received: by 2002:a05:6512:318a:b0:4fe:1d88:2c61 with SMTP id i10-20020a056512318a00b004fe1d882c61mr10615468lfe.32.1692780722664;
        Wed, 23 Aug 2023 01:52:02 -0700 (PDT)
Received: from krzk-bin.. ([77.252.47.198])
        by smtp.gmail.com with ESMTPSA id s19-20020aa7c553000000b0051bed21a635sm9090986edr.74.2023.08.23.01.52.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Aug 2023 01:52:02 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        arm@kernel.org, soc@kernel.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Liviu Dudau <liviu.dudau@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-renesas-soc@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 2/2] arm64: dts: use capital "OR" for multiple licenses in SPDX
Date:   Wed, 23 Aug 2023 10:51:46 +0200
Message-Id: <20230823085146.113562-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230823085146.113562-1-krzysztof.kozlowski@linaro.org>
References: <20230823085146.113562-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Documentation/process/license-rules.rst and checkpatch expect the SPDX
identifier syntax for multiple licenses to use capital "OR".  Correct it
to keep consistent format and avoid copy-paste issues.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Rebased on next-20230822, so might not apply cleanly.  What does not
apply, can be skipped and I will fix it after next RC.
---
 arch/arm64/boot/dts/allwinner/sun50i-a100-allwinner-perf1.dts  | 2 +-
 arch/arm64/boot/dts/allwinner/sun50i-a100.dtsi                 | 2 +-
 arch/arm64/boot/dts/allwinner/sun50i-h6-pine-h64-model-b.dts   | 2 +-
 arch/arm64/boot/dts/allwinner/sun50i-h616-orangepi-zero.dtsi   | 2 +-
 arch/arm64/boot/dts/allwinner/sun50i-h616-orangepi-zero2.dts   | 2 +-
 arch/arm64/boot/dts/allwinner/sun50i-h616-x96-mate.dts         | 2 +-
 arch/arm64/boot/dts/allwinner/sun50i-h618-orangepi-zero3.dts   | 2 +-
 arch/arm64/boot/dts/arm/corstone1000-fvp.dts                   | 2 +-
 arch/arm64/boot/dts/arm/corstone1000-mps3.dts                  | 2 +-
 arch/arm64/boot/dts/arm/corstone1000.dtsi                      | 2 +-
 arch/arm64/boot/dts/broadcom/stingray/bcm958802a802x.dts       | 2 +-
 arch/arm64/boot/dts/broadcom/stingray/stingray-board-base.dtsi | 2 +-
 arch/arm64/boot/dts/broadcom/stingray/stingray-pcie.dtsi       | 2 +-
 arch/arm64/boot/dts/broadcom/stingray/stingray-usb.dtsi        | 2 +-
 arch/arm64/boot/dts/freescale/imx8mm-emcon-avari.dts           | 2 +-
 arch/arm64/boot/dts/freescale/imx8mm-emcon-avari.dtsi          | 2 +-
 arch/arm64/boot/dts/freescale/imx8mm-emcon.dtsi                | 2 +-
 arch/arm64/boot/dts/renesas/r8a77980a.dtsi                     | 2 +-
 arch/arm64/boot/dts/renesas/r8a779f0-spider-cpu.dtsi           | 2 +-
 arch/arm64/boot/dts/renesas/r8a779f0-spider.dts                | 2 +-
 arch/arm64/boot/dts/renesas/r8a779f0.dtsi                      | 2 +-
 arch/arm64/boot/dts/renesas/r8a779m0.dtsi                      | 2 +-
 arch/arm64/boot/dts/renesas/r8a779m1-salvator-xs.dts           | 2 +-
 arch/arm64/boot/dts/renesas/r8a779m1-ulcb-kf.dts               | 2 +-
 arch/arm64/boot/dts/renesas/r8a779m1-ulcb.dts                  | 2 +-
 arch/arm64/boot/dts/renesas/r8a779m1.dtsi                      | 2 +-
 arch/arm64/boot/dts/renesas/r8a779m2.dtsi                      | 2 +-
 arch/arm64/boot/dts/renesas/r8a779m3-salvator-xs.dts           | 2 +-
 arch/arm64/boot/dts/renesas/r8a779m3-ulcb-kf.dts               | 2 +-
 arch/arm64/boot/dts/renesas/r8a779m3-ulcb.dts                  | 2 +-
 arch/arm64/boot/dts/renesas/r8a779m3.dtsi                      | 2 +-
 arch/arm64/boot/dts/renesas/r8a779m4.dtsi                      | 2 +-
 arch/arm64/boot/dts/renesas/r8a779m5-salvator-xs.dts           | 2 +-
 arch/arm64/boot/dts/renesas/r8a779m5.dtsi                      | 2 +-
 arch/arm64/boot/dts/renesas/r8a779m6.dtsi                      | 2 +-
 arch/arm64/boot/dts/renesas/r8a779m7.dtsi                      | 2 +-
 arch/arm64/boot/dts/renesas/r8a779m8.dtsi                      | 2 +-
 arch/arm64/boot/dts/renesas/r8a779mb.dtsi                      | 2 +-
 38 files changed, 38 insertions(+), 38 deletions(-)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a100-allwinner-perf1.dts b/arch/arm64/boot/dts/allwinner/sun50i-a100-allwinner-perf1.dts
index d34c2bb1079f..f5c5c1464482 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a100-allwinner-perf1.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a100-allwinner-perf1.dts
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: (GPL-2.0+ or MIT)
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
 /*
  * Copyright (c) 2020 Yangtao Li <frank@allwinnertech.com>
  */
diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a100.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-a100.dtsi
index 97e3e6907acd..a3dccf193765 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a100.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a100.dtsi
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: (GPL-2.0+ or MIT)
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
 /*
  * Copyright (c) 2020 Yangtao Li <frank@allwinnertech.com>
  */
diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6-pine-h64-model-b.dts b/arch/arm64/boot/dts/allwinner/sun50i-h6-pine-h64-model-b.dts
index 686f58e77004..b710f1a0f53a 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h6-pine-h64-model-b.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h6-pine-h64-model-b.dts
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: (GPL-2.0+ or MIT)
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
 /*
  * Copyright (C) 2019 Corentin LABBE <clabbe@baylibre.com>
  */
diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h616-orangepi-zero.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-h616-orangepi-zero.dtsi
index 8788c129b288..15290e6892fc 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h616-orangepi-zero.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h616-orangepi-zero.dtsi
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: (GPL-2.0+ or MIT)
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
 /*
  * Copyright (C) 2020 Arm Ltd.
  *
diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h616-orangepi-zero2.dts b/arch/arm64/boot/dts/allwinner/sun50i-h616-orangepi-zero2.dts
index d6e732b12c52..d83852e72f06 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h616-orangepi-zero2.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h616-orangepi-zero2.dts
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: (GPL-2.0+ or MIT)
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
 /*
  * Copyright (C) 2020 Arm Ltd.
  */
diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h616-x96-mate.dts b/arch/arm64/boot/dts/allwinner/sun50i-h616-x96-mate.dts
index 07424c28b696..959b6fd18483 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h616-x96-mate.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h616-x96-mate.dts
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: (GPL-2.0+ or MIT)
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
 /*
  * Copyright (C) 2021 Arm Ltd.
  */
diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h618-orangepi-zero3.dts b/arch/arm64/boot/dts/allwinner/sun50i-h618-orangepi-zero3.dts
index 96a685172811..00fe28caac93 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h618-orangepi-zero3.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h618-orangepi-zero3.dts
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: (GPL-2.0+ or MIT)
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
 /*
  * Copyright (C) 2023 Arm Ltd.
  */
diff --git a/arch/arm64/boot/dts/arm/corstone1000-fvp.dts b/arch/arm64/boot/dts/arm/corstone1000-fvp.dts
index 26b0f1b3cea6..901a7fc83307 100644
--- a/arch/arm64/boot/dts/arm/corstone1000-fvp.dts
+++ b/arch/arm64/boot/dts/arm/corstone1000-fvp.dts
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0 or MIT
+// SPDX-License-Identifier: GPL-2.0 OR MIT
 /*
  * Copyright (c) 2022, Arm Limited. All rights reserved.
  * Copyright (c) 2022, Linaro Limited. All rights reserved.
diff --git a/arch/arm64/boot/dts/arm/corstone1000-mps3.dts b/arch/arm64/boot/dts/arm/corstone1000-mps3.dts
index e3146747c2d9..10d265be0c02 100644
--- a/arch/arm64/boot/dts/arm/corstone1000-mps3.dts
+++ b/arch/arm64/boot/dts/arm/corstone1000-mps3.dts
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0 or MIT
+// SPDX-License-Identifier: GPL-2.0 OR MIT
 /*
  * Copyright (c) 2022, Arm Limited. All rights reserved.
  * Copyright (c) 2022, Linaro Limited. All rights reserved.
diff --git a/arch/arm64/boot/dts/arm/corstone1000.dtsi b/arch/arm64/boot/dts/arm/corstone1000.dtsi
index 34bc336ba8d1..6ad7829f9e28 100644
--- a/arch/arm64/boot/dts/arm/corstone1000.dtsi
+++ b/arch/arm64/boot/dts/arm/corstone1000.dtsi
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0 or MIT
+// SPDX-License-Identifier: GPL-2.0 OR MIT
 /*
  * Copyright (c) 2022, Arm Limited. All rights reserved.
  * Copyright (c) 2022, Linaro Limited. All rights reserved.
diff --git a/arch/arm64/boot/dts/broadcom/stingray/bcm958802a802x.dts b/arch/arm64/boot/dts/broadcom/stingray/bcm958802a802x.dts
index a41facd7d79b..66471a25e4ac 100644
--- a/arch/arm64/boot/dts/broadcom/stingray/bcm958802a802x.dts
+++ b/arch/arm64/boot/dts/broadcom/stingray/bcm958802a802x.dts
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: (GPL-2.0 or BSD-3-Clause)
+// SPDX-License-Identifier: (GPL-2.0 OR BSD-3-Clause)
 /*
  *Copyright(c) 2018 Broadcom
  */
diff --git a/arch/arm64/boot/dts/broadcom/stingray/stingray-board-base.dtsi b/arch/arm64/boot/dts/broadcom/stingray/stingray-board-base.dtsi
index 82a24711d0d8..cdd709491f01 100644
--- a/arch/arm64/boot/dts/broadcom/stingray/stingray-board-base.dtsi
+++ b/arch/arm64/boot/dts/broadcom/stingray/stingray-board-base.dtsi
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: (GPL-2.0 or BSD-3-Clause)
+// SPDX-License-Identifier: (GPL-2.0 OR BSD-3-Clause)
 /*
  *  Copyright(c) 2016-2018 Broadcom
  */
diff --git a/arch/arm64/boot/dts/broadcom/stingray/stingray-pcie.dtsi b/arch/arm64/boot/dts/broadcom/stingray/stingray-pcie.dtsi
index 33a472ab17e8..663e51756746 100644
--- a/arch/arm64/boot/dts/broadcom/stingray/stingray-pcie.dtsi
+++ b/arch/arm64/boot/dts/broadcom/stingray/stingray-pcie.dtsi
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: (GPL-2.0 or BSD-3-Clause)
+// SPDX-License-Identifier: (GPL-2.0 OR BSD-3-Clause)
 /*
  *Copyright(c) 2018 Broadcom
  */
diff --git a/arch/arm64/boot/dts/broadcom/stingray/stingray-usb.dtsi b/arch/arm64/boot/dts/broadcom/stingray/stingray-usb.dtsi
index 5401a646c840..ac4f7b8f9273 100644
--- a/arch/arm64/boot/dts/broadcom/stingray/stingray-usb.dtsi
+++ b/arch/arm64/boot/dts/broadcom/stingray/stingray-usb.dtsi
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: (GPL-2.0 or BSD-3-Clause)
+// SPDX-License-Identifier: (GPL-2.0 OR BSD-3-Clause)
 /*
  *Copyright(c) 2018 Broadcom
  */
diff --git a/arch/arm64/boot/dts/freescale/imx8mm-emcon-avari.dts b/arch/arm64/boot/dts/freescale/imx8mm-emcon-avari.dts
index b2e8967e9687..c8ff70212602 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm-emcon-avari.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mm-emcon-avari.dts
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: (GPL-2.0 or MIT)
+// SPDX-License-Identifier: (GPL-2.0 OR MIT)
 //
 // Copyright (c) 2021 emtrion GmbH
 // Author: Frank Erdrich <frank.erdrich@emtrion.com>
diff --git a/arch/arm64/boot/dts/freescale/imx8mm-emcon-avari.dtsi b/arch/arm64/boot/dts/freescale/imx8mm-emcon-avari.dtsi
index 5028f232b6bd..d897a8527335 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm-emcon-avari.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mm-emcon-avari.dtsi
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: (GPL-2.0 or MIT)
+// SPDX-License-Identifier: (GPL-2.0 OR MIT)
 //
 // Copyright (C) 2021 emtrion GmbH
 // Author: Frank Erdrich <frank.erdrich@emtrion.com>
diff --git a/arch/arm64/boot/dts/freescale/imx8mm-emcon.dtsi b/arch/arm64/boot/dts/freescale/imx8mm-emcon.dtsi
index 40e18edbaadd..af7dc8d1f5f1 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm-emcon.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mm-emcon.dtsi
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: (GPL-2.0 or MIT)
+// SPDX-License-Identifier: (GPL-2.0 OR MIT)
 //
 // Copyright 2018 NXP
 // Copyright (C) 2021 emtrion GmbH
diff --git a/arch/arm64/boot/dts/renesas/r8a77980a.dtsi b/arch/arm64/boot/dts/renesas/r8a77980a.dtsi
index 25b2d27b6167..83f5e21111c9 100644
--- a/arch/arm64/boot/dts/renesas/r8a77980a.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a77980a.dtsi
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: (GPL-2.0 or MIT)
+// SPDX-License-Identifier: (GPL-2.0 OR MIT)
 /*
  * Device Tree Source for the R-Car V3H2 (R8A77980A) SoC
  *
diff --git a/arch/arm64/boot/dts/renesas/r8a779f0-spider-cpu.dtsi b/arch/arm64/boot/dts/renesas/r8a779f0-spider-cpu.dtsi
index 76a94812875e..5cbde8e8fcd5 100644
--- a/arch/arm64/boot/dts/renesas/r8a779f0-spider-cpu.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a779f0-spider-cpu.dtsi
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: (GPL-2.0 or MIT)
+// SPDX-License-Identifier: (GPL-2.0 OR MIT)
 /*
  * Device Tree Source for the Spider CPU board
  *
diff --git a/arch/arm64/boot/dts/renesas/r8a779f0-spider.dts b/arch/arm64/boot/dts/renesas/r8a779f0-spider.dts
index 7aac3f4d319c..f139cc4feb37 100644
--- a/arch/arm64/boot/dts/renesas/r8a779f0-spider.dts
+++ b/arch/arm64/boot/dts/renesas/r8a779f0-spider.dts
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: (GPL-2.0 or MIT)
+// SPDX-License-Identifier: (GPL-2.0 OR MIT)
 /*
  * Device Tree Source for the Spider CPU and BreakOut boards
  *
diff --git a/arch/arm64/boot/dts/renesas/r8a779f0.dtsi b/arch/arm64/boot/dts/renesas/r8a779f0.dtsi
index 0059c9c580f3..ecdd5a523fa3 100644
--- a/arch/arm64/boot/dts/renesas/r8a779f0.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a779f0.dtsi
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: (GPL-2.0 or MIT)
+// SPDX-License-Identifier: (GPL-2.0 OR MIT)
 /*
  * Device Tree Source for the R-Car S4-8 (R8A779F0) SoC
  *
diff --git a/arch/arm64/boot/dts/renesas/r8a779m0.dtsi b/arch/arm64/boot/dts/renesas/r8a779m0.dtsi
index 6fb1979cc041..38978360e722 100644
--- a/arch/arm64/boot/dts/renesas/r8a779m0.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a779m0.dtsi
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: (GPL-2.0 or MIT)
+// SPDX-License-Identifier: (GPL-2.0 OR MIT)
 /*
  * Device Tree Source for the R-Car H3e (R8A779M0) SoC
  *
diff --git a/arch/arm64/boot/dts/renesas/r8a779m1-salvator-xs.dts b/arch/arm64/boot/dts/renesas/r8a779m1-salvator-xs.dts
index 084b75b04680..74b0ac04ffe1 100644
--- a/arch/arm64/boot/dts/renesas/r8a779m1-salvator-xs.dts
+++ b/arch/arm64/boot/dts/renesas/r8a779m1-salvator-xs.dts
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: (GPL-2.0 or MIT)
+// SPDX-License-Identifier: (GPL-2.0 OR MIT)
 /*
  * Device Tree Source for the Salvator-X 2nd version board with R-Car H3e-2G
  *
diff --git a/arch/arm64/boot/dts/renesas/r8a779m1-ulcb-kf.dts b/arch/arm64/boot/dts/renesas/r8a779m1-ulcb-kf.dts
index 0baebc5c58b0..d2089e1d7100 100644
--- a/arch/arm64/boot/dts/renesas/r8a779m1-ulcb-kf.dts
+++ b/arch/arm64/boot/dts/renesas/r8a779m1-ulcb-kf.dts
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: (GPL-2.0 or MIT)
+// SPDX-License-Identifier: (GPL-2.0 OR MIT)
 /*
  * Device Tree Source for the H3ULCB Kingfisher board with R-Car H3e-2G
  *
diff --git a/arch/arm64/boot/dts/renesas/r8a779m1-ulcb.dts b/arch/arm64/boot/dts/renesas/r8a779m1-ulcb.dts
index e294b6bda28c..705ea047ef62 100644
--- a/arch/arm64/boot/dts/renesas/r8a779m1-ulcb.dts
+++ b/arch/arm64/boot/dts/renesas/r8a779m1-ulcb.dts
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: (GPL-2.0 or MIT)
+// SPDX-License-Identifier: (GPL-2.0 OR MIT)
 /*
  * Device Tree Source for the H3ULCB (R-Car Starter Kit Premier) with R-Car H3e-2G
  *
diff --git a/arch/arm64/boot/dts/renesas/r8a779m1.dtsi b/arch/arm64/boot/dts/renesas/r8a779m1.dtsi
index 1064a87a0c77..be0219defe3a 100644
--- a/arch/arm64/boot/dts/renesas/r8a779m1.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a779m1.dtsi
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: (GPL-2.0 or MIT)
+// SPDX-License-Identifier: (GPL-2.0 OR MIT)
 /*
  * Device Tree Source for the R-Car H3e-2G (R8A779M1) SoC
  *
diff --git a/arch/arm64/boot/dts/renesas/r8a779m2.dtsi b/arch/arm64/boot/dts/renesas/r8a779m2.dtsi
index 324627340b86..bced12764c69 100644
--- a/arch/arm64/boot/dts/renesas/r8a779m2.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a779m2.dtsi
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: (GPL-2.0 or MIT)
+// SPDX-License-Identifier: (GPL-2.0 OR MIT)
 /*
  * Device Tree Source for the R-Car M3e (R8A779M2) SoC
  *
diff --git a/arch/arm64/boot/dts/renesas/r8a779m3-salvator-xs.dts b/arch/arm64/boot/dts/renesas/r8a779m3-salvator-xs.dts
index 4ab26fd7233d..e53a6e88ccfa 100644
--- a/arch/arm64/boot/dts/renesas/r8a779m3-salvator-xs.dts
+++ b/arch/arm64/boot/dts/renesas/r8a779m3-salvator-xs.dts
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: (GPL-2.0 or MIT)
+// SPDX-License-Identifier: (GPL-2.0 OR MIT)
 /*
  * Device Tree Source for the Salvator-X 2nd version board with R-Car M3e-2G
  *
diff --git a/arch/arm64/boot/dts/renesas/r8a779m3-ulcb-kf.dts b/arch/arm64/boot/dts/renesas/r8a779m3-ulcb-kf.dts
index 6bacee1d2ef5..587e8764bcd2 100644
--- a/arch/arm64/boot/dts/renesas/r8a779m3-ulcb-kf.dts
+++ b/arch/arm64/boot/dts/renesas/r8a779m3-ulcb-kf.dts
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: (GPL-2.0 or MIT)
+// SPDX-License-Identifier: (GPL-2.0 OR MIT)
 /*
  * Device Tree Source for the M3ULCB Kingfisher board with R-Car M3e-2G
  *
diff --git a/arch/arm64/boot/dts/renesas/r8a779m3-ulcb.dts b/arch/arm64/boot/dts/renesas/r8a779m3-ulcb.dts
index 8f215a0b771b..413f000b4630 100644
--- a/arch/arm64/boot/dts/renesas/r8a779m3-ulcb.dts
+++ b/arch/arm64/boot/dts/renesas/r8a779m3-ulcb.dts
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: (GPL-2.0 or MIT)
+// SPDX-License-Identifier: (GPL-2.0 OR MIT)
 /*
  * Device Tree Source for the M3ULCB (R-Car Starter Kit Pro) with R-Car M3e-2G
  *
diff --git a/arch/arm64/boot/dts/renesas/r8a779m3.dtsi b/arch/arm64/boot/dts/renesas/r8a779m3.dtsi
index 7fdbdd97ed4b..ffde141137df 100644
--- a/arch/arm64/boot/dts/renesas/r8a779m3.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a779m3.dtsi
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: (GPL-2.0 or MIT)
+// SPDX-License-Identifier: (GPL-2.0 OR MIT)
 /*
  * Device Tree Source for the R-Car M3e-2G (R8A779M3) SoC
  *
diff --git a/arch/arm64/boot/dts/renesas/r8a779m4.dtsi b/arch/arm64/boot/dts/renesas/r8a779m4.dtsi
index d7fbb6c05502..ae8486056962 100644
--- a/arch/arm64/boot/dts/renesas/r8a779m4.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a779m4.dtsi
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: (GPL-2.0 or MIT)
+// SPDX-License-Identifier: (GPL-2.0 OR MIT)
 /*
  * Device Tree Source for the R-Car M3Ne (R8A779M4) SoC
  *
diff --git a/arch/arm64/boot/dts/renesas/r8a779m5-salvator-xs.dts b/arch/arm64/boot/dts/renesas/r8a779m5-salvator-xs.dts
index c0341a88d641..6efc23171a66 100644
--- a/arch/arm64/boot/dts/renesas/r8a779m5-salvator-xs.dts
+++ b/arch/arm64/boot/dts/renesas/r8a779m5-salvator-xs.dts
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: (GPL-2.0 or MIT)
+// SPDX-License-Identifier: (GPL-2.0 OR MIT)
 /*
  * Device Tree Source for the Salvator-X 2nd version board with R-Car M3Ne-2G
  *
diff --git a/arch/arm64/boot/dts/renesas/r8a779m5.dtsi b/arch/arm64/boot/dts/renesas/r8a779m5.dtsi
index df51e0ff5986..aded03ad31a1 100644
--- a/arch/arm64/boot/dts/renesas/r8a779m5.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a779m5.dtsi
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: (GPL-2.0 or MIT)
+// SPDX-License-Identifier: (GPL-2.0 OR MIT)
 /*
  * Device Tree Source for the R-Car M3Ne-2G (R8A779M5) SoC
  *
diff --git a/arch/arm64/boot/dts/renesas/r8a779m6.dtsi b/arch/arm64/boot/dts/renesas/r8a779m6.dtsi
index afe3cabfb898..94d6a6cf503e 100644
--- a/arch/arm64/boot/dts/renesas/r8a779m6.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a779m6.dtsi
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: (GPL-2.0 or MIT)
+// SPDX-License-Identifier: (GPL-2.0 OR MIT)
 /*
  * Device Tree Source for the R-Car E3e (R8A779M6) SoC
  *
diff --git a/arch/arm64/boot/dts/renesas/r8a779m7.dtsi b/arch/arm64/boot/dts/renesas/r8a779m7.dtsi
index 4958babc52fd..0580fa614034 100644
--- a/arch/arm64/boot/dts/renesas/r8a779m7.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a779m7.dtsi
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: (GPL-2.0 or MIT)
+// SPDX-License-Identifier: (GPL-2.0 OR MIT)
 /*
  * Device Tree Source for the R-Car D3e (R8A779M7) SoC
  *
diff --git a/arch/arm64/boot/dts/renesas/r8a779m8.dtsi b/arch/arm64/boot/dts/renesas/r8a779m8.dtsi
index 750bd8ccdb7f..dfccc080fb3e 100644
--- a/arch/arm64/boot/dts/renesas/r8a779m8.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a779m8.dtsi
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: (GPL-2.0 or MIT)
+// SPDX-License-Identifier: (GPL-2.0 OR MIT)
 /*
  * Device Tree Source for the R-Car H3Ne (R8A779M8) SoC
  *
diff --git a/arch/arm64/boot/dts/renesas/r8a779mb.dtsi b/arch/arm64/boot/dts/renesas/r8a779mb.dtsi
index 40d1dce2f350..181b737c91cd 100644
--- a/arch/arm64/boot/dts/renesas/r8a779mb.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a779mb.dtsi
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: (GPL-2.0 or MIT)
+// SPDX-License-Identifier: (GPL-2.0 OR MIT)
 /*
  * Device Tree Source for the R-Car H3Ne-1.7G (R8A779MB) SoC
  *
-- 
2.34.1

