Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1F5A7BB1C6
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 08:53:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230220AbjJFGxq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 02:53:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230184AbjJFGxp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 02:53:45 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26AA1EB;
        Thu,  5 Oct 2023 23:53:43 -0700 (PDT)
Received: from benjamin-XPS-13-9310.. (unknown [IPv6:2a01:e0a:120:3210:40dd:1541:8234:4d16])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: benjamin.gaignard)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 009216607336;
        Fri,  6 Oct 2023 07:53:40 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1696575221;
        bh=lxJjyV/iMvcHmNqd0VGLIe+5rW3S6hUI6UcED93hyTo=;
        h=From:To:Cc:Subject:Date:From;
        b=Ya3dxMsz3yXH4nuNnydhrYwXRinFUR/TJJYZ2h2HNQlkfeO1497C4raGKAhtEUygp
         1H0WzPmXABuaB/OOCl58KG3MDtWRz47YsN9bFhlo7Z88GKKD2MA4ah2xRF3v9XrZDu
         nXCMdxmWR3tMTLeF0c0qJO2HFfnStkHDRPMDAQYYdev7JE3YqiDlaOAat/f33UHLne
         OzfKau+q0b9i00z7E29FAMIOCeyH+qIv+yL16DDOK/sPLSfrLKRacai5/65epDRj9h
         qUyR+jntfMeXcAdmaJZMG6IAwJA7SaiThsUyv39Qy6JV0A5lFA6i7cjx6T+cY8m8Zi
         /3UHA6pK7MkEg==
From:   Benjamin Gaignard <benjamin.gaignard@collabora.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, heiko@sntech.de
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        Sebastian Reichel <sebastian.reichel@collabora.com>
Subject: [PATCH v3] arm64: dts: rockchip: rk3588s: Add AV1 decoder node
Date:   Fri,  6 Oct 2023 08:53:34 +0200
Message-Id: <20231006065334.8117-1-benjamin.gaignard@collabora.com>
X-Mailer: git-send-email 2.39.2
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

Add node for AV1 video decoder.

Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
version 3:
- remove status = "okay"

version 2:
- change node name to video-codec
- fix typo in commit header

 arch/arm64/boot/dts/rockchip/rk3588s.dtsi | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3588s.dtsi b/arch/arm64/boot/dts/rockchip/rk3588s.dtsi
index 5544f66c6ff4..5481f59f551f 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588s.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3588s.dtsi
@@ -2304,6 +2304,19 @@ gpio4: gpio@fec50000 {
 			#interrupt-cells = <2>;
 		};
 	};
+
+	av1d: video-codec@fdc70000 {
+		compatible = "rockchip,rk3588-av1-vpu";
+		reg = <0x0 0xfdc70000 0x0 0x800>;
+		interrupts = <GIC_SPI 108 IRQ_TYPE_LEVEL_HIGH 0>;
+		interrupt-names = "vdpu";
+		clocks = <&cru ACLK_AV1>, <&cru PCLK_AV1>;
+		clock-names = "aclk", "hclk";
+		assigned-clocks = <&cru ACLK_AV1>, <&cru PCLK_AV1>;
+		assigned-clock-rates = <400000000>, <400000000>;
+		resets = <&cru SRST_A_AV1>, <&cru SRST_P_AV1>, <&cru SRST_A_AV1_BIU>, <&cru SRST_P_AV1_BIU>;
+		power-domains = <&power RK3588_PD_AV1>;
+	};
 };
 
 #include "rk3588s-pinctrl.dtsi"
-- 
2.39.2

