Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFF1177BE76
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 18:54:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232583AbjHNQyG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 12:54:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232249AbjHNQxw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 12:53:52 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69DD8E65
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 09:53:51 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id 4fb4d7f45d1cf-52164adea19so5880062a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 09:53:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692032030; x=1692636830;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nhZakCORHJvvcHJeYynzuiqb7Qqvi9fc/FhpwNnEQh4=;
        b=UU1zEQkSz+aiRtzKBsG3ob0Lp/qsaAQOXAQCtaon4JRzjCEk5WZGKpOxxXumJ3rx+G
         GWxdSBaErrFO22F0R5K1EK9G9Vivk55zeo32t5KN5CzTDbRR43ugLNwujNEOQNH9fcHn
         2pa43+3FIrQShNODVGT5+Smi4phqdOl4hXCNDZyoQOopZjb68I0ieAQEp5zYfC9xR/h2
         o7fd0TrWC2fbF+7GkVsL5wPUx51NyAVbkHW2ddoz4ojcDm/mw8UOvGH5nSAnN9/L4Fpz
         +ypL3G5EYkH90ZEgVRjAo7gHGONVmI28j26onWBulnjA8Pl5IFfQ4+eHOwsQZIIcMnAf
         HALA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692032030; x=1692636830;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nhZakCORHJvvcHJeYynzuiqb7Qqvi9fc/FhpwNnEQh4=;
        b=TRPsFlHHbe6mtWvdEs7WipfRM80ZgeF2zzmHCWkGAaTbtT8tYRg6kpiVBnedTlf2Pr
         ZAb8l83fQYoccVM80x9oCoSQEEIwerw5JLiHge5C+fbzes65AsARfTeX3UR0xI9ep+BQ
         fomvVFnjt3TlCo6JGMK6Gpy6jf8Ik+xr0mlbdcPizM2p79mMxMQ1Cv1M5bsi0GO1me4y
         8SUBjjS3tc5itlZ6uPrRXlobOLTttJHZVS8VUD7QA0KAE/Ee+zCW8LGUuUSrrkoYQNNr
         lAVuYycgA6sJ7IjUpx8ZBB/+4rb28pnDRSaz/scmljQzxHnD6pON78xjPPDMOt0OYks9
         oTeQ==
X-Gm-Message-State: AOJu0YyO69WyXqsS1TTHL/luYAgrmUPk+rDtQxKghZhxoMwdfswPvQ0d
        Mbgmov4DjJhClrMKmBmHl0TTYQ==
X-Google-Smtp-Source: AGHT+IHH58n3dwmVLyOxmdEpb6TAsaEQKuG7vFdqN5zouaZw0m/D+WZOkvbRnz5AC4ZNWjmaHEoPCw==
X-Received: by 2002:a05:6402:206a:b0:51e:5251:8f45 with SMTP id bd10-20020a056402206a00b0051e52518f45mr7529320edb.4.1692032029902;
        Mon, 14 Aug 2023 09:53:49 -0700 (PDT)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id n5-20020aa7c785000000b0052338f5b2a4sm5811267eds.86.2023.08.14.09.53.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Aug 2023 09:53:48 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, Rob Herring <robh@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 13/22] nvmem: Explicitly include correct DT includes
Date:   Mon, 14 Aug 2023 17:52:43 +0100
Message-Id: <20230814165252.93422-14-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230814165252.93422-1-srinivas.kandagatla@linaro.org>
References: <20230814165252.93422-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rob Herring <robh@kernel.org>

The DT of_device.h and of_platform.h date back to the separate
of_platform_bus_type before it as merged into the regular platform bus.
As part of that merge prepping Arm DT support 13 years ago, they
"temporarily" include each other. They also include platform_device.h
and of.h. As a result, there's a pretty much random mix of those include
files used throughout the tree. In order to detangle these headers and
replace the implicit includes with struct declarations, users need to
explicitly include the correct includes.

Signed-off-by: Rob Herring <robh@kernel.org>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/nvmem/bcm-ocotp.c      | 1 -
 drivers/nvmem/core.c           | 1 -
 drivers/nvmem/imx-iim.c        | 1 -
 drivers/nvmem/imx-ocotp-ele.c  | 2 +-
 drivers/nvmem/imx-ocotp-scu.c  | 2 +-
 drivers/nvmem/imx-ocotp.c      | 1 -
 drivers/nvmem/lpc18xx_otp.c    | 1 -
 drivers/nvmem/meson-mx-efuse.c | 1 -
 drivers/nvmem/qcom-spmi-sdam.c | 2 +-
 drivers/nvmem/rave-sp-eeprom.c | 2 +-
 drivers/nvmem/sc27xx-efuse.c   | 1 -
 drivers/nvmem/snvs_lpgpr.c     | 3 ++-
 drivers/nvmem/sprd-efuse.c     | 2 +-
 drivers/nvmem/sunplus-ocotp.c  | 2 +-
 drivers/nvmem/sunxi_sid.c      | 1 -
 drivers/nvmem/u-boot-env.c     | 2 +-
 16 files changed, 9 insertions(+), 16 deletions(-)

