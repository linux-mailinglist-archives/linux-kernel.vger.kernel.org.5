Return-Path: <linux-kernel+bounces-35244-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2389C838E6D
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 13:23:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 471B41C23211
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 12:23:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 251B55DF33;
	Tue, 23 Jan 2024 12:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JGz9NGCn"
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6BF65DF11;
	Tue, 23 Jan 2024 12:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706012604; cv=none; b=khDumpZmk62FRbo40IyGWF90Iv9r3fCzZoonQWZG/mNb4Uh1iAwhLdrrlAr7gDebY22dqjYA0X4l75pOjC6YylWusJ2Lq1E99vXtEE497vmL3+yNM3UUfuXZ90uDdQTWarmFrgh2NYfvBDH6wf2DV97q9PAsPi+XeOwdecdh/pk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706012604; c=relaxed/simple;
	bh=81Rq969C5fC2gwndSCJqbGyzbfJ1wYlS4kuBnSDBHgM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=jcmmRmbAke1gQhgQl+SEt47DWWAJC5Fzfp9YYElkxStMmTpNQB7igOhMNUBpbeq7O+xUQRjtVP0kEE+CwoCMTnrowCfzbY7I3slFE5nk9ND4zKbYlyk+MA95sX9tvCdRGaIDHR01U6U9Lsq0/2ZENs66np5dFzxwJA64SYhnxww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JGz9NGCn; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-55a3a875f7fso4622854a12.3;
        Tue, 23 Jan 2024 04:23:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706012601; x=1706617401; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0aT0YmN+E9RIm6EBLaUbj2bmTaqy7pebRlFTaUr3D2Y=;
        b=JGz9NGCnniuAM+DPmb+XqjWLKMTj29KHdVuv8KfXvDgfBPsGz4q5t6xDoHYmyMRSdt
         3sE2BZ3iIMUTi3y6GJ5QgpOwxXwO5BlfLSBeYFFnzW9a7x87/qvsgxMXPsYapDLPJIE1
         qL7mimPP1MRjkofJPQqX7Z/KfNOMwv9zAxfPUGSkKDJ9f3s89WxDmiD8uw4sVe8G5Xm1
         IYt9HChq2kb+4ZtPueXP8H6AMA1HhJHtAouEKrDMlJqRmdrHtYL1AWZMdOt4q/ab1D+B
         Zj8Ne5ZwIvL+UrDVh+vCg8e2IJQ5PCJ3I7jAbcIwMFKTc3p6Hvm4HnkGZEDWMmQ+u8Bt
         EE5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706012601; x=1706617401;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0aT0YmN+E9RIm6EBLaUbj2bmTaqy7pebRlFTaUr3D2Y=;
        b=q3D/e9lUQiPXbjV6a+aOKUIxMVEshrk680uYp429B1I+bx4XGPi3xKKNz6UANSqO87
         AtoKR7Y8Z84VHXaPjiAuc2/YilkrP5vgq2dGUxOAgI3TpHHASN3H/Z2OyFaPaPOIDc/L
         xQxSfZNqtdfwqlmspnkfoumeKXL1vfrC6FSqkxACafqF7yqWSlewr9MMU8hWMY7WXup7
         aKqY9T3Mayby0RZUkeM7na3yJ/Gf9vd+WruVoetgQ2UUXibGBb4HulfQQntErG3Dd0WR
         nARmhI89k/3JvrCBUOWNjMHSaClRFFYKUSQMjl3QpDXu2Mf3BKGN4GLw4Oyp9JrRB1cS
         qRiQ==
X-Gm-Message-State: AOJu0Yw48c0eONcPQZQCEfQ3KSNl2737lymMTTqQud8SVEubrLwtCWDp
	B8RqTdIj2e07nEiyGosXsKhp+H33MOnlGasmuISEmIg/ktoui+mn
X-Google-Smtp-Source: AGHT+IGA3HrSeLV+JUbWs+DXbEXmOPvoc09OHj5n0LVd6cRvKKc77CwwjGVeefJBo43iRrx7MpMG9w==
X-Received: by 2002:a17:907:c312:b0:a2a:3101:c9c7 with SMTP id tl18-20020a170907c31200b00a2a3101c9c7mr99810ejc.123.1706012600578;
        Tue, 23 Jan 2024 04:23:20 -0800 (PST)
Received: from localhost.lan (031011218106.poznan.vectranet.pl. [31.11.218.106])
        by smtp.gmail.com with ESMTPSA id ce2-20020a170906b24200b00a26a0145c5esm14292308ejb.116.2024.01.23.04.23.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jan 2024 04:23:20 -0800 (PST)
From: =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>,
	Gregory Clement <gregory.clement@bootlin.com>,
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>
Subject: [PATCH] arm64: dts: marvell: reorder crypto interrupts on Armada SoCs
Date: Tue, 23 Jan 2024 13:22:58 +0100
Message-Id: <20240123122258.24218-1-zajec5@gmail.com>
X-Mailer: git-send-email 2.35.3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Rafał Miłecki <rafal@milecki.pl>

