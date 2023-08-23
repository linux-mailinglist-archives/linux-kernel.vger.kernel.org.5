Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DF8378534F
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 10:59:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235291AbjHWI7S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 04:59:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234910AbjHWIzk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 04:55:40 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46FEC1FE4
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 01:52:02 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id 2adb3069b0e04-4ff91f2d7e2so7698274e87.0
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 01:52:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692780720; x=1693385520;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7D2ouUhW30X6Tc9yQKY+DadfBMJeG3kxkyZx2pcZ+Fg=;
        b=sIlOYGc/ZmKfI2RhksznWNTLXphb9ZU1vnoGgw+9kpuBCsrs+KwtG7j1eVs/ryvpFg
         H6A5+1YRebYkjaA/UW6C/PPIEOXNlTcKpC4p/NtVg2r9wYMBZ7779wtWiJdrXcLFnBeH
         ZvFiQGuTARPQxbHziGh6JDOqd2xUP5ZP6CSrKgP2Qvnvtu80JtBgCbUtcK0ioi9KhuA3
         v6M+J92F0Soe/DfWS1BPm5YHlvQU4XCki6xXIrDZWoKBclI3KR8pA3JghKqS4dxvcnWQ
         n2BiuDHFkUqLAumUTHqf4U/rkl6E7dXFXirxUnz2FA61IF+LiiWNLw6bIrwwumB0Folp
         06Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692780720; x=1693385520;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7D2ouUhW30X6Tc9yQKY+DadfBMJeG3kxkyZx2pcZ+Fg=;
        b=NzdXfDBzTzL1BBMEV33IO9XROEmYyirGVxr1866bwnuTUlZCypawBYrwxc2umVzwvu
         fqEf4M+ENyGzZx1bYl236NRUSJ2AY8pOfYDfBQh9eJQ8ME1mU2NyIwUf8cO/RPyrJGkH
         5qXt4LvTwj+pMjnbxDTVLIAYKzF9DczNy9KYcsHk2EBbGhuAQ0lzdk98sYouP/x11Wtx
         VLB0iEZ/ieqrZKTTAQjOF82MVNOByAXU4++0mprsuVNtZJY3gJLOPWYZwcbbh1pP7ztP
         jqBcrw2uRuNAyxnXERIE8BGepvKU4dAzbD+jPSSvYeg5DmwgathJML2UNzzFu4+0Vr8e
         B9sA==
X-Gm-Message-State: AOJu0YyQVL3cCcNEphtsn37FDVPzVRZqgf9JB1idSV5MBR+WauWuizGO
        AX9AHmN/yu4/we5KxW4j3eA+v8O5Xvzn3gl+GbI=
X-Google-Smtp-Source: AGHT+IF5ZWP6+GMqNyYtzuRMXVyZPxGrTYqGvfpxsUPFPsvr3clkivSzzEml7p4XyTWsj2zwc843FQ==
X-Received: by 2002:a19:385e:0:b0:4fd:d517:fbcd with SMTP id d30-20020a19385e000000b004fdd517fbcdmr6963552lfj.6.1692780720501;
        Wed, 23 Aug 2023 01:52:00 -0700 (PDT)
