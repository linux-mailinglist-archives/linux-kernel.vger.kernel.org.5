Return-Path: <linux-kernel+bounces-132632-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C12889977E
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 10:04:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0AA4B284186
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 08:04:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3EA01448E2;
	Fri,  5 Apr 2024 08:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fRF5ZN73"
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D8AB143C65;
	Fri,  5 Apr 2024 08:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712304263; cv=none; b=IqDazv4Mr8LAywBlXfJbHhEp6jGP28i1I/YFrEEKRgeVFeDgQglyi3naVgl/JTPIDyJzz9hSIJiSNjYmXSNkVMnYgPdJhbNTssWCS0fy+qexv1N3aFOaTVIP73eTBAiwBVCTwfWK8UpHqfBOGpJq7AOdwR18hvsUOAMaHkqdKAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712304263; c=relaxed/simple;
	bh=v11yFk9NSOfNoHc6+ANIFNbVeOYgrslLQmB+9CH9P+8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=QZz1FIjcZNRvP9Yl/XFwWAs2SUmSBOxHCVqIMyTGNldHz2EA1fa0wkWowFQdUOACcZ1AC945AMYZi9aij0B5iAzPQLMWV7j1nZpOsTVBDLq6KlkjHktK+kTvBeHmAvwvLtYqzFQFNguyB1y1j6X856OdbCksAtQF8ZaqRKch+cg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fRF5ZN73; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-6ecf406551aso1097449b3a.2;
        Fri, 05 Apr 2024 01:04:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712304261; x=1712909061; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GfvN/GEUvZgHsMPKzmrhQeGD0EhxOkBXG+H6PdOljG4=;
        b=fRF5ZN73lsvPf9tkv6kWqR037JX2BQc5ETO+ko4Uy+7GSkd+UxsOpRu3uUJu8tkVix
         sfX17sEE7MnudyE13BRJWuokGlHFXheGGF/B6jbZcfsdj89dzek3TwXDSGu5X5FtPPJ5
         71ruxej5jGNPDnU1d+/ESmS4WeBMqHEyZCw3gkHkI4+sBFJkKdMrfAgsSRp/IW72ZlR2
         Dk8imfqmqYn3IlwwCopPCotfTxgJpzuM7izhL1FNSGT2RzIVmQqGQnRsnmvF4cwkL7Ud
         X4Jo5TrWJa8I48f+C2Rj4ji97pDh31yHBtrOQcDCelAoF2Nv633lJQ+9XeKH6B2Ge6Go
         yirw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712304261; x=1712909061;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GfvN/GEUvZgHsMPKzmrhQeGD0EhxOkBXG+H6PdOljG4=;
        b=tGUYNcPIrdIzkyqOPZaY8/np2+N/yNrbLzprlJBK5FcOwerZoyxJSDBseIp/FPXO/n
         AeMbEfep4UROEGTKL7K+/mrJ0bWv3N1qD0omUBqp8h1M5XwAv8j8E+pe9FuUbRser+P9
         fGCM9RBCKYdhSuWHrX8qv2KMC0sknQybWMYDlZeujZOT9diaEoABltk4Ey6SQUnLXWWi
         cIErgMFgSZtNPZViOZvBKrWgxWfi3mHJlTxiPUmkawg3OI0Rv6/oTVZ4RWkmtJa7x1+e
         cHKOng/BsizgxHzw6SaXGVT3WCx9eJXzpioDHsjLoDnEQFos9m6kiO28hBmd5FzMktvR
         06xQ==
X-Forwarded-Encrypted: i=1; AJvYcCVMV0Z+5S5yevEJKIoedGDyr/fRxkFDdKal4ZxDssDk5FjK1+TOPRLgHRAP/Bkff7MzvLa3qW/W5rpUWbXFi715fXO9e+NO+8203yltdQE/pVs784NmaJZ2PtWvh6OuWUUtosBvicMIp6qi4GFUF9tzevlGlyzCGPYmEaFY1PNefM7Kirc8sQ==
X-Gm-Message-State: AOJu0YwflE1DqlSnexZSe/PBidZNkodEN74Ftgkau1A15wHHuU56Ai1d
	xL3kwfyToqIfWcC5yrwQUdQmB3MZKkhJG/65202iA0lacAKoTZNc
