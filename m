Return-Path: <linux-kernel+bounces-124191-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 571CB8913AD
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 07:21:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C2A231F22BF5
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 06:21:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01E023EA64;
	Fri, 29 Mar 2024 06:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lUYrjVHg"
Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com [209.85.161.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94ACC3EA8A;
	Fri, 29 Mar 2024 06:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711693264; cv=none; b=FwT1vZqOOFs8IrTTNiPV3nlbK/B/2ly3eiSMT17aX3P2CbAB2m/5lMxrUrx30R03r7QZdQg6MeUqpaOERBKUB4K7RtmRIA86ERQw6TMmaDkXp5wP6TuWt4UzDhB6VhWs/VNmorH93xeUKZx+7aWKNweSGSuPi/HcvdzufOSl9Rk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711693264; c=relaxed/simple;
	bh=R0ygEHJUj8I1NP/GUex190+DSvdj/sG5voRmaHdDgSQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=t6hSVMjTuRHJ4ZXtWWwVqELDCiv224yrPREeyRI2oDv0NLuJOkwbIOJreQEpLvhYU4A8iE1fIRsCdZqOMOV6lOSn8x1ManTy0b96LzEEuEz3IBoK6DoI4sRajKKXFSm/ytHHYUT5V5qdxq76R3MTzVI3rJ/7B9iZQjHznU14YwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lUYrjVHg; arc=none smtp.client-ip=209.85.161.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-5a522ae3747so756800eaf.1;
        Thu, 28 Mar 2024 23:21:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711693261; x=1712298061; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=auVFVf5TZOUclH6ERFg1awZazyADre7qdwcfKdlYJq8=;
        b=lUYrjVHgXYukB1Ll4k7CgsOPrBqcFjLL9fo4H5+zfKcre2czg7HpnUiuWTR+Inc2Hr
         aUUG7pfzcS6kLGr2vPkZI57rTi61F9YKqH28YXogZA6Akcts5Wbbrd9PoNP9Gwvpg/Y8
         2bFq4ISYpKLWPfHlKuqS/E5AuZ0WPCtW53EK8Z1xxn4a0dmhDOPWkMyEqi3mX8C5qyon
         R/jWGqJCLDtT8xAo6m1XV9US6SsRR+MMdppdrM0w+xeFMVHNPwJVHTXZDPPhiXowytdB
         h5AnQ2yNph8E7V7Fnd7EAHbhpWW6iJH3H7R4cfcqC5r9li/l3nCQRaWobcnaoJ7p4Fy1
         KHkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711693262; x=1712298062;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=auVFVf5TZOUclH6ERFg1awZazyADre7qdwcfKdlYJq8=;
        b=dpL5/H6OmGDNDlaQp36W3aC2du8fTlGN5lci5jxFpoSha2h903x8rN0uBht+F9SUZj
         159HVuuaoyrvIptZ4DlG6UuWDu62Z/6yzoBB5qVVyC5Zjz48KwJYbAUE0egGVTnzxXcz
         9Hqj0z5cZj83MubHo74lQXENnJ9xbFD/kLF/YYjE7wdn3dnP+aVGKPWV8v4JhR5qiTel
         +O2pI0A4WtoDv/rrYo+uJpQCXtrYOzcT9+g0xvIIwnBor3Tal8nET3HMj2L3NuWLk33P
         37zrhjK2uLVZpc1fo5mn0S9qwD7JGwddU1a8NLRafTTHYNR2TGeRPxdeMt/Fz5Sregca
         VFUA==
X-Forwarded-Encrypted: i=1; AJvYcCXb0bYSaM57lokyvzuJcIFU1QfvY7f+5VIeyPqGMDyNp1i53CUG4Ki+Mvd9bUxUvyzv6IQnJvcchKuJYOKFWHbN1vp2KgYn8hfCKxcqEQZXChp8I2VFaRiM6mqk8cBY4gxBtf/5J8jVlfpNtE0XtShkG4tdG1XI0TpV3rvrt35sKhAVlw==
X-Gm-Message-State: AOJu0YyA12sgVJKp4RJHjD871ozq2YT3qwKmDOC09Koach9YrttMqgNt
	d70TIxnuVK+oH2T7i600yE0iOViIOdKF45saBcLBNtzLxBhaj3+6
X-Google-Smtp-Source: AGHT+IGrHT6esJkZupM+ldls/6v1YasvdCT9bxxVC5lyyFhVElo5RZXPRkjIlzujjWeJZ50t8IQMyw==
X-Received: by 2002:a05:6820:1e0a:b0:5a4:78d3:e8d5 with SMTP id dh10-20020a0568201e0a00b005a478d3e8d5mr608928oob.4.1711693261669;
        Thu, 28 Mar 2024 23:21:01 -0700 (PDT)
Received: from localhost.localdomain ([122.8.183.87])
        by smtp.gmail.com with ESMTPSA id q1-20020a4aec41000000b005a554ac27d0sm634849ooj.6.2024.03.28.23.20.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Mar 2024 23:21:01 -0700 (PDT)
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
Subject: [PATCH v13 2/5] dt-bindings: clock: sophgo: add RP gate clocks for SG2042
Date: Fri, 29 Mar 2024 14:20:54 +0800
Message-Id: <78ddd5b127860e110f4c782de90025153cdba083.1711692169.git.unicorn_wang@outlook.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1711692169.git.unicorn_wang@outlook.com>
References: <cover.1711692169.git.unicorn_wang@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chen Wang <unicorn_wang@outlook.com>

Add bindings for the gate clocks of RP subsystem for Sophgo SG2042.

Signed-off-by: Chen Wang <unicorn_wang@outlook.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 .../bindings/clock/sophgo,sg2042-rpgate.yaml  | 43 ++++++++++++++
 .../dt-bindings/clock/sophgo,sg2042-rpgate.h  | 58 +++++++++++++++++++
 2 files changed, 101 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/sophgo,sg2042-rpgate.yaml
 create mode 100644 include/dt-bindings/clock/sophgo,sg2042-rpgate.h

diff --git a/Documentation/devicetree/bindings/clock/sophgo,sg2042-rpgate.yaml b/Documentation/devicetree/bindings/clock/sophgo,sg2042-rpgate.yaml
new file mode 100644
index 000000000000..9a58038b3182
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/sophgo,sg2042-rpgate.yaml
@@ -0,0 +1,43 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/clock/sophgo,sg2042-rpgate.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Sophgo SG2042 Gate Clock Generator for RP(riscv processors) subsystem
+
+maintainers:
+  - Chen Wang <unicorn_wang@outlook.com>
+
+properties:
+  compatible:
+    const: sophgo,sg2042-rpgate
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    items:
+      - description: Gate clock for RP subsystem
+
+  '#clock-cells':
+    const: 1
+    description:
+      See <dt-bindings/clock/sophgo,sg2042-rpgate.h> for valid indices.
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
+    clock-controller@20000000 {
+      compatible = "sophgo,sg2042-rpgate";
+      reg = <0x20000000 0x10000>;
+      clocks = <&clkgen 85>;
+      #clock-cells = <1>;
+    };
diff --git a/include/dt-bindings/clock/sophgo,sg2042-rpgate.h b/include/dt-bindings/clock/sophgo,sg2042-rpgate.h
new file mode 100644
index 000000000000..8b4522d5f559
--- /dev/null
+++ b/include/dt-bindings/clock/sophgo,sg2042-rpgate.h
@@ -0,0 +1,58 @@
+/* SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause */
+/*
+ * Copyright (C) 2023 Sophgo Technology Inc. All rights reserved.
+ */
+
+#ifndef __DT_BINDINGS_SOPHGO_SG2042_RPGATE_H__
+#define __DT_BINDINGS_SOPHGO_SG2042_RPGATE_H__
+
+#define GATE_CLK_RXU0			0
+#define GATE_CLK_RXU1			1
+#define GATE_CLK_RXU2			2
+#define GATE_CLK_RXU3			3
+#define GATE_CLK_RXU4			4
+#define GATE_CLK_RXU5			5
+#define GATE_CLK_RXU6			6
+#define GATE_CLK_RXU7			7
+#define GATE_CLK_RXU8			8
+#define GATE_CLK_RXU9			9
+#define GATE_CLK_RXU10			10
+#define GATE_CLK_RXU11			11
+#define GATE_CLK_RXU12			12
+#define GATE_CLK_RXU13			13
+#define GATE_CLK_RXU14			14
+#define GATE_CLK_RXU15			15
+#define GATE_CLK_RXU16			16
+#define GATE_CLK_RXU17			17
+#define GATE_CLK_RXU18			18
+#define GATE_CLK_RXU19			19
+#define GATE_CLK_RXU20			20
+#define GATE_CLK_RXU21			21
+#define GATE_CLK_RXU22			22
+#define GATE_CLK_RXU23			23
+#define GATE_CLK_RXU24			24
+#define GATE_CLK_RXU25			25
+#define GATE_CLK_RXU26			26
+#define GATE_CLK_RXU27			27
+#define GATE_CLK_RXU28			28
+#define GATE_CLK_RXU29			29
+#define GATE_CLK_RXU30			30
+#define GATE_CLK_RXU31			31
+#define GATE_CLK_MP0			32
+#define GATE_CLK_MP1			33
+#define GATE_CLK_MP2			34
+#define GATE_CLK_MP3			35
+#define GATE_CLK_MP4			36
+#define GATE_CLK_MP5			37
+#define GATE_CLK_MP6			38
+#define GATE_CLK_MP7			39
+#define GATE_CLK_MP8			40
+#define GATE_CLK_MP9			41
+#define GATE_CLK_MP10			42
+#define GATE_CLK_MP11			43
+#define GATE_CLK_MP12			44
+#define GATE_CLK_MP13			45
+#define GATE_CLK_MP14			46
+#define GATE_CLK_MP15			47
+
+#endif /* __DT_BINDINGS_SOPHGO_SG2042_RPGATE_H__ */
-- 
2.25.1


