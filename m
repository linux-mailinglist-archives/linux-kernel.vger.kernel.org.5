Return-Path: <linux-kernel+bounces-95698-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BC04875169
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 15:09:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 978161F25F15
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 14:09:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF0FE12F5B1;
	Thu,  7 Mar 2024 14:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="S1vLS2bU"
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D54912EBDD
	for <linux-kernel@vger.kernel.org>; Thu,  7 Mar 2024 14:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709820475; cv=none; b=PblXUiaFJRr7D4ySJqd0eyBTnV/axrMxDM1rCS+JoLX5DLbyaoadMT4BisFlZaSyfPsBstY5DyTRaT4HZvP+z7TuJOhdtMyL/E61+aIvqebjH/vNSm8N1IyHlEmVjGUpe2nkqEL/W0SLFNXzgmelYr0y8226S/SON5W9dJOQlVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709820475; c=relaxed/simple;
	bh=Ye+cH5uXOb/Dt9A9Bu3JbBR7AFS6z5F97MKe51fhY5M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DTlqk9StpoKe4Cf1a35g0c0XXaq381YVEzLwFqOdqjciWax/xkHYlpc6mhh9CObJ1Vtfqj4cmVJQ9FH8GzGxALa8HMsXPKIxWjZ6iAS4jBhNJpYHrjxDmzdoLOhTUqhlrKHYRqIzgEAXgVPXawhbhJeyDw/AxGwXIq61cFbCg44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=S1vLS2bU; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-565c6cf4819so3814697a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 07 Mar 2024 06:07:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1709820471; x=1710425271; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0T6XBGp369ayyJwbVfdwPKp0WqQivhEXG3JCrAStsb4=;
        b=S1vLS2bUame0nyKoA4mUSR/WIQsTnIE78ztBQ54kz/BBHKXuJYp+qhYfXj8f08fFor
         T+pzPv2NBVB2xCLIwL02v9RzvBMqA8mhF3rN5pSh5lURq0j9XAgV6QfkP89DlN0uN1QS
         cUZfDcjhpzzkcvuvn8K9yNA6+aD2+eAH0E5i3X7eOOfPGclhusowf7pPq6d92L5LuFqa
         jVmeYudJaKZTd8IkdeO4tI54cXfORU4hSFRIPICWppT6Ef7dBF4OgKD3AkT/Qkc1bz4Y
         n2XOf9t6/EBmmdYsrtwDBAYDf2lUnST3Di6dQAXjTGKFcrtj3j4b5nvKYoi0sqxFBeKf
         cfUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709820471; x=1710425271;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0T6XBGp369ayyJwbVfdwPKp0WqQivhEXG3JCrAStsb4=;
        b=FlcEIaQIeidT9j+Jj1CMJ049lcwy9NNHr722R9p3pfuGnTYNLUMyaRODGrwMQZpmWe
         iqglbXa288xtrPVLsvhVlsEzFQz0xLHSSj5z/Asc4uaxuWg5alYpvhAG1L6JNbhp5OzE
         lISTdo8fi7T7ukYDhBsl3mswIL+c95VZGWST+YTcfJRYCBev+rhEipaGEZRawDaritgF
         a7aFgDmhCXOQeDfb6pFNt0rBT6dWt6a3eKtAJG6jSEnpMi79oENInpflKT8qIHBixUtZ
         91qzxwBIItDGoXihkXpJDLBpnFoy2YITDwnhZrrBhbklQP9GQ+tYZGhOtH+qlUf9EVN4
         tJKg==
X-Forwarded-Encrypted: i=1; AJvYcCUwE8JElPRTVJJOcUmTNsf3hL7+NK4yizWVHi3WCIxsR4aLn81gPqjBldfktQeh9Phh3vI0pneDO06a74lawY+0vE4QMW4At3k8Wt9X
X-Gm-Message-State: AOJu0YyUAFtzhda32q+vUrFEw1d04PGxvcfmO64T33SDO8O6rKyI/9qJ
	a0KI9w3aShHu2lOcz+vYl50Wg9VfVH2Q2fc8H2J3a+BvMGxCP8ajVNBp4NK9iIo=
X-Google-Smtp-Source: AGHT+IEpfZeoSrSXAmKKGdlnwIJ51aPzO1SJ4sDMLM0zBYZenoph9VCyujtUDGvt0o/GWGYUFOGaqw==
X-Received: by 2002:a17:906:3b46:b0:a45:b506:11ca with SMTP id h6-20020a1709063b4600b00a45b50611camr330686ejf.7.1709820471435;
        Thu, 07 Mar 2024 06:07:51 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.38])
        by smtp.gmail.com with ESMTPSA id v23-20020a1709067d9700b00a42ee62b634sm8200648ejo.106.2024.03.07.06.07.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Mar 2024 06:07:50 -0800 (PST)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: geert+renesas@glider.be,
	mturquette@baylibre.com,
	sboyd@kernel.org,
	robh@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	magnus.damm@gmail.com
Cc: linux-renesas-soc@vger.kernel.org,
	linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	claudiu.beznea@tuxon.dev,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: [PATCH v2 04/10] dt-bindings: clock: r9a08g045-cpg: Add power domain IDs
Date: Thu,  7 Mar 2024 16:07:22 +0200
Message-Id: <20240307140728.190184-5-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240307140728.190184-1-claudiu.beznea.uj@bp.renesas.com>
References: <20240307140728.190184-1-claudiu.beznea.uj@bp.renesas.com>
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
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
---

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


