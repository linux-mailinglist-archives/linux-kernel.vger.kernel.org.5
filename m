Return-Path: <linux-kernel+bounces-81786-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE80B867A17
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 16:23:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D8711C2199A
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 15:23:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8499B12BEB5;
	Mon, 26 Feb 2024 15:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZO8Q6gRd"
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 364DC1E4A1;
	Mon, 26 Feb 2024 15:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708960939; cv=none; b=NEpPj6gumv8+xcIEJ1sy7neauktXNM0zllYQx0754UbkKkqvzSqjLMiBZcc7djBB3DwRiXuzwM2gaR2T9mVsVCa1HzEfjr+NjhCHWF3e4dxnFz+Ws1lK1DRGdL9qNXhFOmmptLJxKDQiXioZg/zCaMnrxYKEfN1BALpG2+/z1qI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708960939; c=relaxed/simple;
	bh=pnLMu2JRaK4jkBKbdQ/FyNx6bxwlJXbOumIQ5QXHA54=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=g2RwWMzJC+/zt4opouobLrg2++/lpa99NVcJPm1zhK0AtiZEz8w5ExTH9GwM3NvGGqYpQMK5Dew6dDKUJ1G90jTfNkkCGbfxN3tqqtg0P6mZXP/hOgUkdMLXtPq9r737exK9JpVKtqmC+oNe9iYXRDjNGxxvleiOtLDG1EL8kLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZO8Q6gRd; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2d24a727f78so45338321fa.0;
        Mon, 26 Feb 2024 07:22:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708960936; x=1709565736; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WkqUh76ItlVehsi7wY8VmVeMyWF5V+vxuPwZ5kjJDeM=;
        b=ZO8Q6gRdcI7KhPUoGTrSGB53QkmoOGCEyPlEFS/6hNLFpGO6Md2XDWROq+iyiBrYr7
         pYvllUOuqJwnwi8P2HE5JK6PF9igk4BYEVOn6CLhsEQYmtAGma4bX6nUCdnknNKrX1p3
         porCnOTkC25QIg3Un6xNGX0UY2yzDcDOVB5nsKUbcR4IEmfSxlJpGVsr6v3XoB61a62D
         zkUdltanIpeklv+nPtW+b21AsUNALHVemCwH3tK0lCkMvlAzDb0jZQGL4CyNJK3q+YUB
         5ld4wsq1j8vnkHN+CJ8UgKIahFnXgkZ9joWyPYrcDEzrZUe7AkhzU6ik6WYMe2YzzY0h
         1m4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708960936; x=1709565736;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WkqUh76ItlVehsi7wY8VmVeMyWF5V+vxuPwZ5kjJDeM=;
        b=udExlnfXgA4MWeO8XLCB8XKzs+nmvcEnmkOMje7lP1dG/Rt7sFFI5p5lz04VOyTj6d
         fWWgrjT5q2QgJRaTvFQQaWfwTRZLwBXY6qLG/rrhcKVYHfKdsbV+tSEHu7SGIeav2bgx
         0t6bP5QSBVLiBBPDvPDAEMPA5YKCV+l9R5vaQK8MEo/BoBahmlpKUtu8lbyeG18Tm68S
         syabm6orbCWCrF3LbaENm1dl5Rcl5V+jE0meWUetzMxvTcPwwZ74hiATvuE4vGFBCEDD
         B/3dZ7SpMjD2qgSf30HP8jLao7UtZEDw/damLnNQc3hwdpDPdrBEMXUWPclHYcPQsrNt
         yK+Q==
X-Forwarded-Encrypted: i=1; AJvYcCWPcECNMWqQemMUUuNMG+w4QzgKxfyphXTF+zNy/yNwQvgGYUI6cbcHf3jZLMp1EGB027hWgLDbUkBOWMn+O1pYnJ/CKY5g2bO4NiYwud6aLFkKaAGa2vEkqJjcnNy+CNmNBgTIuz/tSw==
X-Gm-Message-State: AOJu0Yxpv6qsMF0uNYH6PeQ7H33T8qYJn5QLTxpetnUV9E2t9FqNXD3M
	ylK6tzLPWY9eifP3K4HzD87zQ8BIvHKlRaUoNxKWEghdvMs+S8xZp4i1E7Ki
