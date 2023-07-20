Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1361475AD73
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 13:53:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229935AbjGTLxq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 07:53:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230117AbjGTLxo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 07:53:44 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBEEE10F5
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 04:53:42 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id 4fb4d7f45d1cf-51e56749750so976097a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 04:53:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689854021; x=1690458821;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9zv3NEyTv/sIWt+P+tyiutXqEyfEP11M8lzbpoLr9S4=;
        b=b5UjOwNWH8q6XNidDQUOK+VFlwFgx8SSSB002a660nFo1vm0X8Ane0+FkIsCc0Y9qr
         5OFaqc9M25jWBn2W5Y6kma6nK/Y8y/nTph++jPtOEPfmWDohwER2/CWEZJRGxVtNVtjo
         ErmUoODA4cDRHK4ZR9VNunLGe0oLd9vzfxqN/Z39pHWrDkC/Q6WYSoBmV1So/QlK0N2c
         wbpAaqi7aZP/VkrSsTpQ3PlDRr4IRFwfJQL+sl//v5fVIczXIu74BCuTX/NlL9WRuQhW
         grMiUpawC7RSr/o8qjjqUZuMga7RBdr59wooHaldQ+fdz9LNP+Sg6S0rOi624Qo91s8l
         dl7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689854021; x=1690458821;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9zv3NEyTv/sIWt+P+tyiutXqEyfEP11M8lzbpoLr9S4=;
        b=DifHQEJmLqtqyfDTjoxU6vcvseFssWWefzwl3HAXvDfHhz+0sWnQlvbIHXt38fIbS+
         zaykV2/UecI4bdZaLq3w6iLvD6p64Gb6bzJ+IPnmxSnszZVrSgSASveRMRemC3c69R7+
         H5DK78HTgy+92s5EIKx5DXzdGr/I/l3269zIss1DiCs0vopJdRFLzGOBxuDUieGx90sV
         WYkgSse5nFHxB3S4/MTCo0n6BkdH3DX7DzJ7tSdttmB23ViKQEgpONTfKIMV5H+hPs1O
         H3LRIsGjWrCASAkRgcjFPtFrKxD8SBpd3prIf2Lh/zezKWVSvfAZ5uX6CIRs5Vj8bl9t
         y3kQ==
X-Gm-Message-State: ABy/qLbT6crb3aukyFIwzPXBqDqCVKidHHfp6UAklOYAHBu+ukXMnBV+
        lo0HUWv4pQmmsq/T5nq7UBSsxw==
X-Google-Smtp-Source: APBJJlFo4zbY3+oFzEcpRo4j+d47AIaUmL6H0iWkXBwKqraWjeo+4qRbXWA6/+osF0Cs6/mnXjOktw==
X-Received: by 2002:a17:907:728f:b0:994:17e3:2753 with SMTP id dt15-20020a170907728f00b0099417e32753mr6179665ejc.26.1689854021367;
        Thu, 20 Jul 2023 04:53:41 -0700 (PDT)
Received: from krzk-bin.. ([178.197.223.104])
        by smtp.gmail.com with ESMTPSA id qp7-20020a170907206700b00992b66e54e9sm587758ejb.214.2023.07.20.04.53.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jul 2023 04:53:40 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Gianluca Boiano <morf3089@gmail.com>,
        Eugene Lepshy <fekz115@gmail.com>, Luca Weiss <luca@z3ntu.xyz>,
        Yassine Oudjana <y.oudjana@protonmail.com>,
        Raffaele Tranquillini <raffaele.tranquillini@gmail.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 2/6] arm64: dts: qcom: msm8996-gemini: fix touchscreen VIO supply
Date:   Thu, 20 Jul 2023 13:53:31 +0200
Message-Id: <20230720115335.137354-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230720115335.137354-1-krzysztof.kozlowski@linaro.org>
References: <20230720115335.137354-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

According to bindings and Linux driver, there is no VDDA but VIO supply.

Fixes: 4ac46b3682c5 ("arm64: dts: qcom: msm8996: xiaomi-gemini: Add support for Xiaomi Mi 5")
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm64/boot/dts/qcom/msm8996-xiaomi-gemini.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/msm8996-xiaomi-gemini.dts b/arch/arm64/boot/dts/qcom/msm8996-xiaomi-gemini.dts
index bdedcf9dff03..d1066edaea47 100644
--- a/arch/arm64/boot/dts/qcom/msm8996-xiaomi-gemini.dts
+++ b/arch/arm64/boot/dts/qcom/msm8996-xiaomi-gemini.dts
@@ -82,7 +82,7 @@ synaptics@20 {
 		#size-cells = <0>;
 		interrupt-parent = <&tlmm>;
 		interrupts = <125 IRQ_TYPE_LEVEL_LOW>;
-		vdda-supply = <&vreg_l6a_1p8>;
+		vio-supply = <&vreg_l6a_1p8>;
 		vdd-supply = <&vdd_3v2_tp>;
 		reset-gpios = <&tlmm 89 GPIO_ACTIVE_LOW>;
 
-- 
2.34.1

