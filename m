Return-Path: <linux-kernel+bounces-158806-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 224328B2523
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 17:31:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8E4581F21096
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 15:31:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D465B14B08A;
	Thu, 25 Apr 2024 15:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fy8KimcW"
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D910149E0A;
	Thu, 25 Apr 2024 15:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714059082; cv=none; b=sucFJyRnqszt37jUZw8tCBlNCG1WSgNRF3VMsIdjSyR8H1miErAN42iv8hly5FrmS7p3bHqyhnLuXevJGVxoAQWBI5YOJVE8f0N+eNMCkhmdLhKjryMxTBMEA+lUzStEiHOm5CTecZK8AV/s25mQ272Ld72W1HXTRpXY2i78VKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714059082; c=relaxed/simple;
	bh=kx5+gE45WMQP6pGFUjecoShicQtKbjBVqw5ZcMyBzA4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KSESe+52VEjC7lzCpcWqT7Q5t9jRtOpsGM+8kEt61K0Gxluj6tNKIrUiEd4g+LDCS5H+4l+NKnum2BA1NIwyeVmnZHlGFPpxEFrxT6bvshx55hc3Q47kJHkul/FJHSD0QX4nfksAaC5M4ffPdIFVmgmm9hZYOgBgAd/50FWmWQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fy8KimcW; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-6f26588dd5eso1004899b3a.0;
        Thu, 25 Apr 2024 08:31:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714059080; x=1714663880; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rBERq5/uHp8GRTEc93jIGVH7PZTLRmKPZLsYuH5mF3k=;
        b=fy8KimcWyBO1+ZNq+di8d2eFfPi3nH3sPaJ5TVKMquEKJqRzIxmb0z8xySwbY/ndma
         gfllyCyn6yEzGYsW4l6wmG7ftVELXVQgtAdwptMgSJqEY10ZgCOdLN4MmNIBOnvqaDXN
         3GPPH1NFY6WMyKl3rpQ9ktUm37Yl/+7+EjhfjmQbxBQcMEB3XY4t1+6u+71n1eJrJiLO
         J7Ye6mdw/AaJF0BqoF1LM04fwJGR66xxEIhja+xscMyQ8F+kFhHmlRMO17td8DbL8bij
         B0Ep1dIgZFed86fY4Z4bI5OQGCIebN67n4GnSZ9gpYWWbLxXQWVBYA7QCmtg17aMy3cd
         JHPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714059080; x=1714663880;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rBERq5/uHp8GRTEc93jIGVH7PZTLRmKPZLsYuH5mF3k=;
        b=i9NY1WiRmqhHiH2lLwG5vuVBjOQtkaQ6VBvyr+nxnV5Sxy321de9D31Rv+h0QZobqH
         UbXPYufvV0NVcQtbjSSzxRpfEBs3TszF+7f5WDWsW0VfBDALSa3LP9PvMsourwlfjwdH
         W+yGgFZYJZxXsjFMJUWG4RBAvefhFq+8lqtJW+WwogiC4hITYTPiHfAL2YrGEXCGxg0+
         z6NA0xSkwAXfXB/6nK5l84teWspJCjjdsnRS9T1q/nRWXtxdEVGjsgrafrHh3fN6typX
         z+NBL3QQvulGLejByi6OdKvTqPndL3U9w4UvRhjMBbtAOGTqRDvCXbK4X5upc2CZcB2K
         r6VQ==
X-Forwarded-Encrypted: i=1; AJvYcCW5TkWKrn9LpDMBEBS1eTwnkKKTRxOQH2dKWGgdMHm0K7wvHQ9/clMG0oZ+Hz5JY/Kmpev/1lYwlgkF1iQ51iYYz11lwIvSNv3WbUNIqJjjqC20l8mfpFFfSl3JFfgkzgz07VaJevEKSdb7RRxIYrgH5TplWi1sDHXVaaa1/hgnNGNfiAYU2b6PMGid0LXKC7ugk6ljymWf6W+VzEAROq5fNAQ=
X-Gm-Message-State: AOJu0Yz4exfomqlB+dOEbhxdkLFNwvPc2Bvok3IRxZ0++ZiAnhkw8K66
	m5GAmz0n0SAaIQHXrCt7snexOrLO2lO7HWyhb1gRwJVYKpkT8EXe
X-Google-Smtp-Source: AGHT+IHlGWIXHIsV6x+Fn8uMP/x32pOhS4eia4ZjTF6cFW3rXTkhjaEK7imtaLKQ6B9z0Fwsf3z4Bw==
X-Received: by 2002:a05:6a20:de93:b0:1ad:47c1:7a53 with SMTP id la19-20020a056a20de9300b001ad47c17a53mr4870353pzb.54.1714059079631;
        Thu, 25 Apr 2024 08:31:19 -0700 (PDT)
Received: from localhost (ec2-3-111-32-5.ap-south-1.compute.amazonaws.com. [3.111.32.5])
        by smtp.gmail.com with UTF8SMTPSA id b19-20020a056a000a9300b006eae3aac040sm13269777pfl.31.2024.04.25.08.31.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Apr 2024 08:31:19 -0700 (PDT)
