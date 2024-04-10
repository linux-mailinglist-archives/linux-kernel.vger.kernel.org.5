Return-Path: <linux-kernel+bounces-138489-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 48FED89F228
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 14:28:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B4A821F2547E
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 12:28:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A91215E212;
	Wed, 10 Apr 2024 12:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="Uo9K46/Q"
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 787BA15DBA5
	for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 12:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712752038; cv=none; b=JsPOdxXrxr7RMhrjecClYmgP3kngyHfzcYbsYF33hYtT6TmaXcwCgTMjpoqJgUumiIoJ1WTl9dlBHLUHRweByj/X/98ZeME91AMEca+Cq+RDPfvVsICnGNsCFuCM5dE4lKMuxvTC6i8aLXCY9KnByg+GMZS5Wsyz69ZiSB3gd00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712752038; c=relaxed/simple;
	bh=qwUuBzkqmFMkB1G/+OZHzUg/A5xX2xbrDS1cOPJmiKs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=O5h5Fil7s/SP6Zufqwt6NkjheCoYf5BoW6ehOqPFpu/JQoIvVc4BkFIXKECbnTjZF+yEO/4wC9O1iQpOMAgnVZ5m61tn5/YOdOR5aPz54IHR9mGd4mjlIgm9I6ny04QPMAaoq9jvykVcMQ8obCa8gesD7bITaviYeOa5Fm01Qtg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=Uo9K46/Q; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2d48d75ab70so90245951fa.0
        for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 05:27:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1712752035; x=1713356835; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9CQk4ANjkf6oLJlEybK5vT/PONoV44QPRzZiNNLKPBg=;
        b=Uo9K46/QYI4NqetS3wnFs3wMejYzp3uulpUl4rO5aL+gXsdvL7mBd5VOAWiGk8MMl8
         mg1MczAh4+eOdGoXelsVqWMiBN45LEc4PV7NKHjMCTHP5U1qi9cFzjWsgV7CXtJdjobc
         UypJtbzaH5nuOAlz1XTmnDlqK7msrMPX5GObZ5MjSpSuK+283h2Uw/mvXMaAFSbIhadb
         BR3TyZu82AZbiRWZygMln2ZaHzdlKRyppCfF7Z1WH/jGJN2afGGtgpKnYJXO3zmao66I
         B557GZ5y70v+84Pz0aphORL/iJhuxOqZyVjIL1M+9C4eQ/xZPsscrbcCkUXBX0CkErcK
         2qAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712752035; x=1713356835;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9CQk4ANjkf6oLJlEybK5vT/PONoV44QPRzZiNNLKPBg=;
        b=mn3uvdm5oxwnsL+vYLDgHX7L3F8r+X0E9Qrp0qada2bGi8Fv7NqB3uA9p9o+BTyKK5
         UBECfdY+rYF36+lnzn87Eb8hoZnHEarTBu24lrzWjsypfL97h5THow14A86RM0QJX4WI
         X7QULNYLaJcyLLDqbzvr+9raXAltp5/+LIMc+iCCOKmDs4iRY2c3AlRq+WmC9gZndIBe
         la7hQ1FGkVsF8XV88cX1LFYyXk5f5snWqQvCXPHa16rjRceVNrB9KEcU2wHSUsqNn4+0
         uU00vFnKCPF/hmfWvc9K4rQsxaNPlieyUleEd/NyzxB2JuHJL6dMvkpmJLYuxciWfQXe
         8lEw==
X-Forwarded-Encrypted: i=1; AJvYcCVGWLtbPE4Hj4RmWhgky50q3sIgBKZsd6WRvJAAykQ32RgpOQ8pI31xvt0ngPvU3zthQhaLNkJ302LXAnyP/Vq8/i5SslXSDI+2HUQT
X-Gm-Message-State: AOJu0YwlQDbfddw6IeMmmrdtfskdDSUBn0DMqF72R/WF1KjTX6+TeInc
	xWFrolQE2X7maroHeOTdhqu2ZpFqkOa4ia6wbYav9z6EbB6nMGglYPZRQMoJV0w=
