Return-Path: <linux-kernel+bounces-130555-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 12BF28979E6
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 22:37:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C1F4B284133
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 20:37:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E5A415688E;
	Wed,  3 Apr 2024 20:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cYJx2Y8P"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0C50156664;
	Wed,  3 Apr 2024 20:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712176601; cv=none; b=TOb3P7u21oGvioT63XjZ/H9n5mPsDURvr5GcYuw7hv2E7bc2JHgVDbbj7Dp2DCjA9k6QcFyJAtMQbc6sNGejs4YxXy2BOjSz00xmjsjvPp7yLvvGebMs8rGAUAZQ3dEiTwMrhpb9yDRWRZp9FkeynddWeHRzDrMT2v3KcjxsDB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712176601; c=relaxed/simple;
	bh=bVcrlSpTnIBrGoPS6SXrER2sPZIttxuhKB47nRgtuk4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KOdSUiE9BzhVPJ585+bKqwk8wmQnUkXQBkUKAhmHFfhckD20sge79Bv0SmhYGie0w36fuBgoDRb3En6prtaKrcGLb+GoBt0Yray4ir/kLLa44hYGqFv6cbOONwtEcxY/pUPDu2R+fbvizC9ZxSl/mPz6G4RKkVuziOGEaQa0WE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cYJx2Y8P; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-416290b6631so818445e9.1;
        Wed, 03 Apr 2024 13:36:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712176598; x=1712781398; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p/LXAek9DTip2Fdt/jPhnz1YflAKKdWZVYvtfB/2Zns=;
        b=cYJx2Y8PPJcEa/Yxkp0KjWybSoCfP9g16d0IZqWxKr4QQiXqLqorzyViwuBieePfF+
         u/q79g95+CrueDCqhXqSzaoCRDQizJof4Lm0X9PHQ6fORzbY5ZZgA6gmNwcIecnyHcTN
         TlswFIAOEZ+eHos0UPfkU1rBavTy/eoTqsSsHp+7NIztdFsYYAxOs++4DGEgk7Z8TC85
         4v//08my8ll7LyqEeVppB3TE0clBqsMa2wTpQFWirQJ6zEGFCCoGM1ETRyG04eX9fVEX
         wfW0q3STSP0ED1OaeKVd7//t6Z+kVwMX7uLj/fXO5HAvUtE5+FbcMlIRVes4XeQVv2iT
         fz5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712176598; x=1712781398;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p/LXAek9DTip2Fdt/jPhnz1YflAKKdWZVYvtfB/2Zns=;
        b=sPlqjgSNp3Ehub7vPbXlNJX9OqPdTg3wnbDUhgT6Sx6GsGc2aXVDzJeOBMYboBxT7r
         gRfKlzGsb2LqOenFndL3rA7mbLavGqEH3zmfYjB9BrWnnpNFfPLcZgqLPkta12VkjzXm
         Yh3trnaUBsXL3AeD1fqEdJTMBDXs428IeIQHZs0xZO97yBj9bN5P9y1L5AUnjnVjlThA
         xLpdu6gGA2vokooXUk2meH5K0Tg+ORg82upAkziUrzG8Doji2LZCWBTEwKPy7WG8snph
         sSjjGqT8VALGYs6fkhLgJ1Or9gfLgr0OpvqpDuN4t/rqrOcOnV0xySQqeYVO6IuN0Sj6
         788w==
X-Forwarded-Encrypted: i=1; AJvYcCUOHlWl8LNFPN29uQ14JifVMzw68RrVAuA6lw5lTM2cUiLFu+y2BydMYFKfBlxgkIGh6UaJHS0yDDbpH7TvEvETyqMUMxnS5oVI+TCrxg73BHIgeNeLZFZgrNbOMLc5avvXTPHi+5eiHUdMUnx1
X-Gm-Message-State: AOJu0Yzssfbtf6F/aDz/NTgpXIOnxvaVase4ZKj2XkhRG2yHjSTYzUC5
	TOPsVVGPUH9Bm77nEGSLrjo3UyN/8iv+LO8IdIL0FxWtMbx33Klx
X-Google-Smtp-Source: AGHT+IGyJCnA6zLH2lUVZ2qdR5AHvakpNrLQ0l/p+xtJ4HL1Pvgl52IInn/oXMhJtKGphOIkGjoIVQ==
X-Received: by 2002:a05:600c:d1:b0:414:9072:98dc with SMTP id u17-20020a05600c00d100b00414907298dcmr658973wmm.41.1712176598262;
        Wed, 03 Apr 2024 13:36:38 -0700 (PDT)
Received: from prasmi.home ([2a00:23c8:2500:a01:5eb:3d93:f2b6:25e8])
        by smtp.gmail.com with ESMTPSA id p4-20020a05600c468400b00415f496b9b7sm244910wmo.39.2024.04.03.13.36.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Apr 2024 13:36:37 -0700 (PDT)
From: Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: Geert Uytterhoeven <geert+renesas@glider.be>,
	Thomas Gleixner <tglx@linutronix.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Magnus Damm <magnus.damm@gmail.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>
Cc: linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	Prabhakar <prabhakar.csengg@gmail.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH v2 4/5] arm64: dts: renesas: r9a07g043: Move interrupt-parent property to common DTSI
Date: Wed,  3 Apr 2024 21:35:02 +0100
Message-Id: <20240403203503.634465-5-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240403203503.634465-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20240403203503.634465-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Now that we have added support for IRQC to both RZ/Five and RZ/G2UL SoCs
we can move the interrupt-parent for pinctrl node back to the common
shared r9a07g043.dtsi file.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
v1->v2
- Included RB tag from Geert
---
 arch/arm64/boot/dts/renesas/r9a07g043.dtsi  | 1 +
 arch/arm64/boot/dts/renesas/r9a07g043u.dtsi | 4 ----
 2 files changed, 1 insertion(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/renesas/r9a07g043.dtsi b/arch/arm64/boot/dts/renesas/r9a07g043.dtsi
index 766c54b91acc..6212ee550f33 100644
--- a/arch/arm64/boot/dts/renesas/r9a07g043.dtsi
+++ b/arch/arm64/boot/dts/renesas/r9a07g043.dtsi
@@ -598,6 +598,7 @@ pinctrl: pinctrl@11030000 {
 			gpio-ranges = <&pinctrl 0 0 152>;
 			#interrupt-cells = <2>;
 			interrupt-controller;
+			interrupt-parent = <&irqc>;
 			clocks = <&cpg CPG_MOD R9A07G043_GPIO_HCLK>;
 			power-domains = <&cpg>;
 			resets = <&cpg R9A07G043_GPIO_RSTN>,
diff --git a/arch/arm64/boot/dts/renesas/r9a07g043u.dtsi b/arch/arm64/boot/dts/renesas/r9a07g043u.dtsi
index 964b0a475eee..165bfcfef3bc 100644
--- a/arch/arm64/boot/dts/renesas/r9a07g043u.dtsi
+++ b/arch/arm64/boot/dts/renesas/r9a07g043u.dtsi
@@ -54,10 +54,6 @@ timer {
 	};
 };
 
-&pinctrl {
-	interrupt-parent = <&irqc>;
-};
-
 &soc {
 	interrupt-parent = <&gic>;
 
-- 
2.34.1


