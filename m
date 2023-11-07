Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FBD77E38EA
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 11:21:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233852AbjKGKVY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 05:21:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233642AbjKGKVV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 05:21:21 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5537F7
        for <linux-kernel@vger.kernel.org>; Tue,  7 Nov 2023 02:21:18 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id 4fb4d7f45d1cf-543456dbd7bso12752171a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 07 Nov 2023 02:21:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1699352477; x=1699957277; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=47MAytI0wpXklmtxz3ze9/twRYMKCl4qLroxZ/CA07k=;
        b=Y1UjO4IIqrwPPYEmLCUY8uelNoCArPvpCWQnW01NMiHVhsHLKnYHOzjD4XFN09wp1n
         Ovwxr6V0iNQCCPQgDH7RA0xyRGwK/f7tt13ivtKFUQLOEGHG2UPxHZblI7/+88z6ussA
         sQIXmSr0/5C+QycG3hJ3ozNhWY48eWFz1Z+Sa08ot8JcBmVbGW60gbqMqO1mqPQyhxqT
         NpiyEKVHEtyxo3CW/oxRcBMsh3+kkSDAt/yZgo/8Ny8kb4LvNsMhrO12CxvRTUy15ZgM
         2Mv4AsLGmgCvQlKkeF+KRETKQeYI7PSQHJTsvMqK0z92u3LnAS0JYFgQRKTLTBNMZI77
         O0Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699352477; x=1699957277;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=47MAytI0wpXklmtxz3ze9/twRYMKCl4qLroxZ/CA07k=;
        b=HBFUZM93RCUi8QK7QuyyZP54C9TeTK8rC3og0t+wieHtEe4YkPM2KFBuzuxmqKGSBZ
         ZAJHKUFi94JRaCyG2FrwT/wnS7UbFEhze/8c9dLJFFcN3W5fWO5AzGIpZoDAiVlfYAS+
         J7UDhDmm0GJDoU6Bxdu7sVCnwHvKgU8wqBb+E4pkpApXWBr2hfhjlF+e639LJCRvxdga
         Igh8lOevkzH+E/BYpkmg+U0jYfSKaNQUz9iOGivLFXlIilDSX5fmyxvC5K7l4z8WLvbC
         5gJsjVvzwIeQeUR8nmIYLFV3fIeeLjSqVo/yd1OSItH1mAfI7LGVX/n8H6TLDaRAodvi
         WXvA==
X-Gm-Message-State: AOJu0Yx4XLVO4Kymj+JAFzhO44KhtaA7sO+N3XcBWqs1tfJB2JIYEuSa
        xLik8E2FHnYKw4zNm6IczfMgCA==
X-Google-Smtp-Source: AGHT+IHX0QvvlKra6NCllPEzGPvfh8orZQvj1X1s22+LFf8HWHGhNFdEdr9eI9GC+bvgIuyZye2dwg==
X-Received: by 2002:a17:907:7fa5:b0:9a9:f0e6:904e with SMTP id qk37-20020a1709077fa500b009a9f0e6904emr2099101ejc.16.1699352477298;
        Tue, 07 Nov 2023 02:21:17 -0800 (PST)
Received: from krzk-bin.. ([178.197.218.126])
        by smtp.gmail.com with ESMTPSA id h25-20020a1709062dd900b00988f168811bsm862729eji.135.2023.11.07.02.21.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Nov 2023 02:21:16 -0800 (PST)
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
Subject: [PATCH 2/2] arm64: dts: qcom: sm8250: correct Soundwire node name
Date:   Tue,  7 Nov 2023 11:21:11 +0100
Message-Id: <20231107102111.16465-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231107102111.16465-1-krzysztof.kozlowski@linaro.org>
References: <20231107102111.16465-1-krzysztof.kozlowski@linaro.org>
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

  sm8250-xiaomi-elish-boe.dtb: soundwire-controller@3250000: $nodename:0: 'soundwire-controller@3250000' does not match '^soundwire(@.*)?$'

Reported-by: Neil Armstrong <neil.armstrong@linaro.org>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm8250.dtsi | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8250.dtsi b/arch/arm64/boot/dts/qcom/sm8250.dtsi
index da71de5e1a80..e18a18a9e767 100644
--- a/arch/arm64/boot/dts/qcom/sm8250.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8250.dtsi
@@ -2557,7 +2557,7 @@ wsamacro: codec@3240000 {
 			status = "disabled";
 		};
 
-		swr0: soundwire-controller@3250000 {
+		swr0: soundwire@3250000 {
 			reg = <0 0x03250000 0 0x2000>;
 			compatible = "qcom,soundwire-v1.5.1";
 			interrupts = <GIC_SPI 202 IRQ_TYPE_LEVEL_HIGH>;
@@ -2623,7 +2623,7 @@ rxmacro: rxmacro@3200000 {
 			#sound-dai-cells = <1>;
 		};
 
-		swr1: soundwire-controller@3210000 {
+		swr1: soundwire@3210000 {
 			reg = <0 0x03210000 0 0x2000>;
 			compatible = "qcom,soundwire-v1.5.1";
 			status = "disabled";
@@ -2670,7 +2670,7 @@ txmacro: txmacro@3220000 {
 		};
 
 		/* tx macro */
-		swr2: soundwire-controller@3230000 {
+		swr2: soundwire@3230000 {
 			reg = <0 0x03230000 0 0x2000>;
 			compatible = "qcom,soundwire-v1.5.1";
 			interrupts = <GIC_SPI 297 IRQ_TYPE_LEVEL_HIGH>;
-- 
2.34.1

