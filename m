Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37A7475AD83
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 13:54:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231566AbjGTLyF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 07:54:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230442AbjGTLx6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 07:53:58 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0F9626B8
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 04:53:51 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id a640c23a62f3a-986d8332f50so125867466b.0
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 04:53:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689854030; x=1690458830;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zEB7vXaIwnAhpDASS1J+qAJt1j2aVFugFv9veyrLS2A=;
        b=tujTSyDHHquSlA3TPt7UTDH8MKeyKfD+3wT8wN+T6Z54Fe2sc1t9R7XCEacOok8TgC
         AfJAeYYFNjt3XxI6xqIRvmPScYDeyUwLowykZboYZw+fk0lXDswmTUzV0jmLeDk19KkY
         knQ9tXxlKhJZQyBjlBc22NQULjMO0lkYHZEuR4rrl/l1N2aanHsITGjy6Uypl1/5tNIg
         pSPu/1TBrXHnby+czqXul/aGfold6bBu5EJH7vC+U7w6IkzUnqKNYzYGgmUTIE8BVTV0
         j3k9yDHXlJHcqE75ylEzCBHpfhiDJ0r6zAAbdI/IK8moFIBZ7400XUvxH19JlbszVJht
         f4tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689854030; x=1690458830;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zEB7vXaIwnAhpDASS1J+qAJt1j2aVFugFv9veyrLS2A=;
        b=M4bmDFSj56VOOXV16QxMdKTkOnDIctwxy37V1uUqh3o0/27/i8PDHJnBfF216y6Pyc
         MwlafdzvsBBNxwZIMjgggGVWmI/g3AfC1yHUi8NiVi8YR+tr5ABH/4Msx1t6SKddYrFY
         HnQ7LV5zhb8VXSpH+sZTHu/yqF2lB0oPuTudp2Yrk/APhWgQ8UpZtWPzrqeg4YGpuBoB
         WvwC1XaWeCmdWjb2RdhiFPNc5XaAKRE6UH40fyi7UmlObmLbWFF8VYwwdnQFdlaoRF/K
         yRyS22kB0V74R0AkyeV24/eoYRpG/8stEFhfLs/GTC30XYO/nLVi+A1tZaFoO4lRYZTV
         vPhw==
X-Gm-Message-State: ABy/qLYOwWJYpzlmoGa1o7ilJOc4kXAkO2nqjP1CI9+g6jRsgq822Psw
        UCj4RFvKdkRH90SPuiviY/8v0Q==
X-Google-Smtp-Source: APBJJlH7qOKHUTFdcuSvDY/5P4zGijT6QwAApX1MzF5804HU3zm/82tWf5hA4OxZIVXotXHFAuCCsg==
X-Received: by 2002:a17:906:73cf:b0:99b:48a9:f56d with SMTP id n15-20020a17090673cf00b0099b48a9f56dmr2122866ejl.22.1689854029846;
        Thu, 20 Jul 2023 04:53:49 -0700 (PDT)
Received: from krzk-bin.. ([178.197.223.104])
        by smtp.gmail.com with ESMTPSA id qp7-20020a170907206700b00992b66e54e9sm587758ejb.214.2023.07.20.04.53.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jul 2023 04:53:49 -0700 (PDT)
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
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        stable@vger.kernel.org
Subject: [PATCH 6/6] ARM: dts: qcom: msm8974pro-castor: correct touchscreen syna,nosleep-mode
Date:   Thu, 20 Jul 2023 13:53:35 +0200
Message-Id: <20230720115335.137354-6-krzysztof.kozlowski@linaro.org>
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

There is no syna,nosleep property in Synaptics RMI4 touchscreen:

  qcom-msm8974pro-sony-xperia-shinano-castor.dtb: synaptics@2c: rmi4-f01@1: 'syna,nosleep' does not match any of the regexes: 'pinctrl-[0-9]+'

Fixes: ab80661883de ("ARM: dts: qcom: msm8974: Add Sony Xperia Z2 Tablet")
Cc: <stable@vger.kernel.org>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../dts/qcom/qcom-msm8974pro-sony-xperia-shinano-castor.dts     | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/qcom/qcom-msm8974pro-sony-xperia-shinano-castor.dts b/arch/arm/boot/dts/qcom/qcom-msm8974pro-sony-xperia-shinano-castor.dts
index 726ed67415e1..11468d1409f7 100644
--- a/arch/arm/boot/dts/qcom/qcom-msm8974pro-sony-xperia-shinano-castor.dts
+++ b/arch/arm/boot/dts/qcom/qcom-msm8974pro-sony-xperia-shinano-castor.dts
@@ -127,7 +127,7 @@ synaptics@2c {
 
 		rmi4-f01@1 {
 			reg = <0x1>;
-			syna,nosleep = <1>;
+			syna,nosleep-mode = <1>;
 		};
 
 		rmi4-f11@11 {
-- 
2.34.1

