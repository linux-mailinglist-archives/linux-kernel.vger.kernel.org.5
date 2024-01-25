Return-Path: <linux-kernel+bounces-37996-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E5A8B83B971
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 07:11:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 170711C22E1E
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 06:11:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43F6F10A12;
	Thu, 25 Jan 2024 06:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KxAjUs6T"
Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EA3910A09;
	Thu, 25 Jan 2024 06:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706163052; cv=none; b=YczRw1N9lHudUztXuBqg7wfPKZRl4dlB8H9eDbHh5X3wmVcBbiJhPMq/7nudc1yemvd1WKVLsb4N+APr/lSyCUNfMI2ywgtCW/0x3RIm3TmTMqrfW+O190NagYPJcDcDRjpxL1K17XCThiYzzVdtaXyNyxhRaIIeKNFXGUnX6I0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706163052; c=relaxed/simple;
	bh=r/19X/dXC1ycEPcHoy86G01yBsusb4I+9Ho0FYXMyEw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=B2y0MJS6ACCyjaMv8X6eDfY5RWOGI9wXNa2PY9blZ5/5XO2/UKpaZ734vamlSdlLi74ngp376K6d0X3J0GYPlpMeG2i2JoZ4bVi2m3/fr1px5XZck5CRND7EkYjN4du6jVipzr8bRE7gPbHhizca2nGI7SnZFC+trXj/5Bn3KjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KxAjUs6T; arc=none smtp.client-ip=209.85.210.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-6dec4b7b680so3907448a34.3;
        Wed, 24 Jan 2024 22:10:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706163050; x=1706767850; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=juTltaRHemCcavfwicmcF+YQ/ilhPYwdWF3ZG+iZ1DY=;
        b=KxAjUs6T5UUybcx3tioQhBQBDQGQMe4rTknEzvpY1c+4sb3K9fuW0A22Zv+Rx4SUBs
         /8xYM7Y8D86dbo7AxT9PjSzUiIH+P15MK/TnNI+BfzyU9bqzIUYmh88ss9lyABRRsFqi
         WZIW3rO32+bR826YBwehb+Ie8PPqYBeb1Arq6MIwkvDw3Hd2O7awvR3HAwIM3ndaohki
         SeW86PQ1lt+/MELp7kqwLfrh4VqLCl/1L1jwBo0cxVscG8UvMRTxVClCztU8TDnqod7o
         PnUVtchn5P5oStW86gyXEKzGD56TTluWm5YbV/1MEYA1w2GOUi/fp1xDZxNXrSJHpOHN
         q3VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706163050; x=1706767850;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=juTltaRHemCcavfwicmcF+YQ/ilhPYwdWF3ZG+iZ1DY=;
        b=kR8fxKnOdIlLPEW0IGZy40syvrvcVzPARDcSVyFYJ/LmADNpZ4PjRtkkPzgsG8QtGs
         huukLNqnM7hvr3xMqcLVl2cLO0zhtQr14HPyotX9FJXsS+A+0ufDqVxhhzFZJoZ5b4V5
         zV6MM4kedek9KtRfMnCyUbzg4KJ8NkW/GEtE+opWGgFQ47g18L6VAnFWyYaPx+hOZV7d
         Ol2jh/kdjVUDdfuwCkZuLo7eu2KK/N1XaoCkg1aWFwl8mDe5aUijotuj9MvR1C0HD5cn
         JowP4PFVvQvVGmIa1JG/ykSR1XIpS1hRGy0RaYU+D29v7IAdYMEfDqqa5Ljl6D085Dl/
         SX8w==
X-Gm-Message-State: AOJu0YyVo0EptRw4inH5kNbc2U00Z+vKgbBzG4Yk3sBiu/DYxr7XDKpd
	lGG15UPrUKdSI2gx02IUzMXdHn00szB2mkZIsthZdUwoWwzOzR3c
X-Google-Smtp-Source: AGHT+IFxMBvucinN2QYuIClz4b7js+3wJ8BuY7lSJAxEiroFrkt2r6hiCal9FvJIMKTo2f5LgKDKZQ==
X-Received: by 2002:a05:6870:9a1a:b0:210:9791:54f8 with SMTP id fo26-20020a0568709a1a00b00210979154f8mr448914oab.65.1706163050071;
        Wed, 24 Jan 2024 22:10:50 -0800 (PST)
Received: from localhost.localdomain ([122.8.183.87])
        by smtp.gmail.com with ESMTPSA id rb3-20020a056871618300b00214950bb6ecsm1034959oab.15.2024.01.24.22.10.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jan 2024 22:10:49 -0800 (PST)
From: Chen Wang <unicornxw@gmail.com>
To: aou@eecs.berkeley.edu,
	chao.wei@sophgo.com,
	conor@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	palmer@dabbelt.com,
	paul.walmsley@sifive.com,
	p.zabel@pengutronix.de,
	robh+dt@kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	haijiao.liu@sophgo.com,
	xiaoguang.xing@sophgo.com,
	guoren@kernel.org,
	jszhang@kernel.org,
	inochiama@outlook.com
