Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EA277A4CCC
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 17:41:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229644AbjIRPlJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 11:41:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjIRPlI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 11:41:08 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACC94BE;
        Mon, 18 Sep 2023 08:37:30 -0700 (PDT)
Received: from jupiter.universe (dyndsl-091-248-188-252.ewe-ip-backbone.de [91.248.188.252])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 411746607239;
        Mon, 18 Sep 2023 15:14:58 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1695046498;
        bh=I25whc5DhqxcsIbgYS50yLUplGh7UM7ST9VITX/zNi4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=E2XO6/iZWqZfrSbnktVBsWGU9tyvW4xccNIviKhdeTlswRVAgsAv0whHyRuuvx6lX
         /2L0Gn0QMFdDLQyKmzY0fhe0e2S9T4R7QC/oFhD/3F4vLNMbUZGuD+dagUzcfbgi+T
         nFN1X0+t/FfKbevifgj4dPjhKbCWtcq8nn0ZUX6nzmqtxNKk+snpqpPlkYueWUwxcM
         ugUWV2LXUe5AC+UBKT3Ebxd1jSyc0p9w96lyot/3wOQvbWZKoYcviYncSbAYnkWDLP
         MND/GzzbQY975cdsqM1JbVJoL2Ny+1X3bgR45NhChTP2sqxOQHbE6VA8uK50tX+a/n
         MjBMRfuzTobPA==
Received: by jupiter.universe (Postfix, from userid 1000)
        id 8369B4800D0; Mon, 18 Sep 2023 16:14:56 +0200 (CEST)
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Heiko Stuebner <heiko@sntech.de>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        kernel@collabora.com
Subject: [PATCH 2/3] arm64: dts: rockchip: rock-5b: add PCIe for M.2 M-key
Date:   Mon, 18 Sep 2023 16:14:50 +0200
Message-Id: <20230918141451.131247-3-sebastian.reichel@collabora.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230918141451.131247-1-sebastian.reichel@collabora.com>
References: <20230918141451.131247-1-sebastian.reichel@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Radxa Rock 5B has PCIe 3x4 routed to its M.2 M-key connector
on the board's back.

Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
 .../boot/dts/rockchip/rk3588-rock-5b.dts      | 35 +++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts b/arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts
index 0752b0fb4b54..6e52b5cf49a9 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts
@@ -53,6 +53,19 @@ vcc3v3_pcie2x1l2: vcc3v3-pcie2x1l2-regulator {
 		vin-supply = <&vcc_3v3_s3>;
 	};
 
+	vcc3v3_pcie30: vcc3v3-pcie30-regulator {
+		compatible = "regulator-fixed";
+		enable-active-high;
+		gpios = <&gpio1 RK_PA4 GPIO_ACTIVE_HIGH>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pcie3_vcc3v3_en>;
+		regulator-name = "vcc3v3_pcie30";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		startup-delay-us = <5000>;
+		vin-supply = <&vcc5v0_sys>;
+	};
+
 	vcc5v0_host: vcc5v0-host-regulator {
 		compatible = "regulator-fixed";
 		regulator-name = "vcc5v0_host";
@@ -225,6 +238,18 @@ &pcie2x1l2 {
 	status = "okay";
 };
 
+&pcie30phy {
+	status = "okay";
+};
+
+&pcie3x4 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pcie3_rst>;
+	reset-gpios = <&gpio4 RK_PB6 GPIO_ACTIVE_HIGH>;
+	vpcie3v3-supply = <&vcc3v3_pcie30>;
+	status = "okay";
+};
+
 &pinctrl {
 	hym8563 {
 		hym8563_int: hym8563-int {
@@ -244,6 +269,16 @@ pcie2_2_rst: pcie2-2-rst {
 		};
 	};
 
+	pcie3 {
+		pcie3_rst: pcie3-rst {
+			rockchip,pins = <4 RK_PB6 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+
+		pcie3_vcc3v3_en: pcie3-vcc3v3-en {
+			rockchip,pins = <1 RK_PA4 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+	};
+
 	usb {
 		vcc5v0_host_en: vcc5v0-host-en {
 			rockchip,pins = <4 RK_PB0 RK_FUNC_GPIO &pcfg_pull_none>;
-- 
2.40.1

