Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BA1775B5B9
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 19:36:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231600AbjGTRgv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 13:36:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230027AbjGTRgt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 13:36:49 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82B50CC;
        Thu, 20 Jul 2023 10:36:48 -0700 (PDT)
Received: from jupiter.universe (dyndsl-091-248-215-153.ewe-ip-backbone.de [91.248.215.153])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id E7C15660708E;
        Thu, 20 Jul 2023 18:36:46 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1689874607;
        bh=KtE+VH2GvDS0wFF4IFtRN+7uUhhHqa10Cgj/e8W59WE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jdYamSEaPa7Z88gsS9NgCrPI1gdY3B/n7vQxSE48/g3mbw0FfLz7br9o3jfIu0Ucp
         xcz0GpNLOICRtnFte2QEoUnIrIP7+1fBrOq/LcHuJaBCDRq7rZkFbPAgkmEW5sLlgO
         f+VN2u77eoaC4gIiGFxuZLdHJRPj98re6pWBw2QLngAl0g3Xg1+OOaCYAUymTCDXIe
         6Hu/UBMwF6vjirxwVrzEc500DCKhjzlAr+4IwAC7Cu82/ZcmDTkT8ubx/V/dL1RhIl
         VGydnUf38MIvTt6o80bNOzoe3m+6L6LFmJddxnXE+I+FTBRzhDL82WqWYl2l4R8X/e
         t/t3yv+tX3Xrg==
Received: by jupiter.universe (Postfix, from userid 1000)
        id E9037480E66; Thu, 20 Jul 2023 19:36:44 +0200 (CEST)
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Heiko Stuebner <heiko@sntech.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-rockchip@lists.infradead.org, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        kernel@collabora.com
Subject: [PATCH v2 3/3] arm64: dts: rockchip: rk3588s: Add USB3 host controller
Date:   Thu, 20 Jul 2023 19:36:43 +0200
Message-Id: <20230720173643.69553-4-sebastian.reichel@collabora.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230720173643.69553-1-sebastian.reichel@collabora.com>
References: <20230720173643.69553-1-sebastian.reichel@collabora.com>
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

RK3588 has three USB3 controllers. This adds the host-only controller,
which is using the naneng-combphy shared with PCIe and SATA.

The other two are dual-role and using a different PHY that is not yet
supported upstream.

Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
 arch/arm64/boot/dts/rockchip/rk3588s.dtsi | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3588s.dtsi b/arch/arm64/boot/dts/rockchip/rk3588s.dtsi
index b9b509257aaa..5cda58ea52e2 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588s.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3588s.dtsi
@@ -443,6 +443,27 @@ usb_host1_ohci: usb@fc8c0000 {
 		status = "disabled";
 	};
 
+	usb_host2_xhci: usb@fcd00000 {
+		compatible = "rockchip,rk3588-dwc3", "snps,dwc3";
+		reg = <0x0 0xfcd00000 0x0 0x400000>;
+		interrupts = <GIC_SPI 222 IRQ_TYPE_LEVEL_HIGH 0>;
+		clocks = <&cru REF_CLK_USB3OTG2>, <&cru SUSPEND_CLK_USB3OTG2>,
+			 <&cru ACLK_USB3OTG2>, <&cru CLK_UTMI_OTG2>,
+			 <&cru CLK_PIPEPHY2_PIPE_U3_G>;
+		clock-names = "ref_clk", "suspend_clk", "bus_clk", "utmi", "pipe";
+		dr_mode = "host";
+		phys = <&combphy2_psu PHY_TYPE_USB3>;
+		phy-names = "usb3-phy";
+		phy_type = "utmi_wide";
+		resets = <&cru SRST_A_USB3OTG2>;
+		snps,dis_enblslpm_quirk;
+		snps,dis-u2-freeclk-exists-quirk;
+		snps,dis-del-phy-power-chg-quirk;
+		snps,dis-tx-ipgap-linecheck-quirk;
+		snps,dis_rxdet_inp3_quirk;
+		status = "disabled";
+	};
+
 	sys_grf: syscon@fd58c000 {
 		compatible = "rockchip,rk3588-sys-grf", "syscon";
 		reg = <0x0 0xfd58c000 0x0 0x1000>;
-- 
2.40.1

