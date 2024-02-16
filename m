Return-Path: <linux-kernel+bounces-68379-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66D0B857974
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 10:55:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C6247B25FD9
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 09:55:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E17411F95B;
	Fri, 16 Feb 2024 09:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="vMBtceVO"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8699124B35;
	Fri, 16 Feb 2024 09:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708077119; cv=none; b=oxWOGoGghIZn/fPmttGOQh8BeRcrAFwYYXai3eLclcbnbn4RRa9eofOB/ZwzIrEyjJuRB7Qge/37GSmin66TTfXbJQEYX8rbE4DJBC3pgFocTpo1IgG2rp2q9EBAzDrnWgh8s/aX7E1W0iTFE7gTk3ywcs80mgQ3rivzA9kAVO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708077119; c=relaxed/simple;
	bh=yROMIqIoOVSo2FXVFME/TMKQSUfQnNfARoZHqmtZUXE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Zo1wchXF/kRTBpUwu2DoYsPWMPc5iTb3ZFQohyQx/DexTyTtMm1usKrPSCEIWLA1dOa2Rd0QUUBuSzRXM+Uk7jn6FRhDihqV+Ht6TfehYm8MMkUXJOfooP+XtIejeLLw+xpztOefqY7bXdjPq3IkKCH44YtJyO+ewgrv5imeC3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=vMBtceVO; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1708077115;
	bh=yROMIqIoOVSo2FXVFME/TMKQSUfQnNfARoZHqmtZUXE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=vMBtceVOtsEGY6H1ID0zF//+wnYKAG6zYamUnkWQbaCxE64tr7AWEYiZeRKinck5C
	 3qx0aUFv/3YkdnDIWgSRcQE2Db/usV9DUq7a1+ZgEjE8tpIQlIG/1dgYo0eXyeZPuw
	 wtSQ4HH5gdaYwrX3Dpob1wiODJbrucsnfkGkJgcvgiauocKCZ8yk76AD8mInGRu/6U
	 ngzjoU0rkTZAErX6TZ761UrXw/gwkAAUTNXndFXnh/UlxGJv6RJtX46QtvIbpHY+Eq
	 sd0+Ozuw+ca1HiBlaTZB4pELYnLKdo2/vMMJ3VQUnjzUfFl70HKuk/k3dvuBOwwGTy
	 VypEUbWao2ZZA==
Received: from shreeya.shreeya (ec2-34-240-57-77.eu-west-1.compute.amazonaws.com [34.240.57.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: shreeya)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 9D9863782084;
	Fri, 16 Feb 2024 09:51:51 +0000 (UTC)
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
	shawn.wen@rock-chips.com
Cc: kernel@collabora.com,
	linux-kernel@vger.kernel.org,
	linux-media@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-clk@vger.kernel.org,
	linux-dt@vger.kernel.org,
	linux-arm@lists.infradead.org,
	Shreeya Patel <shreeya.patel@collabora.com>
Subject: [PATCH 2/4] dt-bindings: media: Document bindings for HDMI RX Controller
Date: Fri, 16 Feb 2024 15:19:20 +0530
Message-Id: <20240216094922.257674-3-shreeya.patel@collabora.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240216094922.257674-1-shreeya.patel@collabora.com>
References: <20240216094922.257674-1-shreeya.patel@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Document bindings for the Synopsys DesignWare HDMI RX Controller.

Reviewed-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Signed-off-by: Shreeya Patel <shreeya.patel@collabora.com>
---
 .../bindings/media/snps,dw-hdmi-rx.yaml       | 128 ++++++++++++++++++
 1 file changed, 128 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/media/snps,dw-hdmi-rx.yaml

diff --git a/Documentation/devicetree/bindings/media/snps,dw-hdmi-rx.yaml b/Documentation/devicetree/bindings/media/snps,dw-hdmi-rx.yaml
new file mode 100644
index 000000000000..a70d96b548ee
--- /dev/null
+++ b/Documentation/devicetree/bindings/media/snps,dw-hdmi-rx.yaml
@@ -0,0 +1,128 @@
+# SPDX-License-Identifier: (GPL-3.0 OR BSD-2-Clause)
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
+      - const: rst_a
+      - const: rst_p
+      - const: rst_ref
+      - const: rst_biu
+
+  pinctrl-names:
+    const: default
+
+  memory-region:
+    maxItems: 1
+
+  hdmirx-5v-detection-gpios:
+    description: GPIO specifier for 5V detection.
+    maxItems: 1
+
+  rockchip,grf:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description:
+      The phandle of the syscon node for the GRF register.
+
+  rockchip,vo1_grf:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description:
+      The phandle of the syscon node for the VO1 GRF register.
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
+  - pinctrl-names
+  - hdmirx-5v-detection-gpios
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/rockchip,rk3588-cru.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
+    #include <dt-bindings/power/rk3588-power.h>
+    #include <dt-bindings/reset/rockchip,rk3588-cru.h>
+    hdmirx_ctrler: hdmirx-controller@fdee0000 {
+      compatible = "rockchip,rk3588-hdmirx-ctrler", "snps,dw-hdmi-rx";
+      reg = <0x0 0xfdee0000 0x0 0x6000>;
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
+      reset-names = "rst_a", "rst_p", "rst_ref", "rst_biu";
+      pinctrl-0 = <&hdmim1_rx_cec &hdmim1_rx_hpdin &hdmim1_rx_scl &hdmim1_rx_sda &hdmirx_5v_detection>;
+      pinctrl-names = "default";
+      memory-region = <&hdmirx_cma>;
+      hdmirx-5v-detection-gpios = <&gpio1 RK_PC6 GPIO_ACTIVE_LOW>;
+    };
-- 
2.39.2


