Return-Path: <linux-kernel+bounces-80693-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18373866B5A
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 08:49:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3BB1C1C227A9
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 07:49:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E72AE1CA8A;
	Mon, 26 Feb 2024 07:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="huUcqWa7"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 511E71BDED;
	Mon, 26 Feb 2024 07:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708933733; cv=none; b=pZCP6sK+v999kvVzsnV9pxBu47itxBSjA7YrnWnwExQJmgzr9E1cYgUeRkWcIMdVt33sem8y7e9Ww/Syc6QGFs954MtJgGz2HU1aVbGND0XxiBip0n6DLpSZGAWh7E4UJZDC3lndgaayuw6bzQC1NUumhDUHs49CSl0tuX6jyJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708933733; c=relaxed/simple;
	bh=cpcdxP5G8Qs15hi9mldGQ1Vw0V6oqD1neWB+82Jqh7w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BgjOMZcPxHWRv7CZzvQS83iEpDQKT86w0NSQosz/e9f6Lq827dfEvTh2YyyEXKfE4prOUa2ARIOSXBNHErzPo4wnwHqAd1PdDMNGQofczAb5ErydoqwASagG97cyHGaSfSo1KFmKcpc2t5sgkjHHiNMJ2e6nxwbaRLZWTL9gG+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=huUcqWa7; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-412a87d5afcso541385e9.3;
        Sun, 25 Feb 2024 23:48:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708933730; x=1709538530; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ljEZV321MYaoCKwfbRB+OHvsPB1vjG2tNQbJsxizkqg=;
        b=huUcqWa7ORFAwt7Jn30hZCp0peOgogdsSpqMeYw5NZZksobMLl5aFeI1s8Y7tvgY9D
         R/Nrabn983wYsp7UJKAjqWj/uZdTOyMVZQS8bHRAs8MhvR91E1LcqouXYF8ZwmwFChoT
         1053pvweBdrNFBzGm3rlRReiswJ69x3+XEyPv+3snVuzmI/w0yCQV3WXSSmO5ygibCWI
         aLu8VsWHgvPh5u501p0y1cecGMArjOUc5DiMsKCHKgbhTqycBcs30QtkbSsU4NrjEiY5
         tQmDZui0yCZT2V3riK66vw6fPwAm0kDnpOkFj3eDtfF7kSGQxAeygFMSljPVuK+H40Ri
         1AOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708933730; x=1709538530;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ljEZV321MYaoCKwfbRB+OHvsPB1vjG2tNQbJsxizkqg=;
        b=C4+yFbI6tFqtqfPEwTg9cQJE1sB6MJa0RQGvaAgtJg0W2wNOlXbvMBWTa3DmkWGhBC
         ywbCYPEVjcFaYnu0W0H3n2mXgohlCdEx1G6loc67ErSHi5H/M6AJi0sUisD4aU2K5LWK
         1j398DJgu/ST2RIQ0AKTDL6pn1Dkv0q9z0m6JSGEtpbhoBtD8oGjsm1z52CG8HwRqmoN
         EMUXXYLR9EaLk2o0NDDOaC3XBa3mZlhkQbrWkmunpx2EJ5295so6HB4nrPFGPRHkMtQn
         Ub+31/InA/DhbCp8Ero1HGOibtjIhejPZUPSa6BcMYtkH8AsUwD1Dc9KBhsV0V/+RZjc
         DjLA==
X-Forwarded-Encrypted: i=1; AJvYcCVTRzkWyI1PBSxRfO3DDExVRF7SV0SwV2bVDyeDqFvw5FCPLlpQiFVGyKvRkt0fUZZUP/Rrs2cIxih50wSED791xufQvvdc9bOmelXufKnCM0r7Zsf50+2QlbtqL9OofBQqa6epk9o2KQ==
X-Gm-Message-State: AOJu0Yxtkx1TM+taA4u+owTj42KhWeTyNXY42t2eAdoDi/5DJnE5Kv+V
	hXuAlda/o00e1z/w3HMy1KA6bWhVizOlpaIHwm9cznO8JG8vPQ3t
X-Google-Smtp-Source: AGHT+IG5L8to5/LOVjALIkMmVCop+S/Qb4PeZTshFkd+5CR6iZVCh5z/fvGLEJPHPkbgCiWfTfTM+w==
X-Received: by 2002:a05:600c:138f:b0:411:a5f9:26f5 with SMTP id u15-20020a05600c138f00b00411a5f926f5mr5199772wmf.38.1708933729368;
        Sun, 25 Feb 2024 23:48:49 -0800 (PST)
