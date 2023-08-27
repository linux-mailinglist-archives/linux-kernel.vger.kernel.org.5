Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3873789DCD
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Aug 2023 14:16:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229753AbjH0MPj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Aug 2023 08:15:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229683AbjH0MPH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Aug 2023 08:15:07 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94A8C186
        for <linux-kernel@vger.kernel.org>; Sun, 27 Aug 2023 05:15:04 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id 4fb4d7f45d1cf-51e28cac164so6892342a12.1
        for <linux-kernel@vger.kernel.org>; Sun, 27 Aug 2023 05:15:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693138502; x=1693743302;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nL00MkR7LeahzMDUv+0Kc99z+1SowEYeDRlQjwoP8ws=;
        b=glZdThQj3GUhm6yRWkpKmXv8rdIV58JZJXhJWsdfao+aJXMyt9EWSNYRZYQvorLYBF
         lGJj4exN4qs6+0z9eeRX6fDoszliok2gvc6bTTiklULpfJYKgLR5kRGp/wimeyCmSCe3
         /jIoD4vDd2RLOx5rcbD4h299yQiOrvihdW2lLmMAWXt81zaCxwGUyO4Fnbkkv2YOT8T/
         Ahrg8YTsv/hs1ZH8z/q+355Xc/7BmPi/Y2CNYQMSw8YK3H8kI28fO7AEkqnxBS4r2yse
         iGW6Tc37Ikj/h4anayDF7r6i9kFHSELfb9d1DtTs2Fy0cGSQFeO3Jd8Eue+DC3Ul7Lui
         EMiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693138502; x=1693743302;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nL00MkR7LeahzMDUv+0Kc99z+1SowEYeDRlQjwoP8ws=;
        b=MX1G3EWzgnoi//fqmaqgFn2ZnP/SL6qsuYnT90wzf7FDS0quJR8OLDMw3zZv1jUARM
         /7iPMRtOByXsuIKuQB11vY9Vip/G4jUSc2CusakfK9GV2+h+8jtx+wrtklFE2l+o8tRv
         Bhh+J3kN2eiVr4vUEDt6/6KrRDxalWh10i1CM45tc8YLZv15G9NUfQDq67gc8AVNFpYz
         IqW6J7g7XZCpHSyS85zWugMkuLxp5lG8cQthMy8i1CiZ14fHeUcBhN4tNjeQv/7BslML
         QnLPjzZbIqySepkJzlKsYwgxmUCi0gakefGzMyjbTFRZr3qPMEQpKGAvfaEKaLHYgCm1
         yFug==
X-Gm-Message-State: AOJu0YyP2rLZ0FikIOtyXVAuKf4XlsDjvVarN+jDi8IFm3JKk48vNVUP
        XXFajuYX7kY7eHdqnJVWrQvLfQ==
X-Google-Smtp-Source: AGHT+IHJk50T0YOAxhoYaNypDAGvnuDOj7ZbUgBV4kxxaM6gDB6JHuiu6sxSQekum+voYE+n6xrJcQ==
X-Received: by 2002:aa7:db47:0:b0:523:b37e:b83b with SMTP id n7-20020aa7db47000000b00523b37eb83bmr24339093edt.13.1693138502090;
        Sun, 27 Aug 2023 05:15:02 -0700 (PDT)
Received: from krzk-bin.. ([77.252.47.225])
        by smtp.gmail.com with ESMTPSA id b14-20020a05640202ce00b00522572f323dsm3247656edx.16.2023.08.27.05.15.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Aug 2023 05:15:01 -0700 (PDT)
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
Subject: [PATCH] ARM: dts: qcom: sdx65: correct SPMI node name
Date:   Sun, 27 Aug 2023 14:14:59 +0200
Message-Id: <20230827121459.62539-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
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

Node names should not have vendor prefixes:

  qcom-sdx65-mtp.dtb: qcom,spmi@c440000: $nodename:0: 'qcom,spmi@c440000' does not match '^spmi@.*

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm/boot/dts/qcom/qcom-sdx65.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/qcom/qcom-sdx65.dtsi b/arch/arm/boot/dts/qcom/qcom-sdx65.dtsi
index 58635bbc1123..ff596215ae3c 100644
--- a/arch/arm/boot/dts/qcom/qcom-sdx65.dtsi
+++ b/arch/arm/boot/dts/qcom/qcom-sdx65.dtsi
@@ -537,7 +537,7 @@ restart@c264000 {
 			reg = <0x0c264000 0x1000>;
 		};
 
-		spmi_bus: qcom,spmi@c440000 {
+		spmi_bus: spmi@c440000 {
 			compatible = "qcom,spmi-pmic-arb";
 			reg = <0xc440000 0xd00>,
 				<0xc600000 0x2000000>,
-- 
2.34.1

