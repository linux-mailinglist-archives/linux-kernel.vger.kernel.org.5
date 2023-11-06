Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F22DD7E2FFA
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 23:44:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233302AbjKFWoS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 17:44:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232478AbjKFWoR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 17:44:17 -0500
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B337DD6E
        for <linux-kernel@vger.kernel.org>; Mon,  6 Nov 2023 14:44:14 -0800 (PST)
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-6b497c8575aso5370160b3a.1
        for <linux-kernel@vger.kernel.org>; Mon, 06 Nov 2023 14:44:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1699310654; x=1699915454; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=VKiQCr7hjncufylg+/VbtbjZsCgjIQoLVjcb2bqVtKQ=;
        b=Y4BT/LEAzTvqSAeUYWjtMhSP4ZU6g4T475MUtYWDWD5l+uQwG/+7245coPYvRDNlKQ
         dTs1fgq0lddZ/OIbY5MNRAIDIe3+CxLzkdLpmkv3pK5qSZHnuyqsRsdis3T1nRipp6pp
         eEajpjvVW5FvdC/aThPCXgScok59YPkniQYFQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699310654; x=1699915454;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VKiQCr7hjncufylg+/VbtbjZsCgjIQoLVjcb2bqVtKQ=;
        b=ggpnjK8T+Y3Jg0y8BfVbUxDzvbZJARwdXwmJDEDPWjpWmF8nknv9/24Zu2WFzwTHxk
         eRLFO1Dx2k1BSXBIYFVtbqdDzk2GJzH4RNCcB2ysG5fKXiN4AGHseT/Pq2AYsrRqwRln
         vsBQf5xKoERWji/siJRDGH9O0/TaVbdYHRk2FbIUyb7tOKyyvFRpm6W+0AlzcjxwssR/
         X+fmIQ5QIirIOJqsDh/T/Wqktpwu3FoTOrqzoHMZvfUq2XYLN/8MbFjdNH8NOO1sCxfN
         x98u0u+ez8qAdQX1PFdSOcFHWivKRm9U+RMNzpEcfySkMR8CE93yek4LcVWaiGo5TY8G
         z0RQ==
X-Gm-Message-State: AOJu0Yyz+8z9dNQ5vqQXCjvZLu3RgHfGGQxsMGcRHEqdi21L5dumyoNv
        PWIXo534suLmQZIsSrEn8vqGnA==
X-Google-Smtp-Source: AGHT+IFkpOfcuPLLDmzAviuXIlthZPNPWwOdFQj4TJlFi0vUiPy3DStnuU/aFfkhjXQBMFMASxqjNQ==
X-Received: by 2002:a05:6a20:e123:b0:15e:e0fd:98e7 with SMTP id kr35-20020a056a20e12300b0015ee0fd98e7mr42299408pzb.20.1699310654167;
        Mon, 06 Nov 2023 14:44:14 -0800 (PST)
Received: from tictac2.mtv.corp.google.com ([2620:15c:9d:2:16a7:2c01:9126:36a4])
        by smtp.gmail.com with ESMTPSA id c10-20020a056a00248a00b006b725b2158bsm6043402pfv.41.2023.11.06.14.44.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Nov 2023 14:44:13 -0800 (PST)
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
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        Kees Cook <keescook@chromium.org>,
        Sai Prakash Ranjan <quic_saipraka@quicinc.com>,
        Tony Luck <tony.luck@intel.com>,
        cros-qcom-dts-watchers@chromium.org, devicetree@vger.kernel.org,
        linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/9] arm64: dts: qcom: sc7180: Make watchdog bark interrupt edge triggered
Date:   Mon,  6 Nov 2023 14:43:28 -0800
Message-ID: <20231106144335.v2.1.Ic7577567baff921347d423b722de8b857602efb1@changeid>
X-Mailer: git-send-email 2.42.0.869.gea05f2083d-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On sc7180 when the watchdog timer fires your logs get filled with:
  watchdog0: pretimeout event
  watchdog0: pretimeout event
  watchdog0: pretimeout event
  ...
  watchdog0: pretimeout event

If you're using console-ramoops to debug crashes the above gets quite
annoying since it blows away any other log messages that might have
been there.

The issue is that the "bark" interrupt (AKA the "pretimeout"
interrupt) remains high until the watchdog is pet. Since we've got
things configured as "level" triggered we'll keep getting interrupted
over and over.

Let's switch to edge triggered. Now we'll get one interrupt when the
"bark" interrupt goes off and won't get another one until the "bark"
interrupt is cleared and asserts again.

This matches how many older Qualcomm SoCs have things configured.

Fixes: 28cc13e4060c ("arm64: dts: qcom: sc7180: Add watchdog bark interrupt")
Reviewed-by: Guenter Roeck <linux@roeck-us.net>
Reviewed-by: Stephen Boyd <swboyd@chromium.org>
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

Changes in v2:
- Fixed typo in commit message.

 arch/arm64/boot/dts/qcom/sc7180.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/sc7180.dtsi b/arch/arm64/boot/dts/qcom/sc7180.dtsi
index 11f353d416b4..c0365832c315 100644
--- a/arch/arm64/boot/dts/qcom/sc7180.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7180.dtsi
@@ -3576,7 +3576,7 @@ watchdog@17c10000 {
 			compatible = "qcom,apss-wdt-sc7180", "qcom,kpss-wdt";
 			reg = <0 0x17c10000 0 0x1000>;
 			clocks = <&sleep_clk>;
-			interrupts = <GIC_SPI 0 IRQ_TYPE_LEVEL_HIGH>;
+			interrupts = <GIC_SPI 0 IRQ_TYPE_EDGE_RISING>;
 		};
 
 		timer@17c20000 {
-- 
2.42.0.869.gea05f2083d-goog