Received: from krzk-bin.. ([77.252.47.198])
        by smtp.gmail.com with ESMTPSA id s19-20020aa7c553000000b0051bed21a635sm9090986edr.74.2023.08.23.01.51.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Aug 2023 01:52:00 -0700 (PDT)
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
Subject: [PATCH 1/2] ARM: dts: use capital "OR" for multiple licenses in SPDX
Date:   Wed, 23 Aug 2023 10:51:45 +0200
Message-Id: <20230823085146.113562-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
 arch/arm/boot/dts/allwinner/sun8i-t113s-mangopi-mq-r-t113.dts | 2 +-
 arch/arm/boot/dts/allwinner/sun8i-t113s.dtsi                  | 2 +-
 arch/arm/boot/dts/allwinner/sunxi-d1s-t113-mangopi-mq-r.dtsi  | 2 +-
 arch/arm/boot/dts/nxp/imx/imx6dl-b105pv2.dts                  | 2 +-
 arch/arm/boot/dts/nxp/imx/imx6dl-b105v2.dts                   | 2 +-
 arch/arm/boot/dts/nxp/imx/imx6dl-b125pv2.dts                  | 2 +-
 arch/arm/boot/dts/nxp/imx/imx6dl-b125v2.dts                   | 2 +-
 arch/arm/boot/dts/nxp/imx/imx6dl-b155v2.dts                   | 2 +-
 arch/arm/boot/dts/nxp/imx/imx6dl-b1x5pv2.dtsi                 | 2 +-
 arch/arm/boot/dts/nxp/imx/imx6dl-b1x5v2.dtsi                  | 2 +-
 arch/arm/boot/dts/nxp/imx/imx6dl-emcon-avari.dts              | 2 +-
 arch/arm/boot/dts/nxp/imx/imx6dl-qmx6.dtsi                    | 2 +-
 arch/arm/boot/dts/nxp/imx/imx6q-emcon-avari.dts               | 2 +-
 arch/arm/boot/dts/nxp/imx/imx6qdl-emcon-avari.dtsi            | 2 +-
 arch/arm/boot/dts/nxp/imx/imx6qdl-emcon.dtsi                  | 2 +-
 arch/arm/boot/dts/st/stm32mp157c-emsbc-argon.dts              | 2 +-
 arch/arm/boot/dts/st/stm32mp157c-emstamp-argon.dtsi           | 2 +-
 17 files changed, 17 insertions(+), 17 deletions(-)

diff --git a/arch/arm/boot/dts/allwinner/sun8i-t113s-mangopi-mq-r-t113.dts b/arch/arm/boot/dts/allwinner/sun8i-t113s-mangopi-mq-r-t113.dts
index 94e24b5926dd..8b3a75383816 100644
--- a/arch/arm/boot/dts/allwinner/sun8i-t113s-mangopi-mq-r-t113.dts
+++ b/arch/arm/boot/dts/allwinner/sun8i-t113s-mangopi-mq-r-t113.dts
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: (GPL-2.0+ or MIT)
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
 // Copyright (C) 2022 Arm Ltd.
 
 #include <dt-bindings/interrupt-controller/irq.h>
diff --git a/arch/arm/boot/dts/allwinner/sun8i-t113s.dtsi b/arch/arm/boot/dts/allwinner/sun8i-t113s.dtsi
index 804aa197a24f..c7181308ae6f 100644
--- a/arch/arm/boot/dts/allwinner/sun8i-t113s.dtsi
+++ b/arch/arm/boot/dts/allwinner/sun8i-t113s.dtsi
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: (GPL-2.0+ or MIT)
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
 // Copyright (C) 2022 Arm Ltd.
 
 #define SOC_PERIPHERAL_IRQ(nr) GIC_SPI nr
