Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DF097E8BA9
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Nov 2023 17:42:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231334AbjKKQmj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Nov 2023 11:42:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229797AbjKKQmi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Nov 2023 11:42:38 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 419482590
        for <linux-kernel@vger.kernel.org>; Sat, 11 Nov 2023 08:42:34 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id 4fb4d7f45d1cf-540c54944c4so6225569a12.1
        for <linux-kernel@vger.kernel.org>; Sat, 11 Nov 2023 08:42:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1699720952; x=1700325752; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=M3dLnnrtnCRPaf3PcG0X+1LuRdRy0oyYETAOWAbZ9EE=;
        b=ZjbZDaM8HR8PDVucdTZvHSFRL9VDD1C7HRquF2Qj+FhZuXBgIsL4cKvrMAdSLra+vh
         7ARNwnZ8rPpuGA6NDssBlzxZBITmKlU0G4NE4NZsawyxqIYU2xCGJrpNCwb+HmXK9EtM
         gQizzm270HJNF8IewSs9Ru0T8DAQ2KBCGCKeXs127ynfoIn0XawWZtiuKOYDKlBM10GY
         AQbwFzFbQME0sZnkQTq93tb/bvgvHeYQl5rIY37e7EvgZTxoeti+RMTG3+KN12ropa+s
         xclm+zHZXQyJ7A80KBA4OAUnbG0l3wNJSRwIT/4A+vA6PYC03Cic1R4DYPa7QBR6gYZp
         8XbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699720952; x=1700325752;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=M3dLnnrtnCRPaf3PcG0X+1LuRdRy0oyYETAOWAbZ9EE=;
        b=v++3Lh+pqAED0lquAvSoyr4Zq83JS/KoDUhjMt27ZitShuYL6xRXopD+59x+OGkF7J
         9XrWEP7USa9J6vzRWqbCt2KiuWxs2JwziOXfyKY5mz8s2SQrhw6mRsC/cnQTVpHkOv/2
         pvp9HAn4XXwxeY70whHUMTLn9ZVmmF9Cb3DYfvRRjbbyHgR6jwaEP6+lWPBQygd+Y9Fx
         fWQ1Jel0dFOykHoJ4JSfpEeBVrpTAk2+hoMxHOuh9EiL0CrTZ7DhgaBoxWXc9aHlQkwX
         IDRe6nuBfBIRl1piF6+StCypsrxSkqUptX1XMFWDbas4cjZrzWqRcxYp6Y5GrxDA8Dti
         Khiw==
X-Gm-Message-State: AOJu0YwVyNx4+Xh/OhovRultxDQAjH+pLx4WfIHQol/qNjbWr6i4/uN7
        ej6gyNuv3zebYrIbw6gyiFt+xQ==
X-Google-Smtp-Source: AGHT+IF1jpsrjM3UtSpzuw6TRcBT2uCV+U/eErKJq07Q/dmAe0neXPiNoW/uDvwD3AvZA3KvBK3goA==
X-Received: by 2002:a05:6402:430f:b0:544:4a91:a30b with SMTP id m15-20020a056402430f00b005444a91a30bmr2299104edc.21.1699720952500;
        Sat, 11 Nov 2023 08:42:32 -0800 (PST)
Received: from krzk-bin.. ([178.197.218.126])
        by smtp.gmail.com with ESMTPSA id k25-20020aa7c059000000b0053dd8898f75sm1161917edo.81.2023.11.11.08.42.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Nov 2023 08:42:32 -0800 (PST)
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
Subject: [PATCH 1/6] arm64: dts: qcom: sc8180x-flex-5g: use 'gpios' suffix for PCI GPIOs
Date:   Sat, 11 Nov 2023 17:42:24 +0100
Message-Id: <20231111164229.63803-1-krzysztof.kozlowski@linaro.org>
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

Linux handles both versions, but bindings expect GPIO properties to
have 'gpios' suffix instead of 'gpio':

  sc8180x-lenovo-flex-5g.dtb: pci@1c08000: Unevaluated properties are not allowed ('perst-gpio', 'wake-gpio' were unexpected)

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm64/boot/dts/qcom/sc8180x-lenovo-flex-5g.dts | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sc8180x-lenovo-flex-5g.dts b/arch/arm64/boot/dts/qcom/sc8180x-lenovo-flex-5g.dts
index 3ea07d094b60..0c22f3efec20 100644
--- a/arch/arm64/boot/dts/qcom/sc8180x-lenovo-flex-5g.dts
+++ b/arch/arm64/boot/dts/qcom/sc8180x-lenovo-flex-5g.dts
@@ -452,8 +452,8 @@ mdss_edp_out: endpoint {
 };
 
 &pcie3 {
-	perst-gpio = <&tlmm 178 GPIO_ACTIVE_LOW>;
-	wake-gpio = <&tlmm 180 GPIO_ACTIVE_HIGH>;
+	perst-gpios = <&tlmm 178 GPIO_ACTIVE_LOW>;
+	wake-gpios = <&tlmm 180 GPIO_ACTIVE_HIGH>;
 	pinctrl-0 = <&pcie3_default_state>;
 	pinctrl-names = "default";
 
-- 
2.34.1

