Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C93175DC6F
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jul 2023 14:17:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230330AbjGVMR1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Jul 2023 08:17:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230260AbjGVMRZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jul 2023 08:17:25 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFBA4E5C
        for <linux-kernel@vger.kernel.org>; Sat, 22 Jul 2023 05:17:23 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id ffacd0b85a97d-3142a9ffa89so2469099f8f.0
        for <linux-kernel@vger.kernel.org>; Sat, 22 Jul 2023 05:17:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690028242; x=1690633042;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ILLgpy5dIr0Z3/YUCdwsp2YqhUyEPi8q24EqLCuiREc=;
        b=v9KVvLrdQL96VPifVk0GGKQlLpFKHR9J8RApAIbIJ0DkoBLZKsc8KD851rmi0ncTw0
         2a7ogbPTqkHFKVZLLkgXS5RTdvz8p3ff0F0c5TGNoSr3GzFTPfycZfFJPWwcczH4OhY9
         zze7WUy0AVHlf92hIirYOaqKHKRJIywPeZV5YgnGyqE6YTfXkDUglOqzDBljmr+4aTd0
         Baq18q7Gl5cHpZhoHv4J2j2Dpu5q0jBkb2u4UfBVkrrB2H5AcfR8vZSZezHne306xNQs
         uA/L118caSpP95/TWpyL2RLL7bmkCwjHCjX+lbYQuJfPD4veIVK+COXAb/3CNa4KM8n4
         ftmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690028242; x=1690633042;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ILLgpy5dIr0Z3/YUCdwsp2YqhUyEPi8q24EqLCuiREc=;
        b=c0AQk/qIje6lbvW3xUlIjtRdZI1XhVNIksk8xgOi+XYg4K3GIo7ejK2yhj845vXBmG
         o0M5m/qR3zLIYeVPIn9MYIBJBrwrjWB6rFiTWIRvetijwkE0aE63/KEb9h2TH93G/pJj
         bxWcKFy/DcD3l9ErHdrf8z0HffNrK2UOsyeHFKMKYSWQdvjsO2FLWWO+/M38exHbwPZZ
         AD+7CHd7HYw+78rjgFrok1qb7XCYO9sUD4fDtWfQE+ZWGSuCyDntqoEY4vrhefZ/IJd+
         I96BJVCXgd8BRRve1i4Vvg9BalvwoWCvtbk8AUZSSpyLOTWN2VhuRimjr/ChXpKyzAqs
         0E/g==
X-Gm-Message-State: ABy/qLb+72YmFNPX4UpOmFNJkWGPPRkZXnKUvAXRbPXAOTT3MyV9a114
        6m+ReLDtmsKv9Q7gSoScFs9toxQEiYYgCowNzJI=
X-Google-Smtp-Source: APBJJlENl+aXVKlJM+hM7aRF2AwpchS/c9fYjatpZu+G7lKwGezOvCdyOTn9gQd0Vtz29jV0qPaDug==
X-Received: by 2002:adf:eccc:0:b0:313:dee2:e052 with SMTP id s12-20020adfeccc000000b00313dee2e052mr3917087wro.26.1690028242400;
        Sat, 22 Jul 2023 05:17:22 -0700 (PDT)
Received: from krzk-bin.. ([178.197.223.104])
        by smtp.gmail.com with ESMTPSA id h18-20020a5d5492000000b003142e438e8csm6779086wrv.26.2023.07.22.05.17.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Jul 2023 05:17:21 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v2 1/3] ARM: dts: samsung: exynos4x12: replace duplicate pmu node with phandle
Date:   Sat, 22 Jul 2023 14:17:17 +0200
Message-Id: <20230722121719.150094-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Devicetree for the FIMC IS camera included duplicated PMU node as its
child.  This is not a correct representation of the hardware.  Mapping
the PMU (Power Management Unit) IO memory should be via syscon-like
phandle (samsung,pmu-syscon, already used for other drivers), not by
duplicating "pmu" Devicetree node inside the FIMC IS.

The change is not compatible with older Linux kernel, which does not
parse samsung,pmu-syscon property.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Changes in v2:
1. None

Depends on:
https://lore.kernel.org/linux-devicetree/20230722115441.139628-1-krzysztof.kozlowski@linaro.org/T/#t
---
 arch/arm/boot/dts/samsung/exynos4x12.dtsi | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/samsung/exynos4x12.dtsi b/arch/arm/boot/dts/samsung/exynos4x12.dtsi
index 84c1db221c98..4524c1e6bb2f 100644
--- a/arch/arm/boot/dts/samsung/exynos4x12.dtsi
+++ b/arch/arm/boot/dts/samsung/exynos4x12.dtsi
@@ -516,15 +516,12 @@ fimc_is: fimc-is@12000000 {
 		iommus = <&sysmmu_fimc_isp>, <&sysmmu_fimc_drc>,
 			 <&sysmmu_fimc_fd>, <&sysmmu_fimc_mcuctl>;
 		iommu-names = "isp", "drc", "fd", "mcuctl";
+		samsung,pmu-syscon = <&pmu_system_controller>;
 		#address-cells = <1>;
 		#size-cells = <1>;
 		ranges;
 		status = "disabled";
 
-		pmu@10020000 {
-			reg = <0x10020000 0x3000>;
-		};
-
 		i2c1_isp: i2c-isp@12140000 {
 			compatible = "samsung,exynos4212-i2c-isp";
 			reg = <0x12140000 0x100>;
-- 
2.34.1

