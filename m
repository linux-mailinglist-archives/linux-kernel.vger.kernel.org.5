Return-Path: <linux-kernel+bounces-79606-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F9D18624AB
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 12:46:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DDC731F22065
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 11:46:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 085973F9C6;
	Sat, 24 Feb 2024 11:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="shmlPHus"
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ECBD3C473
	for <linux-kernel@vger.kernel.org>; Sat, 24 Feb 2024 11:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708775149; cv=none; b=OZn+Xz+hYr89+qE0EvTztpd9ivdoteszdmBJ2g4+mO2G6nS58FVZ19FxcUJVgUhS8vD+UsCJBZy+d+pjhlW1q0WTKnHJdL0rQ/gsIqwWT3p344RVdSOyBnQBazqPGdQlvGkXaDKO/5sGJMjLJQ+hBZg8/64/bJdxBe4ZmYaZ28w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708775149; c=relaxed/simple;
	bh=IC5A3pZTbDPbGSPDFbfcuoQTduPSqtKVd0/010GNXf4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pMQiNve03dLwu7j0lUmd+OG9DKmoRM9YTneZ7aRWeTdvc1VUQ5IRHtgkGVxWEahAmiU7HzS5bX0QHqXflGw0W7fjDU7SbUXnSEuhth9mAypWKMFpeoh1FQ4NMhr9aWMLDJdSMV5PH17bHVLFo2V3miJHQ94fEUyolKAC1En7olg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=shmlPHus; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a3e85a76fa8so151267866b.1
        for <linux-kernel@vger.kernel.org>; Sat, 24 Feb 2024 03:45:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708775144; x=1709379944; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ftlPy5iUSBiEG7hkLYK5QF6hb+D3xmG+8r6qGtLsN9Q=;
        b=shmlPHusiIFTp3LEp8dzre3vorB+OaI5TPhGdtyGPpIVm3fxH0KtrlaijBevEQ3BQo
         0u9CGHT+jmgCqoESFIm42ywWQ8L8AGGuFIlZWHIQsl6Wek5f/cuL58E4ubotPNpfwQg6
         V5xjOAZYulTak71JgqTS/s4m76l02noyyrRt5EXk9d97rIgkQ5Xe7XWi5AJOI5YE57Pw
         TaoWnyecKtIsUf3W0BVKZxVYnswIYxdvNNcwIhjpTk6OAWIS68jS/x8CzT75eeQPnL0r
         R2lfIkWo/+SIsOxFnArolq1hkt2Wta6EhsCSxoS7vnzX8/6PghVfRGxOcEZ/eH0F9Bkq
         kkQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708775144; x=1709379944;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ftlPy5iUSBiEG7hkLYK5QF6hb+D3xmG+8r6qGtLsN9Q=;
        b=fAJrPVCRqZ4sIdYD1ZJYQeQglPesb9oIQp4CRtOyewwQH9dT0O+VTy+Bi5Im4ygpw0
         2PcEWsAzyapLfAWlo6BwJJWUg5swgFVvu6aP4bVykOghioolwIBD0+jsu74L/s5A+3LE
         kzGeojM+7qj6PhKchqtyW5aAR5FCWigZJCZxEqHoitgM3M02UUh8cJMyd1Ze8IyDdUVe
         bDOojklDv9avK04S7avOYmbyLzVjI/6jh2FJJxQycs4rzFL+S/RD+gv6GZm19ERRh1d/
         HMCNEfByrR+y3WGYD43PwGUqTKSTPUWBo7AoEopebUVAPreBSZq6L4XHuLyHG8tOm/ek
         5cyw==
X-Gm-Message-State: AOJu0Yz3sv4lxJDK7+tTDJtGnU36bf0+ypJ+NvozRiQaytups52RpCP4
	tEEkrXROm+OmU+Bs9Nfuyzo+hmtLWbB3l13A+wZE3k3/vx3JvD307AuYpf603pk=
X-Google-Smtp-Source: AGHT+IG4L+HOHU77A5hkd99hf1XKtFNvf3jHNIXOz+YD6jefCLv4OkibTG3SIe/USdEYUiljWJJ5tQ==
X-Received: by 2002:a17:906:52cb:b0:a3f:b6f8:3969 with SMTP id w11-20020a17090652cb00b00a3fb6f83969mr1364284ejn.9.1708775144700;
        Sat, 24 Feb 2024 03:45:44 -0800 (PST)
Received: from localhost.localdomain (82-132-212-111.dab.02.net. [82.132.212.111])
        by smtp.gmail.com with ESMTPSA id jp10-20020a170906f74a00b00a3e209b225asm517826ejb.43.2024.02.24.03.45.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Feb 2024 03:45:44 -0800 (PST)
From: srinivas.kandagatla@linaro.org
To: gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org,
	Praveen Teja Kundanala <praveen.teja.kundanala@amd.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 03/11] dt-bindings: nvmem: Convert xlnx,zynqmp-nvmem.txt to yaml
