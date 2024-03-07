Return-Path: <linux-kernel+bounces-95422-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 26A08874D75
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 12:33:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 578741C20F02
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 11:33:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68B431292D9;
	Thu,  7 Mar 2024 11:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=9elements.com header.i=@9elements.com header.b="C6SYopqC"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9764586AC0
	for <linux-kernel@vger.kernel.org>; Thu,  7 Mar 2024 11:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709811218; cv=none; b=rFUYlDgRAx5yVHY13tLLymNhTCqbHVbCwRZ2Mja02ebmFvrr4+kpFVqSuxnkNx93lVZ/Uscww7i9i+giSwOIHv54VxIy+/oj7mzb2LIE8CP3YopWP7/hwmNbZleUVnzHfQPtcrz+Dy59NyfAupD/88hZwbbjsFsJHQStxXryJ0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709811218; c=relaxed/simple;
	bh=dRJ+kAHjwTS6Xk3FNS5Z+qnro/vKxfEynKSGErBYZsw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HohBOujecRDiu8p42VkQ/CQeVMUSEUWYrlUBMyClZCfXgHguuFU3P5qR3YyvLMwVnBvjCXaEwTndP8UQorF7W9L3u5FfawVgCZSMo+0swMVl5DH4P6cfZ29/KBmWPAoC0A9GS7Rf3elYqCeGH84ELbKov/sv4e1hSyqp07s0+Ig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=9elements.com; spf=pass smtp.mailfrom=9elements.com; dkim=pass (2048-bit key) header.d=9elements.com header.i=@9elements.com header.b=C6SYopqC; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=9elements.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=9elements.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-41312cf36a8so1937665e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 07 Mar 2024 03:33:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google; t=1709811214; x=1710416014; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RDRapjKGygNsR+NakDuOIL7yy4efS+lDW0N/vOIav4E=;
        b=C6SYopqCp+bQ6WPLbfEytHwtiW6D07PdZDj1AnjZEakHmYBdlToIZAbrKCV5lkabKn
         X8vHuQO24/CwZH0xj3a/3PUKolf03dnDj/j7iYaaROhzUJsLHN2b7qyZT8VGFQhFOCig
         PxTNgec+oA7cLtjg/ZQYgJ0MrLs1V4c2h6J8qxwVOYPrEm8nFSWaPn1XasmNaQV9ActE
         h1NyMIKEqsSB0UYyrreDziS24Xr40xVkBuv1jb+GVHpLclCkSj5jdsP/ygCMwSdCNzIW
         dmrJtC4jFmzONqxsEL2R4S21+s2Uw1rLD5ujcdQd/HzZ5aoVYZwwXb/vYpGsWY0UWvau
         FoaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709811214; x=1710416014;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RDRapjKGygNsR+NakDuOIL7yy4efS+lDW0N/vOIav4E=;
        b=S1rb255BGEO9HS8pLkFSn5d13MdCpFZ/K1hAO5rUAZhfdzaR3FBKfVFdfxVbywU992
         dKmuT/kY0yggukaW3LIUsFrqyAUp3BwupeiprFeSQlnN/xAvNSSGcTzM2sUD/VJafd20
         PwZYzHtlRCQX5bChw6Ce4bBLfhYZQwCO4C7yj+ljZsXRabM+1Y1XCJ8n/wGf+G07Zhh5
         fTVPgMxagvtAEAkfJlqUX/cJ7a8BzmebbSZo9GIaRRgX/6e4IxzNV5i3aJiaAvqvgYpj
         lQ1SMwyEGTje8Ttt9NoX4gywV+uMtS93yUmAUSTWeeu3RniDI1TDrcr8nPn/MDzuLcpo
         OTTg==
