Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0B9980B586
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Dec 2023 18:31:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230329AbjLIRav (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Dec 2023 12:30:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229940AbjLIRaq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Dec 2023 12:30:46 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1125710EF
        for <linux-kernel@vger.kernel.org>; Sat,  9 Dec 2023 09:30:52 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id 4fb4d7f45d1cf-54c846da5e9so2872106a12.3
        for <linux-kernel@vger.kernel.org>; Sat, 09 Dec 2023 09:30:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702143050; x=1702747850; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=odIvNtZz2+W6QtJ0gN2cO/QgHPmyDySPgMwRvoCZPPs=;
        b=WpKIjhsVMUSZM//kWPKoNZjJCv2/kFUu/jgmNhm3fti7K5Gisf8aXvo11WADv7e0HD
         UAOzQ0l/5sGzB+llheIj7FPaC2X+zMvupEkeyBahia6DflNz9PFS+61StRHhZ4Ok1rdz
         2C9f5TWO79KRJNsP2KXcPX8ZIIT/BKkjdPxUR88eLhvW7NbQXrqO5n8is3VyxdfI4EJG
         eYVvDMMFYISrYXKqpE0Q5XCg/r4B/6U6Ca3Lf0Y2vnDeieaxt3dq46LS/vgKpKV5wjGs
         BhOQk/RXONQkd6KQPC3dbiBDLJNXAElMq8t9iUOlVGp8GOrSI6sA5keqew21Po/8N4Tu
         NGTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702143050; x=1702747850;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=odIvNtZz2+W6QtJ0gN2cO/QgHPmyDySPgMwRvoCZPPs=;
        b=rP5ydOsvNEWAZyNlCWUEKwQbQtZenD3eav6GJfgB//l9co/lOy2NYlue7bR0RqI3Ps
         rgNGmFH6EfILu4yTDmhz+hrx8gqhxzZ1Esxp8SsWuVr4O9+WiMafHZb7Nf8UwJl5du87
         avATB1oS6BDFR7BqOSm1q/7pSWbUAk4/S3G/rBwv1j8G4WpTPktoCTHXVtRkaY/sXG8l
         bbyOwzX5HfE/iuYbDx9wE8UZDqsKsREux/ptBr9klywx/89fnVJe95sUYRTyVHWKi1P8
         EdzJYqVcTsHx0u+7J7/ITahWGX92nlZdbJCV8WTqqdGeboDmiY4GSb/w0OwUDFRNRJmP
         /Ynw==
X-Gm-Message-State: AOJu0YzYiuijhKpxf6k8J6IzeujCb0YMdAIegLOotIcjtovogED+Wabp
        Z5zbAMSm4BS1LmGwvyDZbJIBvo7pEFsUH/dgnoY=
X-Google-Smtp-Source: AGHT+IF2+IkXsSW6NcOhSwKYS9POYcBs9J/eYVF9/uXoVy0i9LJZlis/tJHQhNI7t0k55cJ8L9YsjA==
X-Received: by 2002:aa7:c50e:0:b0:54c:4837:903d with SMTP id o14-20020aa7c50e000000b0054c4837903dmr1202957edq.53.1702143050613;
        Sat, 09 Dec 2023 09:30:50 -0800 (PST)
Received: from krzk-bin.. ([178.197.218.27])
        by smtp.gmail.com with ESMTPSA id m26-20020a50931a000000b0054ce5c00e74sm1926621eda.88.2023.12.09.09.30.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Dec 2023 09:30:50 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Dinh Nguyen <dinguyen@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 03/15] arm64: dts: socfpga: drop unsupported cdns,page-size and cdns,block-size
Date:   Sat,  9 Dec 2023 18:30:32 +0100
Message-Id: <20231209173044.257684-3-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231209173044.257684-1-krzysztof.kozlowski@linaro.org>
References: <20231209173044.257684-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

cdns,page-size and cdns,block-size are neither documented nor used by
Linux, so remove them to fix dtbs_check warnings like:

  socfpga_n5x_socdk.dtb: flash@0: Unevaluated properties are not allowed ('cdns,block-size', 'cdns,page-size' were unexpected)

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm64/boot/dts/altera/socfpga_stratix10_socdk.dts      | 2 --
 arch/arm64/boot/dts/altera/socfpga_stratix10_socdk_nand.dts | 2 --
 arch/arm64/boot/dts/intel/socfpga_agilex_socdk.dts          | 2 --
 arch/arm64/boot/dts/intel/socfpga_n5x_socdk.dts             | 2 --
 4 files changed, 8 deletions(-)

diff --git a/arch/arm64/boot/dts/altera/socfpga_stratix10_socdk.dts b/arch/arm64/boot/dts/altera/socfpga_stratix10_socdk.dts
index 468fcc7da066..347fd1d949fa 100644
--- a/arch/arm64/boot/dts/altera/socfpga_stratix10_socdk.dts
+++ b/arch/arm64/boot/dts/altera/socfpga_stratix10_socdk.dts
@@ -187,8 +187,6 @@ flash@0 {
 		spi-max-frequency = <100000000>;
 
 		m25p,fast-read;
-		cdns,page-size = <256>;
-		cdns,block-size = <16>;
 		cdns,read-delay = <1>;
 		cdns,tshsl-ns = <50>;
 		cdns,tsd2d-ns = <50>;
diff --git a/arch/arm64/boot/dts/altera/socfpga_stratix10_socdk_nand.dts b/arch/arm64/boot/dts/altera/socfpga_stratix10_socdk_nand.dts
index 532164a6354c..4e73e6656d72 100644
--- a/arch/arm64/boot/dts/altera/socfpga_stratix10_socdk_nand.dts
+++ b/arch/arm64/boot/dts/altera/socfpga_stratix10_socdk_nand.dts
@@ -176,8 +176,6 @@ flash@0 {
 		spi-max-frequency = <100000000>;
 
 		m25p,fast-read;
-		cdns,page-size = <256>;
-		cdns,block-size = <16>;
 		cdns,read-delay = <1>;
 		cdns,tshsl-ns = <50>;
 		cdns,tsd2d-ns = <50>;
diff --git a/arch/arm64/boot/dts/intel/socfpga_agilex_socdk.dts b/arch/arm64/boot/dts/intel/socfpga_agilex_socdk.dts
index 053690657675..ad99aefeb185 100644
--- a/arch/arm64/boot/dts/intel/socfpga_agilex_socdk.dts
+++ b/arch/arm64/boot/dts/intel/socfpga_agilex_socdk.dts
@@ -113,8 +113,6 @@ flash@0 {
 		spi-max-frequency = <100000000>;
 
 		m25p,fast-read;
-		cdns,page-size = <256>;
-		cdns,block-size = <16>;
 		cdns,read-delay = <2>;
 		cdns,tshsl-ns = <50>;
 		cdns,tsd2d-ns = <50>;
diff --git a/arch/arm64/boot/dts/intel/socfpga_n5x_socdk.dts b/arch/arm64/boot/dts/intel/socfpga_n5x_socdk.dts
index 5ddfdff37c25..de82a552dc26 100644
--- a/arch/arm64/boot/dts/intel/socfpga_n5x_socdk.dts
+++ b/arch/arm64/boot/dts/intel/socfpga_n5x_socdk.dts
@@ -91,8 +91,6 @@ flash@0 {
 		spi-max-frequency = <100000000>;
 
 		m25p,fast-read;
-		cdns,page-size = <256>;
-		cdns,block-size = <16>;
 		cdns,read-delay = <2>;
 		cdns,tshsl-ns = <50>;
 		cdns,tsd2d-ns = <50>;
-- 
2.34.1

