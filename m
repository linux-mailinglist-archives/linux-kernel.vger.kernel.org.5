Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C0C47E3008
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 23:44:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233225AbjKFWoZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 17:44:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233311AbjKFWoV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 17:44:21 -0500
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D8DDD71
        for <linux-kernel@vger.kernel.org>; Mon,  6 Nov 2023 14:44:18 -0800 (PST)
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-6c320a821c4so4503884b3a.2
        for <linux-kernel@vger.kernel.org>; Mon, 06 Nov 2023 14:44:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1699310658; x=1699915458; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HeV56VEkVxBLKgE3tH5Ot8a67/WG+4GGqoNJQCZhnGc=;
        b=j2ZhQFJuRuGyG30PPkN2LDH00bCrzelyQL1tCMYjP7m7phs5m5XrBLL8k8USMuTcFh
         CS4rQTKEMZlze9RibEfJWmC/fDqURHFAxLIr0w5ys8SVPsunkZ7KyoLvgRSC1bobD9fd
         JJGCGd4Xm6ISGdBFVS33sz0zmyYukmHGr6Lbo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699310658; x=1699915458;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HeV56VEkVxBLKgE3tH5Ot8a67/WG+4GGqoNJQCZhnGc=;
        b=WeKpkWzYnWTY9C+oAl8vx2mCgH9TdEAlnumShBuTRkbNcWCXhvq9dIyhHDu5s/hd8T
         YREmV/x/pSK8ctw3E7BnXdXFoU7APINp5ZsgnAg6guOqO7CbuEK3OKSBmP3i9FCZeCkU
         pXMIc6FHnUe5sndA+f1z779WsMOkkWvwIiyFayCeXPrs2nat6sq0rFSUoh2IxjQcuGul
         /Z9vOCZQyDNRJGSEaF83uOyssfIz9FYV4mI1bFjLf+oQ1z5sAaQ2X/MIdOOxrcX17AGl
         6Ow4uIJf2mmoljRl+HgLpkbnX4qD1okEaCQhfFtIEkl/7BGbVwGp0NReUzlEhLl3ymwP
         bPwQ==
X-Gm-Message-State: AOJu0YyACe2cEJi8r5PL7DYl1z/6Fvzpnejh5eeM6whpyI3YM4DPeIHT
        yHweIvPLJYOS37GtRH3QY+F8Ag==
X-Google-Smtp-Source: AGHT+IEIXQgziQ3zL7lElwnEoydeiE6VJUQiW2+JzEfF+aRZV0sKWTC30e0/G5mAwH/Lhd2P5d9yJQ==
X-Received: by 2002:a05:6a00:190b:b0:6c3:69b9:44db with SMTP id y11-20020a056a00190b00b006c369b944dbmr10357674pfi.22.1699310657851;
        Mon, 06 Nov 2023 14:44:17 -0800 (PST)
Received: from tictac2.mtv.corp.google.com ([2620:15c:9d:2:16a7:2c01:9126:36a4])
        by smtp.gmail.com with ESMTPSA id c10-20020a056a00248a00b006b725b2158bsm6043402pfv.41.2023.11.06.14.44.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Nov 2023 14:44:17 -0800 (PST)
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
Subject: [PATCH v2 3/9] arm64: dts: qcom: sdm845: Make watchdog bark interrupt edge triggered
Date:   Mon,  6 Nov 2023 14:43:30 -0800
Message-ID: <20231106144335.v2.3.I16675ebe5517c68453a1bd7f4334ff885f806c03@changeid>
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

Fixes: 36c436b03c58 ("arm64: dts: qcom: sdm845: Add watchdog bark interrupt")
Reviewed-by: Guenter Roeck <linux@roeck-us.net>
Reviewed-by: Stephen Boyd <swboyd@chromium.org>
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

(no changes since v1)

 arch/arm64/boot/dts/qcom/sdm845.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
index bf5e6eb9d313..9648505644ff 100644
--- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
@@ -5088,7 +5088,7 @@ watchdog@17980000 {
 			compatible = "qcom,apss-wdt-sdm845", "qcom,kpss-wdt";
 			reg = <0 0x17980000 0 0x1000>;
 			clocks = <&sleep_clk>;
-			interrupts = <GIC_SPI 0 IRQ_TYPE_LEVEL_HIGH>;
+			interrupts = <GIC_SPI 0 IRQ_TYPE_EDGE_RISING>;
 		};
 
 		apss_shared: mailbox@17990000 {
-- 
2.42.0.869.gea05f2083d-goog

