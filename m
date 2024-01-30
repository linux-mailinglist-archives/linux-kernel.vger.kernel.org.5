Return-Path: <linux-kernel+bounces-43766-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6505D8418A8
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 02:50:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 89B021C240AF
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 01:50:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDC2236121;
	Tue, 30 Jan 2024 01:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fd9ca+Sm"
Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 957613611F;
	Tue, 30 Jan 2024 01:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706579401; cv=none; b=k3YCMZfgUbnqoFnMU7Z5i2AZ9NH3GtF+nNreB2nRqkeoYynaClxmm/ASx43n424uZsaDcGqVqOLDkljywU+rT2GgV8a7UI8DsbREAbVmDge02RhdJaY6Pi5tEoHcvNvy3taetLXc4E3U6tgcotRyJ5a6HP81GFm2idTxSRvcuwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706579401; c=relaxed/simple;
	bh=r/19X/dXC1ycEPcHoy86G01yBsusb4I+9Ho0FYXMyEw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Gk40H+41rQ25sx/a2Tinglk9A10GZnagLmGP6artuAPcSgJET9qfqKA0vlHrygD0h8rpI4vJ2RoMizcsx2+yelKXQyX7AVqx8Lx7KMtVn/cO0gIwFTN9jRKcrbStLO0ibmAyZxudonR9q6gH9sJr1T/K7wUS74B7VZbp/xO735o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fd9ca+Sm; arc=none smtp.client-ip=209.85.160.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-214ca209184so1463494fac.1;
        Mon, 29 Jan 2024 17:49:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706579398; x=1707184198; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=juTltaRHemCcavfwicmcF+YQ/ilhPYwdWF3ZG+iZ1DY=;
        b=fd9ca+SmrwUqcbmWxes+/t5Mf0svc1ud+wOhLVH8+aEzNGktALfCslA6df6Z4iMPO6
         vwF70cMYnEWYVqD/bAr0+XIGjHJwA+LbR9KQCjYaRYDE86hGjsdpBhapUklo7lW/ApEE
         bt3nEdOWl6IjeJP3dW2FSSIJ2kr+G0BJZtOQ6VbLRWL2An0JNlRdEuojjp+o4BlIdLWn
         GCyyv8yStZAQfBjIwHJrWASuUtC089Z19Bd/qC30qk2UbdIOThgEpwSH1p85SbV32SD4
         JDwuH6l/qMpLddMcjQm0cN43WrydyDmWch9dQRLi5OMCvAYnaBMKpQNbY0d266yVQRxF
         X0mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706579398; x=1707184198;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=juTltaRHemCcavfwicmcF+YQ/ilhPYwdWF3ZG+iZ1DY=;
        b=dlM05X/W8C3vgfXsa+sVUBOYsed9c0/pEUyDZNxIk7lZLNi36lQb++lC2MCbQswkQQ
         P0I02+1Jles+A3srwMZbEa8fym+j6L5OOpHTTjRRxfqrMwlW924b7hi0O1fWaF7jy+nI
         06qIj3hXOwz8AoHjF0K8K9wKTiVa6TlKjizDrbU72vArubEtsG0ehBLMnLPvUnKDTKVY
         atCcCFkc1g48Z4lWlS4Fj3NuZqZYaOtrVoq3P+2gNH4HCr4BsX1dZOBzPbSPmxGOyn9L
         IpQXzeDDNpoJUjR57zuRHCav8HbjWkeyKS3Tp0CxXJoAg/oc0V9wbaNqyxsSH7BiHwA3
         p28A==
X-Gm-Message-State: AOJu0Yyab5STgvYwnSpUD2tJev+EwhIYYH9tAFocJPoQy6H3kpscEQiA
	gsa8EdsISJdfby8kDB15aRwqqalTEzH5mW3D+yWwNdpyKex30xSQXzOAu/bL7mQ=
X-Google-Smtp-Source: AGHT+IHFwIztoAKmouJ2ISxEyX8d2luZETfQl7oA7Uu2cy1y/m4y5eg882Q8cjHqaLw5+kKYn6Ucvw==
X-Received: by 2002:a05:6870:169d:b0:205:f733:1169 with SMTP id j29-20020a056870169d00b00205f7331169mr8551171oae.56.1706579398465;
        Mon, 29 Jan 2024 17:49:58 -0800 (PST)
Received: from localhost.localdomain ([122.8.183.87])
        by smtp.gmail.com with ESMTPSA id he24-20020a056870799800b002186b9cc12bsm1359044oab.5.2024.01.29.17.49.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jan 2024 17:49:58 -0800 (PST)
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
Subject: [PATCH v3 1/4] dt-bindings: reset: sophgo: support SG2042
Date: Tue, 30 Jan 2024 09:49:45 +0800
Message-Id: <35c348437b6e18972ccaf90d9c38040caccd1f11.1706577450.git.unicorn_wang@outlook.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1706577450.git.unicorn_wang@outlook.com>
References: <cover.1706577450.git.unicorn_wang@outlook.com>
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


