Return-Path: <linux-kernel+bounces-63900-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A663E853630
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 17:36:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2C9B81F24942
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 16:36:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DDEA5FDC8;
	Tue, 13 Feb 2024 16:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="XgNaV36o"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 240481D6A5;
	Tue, 13 Feb 2024 16:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707842176; cv=none; b=ljWoyGwLgWygUoCOJarRcWLjwSqwtcVmNtko7bVe6jwruqMt/Zkse9HjDbRJ/0izg5Fv+BCsCZtoy4L6svRbRs+qqlhOKE0IlmkWBVSeOrwv/t7kk/uyqwLcvwiNjyCOCxD6jGHO8XNVYWttnTp66Qm8qB1CGQQL1EQR3bLhGnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707842176; c=relaxed/simple;
	bh=yuTb4jTuPyK9zd2erSEPdlQNmlWtp4FbFwTZNwaDxN8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TTNTXA96rkE/EeBmgsJ7ZJZPnNKGSdBqg+YABprrKUwMWw+HfFXMYlk3o1nSUjJwllAzWNtrrIU0xBsbjIrdkLQ4DBC1D1Z0vXA3OidPAwwR+2iY+gB80QAC8prpm/BEka4MVYp3MVo3s4/9zbVF/zFKCpGG89MmBwNElW/k3Nw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=XgNaV36o; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1707842171;
	bh=yuTb4jTuPyK9zd2erSEPdlQNmlWtp4FbFwTZNwaDxN8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XgNaV36oFN6QVdrz4MFhcnNMjpUv5SRVujrj+NlZg/mMYsZbyqaPg6WymMA1ydebe
	 eWNf5JFgYsQAsNTBMkxFhX1CdBGYJkVCA7cQTkMx8I6be5C0mt4IjyQNqFPeyBvgin
	 Vs2Edx1n4CIcQFYOfcqQycYJJ+cfngSfvhpHKHI5bMXNcR/ONSRgvCI4Kj7TwIrDsM
	 bqI5zu+HNfkJfMxBhfnAYhK/ar3W8QT72MyUpPcqSxrsZU4YGAPRARnEVp7uav41uI
	 dXr9RA3KZXw/8pAvE1EH722KlzX+Z5dX+pVmu498jLQPy1YPPUXYBfIliz2Gs33AKU
	 sSIFq8Yqq/utA==
Received: from jupiter.universe (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: sre)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 5A7013782073;
	Tue, 13 Feb 2024 16:36:11 +0000 (UTC)
Received: by jupiter.universe (Postfix, from userid 1000)
	id F38AF4800D1; Tue, 13 Feb 2024 17:36:10 +0100 (CET)
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
Subject: [PATCH v2 03/12] dt-bindings: phy: add rockchip usbdp combo phy document
Date: Tue, 13 Feb 2024 17:32:37 +0100
Message-ID: <20240213163609.44930-4-sebastian.reichel@collabora.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240213163609.44930-1-sebastian.reichel@collabora.com>
References: <20240213163609.44930-1-sebastian.reichel@collabora.com>
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
 .../bindings/phy/phy-rockchip-usbdp.yaml      | 169 ++++++++++++++++++
 1 file changed, 169 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/phy/phy-rockchip-usbdp.yaml

diff --git a/Documentation/devicetree/bindings/phy/phy-rockchip-usbdp.yaml b/Documentation/devicetree/bindings/phy/phy-rockchip-usbdp.yaml
new file mode 100644
index 000000000000..4ac1825144d7
--- /dev/null
+++ b/Documentation/devicetree/bindings/phy/phy-rockchip-usbdp.yaml
@@ -0,0 +1,169 @@
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
+      An array of physical Type-C lanes indexes. Position of an entry
+      determines the DisplayPort (DP) lane index, while the value of an entry
+      indicates physical Type-C lane. The supported DP lanes number are 2 or 4.
+      e.g. for 2 lanes DP lanes map, we could have "rockchip,dp-lane-mux = <2,
+      3>;", assuming DP lane0 on Type-C phy lane2, DP lane1 on Type-C phy
+      lane3. For 4 lanes DP lanes map, we could have "rockchip,dp-lane-mux =
+      <0, 1, 2, 3>;", assuming DP lane0 on Type-C phy lane0, DP lane1 on Type-C
+      phy lane1, DP lane2 on Type-C phy lane2, DP lane3 on Type-C phy lane3. If
+      DP lane map by DisplayPort Alt mode, this property is not need.
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
+      When select the DP lane mapping will request its phandle.
+
+  sbu1-dc-gpios:
+    description:
+      GPIO connected to the SBU1 line of the USB-C connector via a big resistor
+      (~100K) to apply a DC offset for signalling the connector orientation.
+    maxItems: 1
+
+  sbu2-dc-gpios:
+    description:
+      GPIO connected to the SBU2 line of the USB-C connector via a big resistor
+      (~100K) to apply a DC offset for signalling the connector orientation.
+    maxItems: 1
+
+  orientation-switch:
+    description: Flag the port as possible handler of orientation switching
+    type: boolean
+
+  mode-switch:
+    description: Flag the port as possible handler of altmode switching
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
+      rockchip,u2phy-grf = <&usb2phy0_grf>;
+      rockchip,usb-grf = <&usb_grf>;
+      rockchip,usbdpphy-grf = <&usbdpphy0_grf>;
+      rockchip,vo-grf = <&vo0_grf>;
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


