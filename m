Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C36A7E300E
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 23:44:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233358AbjKFWob (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 17:44:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233326AbjKFWoY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 17:44:24 -0500
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F292910C0
        for <linux-kernel@vger.kernel.org>; Mon,  6 Nov 2023 14:44:20 -0800 (PST)
Received: by mail-oi1-x235.google.com with SMTP id 5614622812f47-3b2b1af09c5so2373687b6e.0
        for <linux-kernel@vger.kernel.org>; Mon, 06 Nov 2023 14:44:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1699310660; x=1699915460; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MQfwiBgyb0NDLVCz1up5WP4xaDEfvCkGE4sF98eZ7HU=;
        b=Z9HuSfM4FPnV9mJ/CsS4B3+t92xyYhdaQo8Z8cmhKiY+JnnGVC8HwpIgqcuIdkDt1X
         Wae4JtthLkDNRFFcXWo8l1dX8lzoyl4FF6phaFTtyElxSB5ZcgVqox4eMGEUA4u3RlaG
         i0/52SlJlA0kWimJq0bLGOkH+CjjLjnR2S39c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699310660; x=1699915460;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MQfwiBgyb0NDLVCz1up5WP4xaDEfvCkGE4sF98eZ7HU=;
        b=bRYyPCj6ns4oUsZ9MO+1J/caWGvypX6zFVr8vwaxvTxuZOTII5q8aEd37Q4R8YvSDK
         IY5SGBnALDIjYS3+Pxnutvy6brqIT3Yowyfv9NyTp5P4FgO64ZoPIfhjNgElfn2qh86D
         wleG3up3tty4KkTGFR0o5+PB1Wh2LkFHQyA/cx6xdiO6ruOabHMkRXksFQB4DKV9T3XD
         IPleoQH+Q7261ymeXuB3P7mKBmqbEsYLwLri9/q88i/Q+97+1Sud6RO5nqV9obiqnfSb
         Sex94pY32V8kcIsGwpxfGhJ5IzwelTPstQZMyt4rygedTZQvH6Xy5OkTMeA5lWyMwXuv
         49xw==
X-Gm-Message-State: AOJu0Yzxti1rpao9vWy48z5k7UmtM02Y6pk4vDfo7gL3rLtq2OKDu058
        HRuPJEH+T0ixErQuBs8mBDBVxA==
X-Google-Smtp-Source: AGHT+IFdMSyh5AqVjDStLHve/AJFaFnM1P4vCt/67yxeGNDa/ie7acpEAVZqAzrV0qH2B1+wMAJiHw==
X-Received: by 2002:aca:1b0d:0:b0:3a7:52b9:cbfe with SMTP id b13-20020aca1b0d000000b003a752b9cbfemr25606422oib.32.1699310660283;
        Mon, 06 Nov 2023 14:44:20 -0800 (PST)
Received: from tictac2.mtv.corp.google.com ([2620:15c:9d:2:16a7:2c01:9126:36a4])
        by smtp.gmail.com with ESMTPSA id c10-20020a056a00248a00b006b725b2158bsm6043402pfv.41.2023.11.06.14.44.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Nov 2023 14:44:19 -0800 (PST)
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
        Andy Gross <agross@kernel.org>,
        Sai Prakash Ranjan <quic_saipraka@quicinc.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 4/9] arm64: dts: qcom: sm8150: Make watchdog bark interrupt edge triggered
Date:   Mon,  6 Nov 2023 14:43:31 -0800
Message-ID: <20231106144335.v2.4.I23d0aa6c8f1fec5c26ad9b3c610df6f4c5392850@changeid>
X-Mailer: git-send-email 2.42.0.869.gea05f2083d-goog
In-Reply-To: <20231106144335.v2.1.Ic7577567baff921347d423b722de8b857602efb1@changeid>
References: <20231106144335.v2.1.Ic7577567baff921347d423b722de8b857602efb1@changeid>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As described in the patch ("arm64: dts: qcom: sc7180: Make watchdog
bark interrupt edge triggered"), the Qualcomm watchdog timer's bark
interrupt should be configured as edge triggered. Make the change.

Fixes: b094c8f8dd2a ("arm64: dts: qcom: sm8150: Add watchdog bark interrupt")
Reviewed-by: Guenter Roeck <linux@roeck-us.net>
Reviewed-by: Stephen Boyd <swboyd@chromium.org>
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

(no changes since v1)

 arch/arm64/boot/dts/qcom/sm8150.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8150.dtsi b/arch/arm64/boot/dts/qcom/sm8150.dtsi
index 97623af13464..ad4fab61222b 100644
--- a/arch/arm64/boot/dts/qcom/sm8150.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8150.dtsi
@@ -4170,7 +4170,7 @@ watchdog@17c10000 {
 			compatible = "qcom,apss-wdt-sm8150", "qcom,kpss-wdt";
 			reg = <0 0x17c10000 0 0x1000>;
 			clocks = <&sleep_clk>;
-			interrupts = <GIC_SPI 0 IRQ_TYPE_LEVEL_HIGH>;
+			interrupts = <GIC_SPI 0 IRQ_TYPE_EDGE_RISING>;
 		};
 
 		timer@17c20000 {
-- 
2.42.0.869.gea05f2083d-goog

