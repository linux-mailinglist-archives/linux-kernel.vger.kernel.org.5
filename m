Return-Path: <linux-kernel+bounces-36029-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA519839A5A
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 21:36:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1AD35B22493
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 20:36:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5752F566A;
	Tue, 23 Jan 2024 20:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d+UAeiMm"
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE96E1FC8;
	Tue, 23 Jan 2024 20:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706042173; cv=none; b=pfi41LILwCd4XvunHk8c/D0qUr4O0+bctrR0XihVkCsK4EYPmC3YattX8sJaObjoH65/3r4M4HRjQQ/kWx+Z0IW6FJlo3TAKG8IY6YTBIpm8oCxi1FGjp4x5gcrUHwNBjZoa5Un1AyRGQiI87KqH3hbpZpTpl0sHGYOIGjstQwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706042173; c=relaxed/simple;
	bh=tpeWXxPW9y0R5ANl3dpUfOq3RGhBakzINSXMqQQKvkc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y3JJpPOGpc1DHcg4AiWhBYAxUzmtVMOtsTh+fwVay7s56NELhSVXPJIWQCCadtr+XvZqpdo9A4WqiS/0lThjNxyRtFeyQ84YWfxbGAgNo+b8+L+fUsETM3h/kHIf57zfn3fe0DvZ3SItAHX9K8yRhFkKu1hpOTHdR/XIXfGqqn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d+UAeiMm; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-55a6833c21eso3486876a12.2;
        Tue, 23 Jan 2024 12:36:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706042170; x=1706646970; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sKk0NSJH0NwGKwQItSQOBruTltCGsF+0CI7v15bHwUA=;
        b=d+UAeiMmuBsifASQ5UCPiBLtvBD7P7ntTwtWeqVCs3DmL/Iu/dpuw97EAAVQrkg76w
         d9sIq/krT4UsTupm0LbxYwWIbQ6sNurG8V7t/76Epe5lW27wLRdrANmpZQF6RTIxhsrd
         8IQnE7dnZjGYZBbhea1tKDTVLfQxKeSWhx0ZTCfQsl3pfMALpZKgY3QWZ6zw3XLZZf/X
         2bTzXKgPOHPegu8moYJ0sldNALjsxgHnRuqA5KwDYUAXD2/jnFAS46TSxDuGb/ZBWi5m
         YH4jGZas0wZVVCffVlnTqHZqhfcSaK7ogp07UyJpMAWsXq4WC1/cT10JTq8D6Eql5V8g
         RZzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706042170; x=1706646970;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sKk0NSJH0NwGKwQItSQOBruTltCGsF+0CI7v15bHwUA=;
        b=FIDeo99nLtkneja90DJpCfrQeudH+zjM3D8IFBSbvDn41u5VHjZ99n0qimZGt4p44M
         0UY6EDrA/OkZRlXr7L1DWOx/4YlcMp7gJgkZF//BVK+5Ht0/qgSOy13EFpgy8cYJjWSp
         0GgazzNA4s4oWClLN02B3TXQKocfuTDxISQ/XZEr84klBTdSfNP86b/rxJjb6hQtxV8z
         c+yqXHU2+tx2/mt+EifvX5wKNccg7a0WI+YFKAXME4xFDOrE1OAnR+ZQa5Z7l5dWew2V
         iknaw/+QcTNjlaquXu7beMtpEu027ybLY499VxRnxJuTu8AD0IAi9Fto53CGbI+H3WE7
         REBg==
X-Gm-Message-State: AOJu0YyWILmrvjjoQQB368m1V54v5OV4HrWXhEa1dmq6mPk/K0mHGSXW
	ZnNEfppOvME7dtOh5tHdp7de+bXeoaL2emSpA5irzLH6i34w22bP
X-Google-Smtp-Source: AGHT+IFrntAG2c+65PMTnJxHtXEpgq6m+V4Wl1viT1RHyMVIsu7KHolMFly7MjDqUYBqQfxNwUsfgg==
X-Received: by 2002:a05:6402:4304:b0:55c:7cad:db35 with SMTP id m4-20020a056402430400b0055c7caddb35mr1401656edc.43.1706042170008;
        Tue, 23 Jan 2024 12:36:10 -0800 (PST)
Received: from localhost.localdomain ([2a02:8109:aa27:2d00::d069])
        by smtp.gmail.com with ESMTPSA id h26-20020aa7c95a000000b005590dc6a4f6sm13227886edt.80.2024.01.23.12.36.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jan 2024 12:36:09 -0800 (PST)
