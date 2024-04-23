Return-Path: <linux-kernel+bounces-155709-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 648428AF5FA
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 19:59:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E2B831F24C2C
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 17:59:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 620FA140375;
	Tue, 23 Apr 2024 17:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K5P61QpK"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D939013E884;
	Tue, 23 Apr 2024 17:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713895161; cv=none; b=DlfHqXi6dRvW2ftZh4ZXlzVJENkRVh6eqGOm2RqSDeV1q5V3G9RpptDTho3HzoRw6xuCoGx00T2bmVqIGqmY+W9eM6xVRyUtm5IP5v/japOpalrAhXqL3dLqdvnnMFyy0f7ZhfZAS/BusuEcE3TDyw9OQlDISM7jYoFnBSaVDCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713895161; c=relaxed/simple;
	bh=BpWeENQe/cQhQ7j1K3BiJsL6NqUqR3mxFkNnEjiJqYM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=IJvZBzPq8XssMk/J8fkPI/Ol5YoddAZ4FeiG/elCSRkgtDGPs2KFJWQXi+P3A77uvvUuixAPpAufZ38uGCZvEqH0nhEGrNqJjkeOaShen8KDRqOwDGDr4woOBTqMcR3DCgd5xBeJWQAbXosBZdy9t5VoAOM6UJr9pxy/rCMp2cQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K5P61QpK; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-41a4f291f80so20911335e9.1;
        Tue, 23 Apr 2024 10:59:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713895158; x=1714499958; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k+oHe0mLkxZA6Ajq9xGHl3pNaIq8n5il5pBKVrZCyg4=;
        b=K5P61QpKeeVFAa8cLh/mCf3niAcrC5AifMtN/XzZxn7qik1iTVjrRcIJRqFdf3Iskq
         4UMYrB9TqfsVRbRESY+tzLybPJks+HsiEMMVueJ1h+HgP1Qx5k0XLuDqGj2MLnKaaOqT
         aWtWIWLlxIfOpzKdPuXvCmvuul4Cd/0CgeypWu5+V0AyPURy0q7ZtakXl5VtM8GneQsu
         mw8KOh7kqARMTGmPTqLrL0wycpVl6xGexx5u3wxDizPDQRKdYz9JSBk3Q7pUPgPYxEJK
         kfVdsdnJVy0TnplERBEADz+Rxe7JkpNydkJmZkVbk1+w02PZXSmTXLnpMZJ3Ogmu/zkY
         UnpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713895158; x=1714499958;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k+oHe0mLkxZA6Ajq9xGHl3pNaIq8n5il5pBKVrZCyg4=;
        b=Yc8aUXfjEzwgiAPR+XlxZ9udq0R/ZE40GtAObqY+jfA0+k5YqBtE1h2ZYeQ38r+92p
         zQzlYgNfQJ2QBGINVmbkAkfkROOUqlVlgeeR8GR6HDtAOZXgj4WpV0flh9pzVCDk5rQg
         cRbanjArNEwUxXfIDveGbpA1qIEj0Qe++Dd4KO836dSa2zoeJd1Pp3dRSXhYh8liJErJ
         pK/oSrjf601AY6uRztMlz2DChyx6weRK9Mp6uR27N7AT4txc6EOfSlJcXDQobLDsf9YK
         R0QOROr3kKiRlDZ1Q2ejlQDcX3cZFj21ZwR/QBTuyuyyjIC5Gy7hHkHmNSaL/JcNKhGs
         WU0g==
X-Forwarded-Encrypted: i=1; AJvYcCV7EmEvhgnAspTMQUaAhTlqBMp8cX+6ZVTI12QNB1QNz2w6DX6wU5KfrXndTmRWv5ICVhYpzG5mppXrqYV7ZV0S/Wy/+WOnxI43GpWWB/ka2SB0pspTXQyQGo2AkIPjtfOBjHTc8YOE0QVEz1TiBM9JzBVtyyk1Tys7164yNc4j7GpZjc+awKuwDi10
X-Gm-Message-State: AOJu0Yw+uwNfXVMQO7WAwl8dZJYqNx7dun/6YxICjQFvUcTuPBwWxShw
	QwLOaCFYKjxExvJgHg1XdQtSNUw0gqoTOX3J8fLtIOIbGSjP3exI
X-Google-Smtp-Source: AGHT+IFZxo10Epb8HusiJzLSajhXUw4HhN7m+DDZZUaUJxBe8dhJDonTd9tJ/87HblWaDyq2p4YidQ==
X-Received: by 2002:a05:600c:5125:b0:41a:7fc8:a650 with SMTP id o37-20020a05600c512500b0041a7fc8a650mr47010wms.0.1713895157861;
        Tue, 23 Apr 2024 10:59:17 -0700 (PDT)
