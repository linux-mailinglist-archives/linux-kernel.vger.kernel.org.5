Return-Path: <linux-kernel+bounces-52841-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DFD35849D50
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 15:45:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 73E451F23A91
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 14:45:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A59732D634;
	Mon,  5 Feb 2024 14:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XH4F4/rI"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30D0F2C85C;
	Mon,  5 Feb 2024 14:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707144285; cv=none; b=pNUlM4rOz+P5729iNVRpYrvUeS7dRPuY/f8ANQkKyl2QG7QFt/2JjPzU0Tyi40tW60hntqoBWjQsBZbw60FCJmLjcW4he81MpxNbxitmXsug42QrjB64PcPCssQJL1cPRa0rUGfxhIiMkSidmEZvWaClQL09J4XQ2HwgNgfy5Dk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707144285; c=relaxed/simple;
	bh=HVNxTNXFH81elhnlHFFoiXRlJRy+wLKmBxr2sIFd+iQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=C/wdeLWBsc5q80oXDeiDML+9oS6fkXG9RUn0WAxCgZ1RDYbic7nUREpenIVBBczdENSbiNLvOJvwZmuAPfZdb1hLmATsOvOQln2WlmygS6IfV7cW5dPXAWKYLNJ+iYMsZ9BPKSSr/lxxvkJs2FaCifGxcSywovtXxD5mSCAxEPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XH4F4/rI; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-40fdc63f4feso6914545e9.3;
        Mon, 05 Feb 2024 06:44:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707144282; x=1707749082; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YOISnKqQCDRm9DMf4rv94ANqERw2XArPKxXWyi/bpyk=;
        b=XH4F4/rIrSTqTHhJoJgnZjQnrlErKfgFLE4FC9HZK4YDx1MwmP4ETgallHewG0aLxS
         oTXQlar8T1b5LKPiMeVdUChaGIywW5rYFsU+1E+Scx3k0NBF3QIAQxQ0zxygb6Lz5b8M
         v4E1MPVCzYvtQ0auLR3QNJY/d7rbPAqdUDvLDiX4Dg8h9IrLkuMnYBRu24WYbrC2aUbH
         7cIgBygyA+jkGCQZCiVSpIvaUx7bu/lqs0rytzNCt67arzmqut3s242um8w/upKWYMfr
         /a2iT+A5vZ/uz3ifFKan+nEijylhGcHTzS2W06eLoq/xuXW6KPwMoXa+PpNh/mE/wXRR
         7iQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707144282; x=1707749082;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YOISnKqQCDRm9DMf4rv94ANqERw2XArPKxXWyi/bpyk=;
        b=vqcvbXqsxI6CrdBi929/mONdSA0IGHc2hZ354g79VpomGDHj1CMQyF/xqh/biYm968
         4c1YqLlii3UKL+09aDxeQYDp+uwVCOohFO858xeiiDwy8qMSQhz7CTQMdYSB0t2GSql0
         RZ++HH7CfMDw5VTkMb0llU207862JIovdEUP8nKPWfKh0Phf3SXTDBrZGUyRx2f12b/8
         fmjxiH3UnpJ0OAyzffcyrWJPAo1xIPfyHnASANBmX56uFPwxtcs3EhOJLG0Z2kDZUZOy
         jCGeLiljCEs6hiRtBY+Ymreu2jouS0qKd4DoXtyz/j0bV7NE/C716Fptiqlerm5VYgpo
         t+Bw==
X-Gm-Message-State: AOJu0YwUpfClpwaA/35uGj3TkOfAOF/v0NME7S/ULfmwya3iY9KfNK7U
	a5g65YwTLJWc3W/Up/FXplczkVLF+Kb5iFWeerucUIB7Im2L5umM
