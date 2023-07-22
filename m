Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3E9475DC33
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jul 2023 13:56:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230208AbjGVL44 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Jul 2023 07:56:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230223AbjGVL4v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jul 2023 07:56:51 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AC693C0D
        for <linux-kernel@vger.kernel.org>; Sat, 22 Jul 2023 04:56:30 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-3fbfa811667so23503215e9.1
        for <linux-kernel@vger.kernel.org>; Sat, 22 Jul 2023 04:56:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690026988; x=1690631788;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jx38YAgpp6hIi64Yp6dmi2Ukk67ZvJvPP+5Pl7scxe0=;
        b=STdBfm9+Ix8aU0/LpfmXkOsCFdEV/PThsfDm6CBgSDhfTfc5qHdp19fkQHB4HWhtR2
         ba+FWXnmkWvaLZOZ4wHE+0QuX0zJXgc1qenAzcMKY0W6xWgQVZ7qc88/KvZm8OurxdpV
         fcsb4oWcquMN4qFO3A0SuLkdUMBTRBURH/ftEEpWEV0lOu4TZX6uoL+jXAW/77D/xLMp
         EDKEhV10rMW9REFCr2Lwu0jrjfkue3dOLul3hTnGp1N01SGUYdb6brGXjZjrVRn9GtHE
         jWiMeUvblxq0GuW3ByI4oGluEtiqJIk246UI3hWJv6r7utyrcaxcOshWQQb/xVksdp0M
         j9eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690026988; x=1690631788;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jx38YAgpp6hIi64Yp6dmi2Ukk67ZvJvPP+5Pl7scxe0=;
        b=NJ/B8Id6NyAxN3nvAazo7iISCHq10B+Rx7h8uknRJbRGLzFXtDg0MRxIabBX0TvLPL
         g5plCVq0zygjbn7MW1Hs+KcmdGOoGM3ja1m2GHtufRrjgM+YUtI1DgThWJYvYL5WxpAn
         Zb41i1W3xzxr7ng6QfWbdhb4fFI6fbPIMC0qOomijV+nUT2kT72yv1L31PSF52166/XQ
         9fqJ0whD/oP/uiqBhPaQqOvNHGLtY4ZioP9gG/NXYIcRSkEK/rGGGkLJt1n4T2QJMYA9
         baXRzM2CyFwcH/pdnIrWDNTepkhfgR1l76kw6UMvvNDlZ5BygZl14oAYDt4W9GLP0KvO
         xtfQ==
X-Gm-Message-State: ABy/qLZIMHw+wOOJzi++msZVn93lPwT/zEWVHD1dZ+Zl0NbnbiEQBlCF
        sRZ8q2EYNem4h1iPMp0Dd8HEHg==
X-Google-Smtp-Source: APBJJlH2wxdhqpfxwFfsZe3/7Q4M5ZjqvxDZQv3rEbLOcDQxMxiCn47vrxpTMvZwclDTRlGTATvpcg==
X-Received: by 2002:a05:600c:1d8e:b0:3fb:ebe2:6f5f with SMTP id p14-20020a05600c1d8e00b003fbebe26f5fmr9682739wms.13.1690026988311;
        Sat, 22 Jul 2023 04:56:28 -0700 (PDT)
Received: from krzk-bin.. ([178.197.223.104])
        by smtp.gmail.com with ESMTPSA id f18-20020a7bc8d2000000b003fc01189b0dsm5242365wml.42.2023.07.22.04.56.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Jul 2023 04:56:26 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 1/2] ARM: dts: samsung: exynos4x12: replace duplicate pmu node with phandle
Date:   Sat, 22 Jul 2023 13:56:17 +0200
Message-Id: <20230722115618.140002-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
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

