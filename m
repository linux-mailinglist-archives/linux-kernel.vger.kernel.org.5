Return-Path: <linux-kernel+bounces-116512-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F73388A04A
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 13:50:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5430C2A60BD
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 12:50:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E59D91C692;
	Mon, 25 Mar 2024 07:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="G8hd7UzZ"
Received: from mail-m92243.xmail.ntesmail.com (mail-m92243.xmail.ntesmail.com [103.126.92.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87A381A2F5E;
	Mon, 25 Mar 2024 04:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.126.92.243
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711340828; cv=none; b=tZ8u5EGzxJI+ZF3+7Ru0rXgj0AQC3d5LcO73hoJFj2DliccZs3gll0cStpVaUB8GC/5SDSf7h/CEzD62s+qMNXEk3CHhJs37LcDBIxBb640oVC2fdXTei3Ph39zivN0s36wrtxD76DxrydvQGLsH8mTafH62WU4V72DW9soCB5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711340828; c=relaxed/simple;
	bh=SN/GS0AZ+EUWn+mOIgLp5B2MlLhwKNw641U3Dmvv68g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=A9KNbysHq8Dwyc/4MItnPj1MMLgwwYRZx96TcDavzFF5PmMe25Euo0PLV6WnzI3tMmmTgJPrB7vA+lhSHSNYc0k313z1Bx/5BsjOaiieOcnWXButWu76hhzFUpbvti6KlyYGUk9sL7alTPh4f1muJJ6IGLeCqe6iQaLSaWRPj8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=G8hd7UzZ; arc=none smtp.client-ip=103.126.92.243
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
DKIM-Signature: a=rsa-sha256;
	b=G8hd7UzZoAdbA1wHmMGafPZkMMNd476Dw1t4XSX3Yv3G1NYOQryEFaXBLj4d+eXjS7R4Y3ypOxtTyS0vv2PkMV/FKUodn5Gyy66Ah8kSlgQzdC6Az/nU0yaiHbUxNy+jrjGEe7ZRze86al36eDaqhwZGUJofvHmhj3AAe2mhd2g=;
	c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
	bh=qNWQ0E2o06XH4CPhJnC+MNCo7SgW7ENaUR/eOaQ2c7o=;
	h=date:mime-version:subject:message-id:from;
Received: from localhost.localdomain (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTPA id 119807C0194;
	Mon, 25 Mar 2024 12:16:57 +0800 (CST)
From: Sugar Zhang <sugar.zhang@rock-chips.com>
To: heiko@sntech.de
Cc: linux-rockchip@lists.infradead.org,
	Sugar Zhang <sugar.zhang@rock-chips.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Michael Turquette <mturquette@baylibre.com>,
	Rob Herring <robh@kernel.org>,
	Stephen Boyd <sboyd@kernel.org>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 2/2] dt-bindings: clock: rockchip: Add support for clk input / output switch
Date: Mon, 25 Mar 2024 12:16:30 +0800
Message-Id: <1711340191-69588-2-git-send-email-sugar.zhang@rock-chips.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1711340191-69588-1-git-send-email-sugar.zhang@rock-chips.com>
References: <1711340191-69588-1-git-send-email-sugar.zhang@rock-chips.com>
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGkJNT1ZJGklCS05ITR9DHR5VEwETFh
	oSFyQUDg9ZV1kYEgtZQVlOQ1VJSVVMVUpKT1lXWRYaDxIVHRRZQVlPS0hVSk5DTUtIVUpLS1VKQl
	kG
X-HM-Tid: 0a8e73d3653b09d2kunm119807c0194
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6NxA6Gjo5FDMIFg02FQg2NEki
	IwpPCVFVSlVKTEpKSE9LSUpDSU9CVTMWGhIXVQgOHBoJVQETGhUcOwkUGBBWGBMSCwhVGBQWRVlX
	WRILWUFZTkNVSUlVTFVKSk9ZV1kIAVlBQk9MSzcG
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

This patch add support switch for clk-bidirection which located
at GRF, such as SAIx_MCLK_{IN OUT} which share the same pin.
and these config maybe located in many pieces of GRF,
which hard to addressed in one single clk driver. so, we add
this simple helper driver to address this situation.

In order to simplify implement and usage, and also for safety
clk usage (avoid high freq glitch), we set all clk out as disabled
(which means Input default for clk-bidrection) in the pre-stage,
such boot-loader or init by HW default. And then set a safety freq
before enable clk-out, such as "assign-clock-rates" or clk_set_rate
in drivers.

e.g.

1. mclk{out,in}_sai0 define:

  mclkin_sai0: mclkin-sai0 {
      compatible = "fixed-clock";
      #clock-cells = <0>;
      clock-frequency = <12288000>;
      clock-output-names = "mclk_sai0_from_io";
  };

  mclkout_sai0: mclkout-sai0@ff040070 {
      compatible = "rockchip,clk-out";
      reg = <0 0xff040070 0 0x4>;
      clocks = <&cru MCLK_SAI0_OUT2IO>;
      #clock-cells = <0>;
      clock-output-names = "mclk_sai0_to_io";
      rockchip,bit-shift = <4>;
      //example with PD if reg access needed
      power-domains = <&power RK3562_PD_VO>;
  };

Note:

clock-output-names of mclkin_sai0 should equal to strings in drivers. such as:

drivers/clk/rockchip/clk-rk3562.c:
PNAME(clk_sai0_p) = { "clk_sai0_src", "clk_sai0_frac", "xin_osc0_half", "mclk_sai0_from_io" };

2. mclkout_sai0 usage:

  &ext_codec {
      clocks = <&mclkout_sai0>;
      clock-names = "mclk";
      assigned-clocks = <&mclkout_sai0>;
      assigned-clock-rates = <12288000>;
      pinctrl-names = "default";
      pinctrl-0 = <&i2s0m0_mclk>;
  };

  clk_summary on sai0 work:

  cat /sys/kernel/debug/clk/clk_summary | egrep "pll|sai0"

  clk_sai0_src                1        1        0  1188000000          0     0  50000
    clk_sai0_frac             1        1        0    12288000          0     0  50000
      clk_sai0                1        1        0    12288000          0     0  50000
        mclk_sai0             1        1        0    12288000          0     0  50000
          mclk_sai0_out2io    1        1        0    12288000          0     0  50000
            mclk_sai0_to_io   1        1        0    12288000          0     0  50000

  example with PD if reg access needed:

  * PD status when mclk_sai0_to_io on:

  cat /sys/kernel/debug/pm_genpd/pm_genpd_summary

  domain                          status          children
    /device                                                runtime status
  ----------------------------------------------------------------------
  ...

  vo                              on
    /devices/platform/clocks/ff040070.mclkout-sai0         active
  ...

  * PD status when mclk_sai0_to_io off:

  cat /sys/kernel/debug/pm_genpd/pm_genpd_summary

  domain                          status          children
    /device                                                runtime status
  ----------------------------------------------------------------------
  ...

  vo                              off-0
    /devices/platform/clocks/ff040070.mclkout-sai0         suspended
  ...

3. mclkin_sai0 usage:

  please override freq of mclkin as the real external clkin, such as:

  &mclkin_sai0 {
      clock-frequency = <24576000>;
  }

  &ext_codec {
      clocks = <&mclkin_sai0>;
      clock-names = "mclk";
      assigned-clocks = <&cru CLK_SAI0>;
      assigned-clock-parents = <&mclkin_sai0>;
      pinctrl-names = "default";
      pinctrl-0 = <&i2s0m0_mclk>;
  };

  clk_summary on sai0 work:

  cat /sys/kernel/debug/clk/clk_summary | egrep "pll|sai0"

  mclk_sai0_from_io          1        1        0    12288000          0     0  50000
    clk_sai0                 1        1        0    12288000          0     0  50000
      mclk_sai0              1        1        0    12288000          0     0  50000
        mclk_sai0_out2io     0        0        0    12288000          0     0  50000
          mclk_sai0_to_io    0        0        0    12288000          0     0  50000

Signed-off-by: Sugar Zhang <sugar.zhang@rock-chips.com>
---

 .../bindings/clock/rockchip,clk-out.yaml           | 107 +++++++++++++++++++++
 1 file changed, 107 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/rockchip,clk-out.yaml

diff --git a/Documentation/devicetree/bindings/clock/rockchip,clk-out.yaml b/Documentation/devicetree/bindings/clock/rockchip,clk-out.yaml
new file mode 100644
index 0000000..6582605
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/rockchip,clk-out.yaml
@@ -0,0 +1,107 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/clock/rockchip,clk-out.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Rockchip Clock Out Control Module Binding
+
+maintainers:
+  - Sugar Zhang <sugar.zhang@rock-chips.com>
+
+description: |
+  This add support switch for clk-bidirection which located
+  at GRF, such as SAIx_MCLK_{IN OUT} which share the same pin.
+  and these config maybe located in many pieces of GRF,
+  which hard to addressed in one single clk driver. so, we add
+  this simple helper driver to address this situation.
+
+  In order to simplify implement and usage, and also for safety
+  clk usage (avoid high freq glitch), we set all clk out as disabled
+  (which means Input default for clk-bidrection) in the pre-stage,
+  such boot-loader or init by HW default. And then set a safety freq
+  before enable clk-out, such as "assign-clock-rates" or clk_set_rate
+  in drivers.
+
+properties:
+  compatible:
+    enum:
+      - rockchip,clk-out
+
+  reg:
+    maxItems: 1
+
+  "#clock-cells":
+    const: 1
+
+  clocks:
+    maxItems: 1
+    description: parent clocks.
+
+  power-domains:
+    maxItems: 1
+
+  clock-output-names:
+    maxItems: 1
+
+  rockchip,bit-shift:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: Defines the bit shift of clk out enable.
+
+  rockchip,bit-set-to-disable:
+    type: boolean
+    description: |
+      By default this clock sets the bit at bit-shift to enable the clock.
+      Setting this property does the opposite: setting the bit disable
+      the clock and clearing it enables the clock.
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - "#clock-cells"
+  - clock-output-names
+  - rockchip,bit-shift
+
+additionalProperties: false
+
+examples:
+  # Clock Provider node:
+  - |
+    mclkin_sai0: mclkin-sai0 {
+        compatible = "fixed-clock";
+        #clock-cells = <0>;
+        clock-frequency = <12288000>;
+        clock-output-names = "mclk_sai0_from_io";
+    };
+
+    mclkout_sai0: mclkout-sai0@ff040070 {
+        compatible = "rockchip,clk-out";
+        reg = <0 0xff040070 0 0x4>;
+        clocks = <&cru MCLK_SAI0_OUT2IO>;
+        #clock-cells = <0>;
+        clock-output-names = "mclk_sai0_to_io";
+        rockchip,bit-shift = <4>;
+    };
+
+  # Clock mclkout Consumer node:
+  - |
+    ext_codec {
+        clocks = <&mclkout_sai0>;
+        clock-names = "mclk";
+        assigned-clocks = <&mclkout_sai0>;
+        assigned-clock-rates = <12288000>;
+        pinctrl-names = "default";
+        pinctrl-0 = <&i2s0m0_mclk>;
+    };
+
+  # Clock mclkin Consumer node:
+  - |
+    ext_codec {
+        clocks = <&mclkin_sai0>;
+        clock-names = "mclk";
+        assigned-clocks = <&cru CLK_SAI0>;
+        assigned-clock-parents = <&mclkin_sai0>;
+        pinctrl-names = "default";
+        pinctrl-0 = <&i2s0m0_mclk>;
+    };
-- 
2.7.4