X-Google-Smtp-Source: AGHT+IFvIy1DmNfZB7kj7EoqbMZqegF/H2rFPRzaGgfh4bfuRnhQ2hiY6Qi+H9I5iuI76TTV44t/Zw==
X-Received: by 2002:a5d:64e6:0:b0:33b:3ced:a5e1 with SMTP id g6-20020a5d64e6000000b0033b3ceda5e1mr2977647wri.20.1707144282065;
        Mon, 05 Feb 2024 06:44:42 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCWb8pba3ZsebPa0k+WYTEdWwu4cItrvFY42MeLwJYoWaa30UnHSKzeUsqmOXGP5WnLa89NqvkEg6wBM53fhS7zAVWCTHBBWJGwtrpjbj9cTGZesf7JkcYkOoBfQWH+hJGLZU/7cNKFwUt38IpkDKagGc7Wx2TO6PA1LAK6UEpW81vV/9iYqKzT1HYgZGyVl0jl4Rd+TCXYwEXF7i7hdtwt7wg5qxNKss3ZOdoFWrmBihZyOx0uyoRl+Bw0+G4p3nucCUt9S4J8clG8jCudPLYpucdEACsnlRMduSo3nxFeXZ3qrdMig+lXbi0BhNErySFtoqOTtdwulHd0fksVoXaQ947vORglCrCcB1RDu0vU5ldwRVyK9L1mjTon26HWmjaRlBuNlYhZ5Fa/SOhcF3dkV9vaxZN3Bd5Uh9OMvlJPzkzyx3gTNuxWnt9tjoeb2lNpVGxAjhUqo0nJ5BAps3IURcnFQxhBs2juiYmXuMS8=
Received: from prasmi.home ([2a00:23c8:2500:a01:8f3c:6ff8:96c9:c9f0])
        by smtp.gmail.com with ESMTPSA id u7-20020a05600c19c700b0040fdf2832desm70272wmq.12.2024.02.05.06.44.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Feb 2024 06:44:41 -0800 (PST)
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
Subject: [PATCH v2 3/3] arm64: dts: renesas: r9a08g045: Add missing interrupts of IRQC node
Date: Mon,  5 Feb 2024 14:44:21 +0000
Message-Id: <20240205144421.51195-4-prabhakar.mahadev-lad.rj@bp.renesas.com>
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

The IRQC block on RZ/G3S ("R9A08G045") SoC supports ECCRAM error
interrupts too, add those missing interrupts in the IRQC node.

Fixes: 837918aa3fdd ("arm64: dts: renesas: r9a08g045: Add IA55 interrupt controller node")
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 arch/arm64/boot/dts/renesas/r9a08g045.dtsi | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/renesas/r9a08g045.dtsi b/arch/arm64/boot/dts/renesas/r9a08g045.dtsi
index dfee878c0f49..4aaffd1753c8 100644
--- a/arch/arm64/boot/dts/renesas/r9a08g045.dtsi
+++ b/arch/arm64/boot/dts/renesas/r9a08g045.dtsi
@@ -152,7 +152,10 @@ irqc: interrupt-controller@11050000 {
 				     <GIC_SPI 458 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 459 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 460 IRQ_TYPE_LEVEL_HIGH>,
-				     <GIC_SPI 29 IRQ_TYPE_LEVEL_HIGH>;
+				     <GIC_SPI 29 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 31 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 32 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 33 IRQ_TYPE_LEVEL_HIGH>;
 			interrupt-names = "nmi",
 					  "irq0", "irq1", "irq2", "irq3",
 					  "irq4", "irq5", "irq6", "irq7",
@@ -164,7 +167,8 @@ irqc: interrupt-controller@11050000 {
 					  "tint20", "tint21", "tint22", "tint23",
 					  "tint24", "tint25", "tint26", "tint27",
 					  "tint28", "tint29", "tint30", "tint31",
-					  "bus-err";
+					  "bus-err", "ec7tie1-0", "ec7tie2-0",
+					  "ec7tiovf-0";
 			clocks = <&cpg CPG_MOD R9A08G045_IA55_CLK>,
 				 <&cpg CPG_MOD R9A08G045_IA55_PCLK>;
 			clock-names = "clk", "pclk";
-- 
2.34.1