X-Google-Smtp-Source: AGHT+IHPpp4B4SYdq6vLgAkUoOon4yKj1df+LOx8WqTWVPOKzVIKw5eJe4Ff5fZnOkPxBF/C4Eeixg==
X-Received: by 2002:a2e:86cf:0:b0:2d2:724d:f653 with SMTP id n15-20020a2e86cf000000b002d2724df653mr4873791ljj.38.1708960936140;
        Mon, 26 Feb 2024 07:22:16 -0800 (PST)
Received: from localhost ([2001:861:3385:e20:6384:4cf:52c5:3194])
        by smtp.gmail.com with ESMTPSA id js1-20020a05600c564100b004128936b9a9sm12354104wmb.33.2024.02.26.07.22.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Feb 2024 07:22:15 -0800 (PST)
From: Raphael Gallais-Pou <rgallaispou@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Patrice Chotard <patrice.chotard@foss.st.com>
Cc: linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: [PATCH v2] dt-bindings: serial: convert st,asc to DT schema
Date: Mon, 26 Feb 2024 16:21:35 +0100
Message-ID: <20240226152135.8671-1-rgallaispou@gmail.com>
X-Mailer: git-send-email 2.43.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

'clocks' property is required regarding the device. Convert st,asc
binding to DT schema format in order to add this property, and update
example.

Signed-off-by: Raphael Gallais-Pou <rgallaispou@gmail.com>
---
Changes in v2:
  - Drop 'uart-has-rtscts' property
  - Rewrite commit log to better match the changes
---
 .../devicetree/bindings/serial/st,asc.yaml    | 55 +++++++++++++++++++
 .../devicetree/bindings/serial/st-asc.txt     | 18 ------
 2 files changed, 55 insertions(+), 18 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/serial/st,asc.yaml
 delete mode 100644 Documentation/devicetree/bindings/serial/st-asc.txt

diff --git a/Documentation/devicetree/bindings/serial/st,asc.yaml b/Documentation/devicetree/bindings/serial/st,asc.yaml
new file mode 100644
index 000000000000..f2083388f36b
--- /dev/null
+++ b/Documentation/devicetree/bindings/serial/st,asc.yaml
@@ -0,0 +1,55 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/serial/st,asc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: STMicroelectronics STi SoCs Serial Port
+
+maintainers:
+  - Patrice Chotard <patrice.chotard@foss.st.com>
+
+allOf:
+  - $ref: serial.yaml#
+
+properties:
+  compatible:
+    const: st,asc
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+  st,hw-flow-ctrl:
+    description: When set, enable hardware flow control.
+    type: boolean
+
+  st,force-m1:
+    description: When set, force asc to be in Mode-1. This is recommended for
+      high bit rates above 19.2K.
+    type: boolean
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - clocks
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/stih407-clks.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    serial@9830000 {
+        compatible = "st,asc";
+        reg = <0x9830000 0x2c>;
+        interrupts = <GIC_SPI 122 IRQ_TYPE_LEVEL_HIGH>;
+        clocks = <&clk_s_c0_flexgen CLK_EXT2F_A9>;
+    };
+...
diff --git a/Documentation/devicetree/bindings/serial/st-asc.txt b/Documentation/devicetree/bindings/serial/st-asc.txt
deleted file mode 100644
index a1b9b6f3490a..000000000000
--- a/Documentation/devicetree/bindings/serial/st-asc.txt
+++ /dev/null
@@ -1,18 +0,0 @@
-*st-asc(Serial Port)
-
-Required properties:
-- compatible : Should be "st,asc".
-- reg, reg-names, interrupts, interrupt-names	: Standard way to define device
-			resources with names. look in
-			Documentation/devicetree/bindings/resource-names.txt
-
-Optional properties:
-- st,hw-flow-ctrl	bool flag to enable hardware flow control.
-- st,force-m1		bool flat to force asc to be in Mode-1 recommended
-			for high bit rates (above 19.2K)
-Example:
-serial@fe440000{
-    compatible    = "st,asc";
-    reg         = <0xfe440000 0x2c>;
-    interrupts     =  <0 209 0>;
-};
-- 
2.43.2


