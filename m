Return-Path: <linux-kernel+bounces-31519-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 98DC9832F70
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 20:38:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 508D31F24862
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 19:38:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B32256772;
	Fri, 19 Jan 2024 19:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="Y7esV1ww"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB8C71E4A8;
	Fri, 19 Jan 2024 19:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705693094; cv=none; b=aXFNFLQl/Em26Jl1MpRJtdqNEvofqeKDUBXNwej857ry2FKGA5GMiOMNph15BvQuyM9wdHJYT4hcqUYa1uCTbHRc0zWx6uHYBV8DSHVSpU7iEYydHiW3W6KhPN6Jgd98aCjtFI9VcbuQlx22vTdkZonyoAY+i5jAj5PNSZUdPX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705693094; c=relaxed/simple;
	bh=UiKN/wzt2VTmVDCklnrDfyuyegL48RVt7U2udrBOTgo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SH1a5yE6Q3gHJKv6T5vXTY9pqS2aWeGLZDQepj+pvXKDKhJYXFtQU6CevRsfaaw49/GNvBpwY2AkaFEIbCiVAIzCmbzOu04E8A0+cgHyX0eXk6+nxr9YR0ncJp2si+EnDUgYjcrnnh/qLp1iUdFFSAGSWMtsE/6ISzS5XcQ80RU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=Y7esV1ww; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1705693091;
	bh=UiKN/wzt2VTmVDCklnrDfyuyegL48RVt7U2udrBOTgo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Y7esV1ww9FoQwrw6eE23ZrECWdlVd6hxgSo5ucA047ZlPDkVwLqejHHeT/MkkALxx
	 JeC6QdY5IIQg+2DfATdq0jZ7p9T4oaXCq8F6CAC6TD/zXAiYOmu6O+XJwWOeBgm5R+
	 YnEj/qOUV79GykMJBV/2i2msA9yRplfM2Pszm3w1XyyF7w13Tk+3e+QtMdTyWX1RNb
	 zPnM0Nk+hVC6q9VaRX7ZnYoNfSJf0kBgdVuyKfouAgbA9dRepyNCW2Ml0FMkfkXw5/
	 oyUibKwmOWkxjJ5zlzYJM+uKvfbEMjdRY9nkFc6ufBNaC34OzFWNoRL8iwRwjLBAUy
	 nRfGe8JwfyJww==
Received: from localhost (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: cristicc)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 205CF3782088;
	Fri, 19 Jan 2024 19:38:11 +0000 (UTC)
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
To: Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Johan Jonker <jbx6244@gmail.com>,
	Sebastian Reichel <sebastian.reichel@collabora.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Andy Yan <andy.yan@rock-chips.com>,
	Algea Cao <algea.cao@rock-chips.com>
Cc: linux-phy@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	kernel@collabora.com
Subject: [PATCH 2/3] dt-bindings: phy: Add Rockchip HDMI/DP Combo PHY schema
Date: Fri, 19 Jan 2024 21:38:02 +0200
Message-ID: <20240119193806.1030214-3-cristian.ciocaltea@collabora.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240119193806.1030214-1-cristian.ciocaltea@collabora.com>
References: <20240119193806.1030214-1-cristian.ciocaltea@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add dt-binding schema for the Rockchip HDMI/DP Transmitter Combo PHY
found on RK3588 SoC.

Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
---
 .../phy/rockchip,rk3588-hdptx-phy.yaml        | 96 +++++++++++++++++++
 1 file changed, 96 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/phy/rockchip,rk3588-hdptx-phy.yaml

diff --git a/Documentation/devicetree/bindings/phy/rockchip,rk3588-hdptx-phy.yaml b/Documentation/devicetree/bindings/phy/rockchip,rk3588-hdptx-phy.yaml
new file mode 100644
index 000000000000..dd357994ba1b
--- /dev/null
+++ b/Documentation/devicetree/bindings/phy/rockchip,rk3588-hdptx-phy.yaml
@@ -0,0 +1,96 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/phy/rockchip,rk3588-hdptx-phy.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Rockchip SoC HDMI/DP Transmitter Combo PHY
+
+maintainers:
+  - Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
+
+properties:
+  compatible:
+    enum:
+      - rockchip,rk3588-hdptx-phy
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    items:
+      - description: Reference clock
+      - description: APB clock
+
+  clock-names:
+    items:
+      - const: ref
+      - const: apb
+
+  "#phy-cells":
+    const: 0
+
+  resets:
+    items:
+      - description: PHY reset line
+      - description: APB reset line
+      - description: INIT reset line
+      - description: CMN reset line
+      - description: LANE reset line
+      - description: ROPLL reset line
+      - description: LCPLL reset line
+
+  reset-names:
+    items:
+      - const: phy
+      - const: apb
+      - const: init
+      - const: cmn
+      - const: lane
+      - const: ropll
+      - const: lcpll
+
+  rockchip,grf:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description: Some PHY related data is accessed through GRF regs.
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - clock-names
+  - "#phy-cells"
+  - resets
+  - reset-names
+  - rockchip,grf
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/rockchip,rk3588-cru.h>
+    #include <dt-bindings/reset/rockchip,rk3588-cru.h>
+
+    soc {
+      #address-cells = <2>;
+      #size-cells = <2>;
+
+      hdptxphy_grf: syscon@fd5e0000 {
+        compatible = "rockchip,rk3588-hdptxphy-grf", "syscon";
+        reg = <0x0 0xfd5e0000 0x0 0x100>;
+      };
+
+      hdptxphy: phy@fed60000 {
+        compatible = "rockchip,rk3588-hdptx-phy";
+        reg = <0x0 0xfed60000 0x0 0x2000>;
+        clocks = <&cru CLK_USB2PHY_HDPTXRXPHY_REF>, <&cru PCLK_HDPTX0>;
+        clock-names = "ref", "apb";
+        #phy-cells = <0>;
+        resets = <&cru SRST_HDPTX0>, <&cru SRST_P_HDPTX0>,
+                 <&cru SRST_HDPTX0_INIT>, <&cru SRST_HDPTX0_CMN>,
+                 <&cru SRST_HDPTX0_LANE>, <&cru SRST_HDPTX0_ROPLL>,
+                 <&cru SRST_HDPTX0_LCPLL>;
+        reset-names = "phy", "apb", "init", "cmn", "lane", "ropll", "lcpll";
+        rockchip,grf = <&hdptxphy_grf>;
+      };
+    };
-- 
2.43.0


