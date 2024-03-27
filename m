Return-Path: <linux-kernel+bounces-122119-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 195BF88F214
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 23:52:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 84717B23956
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 22:52:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74A2015443F;
	Wed, 27 Mar 2024 22:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="q3/sPLlC"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD645153839;
	Wed, 27 Mar 2024 22:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711579943; cv=none; b=NsRK4QbE80+yxs1e7MiYPGP+vzqm2GMyMXMEnpvwJj3w1W0jI4d/qXtBjZKH3XQJd6jWeQHBfJ3JfK4iDL2C1uleOq9NSX2Zit7doAKpdkYWwhvR2DlHnp9L8fU/0NAQYQjqAzdmTDOc0nbu4vAV/yNauiyamrKkEhIcNjvh6Ic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711579943; c=relaxed/simple;
	bh=h0ZBwIl/NO2gbj0PToI9gl/9W/r1616P4CcpEQreKoI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=r0A9EKRUzkID5EkckODID+3VVCsWnWqmwTPAXR61i6rvUueaP9PCkDxXctEYxtX+sOTgvCzg6D0SnFpiXAYkZ8h8M9BtKuc5trcDZsiX95yV7yIhGBYK/uYCzeKyj/JcS/83x90CoR3HjK7Y7X4Lwum5PaBEyhQUgzUQE2cNDYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=q3/sPLlC; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1711579940;
	bh=h0ZBwIl/NO2gbj0PToI9gl/9W/r1616P4CcpEQreKoI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=q3/sPLlCaTRBmoHmx+6eiQ8ALmsp2Ce0Wy4TM5dUCUuBWVLClbIeTh9Uy0cI8KafC
	 DSK3zhuZNMHkG82XVLUwZPelb3kFtEe52MtDpMI5waQjrdTQGRkDUa1s44KkrEesV+
	 PJVmavWaaO28Y2S+FT5sMpaVXwisaXHC4qaMfttcDI9mkwHoy4iuM9c/NlsUj16QIJ
	 TgZmNuqX9tHjB1zvPZLnB4b1fAJfOERvqtKnohUJGBKmA5r5GTyNdPyvmuSn3VQ2Iq
	 hoEnxceAC/fHIuy4p8LNIdM7vYDutoTNWbNJfb4/WPN1+LQyeeg18FuI8oGa2vDKH5
	 SjRKPiFc9QXkg==
