Return-Path: <linux-kernel+bounces-138490-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 364BC89F22D
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 14:28:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5712C1C20FBB
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 12:28:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 757C715ECF7;
	Wed, 10 Apr 2024 12:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="bYNfsx1B"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D35AC15E81E
	for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 12:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712752039; cv=none; b=rQ3X5Tt01VYr7Odwq6BLRij62oxjT8s68q/TYZoQAiK6bAwPn6o+Hu2Iu+N741mw0ai0xOIyao7qkBZbIBsfSxu7LzaXjzSGcOHVsMwhpUaFc4mmPWPHy/vZZzdOUizOAmZRrmVZNLyo2wp4A5oY7N5FBN/ZHRqsrlmfZ2VmHs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712752039; c=relaxed/simple;
	bh=/SapMZDbr7we3R/nDfhqB1tO55zkEkfLpHk1lnckIYc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PFEMi9fJnHgCxLpdf8vYkoWEbJWH9II8Xt3blJmfuJzE25+IuuheYCx+/vznLaDw+P9z4YP/7WgcwXvehbHT+43mwwAMTmHChHF8fdzVruzbxj8dCmzfzjn4wqHrcoIYmU+sCuPXMBrIT723ks4ce+3gIutCJnuxXilU8uOASck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=bYNfsx1B; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-416c4767b07so5585585e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 05:27:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1712752036; x=1713356836; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U0RYIWJlebFDDwbIFrq3BSXmJNpUIeTjSZ+W2cRCXOM=;
        b=bYNfsx1BXcUrr8rkhb/+naFzoQNaZtTaVp9WCgttgNYaK1VRfkotX3gFt5TUz55ci0
         cphuwdm+qW5sku4KAXUkmjEuO3DBSh1lEcockinXnYXwmzTM0WDWHeJ38VpYHhfmAk4P
         oSyrLu8WBztuDWg6ssuIUCJn4r31pzKJXjjC8zirUcvEo0kRAg0aeDS8japlCXheLULJ
         aerOsxBvBfHVfHYQ2BqSFmKVbn6m0wsEGbXZnPWi4TgLWhe82erXkCSnFNiFEMSJjVxB
         gZMfssgbVI4glVTWV3b8hVxGxyIU/Q98DJ5uLMMYsWw9xQNEkaXzd2jLE76lVln+QsDQ
         S4bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712752036; x=1713356836;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U0RYIWJlebFDDwbIFrq3BSXmJNpUIeTjSZ+W2cRCXOM=;
        b=B9nLX6Pgl6Tk7DAbQUF3MGa0V6i7K4Ak4kE0TnLfvDP58bVvxOOMCrloupK1Q8uFsr
         wzIw9mdV76Y386oQFaK4GU513GC4LzW6G/Ezpa0YJ4UdOcbBbRStfPkNSnhvXqVktVMs
         Y0Cpy9FCBb3l2TxnrubWRkSEKmwXz0uzC/DKwx6HtF9gX889azzUhts27HdgkzZmLveL
         0vw9KwX5rtdgxeDyAaD1m71dFWbC1LrqWZdLDdeDfc7f/w1TaaAiPqI9VxtKDP21Ntm+
         U5H0/BvcaQBR9mO9Nu7ZLqBPvIvbrKCIYG46gEO3d/ReRgnB2uoR3SF/C8z8g9IDVg2L
         vcCA==
X-Forwarded-Encrypted: i=1; AJvYcCXyx65rR5+R5DW6O5lEFKaSNLkaQGl4/4DLsFMwdMFkFLxy0yNqGvhegfPrdKiKMc/H5tfBGv4Spg6cTwXIgiVq2V8EhXecYI3cz0mP
X-Gm-Message-State: AOJu0Yxu0ZWrlLFnJCVFh2YpdDMJwCch+RdbzlfglrHxrOzpdBQDOHPQ
	NTAR4YveU0AS7+FEFxYJc3tD2bxwvc5ns4IfoqFjApMl0LTldYC+jc9WxdJng0I=
X-Google-Smtp-Source: AGHT+IHT2XZLgfUdbRTbKBeKWXnT/P22mEfSl1llZs6etbBbJQXiOcc7SepbiJe7Ofcyxfio1Su+7w==
X-Received: by 2002:a05:600c:4586:b0:416:731e:4a6b with SMTP id r6-20020a05600c458600b00416731e4a6bmr2162471wmo.29.1712752036171;
        Wed, 10 Apr 2024 05:27:16 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.8])
        by smtp.gmail.com with ESMTPSA id m2-20020a05600c3b0200b004171f151a5csm1679446wms.16.2024.04.10.05.27.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Apr 2024 05:27:15 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: geert+renesas@glider.be,
	mturquette@baylibre.com,
	sboyd@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	magnus.damm@gmail.com
Cc: linux-renesas-soc@vger.kernel.org,
	linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	claudiu.beznea@tuxon.dev,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: [PATCH v3 4/9] dt-bindings: clock: r9a08g045-cpg: Add power domain IDs
Date: Wed, 10 Apr 2024 15:26:52 +0300
Message-Id: <20240410122657.2051132-5-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240410122657.2051132-1-claudiu.beznea.uj@bp.renesas.com>
References: <20240410122657.2051132-1-claudiu.beznea.uj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Add power domain IDs for RZ/G3S (R9A08G045) SoC.

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---

Changes in v3:
- collected tags

Changes in v2:
- collected tag

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


