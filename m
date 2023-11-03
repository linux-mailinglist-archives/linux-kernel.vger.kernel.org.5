Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C905B7E0C55
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Nov 2023 00:37:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232001AbjKCXgN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 19:36:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231629AbjKCXgB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 19:36:01 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA09AD6A
        for <linux-kernel@vger.kernel.org>; Fri,  3 Nov 2023 16:35:57 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-6c396ef9a3dso553472b3a.1
        for <linux-kernel@vger.kernel.org>; Fri, 03 Nov 2023 16:35:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1699054557; x=1699659357; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xb8JsrX5d6MFcJDdSA4UiCRqCBZzbS6joY26UIgwWL4=;
        b=GtQIQU4SLxZlb2bm7rrC43JN6bYg4YGugmo9AWLNo5pRYD9vIN/w7EDhF5zGOSp0+j
         34gNThY1Yhkb6FoAZFxi4aCe4FS2mshF02UWv1j35rA3X4dvhCo+ykeRESMy+fIVgHLW
         0V6ZsWcp1eKyzdDiToYTxbLXqSausfu1aoR9I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699054557; x=1699659357;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xb8JsrX5d6MFcJDdSA4UiCRqCBZzbS6joY26UIgwWL4=;
        b=HQb+NOpLKL3qPGHrePj4/krGAKsnEVZOJm22WYZIKk6/Q86oQm60Rjd5hunQs9/Kfw
         13Gfps5epJQSLUi1TZpvzWKPSFp5+uPNSKo5Bzi3A/z881DbpcU/Ar8qcl3AB9yndKMB
         epu1BGnuWeYeXsXrfT7f6gUhotCYmIasaZM2dSfnrsgOSfDXL4GlUvnnPkeaLrGqrNBA
         8Pp1j9j+PbyTga3cen5G5K+InKVo9q15DlTLtkWcFqtDvt58/S4GbteLFwklXwrjzESk
         02sD2sjnd0StdIF99QlwzbZ3tgfMfGeSN9E9j5DiYkxG7+TFfGqTZtY94mRBnP/6IDaB
         /yMw==
X-Gm-Message-State: AOJu0Yy2jdbzMiUfTW7ZCBP/7nR+iXtv26DJWVXRlWXUpAQNxuSxdGBi
        7dNrq38TfwC27ep4JCYDlxNnRA==
X-Google-Smtp-Source: AGHT+IHZFtWMPycHBKtwCqbtmyUlVrCGcQ2vWizPaYDMhaiamQlC/2iMPYNgM07+ZC14dALGWDhH8Q==
X-Received: by 2002:a05:6a21:71c7:b0:181:261f:f346 with SMTP id ay7-20020a056a2171c700b00181261ff346mr10955837pzc.26.1699054556970;
        Fri, 03 Nov 2023 16:35:56 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:9d:2:5195:5e72:f5bb:e3f0])
        by smtp.gmail.com with ESMTPSA id jg5-20020a17090326c500b001b8b2a6c4a4sm1878114plb.172.2023.11.03.16.35.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Nov 2023 16:35:56 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>
Cc:     linux-watchdog@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        swboyd@chromium.org, Douglas Anderson <dianders@chromium.org>,
        Andy Gross <agross@kernel.org>,
        Johan Hovold <johan+linaro@kernel.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 7/9] arm64: dts: qcom: sc8280xp: Make watchdog bark interrupt edge triggered
Date:   Fri,  3 Nov 2023 16:34:33 -0700
Message-ID: <20231103163434.7.I1c8ab71570f6906fd020decb80675f05fbe1fe74@changeid>
X-Mailer: git-send-email 2.42.0.869.gea05f2083d-goog
In-Reply-To: <20231103163434.1.Ic7577567baff921347d423b722de8b857602efb1@changeid>
References: <20231103163434.1.Ic7577567baff921347d423b722de8b857602efb1@changeid>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

Fixes: 152d1faf1e2f ("arm64: dts: qcom: add SC8280XP platform")
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

 arch/arm64/boot/dts/qcom/sc8280xp.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
index cad59af7ccef..b8081513176a 100644
--- a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
@@ -4225,7 +4225,7 @@ watchdog@17c10000 {
 			compatible = "qcom,apss-wdt-sc8280xp", "qcom,kpss-wdt";
 			reg = <0 0x17c10000 0 0x1000>;
 			clocks = <&sleep_clk>;
-			interrupts = <GIC_SPI 0 IRQ_TYPE_LEVEL_HIGH>;
+			interrupts = <GIC_SPI 0 IRQ_TYPE_EDGE_RISING>;
 		};
 
 		timer@17c20000 {
-- 
2.42.0.869.gea05f2083d-goog

