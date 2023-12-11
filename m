Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9231F80C3BB
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 09:58:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230319AbjLKI6a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 03:58:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbjLKI62 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 03:58:28 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D42B2D9
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 00:58:34 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-40c31f18274so35555665e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 00:58:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702285113; x=1702889913; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gMUJTjvA3J26dSdTiEt4TdDVTDH3n4BQkpvTQmQkiVg=;
        b=ki9H31C7X8vN9idXqx1kUJrbMeA8MnKiviO8LYjZ0fJzagZtJCA76b9xZB9K2iAdUG
         +3uJHQHwmBwtzNd3gXx9Ghm83YnQM0Ue0VD6pwOip1rXgJEbxqRmXH4NsPWixenzuiCA
         IsCJHvv7WBHXsvz1Fck5jxcJv0Kt5fu8LN021qGFBe/LweomEFGGQE5fbSwDpQWAYAGe
         nyzCpOoAIkOb4BpX2G6tTuQ42M6PFWxdrqdPT0UDRFl1JB85zta7g8IiCGCT/OzBdbRM
         gNKzLixGoSJuwVnuIq4CjD9EQDs3kUdFH4f0vTwicNfy5YYzQYZ3uB9Sc61wURuC2JlR
         Hidg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702285113; x=1702889913;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gMUJTjvA3J26dSdTiEt4TdDVTDH3n4BQkpvTQmQkiVg=;
        b=vADLEY+GwpeMZ0L6mxuAzOPhH0GRRd/vl4IgSQcQynOLQ2t0T6NjR/aBkbvxOxn1Mu
         MyuKqvrrF//BJ8IDe+F3DPOZG0J5MRzPDZToh80MtP2Z7xHSxy92cLfdN2kebx16MdJ0
         kcNoa1YMubsyUbr71CaC/SgnOfwRxLSpgAf0e5SiEsyr7/9G+N2KDR8HBKRBgal7SKIw
         rAgcZh7ZGJ5beW071/99n8v28Z0VXsPV59644kT6+S9rRHGQfUCuVFQwdkKCP7rrqVLQ
         97Pcyyfj1VQ9KxvacOqcrNf2NvSQ32z7iZp/DPemttQ0z2Miwxp1HDPlby+BCWU+hI0d
         43uA==
X-Gm-Message-State: AOJu0YyViGrnrK3rVGBAr27MiwvmY0m4iRYYcxY+3wqoNv/40F/drR+K
        gIi8xCHMl9s86SQ57LQqYs1wlw==
X-Google-Smtp-Source: AGHT+IEdVHw9x75OQSgV0Tjh5ujbDy6v33ypmF+84RpcH9f9bSjyFP0uMPL2YIKrHrKqXdtkfHAc2g==
X-Received: by 2002:a05:600c:2108:b0:40c:24a2:6b0f with SMTP id u8-20020a05600c210800b0040c24a26b0fmr1777549wml.212.1702285113287;
        Mon, 11 Dec 2023 00:58:33 -0800 (PST)
Received: from krzk-bin.. ([178.197.218.27])
        by smtp.gmail.com with ESMTPSA id fl9-20020a05600c0b8900b0040b43da0bbasm12315067wmb.30.2023.12.11.00.58.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Dec 2023 00:58:32 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Bhupesh Sharma <bhupesh.sharma@linaro.org>,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 1/3] dt-bindings: mmc: sdhci-msm: document dedicated IPQ4019 and IPQ8074
Date:   Mon, 11 Dec 2023 09:58:28 +0100
Message-Id: <20231211085830.25380-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
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

Add dedicated compatibles for the Qualcomm IPQ4019 and IPQ8074 SoCs,
because usage of generic qcom,sdhci-msm-v4 compatible alone is
deprecated.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 Documentation/devicetree/bindings/mmc/sdhci-msm.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml b/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml
index 86fae733d9a0..c24c537f62b1 100644
--- a/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml
+++ b/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml
@@ -22,6 +22,8 @@ properties:
       - items:
           - enum:
               - qcom,apq8084-sdhci
+              - qcom,ipq4019-sdhci
+              - qcom,ipq8074-sdhci
               - qcom,msm8226-sdhci
               - qcom,msm8953-sdhci
               - qcom,msm8974-sdhci
-- 
2.34.1

