Return-Path: <linux-kernel+bounces-59785-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F64884FBBB
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 19:19:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 955EFB29263
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 18:19:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FAF98287B;
	Fri,  9 Feb 2024 18:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="ZkHFi/Rn"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13B5D7EF1B;
	Fri,  9 Feb 2024 18:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707502716; cv=none; b=YFezuN9XnalSz3BnQ2YrWHXKKR016QZvOkxsnd9g6UAc9elPvYVQoEBVz1RUSsIKRwBkEshh/NRt1se68bN1DrZP8Fbqzw2TEHXJipbouPH51TRQlxFLq+qzeEQ/CsuS/rKdr3JRuoxT6gGhluLVw/HBCc4pU5qpIMxCs09LgjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707502716; c=relaxed/simple;
	bh=xZcm+orw00B6Nq4H2S1rryWFpOh727WR5BMjfMSxMew=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D/sDS18w5UG74QqNyrflfdi6i4LWxClWxzB+k9Zpt1cDda92ZDGq60wgLgwDnpfCkr+u3M6oWXnz0ULi1SwTns1VBXir2D8csq0eGePnP1qE40tgQBKp/ucftlzyMqTex9IVyXdwjDjvIL8a5eabF8oxBlWabb3+kxOUA2Ef5dM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=ZkHFi/Rn; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1707502713;
	bh=xZcm+orw00B6Nq4H2S1rryWFpOh727WR5BMjfMSxMew=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZkHFi/RnV1PYk4lpnI59yDDYJ/BooxzDGd0zHXCBNrPTb5ujilZPNJ5phoTFHRLbO
	 DBDZHdmImQwVLljhWQCwXlGFOuz5unduh6X59QJFLvDUznAyi/BLep3rhnFAiCZOFb
	 ZWrjyJ4C/8jrbkp7V+ynRAwvApyy4hlnhXNPo28ZQuYscoUCMS4vMMcRK+kR2LJBIr
	 9rGbx4u2bjQmX/Yj7cLJSt/xaZkjX+BgtXDqQihNiAPYv4NkL+KFbOY2Os7AsulOyd
	 xGJHHbwPJxEIMnqIsjvvk5JK1z4osf3uqD3d9a+XQeNq+cyIns04jREZvQNOgtlxsA
	 Q/5Wl6+nFMTjg==
Received: from jupiter.universe (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: sre)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 0A4E5378209E;
	Fri,  9 Feb 2024 18:18:33 +0000 (UTC)
Received: by jupiter.universe (Postfix, from userid 1000)
	id 91DC84800D1; Fri,  9 Feb 2024 19:18:32 +0100 (CET)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Heiko Stuebner <heiko@sntech.de>,
	Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	linux-rockchip@lists.infradead.org,
	linux-phy@lists.infradead.org
Cc: Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Frank Wang <frank.wang@rock-chips.com>,
	Kever Yang <kever.yang@rock-chips.com>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Sebastian Reichel <sebastian.reichel@collabora.com>,
	kernel@collabora.com
Subject: [PATCH v1 03/10] dt-bindings: phy: add rockchip usbdp combo phy document
Date: Fri,  9 Feb 2024 19:17:19 +0100
Message-ID: <20240209181831.104687-4-sebastian.reichel@collabora.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240209181831.104687-1-sebastian.reichel@collabora.com>
References: <20240209181831.104687-1-sebastian.reichel@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add device tree binding document for Rockchip USBDP Combo PHY
with Samsung IP block.

Co-developed-by: Frank Wang <frank.wang@rock-chips.com>
Signed-off-by: Frank Wang <frank.wang@rock-chips.com>
Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
 .../bindings/phy/phy-rockchip-usbdp.yaml      | 166 ++++++++++++++++++
 1 file changed, 166 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/phy/phy-rockchip-usbdp.yaml