Cc: Chen Wang <unicorn_wang@outlook.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v2 1/4] dt-bindings: reset: sophgo: support SG2042
Date: Thu, 25 Jan 2024 14:10:41 +0800
Message-Id: <0378935b41e9646b63fff282c995412aca41da13.1706161530.git.unicorn_wang@outlook.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1706161530.git.unicorn_wang@outlook.com>
References: <cover.1706161530.git.unicorn_wang@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chen Wang <unicorn_wang@outlook.com>

Add bindings for the reset generator on the SOPHGO SG2042 RISC-V SoC.

Signed-off-by: Chen Wang <unicorn_wang@outlook.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../bindings/reset/sophgo,sg2042-reset.yaml   | 35 ++++++++
 .../dt-bindings/reset/sophgo,sg2042-reset.h   | 87 +++++++++++++++++++
 2 files changed, 122 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/reset/sophgo,sg2042-reset.yaml
 create mode 100644 include/dt-bindings/reset/sophgo,sg2042-reset.h

diff --git a/Documentation/devicetree/bindings/reset/sophgo,sg2042-reset.yaml b/Documentation/devicetree/bindings/reset/sophgo,sg2042-reset.yaml
new file mode 100644
index 000000000000..76e1931f0908
--- /dev/null
+++ b/Documentation/devicetree/bindings/reset/sophgo,sg2042-reset.yaml
@@ -0,0 +1,35 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/reset/sophgo,sg2042-reset.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Sophgo SG2042 SoC Reset Controller
+
+maintainers:
+  - Chen Wang <unicorn_wang@outlook.com>
+
+properties:
+  compatible:
+    const: sophgo,sg2042-reset
+
+  reg:
+    maxItems: 1
+
+  "#reset-cells":
+    const: 1
+
+required:
+  - compatible
+  - reg
+  - "#reset-cells"
+
+additionalProperties: false
+
+examples:
+  - |
+    rstgen: reset-controller@c00 {
+        compatible = "sophgo,sg2042-reset";
+        reg = <0xc00 0xc>;
+        #reset-cells = <1>;
+    };
diff --git a/include/dt-bindings/reset/sophgo,sg2042-reset.h b/include/dt-bindings/reset/sophgo,sg2042-reset.h
new file mode 100644
index 000000000000..9ab0980625c1
--- /dev/null
+++ b/include/dt-bindings/reset/sophgo,sg2042-reset.h
@@ -0,0 +1,87 @@
+/* SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause */
+/*
+ * Copyright (C) 2023 Sophgo Technology Inc. All rights reserved.
+ */
+
+#ifndef __DT_BINDINGS_RESET_SOPHGO_SG2042_H_
+#define __DT_BINDINGS_RESET_SOPHGO_SG2042_H_
+
+#define RST_MAIN_AP			0
+#define RST_RISCV_CPU			1
+#define RST_RISCV_LOW_SPEED_LOGIC	2
+#define RST_RISCV_CMN			3
+#define RST_HSDMA			4
+#define RST_SYSDMA			5
+#define RST_EFUSE0			6
+#define RST_EFUSE1			7
+#define RST_RTC				8
+#define RST_TIMER			9
+#define RST_WDT				10
+#define RST_AHB_ROM0			11
+#define RST_AHB_ROM1			12
+#define RST_I2C0			13
+#define RST_I2C1			14
+#define RST_I2C2			15
+#define RST_I2C3			16
+#define RST_GPIO0			17
+#define RST_GPIO1			18
+#define RST_GPIO2			19
+#define RST_PWM				20
+#define RST_AXI_SRAM0			21
+#define RST_AXI_SRAM1			22
+#define RST_SF0				23
+#define RST_SF1				24
+#define RST_LPC				25
+#define RST_ETH0			26
+#define RST_EMMC			27
+#define RST_SD				28
+#define RST_UART0			29
+#define RST_UART1			30
+#define RST_UART2			31
+#define RST_UART3			32
+#define RST_SPI0			33
+#define RST_SPI1			34
+#define RST_DBG_I2C			35
+#define RST_PCIE0			36
+#define RST_PCIE1			37
+#define RST_DDR0			38
+#define RST_DDR1			39
+#define RST_DDR2			40
+#define RST_DDR3			41
+#define RST_FAU0			42
+#define RST_FAU1			43
+#define RST_FAU2			44
+#define RST_RXU0			45
+#define RST_RXU1			46
+#define RST_RXU2			47
+#define RST_RXU3			48
+#define RST_RXU4			49
+#define RST_RXU5			50
+#define RST_RXU6			51
+#define RST_RXU7			52
+#define RST_RXU8			53
+#define RST_RXU9			54
+#define RST_RXU10			55
+#define RST_RXU11			56
+#define RST_RXU12			57
+#define RST_RXU13			58
+#define RST_RXU14			59
+#define RST_RXU15			60
+#define RST_RXU16			61
+#define RST_RXU17			62
+#define RST_RXU18			63
+#define RST_RXU19			64
+#define RST_RXU20			65
+#define RST_RXU21			66
+#define RST_RXU22			67
+#define RST_RXU23			68
+#define RST_RXU24			69
+#define RST_RXU25			70
+#define RST_RXU26			71
+#define RST_RXU27			72
+#define RST_RXU28			73
+#define RST_RXU29			74
+#define RST_RXU30			75
+#define RST_RXU31			76
+
+#endif /* __DT_BINDINGS_RESET_SOPHGO_SG2042_H_ */
-- 
2.25.1