Date: Sat, 24 Feb 2024 11:45:08 +0000
Message-Id: <20240224114516.86365-4-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240224114516.86365-1-srinivas.kandagatla@linaro.org>
References: <20240224114516.86365-1-srinivas.kandagatla@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3412; i=srinivas.kandagatla@linaro.org; h=from:subject; bh=5gPT65/cQJCVAohnxbVMvhSFCBOGKQLLlzRupY1vB5Y=; b=owEBbQGS/pANAwAKAXqh/VnHNFU3AcsmYgBl2dbLAL3DFHySKyBIcdz8yGcCF4wREK67ZeJgp E7FGNIhmu+JATMEAAEKAB0WIQQi509axvzi9vce3Y16of1ZxzRVNwUCZdnWywAKCRB6of1ZxzRV N0LwCACz8JguxCensUsY5lTy3iKwl+SyUvKKPQKz5D6ixsKdyM+0hbZ6q5zckO2PvxGoPul1ByL TFg56EQopxi3kRskxOC4onaBts1mWoJ+8d8ckm5czcaNrPls0DHRzMP9ePypdwHLKFL7bTjPQcY XGJeh7EsCkgmfA1aeyWKEY6T1U3+w4pI2M+1bkCdw59piUMEoN+VgaioKPUCZSvknEyfci8QhE+ w3TvvdKUwmL8+sWDWoMxalc3pRE1VaTPgI6pc8NKhyHIBr4QsiAbNx05Iu4r7qlGEIPkimRwd9R 3Lg8m+S7vjthHvLA933kZ2vGhSfVXcuOPeCyw+bRaVKl0p98
X-Developer-Key: i=srinivas.kandagatla@linaro.org; a=openpgp; fpr=ED6472765AB36EC43B3EF97AD77E3FC0562560D6
Content-Transfer-Encoding: 8bit

From: Praveen Teja Kundanala <praveen.teja.kundanala@amd.com>

Convert the xlnx,zynqmp-nvmem.txt to yaml.

Signed-off-by: Praveen Teja Kundanala <praveen.teja.kundanala@amd.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 .../bindings/nvmem/xlnx,zynqmp-nvmem.txt      | 46 -------------------
 .../bindings/nvmem/xlnx,zynqmp-nvmem.yaml     | 42 +++++++++++++++++
 2 files changed, 42 insertions(+), 46 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/nvmem/xlnx,zynqmp-nvmem.txt
 create mode 100644 Documentation/devicetree/bindings/nvmem/xlnx,zynqmp-nvmem.yaml

diff --git a/Documentation/devicetree/bindings/nvmem/xlnx,zynqmp-nvmem.txt b/Documentation/devicetree/bindings/nvmem/xlnx,zynqmp-nvmem.txt
deleted file mode 100644
index 4881561b3a02..000000000000
--- a/Documentation/devicetree/bindings/nvmem/xlnx,zynqmp-nvmem.txt
+++ /dev/null
@@ -1,46 +0,0 @@
---------------------------------------------------------------------------
-=  Zynq UltraScale+ MPSoC nvmem firmware driver binding =
---------------------------------------------------------------------------
-The nvmem_firmware node provides access to the hardware related data
-like soc revision, IDCODE... etc, By using the firmware interface.
-
-Required properties:
-- compatible: should be "xlnx,zynqmp-nvmem-fw"
-
-= Data cells =
-Are child nodes of silicon id, bindings of which as described in
-bindings/nvmem/nvmem.txt
-
--------
- Example
--------
-firmware {
-	zynqmp_firmware: zynqmp-firmware {
-		compatible = "xlnx,zynqmp-firmware";
-		method = "smc";
-
-		nvmem_firmware {
-			compatible = "xlnx,zynqmp-nvmem-fw";
-			#address-cells = <1>;
-			#size-cells = <1>;
-
-			/* Data cells */
-			soc_revision: soc_revision {
-				reg = <0x0 0x4>;
-			};
-		};
-	};
-};
-
-= Data consumers =
-Are device nodes which consume nvmem data cells.
-
-For example:
-	pcap {
-		...
-
-		nvmem-cells = <&soc_revision>;
-		nvmem-cell-names = "soc_revision";
-
-		...
-	};
diff --git a/Documentation/devicetree/bindings/nvmem/xlnx,zynqmp-nvmem.yaml b/Documentation/devicetree/bindings/nvmem/xlnx,zynqmp-nvmem.yaml
new file mode 100644
index 000000000000..917c40d5c382
--- /dev/null
+++ b/Documentation/devicetree/bindings/nvmem/xlnx,zynqmp-nvmem.yaml
@@ -0,0 +1,42 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/nvmem/xlnx,zynqmp-nvmem.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Zynq UltraScale+ MPSoC Non Volatile Memory interface
+
+description: |
+    The ZynqMP MPSoC provides access to the hardware related data
+    like SOC revision, IDCODE and specific purpose efuses.
+
+maintainers:
+  - Kalyani Akula <kalyani.akula@amd.com>
+  - Praveen Teja Kundanala <praveen.teja.kundanala@amd.com>
+
+allOf:
+  - $ref: nvmem.yaml#
+
+properties:
+  compatible:
+    const: xlnx,zynqmp-nvmem-fw
+
+required:
+  - compatible
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    nvmem {
+        compatible = "xlnx,zynqmp-nvmem-fw";
+        nvmem-layout {
+            compatible = "fixed-layout";
+            #address-cells = <1>;
+            #size-cells = <1>;
+
+            soc_revision: soc-revision@0 {
+                reg = <0x0 0x4>;
+            };
+        };
+    };
-- 
2.25.1


