Return-Path: <linux-kernel+bounces-117218-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C25488A8CA
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 17:18:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8E27C1C6286F
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 16:18:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFFB61C684;
	Mon, 25 Mar 2024 14:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="dd/SXS0L"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F7E41BC4C;
	Mon, 25 Mar 2024 14:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711376220; cv=none; b=qtJhMPX8FXuXtjE3T8q4cjcQXOAJufwV9HM6USGRqS5fbxsYUGD35K5x7nN7u5DWIehhjuE2EQGC3BdA1bvfejB+3kHXsVEbJ7oZaIQ0WoXr4FeedBGhz0iYmyVHHTjvv3PVdtbOj+qDDM0ZTXsBJGL4UAIbNOpPxA84BT6e2tg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711376220; c=relaxed/simple;
	bh=ev+tQTr8gTQ2A1HrDcPurjzutrjaEUDxOmoQnwQqNLg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T9TTjOE6JCeXi66/Kypz8Ox9F8ER5H3N6a2JC0asxGak4yXM8eBXV4JJSsAa2jxNjYeykhhX70yLL0UQNgmfaHV1WCMhKxMstVawU26G9xuE5yTykhkVrROkOziC4wxGOI04BhTGYeWrCwSqxgNkpxwvXSipfRBeH2DecO4c1ic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=dd/SXS0L; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1711376217;
	bh=ev+tQTr8gTQ2A1HrDcPurjzutrjaEUDxOmoQnwQqNLg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dd/SXS0LZhWs31Slr5K0m2VxoFrxEEpHm+m9UwW2PGs6laXjt3DVVMatlTCw/nx/O
	 cnzVaJLLoMlRNRiBmatbJfH4viin2VIvdAntGwPQMfZ5cAGPf15hZg0DzcfuvXB95F
	 9d5k1ZEOy/dMEvxAEXQUPYx7BtGQJJrcg+XhCVdh+sxfRbr8LW9LXS2wzhR7Hs0NCw
	 Bj5jBckjCIX59QfWsIod8OyUylbUs9nZ+xLFBgcdphk7HIAK/fYSa//8mcDvuC1b5A
	 RFeVBbL6uI5AOxLgzpq/FeBZgAP49PcmqZpWeliCXI3T8jdkPAhubPkH2ouEJprC8W
	 KpAiDTNgx4ghQ==
Received: from jupiter.universe (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: sre)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 043A53780EC6;
	Mon, 25 Mar 2024 14:16:57 +0000 (UTC)
Received: by jupiter.universe (Postfix, from userid 1000)
	id 925374800CB; Mon, 25 Mar 2024 15:16:56 +0100 (CET)
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
Subject: [PATCH v4 01/10] dt-bindings: phy: add rockchip usbdp combo phy document
Date: Mon, 25 Mar 2024 15:15:31 +0100
Message-ID: <20240325141653.84910-2-sebastian.reichel@collabora.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240325141653.84910-1-sebastian.reichel@collabora.com>
References: <20240325141653.84910-1-sebastian.reichel@collabora.com>
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


