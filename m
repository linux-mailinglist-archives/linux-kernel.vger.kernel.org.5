Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B2797547DC
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jul 2023 11:21:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230452AbjGOJVP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Jul 2023 05:21:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230328AbjGOJU3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Jul 2023 05:20:29 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 161543C05;
        Sat, 15 Jul 2023 02:20:07 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-3fbc6ab5ff5so24484465e9.1;
        Sat, 15 Jul 2023 02:20:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689412805; x=1692004805;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=16dil7uZ1WaYzCMze6Rz4ebNuwh6PjdbRucSC4l5wwA=;
        b=PQ5HwDQAstwI8XvaYHRCnN5BPDOq3/zF/9r/cDfT7McPHFhmG+Z6SwIkBWvp5/lSLR
         ru7sUyy4zDkce54S/UJk1eGyDpS0ym4THJQtJjoQiuLjAL0195zE4YCU8ee/s8/mGlwB
         6XYnZkI8xD804+jk7R7mlTt/LN7ov6GuaVGDI43cr0nN3Q3jJFKZdbcu/8XoB/52qiId
         h3cDKeMmCvyFgu018zO46oZVe+bD+ifPz8fqTAwBY10QgkCWXt/6V3RwclJanXqIrYMn
         Oh8p8JTQhGA28pn6Iq9H2IzgYLxuFyEZpIR5/xrmflE4+6KhlkowDq85dUcTZH2xuuGr
         AKcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689412805; x=1692004805;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=16dil7uZ1WaYzCMze6Rz4ebNuwh6PjdbRucSC4l5wwA=;
        b=RRFlh+HdJRUOntNxW0iOT7l9i/ODl9oQzKEYpKu2SNp4WLd7zCBx9i8qHAM2Fcl8Mn
         G3ROQ7LVo8EAQFAt+skznMN84SaZ9U3rAmZz8CNmwQXffBbP9aCRWLXPsivqrkjl09JJ
         7UOjCMorpN3G6Cw/i7MavB0Q15qTq9OD3Hc+K5XTtM9ykH7QEfSRkaNvFN0hgmXQPs1s
         IRlYHlv7PNwxvi+eiSpnzTcIfUSw5aXfqn9/JuTYgP/dxnhPJjl50q9FDk41xBN7XN6r
         xIoTwz3cl+kb03J24cDeLTNnrMRp+PgZ5gEyZ2fV62lgLBeuiMsR2219I7N861Ccm7o2
         k69A==
X-Gm-Message-State: ABy/qLa1x11e+zos5yW2AIQOUUyIFCSJ1YKOEAsnIuknJQkPUJmBWH1J
        gPvdW0IMZhKkkyvmz0SgZmk=
X-Google-Smtp-Source: APBJJlHYP7HEns13EOIHz08VVyobQchPqzj3s+RZ6iWGV5V8JDGaWqeub3CgPcfCln225Ss0QmS8TA==
X-Received: by 2002:a05:600c:22c4:b0:3fa:9767:c816 with SMTP id 4-20020a05600c22c400b003fa9767c816mr5339647wmg.39.1689412805593;
        Sat, 15 Jul 2023 02:20:05 -0700 (PDT)
Received: from david-ryuzu.fritz.box ([188.195.202.152])
        by smtp.googlemail.com with ESMTPSA id f22-20020a7bc8d6000000b003fbb5142c4bsm3238133wml.18.2023.07.15.02.20.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Jul 2023 02:20:05 -0700 (PDT)
From:   David Wronek <davidwronek@gmail.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Taniya Das <quic_tdas@quicinc.com>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        cros-qcom-dts-watchers@chromium.org,
        David Wronek <davidwronek@gmail.com>,
        Nikita Travkin <nikita@trvn.ru>
Subject: [PATCH v3 5/7] arm64: dts: qcom: pm6150: Add resin and rtc nodes
Date:   Sat, 15 Jul 2023 11:16:11 +0200
Message-ID: <20230715091932.161507-6-davidwronek@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230715091932.161507-1-davidwronek@gmail.com>
References: <20230715091932.161507-1-davidwronek@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for the RTC which is the same as on other PMICs and add the
resin child node to the PM6150 PON device, both disabled by default.

Signed-off-by: David Wronek <davidwronek@gmail.com>
Tested-by: Nikita Travkin <nikita@trvn.ru>
---
 arch/arm64/boot/dts/qcom/pm6150.dtsi | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/pm6150.dtsi b/arch/arm64/boot/dts/qcom/pm6150.dtsi
index 2e6afa296141..af51eb0646ba 100644
--- a/arch/arm64/boot/dts/qcom/pm6150.dtsi
+++ b/arch/arm64/boot/dts/qcom/pm6150.dtsi
@@ -53,6 +53,14 @@ pm6150_pwrkey: pwrkey {
 				bias-pull-up;
 				linux,code = <KEY_POWER>;
 			};
+
+			pm6150_resin: resin {
+				compatible = "qcom,pm8941-resin";
+				interrupts = <0x0 0x8 1 IRQ_TYPE_EDGE_BOTH>;
+				debounce = <15625>;
+				bias-pull-up;
+				status = "disabled";
+			};
 		};
 
 		pm6150_temp: temp-alarm@2400 {
@@ -88,6 +96,14 @@ pm6150_adc_tm: adc-tm@3500 {
 			status = "disabled";
 		};
 
+		pm6150_rtc: rtc@6000 {
+			compatible = "qcom,pm8941-rtc";
+			reg = <0x6000>, <0x6100>;
+			reg-names = "rtc", "alarm";
+			interrupts = <0x0 0x61 0x1 IRQ_TYPE_EDGE_RISING>;
+			status = "disabled";
+		};
+
 		pm6150_gpios: gpio@c000 {
 			compatible = "qcom,pm6150-gpio", "qcom,spmi-gpio";
 			reg = <0xc000>;
-- 
2.41.0

