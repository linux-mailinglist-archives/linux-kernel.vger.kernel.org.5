Return-Path: <linux-kernel+bounces-38809-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D935283C643
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 16:17:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0A5E91C22392
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 15:17:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1298873170;
	Thu, 25 Jan 2024 15:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dlD8btkl"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2A9D6EB45
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 15:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706195804; cv=none; b=eVD6UJY2OHbvQlxothZtwfetdAsIUMuS690SAFgLPiqzEaY1ts2CKKeQ0/QL5FyXUvGjuipf7T2A08Zh3bxaVgDY1xlG5xIdjUrpm5Yw03Hc46/LK8KnYHuirv+mbjeUoBMzxFl7AmJLZ8e48jeNRHaZ+nMf8Knc6pjkLRbnFak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706195804; c=relaxed/simple;
	bh=0I+ktIFl+QFnTyp/eNm6GBgGpNp7GRnGcljOf6lhUG0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=En4yaKDtBdyycAxt1HuyLmgI5PPyKSIvUPU7MT3+ODS82Ej1MvFmGU205HViWUQdbqnGRrCrYNnOEW8SN756rO7esu+D7m11XOP+OhMvNA7RotlKdhd+aBDq9CEiT1FIaVQGI8K3K+a6bqb7BFt716DpS2J9FQHbYngfKPGzrNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=dlD8btkl; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-40e9101b5f9so75891955e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 07:16:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706195801; x=1706800601; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lvKWG/e47xpVeDKUkt0Rg+N1AoElcEqkQkRChhJ4Oc0=;
        b=dlD8btklKWW0G7Z7dvniU0HltisIaA1OK/fzjb6XEGx7vgw2Z4dEJFgAuJB3+tYHzv
         4GuVeLmAh4qWPkVECxqD0og/1Og3rDd8/VxluHUwMZRB9NbR/ZT93bi95P/XXEReDXFz
         fZ1q2E2D5ijWc4xhblgwrcK/BrqIprsv8lgzIoMzONm8bZFdoWX1m7arlw+ORP2OGRy/
         os6Obpe/sN9sw7b6LP8ScnOHNI1v2hNWjWqJuy0u5PkuoDwfy3l5y+XTbtm0sVOfHXch
         OOxl7QvX2XDWQhdVBuHIURBKWMcvMuwP8Ul14WKC6RYJcfhAPJOgEfVVamEC7BWB/w/5
         EMFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706195801; x=1706800601;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lvKWG/e47xpVeDKUkt0Rg+N1AoElcEqkQkRChhJ4Oc0=;
        b=d5yvEjOiFfklvZIXQ2smo7vVhhfKviIefb9WXcyS743n/0B8f959mUyqDWPrYGsySy
         JDuRM6O9K3QjqcCLAN7p7AvSptkwkCCJQzDVgPxkRt8+KxXowNMBqV7yloQwfVR0GDot
         gon6wffy2RM3DnZnI+jgI+kZuXOKGMW7C9ro9Vm/WNF21WmeEgM+xOFSWa09HT7t99v9
         syzDGe0eJamu/ay1/GnRdfPLZYIHh2ML2blhusLX/mXNXgdIXdFJLDUkNksSs+0aHghr
         ijlu39uMwnGGo3yhOQvHBPfqX51WqVdbkTQo7V0uwjQ4hDHtMVNzz/EklvcKSbtxgoQr
         I0OQ==
X-Gm-Message-State: AOJu0YwKtXCVmYG2Ehe9Zebr2UJQ27hP9t0qrF0V9b65pPjXXRrrjKmq
	bZaG7aXbN7uktdplg5ZvzhrwaCtvfwiUZvFgNTaUxlBst3QQVB0UJS3VFg0D74k=
X-Google-Smtp-Source: AGHT+IHJ7+M4aXjm46yTs7WZOceqTc+7m9CPKpsB/jvIaTZxiHerBJMrs0u00sLOKsFzD6iDKa5CaA==
X-Received: by 2002:a05:600c:3caa:b0:40c:2788:28f3 with SMTP id bg42-20020a05600c3caa00b0040c278828f3mr586429wmb.79.1706195800939;
        Thu, 25 Jan 2024 07:16:40 -0800 (PST)
Received: from ta2.c.googlers.com.com (88.140.78.34.bc.googleusercontent.com. [34.78.140.88])
        by smtp.gmail.com with ESMTPSA id q17-20020adfcb91000000b00337d3465997sm3184656wrh.38.2024.01.25.07.16.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jan 2024 07:16:39 -0800 (PST)
From: Tudor Ambarus <tudor.ambarus@linaro.org>
To: krzysztof.kozlowski+dt@linaro.org,
	broonie@kernel.org
Cc: robh+dt@kernel.org,
	conor+dt@kernel.org,
	alim.akhtar@samsung.com,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-spi@vger.kernel.org,
	andre.draszik@linaro.org,
	peter.griffin@linaro.org,
	semen.protsenko@linaro.org,
	kernel-team@android.com,
	willmcvicker@google.com,
	Tudor Ambarus <tudor.ambarus@linaro.org>
Subject: [PATCH 1/7] ARM: dts: samsung: s5pv210: specify the SPI fifosize
Date: Thu, 25 Jan 2024 15:16:24 +0000
Message-ID: <20240125151630.753318-2-tudor.ambarus@linaro.org>
X-Mailer: git-send-email 2.43.0.429.g432eaa2c6b-goog
In-Reply-To: <20240125151630.753318-1-tudor.ambarus@linaro.org>
References: <20240125151630.753318-1-tudor.ambarus@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Up to now the SPI alias was used as an index into an array defined in
the SPI driver to determine the SPI FIFO size. Drop the dependency on
the SPI alias and specify the SPI FIFO size directly into the SPI node.

The SPI nodes defined in s5pv210.dtsi are not enabled in any board file.
No SPI aliases are defined, thus I chose the FIFO size using common
sense: index 0 of the array corresponds to spi0, and index 1 to spi1.

Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
---
 arch/arm/boot/dts/samsung/s5pv210.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/samsung/s5pv210.dtsi b/arch/arm/boot/dts/samsung/s5pv210.dtsi
index ed560c9a3aa1..e7225b6c94e8 100644
--- a/arch/arm/boot/dts/samsung/s5pv210.dtsi
+++ b/arch/arm/boot/dts/samsung/s5pv210.dtsi
@@ -161,6 +161,7 @@ spi0: spi@e1300000 {
 			pinctrl-0 = <&spi0_bus>;
 			#address-cells = <1>;
 			#size-cells = <0>;
+			samsung,spi-fifosize = <256>;
 			status = "disabled";
 		};
 
@@ -177,6 +178,7 @@ spi1: spi@e1400000 {
 			pinctrl-0 = <&spi1_bus>;
 			#address-cells = <1>;
 			#size-cells = <0>;
+			samsung,spi-fifosize = <64>;
 			status = "disabled";
 		};
 
-- 
2.43.0.429.g432eaa2c6b-goog


