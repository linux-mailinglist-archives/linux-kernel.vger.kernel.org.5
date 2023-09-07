Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F5E2796E4A
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 03:02:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243737AbjIGBCU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 21:02:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242475AbjIGBCP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 21:02:15 -0400
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DAEF19A9;
        Wed,  6 Sep 2023 18:02:10 -0700 (PDT)
Received: by mail-io1-xd31.google.com with SMTP id ca18e2360f4ac-7926de0478eso41165239f.0;
        Wed, 06 Sep 2023 18:02:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694048529; x=1694653329; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7/DXugYCFStEpH1nhWSNJ8V029K3x9zRJrVOGlTmzEA=;
        b=HoWhdEYMC0v4PCOUK9FULoVO1bCsJ2r2zLzH+ZoYoykUk1Kf+CUGd0PsBtbZXiPKME
         KuJublpp2pVj3uC7M36pJQmPk35HNTLKPNKvo52yUb8H1YI30cwingllnbAbdaBwH7K+
         IPsMgeS4nUkBUPC1rceNH5d+BZBTpf54FP9fGXzno8+fD5Nj12z5kjC5y5HE5oEnlSrv
         ieyeakujHZ4bJPMgVC8grjVH7AGGFK28BPKIUjRQNdKWeQdnaFZBNFz+H7VhO1P9oz3j
         qa0wJ1uadHKfv8S3d8FhClgffuQbIWjgLioeWwmhnKeTMjOlEmFkVPGcEITmcjwgeKwb
         Edsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1694048529; x=1694653329;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7/DXugYCFStEpH1nhWSNJ8V029K3x9zRJrVOGlTmzEA=;
        b=eWlgh+lXTyplvr0HaAU99B5E0Z313M9quiLZ9a2UE1J2gGd0Xt8afWbzlhe+pbilny
         E85B8nk2NbzUfX5XlBdAp3P2P1ED31Sh51PNo48ZzDbGrV7aEe0BlUoriLY2E8qqLEID
         7BFdWt7y/rnxrBmC7R2JKMrxHASBDeOgOrwqYdvQmXa/OXi9FdsB8VzEn4+M8oM+CH9K
         6Xx8Kv/4Wjr/3KRblY5Hqn7PRu4AtzEhuFOX8ABl0mxPnEnWM278Qvg8pRQhIK+igkCK
         Gnns+ISSRXDf9depG37NCMklwDHrVE/ZtVeZQADMOrPzX8v3ASTAsDfzUwtWgsvEL9/V
         Lr8w==
X-Gm-Message-State: AOJu0Yyy5W8/llbcOBqcbFHUIe8DRQHdVaX6tdTYkh21kiJ6BXagWSeX
        /Smjd4iEvVUNN1T+gTWCDhGmcM7+Npw=
X-Google-Smtp-Source: AGHT+IEqFvuoaXTrmoy65dl7YvW9l9GkL6URsEAlkIWuCCKho4pAB0L5qrmHqTTpaNpLtr3HwSJjpQ==
X-Received: by 2002:a92:c548:0:b0:34f:115a:158f with SMTP id a8-20020a92c548000000b0034f115a158fmr1516039ilj.14.1694048529224;
        Wed, 06 Sep 2023 18:02:09 -0700 (PDT)
Received: from aford-B741.lan ([2601:447:d001:897f:c24d:eb45:b814:f30b])
        by smtp.gmail.com with ESMTPSA id v6-20020a02b906000000b0042ff466c9bdsm5389796jan.127.2023.09.06.18.02.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Sep 2023 18:02:08 -0700 (PDT)
From:   Adam Ford <aford173@gmail.com>
To:     linux-omap@vger.kernel.org
Cc:     aford@beaconembedded.com, Adam Ford <aford173@gmail.com>,
        =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>,
        Tony Lindgren <tony@atomide.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "Derald D. Woods" <woods.technical@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] arm: dts: am3517-evm: Enable Ethernet PHY Interrupt
Date:   Wed,  6 Sep 2023 20:01:59 -0500
Message-Id: <20230907010159.330555-2-aford173@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230907010159.330555-1-aford173@gmail.com>
References: <20230907010159.330555-1-aford173@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Ethernet PHY interrupt pin is routed to GPIO_58.  Create a
PHY node to configure this GPIO for the interrupt to avoid polling.

Signed-off-by: Adam Ford <aford173@gmail.com>

diff --git a/arch/arm/boot/dts/ti/omap/am3517-evm.dts b/arch/arm/boot/dts/ti/omap/am3517-evm.dts
index 738189ddc8d5..19869ef906a8 100644
--- a/arch/arm/boot/dts/ti/omap/am3517-evm.dts
+++ b/arch/arm/boot/dts/ti/omap/am3517-evm.dts
@@ -172,11 +172,24 @@ hsusb1_phy: hsusb1_phy {
 &davinci_emac {
 	pinctrl-names = "default";
 	pinctrl-0 = <&ethernet_pins>;
+	phy-mode = "rmii";
+	phy-handle = <&ethphy0>;
 	status = "okay";
 };
 
 &davinci_mdio {
+	#address-cells = <1>;
+	#size-cells = <0>;
 	status = "okay";
+
+	ethphy0: ethernet-phy@0 {
+		pinctrl-names = "default";
+		pinctrl-0 = <&enet_phy_pins>;
+		compatible = "ethernet-phy-ieee802.3-c22";
+		reg = <0>;
+		interrupt-parent = <&gpio2>;
+		interrupts = <26 IRQ_TYPE_LEVEL_LOW>;	/* gpio_58 */
+	};
 };
 
 &dss {
@@ -257,6 +270,12 @@ OMAP3_CORE1_IOPAD(0x2210, PIN_INPUT_PULLDOWN | MUX_MODE0) /* rmii_50mhz_clk */
 		>;
 	};
 
+	enet_phy_pins: pinmux_ent_phy_pins {
+		pinctrl-single,pins = <
+			OMAP3_CORE1_IOPAD(0x20bc, PIN_INPUT | MUX_MODE4)	/* gpmc_ncs7.gpio_57 */
+		>;
+	};
+
 	i2c2_pins: i2c2-pins {
 		pinctrl-single,pins = <
 			OMAP3_CORE1_IOPAD(0x21be, PIN_INPUT_PULLUP | MUX_MODE0)  /* i2c2_scl */
-- 
2.39.2

