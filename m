Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA0577E8BA8
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Nov 2023 17:42:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231346AbjKKQml (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Nov 2023 11:42:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231331AbjKKQmj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Nov 2023 11:42:39 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A7723A9D
        for <linux-kernel@vger.kernel.org>; Sat, 11 Nov 2023 08:42:35 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id 4fb4d7f45d1cf-54394328f65so4825520a12.3
        for <linux-kernel@vger.kernel.org>; Sat, 11 Nov 2023 08:42:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1699720954; x=1700325754; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RL7d8VoxJlR4XNP9HJLJN0AQS0DI/va4bZI7OWxqTno=;
        b=kVulnaws97v7mjBkpaYaUICXVOwZnd1mKRrcRXpUsrIOjBSWyyncGbX0+WYMUE94Ym
         e8vwEz/SNZNBzLwlfwnHzYw0M49uY9pQHPe3Pm32eF6IzMtm+tqRLVviL4pbBdp4l0jF
         +FoFPo9tii0PlTRlTmtkz0kfK9Yoi/9NepZyDgL3maUIpK+o/521YPfTEHcpW9GjVhh4
         Ou3f0B2W+UBtJFvpREpS47PSaEdho+8RnK7kKGm+AvnXPGXLrdPt84htfnFReYIu29A6
         Fle/BUjs5PDpa7W86bgiTyc4qV3Zm6f/he08xlSFnGNMhiQBYCDrJ/Cim0NSlxVhH87G
         g2mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699720954; x=1700325754;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RL7d8VoxJlR4XNP9HJLJN0AQS0DI/va4bZI7OWxqTno=;
        b=wn9xrfk2q5gR/TiAhITMULKRIMiSIbuqOTXz0a3tTQWGjLEohM+tkVQ3v7SEBlyBtU
         ypG/XSDyAH8sD/EdvedwZSR8zQDhcasX0ql7OmCTLtquNpA++6S2H/RpdpytahOZE0Xs
         T6PboWrt4c2Esq0oibYoDFb66vCZPi0SWenOuehFMOaUjYANeVVPqjRU31Hglf+Dni0D
         nMu6QZL4AcUghbUTiKLV2i+Kn1Cb7KEQSMSm8KX1sZMI0m0GoMDPHTbPOr0MGRTAf+8f
         8RnJDx1maXqUloUbiBQIYEIi1Ze7M1r1meV8V+z+VF4EaSJlu1IM2cnmB4X78ZFoR+Dj
         k+YQ==
X-Gm-Message-State: AOJu0Yx9jbXDdzJSTp8ps0mZzj7Rwhg/lbEMczT7HjzQVilF3P4gFUue
        s8L+GRuZjwDEugb+EiAOw2B70A==
X-Google-Smtp-Source: AGHT+IFEwuIGXCh7j/HovpdUTndrpARTQgb4kaubQQyR+HNaiq2m4ooVUQzLZ6MbGoiTRuZnQYsJcA==
X-Received: by 2002:a05:6402:1a48:b0:547:b04:db3a with SMTP id bf8-20020a0564021a4800b005470b04db3amr1421103edb.21.1699720954065;
        Sat, 11 Nov 2023 08:42:34 -0800 (PST)
Received: from krzk-bin.. ([178.197.218.126])
        by smtp.gmail.com with ESMTPSA id k25-20020aa7c059000000b0053dd8898f75sm1161917edo.81.2023.11.11.08.42.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Nov 2023 08:42:33 -0800 (PST)
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
Subject: [PATCH 2/6] arm64: dts: qcom: sc8180x-primus: use 'gpios' suffix for PCI GPIOs
Date:   Sat, 11 Nov 2023 17:42:25 +0100
Message-Id: <20231111164229.63803-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231111164229.63803-1-krzysztof.kozlowski@linaro.org>
References: <20231111164229.63803-1-krzysztof.kozlowski@linaro.org>
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

Linux handles both versions, but bindings expect GPIO properties to
have 'gpios' suffix instead of 'gpio':

  sc8180x-primus.dtb: pci@1c10000: Unevaluated properties are not allowed ('perst-gpio', 'wake-gpio' were unexpected)

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm64/boot/dts/qcom/sc8180x-primus.dts | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sc8180x-primus.dts b/arch/arm64/boot/dts/qcom/sc8180x-primus.dts
index fd2fab4895b3..8eec33661ef6 100644
--- a/arch/arm64/boot/dts/qcom/sc8180x-primus.dts
+++ b/arch/arm64/boot/dts/qcom/sc8180x-primus.dts
@@ -531,8 +531,8 @@ mdss_edp_out: endpoint {
 };
 
 &pcie1 {
-	perst-gpio = <&tlmm 175 GPIO_ACTIVE_LOW>;
-	wake-gpio = <&tlmm 177 GPIO_ACTIVE_HIGH>;
+	perst-gpios = <&tlmm 175 GPIO_ACTIVE_LOW>;
+	wake-gpios = <&tlmm 177 GPIO_ACTIVE_HIGH>;
 	pinctrl-names = "default";
 	pinctrl-0 = <&pcie2_default_state>;
 
-- 
2.34.1

