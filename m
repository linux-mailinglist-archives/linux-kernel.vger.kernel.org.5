Return-Path: <linux-kernel+bounces-22502-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 496AE829EAE
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 17:36:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4409F1C22051
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 16:36:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 992F24D102;
	Wed, 10 Jan 2024 16:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tenstorrent.com header.i=@tenstorrent.com header.b="W5qmbDdr"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F35C24CDEC
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jan 2024 16:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tenstorrent.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tenstorrent.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1d41bb4da91so22758225ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jan 2024 08:35:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tenstorrent.com; s=google; t=1704904558; x=1705509358; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QD1dVdUukFSGWgOm+8YErUh8UR6nSG5y/Y+Z803DKGA=;
        b=W5qmbDdrRYih0qWP2q5RDnizVwfF1Hb4cydyZEA6H54d2Vd0Dl1W/lKHVq/qCOaW27
         s8jr2VuxyIOuvUG129D+f86yF8uZLMJrvAYb7kaScEfIQLx+/PtnsVIFm3CbOnZRXNY9
         f+eTe11NRfkPq22/ohQYRvA6BFNDcX+pETbk6qo4k9S5XDa8gFaNrxY2UvM/Bw7T1Kfm
         MH/u1Wp+ySMVxw227BWd2hK/ekrDlkKoq7hVFzqa5xoUVhh18myaBG5wF+aMhmNBoTjD
         AHnwy3NOfYQOZKATLobRS6ExvjV1+dnUJB/6NnowyPrGWjxcbj4xLodOeQ+tdosrSapM
         bqug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704904558; x=1705509358;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QD1dVdUukFSGWgOm+8YErUh8UR6nSG5y/Y+Z803DKGA=;
        b=Ri5vPV9vf2IC72M5dPZXNxSM2vvjVWrJhbCVFrC9fxist4DNAaP3aaNM7Yn7Ao1FIE
         25ac5J8nDd7cmwz0oWeKuqtlKKGV6jgez1OglRaIeuyeNb/oCVszy7KmMZWcdKhQWhvu
         W6YUQLhE5jTWZqI1eccOagfeniGXP2EpExq2drkRaXkIfFfn8tfxt+sYfXcatdZncVS4
         XVmfw3MrAQPmp1ZuJWPrHG2FFTHw5tstuqYxU+vfVNXo36NHBMxPVwDEIFabuBFEPo3b
         8d2/yE6woE7/q7bX9jmwCsGOO9F+aCZl/G8zyVEG4mBTCsSvssRYrKFAtfmyaQHeux8V
         rIuw==
X-Gm-Message-State: AOJu0YxErXNB0Og2djlqm5BWZELcX2C16rk1aeUK6EU2+2NdOSKz3jJ6
	vLD/CQvyegTN/KT+ZapmFJ0OlQLSAKCnIA==
X-Google-Smtp-Source: AGHT+IGJrbgz90idf6ne3m+6HdkkkJnFmYsOcpLxtQWQ01bboj/iLz1TgTJ7i0nyibr1AtoLTx8lag==
X-Received: by 2002:a17:903:2347:b0:1d4:672f:1f30 with SMTP id c7-20020a170903234700b001d4672f1f30mr1000762plh.78.1704904558271;
        Wed, 10 Jan 2024 08:35:58 -0800 (PST)
Received: from [127.0.1.1] ([2601:1c2:1800:f680:858a:4f95:cb29:907c])
        by smtp.gmail.com with ESMTPSA id p20-20020a170903249400b001d4b5e444d2sm3872265plw.48.2024.01.10.08.35.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jan 2024 08:35:57 -0800 (PST)
From: Drew Fustini <dfustini@tenstorrent.com>
Date: Wed, 10 Jan 2024 08:35:15 -0800
Subject: [PATCH RFC 1/3] dt-bindings: clock: Add T-Head TH1520 AP clock
 definitions
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240110-clk-th1520-v1-1-8b0682567984@tenstorrent.com>
References: <20240110-clk-th1520-v1-0-8b0682567984@tenstorrent.com>
In-Reply-To: <20240110-clk-th1520-v1-0-8b0682567984@tenstorrent.com>
To: Jisheng Zhang <jszhang@kernel.org>, Guo Ren <guoren@kernel.org>, 
 Fu Wei <wefu@redhat.com>, Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Yangtao Li <frank.li@vivo.com>
Cc: linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, 
 linux-clk@vger.kernel.org, devicetree@vger.kernel.org, 
 Emil Renner Berthing <emil.renner.berthing@canonical.com>, 
 Han Gao <gaohan@iscas.ac.cn>, Xi Ruoyao <xry111@xry111.site>, 
 Robert Nelson <robertcnelson@beagleboard.org>, 
 Jason Kridner <jkridner@beagleboard.org>, 
 Drew Fustini <dfustini@tenstorrent.com>, 
 Drew Fustini <dfustini@tenstorrent.org>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1704904555; l=3682;
 i=dfustini@tenstorrent.com; s=20230430; h=from:subject:message-id;
 bh=E//ielryYS+ZFfSnl5vU4Bgc/qxt3Y3UKPop02QmMe0=;
 b=XrvAv/aJBCEJ3XXSMhsaJJUaq9SmldPahW0QtrfRKG9ut/+o2bqXqDv9j8TwCokjQLACA66m/
 Dj+eFtCnHhLAPp6nOcuyFi9OK6IaByhRC8G84zPU2/iuAsjRoaSGhJ0
