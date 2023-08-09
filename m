Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03130775E6B
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 14:05:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232575AbjHIMEv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 08:04:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232460AbjHIMEs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 08:04:48 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07F8D1BCF
        for <linux-kernel@vger.kernel.org>; Wed,  9 Aug 2023 05:04:43 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-3fe2ba3e260so63551525e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 09 Aug 2023 05:04:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691582681; x=1692187481;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xkZCFzxfzDyKA7LYooj8Fy3ZdYlwwxLtlpox9Vb53IY=;
        b=vGUKZmEPBkDx/7F9lu/X34D2GA+UhZYWFjHqtsItOHwt2YfQrLz2q41JHEvRkqZNZj
         B2u6eo6WiOb6t7JEnOvQoPz3/UCYiNFnc+FJcNt5R1LvfDqjFd0TUrHcracY+GDrYHaf
         F2xjp893J6fQbB9Y7mF/w+01+kHiFHDrGa5iaGZtA6iBvFlNaRjRthGID6L1kVM1hBcD
         8bPMsaEKE4xi3vFz69x58Fxt717UFHZfZ7YdON6xwjO5O2J+y52EAJU4zC36fnQILNzo
         nqgmqdKoIXIkwKQhJRP0xTTLDh0z+NPRDxF+D3GIMHircdDajZLU7vCEIXhk7Eh6IjFM
         FMCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691582681; x=1692187481;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xkZCFzxfzDyKA7LYooj8Fy3ZdYlwwxLtlpox9Vb53IY=;
        b=Admm3L5KMqmv+KX/Lvik7nhkNS3SxcIG8DD/ZOd9qmFp9IDJUOYb581kNEoY4dS9Vx
         OA/gVOpiSGrHGKEsoeHCC/PQVGHzNVvpJ2LwL+tu5XhHV8WzcwMv6sIQy2Sm8OgX4XIl
         uG3Vd6kKpM6g3HbjtOiJoH1mNTzjsOA61kzZSl4KoCwckljgbztOGK3ONDMOtl/46gF6
         p7/vZyEE9ca3VbP+zq2rky51BznWi9YXfF3a1Ga0vOPo3BJm2qnpyFlzodpmftYWQoSQ
         Pm/vOg9PlmM4CvOqmsFiQTyLAQmDxJdbmzhqzniHctLBY7eDv8KAHAFQ8gNsdikegocq
         Oy4A==
X-Gm-Message-State: AOJu0YwgujARz05Ll6LqPtRGqSRSmyUhob6u0i5B17WnnvsY2Sc7t9hT
        lJqdsBk6tFLdWxKp5nyx8njp/w==
X-Google-Smtp-Source: AGHT+IFYk3DzbomQTzFpWN8TXzDHbS1k2DMgIJIU0zuU+RfqTFui2Yp7Igw+uTj52Fmz9QyZwR+b+g==
X-Received: by 2002:a05:600c:2811:b0:3f7:4961:52ad with SMTP id m17-20020a05600c281100b003f7496152admr2049176wmb.3.1691582681629;
        Wed, 09 Aug 2023 05:04:41 -0700 (PDT)
Received: from sagittarius-a.chello.ie (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id b13-20020a05600c11cd00b003fe1a96845bsm1808573wmi.2.2023.08.09.05.04.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Aug 2023 05:04:41 -0700 (PDT)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, loic.poulain@linaro.org, rfoss@kernel.org
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, bryan.odonoghue@linaro.org
Subject: [PATCH 4/7] arm64: dts: qcom: apq8016-sbc: Rename ov5640 enable-gpios to powerdown-gpios
Date:   Wed,  9 Aug 2023 13:04:29 +0100
Message-Id: <20230809120432.1036405-5-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230809120432.1036405-1-bryan.odonoghue@linaro.org>
References: <20230809120432.1036405-1-bryan.odonoghue@linaro.org>
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

There are two control lines controlled by GPIO going into ov5640

- Reset
- Powerdown

The driver and yaml expect "reset-gpios" and "powerdown-gpios" there has
never been an "enable-gpios".

Fixes: 39e0ce6cd1bf ("arm64: dts: qcom: apq8016-sbc: Add CCI/Sensor nodes")
Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
---
 arch/arm64/boot/dts/qcom/apq8016-sbc.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/apq8016-sbc.dts b/arch/arm64/boot/dts/qcom/apq8016-sbc.dts
index ada0777567623..ddb19709a9eee 100644
--- a/arch/arm64/boot/dts/qcom/apq8016-sbc.dts
+++ b/arch/arm64/boot/dts/qcom/apq8016-sbc.dts
@@ -273,7 +273,7 @@ camera_rear@3b {
 		compatible = "ovti,ov5640";
 		reg = <0x3b>;
 
-		enable-gpios = <&tlmm 34 GPIO_ACTIVE_HIGH>;
+		powerdown-gpios = <&tlmm 34 GPIO_ACTIVE_HIGH>;
 		reset-gpios = <&tlmm 35 GPIO_ACTIVE_LOW>;
 		pinctrl-names = "default";
 		pinctrl-0 = <&camera_rear_default>;
-- 
2.39.2

