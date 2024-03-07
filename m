Return-Path: <linux-kernel+bounces-95695-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B06D87515D
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 15:08:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E719AB284F9
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 14:08:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8E0112EBF5;
	Thu,  7 Mar 2024 14:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="o4GPTDTa"
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F4FD12E1F1
	for <linux-kernel@vger.kernel.org>; Thu,  7 Mar 2024 14:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709820471; cv=none; b=SpRKVHQic13akkeofGY6h5JDtjbdo6GbKLHJmf9DxzIuCn6serIfYrwT4DYWGyBQX05XCf8asx4VZNQF55CER1rgH5pGbJXR4wo036vINS49uPvmNywU/ECOlVUWYY/PMQIKxjnyVTcgbqZ+m0PSEenbhfgBsu2doXQjUrFEiNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709820471; c=relaxed/simple;
	bh=o+isOLC/TWDf8QBrYF6fFqPfwMGPbt0wSxpYHU+dD5U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rh0nyDTuaSsSQ7Aio0cPCq+1cVs8VbxZSjw3Mb3HWJVcOlGnk3m9fE+XCtiwqQY+Eq71uoVdctaic9Dy/3PRYKZxsn2FCRkNmGvundDqGcnswtqYtNAzlIZli12pHuju+sIokgCnc22kfgRxF887d3JGPRpIR573SQhY0TPuQBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=o4GPTDTa; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-51344bebe2fso857273e87.2
        for <linux-kernel@vger.kernel.org>; Thu, 07 Mar 2024 06:07:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1709820467; x=1710425267; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MfoIgw8Unv2o4Ref3vnexmJsmRhKE911tIs07l/4sdo=;
        b=o4GPTDTaF1bqNc+dkKdV3IclpqmgzvUNnQQrp/0abpnpmdkbAMl5UenRMEinSsdtkJ
         YwSsN+MShVCNJkNyPAdtzZaccCkFHFEE/0ag6SxctCg7BMtRVADw885S05nzepo9mN0U
         BNfYl8xzG+FqnmCUQCYEsIu60/mQSMf4P0Yu17Wq0akhb4p6ezcni3Jf0YvtMGLj3lY3
         XWVIjrlY7q9klJQg5VioDrBE/Ndil+fE29fmM+dI4/0tFMuEw5mXZUmscyiYFS0OBjHV
         H0vtQcL6FVE0XYIzqNFSzhZ3FlQxunmY05Wy1SmAVNi+yWZwduFiyzDcHqtEjpHZsddi
         IQpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709820467; x=1710425267;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MfoIgw8Unv2o4Ref3vnexmJsmRhKE911tIs07l/4sdo=;
        b=gyZyQaXmIhJEoPpO2I6AEvGoOry/Smzb4Yt49z0NjYMo79yofJNWGn+s8hlDIPoRbX
         p5dX3/iR2SaRLANIt71wlpE1NpSsiKXsqkntsVoRs4qRoOxJjzVFzf2H502ToNNr3A8S
         ho32G5A1cUbKB0tylxlKcbRb8ZFBrW4KXJELymxtRlKBPuGKACiJk3huzGLNDHX2Z0Ih
         lHw06XfyAY0ljq7FcKtGB+qO8XrspjYOUSlld5VjUPzWEVIdMwBSM3ujaED9FP2kof2E
         Fga+u+Z25vRUoZW9ydMcc1CZeh1pChELokJ2P+y01+TuRA29l1ovjTyvxIEH8CWQ/rO8
         a2Hw==
X-Forwarded-Encrypted: i=1; AJvYcCUhGbb87+ZVm/m6Xr/6RpeXcK9g5dPT5RZ3TnOWHazGlK05sybGv6Z0wU1JeHqsllBzxza2SpL4vsEdqN8Jsvgd0U46TgtQ3J+8i+nR
X-Gm-Message-State: AOJu0YzFnTELpllA/PhftQC8JCro+/csVVqGX1O0Y/OTGroxx8//fo8m
	SyJa2H5X0PnIzgF1hgxPfSxdrfLVA83M+rkTRR6HP9pLFpNEcj2cL15SbhmxcK4=
