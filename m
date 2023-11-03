Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D924E7E0C3D
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Nov 2023 00:35:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229913AbjKCXfu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 19:35:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjKCXfs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 19:35:48 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA558E3
        for <linux-kernel@vger.kernel.org>; Fri,  3 Nov 2023 16:35:45 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-6b5cac99cfdso2532615b3a.2
        for <linux-kernel@vger.kernel.org>; Fri, 03 Nov 2023 16:35:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1699054545; x=1699659345; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=VSqLYgRbivKKnYF2aYcQthhro+1b5nXgEwvXxzPNrJI=;
        b=Xpudmcym95weo5RMydYrt3wBcmheGvdph6nKmkUnU/Ms2To1kqu9g6HiijwWWmWO3r
         MHjQ5cT0Ea3uTmQb71ASJVsSO+cZKzi+o+rOoZ2ZIE+P9A0qtXsuK2z6HSsPkpdNntl7
         NrikQ6u03vqSS2PDSTs0Q3T1b5jmFyajs/1Dc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699054545; x=1699659345;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VSqLYgRbivKKnYF2aYcQthhro+1b5nXgEwvXxzPNrJI=;
        b=N/Pe4wrGDZL+MoWjJpFG6FLGRjV/Tm8wyn7vstrOYj5v2ZMPTjK+/18lTio7Sb+GSJ
         p4KDP+CboYrNGZ+zIEJZvR8yN4lsxjBzUmOmHDUc8ltVrPIrvKQ/3XUIRPnbOoEhZwKy
         FKnePGt7aa1IxoQuf8IwkMtAh3p4AOYYisEONajIOWI8SZq7LhsZRV7gMu/0p5dbIQwO
         RwB91W0wrWtNi1kbp1MpSmffr1hC/vR1JCZ/UwjKoKdnadQLPZuyYsGDa+LjjZucE+S8
         1xEZmCepHIQwugnXh7NhCyeENif+PrDuXDKJef/n6kEnGwXB49ZFj/m0zAiJpwXFVj3q
         IrXA==
X-Gm-Message-State: AOJu0YyMGsMkSbxX4w17WzmS7Pk2CL9Nj+ca4VwyVuZv5H8o56UVapdY
        r6ELK7u/PO7Uq96PlIaFGJ4ZXA==
X-Google-Smtp-Source: AGHT+IGivJm72G8Ok/Dga94KQLsX+IkSW0u6XGPI33zFZ+PCZIj6TFlSL7IcmjdbwjmZbUt1yJ1mbg==
X-Received: by 2002:a05:6a20:938e:b0:180:7df:76a4 with SMTP id x14-20020a056a20938e00b0018007df76a4mr19623287pzh.45.1699054545136;
        Fri, 03 Nov 2023 16:35:45 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:9d:2:5195:5e72:f5bb:e3f0])
        by smtp.gmail.com with ESMTPSA id jg5-20020a17090326c500b001b8b2a6c4a4sm1878114plb.172.2023.11.03.16.35.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Nov 2023 16:35:44 -0700 (PDT)
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
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        Kees Cook <keescook@chromium.org>,
        Sai Prakash Ranjan <quic_saipraka@quicinc.com>,
        Tony Luck <tony.luck@intel.com>,
        cros-qcom-dts-watchers@chromium.org, devicetree@vger.kernel.org,
        linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/9] arm64: dts: qcom: sc7180: Make watchdog bark interrupt edge triggered
Date:   Fri,  3 Nov 2023 16:34:27 -0700
Message-ID: <20231103163434.1.Ic7577567baff921347d423b722de8b857602efb1@changeid>
X-Mailer: git-send-email 2.42.0.869.gea05f2083d-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
"bark" interrupt goes off we'll get one interrupt and won't get
another one until the "bark" interrupt is cleared and asserts again.

This matches how many older Qualcomm SoCs have things configured.

Fixes: 28cc13e4060c ("arm64: dts: qcom: sc7180: Add watchdog bark interrupt")
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

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

