Return-Path: <linux-kernel+bounces-135986-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8077989CE93
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 00:51:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EAAF91F235C3
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 22:51:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64D55146D40;
	Mon,  8 Apr 2024 22:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="P1ruVL0s"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C478C25570;
	Mon,  8 Apr 2024 22:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712616674; cv=none; b=rp13k4IZHOQScLO4P0rMXFpTlUS20IU1th43EKP27rZnB++qGD8I8BWUXo0xBaTuTMrglhYtO12gScBgSA3zkAqUC2eSJM/vA9tn7iZXO5NsVA11qa/piuNhQN2iJivGENGNd1PiXAsg5ukFP+hiqn1/fc8Gi2Jii4eOdDIMi5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712616674; c=relaxed/simple;
	bh=ev+tQTr8gTQ2A1HrDcPurjzutrjaEUDxOmoQnwQqNLg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tfcJCPVD9eXYYTdgKDC8H/qNnzRXqjgEBIv39vEMwv34CV3bVLdsVBXs1XV3sdiYP/Oc6CMruo+fHvBghSvgHGPI7rihB0W90ONP6etY3RypggIa4WPDPHcv5jvWQWy7MsTdfJ2WqQjizJK431su4hW+d7IqJz2ChA8i+/IC32Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=P1ruVL0s; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1712616670;
	bh=ev+tQTr8gTQ2A1HrDcPurjzutrjaEUDxOmoQnwQqNLg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=P1ruVL0slV7WpN8Hw7KU5BRFqHZL1ahW6UdWeDRtk0aIQOr9+HB95bpMWTdUPWLX7
	 VBLn3meCDKSiKDww7vnjElKojLHFFXKEzur66Zt+yrLXLpszhDrW+E3e5xl5OEHLgF
	 QIXRgYb4DiTSlszmQFrfqXiXVO98HO1CM7X+saBXxvELOlY2kyK1J/uj2fa3CAYsa0
	 ZuN9kBCHaM3zmpim190HU1SAWC4fteVNuhfAJESUjHptjX4tGlTz7tpiTakoSpmkis
	 DZrT32VLbM2cthgcHNpmQmQcHbFvTKVxq+kRsHUt6oUTccrFKsjjQTUoeQOFhLcMPF
	 Yh16fI2H1T5pQ==
Received: from jupiter.universe (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: sre)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 9E5AB37820A4;
	Mon,  8 Apr 2024 22:51:10 +0000 (UTC)
Received: by jupiter.universe (Postfix, from userid 1000)
	id 3B3534800CB; Tue,  9 Apr 2024 00:51:10 +0200 (CEST)
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
	kernel@collabora.com,
	Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v5 01/10] dt-bindings: phy: add rockchip usbdp combo phy document
Date: Tue,  9 Apr 2024 00:50:28 +0200
Message-ID: <20240408225109.128953-2-sebastian.reichel@collabora.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240408225109.128953-1-sebastian.reichel@collabora.com>
References: <20240408225109.128953-1-sebastian.reichel@collabora.com>
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
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
Reviewed-by: Heiko Stuebner <heiko@sntech.de>
Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
 .../bindings/phy/phy-rockchip-usbdp.yaml      | 148 ++++++++++++++++++
 1 file changed, 148 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/phy/phy-rockchip-usbdp.yaml

diff --git a/Documentation/devicetree/bindings/phy/phy-rockchip-usbdp.yaml b/Documentation/devicetree/bindings/phy/phy-rockchip-usbdp.yaml
new file mode 100644
index 000000000000..1f1f8863b80d
--- /dev/null
+++ b/Documentation/devicetree/bindings/phy/phy-rockchip-usbdp.yaml
@@ -0,0 +1,148 @@
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
+  "#phy-cells":
+    description: |
+      Cell allows setting the type of the PHY. Possible values are:
+      - PHY_TYPE_USB3
+      - PHY_TYPE_DP
+    const: 1
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
+    items:
+      maximum: 3
+    description:
+      An array of physical Type-C lanes indexes. Position of an entry
+      determines the DisplayPort (DP) lane index, while the value of an entry
+      indicates physical Type-C lane. The supported DP lanes number are 2 or 4.
+      e.g. for 2 lanes DP lanes map, we could have "rockchip,dp-lane-mux = <2,
+      3>;", assuming DP lane0 on Type-C phy lane2, DP lane1 on Type-C phy
+      lane3. For 4 lanes DP lanes map, we could have "rockchip,dp-lane-mux =
+      <0, 1, 2, 3>;", assuming DP lane0 on Type-C phy lane0, DP lane1 on Type-C
+      phy lane1, DP lane2 on Type-C phy lane2, DP lane3 on Type-C phy lane3. If
+      DP lanes are mapped by DisplayPort Alt mode, this property is not needed.
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
+  - "#phy-cells"
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
+      #phy-cells = <1>;
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
+    };
-- 
2.43.0


