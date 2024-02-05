Return-Path: <linux-kernel+bounces-52840-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13C90849D4D
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 15:45:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 018201C2325A
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 14:45:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9580C2D048;
	Mon,  5 Feb 2024 14:44:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IWfsv7Bg"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8DFD2C1A4;
	Mon,  5 Feb 2024 14:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707144284; cv=none; b=nGvhDcyVkXXtrTkWRTXQyDNKmdov9NtxMUzSGGKh1x/Q0PtxI+hEdpQtANr0B92S+McRS/l3gUAdjRQVzbDySRAega373PgFdrI6sh8CegDRsf7T3Bqdof2bFEVZfptOu/zix23ZUdCCYvtucqmkvpf6PiLJLv6EZm2LPlJ/WPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707144284; c=relaxed/simple;
	bh=TeHBKvrOL97DsIkR78em+m1YctHPFczJy8uNVVS0UQM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TUld8RMRVn3YQvglHAsWMVoshFFUQjond/jySp+fZyhPId7a2axhHPGuhEVH7f3y0QCHM6UfNhMXmPPMOvr6x4/Z0BVoIutOUfQn0wacf2rpkD1yVOsu0DMLmsqhXXA++vYRpF5LU67PvPrlHOLHCZWf92RGQn47Q8j1rWkxwog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IWfsv7Bg; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-40ef64d8955so41138585e9.3;
        Mon, 05 Feb 2024 06:44:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707144281; x=1707749081; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v7fBQGIt+/unvEwTJnibDluFSJZOyorUxBAWdUVB2dk=;
        b=IWfsv7BgdrQz7b24N+1j9h4WmOEoARTlUic1XfEmFpnT9jusJPOdz77A5y5EPa7Ivq
         yhGQKQ86jHoYq/6yWeJMNbS1DBchrHYNvx22+4U7if98CWLpdfAzWKEIhCe/xZ9erQnH
         D5xajuJyNoQv/m2rePZhN4S++h489nLoSnPBOdoKZDYwCZhaWlUyMByaXk+UwO0qRhL2
         7X+lt1scS9qqLdCgOlgh/nWAyJPhk5bcyUUaW0aPKfyqQkEGjkWrg2WdXRyuK8teMh+T
         4vnyruNHDs1+dvB8FVM/GSMjr5LSIwTq5pjIjZ8a6nbscjLsJzuVmtvf6XquC+DKK8I9
         OwqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707144281; x=1707749081;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v7fBQGIt+/unvEwTJnibDluFSJZOyorUxBAWdUVB2dk=;
        b=MrecCK/hs3vk4HgEot3NAycPOGd8ulg/rlSRggsQbWscvigxSJs51pPoLF1ARcYIgo
         G/xiff935RxNql5cRnvuA3ZY3tvTAeSrYqbtmilDtMqdBRHiNwUsQMr+0Q1mbs3ZUqfd
         WiUa3s7ZYHdxDkbBAEMfmS29FkIzSPYujIHotmcYH6/gpKSSfAk4OOuWl1LRXR/Dv7ts
         yLnUS3TIICH0V2jBMPreZAcOv43J6X6f4/aAGnT4j1ztyrr81yvzkTZUA/mM3ssokFGx
         iAyDp7X8AnwOswqtfgtpq/oiucE/BdqJDRzgqB71eY4qbiP7wMV6CRGy6lRhMaTutYMF
         7PyA==
X-Gm-Message-State: AOJu0YyTPZF5zQP962d2Zag8UKF4Pkf39/yPbFksN3kn9IKPoctW9eAE
	gvlS6RCgeSTepGhsMT679aHRtlHHBZgA3DyIASHw6K9WCUP+yWhq
X-Google-Smtp-Source: AGHT+IFOjqFuBGisPvWGeOQCrN+gq/WTQNLJg5YXYd1jVbMSF+SLYYmidODwxp5cOT928fGfCT2AzA==
X-Received: by 2002:a05:600c:3594:b0:40e:a569:3555 with SMTP id p20-20020a05600c359400b0040ea5693555mr5023367wmq.35.1707144281088;
        Mon, 05 Feb 2024 06:44:41 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCVhf0PQ529CC9EyIRAGqYlHQYP19Rmsobr0Gy7p23cYllMhaQb9HT3BVMmFANwdDs8aEQKIU68WRhjtAk2wGsIAjDx2s3WF9b0PTIUfbT7nLTtV5Pzt4YhXNcRxu0lRRhkm5V0iy26wqavjRv7xnCZiVMqRuIvHcyjsKzgswhxfvbGBbYNeFdM67DSmv9/VXUHCNEbt8Y5g0hY2NHwGKop7jscPlEse9kmqfb7OOucThN9ygQSXPWKlQNbUEY2ale7F8Vdhb5+/ECLlSYX6Z8oLiG7RRKsMMqAEQm1BDQidsGj9fRdx/zG+ykJcoHfMdmevJspYPK80FykLF/xptNHA1X7o4naS4pIJnAGE5zdfU9SIohbqgn+I4AnTJkelr1GFYQte47iXb25T0P4Dmz+VkfLRajyKO4aAI9/waqoZXEFqJa7VtSDe4G0iWDwHcbvHJuXrQKAj9AnrBOpgGjoalGmbut8Bekj4hf1UYFM=