Received: from shreeya.shreeya (ec2-34-240-57-77.eu-west-1.compute.amazonaws.com [34.240.57.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: shreeya)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 3EDB03782112;
	Wed, 27 Mar 2024 22:52:12 +0000 (UTC)
From: Shreeya Patel <shreeya.patel@collabora.com>
To: heiko@sntech.de,
	mchehab@kernel.org,
	robh@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	mturquette@baylibre.com,
	sboyd@kernel.org,
	p.zabel@pengutronix.de,
	jose.abreu@synopsys.com,
	nelson.costa@synopsys.com,
	dmitry.osipenko@collabora.com,
	sebastian.reichel@collabora.com,
	shawn.wen@rock-chips.com,
	nicolas.dufresne@collabora.com,
	hverkuil@xs4all.nl,
	hverkuil-cisco@xs4all.nl
Cc: kernel@collabora.com,
	linux-kernel@vger.kernel.org,
	linux-media@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-clk@vger.kernel.org,
	linux-arm@lists.infradead.org,
	Shreeya Patel <shreeya.patel@collabora.com>
Subject: [PATCH v3 3/6] dt-bindings: media: Document HDMI RX Controller
Date: Thu, 28 Mar 2024 04:20:54 +0530
Message-Id: <20240327225057.672304-4-shreeya.patel@collabora.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240327225057.672304-1-shreeya.patel@collabora.com>
References: <20240327225057.672304-1-shreeya.patel@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Document bindings for the Synopsys DesignWare HDMI RX Controller.

Reviewed-by: Rob Herring <robh@kernel.org>
Reviewed-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Signed-off-by: Shreeya Patel <shreeya.patel@collabora.com>
---
Changes in v3 :-
  - Rename hdmirx_cma to hdmi_receiver_cma
  - Add a Reviewed-by tag

Changes in v2 :-
  - Add a description for the hardware
  - Rename resets, vo1 grf and HPD properties
  - Add a proper description for grf and vo1-grf phandles
  - Rename the HDMI Input node name to hdmi-receiver
  - Improve the subject line
  - Include gpio header file in example to fix dt_binding_check failure

 .../bindings/media/snps,dw-hdmi-rx.yaml       | 132 ++++++++++++++++++
 1 file changed, 132 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/media/snps,dw-hdmi-rx.yaml

diff --git a/Documentation/devicetree/bindings/media/snps,dw-hdmi-rx.yaml b/Documentation/devicetree/bindings/media/snps,dw-hdmi-rx.yaml
new file mode 100644
index 000000000000..96ae1e2d2816
--- /dev/null
+++ b/Documentation/devicetree/bindings/media/snps,dw-hdmi-rx.yaml
@@ -0,0 +1,132 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+# Device Tree bindings for Synopsys DesignWare HDMI RX Controller
+
+---
+$id: http://devicetree.org/schemas/media/snps,dw-hdmi-rx.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Synopsys DesignWare HDMI RX Controller
+
+maintainers:
+  - Shreeya Patel <shreeya.patel@collabora.com>
+
+description:
+  Synopsys DesignWare HDMI Input Controller preset on RK3588 SoCs
+  allowing devices to receive and decode high-resolution video streams
+  from external sources like media players, cameras, laptops, etc.
+
+properties:
+  compatible:
+    items:
+      - const: rockchip,rk3588-hdmirx-ctrler
+      - const: snps,dw-hdmi-rx
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 3
+
+  interrupt-names:
+    items:
+      - const: cec
+      - const: hdmi
+      - const: dma
+
+  clocks:
+    maxItems: 7
+
+  clock-names:
+    items:
+      - const: aclk
+      - const: audio
+      - const: cr_para
+      - const: pclk
+      - const: ref
+      - const: hclk_s_hdmirx
+      - const: hclk_vo1
+
+  power-domains:
+    maxItems: 1
+
+  resets:
+    maxItems: 4
+
+  reset-names:
+    items:
+      - const: axi
+      - const: apb
+      - const: ref
+      - const: biu
+
+  memory-region:
+    maxItems: 1
+
+  hpd-gpios:
+    description: GPIO specifier for HPD.
+    maxItems: 1
+
+  rockchip,grf:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description:
+      The phandle of the syscon node for the general register file
+      containing HDMIRX PHY status bits.
+
+  rockchip,vo1-grf:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description:
+      The phandle of the syscon node for the Video Output GRF register
+      to enable EDID transfer through SDAIN and SCLIN.
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - interrupt-names
+  - clocks
+  - clock-names
+  - power-domains
+  - resets
+  - pinctrl-0
+  - hpd-gpios
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/rockchip,rk3588-cru.h>
+    #include <dt-bindings/gpio/gpio.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
+    #include <dt-bindings/power/rk3588-power.h>
+    #include <dt-bindings/reset/rockchip,rk3588-cru.h>
+    hdmi_receiver: hdmi-receiver@fdee0000 {
+      compatible = "rockchip,rk3588-hdmirx-ctrler", "snps,dw-hdmi-rx";
+      reg = <0xfdee0000 0x6000>;
+      interrupts = <GIC_SPI 177 IRQ_TYPE_LEVEL_HIGH 0>,
+                   <GIC_SPI 436 IRQ_TYPE_LEVEL_HIGH 0>,
+                   <GIC_SPI 179 IRQ_TYPE_LEVEL_HIGH 0>;
+      interrupt-names = "cec", "hdmi", "dma";
+      clocks = <&cru ACLK_HDMIRX>,
+               <&cru CLK_HDMIRX_AUD>,
+               <&cru CLK_CR_PARA>,
+               <&cru PCLK_HDMIRX>,
+               <&cru CLK_HDMIRX_REF>,
+               <&cru PCLK_S_HDMIRX>,
+               <&cru HCLK_VO1>;
+      clock-names = "aclk",
+                    "audio",
+                    "cr_para",
+                    "pclk",
+                    "ref",
+                    "hclk_s_hdmirx",
+                    "hclk_vo1";
+      power-domains = <&power RK3588_PD_VO1>;
+      resets = <&cru SRST_A_HDMIRX>, <&cru SRST_P_HDMIRX>,
+               <&cru SRST_HDMIRX_REF>, <&cru SRST_A_HDMIRX_BIU>;
+      reset-names = "axi", "apb", "ref", "biu";
+      memory-region = <&hdmi_receiver_cma>;
+      pinctrl-0 = <&hdmim1_rx_cec &hdmim1_rx_hpdin &hdmim1_rx_scl &hdmim1_rx_sda &hdmirx_5v_detection>;
+      pinctrl-names = "default";
+      hpd-gpios = <&gpio1 22 GPIO_ACTIVE_LOW>;
+    };
-- 
2.39.2