diff --git a/arch/arm/boot/dts/allwinner/sunxi-d1s-t113-mangopi-mq-r.dtsi b/arch/arm/boot/dts/allwinner/sunxi-d1s-t113-mangopi-mq-r.dtsi
index e9bc749488bb..a415c4a78a70 100644
--- a/arch/arm/boot/dts/allwinner/sunxi-d1s-t113-mangopi-mq-r.dtsi
+++ b/arch/arm/boot/dts/allwinner/sunxi-d1s-t113-mangopi-mq-r.dtsi
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: (GPL-2.0+ or MIT)
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
 // Copyright (C) 2022 Arm Ltd.
 /*
  * Common peripherals and configurations for MangoPi MQ-R boards.
diff --git a/arch/arm/boot/dts/nxp/imx/imx6dl-b105pv2.dts b/arch/arm/boot/dts/nxp/imx/imx6dl-b105pv2.dts
index 411aa72d344b..7d4ae113c381 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6dl-b105pv2.dts
+++ b/arch/arm/boot/dts/nxp/imx/imx6dl-b105pv2.dts
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0 or MIT
+// SPDX-License-Identifier: GPL-2.0 OR MIT
 //
 // Device Tree Source for General Electric B105Pv2
 //
diff --git a/arch/arm/boot/dts/nxp/imx/imx6dl-b105v2.dts b/arch/arm/boot/dts/nxp/imx/imx6dl-b105v2.dts
index d011127c635b..9c5938e16d99 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6dl-b105v2.dts
+++ b/arch/arm/boot/dts/nxp/imx/imx6dl-b105v2.dts
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0 or MIT
+// SPDX-License-Identifier: GPL-2.0 OR MIT
 //
 // Device Tree Source for General Electric B105v2
 //
diff --git a/arch/arm/boot/dts/nxp/imx/imx6dl-b125pv2.dts b/arch/arm/boot/dts/nxp/imx/imx6dl-b125pv2.dts
index ca840fa84052..01df7cffcef2 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6dl-b125pv2.dts
+++ b/arch/arm/boot/dts/nxp/imx/imx6dl-b125pv2.dts
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0 or MIT
+// SPDX-License-Identifier: GPL-2.0 OR MIT
 //
 // Device Tree Source for General Electric B125Pv2
 //
diff --git a/arch/arm/boot/dts/nxp/imx/imx6dl-b125v2.dts b/arch/arm/boot/dts/nxp/imx/imx6dl-b125v2.dts
index 81e5a9cb8900..a015453daf10 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6dl-b125v2.dts
+++ b/arch/arm/boot/dts/nxp/imx/imx6dl-b125v2.dts
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0 or MIT
+// SPDX-License-Identifier: GPL-2.0 OR MIT
 //
 // Device Tree Source for General Electric B125v2
 //
diff --git a/arch/arm/boot/dts/nxp/imx/imx6dl-b155v2.dts b/arch/arm/boot/dts/nxp/imx/imx6dl-b155v2.dts
index c861937b30f6..b71ee6b79208 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6dl-b155v2.dts
+++ b/arch/arm/boot/dts/nxp/imx/imx6dl-b155v2.dts
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0 or MIT
+// SPDX-License-Identifier: GPL-2.0 OR MIT
 //
 // Device Tree Source for General Electric B155v2
 //
diff --git a/arch/arm/boot/dts/nxp/imx/imx6dl-b1x5pv2.dtsi b/arch/arm/boot/dts/nxp/imx/imx6dl-b1x5pv2.dtsi
index 6e487ebf27a2..9f1655540cb9 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6dl-b1x5pv2.dtsi
+++ b/arch/arm/boot/dts/nxp/imx/imx6dl-b1x5pv2.dtsi
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0 or MIT
+// SPDX-License-Identifier: GPL-2.0 OR MIT
 //
 // Device Tree Source for General Electric B1x5Pv2
 // patient monitor series
diff --git a/arch/arm/boot/dts/nxp/imx/imx6dl-b1x5v2.dtsi b/arch/arm/boot/dts/nxp/imx/imx6dl-b1x5v2.dtsi
index f028b6a191df..590dcc0953cc 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6dl-b1x5v2.dtsi
+++ b/arch/arm/boot/dts/nxp/imx/imx6dl-b1x5v2.dtsi
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0 or MIT
+// SPDX-License-Identifier: GPL-2.0 OR MIT
 //
 // Device Tree Source for General Electric B1x5v2
 // patient monitor series
diff --git a/arch/arm/boot/dts/nxp/imx/imx6dl-emcon-avari.dts b/arch/arm/boot/dts/nxp/imx/imx6dl-emcon-avari.dts
index 407ad8d43c84..77d7600b2675 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6dl-emcon-avari.dts
+++ b/arch/arm/boot/dts/nxp/imx/imx6dl-emcon-avari.dts
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: (GPL-2.0 or MIT)
+// SPDX-License-Identifier: (GPL-2.0 OR MIT)
 //
 // Copyright (C) 2018 emtrion GmbH
 //
diff --git a/arch/arm/boot/dts/nxp/imx/imx6dl-qmx6.dtsi b/arch/arm/boot/dts/nxp/imx/imx6dl-qmx6.dtsi
index 05fd8ff4da1e..8a637fdff073 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6dl-qmx6.dtsi
+++ b/arch/arm/boot/dts/nxp/imx/imx6dl-qmx6.dtsi
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0 or MIT
+// SPDX-License-Identifier: GPL-2.0 OR MIT
 //
 // Device Tree Source for i.MX6DL based congatec QMX6
 // System on Module
diff --git a/arch/arm/boot/dts/nxp/imx/imx6q-emcon-avari.dts b/arch/arm/boot/dts/nxp/imx/imx6q-emcon-avari.dts
index 0f582a9d4c0e..02813368a820 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6q-emcon-avari.dts
+++ b/arch/arm/boot/dts/nxp/imx/imx6q-emcon-avari.dts
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: (GPL-2.0 or MIT)
+// SPDX-License-Identifier: (GPL-2.0 OR MIT)
 //
 // Copyright (C) 2018 emtrion GmbH
 //
diff --git a/arch/arm/boot/dts/nxp/imx/imx6qdl-emcon-avari.dtsi b/arch/arm/boot/dts/nxp/imx/imx6qdl-emcon-avari.dtsi
index c4e146f3341b..f1a41c76729c 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6qdl-emcon-avari.dtsi
+++ b/arch/arm/boot/dts/nxp/imx/imx6qdl-emcon-avari.dtsi
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: (GPL-2.0 or MIT)
+// SPDX-License-Identifier: (GPL-2.0 OR MIT)
 //
 // Copyright (C) 2018 emtrion GmbH
 //
diff --git a/arch/arm/boot/dts/nxp/imx/imx6qdl-emcon.dtsi b/arch/arm/boot/dts/nxp/imx/imx6qdl-emcon.dtsi
index ee2dd75cead6..a63e73adc1fc 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6qdl-emcon.dtsi
+++ b/arch/arm/boot/dts/nxp/imx/imx6qdl-emcon.dtsi
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: (GPL-2.0 or MIT)
+// SPDX-License-Identifier: (GPL-2.0 OR MIT)
 //
 // Copyright (C) 2018 emtrion GmbH
 //
diff --git a/arch/arm/boot/dts/st/stm32mp157c-emsbc-argon.dts b/arch/arm/boot/dts/st/stm32mp157c-emsbc-argon.dts
index 33b3f11d24bb..a19c488cf7c8 100644
--- a/arch/arm/boot/dts/st/stm32mp157c-emsbc-argon.dts
+++ b/arch/arm/boot/dts/st/stm32mp157c-emsbc-argon.dts
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: (GPL-2.0 or MIT)
+// SPDX-License-Identifier: (GPL-2.0 OR MIT)
 //
 // Copyright (c) 2021 emtrion GmbH
 // Author: Reinhold Müller <reinhold.mueller@emtrion.de>.
diff --git a/arch/arm/boot/dts/st/stm32mp157c-emstamp-argon.dtsi b/arch/arm/boot/dts/st/stm32mp157c-emstamp-argon.dtsi
index 009209ca673b..f928cfb80b87 100644
--- a/arch/arm/boot/dts/st/stm32mp157c-emstamp-argon.dtsi
+++ b/arch/arm/boot/dts/st/stm32mp157c-emstamp-argon.dtsi
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: (GPL-2.0 or MIT)
+// SPDX-License-Identifier: (GPL-2.0 OR MIT)
 //
 // Copyright (c) 2021 emtrion GmbH
 // Author: Reinhold Müller <reinhold.mueller@emtrion.de>.
-- 
2.34.1

