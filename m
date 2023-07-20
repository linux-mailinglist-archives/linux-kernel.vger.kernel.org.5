Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41FE975A7AF
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 09:21:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231445AbjGTHVD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 03:21:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231372AbjGTHU5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 03:20:57 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0C3C2115
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 00:20:55 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id ffacd0b85a97d-3141c3a7547so357160f8f.2
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 00:20:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689837654; x=1692429654;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zkvq8PLrKRAViicQL2lp06qamZMGFRuRLh5USoc58vw=;
        b=wnJnPobhUpvmppz0hmMpMdvG9c9qcJ/ca6mAvL1othcTqlsFruzm527lnbmmH4ksaK
         v2JE9+28IuaUsuNW3dVhX7EHwLcBBIVj/wUGo+6ch7GYbXChNJqRaTNwzL8ZGGwG0Df7
         7bJNW7g0oVK5kVlLmC5WEBJZHaAo+Lhyc0q2rpXbEQMMBTHMwqxHLYtJ4cj8LKK4whPu
         sm0e354nwlCjBjvH5SxCN6P9Uu8pLuQh3JFuDsD9+LxCwCWOsxANSyHQyRrm3Gg1YbGl
         E6z4XczhLwKmSu/2bSdY05IzZwqF8R9ce9ZH7wGjiy3vUNmHKbxMY3y+RwLz7UesSSO3
         QWHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689837654; x=1692429654;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Zkvq8PLrKRAViicQL2lp06qamZMGFRuRLh5USoc58vw=;
        b=Pbsis47rVVLfW+ycGWIHy8/UVPsXiaZYWLtNggtXX3nqdkJ3ewk4Fb8aywVop2T3oC
         9EjC+qPmQkKFlAd8aX9r1Iys0SM5KWoKasZ5jVeFemOAvbAzxFRYr8MHjGNOxig/qH/p
         cEoun2oS1KAjZ3A2t8YZdI3TDdabSXLrLRF5yZLEPqGftuBnb2MQ3I0nblzl3XlJjDWw
         5hJRLalHCF8VuTks0+WQ0IhmAZHOlCzlySQKgHkBahMQA8nJiPZsadQWrbcDhG+tB1Yk
         bkXW8Hg9kdJ43vmQrsmZcoXMQKL2ptxv2bpXLIUo3vN2IaQmzILsaFyj480OY3ig0VzU
         gfEw==
X-Gm-Message-State: ABy/qLZdyWmDcGo7IRPalD7SB7kFZDfFQqcuDEkfn2k4kSAh41CssTyR
        kTw/gjJFHu26XNbMzYWKMd1z6g==
X-Google-Smtp-Source: APBJJlE/7M5tGfJ/bv8zqoEC6d/nfpK99w6SC9TQP0/TEykqSrrfD/lk4A3aQHRzuHvI0jKAlXWV/Q==
X-Received: by 2002:a5d:4524:0:b0:314:268b:21f1 with SMTP id j4-20020a5d4524000000b00314268b21f1mr1325029wra.18.1689837654072;
        Thu, 20 Jul 2023 00:20:54 -0700 (PDT)
Received: from krzk-bin.. ([178.197.223.104])
        by smtp.gmail.com with ESMTPSA id v1-20020a5d6781000000b0031434c08bb7sm399767wru.105.2023.07.20.00.20.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jul 2023 00:20:53 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [RESEND PATCH 2/2] arm64: dts: qcom: msm8992-libra: drop duplicated reserved memory
Date:   Thu, 20 Jul 2023 09:20:48 +0200
Message-Id: <20230720072048.10093-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230720072048.10093-1-krzysztof.kozlowski@linaro.org>
References: <20230720072048.10093-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are two entries for similar reserved memory: qseecom@cb400000 and
audio@cb400000.  Keep the qseecom as it is longer.

  Warning (unique_unit_address_if_enabled): /reserved-memory/audio@cb400000: duplicate unit-address (also used in node /reserved-memory/qseecom@cb400000)

Fixes: 69876bc6fd4d ("arm64: dts: qcom: msm8992-libra: Fix the memory map")
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Maybe the original intention was to use different address for audio res.
memory?
---
 arch/arm64/boot/dts/qcom/msm8992-xiaomi-libra.dts | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/msm8992-xiaomi-libra.dts b/arch/arm64/boot/dts/qcom/msm8992-xiaomi-libra.dts
index 501e05efbef4..133f9c2540bc 100644
--- a/arch/arm64/boot/dts/qcom/msm8992-xiaomi-libra.dts
+++ b/arch/arm64/boot/dts/qcom/msm8992-xiaomi-libra.dts
@@ -110,11 +110,6 @@ rmtfs_mem: rmtfs@ca100000 {
 			qcom,client-id = <1>;
 		};
 
-		audio_mem: audio@cb400000 {
-			reg = <0 0xcb000000 0 0x400000>;
-			no-mem;
-		};
-
 		qseecom_mem: qseecom@cb400000 {
 			reg = <0 0xcb400000 0 0x1c00000>;
 			no-mem;
-- 
2.34.1

