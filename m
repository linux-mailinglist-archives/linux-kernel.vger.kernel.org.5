Return-Path: <linux-kernel+bounces-49603-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6495E846C50
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 10:40:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 195B328F5A2
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 09:40:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 895C069D39;
	Fri,  2 Feb 2024 09:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sek8YVI6"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F11177F13;
	Fri,  2 Feb 2024 09:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706866769; cv=none; b=est5jR6e5b90WGO6MZ6/jMYXDDDHd8gM0MzCAGZtLVSaFTcEGAfxlK3mxxxU2o/9rGsqUF1KX9MyO4+HNTCj1Ag/9DG6EhHVkjNY6pucik486FQ3tne3ZpwEvhVqOag30tGQTeq2f4C7BWNPm819KsW/ek2GK0fuisiTfZNItMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706866769; c=relaxed/simple;
	bh=o6zKlCRYUt2BSG8XpkiwFiKX5T6HCJM24IsdrG2CyKs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CKE+9fW15humvY8Ef8P482v4tIG6+V/iLaQojAqpI25v5ZdP5qBHSGqHjDPDdkFF8Ec3cB5HV0qXnwzEpIRkhCD+urDjZiOjJJ2mNj2Q5OjgurvyTXmMX+LIfeZBglbvTF/Uq/5OjpEFBWvnnUFdErAXKg6rMGYAOG3yn49CpeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Sek8YVI6; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-40fb63c40c0so16247965e9.2;
        Fri, 02 Feb 2024 01:39:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706866766; x=1707471566; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mxX9SuYP61nTgfI4oPW5jhb/LHORakLs18eXcIl65Qk=;
        b=Sek8YVI6A1tfE1ifbaJuzZjy4tXoxZ5RQqXSmpTCEyN+wn+MKhyuqdrd+TUihOHmWr
         hK58WpYrIQOsZ1fIur/tJ3Lc7er6ZtdzSNe/R2S15xRqLQab17c/Qd7YdNcyrh+3d+Tk
         NNr/y3PNJF52zGjqknRojZgL6GIvLywIC2LBefzlDmpy2huEKaE6VO8d2tV6i4n4/dN8
         GzGyVTQs40F1NqDxcCrA+QuWajnIE3X10PhC1YJ5nfYbKQbKnAiUzM3sPY4z0C5d+8Kf
         6QToixq8+h3+lwHvwBpbXXSfLJSlmsoznnx9sk5UKrxTL48qnG5UMmehxo0jhDzB+WA3
         uiDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706866766; x=1707471566;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mxX9SuYP61nTgfI4oPW5jhb/LHORakLs18eXcIl65Qk=;
        b=k3qlno+sTxtAiUxpf2b/rEMvzn5Bd16OgSx55wtB0eO7+A6pBY/541nQsoiZZ884eJ
         T3qeZni71Y3l00aE4nXNMa7YcbsnPFU+mGZy1LzoQoUSZZEnBz5bDtI+0WUg/HyZQP7t
         6u560pGA4A/N54FNQW7IGvj5Uesmmn8oa8hJZu7YCXYeKLH+mZD0tYNf9+V7FuTPTxxL
         WiBQC8LcrpoWhHTK21B/x/nmS5iqRuU0OftGnjQNPUUd7Bu1wlDjWt2zIbtCSuegp6QD
         S+9IbkGO+zEXN8FXqHcbkqYGFgJohOl6wib72h9Y4QzOEFX6mWJJHU3H1PqneKUCpIwl
         /fxg==
X-Gm-Message-State: AOJu0YxdohYVGvqxZhsAV8GYjbuWgfbG0JoJduymrjqKXyky0Vd4zsfm
	blx6DF3iFf8zzu+cTj24RpvIYKPxoz0btuLLE0pCSB+NbdcXpZ1XfGSHjjjHvm8=
X-Google-Smtp-Source: AGHT+IFaNIhkG3te4w9nYdaZxElf7pShxmN5czz3G55ma+m/iyWAdXZF0QLTGnCG2FrnwRaBO980WA==
X-Received: by 2002:a05:600c:1989:b0:40e:3a6f:9b3e with SMTP id t9-20020a05600c198900b0040e3a6f9b3emr5983606wmq.6.1706866766163;
        Fri, 02 Feb 2024 01:39:26 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCVGlG/lpDTPs2dsBACt7oY0zPiMT7lwAtshlG6KmCJI9DVD0D2jbr+NtMVWgllpvn5qVi5pJz3qotgkrvihomQOXwrhQTUAecUOxSqpVlyGG8KFlLtokagexDI0kXM6M5ZlhGKyiycbCU7csdE3fxFxdK1IQkk56axgGQWAfsABJ9PF0sJwTvwt8dhDW1FT2/HATo1FmkN0qRfnw3WQp92DV2izwQ/VKeaxqVlHbihnlgrCc9D9vB2Oo44Pe4N61pe4WYd22wdffCTo8pd/4swueFlLu6TAnO7Kf9cqq32ggaS4MVbeHWAhfCCykhRtBYW+A9zJRN5V89U7I4gVKTxxBnzaWLp0Vi+HXKHnuREiwED3BGHAm+58ssc5NiCbjaH7pSGtUP5DHGn3+bjnxk1DOn7ygWWW+vLL8r0me7Wpe7ePRMB8HjIHV0Za2OBhXONQwtaQImH5zaXEGRb3Y1joNe8phmR6Rf7khLn3sic=
Received: from prasmi.home ([2a00:23c8:2500:a01:a994:230a:9969:dbf7])
        by smtp.gmail.com with ESMTPSA id bg10-20020a05600c3c8a00b0040fbdf77ca3sm3827530wmb.42.2024.02.02.01.39.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Feb 2024 01:39:25 -0800 (PST)
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
Subject: [PATCH 3/3] arm64: dts: renesas: r9a08g045: Add missing interrupts of IRQC node
Date: Fri,  2 Feb 2024 09:39:07 +0000
Message-Id: <20240202093907.9465-4-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240202093907.9465-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20240202093907.9465-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

The IRQC block on RZ/G3S supports ECCRAM error interrupts too, add those
interrupts in the IRQC node.

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