X-Forwarded-Encrypted: i=1; AJvYcCVAM9bsZhlZHRjwf2klDxjrpndmHmUYNA4ZjtTGUlxREL1RbPEs88+vaEmMMPHfhknY8sphxUp4Qbjb9M/FG0VcuVq8LNhEs9Caa62i
X-Gm-Message-State: AOJu0Yyg+2929dPXjqcD1dBh+EaD114Kt0x6jNU5lpXBRyIg+S00LcBc
	XIjHnuOr4u/Dn8oMZO64B0xDIYIaXt/sXrWJptPTNU0z19uDK6XEhT3I6+Q16D8=
X-Google-Smtp-Source: AGHT+IGss+m1vf/IVS15u/Vc7sXlFTJh6hhNvzfoJex9mq1unXJ7Qeo/d50qnGfSrzgMJA689NiH8g==
X-Received: by 2002:a05:600c:45c6:b0:412:faa6:c56e with SMTP id s6-20020a05600c45c600b00412faa6c56emr2686316wmo.14.1709811213760;
        Thu, 07 Mar 2024 03:33:33 -0800 (PST)
Received: from stroh80.sec.9e.network (ip-078-094-000-051.um19.pools.vodafone-ip.de. [78.94.0.51])
        by smtp.gmail.com with ESMTPSA id r7-20020a05600c458700b0041312bdcd6fsm887617wmo.40.2024.03.07.03.33.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Mar 2024 03:33:33 -0800 (PST)
From: Naresh Solanki <naresh.solanki@9elements.com>
To: Jean Delvare <jdelvare@suse.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Naresh Solanki <naresh.solanki@9elements.com>
Cc: mazziesaccount@gmail.com,
	linux-hwmon@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4] dt-bindings: hwmon: tda38640: Add interrupt & regulator properties
Date: Thu,  7 Mar 2024 17:03:24 +0530
Message-ID: <20240307113325.3800181-1-naresh.solanki@9elements.com>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

tda38640 has a single regulator output along with CAT_FAULT# pin to
report internal events. Hence add properties for regulator & interrupt.

Signed-off-by: Naresh Solanki <naresh.solanki@9elements.com>

---
Changes in V4:
1. Update commit message.

Changes in V3:
1. Update regulator node from vout0 to vout.

Changes in V2:
1. Remove TEST=..
2. Update regulator subnode property as vout0
3. Restore commented line in example
4. blank line after interrupts property in example.
---
 .../hwmon/pmbus/infineon,tda38640.yaml        | 28 +++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/Documentation/devicetree/bindings/hwmon/pmbus/infineon,tda38640.yaml b/Documentation/devicetree/bindings/hwmon/pmbus/infineon,tda38640.yaml
index ded1c115764b..5c4e52b472ad 100644
--- a/Documentation/devicetree/bindings/hwmon/pmbus/infineon,tda38640.yaml
+++ b/Documentation/devicetree/bindings/hwmon/pmbus/infineon,tda38640.yaml
@@ -30,6 +30,23 @@ properties:
       unconnected(has internal pull-down).
     type: boolean
 
+  interrupts:
+    maxItems: 1
+
+  regulators:
+    type: object
+    description:
+      list of regulators provided by this controller.
+
+    properties:
+      vout:
+        $ref: /schemas/regulator/regulator.yaml#
+        type: object
+
+        unevaluatedProperties: false
+
+    additionalProperties: false
+
 required:
   - compatible
   - reg
@@ -38,6 +55,7 @@ additionalProperties: false
 
 examples:
   - |
+    #include <dt-bindings/interrupt-controller/irq.h>
     i2c {
         #address-cells = <1>;
         #size-cells = <0>;
@@ -45,5 +63,15 @@ examples:
         tda38640@40 {
             compatible = "infineon,tda38640";
             reg = <0x40>;
+
+            interrupt-parent = <&smb_pex_cpu0_event>;
+            interrupts = <10 IRQ_TYPE_LEVEL_LOW>;
+
+            regulators {
+                pvnn_main_cpu0: vout {
+                    regulator-name = "pvnn_main_cpu0";
+                    regulator-enable-ramp-delay = <200>;
+                };
+            };
         };
     };

base-commit: 78cc80d834ed3b792605bc9c2215ed9e63825459
-- 
2.42.0


