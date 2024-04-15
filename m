Return-Path: <linux-kernel+bounces-144660-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 867768A48E5
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 09:22:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A91781C22E0D
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 07:22:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81EE12263E;
	Mon, 15 Apr 2024 07:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OPZ73lmV"
Received: from mail-oo1-f42.google.com (mail-oo1-f42.google.com [209.85.161.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68D272E620;
	Mon, 15 Apr 2024 07:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713165751; cv=none; b=ku5ffH40SMB98ym7xh9X1+EDSS3XNibwxcpqz00UsvaPN5rWPE+M65melqwNnfgjqp5gTPB6YR4JoF0P6YZa2EfIIpCzCaxm5TEnT9Am11ACramRNp9EcCCdZiFHb5eBxdsH/Bp6mxSV4PuB1Fi4sXnezSqv2jo+ttEnu2PtLOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713165751; c=relaxed/simple;
	bh=1z2DjnnEUQ8VRVOOj7bX9GFcbA+wqEyxADFf3p99mzE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WnU+AmS8ICw9+jKw99xbAC8nQoLeZXHbysqj3BSKT/+oEE54n6icghF053nKb+MAsryh0ypnn+APvvYcJciloLFZJIe7VpY0rISe47FlrIaM4GOraEBNsbp3W3Y8T+Gvlml4oIQHVJo1sxzXQ412pWAwGmWbr8FFJnZk5sAX9Uw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OPZ73lmV; arc=none smtp.client-ip=209.85.161.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-5aa1b7a37b5so1977439eaf.2;
        Mon, 15 Apr 2024 00:22:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713165749; x=1713770549; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FvyDKytI3LByIiwfwmYUFkoNWJX9ByqcE9gyEaLOuuM=;
        b=OPZ73lmVeDDHRsS6Dp1gPRpJvhrtD66t81yl/euZoCLacplKu7pj8iAVvMJoH4uIUo
         OI2BAZhhowh8k3R9BIY3AlHpOp+sCSXwF/X2SfSb/ZI2kI6Xb9bdlQWUtrZUQc5UXyP9
         FbzBFHs4TSPbJDOhH35X3P9IQ1kKX6B54X6Wk6SNYba+aE3ndPzfT+0Z0olpyqRZHAFJ
         zZDvmqBGPjFwZ9wseYi0t8d4f+GODCd3dC42dWAqc5FtkJDDsZ4s4DPH33iHF9BrS3/p
         k+E8yAfqkC0MUQBOz1ODpKm8Rs8WZ8bGq3w6HUuQ8SXBQmdxckbqHJvHogp0juy9fPYM
         h9ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713165749; x=1713770549;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FvyDKytI3LByIiwfwmYUFkoNWJX9ByqcE9gyEaLOuuM=;
        b=P+Zze7vQc5dywOQM/wQ4tdtGqV2BMY5HQKNEbSit3rOXMo2Jey87DiV4pr2dQcpcrm
         YfzezZNNAqqsfz+KJuUlMiNTwkelnkmeiJIixbj5hbYcTxqNlqGksPLIx8ez4MOBzLjC
         pI3iVSh2GczTYO67DP4f0l/wienKp2R8qxLsq86Ctqn2y98nxsElPbX2wh/oSxbqWHjn
         shlEncvtUbJcb6hJR9SLdcPr3GXbwQKFGH7FqUVb3MDOmWIlQJ2mdcEGH8YCB4POTqGv
         tsX/p5t8UofB80RdtS2TbMltsEt1Pq0bDWAlr3Hw/w3FvTDypInGj1Kh5oJL/5CPZHuC
         Mckg==
X-Forwarded-Encrypted: i=1; AJvYcCUTGZpsI+6heO2cbOzLnZTzychUKeh/xj0Nst5CLVm0Wp/dX8ON/3RIignmIgtQ70WMQopEdE2CjEdXgbAlP/79K3jbfHBujEOCBeb1KzlyLHO0yG3H/WV+diyXxjo2jp/M4QBHaLFG3CeqvBLGaREqMvYDyfINPnYSmwIEA1z97fAEPQ==
X-Gm-Message-State: AOJu0YwQeGBX+kh8CMCB5d1oPgWaD7LX8Qe842vfdhiLlXAKmZbu7Yau
	eHECGrunZGpvWnvAsCxq9R5akLnes7OEFU3ctw+dK1IarIwzSapX
X-Google-Smtp-Source: AGHT+IHvpL041wks7+mOr6ziePq05Pg/yOBK9Eo6y8ri2QCWzxBiiD99Wbd6D62vwHtEEj7hjryxSQ==
X-Received: by 2002:a4a:8c0c:0:b0:5ac:bdbf:8a31 with SMTP id u12-20020a4a8c0c000000b005acbdbf8a31mr115405ooj.8.1713165749474;
        Mon, 15 Apr 2024 00:22:29 -0700 (PDT)
Received: from localhost.localdomain ([122.8.183.87])
        by smtp.gmail.com with ESMTPSA id bw16-20020a056820021000b005a588e72c3bsm1967615oob.9.2024.04.15.00.22.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Apr 2024 00:22:27 -0700 (PDT)
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
Subject: [PATCH v14 1/5] dt-bindings: clock: sophgo: add pll clocks for SG2042
Date: Mon, 15 Apr 2024 15:22:18 +0800
Message-Id: <cb4ccaad1d3637a6ebb0413dbe45bb0fd12ed401.1713164546.git.unicorn_wang@outlook.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1713164546.git.unicorn_wang@outlook.com>
References: <cover.1713164546.git.unicorn_wang@outlook.com>
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
Reviewed-by: Guo Ren <guoren@kernel.org>
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


