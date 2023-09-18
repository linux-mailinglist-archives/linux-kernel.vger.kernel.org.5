Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8099F7A4CFB
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 17:44:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229604AbjIRPoy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 11:44:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229768AbjIRPoq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 11:44:46 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4263310F4;
        Mon, 18 Sep 2023 08:42:24 -0700 (PDT)
Received: from jupiter.universe (dyndsl-091-248-188-252.ewe-ip-backbone.de [91.248.188.252])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 3D6636607201;
        Mon, 18 Sep 2023 15:14:58 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1695046498;
        bh=fexmH11W8W4v7URTCHuJ5kQTk9dY/yuzuXTeYE9KXXo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XhhNyc3UkOixPt6WBmb5KvAqCLpNDC7iKt2u3EK+tXDd9LXRG2vY81nQrnYI1mFIc
         +NkuwFYHr8eYfLQEVo82LdWoHJyhaAQLQ5aNE6gmxMuhPVGW4ilVR3jOn2mUgP+hyZ
         fyJ3vE9NTIOmglw56YrxTXaqDRHlLZaSgXUrT2qLeZ45XZnfQl3xHeIBQ0vZGP1dTy
         2pYn2bVxuu2gMIzUCYhdtoL7aaT+zplfwIBCt5uF+4UcNuJuRU8YunHkluAKf+q178
         S1NR3upNR6o/5PW2+Gaj3LMU3sJjvsXOKkc6gEpHnNgbufmFat8rpOQJqcgbWUyKfd
         FrJnLUeLnC4Lg==
Received: by jupiter.universe (Postfix, from userid 1000)
        id 8120D4800CF; Mon, 18 Sep 2023 16:14:56 +0200 (CEST)
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Heiko Stuebner <heiko@sntech.de>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        kernel@collabora.com
Subject: [PATCH 1/3] arm64: dts: rockchip: rock-5b: add PCIe network controller
Date:   Mon, 18 Sep 2023 16:14:49 +0200
Message-Id: <20230918141451.131247-2-sebastian.reichel@collabora.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230918141451.131247-1-sebastian.reichel@collabora.com>
References: <20230918141451.131247-1-sebastian.reichel@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable the RTL8125 network controller, which is connected via
PCIe.

Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
 .../boot/dts/rockchip/rk3588-rock-5b.dts      | 27 +++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts b/arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts
index 8ab60968f275..0752b0fb4b54 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts
@@ -44,6 +44,15 @@ fan: pwm-fan {
 		#cooling-cells = <2>;
 	};
 
+	vcc3v3_pcie2x1l2: vcc3v3-pcie2x1l2-regulator {
+		compatible = "regulator-fixed";
+		regulator-name = "vcc3v3_pcie2x1l2";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		startup-delay-us = <5000>;
+		vin-supply = <&vcc_3v3_s3>;
+	};
+
 	vcc5v0_host: vcc5v0-host-regulator {
 		compatible = "regulator-fixed";
 		regulator-name = "vcc5v0_host";
@@ -78,6 +87,10 @@ vcc_1v1_nldo_s3: vcc-1v1-nldo-s3-regulator {
 	};
 };
 
+&combphy0_ps {
+	status = "okay";
+};
+
 &cpu_b0 {
 	cpu-supply = <&vdd_cpu_big0_s0>;
 };
@@ -204,6 +217,14 @@ i2s0_8ch_p0_0: endpoint {
 	};
 };
 
+&pcie2x1l2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pcie2_2_rst>;
+	reset-gpios = <&gpio3 RK_PB0 GPIO_ACTIVE_HIGH>;
+	vpcie3v3-supply = <&vcc3v3_pcie2x1l2>;
+	status = "okay";
+};
+
 &pinctrl {
 	hym8563 {
 		hym8563_int: hym8563-int {
@@ -217,6 +238,12 @@ hp_detect: hp-detect {
 		};
 	};
 
+	pcie2 {
+		pcie2_2_rst: pcie2-2-rst {
+			rockchip,pins = <3 RK_PB0 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+	};
+
 	usb {
 		vcc5v0_host_en: vcc5v0-host-en {
 			rockchip,pins = <4 RK_PB0 RK_FUNC_GPIO &pcfg_pull_none>;
-- 
2.40.1

