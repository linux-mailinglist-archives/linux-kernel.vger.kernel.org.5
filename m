Return-Path: <linux-kernel+bounces-58076-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 39C1D84E0F1
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 13:44:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5EF161C23F6C
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 12:44:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89E1077F33;
	Thu,  8 Feb 2024 12:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="Xi79072o"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 255C276908
	for <linux-kernel@vger.kernel.org>; Thu,  8 Feb 2024 12:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707396234; cv=none; b=boBbJxlnePWEpmL7I/x1bwqE6hf33Xyl+Mdfq34qeCuyt0B+kzztNLFloe+9I7zTmP5icnnHAcXaCljIcVo28IFMYUPMw/9A1/ztXkN59GhthkLE83jaUy+eUyZmP/Qt1vRP80rpicPZw2JToZCx8FpbplxMs/HEWIBXqbqZrTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707396234; c=relaxed/simple;
	bh=qp263+cE9JT3Z9tLyfxaY/WORzkVrN44CFTgkqNDGlo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZNYwaIAs1T3CUdBk/v0UfagFp+4lJuBvynoyHN5ECdbxbhW5BcQHQWyIMJ30+Amhwgdmjf8MTjuiV0KnO4s3OB0LVbZzVf0KwSHN+jM0iAuzxDqTN6xYXhrZp9RK+/my6MOSBGWjFyhhvXvX/cMzqodqfDYQjTxcA2Bl/MigvLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=Xi79072o; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-40fd2f7ef55so4954285e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 08 Feb 2024 04:43:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1707396231; x=1708001031; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5ntIc4Xd+YZj5HH2Wt0TNsIkkpEJY2U3yN2SR97JFpk=;
        b=Xi79072oRTzN0ag+Z63UFbgSwDTOLJRRMqGaJkzhN311BHYPfBcZQsiyG4IE+8+fih
         kYjqC1+OYo9Daa/4I23irVxrEUs8D9aH/Fdcka2fly33ZglEUwP2jiS5H6K2rLfeTtY7
         eLydVW6b+I/IZmrLg8zfm/DcehLybxRI9oNS6K6Q7EjJZp12thJoJDcywYzGmeW43wbL
         OThdFxjsG7LPnK9m1ZrWMqc03oxPXyqZDfL0wbK3fEgNZmGRpVeHpNK/f1al/PGA6N5b
         1/jrGOES55fTt1cc+3YM+MmoF+SidoVMykPEQKJ+yYY0ySC51lhF5f9xDAU8HxQXU5r+
         JdeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707396231; x=1708001031;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5ntIc4Xd+YZj5HH2Wt0TNsIkkpEJY2U3yN2SR97JFpk=;
        b=wnAqWqfligWQEm3c2FDuK5kEcojfPqT7vaVu3aVsOQbS2qXczSglJIUhJZLzQUSenW
         T4YdUidhO+nYCalpwSWCM8IKjem00iWvBuAeJfZxzCjZ02g4Gv9e4HPYeJOVnWRtemkn
         0EasmOIzUSO5eQldA9+DHHePl7n1Dd5Nz2Qg95Jbrfx3wx9Q6WYMtdsAUQtmBBA5vN92
         Rz3//vl2lk+8wh0wUpyyVquYmXNd7vfv87XheAz7d3a3LuQRndrLv6U8v0TxqSEjNqXu
         ynLogQ1ZURz4p6PLyf6XM7nLQd+ffXBI4cuxEPZQa2u+SFMZ1A163SyGOeFI3xsGtZvf
         rUGQ==
X-Gm-Message-State: AOJu0YxeUmD+ZWva8sRbwHZXE/P/g6oFeiV9DGYuHA9qMOgUueC29qHY
	IDnwHnJempbAol+8/4YWaUMbOEWAQ5166wM30KSdmTkhGsAQGvgVu/0gXTT6n8I=
X-Google-Smtp-Source: AGHT+IHVs2lCJKy/UUZC1BNBkvIBfeCLLHIO7OTiYKoC1EFECe4p+YbLsSs5xxIM3yw0i3cximWUwA==
X-Received: by 2002:a5d:5392:0:b0:33a:ead3:6438 with SMTP id d18-20020a5d5392000000b0033aead36438mr1921387wrv.33.1707396231405;
        Thu, 08 Feb 2024 04:43:51 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUmFgAW+Skjw1lnmXbQXSf/9hq51jiHJjDAVQk/4K6QzmOq/O9rXIdU/p6mQ301ukgVBqm9o3SqZiK1KTEZS371ZL3D8guYUX1220vQ3lKtetn5ReofmJLqM8ihrVHEhouSo5NuTYAj7t38SFPmAoUEi6yDYC7hiJt0XMBmT+6lRYSy8dB2bKZCcMcd0e4nEGhiuqi82zhv9PJbv40h0N2C+ECiFqdOM5OP+4ha6aqrH44Trrd2RCMpVVre6hcviWQTMbcXaUhhjoN40hIwqfMFbxkWD/J5rfQw4c5bhFAkV0cb1O9Xqh7B1QC3WCjE0Jkrp6qErRskPMFP6uw18A+T1jmp+CzLOWgzUWRN4sKgD0a0fvJ/vyScZAOGAqsqdOGlu0TQC8zDOUfI6QznLcMJ0zchmA6kwKVRexIaqqZyLujTcQkCUTWAkVjraYQiQivt+PjbJcpI1ZK82jFTbdeRBED/3HtxNN1kXdnvthvusegfD9NCOY3o1gQinq6MiztY6j+yw6aygjn4izuKrWfTXUwl3n1zurce98xOwIMlKNH0iQaU893nFZbgkDsu3U8=
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.45])
        by smtp.gmail.com with ESMTPSA id o13-20020a05600c4fcd00b0041047382b76sm790244wmq.37.2024.02.08.04.43.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Feb 2024 04:43:50 -0800 (PST)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: geert+renesas@glider.be,
	mturquette@baylibre.com,
	sboyd@kernel.org,
	robh@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	magnus.damm@gmail.com,
	paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu
