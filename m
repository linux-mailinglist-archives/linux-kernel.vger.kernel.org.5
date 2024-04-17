Return-Path: <linux-kernel+bounces-148638-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D1A48A8568
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 15:58:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0694AB2548B
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 13:58:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1F5D1411CB;
	Wed, 17 Apr 2024 13:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WELsYkuE"
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B21813F443;
	Wed, 17 Apr 2024 13:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713362267; cv=none; b=VFcXMrZRTu+ss9FqHuqgLP9TRessLXBvXn4N8HsTlQ6CFsLe1vpM7FWAruJi5MRtg4Kt0HtSe4UAoXJWgXHZ2u17j0U0I70SRrrkcciZUW4dhCCAiyRcitoAwRNOqVCAx4Zbp+VEGnvLvsYEcyoyB+s9lKQTEXXQX6yX4TgXIw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713362267; c=relaxed/simple;
	bh=tAuTme6GkvilwxtiDUHh+kXeYKrHGiZ7i8iQOkzrPBg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=InFuWzyg+czyAZ/0dBOlT38rBmczfvtJwLm9QSUvzUaaEZG9lJBkUpQRPp5O6nQjlfvJEu3lJ+L/yhuAwdTCRo8pExZQob1SSNvdqI632MKTZacGrBPDEU5Hz1hQCNXX4ecAviwJ8InfehZ/RisYbbhMYHLcQyBU/hAzsMVnMZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WELsYkuE; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2d8863d8a6eso72972451fa.3;
        Wed, 17 Apr 2024 06:57:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713362264; x=1713967064; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4CPt5wsPPyfiuSaFsXxCJvkSsW2VMZQ8yMjMPQ4gYeA=;
        b=WELsYkuE8+DsMAIZkP1dXlRBmiYEGRDFXl3KCwgDOAwnMYMcHwUBVwPXoBXBTuE2qw
         iQ7B8wBV3u3XfE0VFoeq2LB0yF+C7DEIy1Yk/saRHhehyEfp2+EC3H08VaHX+Mi5gBxw
         c/do0vM3MI/LhVJ2YWZMPsqWJ/F4EOHfBCJMTUFB1dpCPWWDCMcXc/rZJtu5Unzl88Ka
         yLphbsBFMBWbjnHcvHTCDUbkZMQDskZkPN/mGKHvSoRCZrQuXAqKFKrtpulV6avd1Ezq
         kolHQoLnMF4FPJ5v/T8eDof6MyjTGrZ0qEiyEfDieMJ+km1rusl3HBe5HhuVH3XamcYG
         OD2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713362264; x=1713967064;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4CPt5wsPPyfiuSaFsXxCJvkSsW2VMZQ8yMjMPQ4gYeA=;
        b=Zhy2bXn34M1xgkC5eirBWXkLl8nuzcV+OGWfdAB7fCVVVZZljf0pG/dxiEwf6zIBVO
         UNG15qgjb3Wf9Y5+IIigS/OAUE3JKwXhIVQa6JywMqa8EFdJf1adi197Kz9rV4RXI49z
         REV5c/+q64iAYzBOxjcalrYT4gQSk4o94Qc7I0XaBl3atpBeONeYYWVInXTwZpcZ5IDB
         +k64hwEg8tOV1do3seTfwo1/qXaE87U5zdIj3gL2Bjq51Z7yrtwFxOVTb2DzYcEBQuCN
         zsWgE+Q0sAIuc0ycna+7ZT0eNfp1GpYofU6zbWLHbDHbnN5XA5o1Abczmxn6Zu4TvAqN
         hlJg==
X-Forwarded-Encrypted: i=1; AJvYcCXcHVPaZ2uCQnOg9PccnBS953PrNcwuWITbnqfWaFkbNjbvcsJe5AM5g/XV0wRJlZKH0yT3p/56Kvfja9As9HIPz1E8MsSz1bPV9Ht/L11BQVEpyZ/e8cgiENeoDqLLMtq6a1NCqIFPRYs9oVE2aL/TgV1MqZPwSxCFMEcJg1F8qPfwXyxQ6g==
X-Gm-Message-State: AOJu0Yzsk0lQ7rTh086OrssEc4I7ShBApEaF8jW4wxn8w2DQeSBsehVp
	7x2YTNXB/MmzNrrVEavg4tXmpCHNEwcsRwFeQQRdvqIlGZuy7S4A
X-Google-Smtp-Source: AGHT+IHxA3at9V3J8oOOjFoQI8Hxcudvb/valQNqHmVnxagYSsadcG/jKBH3OuVO++fYzASwT0Gzcg==
X-Received: by 2002:a2e:a695:0:b0:2da:38e:f73d with SMTP id q21-20020a2ea695000000b002da038ef73dmr11056940lje.51.1713362264074;
        Wed, 17 Apr 2024 06:57:44 -0700 (PDT)
Received: from pratik-IdeaPad.lan (customer-145-40-29-195.stosn.net. [145.40.29.195])
        by smtp.googlemail.com with ESMTPSA id e9-20020a2e8189000000b002d7095bf808sm1864467ljg.128.2024.04.17.06.57.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Apr 2024 06:57:43 -0700 (PDT)
From: Pratik Farkase <pratikfarkase94@gmail.com>
X-Google-Original-From: Pratik Farkase <pratik.farkase@wsisweden.com>
To: 
Cc: Pratik Farkase <pratik.farkase@wsisweden.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
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
Subject: [PATCH v2] dt-bindings: serial: brcm,bcm2835-aux-uart: convert to dtschema
Date: Wed, 17 Apr 2024 15:51:10 +0200
Message-Id: <20240417135111.20375-1-pratik.farkase@wsisweden.com>
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

Signed-off-by: Pratik Farkase <pratik.farkase@wsisweden.com>
---
Changes in v2
- Updated Maintainers list according to feedback
- Fixed typo `Auxiliar` to `Auxiliary`
---
---
 .../bindings/serial/brcm,bcm2835-aux-uart.txt | 18 -------
 .../serial/brcm,bcm2835-aux-uart.yaml         | 48 +++++++++++++++++++
 2 files changed, 48 insertions(+), 18 deletions(-)
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
index 000000000000..5d4d37371d6b
--- /dev/null
+++ b/Documentation/devicetree/bindings/serial/brcm,bcm2835-aux-uart.yaml
@@ -0,0 +1,48 @@
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
+    #include <dt-bindings/clock/bcm2835.h>
+    #include <dt-bindings/clock/bcm2835-aux.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
+    uart1: serial@7e215040 {
+        compatible = "brcm,bcm2835-aux-uart";
+        reg = <0x7e215040 0x40>;
+        interrupts = <1 29>;
+        clocks = <&aux BCM2835_AUX_CLOCK_UART>;
+    };
-- 
2.34.1


