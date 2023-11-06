Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41D3A7E301C
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 23:44:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233362AbjKFWoy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 17:44:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233389AbjKFWoe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 17:44:34 -0500
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAC3210FC
        for <linux-kernel@vger.kernel.org>; Mon,  6 Nov 2023 14:44:29 -0800 (PST)
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-6b77ab73c6fso3972043b3a.1
        for <linux-kernel@vger.kernel.org>; Mon, 06 Nov 2023 14:44:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1699310668; x=1699915468; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JSFzZ8MKWLiAfWY/igP5BmMC+MvDzsV/nsEt0CPNxwc=;
        b=OiK77QSLdvOzKTwuVexKwfy8shaOf5X0LCpsPwzWfTv9RTrUZ4+/SQTNhHPo5a+ToI
         JkyyTnwZSM06xvOFLnumXFJANKBrsPWLHWrt5vCWj7uVSNiYJT7Yq7E3tnWfhCG1ed77
         thLTFuxnHqR12NdfagsN6fEAtWCTLMA9J35QU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699310668; x=1699915468;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JSFzZ8MKWLiAfWY/igP5BmMC+MvDzsV/nsEt0CPNxwc=;
        b=sNjhrHCxPivyhPIg1nCQ3Hodr4r52Q6uESqJEzhwWOVBBzeLPeB551p/jWA3m0hy2S
         O95gKlCWYWyOhHHDEM3vSdKiUKGITokKeK5//miUyDoIKShaRL7Y3chlGsCG7HMqWFUN
         q9l6xcsoY8rpwzsXFRIZgUufHeTRMjgwgrferjdzbHTn8ZiFZlmR4k4DpQ6oeZbncDVz
         GD+YKS3q3j2nVpOcGf36hMp1fO1xT0puXCXYK0gMONE4Z0Bf/MvdoHP1/2loHjhEYWhN
         PH3ZxxqZHnwIPfp/r38C/cRZZjfAjKcXNectSUux8ICLEE0j//gfESgnYfYZ7W1t/fcQ
         1s/w==
X-Gm-Message-State: AOJu0Yyba6oGVDBW9NIAo/FZbSAM6ARhtpe9QWLKTHDm5xywy/IE/04K
        Q9muXk/La7kRcTkPpH5vO/HXJg==
X-Google-Smtp-Source: AGHT+IG6gzEJ52rY+ItvXab//ZSnUcmhXxypnlC7l6Ma3b1yinNqemp4TAQZMqkiymLSkLqhVuFGnQ==
X-Received: by 2002:a05:6a00:2e9e:b0:68f:b5a3:5ec6 with SMTP id fd30-20020a056a002e9e00b0068fb5a35ec6mr1433778pfb.0.1699310668041;
        Mon, 06 Nov 2023 14:44:28 -0800 (PST)
Received: from tictac2.mtv.corp.google.com ([2620:15c:9d:2:16a7:2c01:9126:36a4])
        by smtp.gmail.com with ESMTPSA id c10-20020a056a00248a00b006b725b2158bsm6043402pfv.41.2023.11.06.14.44.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Nov 2023 14:44:27 -0800 (PST)
From:   Douglas Anderson <dianders@chromium.org>
To:     Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>
Cc:     swboyd@chromium.org, linux-watchdog@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>,
        Andy Gross <agross@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 8/9] arm64: dts: qcom: sm6350: Make watchdog bark interrupt edge triggered
Date:   Mon,  6 Nov 2023 14:43:35 -0800
Message-ID: <20231106144335.v2.8.Ic1d4402e99c70354d501ccd98105e908a902f671@changeid>
X-Mailer: git-send-email 2.42.0.869.gea05f2083d-goog
In-Reply-To: <20231106144335.v2.1.Ic7577567baff921347d423b722de8b857602efb1@changeid>
References: <20231106144335.v2.1.Ic7577567baff921347d423b722de8b857602efb1@changeid>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As described in the patch ("arm64: dts: qcom: sc7180: Make watchdog
bark interrupt edge triggered"), the Qualcomm watchdog timer's bark
interrupt should be configured as edge triggered. Make the change.

Fixes: 5f82b9cda61e ("arm64: dts: qcom: Add SM6350 device tree")
Reviewed-by: Guenter Roeck <linux@roeck-us.net>
Reviewed-by: Stephen Boyd <swboyd@chromium.org>
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

(no changes since v1)

 arch/arm64/boot/dts/qcom/sm6350.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/sm6350.dtsi b/arch/arm64/boot/dts/qcom/sm6350.dtsi
index 8fd6f4d03490..6464e144c228 100644
--- a/arch/arm64/boot/dts/qcom/sm6350.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm6350.dtsi
@@ -2524,7 +2524,7 @@ watchdog@17c10000 {
 			compatible = "qcom,apss-wdt-sm6350", "qcom,kpss-wdt";
 			reg = <0 0x17c10000 0 0x1000>;
 			clocks = <&sleep_clk>;
-			interrupts = <GIC_SPI 0 IRQ_TYPE_LEVEL_HIGH>;
+			interrupts = <GIC_SPI 0 IRQ_TYPE_EDGE_RISING>;
 		};
 
 		timer@17c20000 {
-- 
2.42.0.869.gea05f2083d-goog

