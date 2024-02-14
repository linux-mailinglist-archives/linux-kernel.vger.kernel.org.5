Return-Path: <linux-kernel+bounces-64775-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 516008542AB
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 07:13:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CDDF31F26D0F
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 06:13:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3003111B5;
	Wed, 14 Feb 2024 06:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C87qe6yp"
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72DB010A28;
	Wed, 14 Feb 2024 06:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707891199; cv=none; b=pabxlin6rQj/Hiqh1xug8Q/aVdDFQZ+UWQCD83xcH2UM/IhHeJ3W5iJaGaum/dFX3L1ppkCXP/7P0YcjBDKs7bNQ/TtmQkF7fDsYAtThC/Nj6RSAYLKr3gWTTyUnpPU82ywfr+714u0CTwxtOWy4AbeNikgSi0f08U84kNVArD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707891199; c=relaxed/simple;
	bh=0fAQCTEnvIpzw1bBuG1bZ9WpLnsKPzuE76f0W4PCsXs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=h/XvixtJ2UYILtIuss82qZ7Qy4VY7cDuSFQP79PQsQABUf3vf36/TsW9ZNn+L6mlJtl+8NUpbzAyejQ8qqx5rK1uw5dbJ2DCmGYtTFPi1h8I+o4FdYig40+ZUi9heumI4f2m/ctBiGLxqwgr4rfPdaSyeMdJiCLbIwDBhUTXyOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C87qe6yp; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a26fa294e56so689337566b.0;
        Tue, 13 Feb 2024 22:13:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707891196; x=1708495996; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FYKNeKCJBPMaI8CwH2vaV/FLvsnFOMIKN5WCojMYSS8=;
        b=C87qe6ypHe5wkRau1d3oNHNpJrmU28eNHI1wDnjRGdaLT0QnXrlBUubttTQPyJi3aS
         +XVdcHdfxRzdG4iKPeeX9rWyLsD/xlaK3wxxmcZRapnMvq3cA+eFSbhLt2dATGayKgKb
         4kkEhVwLTbNhPlrl9eK9T3Oq4WLohfZX4ImOaMeAkHlH4hkQPUpQC4qhQ0mq0jMJgaGt
         y6t8bfMlCbAHbypzVnXGUIt/sTEPjWf4JsZpGlKmc2ypgaNAg9fmR7gUcyT/HZRVf6CP
         oBwMKZ61KgnmyUj4XQe8A2hJgUq2XZoMq3VnxI8SvU6mLy6RGxTM4zb3Gq90Tt2TP0go
         BDBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707891196; x=1708495996;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FYKNeKCJBPMaI8CwH2vaV/FLvsnFOMIKN5WCojMYSS8=;
        b=pKwK3upw8Om+AsC7PcRSGQaE+nZNyDG5o/7GOdVtZ01C8jif3YcIDwGlTd04iEIB0Q
         pFLJghH+oHui5TTYEGq5NyhWw7IcyaeVzL8IeYiCdhCO+U68h3jMD3mcdMt3UO61Iosk
         ET1EOUHq4wIp5R+Y0TOl0QQ5k71fOmIqaTAy2B1po8vy4s5aifye5qGasfbQupQqMOIM
         537AKOlfvw6qNh+OmXHaR9TCVLgMJ6UC5xMxmafaU4zqqEdu0sugJJgJESiipFLIMXRl
         abl5wBh0zZEyCUYWVqT7+Ma7aF+/sH1HEPha3mtZmHWTai0v8BKwZJlXrRi462JR0NeM
         fbXw==
X-Forwarded-Encrypted: i=1; AJvYcCXzU17FErJfxzijrog1NFokZD3Q+brugNRcocg3vM2PKpjqXu5hqLSi36JlTcMKyo9uELU/zfI+MTRDTQekUnfIY6dfGDU/VntQGb6xyo1nwmAOv/RIJX84aiamSUEzcjR3tSwiOrvpuT0IIjwobCA/5g0pes0dGs0waVFtblY5QsluUQ==
X-Gm-Message-State: AOJu0Yws0jHMBT3sDHrjZERj2VcI3kYvTIKJgCMZGJVnMjE1ZR1wgMNV
	Jsz4yT2Idm3aay3MHXSB8aWiZYh80aT0vedVv5XFFl/1WHYuu+Ti
X-Google-Smtp-Source: AGHT+IE6U5eDyqPd4NxbI1MXNFUahg8cw2wNelK2ClmTzwpWQl+yo090cvZ4ToXaF74wBpzTBDLryw==
X-Received: by 2002:a17:906:3591:b0:a3d:3781:6edc with SMTP id o17-20020a170906359100b00a3d37816edcmr724594ejb.55.1707891195657;
        Tue, 13 Feb 2024 22:13:15 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUA6/cWH8rk10rbePU2FffSK6B1tnl0A12AHsAkeryQ1Y4NTIDw2VRh7L7h5OwCIh85kJItn1tkW8nDQKXdSaAbcfXAcISGoqlZSdZLcZsK9e3IecwolTfoQX+pnRLo/5WBtCCnZy1Hy1bQ6mN34z3QMZxtw+702PRaX2m42qgtZ6QIiOaHzeGAgtf+iUgn7Qi74P+C1Ol67bJJuc+n8oPXJMHkMH1rSmiJ98C961hlXzUp1daeUsX8V6idUE1zu/Hai1Zi3CzOT6EidnB7SbnXsAD8L2oFF9KFopnCA4oxVhbcMxRvHVW+6Ztx7SOzDhqVbNMiS5IWTk7rpVy4b4H5rfPb1H+TfJtkvzTa6lVxO3KSQM6ewbhED+imCe2tUggqbjBkMqdkFkxMVrMuljwGVsHKIRt/AnZq+09sSXdU9NuXO1TA8oeZXrkCwPPc9qQwsCL8M2yKOEG48J/yXUk0otyNZ1ubSeJW6Ewa4tmA+c3h61+wBBFstSebTyxik7fxbbixXpDsh4aL5JYZa+r80dvNpMp27iOcU76U9jYChvZB0gSa1E/v5MzmbZi1A8l2bOz5UrKktVpegMwwI/2wx+XaaMKv9GUd
