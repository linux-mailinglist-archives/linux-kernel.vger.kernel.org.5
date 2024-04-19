Return-Path: <linux-kernel+bounces-151490-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E0C88AAF90
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 15:40:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9C5F11F239DC
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 13:40:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6987712A171;
	Fri, 19 Apr 2024 13:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lvZonMul"
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 231F9128806;
	Fri, 19 Apr 2024 13:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713534034; cv=none; b=H6DW/Dr8XQW1r5/tYetQNBaZlI2aAna9LngLZGGG3uK4++E2G47CL3USyuRqPWeBioddr6lkDpRFq/OJr1JwEAUvGmK00dSNQZMujIKqQG8wBnn7EicdAb7J2/0pV7BJNf5YGOlFL/U9Z+zMbj1yuoau89YqIMGDBd/zRqylgGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713534034; c=relaxed/simple;
	bh=r303P7AMvICWwMERTQj17vy0rKIEfoN+4xEvUKIS2Io=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ukRUS39Iqu9G0Ax6BOCi15fnOlGWfoOFFwprhW7UsqpnMObNoEoVpYXghG6dG+3an45CNXHrJGGW+C79Lq/RdUB7MkL4uEwtjaSwfN+tg2kiGK9C4LXe+DOfmiK3J4BVgZiOSrJPTEW/L93h4zzXW49X2fHk0FQFxC+xo5IaFjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lvZonMul; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-518a56cdbcfso3310374e87.2;
        Fri, 19 Apr 2024 06:40:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713534031; x=1714138831; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=88OzPCMmMVYOwupPg6OkAd67e40tz5zYU0Q3Z+mUdkU=;
        b=lvZonMulcxbn5sX+pO2mUvxozDXkDPQOqaMAzpGXi4E/kPLdyrxDGH3BC3smYLvn7U
         so0ZVrN59l27v8X6QEwFJsvHcsM4ypfFKCUm8lMSrBKMXo62jEe8cLaQYaoPYRcI803F
         NdeD+vnDT9HP74EoyPWiTZ2yoihntSsUuQWT0iNB1hiSOXGssCbjTrZY70wnGgomuCiN
         pQX8IeUzaMdxoAa1TSBW67KXBpX42QK/UB5BMRfux7vg4KFXeNPctU8gLmdvBD4ngeAE
         kj2P/f7gBlfE7C6r9o++l6Y5T9izJg/fpiXHeYUMHok0Ap7+3DyWwe4vwV5vF4Ub5Zn+
         HVtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713534031; x=1714138831;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=88OzPCMmMVYOwupPg6OkAd67e40tz5zYU0Q3Z+mUdkU=;
        b=NQKMAg8fOwv5y8UdZyAw6igTMoWKwRyYPn9xM5VwKAKn26w/CvHFCAEXwNrGhVJt2x
         RJd13sEx2kH5glPjy9B1DinJn1D/l4YFm5W+jxmJD6HBYwy5zmHNryTw0hhCLqsdpAuM
         l+A3w+qKOra9t5q/qNZTejPGU6ePFm8AsyVn+nK+bbWkS8pmnbc1GX0/Bw9joxq9Ow4V
         LuaImGr1ZWwfiPbAm7kyWIkhx0FHT5eQCjW4uWY1TaUNwVMBTxis2o7e0cHMItv1hAq6
         q3Agg/3LGQJYWWk8YLO7gxdfaZ7kPEab8akj3/7DgMLmU4zhiUNyJ9t1qS/c2y9gdfGF
         EeMw==
X-Forwarded-Encrypted: i=1; AJvYcCVT8NHvI41uSSqt80J5tfe7GVIWTx2EK3QiLpgYRfM+j+C0sCpTztAtXTqQNl39aA7KnMyPsjDXlPJDz5XWp5SBGTEwX9dbeD/LIiu7rdKK0r3RoCh801zoetqj+CLuhV36poqzuk/KgZ8XqeEJS1OVLOXimv+Iu1OEO+z9GyCP8NwGxS9R+A==
X-Gm-Message-State: AOJu0YyK+gX7dKo2CPBO/cp8Qx1xQGC+2sgGWBvahaOG3JW8Sfrh+9yr
	Ry/Hdu+GvcK6nox7PMvNs3YJkXU4ioWLEAdBKnV9c8+J/k0Bqi+BONcfhe3e
X-Google-Smtp-Source: AGHT+IG/ypbis3C/o9X7edx2a6AGkaKNTJgyJY+wc6rxz3B02rr4RqDxqjfJ95rHEAVaeP4zFIXwEg==
X-Received: by 2002:ac2:4bd0:0:b0:516:9f03:6a92 with SMTP id o16-20020ac24bd0000000b005169f036a92mr2566518lfq.43.1713534031040;
        Fri, 19 Apr 2024 06:40:31 -0700 (PDT)
Received: from pratik-IdeaPad.lan (customer-145-40-29-195.stosn.net. [145.40.29.195])
        by smtp.googlemail.com with ESMTPSA id q3-20020a056512210300b0051876f88f46sm711190lfr.208.2024.04.19.06.40.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Apr 2024 06:40:30 -0700 (PDT)
From: Pratik Farkase <pratikfarkase94@gmail.com>
X-Google-Original-From: Pratik Farkase <pratik.farkase@wsisweden.com>
To: 
Cc: Pratik Farkase <pratik.farkase@wsisweden.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Ray Jui <rjui@broadcom.com>,
	Scott Branden <sbranden@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Pratik Farkase <pratikfarkase94@gmail.com>,
	Stefan Wahren <wahrenst@gmx.net>,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH v3] dt-bindings: serial: brcm,bcm2835-aux-uart: convert to dtschema
Date: Fri, 19 Apr 2024 15:40:08 +0200
Message-Id: <20240419134010.105297-1-pratik.farkase@wsisweden.com>
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

Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Pratik Farkase <pratik.farkase@wsisweden.com>
---
Changes in v3
- Removed unecessary headers from example
- Removed the `uart1` label
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


