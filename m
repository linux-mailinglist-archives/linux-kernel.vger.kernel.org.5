Return-Path: <linux-kernel+bounces-42977-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AE4E84098B
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 16:17:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B418EB270A3
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 15:17:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 394AA155309;
	Mon, 29 Jan 2024 15:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Un99ZBMS"
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C17C515442F;
	Mon, 29 Jan 2024 15:16:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706541395; cv=none; b=kbusMeEa/qCbT/LAjfoiTiYjPJ9XveseXwayTYKpDzP34iSiKG1Fr8yTYP1Sp42PTz2ZVCdGyntpTrz09h+e+HXJsUKOfrU0TNaSHOGeuyffwQIIeUUiWDwGLmx1Tfv/MqDrpJi5hf+BMGbMKp6ZnhmFVSeaxaCgmhy7YOJWKow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706541395; c=relaxed/simple;
	bh=JqPOmyFWWffOGxGbyUZMSwBOxA6+G5/Ybqx9eE7zcuA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pQE3CwG5O2B8gB9mAN+ykrQ1qX/nW00QlmXvyxtZZOoksSg78wyfSCxtrg1FVf7E8UoGCtNnx6s+jAkr4f5P/6iYmyznkhPMcvPeoTLhujMZ5nmTpCzTnL0KTNlQyvMuucoA8b8jRvVHotdKi+GkmFdiHkdufjPC1EVIdN6Cx6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Un99ZBMS; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3392b12dd21so2376903f8f.0;
        Mon, 29 Jan 2024 07:16:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706541392; x=1707146192; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wJgRXuTMoAWmkGwVsSeykflT2WPb6W3nvYvk+W/0dwE=;
        b=Un99ZBMSAiRSItG8+0eraYwn9zApoleeWpb//q0V9G2+/5BmEGOhjODFRa/h/IWeNi
         FKjAXTWWyho4XQHzqlfxYGDdyYnNExOht1lRWQJ+0VaqgImcw8h6xODCK6ZHafznfc5T
         Yiu8e2X8u6Dxn/czFSuhRhU+U3jB0C8+LxqfMZ+TnL4uq2NU16rxnEB1gcmvgqmritgc
         F1iY3149FXq5Wdcz9vPxB3jY4QgagmQBDcm4fD2ujMu73nrIN+1FJ8eT88Qd4GQoXxGS
         CsPzrT7+7lyUD5iWYNsdXyKpj04oF6f/tlVLoiEtkKqvWKp9fHIr4vQuB7sP9BW/5DlW
         QH5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706541392; x=1707146192;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wJgRXuTMoAWmkGwVsSeykflT2WPb6W3nvYvk+W/0dwE=;
        b=u7rZw3dAUyL6+IDWzL1C4qK6kjg7VY2DKdRoCiwkCzPPKjS7ZJqQUa3GKPhU+Zyr2U
         /V/HFsOaEUgaFQRg+6i0DeZ3ght8QYBP+lpWnnHsKu1696/7mTI0fOSd5Z0ymBRIHdWw
         rt3x558XPt5TkBWlVOG/asiI10ptzBga/7Fyy0Q331jA+vkM1EC5JJKJneeOqpZzopM8
         qh712lIqLf2d2tBnWugGgNl59a/B/Eae4iOki4dyQBiYN2ou7SjpOXooMcAaXFJHjJ5O
         K1PWusfDdB5/owuirogXQRAZtPD3U2aCo0UUHZyzmCTJtiG0lmiM9jtC29HAQWaVnSfn
         27bQ==
X-Gm-Message-State: AOJu0YyrD4uCK3K+KE55gxQnA8H8Luh0vd23rYVcBnCewIwgTi4C8js+
	7rAFe+6uZbg7RGsyxhOPZVQJPkwmdBvWmdaUk2+OQbw/y18b8uCG
X-Google-Smtp-Source: AGHT+IFwq3XWk7GpIaGHC4p6tV7o7Q2uoZ+gdSfO/MQj7Ut/Qs87y1mR3yt8SnlfoQQg8m2U9NMLHg==
X-Received: by 2002:a5d:444a:0:b0:33a:e5a9:c22d with SMTP id x10-20020a5d444a000000b0033ae5a9c22dmr4041475wrr.25.1706541391673;
        Mon, 29 Jan 2024 07:16:31 -0800 (PST)
Received: from prasmi.home ([2a00:23c8:2500:a01:5616:a18c:ea50:2995])
        by smtp.gmail.com with ESMTPSA id h4-20020adfa4c4000000b00337d4eed87asm8397774wrb.115.2024.01.29.07.16.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jan 2024 07:16:30 -0800 (PST)
From: Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: Thomas Gleixner <tglx@linutronix.de>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Magnus Damm <magnus.damm@gmail.com>
Cc: linux-renesas-soc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Prabhakar <prabhakar.csengg@gmail.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 4/5] arm64: dts: renesas: r9a07g043: Move interrupt-parent property to common DTSI
Date: Mon, 29 Jan 2024 15:16:17 +0000
Message-Id: <20240129151618.90922-5-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240129151618.90922-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20240129151618.90922-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
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
---
 arch/arm64/boot/dts/renesas/r9a07g043.dtsi  | 1 +
 arch/arm64/boot/dts/renesas/r9a07g043u.dtsi | 4 ----
 2 files changed, 1 insertion(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/renesas/r9a07g043.dtsi b/arch/arm64/boot/dts/renesas/r9a07g043.dtsi
index 8721f4c9fa0f..d2365def1059 100644
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
index 2ab231572d95..0e931c88afa5 100644
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