Received: from localhost.lan (031011218106.poznan.vectranet.pl. [31.11.218.106])
        by smtp.gmail.com with ESMTPSA id ca23-20020a170906a3d700b00a3caccb8f66sm1980163ejb.44.2024.02.13.22.13.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Feb 2024 22:13:15 -0800 (PST)
From: =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>
To: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Russell King <linux@armlinux.org.uk>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	devicetree@vger.kernel.org,
	linux-clk@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH V4 1/3] dt-bindings: clock: mediatek: convert hifsys to the json-schema clock
Date: Wed, 14 Feb 2024 07:12:31 +0100
Message-Id: <20240214061233.24645-2-zajec5@gmail.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240214061233.24645-1-zajec5@gmail.com>
References: <20240214061233.24645-1-zajec5@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Rafał Miłecki <rafal@milecki.pl>

This helps validating DTS files. Introduced changes:
1. Documented "reg" property
2. Documented "#reset-cells" property
3. Dropped "syscon" as it was incorrectly used
4. Adjusted "compatible" and "reg" in example

Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 .../bindings/arm/mediatek/mediatek,hifsys.txt | 26 ----------
 .../clock/mediatek,mt2701-hifsys.yaml         | 50 +++++++++++++++++++
 2 files changed, 50 insertions(+), 26 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/arm/mediatek/mediatek,hifsys.txt
 create mode 100644 Documentation/devicetree/bindings/clock/mediatek,mt2701-hifsys.yaml

diff --git a/Documentation/devicetree/bindings/arm/mediatek/mediatek,hifsys.txt b/Documentation/devicetree/bindings/arm/mediatek/mediatek,hifsys.txt
deleted file mode 100644
index 323905af82c3..000000000000
--- a/Documentation/devicetree/bindings/arm/mediatek/mediatek,hifsys.txt
+++ /dev/null
@@ -1,26 +0,0 @@
-Mediatek hifsys controller
-============================
-
-The Mediatek hifsys controller provides various clocks and reset
-outputs to the system.
-
-Required Properties:
-
-- compatible: Should be:
-	- "mediatek,mt2701-hifsys", "syscon"
-	- "mediatek,mt7622-hifsys", "syscon"
-	- "mediatek,mt7623-hifsys", "mediatek,mt2701-hifsys", "syscon"
-- #clock-cells: Must be 1
-
-The hifsys controller uses the common clk binding from
-Documentation/devicetree/bindings/clock/clock-bindings.txt
-The available clocks are defined in dt-bindings/clock/mt*-clk.h.
-
-Example:
-
-hifsys: clock-controller@1a000000 {
-	compatible = "mediatek,mt2701-hifsys", "syscon";
-	reg = <0 0x1a000000 0 0x1000>;
-	#clock-cells = <1>;
-	#reset-cells = <1>;
-};
diff --git a/Documentation/devicetree/bindings/clock/mediatek,mt2701-hifsys.yaml b/Documentation/devicetree/bindings/clock/mediatek,mt2701-hifsys.yaml
new file mode 100644
index 000000000000..9e7c725093aa
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/mediatek,mt2701-hifsys.yaml
@@ -0,0 +1,50 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/clock/mediatek,mt2701-hifsys.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: MediaTek HIFSYS clock and reset controller
+
+description:
+  The MediaTek HIFSYS controller provides various clocks and reset outputs to
+  the system.
+
+maintainers:
+  - Matthias Brugger <matthias.bgg@gmail.com>
+
+properties:
+  compatible:
+    oneOf:
+      - enum:
+          - mediatek,mt2701-hifsys
+          - mediatek,mt7622-hifsys
+      - items:
+          - enum:
+              - mediatek,mt7623-hifsys
+          - const: mediatek,mt2701-hifsys
+
+  reg:
+    maxItems: 1
+
+  "#clock-cells":
+    const: 1
+    description: The available clocks are defined in dt-bindings/clock/mt*-clk.h
+
+  "#reset-cells":
+    const: 1
+
+required:
+  - reg
+  - "#clock-cells"
+
+additionalProperties: false
+
+examples:
+  - |
+    clock-controller@1a000000 {
+        compatible = "mediatek,mt2701-hifsys";
+        reg = <0x1a000000 0x1000>;
+        #clock-cells = <1>;
+        #reset-cells = <1>;
+    };
-- 
2.35.3