X-Google-Smtp-Source: AGHT+IFq4JZpnL7loI4m5HHRMYuldIhrZEXFuMk3nUIdnGcvfPA4mdWQ2OQo0yaitgoxb7bY7KpRPg==
X-Received: by 2002:a05:651c:505:b0:2d8:3fbb:df69 with SMTP id o5-20020a05651c050500b002d83fbbdf69mr2097287ljp.11.1712752034539;
        Wed, 10 Apr 2024 05:27:14 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.8])
        by smtp.gmail.com with ESMTPSA id m2-20020a05600c3b0200b004171f151a5csm1679446wms.16.2024.04.10.05.27.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Apr 2024 05:27:14 -0700 (PDT)
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
Subject: [PATCH v3 3/9] dt-bindings: clock: r9a07g054-cpg: Add power domain IDs
Date: Wed, 10 Apr 2024 15:26:51 +0300
Message-Id: <20240410122657.2051132-4-claudiu.beznea.uj@bp.renesas.com>
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

Add power domain IDs for RZ/V2L (R9A07G054) SoC.

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---

Changes in v3:
- collected tags

Changes in v2:
- collected tag

 include/dt-bindings/clock/r9a07g054-cpg.h | 58 +++++++++++++++++++++++
 1 file changed, 58 insertions(+)

diff --git a/include/dt-bindings/clock/r9a07g054-cpg.h b/include/dt-bindings/clock/r9a07g054-cpg.h
index 43f4dbda872c..2c99f89397c4 100644
--- a/include/dt-bindings/clock/r9a07g054-cpg.h
+++ b/include/dt-bindings/clock/r9a07g054-cpg.h
@@ -226,4 +226,62 @@
 #define R9A07G054_TSU_PRESETN		83
 #define R9A07G054_STPAI_ARESETN		84
 
+/* Power domain IDs. */
+#define R9A07G054_PD_ALWAYS_ON		0
+#define R9A07G054_PD_GIC		1
+#define R9A07G054_PD_IA55		2
+#define R9A07G054_PD_MHU		3
+#define R9A07G054_PD_CORESIGHT		4
+#define R9A07G054_PD_SYC		5
+#define R9A07G054_PD_DMAC		6
+#define R9A07G054_PD_GTM0		7
+#define R9A07G054_PD_GTM1		8
+#define R9A07G054_PD_GTM2		9
+#define R9A07G054_PD_MTU		10
+#define R9A07G054_PD_POE3		11
+#define R9A07G054_PD_GPT		12
+#define R9A07G054_PD_POEGA		13
+#define R9A07G054_PD_POEGB		14
+#define R9A07G054_PD_POEGC		15
+#define R9A07G054_PD_POEGD		16
+#define R9A07G054_PD_WDT0		17
+#define R9A07G054_PD_WDT1		18
+#define R9A07G054_PD_SPI		19
+#define R9A07G054_PD_SDHI0		20
+#define R9A07G054_PD_SDHI1		21
+#define R9A07G054_PD_3DGE		22
+#define R9A07G054_PD_ISU		23
+#define R9A07G054_PD_VCPL4		24
+#define R9A07G054_PD_CRU		25
+#define R9A07G054_PD_MIPI_DSI		26
+#define R9A07G054_PD_LCDC		27
+#define R9A07G054_PD_SSI0		28
+#define R9A07G054_PD_SSI1		29
+#define R9A07G054_PD_SSI2		30
+#define R9A07G054_PD_SSI3		31
+#define R9A07G054_PD_SRC		32
+#define R9A07G054_PD_USB0		33
+#define R9A07G054_PD_USB1		34
+#define R9A07G054_PD_USB_PHY		35
+#define R9A07G054_PD_ETHER0		36
+#define R9A07G054_PD_ETHER1		37
+#define R9A07G054_PD_I2C0		38
+#define R9A07G054_PD_I2C1		39
+#define R9A07G054_PD_I2C2		40
+#define R9A07G054_PD_I2C3		41
+#define R9A07G054_PD_SCIF0		42
+#define R9A07G054_PD_SCIF1		43
+#define R9A07G054_PD_SCIF2		44
+#define R9A07G054_PD_SCIF3		45
+#define R9A07G054_PD_SCIF4		46
+#define R9A07G054_PD_SCI0		47
+#define R9A07G054_PD_SCI1		48
+#define R9A07G054_PD_IRDA		49
+#define R9A07G054_PD_RSPI0		50
+#define R9A07G054_PD_RSPI1		51
+#define R9A07G054_PD_RSPI2		52
+#define R9A07G054_PD_CANFD		53
+#define R9A07G054_PD_ADC		54
+#define R9A07G054_PD_TSU		55
+
 #endif /* __DT_BINDINGS_CLOCK_R9A07G054_CPG_H__ */
-- 
2.39.2


