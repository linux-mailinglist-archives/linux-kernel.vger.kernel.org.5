Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3F89779BA0
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Aug 2023 01:48:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237315AbjHKXrz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 19:47:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237293AbjHKXrv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 19:47:51 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C3E21FE1
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 16:47:47 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-3fe2ba3e260so22787755e9.2
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 16:47:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691797666; x=1692402466;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AmdOHdUjMP1wW0HGcyhP92vzMBSWzUH40ytilEtrnAQ=;
        b=kss1hx9XlprSfLLqs7/RjiejWPn3OTv3AsXNvNQwsHsN/lidSfIaeoZ7F6PBJOyfVk
         jb5YLNsGCUqKZpa0Ni4dJvBk3n7a/7mEdPlAQ7k6e9u1nDyNyaljLdWY45AalPo8qJvN
         tGL2EmUo76VRqdQJ7eaI0oPBsiB10bD8JXN6NCn1yu0dr7rFNP6JPfmhmn47O1akaGCk
         hGap25+JDlzrQDd6GD8swUbpoarMseClZQDvZWZbVW1/yjWXX4FJXJrCxWT3eqOjYgMU
         lSsCNGJ+ALQSUEqHPrmRnFScjoV6bEn7aUol+++7+xVycA2VOEBYw/mzHNfT0ERsJVA4
         5eFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691797666; x=1692402466;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AmdOHdUjMP1wW0HGcyhP92vzMBSWzUH40ytilEtrnAQ=;
        b=XR4rUetFgRNm4AqOsQiNB9Y3prCvpa/ATqDxbTxhhDF0nBq/Pv4eP7Q5LXIdx2aZ4D
         1AbslkKLr5U0yuupms3g4HejpWoQk58+lScPanSGMg/Qs44pVbXF4r4nCohbkKTD/Oim
         fMCNBVZAT3raLjAt48JkwttZKWsi6hDmRa4FgzMPfFqIChqv9lcfF+ge2HzAtBlgG5P3
         epT0e/hLoRQ139KOws1FEtMjd6k9JaFXLYBnvgUTkC05BQ1U+r3lra07RyRfGrVridiH
         J6KSe9r/TKWSyKiLL2Iv0MMUmJGnAAC1lUMYFcIUANfGsvh2iUzDPhZ3m3KNfWkQOAv6
         Kk3Q==
X-Gm-Message-State: AOJu0YzV0rLrjNYVinK7egbPe2sCNID8wtqrc6hgqsEcQTOwHX6yZ54i
        4QwXI+QpaD2g5bTmNbVecJbvcC5ae5J54DhCr+8=
X-Google-Smtp-Source: AGHT+IEfMc/yBi590IOV70wxZo349TY06SKpfQbLcFmk4nLo7/5vyDe1y5S1+hH3JZVExCxHi+GgYA==
X-Received: by 2002:a7b:c045:0:b0:3fb:40ff:1cba with SMTP id u5-20020a7bc045000000b003fb40ff1cbamr2635385wmc.6.1691797665873;
        Fri, 11 Aug 2023 16:47:45 -0700 (PDT)
Received: from sagittarius-a.chello.ie (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id 20-20020a05600c025400b003fa98908014sm9599051wmj.8.2023.08.11.16.47.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Aug 2023 16:47:45 -0700 (PDT)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, bryan.odonoghue@linaro.org
Subject: [PATCH v3 4/7] arm64: dts: qcom: apq8016-sbc: Set ov5640 assigned-clock
Date:   Sat, 12 Aug 2023 00:47:35 +0100
Message-ID: <20230811234738.2859417-5-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230811234738.2859417-1-bryan.odonoghue@linaro.org>
References: <20230811234738.2859417-1-bryan.odonoghue@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The driver for the ov5640 doesn't do a set-rate, instead it expects the
clock to already be set at an appropriate rate.

Similarly the yaml for ov5640 doesn't understand clock-frequency. Convert
from clock-rate to assigned-clock and assigned-clock-rate to remediate.

Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 arch/arm64/boot/dts/qcom/apq8016-sbc.dts | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/apq8016-sbc.dts b/arch/arm64/boot/dts/qcom/apq8016-sbc.dts
index 0481a4a82090a..ada0777567623 100644
--- a/arch/arm64/boot/dts/qcom/apq8016-sbc.dts
+++ b/arch/arm64/boot/dts/qcom/apq8016-sbc.dts
@@ -280,7 +280,8 @@ camera_rear@3b {
 
 		clocks = <&gcc GCC_CAMSS_MCLK0_CLK>;
 		clock-names = "xclk";
-		clock-frequency = <23880000>;
+		assigned-clocks = <&gcc GCC_CAMSS_MCLK0_CLK>;
+		assigned-clock-rates = <23880000>;
 
 		DOVDD-supply = <&camera_vdddo_1v8>;
 		AVDD-supply = <&camera_vdda_2v8>;
-- 
2.41.0

