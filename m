Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4A00761F7A
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 18:50:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231768AbjGYQuQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 12:50:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229827AbjGYQuG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 12:50:06 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 073332723
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 09:49:27 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id 4fb4d7f45d1cf-522294c0d5bso3556303a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 09:49:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690303762; x=1690908562;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h6+KlmxDDLwiObK04L7eIkif60/hmbr4y7H5N43zkSQ=;
        b=Ec8fAc2F2R2VjwOoOSvGKsIP9TUvH6qoejGJ/NjJFD+wpt3MU9l2Jv3xpbf33kS5RJ
         u163xdCrB8iPqdOh7tR7AA9sI1pzC6FwmUSdPPCAbsD24kuk5qrBui0xAWUfLRWSjIV+
         dZmu0TzZlqkFbL+C81em53kV+m2+MR73PdVJc1C8eFUe+TYQvsI34LYLOxAwjWqnjLb/
         mTH6Yx2vu6rmF0KsSCoMNWJBYB4rRf5M5QB5ENkQp4Cuqht+NPO/kip646TJOeRrxUKk
         K1Cds56lcDuYdipFMK2FZGxLcQofodlF90h08jJA4WV3m9bhAlJnreg3fu3/04rQOl0f
         eqFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690303762; x=1690908562;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h6+KlmxDDLwiObK04L7eIkif60/hmbr4y7H5N43zkSQ=;
        b=SsSIdh7wIyLAoX5InTEuJ3X66YskdGutjkBUzXUu0K3GFfzJTK5Cgn/VQdNX9CsQYU
         UjrsCB+zZ5cgP77yQyGpoOICyl/lC9GxbSeC/dE6YStQsvcFB7Og9WhXxkqXiND2pBB0
         nNRmZrWikn/zQBcVToJqAXJSNVpMMKj7LDgJ8pzQ/b+mdI12auTo4/34dmtBBWRAhc9i
         DY5MxukkJ9F1bsHNGzTJlFgFZ6+NxAH9kiRyUGzwY9gCPZjpk/NWNj2IaejU8Cxe0A8c
         3LHsjObn6LPzq7s98qISd1YYpQPobisAycVAzRyIRcv+K21xdUBaIMCi1kA7K9c11f4u
         gvIQ==
X-Gm-Message-State: ABy/qLayTWfi1c26BeQB5PwNjHcPE7fNEarjVL/FiS+pkLq1BLL0uxg4
        CDniN5ZS6Lq7+OhsGD+JerZg3g==
X-Google-Smtp-Source: APBJJlHsHWD2p7W1JW2oUWbXR0/kQ8G9r1fFfG9/qxiqymE8cUtKcqOD8jUhQqP5+iEj1idpkGVLVQ==
X-Received: by 2002:a17:907:763b:b0:98e:933:28fe with SMTP id jy27-20020a170907763b00b0098e093328femr12138908ejc.66.1690303762097;
        Tue, 25 Jul 2023 09:49:22 -0700 (PDT)
Received: from krzk-bin.. ([178.197.223.104])
        by smtp.gmail.com with ESMTPSA id a5-20020a170906274500b009932337747esm8379401ejd.86.2023.07.25.09.49.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jul 2023 09:49:21 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 2/2] ARM: dts: qcom: apq8060: drop incorrect regulator-type
Date:   Tue, 25 Jul 2023 18:49:17 +0200
Message-Id: <20230725164917.371714-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230725164917.371714-1-krzysztof.kozlowski@linaro.org>
References: <20230725164917.371714-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

regulator-fixed does not have a "regulator-type" property:

  qcom-apq8060-dragonboard.dtb: regulator-fixed: Unevaluated properties are not allowed ('regulator-type' was unexpected)

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm/boot/dts/qcom/qcom-apq8060-dragonboard.dts | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/boot/dts/qcom/qcom-apq8060-dragonboard.dts b/arch/arm/boot/dts/qcom/qcom-apq8060-dragonboard.dts
index db4c791b2e2f..569cbf0d8df8 100644
--- a/arch/arm/boot/dts/qcom/qcom-apq8060-dragonboard.dts
+++ b/arch/arm/boot/dts/qcom/qcom-apq8060-dragonboard.dts
@@ -24,7 +24,6 @@ vph: regulator-fixed {
 		regulator-min-microvolt = <3700000>;
 		regulator-max-microvolt = <3700000>;
 		regulator-name = "VPH";
-		regulator-type = "voltage";
 		regulator-always-on;
 		regulator-boot-on;
 	};
-- 
2.34.1

