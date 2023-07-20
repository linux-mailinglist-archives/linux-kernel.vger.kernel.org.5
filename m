Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42E1275AD77
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 13:53:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230364AbjGTLxt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 07:53:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230376AbjGTLxq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 07:53:46 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDDAEE4C
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 04:53:44 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id a640c23a62f3a-98e39784a85so398816566b.1
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 04:53:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689854023; x=1690458823;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dh9x5OzIZBZz686RZwBsvwLGYaOWlknFf5Xss4Llsg0=;
        b=HKL9QrvXI3WhMX+TffdOkBSqCNh472H0p8CjEDyI20h2zV6qH8SUnAONL/rKkvwG+H
         W7vEAgD4LQj5L5QQiwWpeJo8WTelPaotjoFsZiUVqfyWvENFberml9LzN1lckzxOjPW/
         xlUPRhfVbRAJIVmkjjkORTjHv9T73UzSySZrpX5yn6nd5vMRgOT7L7rHksetpuYJmG/Q
         PqAJPVzI+tsZJn9nJfWtV44kAMgtcirWHcsMtE9UKTzU/Nbfdj1IVghAV7I0LxPtAobU
         +6bwjFqEB+PAYPMGI97jgjt56jPAnpLlj1YZ2C+9LEoJqNfOeGIF39SlFs+sKPob9S9W
         O7jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689854023; x=1690458823;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dh9x5OzIZBZz686RZwBsvwLGYaOWlknFf5Xss4Llsg0=;
        b=NyEQh5W5Sx/9kqnZcDhrAax1suEloGvWAKAqnYnTjXbcAiINIGWmZ2j51XEE6aRj+N
         CftQY3S79mND0W17mReOXUFeNY5mZKWN1qFArTGzAmS/I2CFEB0GKXWIiJ3kxdFbLsSm
         g+7cVdw2wnhithEPgS8NRFbqBPZpBG+0bc/acwy5rCX8B80OsXUNq1FYyUqjgo/qgSlO
         4/NkLfdBFihKQmYucRGce17sFnqIfvJ8dR7LCzixt0JJ04n+/RH9ReX1ENbGUkR628Jo
         waa6cee6PCoJhCNlQ3hQe6Ct46WCzjA11ydzqdoXDEKhap+gF+z9pfqvmCBB8+4vOjD4
         UgDA==
X-Gm-Message-State: ABy/qLaRB8H1ppAcgWh8NKSP9dSgItDccdeD2h8KeF3GGh9p80xHMwKg
        pbtTAICLa/9J2/wEnCTrqz2kpQ==
X-Google-Smtp-Source: APBJJlHrqj57D7I81VDvLjIU4hqA4Jy4Wa7pWzqrDT3psrhnfIqDBOLRjLfgiIk+Cdq3fR9xyYyqzA==
X-Received: by 2002:a17:907:7d94:b0:98e:1729:aeee with SMTP id oz20-20020a1709077d9400b0098e1729aeeemr5471669ejc.2.1689854023530;
        Thu, 20 Jul 2023 04:53:43 -0700 (PDT)
Received: from krzk-bin.. ([178.197.223.104])
        by smtp.gmail.com with ESMTPSA id qp7-20020a170907206700b00992b66e54e9sm587758ejb.214.2023.07.20.04.53.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jul 2023 04:53:43 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Gianluca Boiano <morf3089@gmail.com>,
        Eugene Lepshy <fekz115@gmail.com>, Luca Weiss <luca@z3ntu.xyz>,
        Yassine Oudjana <y.oudjana@protonmail.com>,
        Raffaele Tranquillini <raffaele.tranquillini@gmail.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 3/6] arm64: dts: qcom: msm8996-sagit: drop unsupported syna,codes
Date:   Thu, 20 Jul 2023 13:53:32 +0200
Message-Id: <20230720115335.137354-3-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230720115335.137354-1-krzysztof.kozlowski@linaro.org>
References: <20230720115335.137354-1-krzysztof.kozlowski@linaro.org>
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

Synaptics RMI4 Touchscreen bindings never defined syna,codes property
for function 1a.  No usage in Linux drivers.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm64/boot/dts/qcom/msm8998-xiaomi-sagit.dts | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/msm8998-xiaomi-sagit.dts b/arch/arm64/boot/dts/qcom/msm8998-xiaomi-sagit.dts
index 2444b87fddf7..437b30cc8bdc 100644
--- a/arch/arm64/boot/dts/qcom/msm8998-xiaomi-sagit.dts
+++ b/arch/arm64/boot/dts/qcom/msm8998-xiaomi-sagit.dts
@@ -213,7 +213,6 @@ rmi4-f12@12 {
 
 		rmi4-f1a@1a {
 			reg = <0x1a>;
-			syna,codes = <KEY_BACK KEY_APPSELECT>;
 		};
 	};
 };
-- 
2.34.1

