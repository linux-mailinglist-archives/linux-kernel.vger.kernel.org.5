Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5161580B587
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Dec 2023 18:31:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230208AbjLIRat (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Dec 2023 12:30:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229705AbjLIRaq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Dec 2023 12:30:46 -0500
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA6A010E6
        for <linux-kernel@vger.kernel.org>; Sat,  9 Dec 2023 09:30:50 -0800 (PST)
Received: by mail-lj1-x234.google.com with SMTP id 38308e7fff4ca-2ca0c36f5beso39378661fa.1
        for <linux-kernel@vger.kernel.org>; Sat, 09 Dec 2023 09:30:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702143049; x=1702747849; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZGxNyInPX1FnWv8EFnzseBq2mTwZXauB1MxLYzgPaVA=;
        b=fN+MLyubHaJawA+6R3EICEVv/7KUz/P5uGO1mjqSpyw8OR9IsfHpKyDFilMxTsgDcA
         YOmkpLBwjkG35UNbAUfuI2Xoz8uIIykFZtiG4mEVGuMwXVfqPbu9kR2fbwJuGvUFHniw
         /XPdhEHWsxu+QUhgsN0+wSVVIFzvakMZse31fSAq2+xo92CvWaRk+t/89ptnDJvSOlt7
         lLRVltkgbYZFf/yDeIPzO2Sfrt2efeccs/7HkCkBYKVhpbA4sP3+P7NO8tQ8sa4BpI0v
         En/DzT+a+KEaBKV4LMTaCCz4mtMw25gAkDVZbFEJkXgDcvo5CJU+1DETg1zHV+JYCezl
         fbjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702143049; x=1702747849;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZGxNyInPX1FnWv8EFnzseBq2mTwZXauB1MxLYzgPaVA=;
        b=IHjYtCV8sq2CWrFhJ7OabA+w/S44UORa4Gh/9pEy9+O4hiEQNZ4dabMzOBvb/CvPm9
         J4NxMsFRWupAKqsSb5kw+KcK0JbzrD8NL1u7HgZ6oFB2dVXbw6iN/d37/EYaFFKx5A4J
         8DP81vk0p4IVFo2prjXzSgAqDULTN+Jlbq7/anyCfO3LjJXR5plFnrmywIWM/iKZw46k
         7x47cdzsOoHLieilvWdInhBp3G5puM7nlrY9gH6HIuCQiVBG2W3yY2ZLFu8ES3I4cVIl
         NUgfMA2kGoaExrYpL8Jl3IizuRgXCqwauUACwXOEpUkDv7WeJvVtI9g1RpEAMF2QHHba
         zjSw==
X-Gm-Message-State: AOJu0Yyczx4jKsyTIexplPXNi2iHtI7RZVRt2IbJ4C9sPlhRM5+ACsJ/
        NvLDrvbasfx2Oc+ZDcDOIWnRqw==
X-Google-Smtp-Source: AGHT+IGySQvOJT4d+bavrxMPm6g2MuiNYfbCA9x14FdEX50mgGtZpw9szmA1Uo+64KQmfOoK3MUyJQ==
X-Received: by 2002:a05:6512:693:b0:50b:b9c7:9f3d with SMTP id t19-20020a056512069300b0050bb9c79f3dmr1126978lfe.21.1702143048967;
        Sat, 09 Dec 2023 09:30:48 -0800 (PST)
Received: from krzk-bin.. ([178.197.218.27])
        by smtp.gmail.com with ESMTPSA id m26-20020a50931a000000b0054ce5c00e74sm1926621eda.88.2023.12.09.09.30.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Dec 2023 09:30:48 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Dinh Nguyen <dinguyen@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 02/15] ARM: dts: socfpga: align NAND controller name with bindings
Date:   Sat,  9 Dec 2023 18:30:31 +0100
Message-Id: <20231209173044.257684-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231209173044.257684-1-krzysztof.kozlowski@linaro.org>
References: <20231209173044.257684-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Bindings expect NAND controller node name to match certain patterns:

  socfpga_arria10_socdk_nand.dtb: nand@ffb90000: $nodename:0: 'nand@ffb90000' does not match '^nand-controller(@.*)?'

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm/boot/dts/intel/socfpga/socfpga.dtsi         | 2 +-
 arch/arm/boot/dts/intel/socfpga/socfpga_arria10.dtsi | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/intel/socfpga/socfpga.dtsi b/arch/arm/boot/dts/intel/socfpga/socfpga.dtsi
index 4c1d140f40f8..35be14150f41 100644
--- a/arch/arm/boot/dts/intel/socfpga/socfpga.dtsi
+++ b/arch/arm/boot/dts/intel/socfpga/socfpga.dtsi
@@ -768,7 +768,7 @@ mmc: mmc@ff704000 {
 			status = "disabled";
 		};
 
-		nand0: nand@ff900000 {
+		nand0: nand-controller@ff900000 {
 			#address-cells = <0x1>;
 			#size-cells = <0x0>;
 			compatible = "altr,socfpga-denali-nand";
diff --git a/arch/arm/boot/dts/intel/socfpga/socfpga_arria10.dtsi b/arch/arm/boot/dts/intel/socfpga/socfpga_arria10.dtsi
index f36063c57c7f..6b6e77596ffa 100644
--- a/arch/arm/boot/dts/intel/socfpga/socfpga_arria10.dtsi
+++ b/arch/arm/boot/dts/intel/socfpga/socfpga_arria10.dtsi
@@ -669,7 +669,7 @@ mmc: mmc@ff808000 {
 			status = "disabled";
 		};
 
-		nand: nand@ffb90000 {
+		nand: nand-controller@ffb90000 {
 			#address-cells = <1>;
 			#size-cells = <0>;
 			compatible = "altr,socfpga-denali-nand";
-- 
2.34.1