Cc: linux-renesas-soc@vger.kernel.org,
	linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	claudiu.beznea@tuxon.dev,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: [PATCH 04/17] dt-bindings: clock: r9a08g045-cpg: Add power domain IDs
Date: Thu,  8 Feb 2024 14:42:47 +0200
Message-Id: <20240208124300.2740313-5-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240208124300.2740313-1-claudiu.beznea.uj@bp.renesas.com>
References: <20240208124300.2740313-1-claudiu.beznea.uj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Add power domain IDs for RZ/G3S (R9A08G045) SoC.

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 include/dt-bindings/clock/r9a08g045-cpg.h | 70 +++++++++++++++++++++++
 1 file changed, 70 insertions(+)

diff --git a/include/dt-bindings/clock/r9a08g045-cpg.h b/include/dt-bindings/clock/r9a08g045-cpg.h
index 410725b778a8..8281e9caf3a9 100644
--- a/include/dt-bindings/clock/r9a08g045-cpg.h
+++ b/include/dt-bindings/clock/r9a08g045-cpg.h
@@ -239,4 +239,74 @@
 #define R9A08G045_I3C_PRESETN		92
 #define R9A08G045_VBAT_BRESETN		93
 
+/* Power domain IDs. */
+#define R9A08G045_PD_ALWAYS_ON		0
+#define R9A08G045_PD_GIC		1
+#define R9A08G045_PD_IA55		2
+#define R9A08G045_PD_MHU		3
+#define R9A08G045_PD_CORESIGHT		4
+#define R9A08G045_PD_SYC		5
+#define R9A08G045_PD_DMAC		6
+#define R9A08G045_PD_GTM0		7
+#define R9A08G045_PD_GTM1		8
+#define R9A08G045_PD_GTM2		9
+#define R9A08G045_PD_GTM3		10
+#define R9A08G045_PD_GTM4		11
+#define R9A08G045_PD_GTM5		12
+#define R9A08G045_PD_GTM6		13
+#define R9A08G045_PD_GTM7		14
+#define R9A08G045_PD_MTU		15
+#define R9A08G045_PD_POE3		16
+#define R9A08G045_PD_GPT		17
+#define R9A08G045_PD_POEGA		18
+#define R9A08G045_PD_POEGB		19
+#define R9A08G045_PD_POEGC		20
+#define R9A08G045_PD_POEGD		21
+#define R9A08G045_PD_WDT0		22
+#define R9A08G045_PD_XSPI		23
+#define R9A08G045_PD_SDHI0		24
+#define R9A08G045_PD_SDHI1		25
+#define R9A08G045_PD_SDHI2		26
+#define R9A08G045_PD_SSI0		27
+#define R9A08G045_PD_SSI1		28
+#define R9A08G045_PD_SSI2		29
+#define R9A08G045_PD_SSI3		30
+#define R9A08G045_PD_SRC		31
+#define R9A08G045_PD_USB0		32
+#define R9A08G045_PD_USB1		33
+#define R9A08G045_PD_USB_PHY		34
+#define R9A08G045_PD_ETHER0		35
+#define R9A08G045_PD_ETHER1		36
+#define R9A08G045_PD_I2C0		37
+#define R9A08G045_PD_I2C1		38
+#define R9A08G045_PD_I2C2		39
+#define R9A08G045_PD_I2C3		40
+#define R9A08G045_PD_SCIF0		41
+#define R9A08G045_PD_SCIF1		42
+#define R9A08G045_PD_SCIF2		43
+#define R9A08G045_PD_SCIF3		44
+#define R9A08G045_PD_SCIF4		45
+#define R9A08G045_PD_SCIF5		46
+#define R9A08G045_PD_SCI0		47
+#define R9A08G045_PD_SCI1		48
+#define R9A08G045_PD_IRDA		49
+#define R9A08G045_PD_RSPI0		50
+#define R9A08G045_PD_RSPI1		51
+#define R9A08G045_PD_RSPI2		52
+#define R9A08G045_PD_RSPI3		53
+#define R9A08G045_PD_RSPI4		54
+#define R9A08G045_PD_CANFD		55
+#define R9A08G045_PD_ADC		56
+#define R9A08G045_PD_TSU		57
+#define R9A08G045_PD_OCTA		58
+#define R9A08G045_PD_PDM		59
+#define R9A08G045_PD_PCI		60
+#define R9A08G045_PD_SPDIF		61
+#define R9A08G045_PD_I3C		62
+#define R9A08G045_PD_VBAT		63
+
+#define R9A08G045_PD_DDR		64
+#define R9A08G045_PD_TZCDDR		65
+#define R9A08G045_PD_OTFDE_DDR		66
+
 #endif /* __DT_BINDINGS_CLOCK_R9A08G045_CPG_H__ */
-- 
2.39.2