diff --git a/drivers/nvmem/bcm-ocotp.c b/drivers/nvmem/bcm-ocotp.c
index 0c1fa0c4feb2..2490f44caa40 100644
--- a/drivers/nvmem/bcm-ocotp.c
+++ b/drivers/nvmem/bcm-ocotp.c
@@ -8,7 +8,6 @@
 #include <linux/module.h>
 #include <linux/nvmem-provider.h>
 #include <linux/of.h>
-#include <linux/of_device.h>
 #include <linux/platform_device.h>
 
 /*
diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
index 3f8c7718412b..2251103b2c5f 100644
--- a/drivers/nvmem/core.c
+++ b/drivers/nvmem/core.c
@@ -17,7 +17,6 @@
 #include <linux/nvmem-provider.h>
 #include <linux/gpio/consumer.h>
 #include <linux/of.h>
-#include <linux/of_device.h>
 #include <linux/slab.h>
 
 struct nvmem_device {
diff --git a/drivers/nvmem/imx-iim.c b/drivers/nvmem/imx-iim.c
index c86339a7f583..f13bbd164086 100644
--- a/drivers/nvmem/imx-iim.c
+++ b/drivers/nvmem/imx-iim.c
@@ -14,7 +14,6 @@
 #include <linux/module.h>
 #include <linux/nvmem-provider.h>
 #include <linux/of.h>
-#include <linux/of_device.h>
 #include <linux/platform_device.h>
 #include <linux/slab.h>
 #include <linux/clk.h>
diff --git a/drivers/nvmem/imx-ocotp-ele.c b/drivers/nvmem/imx-ocotp-ele.c
index f1cbbc9afeb8..cf920542f939 100644
--- a/drivers/nvmem/imx-ocotp-ele.c
+++ b/drivers/nvmem/imx-ocotp-ele.c
@@ -9,7 +9,7 @@
 #include <linux/io.h>
 #include <linux/module.h>
 #include <linux/nvmem-provider.h>
-#include <linux/of_device.h>
+#include <linux/of.h>
 #include <linux/platform_device.h>
 #include <linux/slab.h>
 
diff --git a/drivers/nvmem/imx-ocotp-scu.c b/drivers/nvmem/imx-ocotp-scu.c
index 399e1eb8b4c1..c38d9c1c3f48 100644
--- a/drivers/nvmem/imx-ocotp-scu.c
+++ b/drivers/nvmem/imx-ocotp-scu.c
@@ -11,7 +11,7 @@
 #include <linux/firmware/imx/sci.h>
 #include <linux/module.h>
 #include <linux/nvmem-provider.h>
-#include <linux/of_device.h>
+#include <linux/of.h>
 #include <linux/platform_device.h>
 #include <linux/slab.h>
 
diff --git a/drivers/nvmem/imx-ocotp.c b/drivers/nvmem/imx-ocotp.c
index ab556c011f3e..a223d9537f22 100644
--- a/drivers/nvmem/imx-ocotp.c
+++ b/drivers/nvmem/imx-ocotp.c
@@ -20,7 +20,6 @@
 #include <linux/module.h>
 #include <linux/nvmem-provider.h>
 #include <linux/of.h>
-#include <linux/of_device.h>
 #include <linux/platform_device.h>
 #include <linux/slab.h>
 #include <linux/delay.h>
diff --git a/drivers/nvmem/lpc18xx_otp.c b/drivers/nvmem/lpc18xx_otp.c
index 8faed05e3cbe..adc9948e7b2e 100644
--- a/drivers/nvmem/lpc18xx_otp.c
+++ b/drivers/nvmem/lpc18xx_otp.c
@@ -14,7 +14,6 @@
 #include <linux/module.h>
 #include <linux/nvmem-provider.h>
 #include <linux/of.h>
-#include <linux/of_device.h>
 #include <linux/platform_device.h>
 #include <linux/slab.h>
 
diff --git a/drivers/nvmem/meson-mx-efuse.c b/drivers/nvmem/meson-mx-efuse.c
index 461e3ad87bcd..d6d7aeda31f9 100644
--- a/drivers/nvmem/meson-mx-efuse.c
+++ b/drivers/nvmem/meson-mx-efuse.c
@@ -14,7 +14,6 @@
 #include <linux/module.h>
 #include <linux/nvmem-provider.h>
 #include <linux/of.h>
-#include <linux/of_device.h>
 #include <linux/platform_device.h>
 #include <linux/sizes.h>
 #include <linux/slab.h>
diff --git a/drivers/nvmem/qcom-spmi-sdam.c b/drivers/nvmem/qcom-spmi-sdam.c
index f822790db49e..70f2d4f2efbf 100644
--- a/drivers/nvmem/qcom-spmi-sdam.c
+++ b/drivers/nvmem/qcom-spmi-sdam.c
@@ -6,8 +6,8 @@
 #include <linux/device.h>
 #include <linux/module.h>
 #include <linux/of.h>
-#include <linux/of_platform.h>
 #include <linux/nvmem-provider.h>
+#include <linux/platform_device.h>
 #include <linux/regmap.h>
 
 #define SDAM_MEM_START			0x40
diff --git a/drivers/nvmem/rave-sp-eeprom.c b/drivers/nvmem/rave-sp-eeprom.c
index c456011b75e8..df6a1c594b78 100644
--- a/drivers/nvmem/rave-sp-eeprom.c
+++ b/drivers/nvmem/rave-sp-eeprom.c
@@ -10,7 +10,7 @@
 #include <linux/mfd/rave-sp.h>
 #include <linux/module.h>
 #include <linux/nvmem-provider.h>
-#include <linux/of_device.h>
+#include <linux/of.h>
 #include <linux/platform_device.h>
 #include <linux/sizes.h>
 
diff --git a/drivers/nvmem/sc27xx-efuse.c b/drivers/nvmem/sc27xx-efuse.c
index c825fc902d10..2210da40dfbd 100644
--- a/drivers/nvmem/sc27xx-efuse.c
+++ b/drivers/nvmem/sc27xx-efuse.c
@@ -4,7 +4,6 @@
 #include <linux/hwspinlock.h>
 #include <linux/module.h>
 #include <linux/of.h>
-#include <linux/of_device.h>
 #include <linux/platform_device.h>
 #include <linux/regmap.h>
 #include <linux/nvmem-provider.h>
diff --git a/drivers/nvmem/snvs_lpgpr.c b/drivers/nvmem/snvs_lpgpr.c
index 4692aa985bd6..89c27112320f 100644
--- a/drivers/nvmem/snvs_lpgpr.c
+++ b/drivers/nvmem/snvs_lpgpr.c
@@ -7,7 +7,8 @@
 #include <linux/mfd/syscon.h>
 #include <linux/module.h>
 #include <linux/nvmem-provider.h>
-#include <linux/of_device.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
 #include <linux/regmap.h>
 
 #define IMX6Q_SNVS_HPLR		0x00
diff --git a/drivers/nvmem/sprd-efuse.c b/drivers/nvmem/sprd-efuse.c
index 4f1fcbfec394..7e6e31db4baa 100644
--- a/drivers/nvmem/sprd-efuse.c
+++ b/drivers/nvmem/sprd-efuse.c
@@ -7,7 +7,7 @@
 #include <linux/io.h>
 #include <linux/module.h>
 #include <linux/nvmem-provider.h>
-#include <linux/of_device.h>
+#include <linux/of.h>
 #include <linux/platform_device.h>
 
 #define SPRD_EFUSE_ENABLE		0x20
diff --git a/drivers/nvmem/sunplus-ocotp.c b/drivers/nvmem/sunplus-ocotp.c
index f85350b17d67..f3a18aa0a6c7 100644
--- a/drivers/nvmem/sunplus-ocotp.c
+++ b/drivers/nvmem/sunplus-ocotp.c
@@ -13,8 +13,8 @@
 #include <linux/io.h>
 #include <linux/iopoll.h>
 #include <linux/module.h>
+#include <linux/mod_devicetable.h>
 #include <linux/nvmem-provider.h>
-#include <linux/of_device.h>
 #include <linux/platform_device.h>
 
 /*
diff --git a/drivers/nvmem/sunxi_sid.c b/drivers/nvmem/sunxi_sid.c
index 6bfe02ab169a..5d364d85347f 100644
--- a/drivers/nvmem/sunxi_sid.c
+++ b/drivers/nvmem/sunxi_sid.c
@@ -12,7 +12,6 @@
 #include <linux/module.h>
 #include <linux/nvmem-provider.h>
 #include <linux/of.h>
-#include <linux/of_device.h>
 #include <linux/platform_device.h>
 #include <linux/slab.h>
 #include <linux/random.h>
diff --git a/drivers/nvmem/u-boot-env.c b/drivers/nvmem/u-boot-env.c
index ee9fd9989b6e..80c5382b361c 100644
--- a/drivers/nvmem/u-boot-env.c
+++ b/drivers/nvmem/u-boot-env.c
@@ -11,7 +11,7 @@
 #include <linux/mtd/mtd.h>
 #include <linux/nvmem-consumer.h>
 #include <linux/nvmem-provider.h>
-#include <linux/of_device.h>
+#include <linux/of.h>
 #include <linux/platform_device.h>
 #include <linux/slab.h>
 
-- 
2.25.1

