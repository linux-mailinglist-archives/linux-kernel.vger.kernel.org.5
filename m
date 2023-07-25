Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EDB0761B9E
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 16:27:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232973AbjGYO1o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 10:27:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232963AbjGYO1Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 10:27:25 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 283E430E2
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 07:27:01 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id 4fb4d7f45d1cf-5221c6a2d3dso4886850a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 07:27:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690295216; x=1690900016;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dir5ASEzokI/ZeilxDTBS8n6gA6CsuFHZnaxq4/wl6M=;
        b=r9xLV8JZTKNkopGscUtG9DGZVqCxNN4NQ6oL65+fXXMbN0BTyKFozdIYiYbiR/6ZBS
         LNrfbTQ4jlvQxlmm0p5q8zXXv8V49fareFoCUiIk9cA1OcBGcealr+TYouFyQsT5FdPH
         WifzhfN+d8kGzXjGon8pVqTqK7DW6EI2CvzibuwVHAEVEuxCFZQQNaLlSse2LHH7KdRz
         vQCVsZnvqeZ8ITVVxQ4I2V8BQh4r1J+NdAk4jFbBSuVe43c6BvCRfUsp36VtJhU7p6eW
         Zb+6i5NQQ6JdmbpwWySUH7oP1wfgop2Ur0b6cpMEmh2JNKoLK/e4nC4GthkiZq4U9D8s
         fieA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690295216; x=1690900016;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dir5ASEzokI/ZeilxDTBS8n6gA6CsuFHZnaxq4/wl6M=;
        b=hxT/joZbQUtZgt/fUjyewhBNnUOFLA+Yk+XB4DAWGRPPU/TZpEyzFYvNfSpXLKAiY+
         5Pisxo8ExWGZcexuEZ0AAxJoCS7FUVm6Fl6jDeEm1q+0wJWFuBiqOrZqJaVW3TzSlrCR
         F1YWUysa6ImUXhL5EdXeqmw8t7H1Puf1Sm9WeLI3lCo5LVgYPl1TT/tgjzG6uVCF8kLW
         HqjnaxAlS6bHqK3MoVxBZIkb1OdtvfVqKaEJxc19ug62ApVgpeHtXz1q3QbmkwQyllj1
         1XJkqRSXRNTBJocZmScal388W7MkLaolVH3RjOaDzLeRvNVgwlU6MTW1Md/Z87GarzA+
         kNoA==
X-Gm-Message-State: ABy/qLZc/dIHJRkBhyOSZBBz5vQ+Enu7GiSCnIkln2HSFlWIKCZrpgwg
        7Y+DuW1htLWPhKPepZ0+eu8ISaggijopvvTiOao=
X-Google-Smtp-Source: APBJJlGiFCRzZ75vlxh1hZXLQh7rY2Rxx/PIlRUl13ZbMn6/H1lrVgZLlwjP2XyNt1mXp78KM30UaA==
X-Received: by 2002:a05:6402:14c:b0:522:1cec:ca9f with SMTP id s12-20020a056402014c00b005221cecca9fmr8757091edu.19.1690295216389;
        Tue, 25 Jul 2023 07:26:56 -0700 (PDT)
Received: from krzk-bin.. ([178.197.223.104])
        by smtp.gmail.com with ESMTPSA id r7-20020aa7da07000000b005222aee9ef9sm3315262eds.97.2023.07.25.07.26.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jul 2023 07:26:55 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] arm64: dts: imx8mm-phycore: drop uncorrect vselect-en
Date:   Tue, 25 Jul 2023 16:26:53 +0200
Message-Id: <20230725142653.157510-1-krzysztof.kozlowski@linaro.org>
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

There is no "vselect-en" property, neither in the bindings nor in the
Linux driver:

  imx8mm-phyboard-polis-rdk.dtb: pmic@8: regulators:ldo2: Unevaluated properties are not allowed ('vselect-en' was unexpected)

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm64/boot/dts/freescale/imx8mm-phycore-som.dtsi | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mm-phycore-som.dtsi b/arch/arm64/boot/dts/freescale/imx8mm-phycore-som.dtsi
index 404f7de0b722..6069678244f3 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm-phycore-som.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mm-phycore-som.dtsi
@@ -151,7 +151,6 @@ reg_nvcc_sd2: ldo2 {
 				regulator-max-microvolt = <3300000>;
 				regulator-min-microvolt = <1800000>;
 				regulator-name = "NVCC_SD2 (LDO2)";
-				vselect-en;
 
 				regulator-state-mem {
 					regulator-off-in-suspend;
-- 
2.34.1

