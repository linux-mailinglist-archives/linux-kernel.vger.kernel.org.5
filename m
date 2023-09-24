Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 427CE7ACB70
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Sep 2023 20:39:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230359AbjIXSj3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Sep 2023 14:39:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229993AbjIXSj2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Sep 2023 14:39:28 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B112FC
        for <linux-kernel@vger.kernel.org>; Sun, 24 Sep 2023 11:39:21 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-405361bb93bso47622805e9.3
        for <linux-kernel@vger.kernel.org>; Sun, 24 Sep 2023 11:39:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1695580760; x=1696185560; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JDWHB1WKJQ9UFWx5zu1gEgL+1FlRAm4HOBKXObVJBnQ=;
        b=KHC2DOjjNA2wvZS9Sp2plgOMI65CJsThYamDBoXK0H5FX2Msj+ps8o1sKG6DkHc4FA
         OOCWDtigds6Waaw2zdnE6ME3uQRSNV0ENqByL40ctCNQECCEeqtIRYNQxZcrGCTNI+dj
         7iOFUoe86jXoNpXS08yEuRFKoMaFoj/oQSAd9BD+ZLBXNe0gw3TC9ht8GkD99gYTs8XT
         US2yvIxfrCZXY9EXcfKT6TrGvhNEt+MRS0Iw1oVLQc/eXQsC8vfGwzZlIVYIjr4xfTUa
         nhG/KUtXNeRady7TOKbXRuakaFUtjIKz1ue7YzqN2xe4ng8YtehrzOT+bTYqdD+9qZSL
         EAQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695580760; x=1696185560;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JDWHB1WKJQ9UFWx5zu1gEgL+1FlRAm4HOBKXObVJBnQ=;
        b=cOLUPq7lKglj+dX8Q9UA/IQbueyKDiSXxfELQM0mXFZjA3eW+0VBv613J6oJbqigj6
         ECt7j5n3/YShG2dFCQdS2untI9s1aVRYz1pRhGXEp7Cqu+laSzYKFqncbBZ5Yg6bdxMt
         m8I5PjfzirK9Awr1vFLZcm+G8qI402Pjel1cRBJ2T8C1xmozKBrGwsa+6657jauh6vmS
         ZixL/BlYE0IZ/+I8IbyN5vNm7TVlyt5J0ZZYSIBkdqeQpmesjuXUK5HRxv+d/qeNSZtM
         39iZsCjsE3GcvkLIxBtagvw5j+dKhTyDl197+lzYcP3Ix+rwA5x5i23t3Rjz0N4NDjO7
         bU+A==
X-Gm-Message-State: AOJu0Yw48dtA17CBEriHZCYtwsXzrNP1cCoMa3A/jIgd3aAsOyXI7WeX
        qhXi3uBzz86azTt/knTHidheKw==
X-Google-Smtp-Source: AGHT+IHv+nx/rJB1OOKnIvD0oA5UGq4NPuXVJ4tt3A6W7gZQko10kjhseLnqn9343D7X11Tc1jeFcg==
X-Received: by 2002:a05:600c:289:b0:401:bf87:9898 with SMTP id 9-20020a05600c028900b00401bf879898mr4498038wmk.25.1695580759930;
        Sun, 24 Sep 2023 11:39:19 -0700 (PDT)
Received: from krzk-bin.. ([178.197.219.100])
        by smtp.gmail.com with ESMTPSA id v20-20020a05600c215400b00401b242e2e6sm7570446wml.47.2023.09.24.11.39.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Sep 2023 11:39:19 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Stephen Boyd <sboyd@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [RESEND PATCH 2/4] ARM: dts: qcom: apq8060: drop incorrect regulator-type
Date:   Sun, 24 Sep 2023 20:39:12 +0200
Message-Id: <20230924183914.51414-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230924183914.51414-1-krzysztof.kozlowski@linaro.org>
References: <20230924183914.51414-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

regulator-fixed does not have a "regulator-type" property:

  qcom-apq8060-dragonboard.dtb: regulator-fixed: Unevaluated properties are not allowed ('regulator-type' was unexpected)

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
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