From: Mehdi Djait <mehdi.djait.k@gmail.com>
To: mchehab@kernel.org,
	heiko@sntech.de,
	hverkuil-cisco@xs4all.nl,
	krzysztof.kozlowski+dt@linaro.org,
	robh+dt@kernel.org,
	conor+dt@kernel.org
Cc: linux-media@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	thomas.petazzoni@bootlin.com,
	alexandre.belloni@bootlin.com,
	maxime.chevallier@bootlin.com,
	paul.kocialkowski@bootlin.com,
	michael.riesch@wolfvision.net,
	laurent.pinchart@ideasonboard.com,
	Mehdi Djait <mehdi.djait.k@gmail.com>,
	Mehdi Djait <mehdi.djait@bootlin.com>,
	Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v13 1/3] media: dt-bindings: media: add bindings for Rockchip CIF
Date: Tue, 23 Jan 2024 21:36:02 +0100
Message-ID: <1742a08ce62e5163a4291c992f784475a3474045.1706041950.git.mehdi.djait.k@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1706041950.git.mehdi.djait.k@gmail.com>
References: <cover.1706041950.git.mehdi.djait.k@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mehdi Djait <mehdi.djait@bootlin.com>

Add a documentation for the Rockchip Camera Interface binding.

Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
Reviewed-by: Michael Riesch <michael.riesch@wolfvision.net>
Signed-off-by: Mehdi Djait <mehdi.djait@bootlin.com>
Signed-off-by: Mehdi Djait <mehdi.djait.k@gmail.com>
---
 .../bindings/media/rockchip,px30-vip.yaml     | 123 ++++++++++++++++++
 1 file changed, 123 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/media/rockchip,px30-vip.yaml

diff --git a/Documentation/devicetree/bindings/media/rockchip,px30-vip.yaml b/Documentation/devicetree/bindings/media/rockchip,px30-vip.yaml
new file mode 100644
index 000000000000..6af4a9b6774a
--- /dev/null
+++ b/Documentation/devicetree/bindings/media/rockchip,px30-vip.yaml
@@ -0,0 +1,123 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/media/rockchip,px30-vip.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Rockchip Camera Interface (CIF)
+
+maintainers:
+  - Mehdi Djait <mehdi.djait@bootlin.com>
+
+description:
+  CIF is a camera interface present on some Rockchip SoCs. It receives the data
+  from Camera sensor or CCIR656 encoder and transfers it into system main memory
+  by AXI bus.
+
+properties:
+  compatible:
+    const: rockchip,px30-vip
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  clocks:
+    items:
+      - description: ACLK
+      - description: HCLK
+      - description: PCLK
+
+  clock-names:
+    items:
+      - const: aclk
+      - const: hclk
+      - const: pclk
+
+  resets:
+    items:
+      - description: AXI
+      - description: AHB
+      - description: PCLK IN
+
+  reset-names:
+    items:
+      - const: axi
+      - const: ahb
+      - const: pclkin
+
+  power-domains:
+    maxItems: 1
+
+  ports:
+    $ref: /schemas/graph.yaml#/properties/ports
+
+    properties:
+      port@0:
+        $ref: /schemas/graph.yaml#/$defs/port-base
+        unevaluatedProperties: false
+        description: input port on the parallel interface
+
+        properties:
+          endpoint:
+            $ref: video-interfaces.yaml#
+            unevaluatedProperties: false
+
+            properties:
+              bus-type:
+                enum: [5, 6]
+
+            required:
+              - bus-type
+
+    required:
+      - port@0
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - clocks
+  - ports
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/px30-cru.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/media/video-interfaces.h>
+    #include <dt-bindings/power/px30-power.h>
+
+    parent {
+        #address-cells = <2>;
+        #size-cells = <2>;
+
+        video-capture@ff490000 {
+            compatible = "rockchip,px30-vip";
+            reg = <0x0 0xff490000 0x0 0x200>;
+            interrupts = <GIC_SPI 69 IRQ_TYPE_LEVEL_HIGH>;
+            clocks = <&cru ACLK_CIF>, <&cru HCLK_CIF>, <&cru PCLK_CIF>;
+            clock-names = "aclk", "hclk", "pclk";
+            power-domains = <&power PX30_PD_VI>;
+            resets = <&cru SRST_CIF_A>, <&cru SRST_CIF_H>, <&cru SRST_CIF_PCLKIN>;
+            reset-names = "axi", "ahb", "pclkin";
+
+            ports {
+                #address-cells = <1>;
+                #size-cells = <0>;
+
+                port@0 {
+                    reg = <0>;
+
+                    cif_in: endpoint {
+                        remote-endpoint = <&tw9900_out>;
+                        bus-type = <MEDIA_BUS_TYPE_BT656>;
+                    };
+                };
+            };
+        };
+    };
+...
-- 
2.43.0