Received: from localhost ([2001:861:3385:e20:6384:4cf:52c5:3194])
        by smtp.gmail.com with ESMTPSA id d16-20020a05600c34d000b004129e8af6absm6732333wmq.33.2024.02.25.23.48.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Feb 2024 23:48:49 -0800 (PST)
From: Raphael Gallais-Pou <rgallaispou@gmail.com>
Date: Mon, 26 Feb 2024 08:48:38 +0100
Subject: [PATCH 1/2] dt-bindings: thermal: convert st,stih407-thermal to DT
 schema
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240226-thermal-v1-1-8b03589ece73@gmail.com>
References: <20240226-thermal-v1-0-8b03589ece73@gmail.com>
In-Reply-To: <20240226-thermal-v1-0-8b03589ece73@gmail.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>, 
 Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>, 
 Lukasz Luba <lukasz.luba@arm.com>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, Lee Jones <lee@kernel.org>
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
X-Mailer: b4 0.13.0

Converts st,stih407-thermal binding to DT schema format and cleans
unused property "st,passive_cooling_temp" which does not appear in the
device-tree.

Signed-off-by: Raphael Gallais-Pou <rgallaispou@gmail.com>
---
 .../bindings/thermal/st,stih407-thermal.yaml       | 61 ++++++++++++++++++++++
 .../devicetree/bindings/thermal/st-thermal.txt     | 32 ------------
 2 files changed, 61 insertions(+), 32 deletions(-)

diff --git a/Documentation/devicetree/bindings/thermal/st,stih407-thermal.yaml b/Documentation/devicetree/bindings/thermal/st,stih407-thermal.yaml
new file mode 100644
index 000000000000..807f8d77edf5
--- /dev/null
+++ b/Documentation/devicetree/bindings/thermal/st,stih407-thermal.yaml
@@ -0,0 +1,61 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/thermal/st,stih407-thermal.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: STMicroelectronics STi digital thermal sensor (DTS)
+
+maintainers:
+  - Patrice Chotard <patrice.chotard@foss.st.com>
+  - Lee Jones <lee@kernel.org>
+
+description:
+  Binding for Thermal Sensor device for STMicroelectronics STi SoCs series.
+
+allOf:
+  - $ref: thermal-sensor.yaml
+
+properties:
+  compatible:
+    const: st,stih407-thermal
+
+  clocks:
+    maxItems: 1
+    description: Phandle of the clock used by the thermal sensor.
+
+  clock-names:
+    items:
+      - const: thermal
+
+  reg:
+    description:
+      For non-sysconf based sensors, this should be the physical base
+      address and length of the sensor's registers.
+
+  interrupts:
+    description: |
+      Standard way to define interrupt number.
+      For thermal sensor's for which no interrupt has been
+      defined, a polling delay of 1000ms will be used to read the
+      temperature from device.
+
+required:
+  - compatible
+  - clocks
+  - clock-names
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    temp0@91a0000 {
+        compatible = "st,stih407-thermal";
+        reg = <0x91a0000 0x28>;
+        clock-names = "thermal";
+        clocks = <&CLK_SYSIN>;
+        interrupts = <GIC_SPI 205 IRQ_TYPE_EDGE_RISING>;
+        #thermal-sensor-cells = <0>;
+    };
+...
diff --git a/Documentation/devicetree/bindings/thermal/st-thermal.txt b/Documentation/devicetree/bindings/thermal/st-thermal.txt
deleted file mode 100644
index a2f939137e35..000000000000
--- a/Documentation/devicetree/bindings/thermal/st-thermal.txt
+++ /dev/null
@@ -1,32 +0,0 @@
-Binding for Thermal Sensor driver for STMicroelectronics STi series of SoCs.
-
-Required parameters:
--------------------
-
-compatible : 	Should be "st,stih407-thermal"
-
-clock-names : 	Should be "thermal".
-		  See: Documentation/devicetree/bindings/resource-names.txt
-clocks : 	Phandle of the clock used by the thermal sensor.
-		  See: Documentation/devicetree/bindings/clock/clock-bindings.txt
-
-Optional parameters:
--------------------
-
-reg : 		For non-sysconf based sensors, this should be the physical base
-		address and length of the sensor's registers.
-interrupts :	Standard way to define interrupt number.
-		  NB: For thermal sensor's for which no interrupt has been
-		  defined, a polling delay of 1000ms will be used to read the
-		  temperature from device.
-
-Example:
-
-	temp0@91a0000 {
-		compatible = "st,stih407-thermal";
-		reg = <0x91a0000 0x28>;
-		clock-names = "thermal";
-		clocks = <&CLK_SYSIN>;
-		interrupts = <GIC_SPI 205 IRQ_TYPE_EDGE_RISING>;
-		st,passive_cooling_temp = <110>;
-	};

-- 
2.43.2


