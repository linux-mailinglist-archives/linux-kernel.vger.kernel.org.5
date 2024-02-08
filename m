Return-Path: <linux-kernel+bounces-58075-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 58DBF84E0EE
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 13:44:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F2C15282A4D
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 12:44:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA57576C72;
	Thu,  8 Feb 2024 12:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="L4298ZVn"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F02276404
	for <linux-kernel@vger.kernel.org>; Thu,  8 Feb 2024 12:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707396234; cv=none; b=Rg2Df67cVf5jNRM4av5/hBc8nEMakW/3venOfcMrIeQqfZ3nu9UWIO7ZpovGZ9ftC1sHbyry9Z6j+rYEjREJ/yaCSRTheH1l0ByIinMeCg5We79Ff2POYat4HCMb3rYeoWt2f1agTv708Nj7uqTF0Q492tg2ZXYUcHQZPtUU0Mo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707396234; c=relaxed/simple;
	bh=AyaaNH9yUH5TOfV/Vf9mtFGfTApVsa4nreCNtA8vcKI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=r/VYtVHeozg7s8y7XHLSzi6HGrBmkKrPCnZeM8dpNmCgpifmdk/TyCHOUktAMY/u/rOOTXRQTBEpihQhXMFadpIyX1x6cwYd54ZkfueJftj7D3R0+2Bb0h7bIn+Z3P08Gvr0LgbUW0FZgZovQulqMEVYKLDGyRd6dWo+WrpIzDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=L4298ZVn; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-40fe03cd1caso16702005e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 08 Feb 2024 04:43:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1707396229; x=1708001029; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+fOhTxwLR2CTPTSVgD2JffQTM0OmlAEFcQjojvDRSHE=;
        b=L4298ZVn4rNJPetgx86TJYdMUXeOsiDuLAb3OaqGeswyIm8ZXesrHmNNfLNvbbIrCm
         D1HUK82E2UzFjtMEPIjNo3pn5RcmMj57Z34MkLJXndwnn6g2f0olxnC6tW3PTijN2dzO
         +cB620MUXMRdKzZ2YzDHoozYPqABI35VaTWUAA7rXzeawCe9eeKsw+G347F6n0nD7/iO
         pA50z/bw6P68O10n7PCrBiyZ+PokCbFGZnrPFnhtMcodAnTrPk8JdUu46ohRgoGVD6XN
         eT1h5vDGxKKo7xgsgcSzJqgw5XIjbfYdSzZpd6Gl6INgwqR4exCP8yUFrDiPDYapxk60
         fZtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707396229; x=1708001029;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+fOhTxwLR2CTPTSVgD2JffQTM0OmlAEFcQjojvDRSHE=;
        b=qGzA7JR9tIXZhloix2OuEYK7LqVFAZY4Ip1SckHu1hIQxmV3xr9upjlp+CCNge/EL9
         BKZjofTN6PwBrB8YvvJs5yokj2stsGI42GU/HovEcM0QyRZftFtyjfgU16lq4IiXtNBj
         47W86p+apq1m2Bi2ukf4B97wThZ8XSto8xBeCoUeqb4mHRyf8Q40wsDbZU8ltGboS965
         a4P5T1Eb/5vXDl6eCg3HzYSlpari6TgG9wb8CCurrWqxpSvg1879lkDOXDv6LNmiCGWx
         WiYrwaoLReUdMRqwqRpzJwGuitEQTqVphwqV8JPeLx+0+7PLkV7b1ZFYl4a1bCfca95R
         syqQ==
X-Gm-Message-State: AOJu0YwoG+/3DWb2/NxQSafpt3zcakLQLGSy5WFy2qBImR2MfILtfZdd
	+WSeJQMw8TqxPUSRYjZbSRFDLQEUJS04v/TPTU6Z/gripMzGTpIoqwabUt+ZULY=
X-Google-Smtp-Source: AGHT+IGZ/OcDn9XPGfMMCWWCJdAhmDANv8WANS2E3UnxPczVABByOOstT6S9Z6KhZwZJ2T+fQBSfSQ==
X-Received: by 2002:a05:600c:548f:b0:40f:dcfa:49eb with SMTP id iv15-20020a05600c548f00b0040fdcfa49ebmr7243377wmb.38.1707396229587;
        Thu, 08 Feb 2024 04:43:49 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUBGegHiGd58BcX1RZ1tU2XrzC4XJ2uIY56GpOH5CUKNnLUQ32L1rzWwPkYY1gRkvK9QOZlvuLRzSwUwfoOtxf3Yn/CGM5hrvd+/mlPXAWQB+uYAjQJf7GdRedlZS51D8gwnJmiPMyRAvORjBw6l0GaTn2Acb+jKzY9hK9ytAm37t3EkZZJ7huTI+mFTZv8dgfclwL3dnOEfVydrTyDo4ogdUWpaxKujw18RtsDAH7vyReJbGYbGgds+w/e3EZoLFYGD9voFY1qdM3V7736ARiEtIKRWUwBqUvjD8bjXLIOjtBlfPOwVoNXvgszzeIYSfVQnHdDQ8CI48DICoefkYbeJUES2qdexQqIG6+YpeBB2bEIqkU/j2Jb9BErQyE5oxRbXEYa2yjYbJLgtm70UJ3FXn76E64liZPIV0HEs+/W61fZRiCuLS5fvxuEno6bjXAOD+dIyy7wPvcuV53AlXBLAGfAwCFbibz0cHn7o/XRnoJBO+EXNTZmAPNLguOFRmZ+X54ZI4/Svre1rJWyymuxZseki5Z3e7P1w2pOVC6jqRuYyJggIMlUZHmYfO793sc=
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.45])
        by smtp.gmail.com with ESMTPSA id o13-20020a05600c4fcd00b0041047382b76sm790244wmq.37.2024.02.08.04.43.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Feb 2024 04:43:49 -0800 (PST)
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
Subject: [PATCH 03/17] dt-bindings: clock: r9a07g054-cpg: Add power domain IDs
Date: Thu,  8 Feb 2024 14:42:46 +0200
Message-Id: <20240208124300.2740313-4-claudiu.beznea.uj@bp.renesas.com>
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

Add power domain IDs for RZ/V2L (R9A07G054) SoC.

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
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


