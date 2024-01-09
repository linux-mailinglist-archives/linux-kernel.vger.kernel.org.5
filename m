Return-Path: <linux-kernel+bounces-20640-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED83E8282D1
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 10:16:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1B1661C23D5A
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 09:16:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE2292E634;
	Tue,  9 Jan 2024 09:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cE+b6yVT"
Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87566328DA;
	Tue,  9 Jan 2024 09:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-6dd8cba736aso1845569a34.3;
        Tue, 09 Jan 2024 01:16:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704791810; x=1705396610; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uPNFZBbuaAO34pis2FOL3RIG+0DI0ThEyhDzqc1WUV0=;
        b=cE+b6yVTf4gbjnTCQMhVtRRjeqYhUC6ZJq/3O6HfUK+xoXwOshREHavc0Eb/cWIG+u
         GPd4p9n3QewTzdSg3wT3tVGARzJu7+XL+m+yAC/g7DHFzfNVeVHo9G6sMZcqe930mQsu
         R8UAaFuYyU61cpzwUFgCEaOffxBBkK0gzm2ZpDwJ/RyjDJH4lOpZPSJqQH1TPqRa4QcZ
         2Wv1B5LbN/TycrkaPf/sYZ5spz1qiqK/iqM+PBTrosxV83xA17o22yptllcSc/MapAcH
         kEwN7hxhlNztxWxsFSwsthm7MkuWavCgyQ/4NYbUsvAaSpcXkSgYcfHoEjE7bJRd6EkX
         RaIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704791810; x=1705396610;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uPNFZBbuaAO34pis2FOL3RIG+0DI0ThEyhDzqc1WUV0=;
        b=o6DwNrJUhIRTRm1BTPsklEbtbBvwyfUpXNMeAnyKSyKCZo51HTS3tIVp8I3OjxDfRL
         RQeJ5Xe1AwQn9nLo+97o+8RKX6d+asSJPZ3RWJJ/Gc8QMUYAH3/sBAe6Asu+pfP07f6G
         XKUIaNrV42wWCdfE1uDTZvwjSErJpukvvKc9ZT65bGxA+trA5b9FTlgypQfYTLj+N7An
         mBoTDcgbtQCglVk3FI4zf7Ee9AIDiudaH+Aes+utajKW7dBQ1BO4d2lCA74vJkSoDBcb
         kFv1t+YGs4gaFhKqIMoi0/xDy/5G+A3E5cOcKOqgO+9ivMElSknvLsycRFeabxxEPjxA
         oKVA==
X-Gm-Message-State: AOJu0Yydxv3DiaHJ//2JHiiT+NxpXXe0PHOSInSQmDZ7rGXYBfYPYy3l
	8aculgvWiDpCPboZa2CR8cE=
X-Google-Smtp-Source: AGHT+IESyX+yTTHmw6YPFuuFRd1KpXg//Na1hXFVDNcY7i0q5xVWxUMT5xawbpLyASDSNp3Jsn4piw==
X-Received: by 2002:a05:6870:d886:b0:203:cac5:f217 with SMTP id oe6-20020a056870d88600b00203cac5f217mr6512941oac.109.1704791810405;
        Tue, 09 Jan 2024 01:16:50 -0800 (PST)
Received: from localhost.localdomain ([122.8.183.87])
        by smtp.gmail.com with ESMTPSA id dy51-20020a056870c7b300b00205eed77439sm390194oab.40.2024.01.09.01.16.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jan 2024 01:16:50 -0800 (PST)
From: Chen Wang <unicornxw@gmail.com>
To: aou@eecs.berkeley.edu,
	chao.wei@sophgo.com,
	conor@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	palmer@dabbelt.com,
	paul.walmsley@sifive.com,
	robh+dt@kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	haijiao.liu@sophgo.com,
	xiaoguang.xing@sophgo.com,
	guoren@kernel.org,
	jszhang@kernel.org,
	inochiama@outlook.com
Cc: Chen Wang <unicorn_wang@outlook.com>
Subject: [PATCH 1/4] dt-bindings: reset: sophgo: support SG2042
Date: Tue,  9 Jan 2024 17:16:41 +0800
Message-Id: <9798e2ea0c4e339717cc5c411e0db0188befdc58.1704790558.git.unicorn_wang@outlook.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1704790558.git.unicorn_wang@outlook.com>
References: <cover.1704790558.git.unicorn_wang@outlook.com>
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
---
 .../bindings/reset/sophgo,sg2042-reset.yaml   | 35 ++++++++
 .../dt-bindings/reset/sophgo,sg2042-reset.h   | 88 +++++++++++++++++++
 2 files changed, 123 insertions(+)
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
index 000000000000..750197e2c2ed
--- /dev/null
+++ b/include/dt-bindings/reset/sophgo,sg2042-reset.h
@@ -0,0 +1,88 @@
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
+
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


