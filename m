Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CB607E8F15
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Nov 2023 09:01:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230395AbjKLIBy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Nov 2023 03:01:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230240AbjKLIBr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Nov 2023 03:01:47 -0500
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 163C330CB
        for <linux-kernel@vger.kernel.org>; Sun, 12 Nov 2023 00:01:44 -0800 (PST)
Received: by mail-lf1-x134.google.com with SMTP id 2adb3069b0e04-507a0907896so4611681e87.2
        for <linux-kernel@vger.kernel.org>; Sun, 12 Nov 2023 00:01:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1699776102; x=1700380902; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TWIb1bx21KXA/e/moLxgTKfaIIIfJdvhi2i/+fjCaMI=;
        b=Zyqy7KosIWld1AAcDop2Fe0xR4u0ng2f4tP9Wefxo5LTVBei80vsxg7ZrPcZYoYpKO
         uG8Zkq1c3uVpqtXTGNt44mVVnHvt7LfUwhx8Kxrswp2WEdcBcdZEa1yOmC/DaoN7Z9Tl
         tzNRB8OpMRM5nE5Byci6IqEk3990c+qqfoMo5jbzYzcUEgysLwRnQbjM9jcDqEg66i6g
         BhBxHOcIYAzDeLqMnSYeUjpJ8OC6v2qflUwG76JCYOT4k2c+6okcf7igLqoheeNk7+HU
         dZhyOhGMxG9CxaTziGU4EMX+mCZbiWg6VEa1rhXmMkwhLJ3q06AkV08trSYqbuZ4JGPQ
         Zz3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699776102; x=1700380902;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TWIb1bx21KXA/e/moLxgTKfaIIIfJdvhi2i/+fjCaMI=;
        b=pEKgvm2Rm7JvTtRy09IxUWz+qr4IFK1Ma0Mu6XnS7suT6ntZs0nsmk+7l4HPA7ApNR
         dV2KWh/ULx7BgkmGbwDWngHWaszHY6zTO/9Lo3zo3B39UVcCeR6ZzurdsybR6r4xFwZ8
         mjwpY8XWZjht2v+mPhm7NSwBaEvybP0ntrWCI0z/HIoQHNHa8ghGRRxn6LUti01LBOdc
         Mg4+jv2r6SeLj2JrRqCOUz/6nP09uOqDSynvoOE5+wk6ZTrrknBycHxQaMk8ldcXSKvh
         AMbKAt/XBL+BJUJCdPrmM1dwkyOAyG3C4yatfDe6jM9mew4MppDcb8htPUaBbmmIBTiQ
         AAGA==
X-Gm-Message-State: AOJu0YxNsatZIcZZ+/5PTULUBROsmIBHIDSrnYK2aEvIFo63ILImUgjZ
        Muk8P2+kjQy8EcA1PGvO6E2fQg==
X-Google-Smtp-Source: AGHT+IGn7yHakrWaPAN/7vTrfpqtai2xTB7Hn0e4NanBdRR9RU9Oh00G1L0zPbe4UogOqtyDxzn9pg==
X-Received: by 2002:ac2:424a:0:b0:509:4511:8ec4 with SMTP id m10-20020ac2424a000000b0050945118ec4mr2078179lfl.38.1699776102364;
        Sun, 12 Nov 2023 00:01:42 -0800 (PST)
Received: from krzk-bin.monzoon.net (46-253-189-43.dynamic.monzoon.net. [46.253.189.43])
        by smtp.gmail.com with ESMTPSA id bf17-20020a0564021a5100b0054351b5a768sm1940853edb.82.2023.11.12.00.01.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Nov 2023 00:01:41 -0800 (PST)
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
Subject: [PATCH 3/3] ARM: dts: qcom: ipq4019: correct clock order in DWC3 node
Date:   Sun, 12 Nov 2023 09:01:36 +0100
Message-Id: <20231112080136.12518-3-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231112080136.12518-1-krzysztof.kozlowski@linaro.org>
References: <20231112080136.12518-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Align the order of clocks in Qualcomm DWC3 USB controller to match
bindings.  Linux driver does not care about the order.  This fixes
dtbs_check warning:

  qcom-ipq4018-ap120c-ac.dtb: usb@60f8800: clock-names:0: 'core' was expected

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm/boot/dts/qcom/qcom-ipq4019.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/qcom/qcom-ipq4019.dtsi b/arch/arm/boot/dts/qcom/qcom-ipq4019.dtsi
index b93c7efda827..6357cd342b33 100644
--- a/arch/arm/boot/dts/qcom/qcom-ipq4019.dtsi
+++ b/arch/arm/boot/dts/qcom/qcom-ipq4019.dtsi
@@ -684,7 +684,7 @@ usb2: usb@60f8800 {
 			clocks = <&gcc GCC_USB2_MASTER_CLK>,
 				 <&gcc GCC_USB2_SLEEP_CLK>,
 				 <&gcc GCC_USB2_MOCK_UTMI_CLK>;
-			clock-names = "master", "sleep", "mock_utmi";
+			clock-names = "core", "sleep", "mock_utmi";
 			ranges;
 			status = "disabled";
 
-- 
2.34.1

