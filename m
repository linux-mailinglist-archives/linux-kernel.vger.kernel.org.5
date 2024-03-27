Return-Path: <linux-kernel+bounces-120543-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A418488D923
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 09:30:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5AC9D2965BF
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 08:30:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBF9831A81;
	Wed, 27 Mar 2024 08:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OzS7plxM"
Received: from mail-oo1-f45.google.com (mail-oo1-f45.google.com [209.85.161.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FC9117BB3;
	Wed, 27 Mar 2024 08:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711528197; cv=none; b=jao0+GTWP5POqwKJG1645aoImqFlioLU12/+KavQWc0KiW261pXEx2Be7Lt4crrWoeRUa+N7A0YYzksc72HnIpCgiT2EnFiXlFfzq7ZTDzcIg5J1YMVtCkn3laP2BXN9T1wKg844/qI/uyfr5+2o0M3F5YOV5XLW1qlUPUBb0MQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711528197; c=relaxed/simple;
	bh=1z2DjnnEUQ8VRVOOj7bX9GFcbA+wqEyxADFf3p99mzE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SI752wb5vJNsL6KdBpYlTxjPiYABSQ+gRCi7BB46vbiVti7nLPtUpnSlowH+o+k2w+cWFWz3W1HCkF+kHZeApxT49zobWJktvLn3xwdjun4WWgGpmjbAngRnA5MaLhI5V0ltipU/EMHxkq9dm4wWMUOQLv/UvYZKsPpIQ+jhHB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OzS7plxM; arc=none smtp.client-ip=209.85.161.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f45.google.com with SMTP id 006d021491bc7-5a47cecb98bso3720403eaf.0;
        Wed, 27 Mar 2024 01:29:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711528194; x=1712132994; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FvyDKytI3LByIiwfwmYUFkoNWJX9ByqcE9gyEaLOuuM=;
        b=OzS7plxMkFjsWOFFHPZoLYu5Z7RkoZN1qg7KvnVNd1nVFMAStG97JfQffat+uPUSLh
         fyisHVWlemslvgsQxhFmIP3pN7Zzwutp95sNCd4RnnwnBO6Y7Uii5RZGdRpEmG8uk+MG
         kgdQ5UyaFSyoTKXgdFLBhq3axV4Mtumt+arjdAlH/Zv/uQMca4Wk+Q5tfBFBsfshH6wI
         sGqtPDUULhO4+FG/eJerN0e2FZlcLuij1UgOxnw/lLQcRg+xTXYOyY6bTmuuzuM3bQXr
         cxfg5HF6wS1dY7QypvLjgHz5tW6JGXADFgsdnZ+86kbFVIfhnOsWcW49RDW2BUJ8WWBz
         EUew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711528194; x=1712132994;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FvyDKytI3LByIiwfwmYUFkoNWJX9ByqcE9gyEaLOuuM=;
        b=V8hOZ/SHlkPbvFRR0wvYM1n5cpBV7di330Fm8LTs8FYNfKp24RXc28boYk1hVKcH0o
         xnbSS5cy6P76rFmLSO+LtCMslKEzooYG/JoahoMPcNL1OM1DAoASEnx7XQ2DwEofq9fJ
         FzvVV2GnHdHa9+wwkZB+KK/jtZjuK5erhW50VYSG4j6U0CYISEfZViefi87CVSKZ+4Td
         ZHtX6vNscJLNoi2gzDij8xztuX6+4535hWlQtpFCzwD3SKuLvyxKg1j3WgoSqdSP08b5
         84AcqP20ijqZ0KRzTKGnU/Vl40j46HfnU/9hjrRQLpAFA5fTkwU+riUwAXbbF0mKnGKJ
         bu8Q==
X-Forwarded-Encrypted: i=1; AJvYcCXtBpAF4ckiVlxJ2j3GAxKP3yH8j2EBozSXJB3cawSYkJOkaSPFZF361esT0TMSjsV7qeSeIHwWC360f2DRzR/QqhBwSgpS58LdIz9c8z2LUpsLmD3GyVnTil6SKRKghNHemCjFjrY7HCfg0OlC6Bwc15uwQAxu1caVtDV1u+IQZQhDvA==
X-Gm-Message-State: AOJu0Yx0XUDZoNNZkMoPjz1rQGQPGJH0ev8w6/0eL8YuhnbNMituMrqM
	VY7zv9IuZWJTGK35K8bGyQrLv4mnRLWKj72AT/z58lOhaGRDRNro
X-Google-Smtp-Source: AGHT+IEIETJYfm1LeEXZ17gb9zA1z0lN3OnPZ/F9w3Ecsm23rOzisdPobwpL692i6eZcBTxilITALA==
X-Received: by 2002:a05:6820:1a07:b0:5a4:71b3:d090 with SMTP id bq7-20020a0568201a0700b005a471b3d090mr483779oob.5.1711528194636;
        Wed, 27 Mar 2024 01:29:54 -0700 (PDT)
Received: from localhost.localdomain ([122.8.183.87])
        by smtp.gmail.com with ESMTPSA id bp12-20020a056820198c00b005a1bc9b380esm2229466oob.24.2024.03.27.01.29.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Mar 2024 01:29:54 -0700 (PDT)
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
Subject: [PATCH v12 1/5] dt-bindings: clock: sophgo: add pll clocks for SG2042
Date: Wed, 27 Mar 2024 16:29:47 +0800
Message-Id: <ea7c845ef81a933a4f927f76b69dc6f7a71942c0.1711527932.git.unicorn_wang@outlook.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1711527932.git.unicorn_wang@outlook.com>
References: <cover.1711527932.git.unicorn_wang@outlook.com>
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