X-Google-Smtp-Source: AGHT+IEk9ijxrJqAh34I2dW8pSMS+a1cqK0Fa6E00ttmimkRzuDSHQJOQgvaAdjxlY1/kHWPx48UVw==
X-Received: by 2002:a05:6a20:3d8a:b0:1a3:c512:580c with SMTP id s10-20020a056a203d8a00b001a3c512580cmr857251pzi.9.1712304260711;
        Fri, 05 Apr 2024 01:04:20 -0700 (PDT)
Received: from localhost.localdomain ([103.4.220.252])
        by smtp.googlemail.com with ESMTPSA id b6-20020a170902ed0600b001e10b6f45dasm921162pld.295.2024.04.05.01.04.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Apr 2024 01:04:19 -0700 (PDT)
From: Kanak Shilledar <kanakshilledar@gmail.com>
To: 
Cc: daniel.baluta@nxp.com,
	Kanak Shilledar <kanakshilledar111@protonmail.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	=?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-actions@lists.infradead.org
Subject: [PATCH v5] dt-bindings: serial: actions,owl-uart: convert to dtschema
Date: Fri,  5 Apr 2024 13:32:32 +0530
Message-Id: <20240405080235.11563-1-kanakshilledar@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kanak Shilledar <kanakshilledar111@protonmail.com>

Convert the Actions Semi Owl UART to newer DT schema.
Created DT schema based on the .txt file which had
`compatible`, `reg` and `interrupts` as the
required properties. This binding is used by Actions S500, S700
and S900 SoC. S700 and S900 use the same UART compatible string.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Kanak Shilledar <kanakshilledar111@protonmail.com>
---
Changes in v5
- rebased the patch
- sent to all the maintainers

Changes in v4
- updated commit message
- `clocks` property is removed from the required section.
- remove disabled status from example devicetree
---
 .../bindings/serial/actions,owl-uart.txt      | 16 -------
 .../bindings/serial/actions,owl-uart.yaml     | 48 +++++++++++++++++++
 2 files changed, 48 insertions(+), 16 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/serial/actions,owl-uart.txt
 create mode 100644 Documentation/devicetree/bindings/serial/actions,owl-uart.yaml

diff --git a/Documentation/devicetree/bindings/serial/actions,owl-uart.txt b/Documentation/devicetree/bindings/serial/actions,owl-uart.txt
deleted file mode 100644
index aa873eada02d..000000000000
--- a/Documentation/devicetree/bindings/serial/actions,owl-uart.txt
+++ /dev/null
@@ -1,16 +0,0 @@
-Actions Semi Owl UART
-
-Required properties:
-- compatible :  "actions,s500-uart", "actions,owl-uart" for S500
-                "actions,s900-uart", "actions,owl-uart" for S900
-- reg        :  Offset and length of the register set for the device.
-- interrupts :  Should contain UART interrupt.
-
-
-Example:
-
-		uart3: serial@b0126000 {
-			compatible = "actions,s500-uart", "actions,owl-uart";
-			reg = <0xb0126000 0x1000>;
-			interrupts = <GIC_SPI 32 IRQ_TYPE_LEVEL_HIGH>;
-		};
diff --git a/Documentation/devicetree/bindings/serial/actions,owl-uart.yaml b/Documentation/devicetree/bindings/serial/actions,owl-uart.yaml
new file mode 100644
index 000000000000..ab1c4514ae93
--- /dev/null
+++ b/Documentation/devicetree/bindings/serial/actions,owl-uart.yaml
@@ -0,0 +1,48 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/serial/actions,owl-uart.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Actions Semi Owl UART
+
+maintainers:
+  - Kanak Shilledar <kanakshilledar111@protonmail.com>
+
+allOf:
+  - $ref: serial.yaml
+
+properties:
+  compatible:
+    items:
+      - enum:
+          - actions,s500-uart
+          - actions,s900-uart
+      - const: actions,owl-uart
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
+required:
+  - compatible
+  - reg
+  - interrupts
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/actions,s500-cmu.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    uart0: serial@b0126000 {
+        compatible = "actions,s500-uart", "actions,owl-uart";
+        reg = <0xb0126000 0x1000>;
+        clocks = <&cmu CLK_UART0>;
+        interrupts = <GIC_SPI 32 IRQ_TYPE_LEVEL_HIGH>;
+    };
-- 
2.34.1