Received: from prasmi.home ([2a00:23c8:2500:a01:cef0:9ed3:1428:f85f])
        by smtp.gmail.com with ESMTPSA id fl5-20020a05600c0b8500b0041abeaaf7f0sm2808145wmb.28.2024.04.23.10.59.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Apr 2024 10:59:17 -0700 (PDT)
From: Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: Geert Uytterhoeven <geert+renesas@glider.be>,
	Linus Walleij <linus.walleij@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Magnus Damm <magnus.damm@gmail.com>,
	linux-renesas-soc@vger.kernel.org
Cc: linux-gpio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Prabhakar <prabhakar.csengg@gmail.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH v2 02/13] dt-bindings: pinctrl: renesas: Document RZ/V2H(P) SoC
Date: Tue, 23 Apr 2024 18:58:49 +0100
Message-Id: <20240423175900.702640-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240423175900.702640-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20240423175900.702640-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Add documentation for the pin controller found on the Renesas RZ/V2H(P)
(R9A09G057) SoC. The RZ/V2H PFC varies slightly compared to the RZ/G2L
family:
- Additional bits need to be set during pinmuxing.
- The GPIO pin count is different.

Hence, a SoC-specific compatible string, 'renesas,r9a09g057-pinctrl', is
added for the RZ/V2H(P) SoC.

Also, add the 'renesas,output-impedance' property. The drive strength
setting on RZ/V2H(P) depends on the different power rails coming out from
the PMIC (connected via I2C). These power rails (required for drive
strength) can be 1.2V, 1.8V, or 3.3V.

Pins are grouped into 4 groups:

Group 1: Impedance
- 150/75/38/25 ohms (at 3.3V)
- 130/65/33/22 ohms (at 1.8V)

Group 2: Impedance
- 50/40/33/25 ohms (at 1.8V)

Group 3: Impedance
- 150/75/37.5/25 ohms (at 3.3V)
- 130/65/33/22 ohms (at 1.8V)

Group 4: Impedance
- 110/55/30/20 ohms (at 1.8V)
- 150/75/38/25 ohms (at 1.2V)

The 'renesas,output-impedance' property, as documented, can be
[0, 1, 2, 3], indicating x1/x2/x3/x4 drive strength.

As power rail information may not be available very early in the boot
process, the 'renesas,output-impedance' property is added instead of
reusing the 'output-impedance-ohms' property.

Also, allow bias-disable, bias-pull-down and bias-pull-up properties
as these can be used to configure the pins.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
RFC->v2
- Renamed renesas-rzv2h,output-impedance -> renesas,output-impedance
- Updated values for renesas,output-impedance
- Added bias properties
---
 .../pinctrl/renesas,rzg2l-pinctrl.yaml        | 25 ++++++++++++++++---
 1 file changed, 21 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/pinctrl/renesas,rzg2l-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/renesas,rzg2l-pinctrl.yaml
index 881e992adca3..089b3ce61bac 100644
--- a/Documentation/devicetree/bindings/pinctrl/renesas,rzg2l-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/renesas,rzg2l-pinctrl.yaml
@@ -26,6 +26,7 @@ properties:
               - renesas,r9a07g043-pinctrl # RZ/G2UL{Type-1,Type-2} and RZ/Five
               - renesas,r9a07g044-pinctrl # RZ/G2{L,LC}
               - renesas,r9a08g045-pinctrl # RZ/G3S
+              - renesas,r9a09g057-pinctrl # RZ/V2H(P)
 
       - items:
           - enum:
@@ -66,10 +67,14 @@ properties:
     maxItems: 1
 
   resets:
-    items:
-      - description: GPIO_RSTN signal
-      - description: GPIO_PORT_RESETN signal
-      - description: GPIO_SPARE_RESETN signal
+    oneOf:
+      - items:
+          - description: GPIO_RSTN signal
+          - description: GPIO_PORT_RESETN signal
+          - description: GPIO_SPARE_RESETN signal
+      - items:
+          - description: PFC main reset
+          - description: Reset for the control register related to WDTUDFCA and WDTUDFFCM pins
 
 additionalProperties:
   anyOf:
@@ -111,6 +116,18 @@ additionalProperties:
         output-high: true
         output-low: true
         line-name: true
+        bias-disable: true
+        bias-pull-down: true
+        bias-pull-up: true
+        renesas,output-impedance:
+          description: |
+            Output impedance for pins on RZ/V2H(P) SoC.
+            0: Corresponds to x1
+            1: Corresponds to x2
+            2: Corresponds to x3
+            3: Corresponds to x4
+          $ref: /schemas/types.yaml#/definitions/uint32
+          enum: [0, 1, 2, 3]
 
     - type: object
       additionalProperties:
-- 
2.34.1


