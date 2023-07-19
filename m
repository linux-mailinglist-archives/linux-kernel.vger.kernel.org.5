Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98E61759C9B
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 19:40:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230418AbjGSRk3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 13:40:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230179AbjGSRk0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 13:40:26 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7A291BF6;
        Wed, 19 Jul 2023 10:40:20 -0700 (PDT)
Received: from jupiter.universe (dyndsl-091-248-208-009.ewe-ip-backbone.de [91.248.208.9])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 43F04660704A;
        Wed, 19 Jul 2023 18:40:19 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1689788419;
        bh=8jqadUrLP+GDojjmPoLDIihhsoBB6VsVeLoCMFXOZXs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SgSUnYOSN8oYJy4ma5e1Y5O2G6mWv/uDrAjnCLeD0aUJ2wdovwZGOS1rPQm3xmeu1
         +AORNA0+ywiUSTqtaoG5N1IizNlnMnbzMOH3H+qxikyYW6BIopmyu7JllkgPTiL4RY
         SCfs8Oj/Ud/YSfmDZFARbOT0keb+yQc0NcQ7c4lqB1H3MylBkvxoYKsWBnut1msXkF
         BpIqMzuoN1q7yv2WG9uSi7ea3c5iTJApmpbz143/34AMXCNkVe4MOGQbW1ECtGZRZl
         xmI6U0htlAIRRNBc65dtTmo3rVHIyE6dlgcNz7Srle8D8ifiQlmux/CS7V/kn+y5Xa
         MyxVsgijPTOQQ==
Received: by jupiter.universe (Postfix, from userid 1000)
        id 22496480DA9; Wed, 19 Jul 2023 19:40:17 +0200 (CEST)
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Heiko Stuebner <heiko@sntech.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-rockchip@lists.infradead.org, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        kernel@collabora.com
Subject: [PATCH v1 2/2] arm64: dts: rockchip: rk3588s: Add USB3 host controller
Date:   Wed, 19 Jul 2023 19:40:15 +0200
Message-Id: <20230719174015.68153-3-sebastian.reichel@collabora.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230719174015.68153-1-sebastian.reichel@collabora.com>
References: <20230719174015.68153-1-sebastian.reichel@collabora.com>
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

RK3588 has three USB3 controllers. One of them is host-only and uses
the naneng-combphy. The other two are dual-role and using a different
PHY that is not yet supported upstream.

Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
 arch/arm64/boot/dts/rockchip/rk3588s.dtsi | 29 +++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3588s.dtsi b/arch/arm64/boot/dts/rockchip/rk3588s.dtsi
index b9b509257aaa..416581dd3bb5 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588s.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3588s.dtsi
@@ -443,6 +443,35 @@ usb_host1_ohci: usb@fc8c0000 {
 		status = "disabled";
 	};
 
+	usbhost3_0: usb@fcd00000 {
+		compatible = "rockchip,rk3588-dwc3-host", "rockchip,rk3399-dwc3";
+		clocks = <&cru REF_CLK_USB3OTG2>, <&cru SUSPEND_CLK_USB3OTG2>,
+			 <&cru ACLK_USB3OTG2>, <&cru CLK_UTMI_OTG2>,
+			 <&cru PCLK_PHP_ROOT>, <&cru CLK_PIPEPHY2_PIPE_U3_G>;
+		clock-names = "ref", "suspend", "bus", "utmi", "php", "pipe";
+		ranges;
+		resets = <&cru SRST_A_USB3OTG2>;
+		reset-names = "usb3-host";
+		#address-cells = <2>;
+		#size-cells = <2>;
+		status = "disabled";
+
+		usbhost_dwc3_0: usb@fcd00000 {
+			compatible = "snps,dwc3";
+			reg = <0x0 0xfcd00000 0x0 0x400000>;
+			interrupts = <GIC_SPI 222 IRQ_TYPE_LEVEL_HIGH 0>;
+			dr_mode = "host";
+			phys = <&combphy2_psu PHY_TYPE_USB3>;
+			phy-names = "usb3-phy";
+			phy_type = "utmi_wide";
+			snps,dis_enblslpm_quirk;
+			snps,dis-u2-freeclk-exists-quirk;
+			snps,dis-del-phy-power-chg-quirk;
+			snps,dis-tx-ipgap-linecheck-quirk;
+			snps,dis_rxdet_inp3_quirk;
+		};
+	};
+
 	sys_grf: syscon@fd58c000 {
 		compatible = "rockchip,rk3588-sys-grf", "syscon";
 		reg = <0x0 0xfd58c000 0x0 0x1000>;
-- 
2.40.1