X-Google-Smtp-Source: AGHT+IFnmZHrky58RFBMdeu65Vl/I30y/4ADskPAIE5LOhPBlg6oJCaN2YulY/RMs1cYItpqq2bOeQ==
X-Received: by 2002:a05:6512:20c9:b0:513:ece:1fe1 with SMTP id u9-20020a05651220c900b005130ece1fe1mr1339326lfr.54.1709820466719;
        Thu, 07 Mar 2024 06:07:46 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.38])
        by smtp.gmail.com with ESMTPSA id v23-20020a1709067d9700b00a42ee62b634sm8200648ejo.106.2024.03.07.06.07.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Mar 2024 06:07:46 -0800 (PST)
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
Subject: [PATCH v2 01/10] dt-bindings: clock: r9a07g043-cpg: Add power domain IDs
Date: Thu,  7 Mar 2024 16:07:19 +0200
Message-Id: <20240307140728.190184-2-claudiu.beznea.uj@bp.renesas.com>
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

Add power domain IDs for RZ/G2UL (R9A07G043) SoC.

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---

Changes in v2:
- added "RZ/G2UL Only" comments to some defines
- added RZ/Five specific defines

 include/dt-bindings/clock/r9a07g043-cpg.h | 52 +++++++++++++++++++++++
 1 file changed, 52 insertions(+)

diff --git a/include/dt-bindings/clock/r9a07g043-cpg.h b/include/dt-bindings/clock/r9a07g043-cpg.h
index 77cde8effdc7..ba9ea276c4a0 100644
--- a/include/dt-bindings/clock/r9a07g043-cpg.h
+++ b/include/dt-bindings/clock/r9a07g043-cpg.h
@@ -200,5 +200,57 @@
 #define R9A07G043_AX45MP_CORE0_RESETN	78	/* RZ/Five Only */
 #define R9A07G043_IAX45_RESETN		79	/* RZ/Five Only */
 
+/* Power domain IDs. */
+#define R9A07G043_PD_ALWAYS_ON		0
+#define R9A07G043_PD_GIC		1	/* RZ/G2UL Only */
+#define R9A07G043_PD_IA55		2	/* RZ/G2UL Only */
+#define R9A07G043_PD_MHU		3	/* RZ/G2UL Only */
+#define R9A07G043_PD_CORESIGHT		4	/* RZ/G2UL Only */
+#define R9A07G043_PD_SYC		5	/* RZ/G2UL Only */
+#define R9A07G043_PD_DMAC		6
+#define R9A07G043_PD_GTM0		7
+#define R9A07G043_PD_GTM1		8
+#define R9A07G043_PD_GTM2		9
+#define R9A07G043_PD_MTU		10
+#define R9A07G043_PD_POE3		11
+#define R9A07G043_PD_WDT0		12
+#define R9A07G043_PD_SPI		13
+#define R9A07G043_PD_SDHI0		14
+#define R9A07G043_PD_SDHI1		15
+#define R9A07G043_PD_ISU		16	/* RZ/G2UL Only */
+#define R9A07G043_PD_CRU		17	/* RZ/G2UL Only */
+#define R9A07G043_PD_LCDC		18	/* RZ/G2UL Only */
+#define R9A07G043_PD_SSI0		19
+#define R9A07G043_PD_SSI1		20
+#define R9A07G043_PD_SSI2		21
+#define R9A07G043_PD_SSI3		22
+#define R9A07G043_PD_SRC		23
+#define R9A07G043_PD_USB0		24
+#define R9A07G043_PD_USB1		25
+#define R9A07G043_PD_USB_PHY		26
+#define R9A07G043_PD_ETHER0		27
+#define R9A07G043_PD_ETHER1		28
+#define R9A07G043_PD_I2C0		29
+#define R9A07G043_PD_I2C1		30
+#define R9A07G043_PD_I2C2		31
+#define R9A07G043_PD_I2C3		32
+#define R9A07G043_PD_SCIF0		33
+#define R9A07G043_PD_SCIF1		34
+#define R9A07G043_PD_SCIF2		35
+#define R9A07G043_PD_SCIF3		36
+#define R9A07G043_PD_SCIF4		37
+#define R9A07G043_PD_SCI0		38
+#define R9A07G043_PD_SCI1		39
+#define R9A07G043_PD_IRDA		40
+#define R9A07G043_PD_RSPI0		41
+#define R9A07G043_PD_RSPI1		42
+#define R9A07G043_PD_RSPI2		43
+#define R9A07G043_PD_CANFD		44
+#define R9A07G043_PD_ADC		45
+#define R9A07G043_PD_TSU		46
+#define R9A07G043_PD_PLIC		47	/* RZ/Five Only */
+#define R9A07G043_PD_IAX45		48	/* RZ/Five Only */
+#define R9A07G043_PD_NCEPLDM		49	/* RZ/Five Only */
+#define R9A07G043_PD_NCEPLMT		50	/* RZ/Five Only */
 
 #endif /* __DT_BINDINGS_CLOCK_R9A07G043_CPG_H__ */
-- 
2.39.2


