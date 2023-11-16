Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3ADE77EE8B8
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 22:17:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229723AbjKPVRt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 16:17:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjKPVRr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 16:17:47 -0500
Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A205B0;
        Thu, 16 Nov 2023 13:17:44 -0800 (PST)
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-1f00b95dc43so660892fac.3;
        Thu, 16 Nov 2023 13:17:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700169464; x=1700774264;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qnTKqQWM65hHmGWrh7eGkwdIKG6NV9DIncGlNOoqLgY=;
        b=ax9MXv8UIQLPoWRVd3lBeGX3GcvztvrCZuAirWtBhDfj9zqQWxbMxBobJxQqL6Oef6
         rwT7RO++2lQpX/tIrACjVtDMgQrMAudTQgjzUN4/+/tqFluM7vOx/AzWWpbOljTIuO2Y
         t39sWO8LOcjwgaWLh5yDonosT5GIosNhYYfBLCrxVZP5b0MI/8zK6XtlVwht0fl+S7sL
         lW4qggmuEZz0YYX+ogChV0Lk5v2URVVnc0Fsoh3C1xE7h2epKVA2K8fhIYOFXid3/4b6
         yFgafai0Ov8uOXg7CcCuC0FDQsiiEpV8cW4RMqIGSK0iSJv0BWlG1U0I4g+eXUTKXSjm
         MMrA==
X-Gm-Message-State: AOJu0YyOseU+ANelQeqM44lLsN1GssoxSmVklbgGiN5GTQ6eCQYYmEwK
        1wPEoLOFuqJ4PIG/VGSB9A==
X-Google-Smtp-Source: AGHT+IEBU/vTNTcV7kR70vkC1wTuSFY8n7ps0aTSJs2J+hUbwRB6rGAjShACA+o2CIuo9Vr35pp0ww==
X-Received: by 2002:a05:6870:2102:b0:1cc:c744:d320 with SMTP id f2-20020a056870210200b001ccc744d320mr22303935oae.53.1700169463720;
        Thu, 16 Nov 2023 13:17:43 -0800 (PST)
Received: from herring.priv (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id mo49-20020a056871323100b001ea689d8969sm33233oac.48.2023.11.16.13.17.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Nov 2023 13:17:42 -0800 (PST)
Received: (nullmailer pid 3228341 invoked by uid 1000);
        Thu, 16 Nov 2023 21:17:41 -0000
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] arm/arm64: samsung: Enable W=1 on dtbs by default
Date:   Thu, 16 Nov 2023 15:17:38 -0600
Message-ID: <20231116211739.3228239-1-robh@kernel.org>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Samsung platforms are clean of W=1 dtc warnings, so enable the warnings
by default. This way submitters don't have to remember to run a W=1
build of the .dts files and the grumpiness of the maintainers can be
reduced.

Signed-off-by: Rob Herring <robh@kernel.org>
---
Well, there's a couple of warnings on 32-bit, but they look fixable to
me.

There's a few other platforms we could do this to. Sadly, they are still
the minority. Otherwise, we could change the default and add a flag to
disable (I_STILL_HAVENT_FIXED_MY_PLATFORMS=1).
---
 arch/arm/boot/dts/samsung/Makefile  | 3 +++
 arch/arm64/boot/dts/exynos/Makefile | 4 ++++
 2 files changed, 7 insertions(+)

diff --git a/arch/arm/boot/dts/samsung/Makefile b/arch/arm/boot/dts/samsung/Makefile
index 7becf36656b1..b6a0e2beac00 100644
--- a/arch/arm/boot/dts/samsung/Makefile
+++ b/arch/arm/boot/dts/samsung/Makefile
@@ -1,4 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
+
+KBUILD_EXTRA_WARN=1
+
 dtb-$(CONFIG_ARCH_EXYNOS3) += \
 	exynos3250-artik5-eval.dtb \
 	exynos3250-monk.dtb \
diff --git a/arch/arm64/boot/dts/exynos/Makefile b/arch/arm64/boot/dts/exynos/Makefile
index 6e4ba69268e5..45c996fba5e4 100644
--- a/arch/arm64/boot/dts/exynos/Makefile
+++ b/arch/arm64/boot/dts/exynos/Makefile
@@ -1,4 +1,8 @@
 # SPDX-License-Identifier: GPL-2.0
+
+KBUILD_EXTRA_WARN=1
+DTC_FLAGS += -Wno-graph_child_address
+
 dtb-$(CONFIG_ARCH_EXYNOS) += \
 	exynos5433-tm2.dtb		\
 	exynos5433-tm2e.dtb		\
-- 
2.42.0