From: Mohammad Shehar Yaar Tausif <sheharyaar48@gmail.com>
To: Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>
Cc: Mohammad Shehar Yaar Tausif <sheharyaar48@gmail.com>,
	Thierry Reding <treding@nvidia.com>,
	linux-sound@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-tegra@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4] ASoC: dt-bindings: tegra30-i2s: convert to dt schema
Date: Thu, 25 Apr 2024 21:00:43 +0530
Message-ID: <20240425153045.49939-1-sheharyaar48@gmail.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert NVIDIA Tegra30 I2S binding to DT schema and
add "clock-names" property used by multiple tegra i2s blocks
in arch/arm64/boot/dts/nvidia/tegra132.dtsi. This is not a
required property by the binding.

Signed-off-by: Mohammad Shehar Yaar Tausif <sheharyaar48@gmail.com>
---
Changes v3->v4:
- removed redundant example
- defined clock-names property

v3:
https://lore.kernel.org/all/20240425090716.176818-1-sheharyaar48@gmail.com/
---
 .../bindings/sound/nvidia,tegra30-i2s.txt     | 27 ------
 .../bindings/sound/nvidia,tegra30-i2s.yaml    | 83 +++++++++++++++++++
 2 files changed, 83 insertions(+), 27 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/sound/nvidia,tegra30-i2s.txt
 create mode 100644 Documentation/devicetree/bindings/sound/nvidia,tegra30-i2s.yaml

diff --git a/Documentation/devicetree/bindings/sound/nvidia,tegra30-i2s.txt b/Documentation/devicetree/bindings/sound/nvidia,tegra30-i2s.txt
deleted file mode 100644
index 38caa936f6f8..000000000000
--- a/Documentation/devicetree/bindings/sound/nvidia,tegra30-i2s.txt
+++ /dev/null
@@ -1,27 +0,0 @@
-NVIDIA Tegra30 I2S controller
-
-Required properties:
-- compatible : For Tegra30, must contain "nvidia,tegra30-i2s".  For Tegra124,
-  must contain "nvidia,tegra124-i2s".  Otherwise, must contain
-  "nvidia,<chip>-i2s" plus at least one of the above, where <chip> is
-  tegra114 or tegra132.
-- reg : Should contain I2S registers location and length
-- clocks : Must contain one entry, for the module clock.
-  See ../clocks/clock-bindings.txt for details.
-- resets : Must contain an entry for each entry in reset-names.
-  See ../reset/reset.txt for details.
-- reset-names : Must include the following entries:
-  - i2s
-- nvidia,ahub-cif-ids : The list of AHUB CIF IDs for this port, rx (playback)
-  first, tx (capture) second. See nvidia,tegra30-ahub.txt for values.
-
-Example:
-
-i2s@70080300 {
-	compatible = "nvidia,tegra30-i2s";
-	reg = <0x70080300 0x100>;
-	nvidia,ahub-cif-ids = <4 4>;
-	clocks = <&tegra_car 11>;
-	resets = <&tegra_car 11>;
-	reset-names = "i2s";
-};
diff --git a/Documentation/devicetree/bindings/sound/nvidia,tegra30-i2s.yaml b/Documentation/devicetree/bindings/sound/nvidia,tegra30-i2s.yaml
new file mode 100644
index 000000000000..13cee366f5b3
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/nvidia,tegra30-i2s.yaml
@@ -0,0 +1,83 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/sound/nvidia,tegra30-i2s.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: NVIDIA Tegra30 I2S controller
+
+maintainers:
+  - Thierry Reding <treding@nvidia.com>
+  - Jon Hunter <jonathanh@nvidia.com>
+
+properties:
+  compatible:
+    oneOf:
+      - enum:
+          - nvidia,tegra124-i2s
+          - nvidia,tegra30-i2s
+      - items:
+          - enum:
+              - nvidia,tegra114-i2s
+              - nvidia,tegra132-i2s
+          - enum:
+              - nvidia,tegra124-i2s
+              - nvidia,tegra30-i2s
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+  clock-names:
+    const: i2s
+
+  resets:
+    maxItems: 1
+
+  reset-names:
+    const: i2s
+
+  nvidia,ahub-cif-ids:
+    description: list of AHUB CIF IDs
+    $ref: /schemas/types.yaml#/definitions/uint32-array
+    items:
+      - description: rx (playback)
+      - description: tx (capture)
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - resets
+  - reset-names
+  - nvidia,ahub-cif-ids
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/tegra30-car.h>
+
+    i2s@70080300 {
+        compatible = "nvidia,tegra30-i2s";
+        reg = <0x70080300 0x100>;
+        nvidia,ahub-cif-ids = <4 4>;
+        clocks = <&tegra_car TEGRA30_CLK_I2S0>;
+        resets = <&tegra_car 30>;
+        reset-names = "i2s";
+    };
+  - |
+    #include <dt-bindings/clock/tegra124-car.h>
+
+    i2s@70301100 {
+        compatible = "nvidia,tegra124-i2s";
+        reg = <0x70301100 0x100>;
+        nvidia,ahub-cif-ids = <5 5>;
+        clocks = <&tegra_car TEGRA124_CLK_I2S1>;
+        clock-names = "i2s";
+        resets = <&tegra_car 11>;
+        reset-names = "i2s";
+    };
+...
-- 
2.44.0


