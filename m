Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB46576929C
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 11:59:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231149AbjGaJ7d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 05:59:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230014AbjGaJ6k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 05:58:40 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FF422110
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 02:57:42 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-99357737980so694265266b.2
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 02:57:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690797461; x=1691402261;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Fo+0+vHRPXrDtZ0tjQ0v+C3nzYHHH+ZPuoUPguExYlo=;
        b=bRdfh7zayUh7aqsg780V5bn+wNnhzY3nk6VWazS3ho77ejVFkv4/nvSEg+bdgvVrXm
         XADgcLLTEptPX6ysTK9okJ9ZSr5vcsugy3/N9ipsO1wOPWJ2uq3mzpDZchB+ZOHmLEPF
         nhfmSrmNLC2FVnAHrZUGVjXWzuL9Att+eAsBFGwHdyyewQ4XU8mP7R8cVQL/XsOyln1v
         SQrmzU50ZEdu08/MFaVn5DKSfxUGxii7p92jVZI5gMVE5K/SJRMWa5eHlpY2bMIBq4CK
         DJuCqcZl/MfpGWmqWLTPRBgNb3URC1lhOMYhkx3F3XuCeHQj+X3Du+NP7Gu0xJKuboLv
         aLsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690797461; x=1691402261;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Fo+0+vHRPXrDtZ0tjQ0v+C3nzYHHH+ZPuoUPguExYlo=;
        b=a0aXzxBrqubzQ8MMuMV3Qf8tw/TQqLZp0FJwLY2Nv4ow4a3lkBL90xGEqlFoL7F/4l
         i6avyEbnEHDa6Yj4u9Pn/68r8dld6KMwZ+rvItH7x5mywM213TeZAeQbvq1aeWvVsIYP
         t3D0Oi0bluiCwXcuhKQnXIhNlRv7xMEAPjhJSDGmCW74cBeNtM37jtQeJUR7O6EeDHym
         httbeWwWJmdAU7W14JoaH24YX/9NvrvNrjk1c9heI4VQKbPuwdbT/SV1pKfYtxL1yMtL
         t+VoojH0UsvpIoe6zQ1XJASAWUEE4FAEQ9FMEyB1GmJXZWYniVNwxtmeqZizwTPmPFij
         rVXA==
X-Gm-Message-State: ABy/qLbF34AcI9gTOYqRswSoUl6S6O2r68WhStqWZtRi0CcCsYm05j+j
        kRKx0N2/N29Lo6NRyfYtCdh03w==
X-Google-Smtp-Source: APBJJlG7U0zWI7OPl82f1WVMHJKL4xOV+ZQ6cmw+FWnEq8/Et0UZbSHmy41qMNCFe4tv0h81tzEXlQ==
X-Received: by 2002:a17:906:2181:b0:997:865a:77e5 with SMTP id 1-20020a170906218100b00997865a77e5mr7773666eju.45.1690797460913;
        Mon, 31 Jul 2023 02:57:40 -0700 (PDT)
Received: from krzk-bin.. ([178.197.222.183])
        by smtp.gmail.com with ESMTPSA id kq6-20020a170906abc600b009828e26e519sm5860678ejb.122.2023.07.31.02.57.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Jul 2023 02:57:40 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 7/8] ARM: dts: samsung: s5pv210-fascinate4g: switch sound card to audio-routing
Date:   Mon, 31 Jul 2023 11:57:29 +0200
Message-Id: <20230731095730.204567-7-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230731095730.204567-1-krzysztof.kozlowski@linaro.org>
References: <20230731095730.204567-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"samsung,audio-routing" property is being deprecated, so switch to
generic "audio-routing".

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../boot/dts/samsung/s5pv210-fascinate4g.dts  | 33 +++++++++----------
 1 file changed, 16 insertions(+), 17 deletions(-)

diff --git a/arch/arm/boot/dts/samsung/s5pv210-fascinate4g.dts b/arch/arm/boot/dts/samsung/s5pv210-fascinate4g.dts
index eaa7c4f0e257..149e488f8e74 100644
--- a/arch/arm/boot/dts/samsung/s5pv210-fascinate4g.dts
+++ b/arch/arm/boot/dts/samsung/s5pv210-fascinate4g.dts
@@ -74,30 +74,29 @@ sound {
 		headset-detect-gpios = <&gph0 6 GPIO_ACTIVE_HIGH>;
 		headset-key-gpios = <&gph3 6 GPIO_ACTIVE_HIGH>;
 
-		samsung,audio-routing =
-			"HP", "HPOUT1L",
-			"HP", "HPOUT1R",
+		audio-routing = "HP", "HPOUT1L",
+				"HP", "HPOUT1R",
 
-			"SPK", "SPKOUTLN",
-			"SPK", "SPKOUTLP",
+				"SPK", "SPKOUTLN",
+				"SPK", "SPKOUTLP",
 
-			"RCV", "HPOUT2N",
-			"RCV", "HPOUT2P",
+				"RCV", "HPOUT2N",
+				"RCV", "HPOUT2P",
 
-			"LINE", "LINEOUT2N",
-			"LINE", "LINEOUT2P",
+				"LINE", "LINEOUT2N",
+				"LINE", "LINEOUT2P",
 
-			"IN1LP", "Main Mic",
-			"IN1LN", "Main Mic",
+				"IN1LP", "Main Mic",
+				"IN1LN", "Main Mic",
 
-			"IN1RP", "Headset Mic",
-			"IN1RN", "Headset Mic",
+				"IN1RP", "Headset Mic",
+				"IN1RN", "Headset Mic",
 
-			"Modem Out", "Modem TX",
-			"Modem RX", "Modem In",
+				"Modem Out", "Modem TX",
+				"Modem RX", "Modem In",
 
-			"Bluetooth SPK", "TX",
-			"RX", "Bluetooth Mic";
+				"Bluetooth SPK", "TX",
+				"RX", "Bluetooth Mic";
 
 		pinctrl-names = "default";
 		pinctrl-0 = <&headset_det &earpath_sel>;
-- 
2.34.1