Match order specified in binding documentation. It says "mem" should be
the last interrupt.

This fixes:
arch/arm64/boot/dts/marvell/armada-3720-db.dtb: crypto@90000: interrupt-names:0: 'ring0' was expected
        from schema $id: http://devicetree.org/schemas/crypto/inside-secure,safexcel.yaml#
arch/arm64/boot/dts/marvell/armada-3720-db.dtb: crypto@90000: interrupt-names:1: 'ring1' was expected
        from schema $id: http://devicetree.org/schemas/crypto/inside-secure,safexcel.yaml#
arch/arm64/boot/dts/marvell/armada-3720-db.dtb: crypto@90000: interrupt-names:2: 'ring2' was expected
        from schema $id: http://devicetree.org/schemas/crypto/inside-secure,safexcel.yaml#
arch/arm64/boot/dts/marvell/armada-3720-db.dtb: crypto@90000: interrupt-names:3: 'ring3' was expected
        from schema $id: http://devicetree.org/schemas/crypto/inside-secure,safexcel.yaml#
arch/arm64/boot/dts/marvell/armada-3720-db.dtb: crypto@90000: interrupt-names:4: 'eip' was expected
        from schema $id: http://devicetree.org/schemas/crypto/inside-secure,safexcel.yaml#
arch/arm64/boot/dts/marvell/armada-3720-db.dtb: crypto@90000: interrupt-names:5: 'mem' was expected
        from schema $id: http://devicetree.org/schemas/crypto/inside-secure,safexcel.yaml#

Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
---
 arch/arm64/boot/dts/marvell/armada-37xx.dtsi  | 10 +++++-----
 arch/arm64/boot/dts/marvell/armada-cp11x.dtsi | 10 +++++-----
 2 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/arch/arm64/boot/dts/marvell/armada-37xx.dtsi b/arch/arm64/boot/dts/marvell/armada-37xx.dtsi
index e300145ad1a6..1cc3fa1c354d 100644
--- a/arch/arm64/boot/dts/marvell/armada-37xx.dtsi
+++ b/arch/arm64/boot/dts/marvell/armada-37xx.dtsi
@@ -431,14 +431,14 @@ xor11 {
 			crypto: crypto@90000 {
 				compatible = "inside-secure,safexcel-eip97ies";
 				reg = <0x90000 0x20000>;
-				interrupts = <GIC_SPI 19 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 20 IRQ_TYPE_LEVEL_HIGH>,
+				interrupts = <GIC_SPI 20 IRQ_TYPE_LEVEL_HIGH>,
 					     <GIC_SPI 21 IRQ_TYPE_LEVEL_HIGH>,
 					     <GIC_SPI 22 IRQ_TYPE_LEVEL_HIGH>,
 					     <GIC_SPI 23 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 24 IRQ_TYPE_LEVEL_HIGH>;
-				interrupt-names = "mem", "ring0", "ring1",
-						  "ring2", "ring3", "eip";
+					     <GIC_SPI 24 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 19 IRQ_TYPE_LEVEL_HIGH>;
+				interrupt-names = "ring0", "ring1", "ring2",
+						  "ring3", "eip", "mem";
 				clocks = <&nb_periph_clk 15>;
 			};
 
diff --git a/arch/arm64/boot/dts/marvell/armada-cp11x.dtsi b/arch/arm64/boot/dts/marvell/armada-cp11x.dtsi
index 4ec1aae0a3a9..7e595ac80043 100644
--- a/arch/arm64/boot/dts/marvell/armada-cp11x.dtsi
+++ b/arch/arm64/boot/dts/marvell/armada-cp11x.dtsi
@@ -511,14 +511,14 @@ CP11X_LABEL(sdhci0): mmc@780000 {
 		CP11X_LABEL(crypto): crypto@800000 {
 			compatible = "inside-secure,safexcel-eip197b";
 			reg = <0x800000 0x200000>;
-			interrupts = <87 IRQ_TYPE_LEVEL_HIGH>,
-				<88 IRQ_TYPE_LEVEL_HIGH>,
+			interrupts = <88 IRQ_TYPE_LEVEL_HIGH>,
 				<89 IRQ_TYPE_LEVEL_HIGH>,
 				<90 IRQ_TYPE_LEVEL_HIGH>,
 				<91 IRQ_TYPE_LEVEL_HIGH>,
-				<92 IRQ_TYPE_LEVEL_HIGH>;
-			interrupt-names = "mem", "ring0", "ring1",
-				"ring2", "ring3", "eip";
+				<92 IRQ_TYPE_LEVEL_HIGH>,
+				<87 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "ring0", "ring1", "ring2", "ring3",
+					  "eip", "mem";
 			clock-names = "core", "reg";
 			clocks = <&CP11X_LABEL(clk) 1 26>,
 				 <&CP11X_LABEL(clk) 1 17>;
-- 
2.35.3


