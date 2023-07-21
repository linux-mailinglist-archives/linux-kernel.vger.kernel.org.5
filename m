Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F43375C7DF
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 15:33:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231229AbjGUNdE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 09:33:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231357AbjGUNc4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 09:32:56 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE3EA30D4
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 06:32:52 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id a640c23a62f3a-992b2249d82so309137066b.1
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 06:32:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689946371; x=1690551171;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QOWJLBf1ty8KzVG8dUmwJsE8IPV8x0Srq0/dtmrSM/A=;
        b=DKpboIZu/eBEk5A5aNIiG3K5eAreQDmJcU5De/RJrEqY9O1e5mKOwm9T8J9cnRQkzh
         U7PPLMILwW0BvjmPNyyWa8QEbDoKvG5knagJSBEDHMlzAbJv/2+CDBERJnUco3eceosO
         +7Um1qhc5eF/+y6NHGUhKjyk9Kz/kIoKWxCi/htydouQ2V8Yfdn86Q39Zrm033kulpUT
         d565tjHsEjr6vlg+XsxaK+GEsPYRLBD+17Ma4zsKTjC3vP/XcQ+EzDKWrss5drD5ozTi
         e78B6CcADLctsjUmEkupmTx+pyOETeuht5hJXXaaN562QxUF3DafFK9Q538tPWBbbn2J
         dpig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689946371; x=1690551171;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QOWJLBf1ty8KzVG8dUmwJsE8IPV8x0Srq0/dtmrSM/A=;
        b=OmuiD6RMhd6kVuVMnX/B5YrODlZ1qVuC2dntgZLgL6LHHkdUpUy3ABdbtrXwJ3lYqp
         NtjlU9uFUS4q0do1Jze6+7S7kOENTi7wJFuRjwbGl41Kt63KJ0nUUBDZ7lklW8SWGKqT
         udrZFbDBrl4hdJYbOPAbfLWxrWQEOFYgCEHyVgwBTijAJbsLVKW43UYG6+yvInmWwY3j
         6g62jkJa+L/Q/A0uIWrWqSoy6YJPI/clBbFaxRyTd+7khtQNn0BAvQhD6YSdBTJxSwUV
         OhylpX+zmI/1pNVg8LcRjae3FALOfP5xj410c183kZK+0zk8HLh8nTR0zGBAA8X+FXQN
         0rzw==
X-Gm-Message-State: ABy/qLZzuwxL7Vz8mDu6i3orWi0C8HJLdTR2QrKQTZFgfNw1UycgtwHl
        pfIBnvqRSlBFroAG7QplIyMqlw==
X-Google-Smtp-Source: APBJJlGFk/rv9nGVhk02KNVz6CUfXg+yS5TJPVyYDu6CF7DM/SZEyPteTU7J8/zhCBqx5Hy5DstoHA==
X-Received: by 2002:a17:906:9bcc:b0:991:f7cb:cc3d with SMTP id de12-20020a1709069bcc00b00991f7cbcc3dmr1713361ejc.65.1689946371156;
        Fri, 21 Jul 2023 06:32:51 -0700 (PDT)
Received: from krzk-bin.. ([178.197.223.104])
        by smtp.gmail.com with ESMTPSA id z3-20020a170906270300b00993017b64a8sm2170613ejc.224.2023.07.21.06.32.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jul 2023 06:32:50 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 2/2] ARM: dts: samsung: exynos5250-snow: switch i2c-arb to new child variant
Date:   Fri, 21 Jul 2023 15:32:46 +0200
Message-Id: <20230721133246.15752-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230721133246.15752-1-krzysztof.kozlowski@linaro.org>
References: <20230721133246.15752-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit e8813c15be0a ("dt-bindings: i2c: add support for 'i2c-arb'
subnode") the i2c-arbitrator subnode should not have unit address.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm/boot/dts/samsung/exynos5250-snow-common.dtsi | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/arch/arm/boot/dts/samsung/exynos5250-snow-common.dtsi b/arch/arm/boot/dts/samsung/exynos5250-snow-common.dtsi
index 64f00c5fd322..65b000df176e 100644
--- a/arch/arm/boot/dts/samsung/exynos5250-snow-common.dtsi
+++ b/arch/arm/boot/dts/samsung/exynos5250-snow-common.dtsi
@@ -60,9 +60,6 @@ vbat: vbat-fixed-regulator {
 
 	i2c-arbitrator {
 		compatible = "i2c-arb-gpio-challenge";
-		#address-cells = <1>;
-		#size-cells = <0>;
-
 		i2c-parent = <&i2c_4>;
 
 		our-claim-gpios = <&gpf0 3 GPIO_ACTIVE_LOW>;
@@ -75,8 +72,7 @@ i2c-arbitrator {
 		pinctrl-0 = <&arb_our_claim &arb_their_claim>;
 
 		/* Use ID 104 as a hint that we're on physical bus 4 */
-		i2c_104: i2c@0 {
-			reg = <0>;
+		i2c_104: i2c-arb {
 			#address-cells = <1>;
 			#size-cells = <0>;
 
-- 
2.34.1