diff --git a/Documentation/devicetree/bindings/phy/phy-rockchip-usbdp.yaml b/Documentation/devicetree/bindings/phy/phy-rockchip-usbdp.yaml
new file mode 100644
index 000000000000..3375a3099038
--- /dev/null
+++ b/Documentation/devicetree/bindings/phy/phy-rockchip-usbdp.yaml
@@ -0,0 +1,166 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/phy/phy-rockchip-usbdp.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Rockchip USBDP Combo PHY with Samsung IP block
+
+maintainers:
+  - Frank Wang <frank.wang@rock-chips.com>
+  - Zhang Yubing <yubing.zhang@rock-chips.com>
+
+properties:
+  compatible:
+    enum:
+      - rockchip,rk3588-usbdp-phy
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    maxItems: 4
+
+  clock-names:
+    items:
+      - const: refclk
+      - const: immortal
+      - const: pclk
+      - const: utmi
+
+  resets:
+    maxItems: 5
+
+  reset-names:
+    items:
+      - const: init
+      - const: cmn
+      - const: lane
+      - const: pcs_apb
+      - const: pma_apb
+
+  rockchip,dp-lane-mux:
+    $ref: /schemas/types.yaml#/definitions/uint32-array
+    minItems: 2
+    maxItems: 4
+    description:
+      An array of physical Tyep-C lanes indexes. Position of an entry determines
+      the dp lane index, while the value of an entry indicater physical Type-C lane.
+      The support dp lanes number are 2 or 4. e.g. for 2 lanes dp lanes map, we could
+      have "rockchip,dp-lane-mux = <2, 3>;", assuming dp lane0 on Type-C phy lane2,
+      dp lane1 on Type-C phy lane3. For 4 lanes dp lanes map, we could have
+      "rockchip,dp-lane-mux = <0, 1, 2, 3>;", assuming dp lane0 on Type-C phy lane0,
+      dp lane1 on Type-C phy lane1, dp lane2 on Type-C phy lane2, dp lane3 on Type-C
+      phy lane3. If dp lane map by DisplayPort Alt mode, this property is not need.
+
+  rockchip,u2phy-grf:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description:
+      Phandle to the syscon managing the 'usb2 phy general register files'.
+
+  rockchip,usb-grf:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description:
+      Phandle to the syscon managing the 'usb general register files'.
+
+  rockchip,usbdpphy-grf:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description:
+      Phandle to the syscon managing the 'usbdp phy general register files'.
+
+  rockchip,vo-grf:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description:
+      Phandle to the syscon managing the 'video output general register files'.
+      When select the dp lane mapping will request its phandle.
+
+  sbu1-dc-gpios:
+    description:
+      GPIO connected to the SBU1 line of the USB-C connector via a big resistor
+      (~100K) to apply a DC offset for signalling the connector orientation.
+
+  sbu2-dc-gpios:
+    description:
+      GPIO connected to the SBU2 line of the USB-C connector via a big resistor
+      (~100K) to apply a DC offset for signalling the connector orientation.
+
+  orientation-switch:
+    description: Flag the port as possible handler of orientation switching
+    type: boolean
+
+  mode-switch:
+    description: Flag the port as possible handle of altmode switching
+    type: boolean
+
+  dp-port:
+    type: object
+    additionalProperties: false
+
+    properties:
+      "#phy-cells":
+        const: 0
+
+    required:
+      - "#phy-cells"
+
+  usb3-port:
+    type: object
+    additionalProperties: false
+
+    properties:
+      "#phy-cells":
+        const: 0
+
+    required:
+      - "#phy-cells"
+
+  port:
+    $ref: /schemas/graph.yaml#/properties/port
+    description:
+      A port node to link the PHY to a TypeC controller for the purpose of
+      handling orientation switching.
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - clock-names
+  - resets
+  - reset-names
+  - dp-port
+  - usb3-port
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/rockchip,rk3588-cru.h>
+    #include <dt-bindings/reset/rockchip,rk3588-cru.h>
+
+    usbdp_phy0: phy@fed80000 {
+      compatible = "rockchip,rk3588-usbdp-phy";
+      reg = <0xfed80000 0x10000>;
+      rockchip,u2phy-grf = <&usb2phy0_grf>;
+      rockchip,usb-grf = <&usb_grf>;
+      rockchip,usbdpphy-grf = <&usbdpphy0_grf>;
+      rockchip,vo-grf = <&vo0_grf>;
+      clocks = <&cru CLK_USBDPPHY_MIPIDCPPHY_REF>,
+               <&cru CLK_USBDP_PHY0_IMMORTAL>,
+               <&cru PCLK_USBDPPHY0>,
+               <&u2phy0>;
+      clock-names = "refclk", "immortal", "pclk", "utmi";
+      resets = <&cru SRST_USBDP_COMBO_PHY0_INIT>,
+               <&cru SRST_USBDP_COMBO_PHY0_CMN>,
+               <&cru SRST_USBDP_COMBO_PHY0_LANE>,
+               <&cru SRST_USBDP_COMBO_PHY0_PCS>,
+               <&cru SRST_P_USBDPPHY0>;
+      reset-names = "init", "cmn", "lane", "pcs_apb", "pma_apb";
+
+      usbdp_phy0_dp: dp-port {
+        #phy-cells = <0>;
+      };
+
+      usbdp_phy0_u3: usb3-port {
+        #phy-cells = <0>;
+      };
+    };
-- 
2.43.0