X-Developer-Key: i=dfustini@tenstorrent.com; a=ed25519;
 pk=p3GKE9XFmjhwAayAHG4U108yag7V8xQVd4zJLdW0g7g=

From: Yangtao Li <frank.li@vivo.com>

Add the clock definitions for T-Head TH1520 AP sub-system.

Link: https://openbeagle.org/beaglev-ahead/beaglev-ahead/-/blob/main/docs/TH1520%20System%20User%20Manual.pdf
Signed-off-by: Yangtao Li <frank.li@vivo.com>
[fixed duplicate number for CLK_NPU and CLK_NPU_AXI]
[revised commit description]
Signed-off-by: Drew Fustini <dfustini@tenstorrent.org>
---
 MAINTAINERS                                  |  1 +
 include/dt-bindings/clock/thead,th1520-clk.h | 96 ++++++++++++++++++++++++++++
 2 files changed, 97 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index bcacd665f259..a52dbf3c5606 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -18857,6 +18857,7 @@ M:	Fu Wei <wefu@redhat.com>
 L:	linux-riscv@lists.infradead.org
 S:	Maintained
 F:	arch/riscv/boot/dts/thead/
+F:	include/dt-bindings/clock/thead,th1520-clk.h
 
 RNBD BLOCK DRIVERS
 M:	Md. Haris Iqbal <haris.iqbal@ionos.com>
diff --git a/include/dt-bindings/clock/thead,th1520-clk.h b/include/dt-bindings/clock/thead,th1520-clk.h
new file mode 100644
index 000000000000..d0d1ab1e672a
--- /dev/null
+++ b/include/dt-bindings/clock/thead,th1520-clk.h
@@ -0,0 +1,96 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
+/*
+ * Copyright (C) 2023 Vivo Communication Technology Co. Ltd.
+ * Authors: Yangtao Li <frank.li@vivo.com>
+ */
+
+#ifndef _DT_BINDINGS_CLK_TH1520_H_
+#define _DT_BINDINGS_CLK_TH1520_H_
+
+#define CLK_CPU_PLL0		0
+#define CLK_CPU_PLL1		1
+#define CLK_GMAC_PLL		2
+#define CLK_VIDEO_PLL		3
+#define CLK_DPU0_PLL		4
+#define CLK_DPU1_PLL		5
+#define CLK_TEE_PLL		6
+#define CLK_C910_I0		7
+#define CLK_C910		8
+#define CLK_BROM		9
+#define CLK_BMU			10
+#define CLK_AHB2_CPUSYS_HCLK	11
+#define CLK_APB3_CPUSYS_PCLK	12
+#define CLK_AXI4_CPUSYS2_ACLK	13
+#define CLK_AON2CPU_A2X		14
+#define CLK_X2X_CPUSYS		15
+#define CLK_AXI_ACLK		16
+#define CLK_CPU2AON_X2H		17
+#define CLK_PERI_AHB_HCLK	18
+#define CLK_CPU2PERI_X2H	19
+#define CLK_PERI_APB_PCLK	20
+#define CLK_PERI2APB_PCLK	21
+#define CLK_PERI_APB1_HCLK	22
+#define CLK_PERI_APB2_HCLK	23
+#define CLK_PERI_APB3_HCLK	24
+#define CLK_PERI_APB4_HCLK	25
+#define CLK_OSC12M		26
+#define CLK_OUT1		27
+#define CLK_OUT2		28
+#define CLK_OUT3		29
+#define CLK_OUT4		30
+#define CLK_APB_PCLK		31
+#define CLK_NPU			32
+#define CLK_NPU_AXI		33
+#define CLK_VI			34
+#define CLK_VI_AHB		35
+#define CLK_VO_AXI		36
+#define CLK_VP_APB		37
+#define CLK_VP_AXI		38
+#define CLK_CPU2VP		39
+#define CLK_VENC		40
+#define CLK_DPU0		41
+#define CLK_DPU1		42
+#define CLK_EMMC_SDIO		43
+#define CLK_GMAC1		44
+#define CLK_PADCTRL1		45
+#define CLK_DSMART		46
+#define CLK_PADCTRL0		47
+#define CLK_GMAC_AXI		48
+#define CLK_GPIO3		49
+#define CLK_GMAC0		50
+#define CLK_PWM			51
+#define CLK_QSPI0		52
+#define CLK_QSPI1		53
+#define CLK_SPI			54
+#define CLK_UART0_PCLK		55
+#define CLK_UART1_PCLK		56
+#define CLK_UART2_PCLK		57
+#define CLK_UART3_PCLK		58
+#define CLK_UART4_PCLK		59
+#define CLK_UART5_PCLK		60
+#define CLK_GPIO0		61
+#define CLK_GPIO1		62
+#define CLK_GPIO2		63
+#define CLK_I2C0		64
+#define CLK_I2C1		65
+#define CLK_I2C2		66
+#define CLK_I2C3		67
+#define CLK_I2C4		68
+#define CLK_I2C5		69
+#define CLK_SPINLOCK		70
+#define CLK_DMA			71
+#define CLK_MBOX0		72
+#define CLK_MBOX1		73
+#define CLK_MBOX2		74
+#define CLK_MBOX3		75
+#define CLK_WDT0		76
+#define CLK_WDT1		77
+#define CLK_TIMER0		78
+#define CLK_TIMER1		79
+#define CLK_SRAM0		80
+#define CLK_SRAM1		81
+#define CLK_SRAM2		82
+#define CLK_SRAM3		83
+#define CLK_PLL_GMAC_100M	84
+#define CLK_UART_SCLK		85
+#endif

-- 
2.34.1


