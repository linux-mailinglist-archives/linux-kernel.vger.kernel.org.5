Return-Path: <linux-kernel+bounces-145410-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A90608A55DA
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 17:01:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F4A9282ECE
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 15:01:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A9AE76044;
	Mon, 15 Apr 2024 15:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="igAueFYi"
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42F8F71B3B;
	Mon, 15 Apr 2024 15:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713193287; cv=none; b=aOIbQmF57NjYcbUqzUFDBGjAuHAYMtBsnIMDmGNWy5JozvUB1kTJqbwhl/P5WxhVpvmamVqnnkE2yUFvqbWuh+VhVdzwLrPLLzf4/cpVlYncZlVi3LmjXendkW20a8vu/O73gtYWZ4N/hM273GiPt2dYeBoobJQo90/aLWbJvk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713193287; c=relaxed/simple;
	bh=T7MRLv7FhJRARR1bVP7YZL9xM5lJoY6hPL2r7Wr+kxU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=n4KsAJuBSdQdCZLH0bpT31GLuhae2bYN1FMA8WxvhYf4baV/TZndqy6lki0peNgpywkUrRAYapNKZxhE6jCke5TbysfGTPCPt2awyopM6ABKowetT3V+nfgALjUmqo8v1jpCN/ptgtxB56KYZnaxLVdY44qu37QhLLQ0Rl9xD+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=igAueFYi; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2d4a8bddc21so38619041fa.0;
        Mon, 15 Apr 2024 08:01:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713193280; x=1713798080; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Mx/6MUgB7xl8fVQhit3vdrOM02gBSAL1RlrQaMlTq6k=;
        b=igAueFYivVbgPE8r9zIGRUH+7LRuUHMgtFqvt6XS18WPOxLtD5syGRHWobzCbPzHWT
         gLeHD9GnRSaGhEy8NV9797mwjT1R/P69JpUOpEZExMmE22Rmf6LRPH1h4Tf2xz8JUJOC
         +wimp19ZKKBvTDYR6pcXBDqRa4ScT1bXSX0nu/S7nGMN/XPHQUyhnKzDFOWZDq7+GVOY
         lKny8EustoQGJwhZXlQ1nH8wo5UXxC18RZi7EOYce3DMNPROu6LL31AGDLdPHM07/xbP
         IXQecEfTOw2jn397LjZY2HoJsAPg/KI+6+LY4wyZKHZxjDH/PuoHA49mmI+jSEH0BRs7
         HTUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713193280; x=1713798080;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Mx/6MUgB7xl8fVQhit3vdrOM02gBSAL1RlrQaMlTq6k=;
        b=enhk5TibIT1jLFRodMdDBIt08aKyPo/8mNoZAGMeZMZUzrGzsJPv0qpHz4MIWe6vr7
         jAQ5EdhtHX6rqmT12GUbPBIlq1Cid2/JH5pc4/4ySswGe/pbl64Pxnt/wBG7+ehEHysk
         ccNdNDN+FqjFnhKxc7YE0YPJyWNIi6TqstTLycx+TRGjpHlsAGU7B7HGHnn3/ce5yUME
         2YfjK4btyk/vbPivnCYhcjHICGP94MbpscaP7rKbqcTJHJL5xlQTpY5zlF6SVgC9DNdl
         Ks6eROX30ZilMaTYPcPi552hWSkH4Dly16xQ1N84kkAUJ7wOI909hhkv0mYVU36tJShH
         Odhw==
X-Forwarded-Encrypted: i=1; AJvYcCXxX5mGI4/Tyipf2CS3UO1VEDOpIZqSregIf+jzPw0F1Lq0gLFpZ0UEJJEFMBCAc694LEP2mNCeAJZrlt+iRUsmr4oyxlGEzPwP2ikOxI8kIL6Oe6g89XwP/ZySv+sXyDk+b4S8lhTKugQD2o0JLOM9CmmSVkY4TNtiho7pLRKEDcq3ImAzsw==
X-Gm-Message-State: AOJu0Yyo3ZXRfXl0X2FrmdHK+4G6cUcp+ifSuU9R7ZAgrtEP9SSSqEnm
	/UOpagTjdojiJBb6QsP0xVz2f7+GNddZzH0AQ7RuIcUAabiyHc6s
X-Google-Smtp-Source: AGHT+IFv/gU+KWM1ufZfi1AtNceIbXbIeTp539sQYbvvFryi8Vyrm8iEP5X7q/0EfTOW2o1A9DL29A==
X-Received: by 2002:a2e:8012:0:b0:2d8:d23a:f440 with SMTP id j18-20020a2e8012000000b002d8d23af440mr6139405ljg.6.1713193280100;
        Mon, 15 Apr 2024 08:01:20 -0700 (PDT)
Received: from pratik-IdeaPad.lan (customer-145-40-29-195.stosn.net. [145.40.29.195])
        by smtp.googlemail.com with ESMTPSA id n11-20020a2e878b000000b002d8e9a37bfdsm1302799lji.113.2024.04.15.08.01.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Apr 2024 08:01:19 -0700 (PDT)
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
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH] dt-bindings: serial: brcm,bcm2835-aux-uart: convert to dtschema
Date: Mon, 15 Apr 2024 17:00:44 +0200
Message-Id: <20240415150046.144987-1-pratik.farkase@wsisweden.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert the Broadcom BCM2835 Auxiliar UART to newer DT schema.
Created DT schema based on the .txt file which had
`compatible`, `reg` `clocks` and `interrupts` as the
required properties. This binding is used by Broadcom BCM2835
SOC used in some Raspberry PI boards.
Changes from original file:
Implemented complete example which the original txt binding lacked.

Signed-off-by: Pratik Farkase <pratik.farkase@wsisweden.com>
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
index 000000000000..c52ba2e33f28
--- /dev/null
+++ b/Documentation/devicetree/bindings/serial/brcm,bcm2835-aux-uart.yaml
@@ -0,0 +1,46 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/serial/brcm,bcm2835-aux-uart.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: BCM2835 AUXILIAR UART
+
+maintainers:
+  - Pratik Farkase <pratikfarkase94@gmail.com>
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