Received: from prasmi.home ([2a00:23c8:2500:a01:8f3c:6ff8:96c9:c9f0])
        by smtp.gmail.com with ESMTPSA id u7-20020a05600c19c700b0040fdf2832desm70272wmq.12.2024.02.05.06.44.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Feb 2024 06:44:39 -0800 (PST)
From: Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: Thomas Gleixner <tglx@linutronix.de>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>
Cc: devicetree@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Prabhakar <prabhakar.csengg@gmail.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH v2 2/3] arm64: dts: renesas: rz-g2l-family: Add missing interrupts from IRQC IP block
Date: Mon,  5 Feb 2024 14:44:20 +0000
Message-Id: <20240205144421.51195-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240205144421.51195-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20240205144421.51195-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

The IRQC IP block supports Bus error and ECCRAM interrupts for RZ/G2L and
alike SoC's (listed below). Update the IRQC node with the missing
interrupts, and additionally, include the 'interrupt-names' property in
the IRQC node so that driver can parse the interrupts based on the name.

- R9A07G043U              - RZ/G2UL
- R9A07G044L/R9A07G044LC  - RZ/{G2L,G2LC}
- R9A07G054               - RZ/V2L

Fixes: 5edc51af5b30 ("arm64: dts: renesas: r9a07g044: Add IRQC node")
Fixes: 48ab6eddd8bb ("arm64: dts: renesas: r9a07g043u: Add IRQC node")
Fixes: 379478ab09e0 ("arm64: dts: renesas: r9a07g054: Add IRQC node")
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 arch/arm64/boot/dts/renesas/r9a07g043u.dtsi | 12 +++++++++--
 arch/arm64/boot/dts/renesas/r9a07g044.dtsi  | 22 ++++++++++++++++++++-
 arch/arm64/boot/dts/renesas/r9a07g054.dtsi  | 22 ++++++++++++++++++++-
 3 files changed, 52 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/renesas/r9a07g043u.dtsi b/arch/arm64/boot/dts/renesas/r9a07g043u.dtsi
