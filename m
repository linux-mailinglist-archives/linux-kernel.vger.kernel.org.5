Return-Path: <linux-kernel+bounces-158893-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 66ACC8B2661
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 18:26:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1BA5A282A0F
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 16:26:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A59C414D458;
	Thu, 25 Apr 2024 16:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ml5U5uNP"
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F1224500E;
	Thu, 25 Apr 2024 16:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714062362; cv=none; b=qkS+9/ty32MGBZM8vwqQQDDPT0HkNceF5ZAeJsYvHtrpQasRTHMvpMEX8E6dq4E/n8pkPEv7G8jk1+psXkpolibnQghKPut5QsCIorjWESy48p6JKMsKcQ0YMjlXtUUWSuN7ppGusWDNPd8sFgYYnshgZEMqNpRfOQldYKpgTF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714062362; c=relaxed/simple;
	bh=TxvnLVnHCzLYr5N2HFp/nczLdov6mGmacGR7PuTbNPY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Xxxfz7cq/PqV/fUK8OsMOpZtE2b2oDsAey2S3EQuYUVYZ3hzQ/caWBwgPMk7zEGpioCHE4ssK2iLANLM/Dd4oIT5uLVyJewUAwwZhGiJUnQKR5UB+B1FUoaz+44vEVEs6B6NDj4fjQPkTfGC2I9jD+lKrW0/3H6O5+9asxQM7H0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ml5U5uNP; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-516d264d0e4so2090504e87.0;
        Thu, 25 Apr 2024 09:26:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714062359; x=1714667159; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DxO2oNlSzGM7kBMrDEAxbo8f0S+NuBcTPULwJPIkD1w=;
        b=Ml5U5uNPQww9OYEpahZSaB2jGYWNLeYhwnj1QGjDvMt2x5IyEC+vbmD/H3WpK45aqc
         kPzCzNJndHTnuuPUgjkhqaLafkobbGtWbk9ch0cl1LH81ofT1U34CcNoR6621FjPORae
         S41S8ukklPG9hAZNwi45L6Sy3XqXfcViK3apWQVnE5TSmBSQLBM0eFzwfSq/btfaIhs6
         9/oZTCNbm9cTqOrBWOrlb15WFXu8j2MTnXAqLn11TP8S4eru8v+eaGFEyRJODaNXvPCN
         5zj5NNsZYgguNYu1J9q/yKMMLaJ5yHCJICh2q5if+4pJ53F+ZFfli3Rwc0d56zmlh+9x
         EZ/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714062359; x=1714667159;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DxO2oNlSzGM7kBMrDEAxbo8f0S+NuBcTPULwJPIkD1w=;
        b=p2h49kQh4sTGnMngxoQAiKg/a4aJxrj7bmMvZPLjIrAypjYQvW9yV0YaSWWTDwRQsw
         mEYHTwvE1ENkm4u3nWga97TkqOMpTapAaD17c9VT3JVbV91gdigb8JOImVBYlRNCnJK5
         b7kfowedbGBkZ7XoDyQ8y8NbmBHLoeX7g9Nlf0nYAtKD2qbltKL/GDcAOw663p2H/tBC
         NNtJEjejkL68Atfk7KaXxLS5Somawv9+XlOTtQFR4Bh7ZHqSkbaG3/7ZFI1DOEn62eHr
         hHZLrPuZakQXjck3J4ZOpGyaneq4+cP7CoZcrkF9NoPKCEVv2a8WyPavjko2m65XT3dc
         uIfQ==
X-Forwarded-Encrypted: i=1; AJvYcCX001Yhv30dMVq+ujqH118JxM4ldXWJ+aj+8b7/RvHJY2Oyu5uNJtygaYnt+uVENQ5cS/sk3GIxIP522cKE2vJU9p8aVpArySy04bAPVngGbunXrW5G58NIGB/nscB5ABWRchinG2SQLfykMa11vFQmqi8su/bPevgWxQmDZzyH5K9V0WjoFA==
X-Gm-Message-State: AOJu0YytzBmstKK5Lyjz0PW5Qpy63XOAdS1R6ZwglMYW5p5TnUGqPmA9
	zmtFJRX9Rmw7dNz2xgPIKUSHscPBxpxcifrMzc/pKaM9wYhU4Myv
X-Google-Smtp-Source: AGHT+IFpUL/ltxk0Un9ie7MK4i1cxn3QTf0qOcrWXxoJLk4IsyJxBA+VOMT+7HF1zDbPrQmBhSjPiA==
X-Received: by 2002:a19:3855:0:b0:518:f4e9:201c with SMTP id d21-20020a193855000000b00518f4e9201cmr1093178lfj.16.1714062358954;
        Thu, 25 Apr 2024 09:25:58 -0700 (PDT)
