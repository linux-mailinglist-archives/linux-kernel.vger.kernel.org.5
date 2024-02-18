Return-Path: <linux-kernel+bounces-70161-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 217FF859431
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 03:51:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 85B3D1F21604
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 02:51:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97F3F149DFB;
	Sun, 18 Feb 2024 02:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EhMejjO1"
Received: from mail-oo1-f47.google.com (mail-oo1-f47.google.com [209.85.161.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD346149E0E;
	Sun, 18 Feb 2024 02:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708224669; cv=none; b=MwObGPQQEUtvT1XogoXWy+RVCFjgrqQoZr41AKgApa5bZpZ0cSvd4S8uiTWNBe685lQjTVCgcefZwa/Ok9qFr5KqPkKmpjOhi07wxo2thOhC11wSx8UOJVRDfL4x6OsjRNdjskfAA67dKXK54LU+SNgkFTDBTMPgbyWYxUGuBrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708224669; c=relaxed/simple;
	bh=qZtLfSCabFXM1zbJBeDXcJTFCoa5CiSclOu2tfdySOw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MwpMHJAop2TLwyFt/7/344hzsN3VJYQlmvQmlm6BfaLRZdYo5VK+ChbmPC6WkOs1aIEyZPOYOHyNfMQt57mJnzMin5JWdfP07thqpii57B44ZBg/LufFlES0/S/uxfbzZFpPRvGy5ou8m3sdb8r3/y4zurJDPYpVBtzUQC2XLmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EhMejjO1; arc=none smtp.client-ip=209.85.161.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-599f5e71d85so2118549eaf.3;
        Sat, 17 Feb 2024 18:51:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708224664; x=1708829464; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OJhvWCiuAiLMQCwCkgsdnNryPVW/71LDFA8iR1YzrEM=;
        b=EhMejjO1K3njffHDmhrBYFiaY/GO9urhRkbhLWQi7nl58gQtPaTqXci+LRINzy4mJB
         /FPM68CcYMnymHjfpim8WQ2aXA+m/dFUC23deohORbEMOLiz48xi+CMlOYnrL1eUNi5G
         ftzamin4OdLfv0Xx0k+PT/NNfDJNr0xPemxYYVpzHX2kk+ZQnq2bOnqcUxp9OzCgMPag
         xPiR1TkBIw2mdViASTEC5tR3/f8zp0f0W7MNAT2TPmcDwqkEm3hefQqkkzClya/VffUa
         Irq280692OGBIflm7T3L8SgEHkFFXLmTBEgGuF8bLA/h5LaTMXEc51WsqWhN5IImvPle
         tggQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708224664; x=1708829464;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OJhvWCiuAiLMQCwCkgsdnNryPVW/71LDFA8iR1YzrEM=;
        b=C8ucvFg7+lsVmoq5uI2OQlAfbuWY5GRxm1Pb5zZ/Heu/ALku6PdXO1Yh37361O4V/b
         tDxl1uzZN8T+iL6v1rLHYUQTgzv2UuS0LuI8x646i8r5zDsxxYONbu6M4jTgFFKalbOg
         /x1aKDQ6gGcHdlhuICf/c8kZa1wJzHuIkHnRlshlVkN/LGZG4PiJTeDgmK4wgHrT/aXJ
         gu9gPIQuFV/Mb5phSByZSi6NqVyBFKkiQA0In7nEPtnWJTaRbwYHfihQ3P5iDFwwvizG
         14gC4nymk6yJZXvhO7uOBG9JjUMaAEyzKJRo4qpugRKzqvAN6p1PP8wAkI3KycckbSrr
         8gJg==
X-Forwarded-Encrypted: i=1; AJvYcCU2cIsGjGagN89hTR7rIMeY80FuDRz6YZi/J1DuMMgJu/3eXtUdll7f931pOaICcCyS3M38GPUJzzEPfBPoNz8cXkPhTLurcNkQS6ByDEOfgBKZDbS8rMupEowLkpYkZ7fPd31LozDpoY9wNoSfg4B2BiKE0DMGGpFvS1SI9Fno/ajdwQ==
X-Gm-Message-State: AOJu0Ywn0Sn56Nhpe5uIWDGjoA3eX8QfAH7fz4gJe+6g+Dd36KL3ULwU
	EWpuaRrqjP4k2NYy6Qx/LEAYgYHywcv38uCuAxIEZaUK9MGW4erH
X-Google-Smtp-Source: AGHT+IEiYNzDXEQXqHIf5Bob3BZZiHADsLv+HRhoLak/eB89MmVLfHVQYczKxLEVNI0n4ewD2zaOUA==
X-Received: by 2002:a4a:241d:0:b0:59f:91de:26c8 with SMTP id m29-20020a4a241d000000b0059f91de26c8mr7420030oof.5.1708224664382;
        Sat, 17 Feb 2024 18:51:04 -0800 (PST)
Received: from localhost.localdomain ([122.8.183.87])
        by smtp.gmail.com with ESMTPSA id br21-20020a0568201a5500b0059fae4c8100sm510680oob.0.2024.02.17.18.51.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Feb 2024 18:51:04 -0800 (PST)
From: Chen Wang <unicornxw@gmail.com>
To: aou@eecs.berkeley.edu,
	chao.wei@sophgo.com,
	conor@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	mturquette@baylibre.com,
	palmer@dabbelt.com,
	paul.walmsley@sifive.com,
	richardcochran@gmail.com,
	robh+dt@kernel.org,
	sboyd@kernel.org,
	devicetree@vger.kernel.org,
	linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	haijiao.liu@sophgo.com,
	xiaoguang.xing@sophgo.com,
	guoren@kernel.org,
	jszhang@kernel.org,
	inochiama@outlook.com,
	samuel.holland@sifive.com
Cc: Chen Wang <unicorn_wang@outlook.com>,
	Rob Herring <robh@kernel.org>
Subject: [PATCH v10 1/5] dt-bindings: clock: sophgo: add pll clocks for SG2042
Date: Sun, 18 Feb 2024 10:50:56 +0800
Message-Id: <aaad6e257a44e312cfbeb5a8ce84b8975cdc461e.1708223519.git.unicorn_wang@outlook.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1708223519.git.unicorn_wang@outlook.com>
References: <cover.1708223519.git.unicorn_wang@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chen Wang <unicorn_wang@outlook.com>

Add bindings for the pll clocks for Sophgo SG2042.

Signed-off-by: Chen Wang <unicorn_wang@outlook.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 .../bindings/clock/sophgo,sg2042-pll.yaml     | 45 +++++++++++++++++++
 include/dt-bindings/clock/sophgo,sg2042-pll.h | 14 ++++++
 2 files changed, 59 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/sophgo,sg2042-pll.yaml
 create mode 100644 include/dt-bindings/clock/sophgo,sg2042-pll.h

diff --git a/Documentation/devicetree/bindings/clock/sophgo,sg2042-pll.yaml b/Documentation/devicetree/bindings/clock/sophgo,sg2042-pll.yaml
new file mode 100644
index 000000000000..b9af733e8a73
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/sophgo,sg2042-pll.yaml
@@ -0,0 +1,45 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/clock/sophgo,sg2042-pll.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Sophgo SG2042 PLL Clock Generator
+
+maintainers:
+  - Chen Wang <unicorn_wang@outlook.com>
+
+properties:
+  compatible:
+    const: sophgo,sg2042-pll
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    items:
+      - description: Oscillator(Clock Generation IC) for Main/Fixed PLL (25 MHz)
+      - description: Oscillator(Clock Generation IC) for DDR PLL 0 (25 MHz)
+      - description: Oscillator(Clock Generation IC) for DDR PLL 1 (25 MHz)
+
+  '#clock-cells':
+    const: 1
+    description:
+      See <dt-bindings/clock/sophgo,sg2042-pll.h> for valid indices.
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - '#clock-cells'
+
+additionalProperties: false
+
+examples:
+  - |
+    clock-controller@10000000 {
+      compatible = "sophgo,sg2042-pll";
+      reg = <0x10000000 0x10000>;
+      clocks = <&cgi_main>, <&cgi_dpll0>, <&cgi_dpll1>;
+      #clock-cells = <1>;
+    };
diff --git a/include/dt-bindings/clock/sophgo,sg2042-pll.h b/include/dt-bindings/clock/sophgo,sg2042-pll.h
new file mode 100644
index 000000000000..2d519b3bf51c
--- /dev/null
+++ b/include/dt-bindings/clock/sophgo,sg2042-pll.h
@@ -0,0 +1,14 @@
+/* SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause */
+/*
+ * Copyright (C) 2023 Sophgo Technology Inc. All rights reserved.
+ */
+
+#ifndef __DT_BINDINGS_SOPHGO_SG2042_PLL_H__
+#define __DT_BINDINGS_SOPHGO_SG2042_PLL_H__
+
+#define MPLL_CLK			0
+#define FPLL_CLK			1
+#define DPLL0_CLK			2
+#define DPLL1_CLK			3
+
+#endif /* __DT_BINDINGS_SOPHGO_SG2042_PLL_H__ */
-- 
2.25.1


