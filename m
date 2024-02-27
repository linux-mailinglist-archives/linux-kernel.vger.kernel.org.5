Return-Path: <linux-kernel+bounces-83578-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED445869BDA
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 17:17:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F2AC7B23393
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 16:14:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4A4A1487D8;
	Tue, 27 Feb 2024 16:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=udima.es header.i=@udima.es header.b="io+5H2+g"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C99C1487C6
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 16:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709050434; cv=none; b=mf4jg0g66VO7KlIFtNQQvIRXEWAAygDLvrfhESFiIbKxfZY302oR+rZx5f/T1X0G+V5KBA6BxQkM/HfSr0jlg3qUqdTtcqzVpR0X3yGxVNk8PitOH2cviOwZAB+Vl1g6iBZVw1X9K5GFRi1smpH/CIsB2o4xBOxnQnfsjFz+12Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709050434; c=relaxed/simple;
	bh=ynCwNGBCpdLuOAMyA2li1eRc4k2Kg54U/5iHg9f2QIA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pktVl6iZntoHPX9OH6B+MiqmjiuLQA6294DdU+JKv25JG5MZKh5pmR6Sl6Pv+ZIS8D/G48uRWxKJTj+twc5Sz/dG23UGTswgXkceHkE6tM3B/FxTJAQ4n1F+Q891Q39NsWMas/hyRHEPHqhDmOcbwDEOJDQ4UxYkGKhtsl0jqWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=udima.es; spf=pass smtp.mailfrom=udima.es; dkim=pass (1024-bit key) header.d=udima.es header.i=@udima.es header.b=io+5H2+g; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=udima.es
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=udima.es
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-412af664954so4603625e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 08:13:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=udima.es; s=google; t=1709050429; x=1709655229; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lIjsoxnq6AgqQD4mfxCKabO/R3fvGqki3BITIbxy4c0=;
        b=io+5H2+gKcpS6u5J5aqxUB7can1uMBSJBYmRSSjzAMa2BrvNHb0em1JFhMcY5vvY1M
         c+PyGMXI66qd+wbRa0FW2gVzgbS3+0YJ5wPAZFH+a8qZkdX430ww0rHlbUvQK9XZyijG
         i28ZQQ4WUpOAye3rXamyle7wnCmuIVST+WmoM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709050429; x=1709655229;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lIjsoxnq6AgqQD4mfxCKabO/R3fvGqki3BITIbxy4c0=;
        b=lqKfV/FVzo7fABNc4iby1oK1D9X89/5ms+8amfbdUnBUMnnML3slysHiB5HiLprx7j
         WnENdL2lE0OWnYeipnFI1QH3yR/EeUf5unjOwphBQEfdNRiHrLxxU3DGxa8cgoFZeDoe
         4XsoqavGJujGqPJFWC6mpfS/laIRuAkoRERXrEg7+Z7CZzu1m4CJJGnUE+jmKg4BCmk9
         vAVDa3f9mHtPpwFdspt88yz5kjeiJZOypSYtcG2Dj/E3pujZHUH+zQ1g5G3HGeDpEJ1w
         UlNXafIsFkoNd/X6getcgYcLh6u4FwwaSHnois2W3S+fIg+l1del/vxyseEEF/cTN+1b
         sP2w==
X-Forwarded-Encrypted: i=1; AJvYcCW8ciLph+OSO2MILEkgm099F7oy5cd+kbMR5LsTvU9/fY4ZQ7nFO2N5WEAjkkVbB7E8QjB3NEA4ynBMw6AkWGTsvh9h1hWZg41cj+jD
X-Gm-Message-State: AOJu0YzygarA8noM+VGodbGijE/+uDM5w1ICgWkeEWVm6eanhrjG5yQN
	OqjSBRmSTi8/TBjoUR6Cuo4segBuDOU2JZc1tXsD5W5GDcV8WTyqJKu+b6ancKs=
X-Google-Smtp-Source: AGHT+IG06PGVQEU3WAnZ+8bEx0FEcvUA92bULNNkoRNL4eczSC9AUEzpmKjluS0KPvrpX9I8Z/LbZA==
X-Received: by 2002:a05:600c:1989:b0:412:9dfc:f67a with SMTP id t9-20020a05600c198900b004129dfcf67amr7819985wmq.12.1709050429339;
        Tue, 27 Feb 2024 08:13:49 -0800 (PST)
Received: from portatil76.udima ([79.116.0.170])
        by smtp.googlemail.com with ESMTPSA id 9-20020a05600c020900b004104bc8d841sm15225371wmi.13.2024.02.27.08.13.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Feb 2024 08:13:49 -0800 (PST)