Received: from pratik-IdeaPad.lan (customer-145-40-29-195.stosn.net. [145.40.29.195])
        by smtp.googlemail.com with ESMTPSA id d42-20020a0565123d2a00b0051aef948b0asm1893471lfv.201.2024.04.25.09.25.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Apr 2024 09:25:58 -0700 (PDT)
From: Pratik Farkase <pratikfarkase94@gmail.com>
X-Google-Original-From: Pratik Farkase <pratik.farkase@wsisweden.com>
To: 
Cc: Pratik Farkase <pratik.farkase@wsisweden.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Ray Jui <rjui@broadcom.com>,
	Scott Branden <sbranden@broadcom.com>,
	Pratik Farkase <pratikfarkase94@gmail.com>,
	Stefan Wahren <wahrenst@gmx.net>,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH v4] dt-bindings: serial: brcm,bcm2835-aux-uart: convert to dtschema
Date: Thu, 25 Apr 2024 18:25:50 +0200
Message-Id: <20240425162554.13576-1-pratik.farkase@wsisweden.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert the Broadcom BCM2835 Auxiliary UART to newer DT schema.
Created DT schema based on the .txt file which had
`compatible`, `reg` `clocks` and `interrupts` as the
required properties. This binding is used by Broadcom BCM2835
SOC used in some Raspberry PI boards.
Changes from original file:
Implemented complete example which the original txt binding lacked.

Acked-by: Florian Fainelli <florian.fainelli@broadcom.com>
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Pratik Farkase <pratik.farkase@wsisweden.com>
---
Changes in v4
- Added Acked-by flag
---
Changes in v3
- Removed unecessary headers from example
- Removed the `uart1` label
- Added Reviewed-by flag
---
Changes in v2
- Updated Maintainers list according to feedback
- Fixed typo `Auxiliar` to `Auxiliary`
---
---
 .../bindings/serial/brcm,bcm2835-aux-uart.txt | 18 --------
 .../serial/brcm,bcm2835-aux-uart.yaml         | 46 +++++++++++++++++++
 2 files changed, 46 insertions(+), 18 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/serial/brcm,bcm2835-aux-uart.txt
 create mode 100644 Documentation/devicetree/bindings/serial/brcm,bcm2835-aux-uart.yaml

diff --git a/Documentation/devicetree/bindings/serial/brcm,bcm2835-aux-uart.txt b/Documentation/devicetree/bindings/serial/brcm,bcm2835-aux-uart.txt
deleted file mode 100644
index b5cc6297cd1b..000000000000
--- a/Documentation/devicetree/bindings/serial/brcm,bcm2835-aux-uart.txt
+++ /dev/null
@@ -1,18 +0,0 @@
-* BCM2835 AUXILIAR UART
-
-Required properties:
-
-- compatible: "brcm,bcm2835-aux-uart"
-- reg: The base address of the UART register bank.
-- interrupts: A single interrupt specifier.
-- clocks: Clock driving the hardware; used to figure out the baud rate
-  divisor.
-
-Example:
-
-	uart1: serial@7e215040 {
-		compatible = "brcm,bcm2835-aux-uart";
-		reg = <0x7e215040 0x40>;
-		interrupts = <1 29>;
-		clocks = <&aux BCM2835_AUX_CLOCK_UART>;
-	};
diff --git a/Documentation/devicetree/bindings/serial/brcm,bcm2835-aux-uart.yaml b/Documentation/devicetree/bindings/serial/brcm,bcm2835-aux-uart.yaml
new file mode 100644
index 000000000000..8a31eb56b865
--- /dev/null
+++ b/Documentation/devicetree/bindings/serial/brcm,bcm2835-aux-uart.yaml
@@ -0,0 +1,46 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/serial/brcm,bcm2835-aux-uart.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: BCM2835 AUXILIARY UART
+
+maintainers:
+  - Pratik Farkase <pratikfarkase94@gmail.com>
+  - Florian Fainelli <florian.fainelli@broadcom.com>
+  - Stefan Wahren <wahrenst@gmx.net>
+
+allOf:
+  - $ref: serial.yaml
+
+properties:
+  compatible:
+    const: brcm,bcm2835-aux-uart
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
+  - clocks
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/bcm2835-aux.h>
+    serial@7e215040 {
+        compatible = "brcm,bcm2835-aux-uart";
+        reg = <0x7e215040 0x40>;
+        interrupts = <1 29>;
+        clocks = <&aux BCM2835_AUX_CLOCK_UART>;
+    };
-- 
2.34.1