index 01d08ebb4a78..964b0a475eee 100644
--- a/arch/arm64/boot/dts/renesas/r9a07g043u.dtsi
+++ b/arch/arm64/boot/dts/renesas/r9a07g043u.dtsi
@@ -178,7 +178,13 @@ irqc: interrupt-controller@110a0000 {
 			     <SOC_PERIPHERAL_IRQ(473) IRQ_TYPE_LEVEL_HIGH>,
 			     <SOC_PERIPHERAL_IRQ(474) IRQ_TYPE_LEVEL_HIGH>,
 			     <SOC_PERIPHERAL_IRQ(475) IRQ_TYPE_LEVEL_HIGH>,
-			     <SOC_PERIPHERAL_IRQ(25) IRQ_TYPE_EDGE_RISING>;
+			     <SOC_PERIPHERAL_IRQ(25) IRQ_TYPE_EDGE_RISING>,
+			     <SOC_PERIPHERAL_IRQ(34) IRQ_TYPE_EDGE_RISING>,
+			     <SOC_PERIPHERAL_IRQ(35) IRQ_TYPE_EDGE_RISING>,
+			     <SOC_PERIPHERAL_IRQ(36) IRQ_TYPE_EDGE_RISING>,
+			     <SOC_PERIPHERAL_IRQ(37) IRQ_TYPE_EDGE_RISING>,
+			     <SOC_PERIPHERAL_IRQ(38) IRQ_TYPE_EDGE_RISING>,
+			     <SOC_PERIPHERAL_IRQ(39) IRQ_TYPE_EDGE_RISING>;
 		interrupt-names = "nmi",
 				  "irq0", "irq1", "irq2", "irq3",
 				  "irq4", "irq5", "irq6", "irq7",
@@ -190,7 +196,9 @@ irqc: interrupt-controller@110a0000 {
 				  "tint20", "tint21", "tint22", "tint23",
 				  "tint24", "tint25", "tint26", "tint27",
 				  "tint28", "tint29", "tint30", "tint31",
-				  "bus-err";
+				  "bus-err", "ec7tie1-0", "ec7tie2-0",
+				  "ec7tiovf-0", "ec7tie1-1", "ec7tie2-1",
+				  "ec7tiovf-1";
 		clocks = <&cpg CPG_MOD R9A07G043_IA55_CLK>,
 			<&cpg CPG_MOD R9A07G043_IA55_PCLK>;
 		clock-names = "clk", "pclk";
diff --git a/arch/arm64/boot/dts/renesas/r9a07g044.dtsi b/arch/arm64/boot/dts/renesas/r9a07g044.dtsi
index 66f68fc2b241..081d8f49db87 100644
--- a/arch/arm64/boot/dts/renesas/r9a07g044.dtsi
+++ b/arch/arm64/boot/dts/renesas/r9a07g044.dtsi
@@ -905,7 +905,27 @@ irqc: interrupt-controller@110a0000 {
 				     <GIC_SPI 472 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 473 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 474 IRQ_TYPE_LEVEL_HIGH>,
-				     <GIC_SPI 475 IRQ_TYPE_LEVEL_HIGH>;
+				     <GIC_SPI 475 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 25 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 34 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 35 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 36 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 37 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 38 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 39 IRQ_TYPE_EDGE_RISING>;
+			interrupt-names = "nmi", "irq0", "irq1", "irq2", "irq3",
+					  "irq4", "irq5", "irq6", "irq7",
+					  "tint0", "tint1", "tint2", "tint3",
+					  "tint4", "tint5", "tint6", "tint7",
+					  "tint8", "tint9", "tint10", "tint11",
+					  "tint12", "tint13", "tint14", "tint15",
+					  "tint16", "tint17", "tint18", "tint19",
+					  "tint20", "tint21", "tint22", "tint23",
+					  "tint24", "tint25", "tint26", "tint27",
+					  "tint28", "tint29", "tint30", "tint31",
+					  "bus-err", "ec7tie1-0", "ec7tie2-0",
+					  "ec7tiovf-0", "ec7tie1-1", "ec7tie2-1",
+					  "ec7tiovf-1";
 			clocks = <&cpg CPG_MOD R9A07G044_IA55_CLK>,
 				 <&cpg CPG_MOD R9A07G044_IA55_PCLK>;
 			clock-names = "clk", "pclk";
diff --git a/arch/arm64/boot/dts/renesas/r9a07g054.dtsi b/arch/arm64/boot/dts/renesas/r9a07g054.dtsi
index 1f1d481dc783..0d327464d2ba 100644
--- a/arch/arm64/boot/dts/renesas/r9a07g054.dtsi
+++ b/arch/arm64/boot/dts/renesas/r9a07g054.dtsi
@@ -912,7 +912,27 @@ irqc: interrupt-controller@110a0000 {
 				     <GIC_SPI 472 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 473 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 474 IRQ_TYPE_LEVEL_HIGH>,
-				     <GIC_SPI 475 IRQ_TYPE_LEVEL_HIGH>;
+				     <GIC_SPI 475 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 25 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 34 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 35 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 36 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 37 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 38 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 39 IRQ_TYPE_EDGE_RISING>;
+			interrupt-names = "nmi", "irq0", "irq1", "irq2", "irq3",
+					  "irq4", "irq5", "irq6", "irq7",
+					  "tint0", "tint1", "tint2", "tint3",
+					  "tint4", "tint5", "tint6", "tint7",
+					  "tint8", "tint9", "tint10", "tint11",
+					  "tint12", "tint13", "tint14", "tint15",
+					  "tint16", "tint17", "tint18", "tint19",
+					  "tint20", "tint21", "tint22", "tint23",
+					  "tint24", "tint25", "tint26", "tint27",
+					  "tint28", "tint29", "tint30", "tint31",
+					  "bus-err", "ec7tie1-0", "ec7tie2-0",
+					  "ec7tiovf-0", "ec7tie1-1", "ec7tie2-1",
+					  "ec7tiovf-1";
 			clocks = <&cpg CPG_MOD R9A07G054_IA55_CLK>,
 				 <&cpg CPG_MOD R9A07G054_IA55_PCLK>;
 			clock-names = "clk", "pclk";
-- 
2.34.1


