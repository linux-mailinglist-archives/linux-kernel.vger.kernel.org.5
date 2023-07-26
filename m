Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80653762C89
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 09:06:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232252AbjGZHFz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 03:05:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232314AbjGZHFN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 03:05:13 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 070E9422B
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 00:03:29 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id 2adb3069b0e04-4fbb281eec6so10081747e87.1
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 00:03:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690355007; x=1690959807;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+Sp6Oh3kIZYgwY/6PAzwynsD4VZMj8j6x6i38EBvjv4=;
        b=k13+9VtFyhCyA5x2o3+p6BFUWl8Y6TGcK+ogwMkvvl5J81O/Se+A/TuSVB0nWIbUbQ
         eLmY/aMEhNS9VKXnuu/br+QfQIdjkoNYdFPmWxQWHi3E3X3B/7Qmj8QgZCWbIo3kd/am
         BKtbVu7bjEhU/rcld+xJvdH0tU3UkGNwB9aIR/EKRT9B+2ZW22Shf1ZbCr1N5GwCwsMo
         xW3VYzQTdAWOKkcBF/cOcspJm/vh4XL2rihv5wMspqOb+CiQA37T76CuxE3qZHyHaYUz
         l2fvbI8xagKyHKkbAAH1vziITBrrkGyyaqFMzfD13CzUIu/PjykZKvnzIL8VUDkVGvGt
         ur/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690355007; x=1690959807;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+Sp6Oh3kIZYgwY/6PAzwynsD4VZMj8j6x6i38EBvjv4=;
        b=bGbOI4xX8JB5sRBvtxq1QllBZeFmkmDQqoiSeKil0FS45BTRnmhbi3ddbArWU3EdNR
         /SlFNvh8W+jaadgRV/2F/GGP2AEja+8+BXbr1yMB0P0X0WDVHkK/QXRcQFDiZWs/cGs5
         E60PWXFTSm7aPGb7e3x4Cw9xZ7k4I6qYpTJabqscxbTfUc4/kIQG5c3M+1vj6hMLuTme
         fcMK3cExkJkaV25DtIDp+9EynrNUi4FLIMRZU6wjqruD+ED1QpRDkPzYuVX6gqp7lRUf
         lMr2wqOPZH4GVrS2G0y7AIfvaIA/3fOUMUY4DY/5V5pkHEH4FjR4Y0rmNewrDFR27tmG
         FEGw==
X-Gm-Message-State: ABy/qLZnwLKFQ86FKNqiO/vKWW4K06ZdGVCwGcCXt3ywQIL9y5UkAyH6
        7qKFXJE3VU9gkZBidIMBzyZmHA==
X-Google-Smtp-Source: APBJJlFWiuBO4vk/bvm/I48NbQmLqb+Rw/jod2Hiopmi/kTz7LGgnkmgmBKcX6/u4/1AX2YuxUoPVQ==
X-Received: by 2002:ac2:495b:0:b0:4fe:8b5:588a with SMTP id o27-20020ac2495b000000b004fe08b5588amr723344lfi.57.1690355006710;
        Wed, 26 Jul 2023 00:03:26 -0700 (PDT)
Received: from krzk-bin.. ([178.197.223.104])
        by smtp.gmail.com with ESMTPSA id dy16-20020a05640231f000b005224f840130sm1572003edb.60.2023.07.26.00.03.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jul 2023 00:03:26 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 1/8] AMR: dts: imx6sx-nitrogen6sx: drop incorrect regulator clock-names
Date:   Wed, 26 Jul 2023 09:03:15 +0200
Message-Id: <20230726070322.103871-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
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

regulator-fixed does not take "clock-names" property:

  imx6sx-nitrogen6sx.dtb: regulator-wlan: Unevaluated properties are not allowed ('clock-names' was unexpected)

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm/boot/dts/nxp/imx/imx6sx-nitrogen6sx.dts | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/boot/dts/nxp/imx/imx6sx-nitrogen6sx.dts b/arch/arm/boot/dts/nxp/imx/imx6sx-nitrogen6sx.dts
index a2c79bcf9a11..23ccca2dea44 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6sx-nitrogen6sx.dts
+++ b/arch/arm/boot/dts/nxp/imx/imx6sx-nitrogen6sx.dts
@@ -72,7 +72,6 @@ reg_wlan: regulator-wlan {
 		pinctrl-0 = <&pinctrl_reg_wlan>;
 		compatible = "regulator-fixed";
 		clocks = <&clks IMX6SX_CLK_CKO>;
-		clock-names = "slow";
 		regulator-name = "wlan-en";
 		regulator-min-microvolt = <3300000>;
 		regulator-max-microvolt = <3300000>;
-- 
2.34.1

