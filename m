Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A35A7E38E4
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 11:21:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233843AbjKGKVV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 05:21:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233765AbjKGKVT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 05:21:19 -0500
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5393F11D
        for <linux-kernel@vger.kernel.org>; Tue,  7 Nov 2023 02:21:16 -0800 (PST)
Received: by mail-ej1-x62b.google.com with SMTP id a640c23a62f3a-9c603e235d1so817900266b.3
        for <linux-kernel@vger.kernel.org>; Tue, 07 Nov 2023 02:21:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1699352475; x=1699957275; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LbHY8GAPAEL3LtP7aLdc8wgTK9Cumu0+Rrjz3dq0kEI=;
        b=FPm9yH6vZDZXtunJvSbS4dZve3ULDZPo6BdKECNqv6wFzajG6A50wk1cfDC/l8HgY/
         5C7+MiKW8TC+xsIbpLQXjXw044F6dmMliVqlzkH7hAJ/YjS1oGHA1GJWtl3m79Q8PL3k
         hbZUO+RlQMca8YKu1qB2niDz25CmZm40h9lwOwqvz6O4pFPj47SJCekIgLfpLhuOX6NQ
         d4vqYhjt+wSxEG+tmF8m5Jq0G9wE45xoetQie3f5w3OfvjBpAhW3uwHhU8j4PSsCfv6U
         upr1p31SLxE+QWeM882hG5KvAZcAyUo5HhN4nM5aEOUfRLUOAIh6dPt9gIOx304y1nur
         0nKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699352475; x=1699957275;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LbHY8GAPAEL3LtP7aLdc8wgTK9Cumu0+Rrjz3dq0kEI=;
        b=oeHlT12Omgc6+PFlsJPTer/zUAG1ZnK1vC5XcZqtXxZA+HMbdJDDzLtaX8UgW1U09o
         vrbZtmcmkTL0tDo2CH+XfhQ4IlVozRBSdigOfumWesp2lRRtT5p6ZykgJ05jq7Kd2eF8
         /OBGCJTZyhrl2vIL2ZywsDaLKMcKd8nRqlbNBdH8bQQrvTc6x0gN1AbV/yq0ZoW/rN9b
         w/aFm90hA05rROWyWqrpdHG9u3GPcLRp3Be5hG36NWUTE9UUw3LcvsNtvCgGdYxEBXiL
         7aG1irlVuo28t849ULWExwRvTuyazq7zhMopv1EkRZhi/4l3SQIZPP/nS5SsvCCELZ1z
         HsgA==
X-Gm-Message-State: AOJu0Yw9hzZmkbFQxnW64pDMqR/9Rh/3lY6MjGMoUa2y7dnqNbB4RZT9
        ERwxG5w4GEVXBARBk0lyD3lvhQ==
X-Google-Smtp-Source: AGHT+IHhOxt3k1xxBC+RvB3+y16vDtfztqH98fVnIEZDJpjQJqNOpq8YmL2kBEfF5/8qwrPSAfbTUw==
X-Received: by 2002:a17:906:7309:b0:9d2:414c:b92 with SMTP id di9-20020a170906730900b009d2414c0b92mr16617407ejc.68.1699352474849;
        Tue, 07 Nov 2023 02:21:14 -0800 (PST)
Received: from krzk-bin.. ([178.197.218.126])
        by smtp.gmail.com with ESMTPSA id h25-20020a1709062dd900b00988f168811bsm862729eji.135.2023.11.07.02.21.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Nov 2023 02:21:14 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>
Subject: [PATCH 1/2] arm64: dts: qcom: sc8280xp: correct Soundwire node name
Date:   Tue,  7 Nov 2023 11:21:10 +0100
Message-Id: <20231107102111.16465-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Soundwire Devicetree bindings expect the Soundwire controller device
node to be named just "soundwire":

  sc8280xp-lenovo-thinkpad-x13s.dtb: soundwire-controller@3210000: $nodename:0: 'soundwire-controller@3210000' does not match '^soundwire(@.*)?$'

Reported-by: Neil Armstrong <neil.armstrong@linaro.org>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm64/boot/dts/qcom/sc8280xp.dtsi | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
index e5bc9c51ceff..3af3625dd5e6 100644
--- a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
@@ -2730,7 +2730,7 @@ rxmacro: rxmacro@3200000 {
 			status = "disabled";
 		};
 
-		swr1: soundwire-controller@3210000 {
+		swr1: soundwire@3210000 {
 			compatible = "qcom,soundwire-v1.6.0";
 			reg = <0 0x03210000 0 0x2000>;
 			interrupts = <GIC_SPI 155 IRQ_TYPE_LEVEL_HIGH>;
@@ -2806,7 +2806,7 @@ wsamacro: codec@3240000 {
 			status = "disabled";
 		};
 
-		swr0: soundwire-controller@3250000 {
+		swr0: soundwire@3250000 {
 			reg = <0 0x03250000 0 0x2000>;
 			compatible = "qcom,soundwire-v1.6.0";
 			interrupts = <GIC_SPI 170 IRQ_TYPE_LEVEL_HIGH>;
@@ -2843,7 +2843,7 @@ lpass_audiocc: clock-controller@32a9000 {
 			#reset-cells = <1>;
 		};
 
-		swr2: soundwire-controller@3330000 {
+		swr2: soundwire@3330000 {
 			compatible = "qcom,soundwire-v1.6.0";
 			reg = <0 0x03330000 0 0x2000>;
 			interrupts = <GIC_SPI 959 IRQ_TYPE_LEVEL_HIGH>,
-- 
2.34.1