From: =?UTF-8?q?Javier=20Garc=C3=ADa?= <javier.garcia.ta@udima.es>
To: 
Cc: daniel.baluta@nxp.com,
	javier.garcia.ta@udima.es,
	daniel.baluta@gmail.com,
	broonie@kernel.org,
	krzysztof.kozlowski@linaro.org,
	Liam Girdwood <lgirdwood@gmail.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	alsa-devel@alsa-project.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] ASoC: dt-bindings: img,spdif-in: Convert to dtschema
Date: Tue, 27 Feb 2024 17:09:47 +0100
Message-ID: <20240227160952.615291-1-javier.garcia.ta@udima.es>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240227123602.258190-1-javier.garcia.ta@udima.es>
References: <20240227123602.258190-1-javier.garcia.ta@udima.es>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Convert the Imagination Technologies SPDIF Input Controllerto DT schema.

Signed-off-by: Javier García <javier.garcia.ta@udima.es>
---
 .../bindings/sound/img,spdif-in.txt           | 41 ----------
 .../bindings/sound/img,spdif-in.yaml          | 78 +++++++++++++++++++
 2 files changed, 78 insertions(+), 41 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/sound/img,spdif-in.txt
 create mode 100644 Documentation/devicetree/bindings/sound/img,spdif-in.yaml

diff --git a/Documentation/devicetree/bindings/sound/img,spdif-in.txt b/Documentation/devicetree/bindings/sound/img,spdif-in.txt
deleted file mode 100644
index f7ea8c87bf34..000000000000
--- a/Documentation/devicetree/bindings/sound/img,spdif-in.txt
+++ /dev/null
@@ -1,41 +0,0 @@
-Imagination Technologies SPDIF Input Controller
-
-Required Properties:
-
-  - compatible : Compatible list, must contain "img,spdif-in"
-
-  - #sound-dai-cells : Must be equal to 0
-
-  - reg : Offset and length of the register set for the device
-
-  - dmas: Contains an entry for each entry in dma-names.
-
-  - dma-names: Must include the following entry:
-	"rx"
-
-  - clocks : Contains an entry for each entry in clock-names
-
-  - clock-names : Includes the following entries:
-	"sys"	The system clock
-
-Optional Properties:
-
-  - resets: Should contain a phandle to the spdif in reset signal, if any
-
-  - reset-names: Should contain the reset signal name "rst", if a
-	reset phandle is given
-
-  - interrupts : Contains the spdif in interrupt, if present
-
-Example:
-
-spdif_in: spdif-in@18100e00 {
-	compatible = "img,spdif-in";
-	reg = <0x18100E00 0x100>;
-	interrupts = <GIC_SHARED 20 IRQ_TYPE_LEVEL_HIGH>;
-	dmas = <&mdc 15 0xffffffff 0>;
-	dma-names = "rx";
-	clocks = <&cr_periph SYS_CLK_SPDIF_IN>;
-	clock-names = "sys";
-	#sound-dai-cells = <0>;
-};
diff --git a/Documentation/devicetree/bindings/sound/img,spdif-in.yaml b/Documentation/devicetree/bindings/sound/img,spdif-in.yaml
new file mode 100644
index 000000000000..1d2e318b349f
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/img,spdif-in.yaml
@@ -0,0 +1,78 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/sound/img,spdif-in.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Imagination Technologies SPDIF Input Controller
+
+maintainers:
+  - Liam Girdwood <lgirdwood@gmail.com>
+  - Mark Brown <broonie@kernel.org>
+
+allOf:
+  - $ref: dai-common.yaml#
+
+properties:
+  compatible:
+    enum:
+      - img,spdif-in
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  dmas:
+    maxItems: 1
+
+  dma-names:
+    items:
+      - const: rx
+
+  clocks:
+    items:
+      - description: The system clock
+
+  clock-names:
+    items:
+      - const: sys
+
+  '#sound-dai-cells':
+    const: 0
+
+  resets:
+    maxItems: 1
+
+  reset-names:
+    items:
+      - const: rst
+
+required:
+  - compatible
+  - reg
+  - dmas
+  - dma-names
+  - clocks
+  - clock-names
+  - '#sound-dai-cells'
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/pistachio-clk.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
+    #include <dt-bindings/interrupt-controller/mips-gic.h>
+    spdif_in: spdif@18100e00 {
+        compatible = "img,spdif-in";
+        reg = <0x18100e00 0x100>;
+        interrupts = <GIC_SHARED 20 IRQ_TYPE_LEVEL_HIGH>;
+        dmas = <&mdc 15 0xffffffff 0>;
+        dma-names = "rx";
+        clocks = <&cr_periph SYS_CLK_SPDIF_IN>;
+        clock-names = "sys";
+
+        #sound-dai-cells = <0>;
+    };
-- 
2.43.0


