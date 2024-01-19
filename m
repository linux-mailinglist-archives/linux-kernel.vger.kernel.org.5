Return-Path: <linux-kernel+bounces-31079-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F279E832886
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 12:12:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3177D1C2237A
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 11:12:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 195814D581;
	Fri, 19 Jan 2024 11:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="T6m69d+e"
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CF2C4CE12
	for <linux-kernel@vger.kernel.org>; Fri, 19 Jan 2024 11:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705662715; cv=none; b=Xj74LQOXWiB7fIevcRPTjThoEFk/QS4Lh0USsSL/VcZU7b7Z72XKN+dS3YGS21TiZ7bl95BPbS/FqH8KIv6vPlf2z/5ZL3xI6GgqmsfzM7kTpFIWGxRAXN6jvqrGzLaiOPQuzsrGY3vBXUedvGxyonDNjy3sODrR6De8fc951aI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705662715; c=relaxed/simple;
	bh=ll3DEYGeH8ZhZJgGGkbdKZTUz6Fb1jCFDA13FeOkVVU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=thcbNtGG5RsPYKxAOSPhl1P0J+BrLrxZb5XzMtYflbndgCq1iYQ9v+A70KufWjrB30mA0+KwNyGN94/eWFC6A36AoJkXiWyY8trc6Wm3OnY/X+Z5ewcqFJOmHgsdOxjwaxdSGPMo39/eQtCP0KMAJ/zKqKof8Fi14THt1+j423g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=T6m69d+e; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-339237092dcso74493f8f.3
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jan 2024 03:11:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1705662712; x=1706267512; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Kmoj2ktoPsbPmlsDcpfD/T2RAgfFkzb1A8UxvOaNUC0=;
        b=T6m69d+eAxB7sySw3xnTUqt6BuzF9RBfXaGWKtSmDUQQ79QhvPzHwAq3bF97mH/dTW
         MkGj969nxOCzXCQ7KNj/9ldHY8C7rqzMEU5Rt9z1pGaHUTtVqqaTvF7veAaUtym4IcuL
         dN5E2S+ZB89JDJLI7JlTJNJXsIFqH/Nna0QG4iFo47BFJjmh5K36jE+HbXC89kZ2DCPj
         D5PakHtasmhwnfxzkUs+epggs6DS0UniYkaDIRgeE5QdsALNvXKQzNH5wp/3fK7xwWrL
         MuPrY+6Cix9xPmmvQYE3oZqCCUYVwpNXZHdhs//iF4Pc8Ux5eqquoC6O/4QJsPCyggig
         6maQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705662712; x=1706267512;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Kmoj2ktoPsbPmlsDcpfD/T2RAgfFkzb1A8UxvOaNUC0=;
        b=OGGA5uVhbifiFvb8//LYMYCRlinkU7OLH3nXkaxRCcwwYQ6iE8Mdan6UcnM+PYjitF
         uTFoLwJbiK/SxrlP0UMMGBKpicJDC33SnWzJ7/dTZDA43o3mla2dTxH9Q3WxQvVIt9y+
         Mc/JxDla/NDx6XnAWa+h+9e3dLUSzBgniuHtwLlyf1RTUxzI/5oK/nOfLlFBYWMBgoxA
         3YaAzpyNSbSvCWiQ4q0UiqUl9En413kxwx4x9lFvvigTCDtkYmGMaQYwrnHAi/jraNs8
         a8/k/ecqjSoGjC36aCNHThNwu1oDlkB9RdH8UT0orEU52U3voorOVFcNES+zE9FdcysP
         qt1w==
X-Gm-Message-State: AOJu0YyxzxAD2IIGqcJRULqEXpN2NrnEIRkW/QQU+XKsjAoI8swbriT4
	SmqUk/py68haXziqpo/rBtVFlffCUP1vt62HeQRWJ87UVX2uYUB/P6VzpW1HRHA=
X-Google-Smtp-Source: AGHT+IE6UGIuaWhe9PeL0tRLx7x2fZr6EP8zmEAW/WSGxSmRD4govtvG9uJd/VWwLIAEKLQLWvKK2w==
X-Received: by 2002:a5d:468c:0:b0:336:4b14:bed9 with SMTP id u12-20020a5d468c000000b003364b14bed9mr1605282wrq.6.1705662711797;
        Fri, 19 Jan 2024 03:11:51 -0800 (PST)
Received: from ta2.c.googlers.com.com (88.140.78.34.bc.googleusercontent.com. [34.78.140.88])
        by smtp.gmail.com with ESMTPSA id o10-20020a5d62ca000000b00337d4ce6ab4sm3341868wrv.20.2024.01.19.03.11.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jan 2024 03:11:50 -0800 (PST)
From: Tudor Ambarus <tudor.ambarus@linaro.org>
To: peter.griffin@linaro.org,
	mturquette@baylibre.com,
	sboyd@kernel.org,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org
Cc: andi.shyti@kernel.org,
	alim.akhtar@samsung.com,
	s.nawrocki@samsung.com,
	tomasz.figa@gmail.com,
	cw00.choi@samsung.com,
	linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org,
	linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-i2c@vger.kernel.org,
	andre.draszik@linaro.org,
	semen.protsenko@linaro.org,
	willmcvicker@google.com,
	kernel-team@android.com,
	Tudor Ambarus <tudor.ambarus@linaro.org>
Subject: [PATCH v4 4/8] arm64: dts: exynos: gs101: remove reg-io-width from serial
Date: Fri, 19 Jan 2024 11:11:28 +0000
Message-ID: <20240119111132.1290455-5-tudor.ambarus@linaro.org>
X-Mailer: git-send-email 2.43.0.429.g432eaa2c6b-goog
In-Reply-To: <20240119111132.1290455-1-tudor.ambarus@linaro.org>
References: <20240119111132.1290455-1-tudor.ambarus@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove the reg-io-width property in order to comply with the bindings.

The entire bus (PERIC) on which the GS101 serial resides only allows
32-bit register accesses. The reg-io-width dt property is disallowed
for the "google,gs101-uart" compatible and instead the iotype is
inferred from the compatible.

Reviewed-by: Peter Griffin <peter.griffin@linaro.org>
Reviewed-by: Sam Protsenko <semen.protsenko@linaro.org>
Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
---
 arch/arm64/boot/dts/exynos/google/gs101.dtsi | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm64/boot/dts/exynos/google/gs101.dtsi b/arch/arm64/boot/dts/exynos/google/gs101.dtsi
index d838e3a7af6e..4e5f4c748906 100644
--- a/arch/arm64/boot/dts/exynos/google/gs101.dtsi
+++ b/arch/arm64/boot/dts/exynos/google/gs101.dtsi
@@ -366,7 +366,6 @@ usi_uart: usi@10a000c0 {
 			serial_0: serial@10a00000 {
 				compatible = "google,gs101-uart";
 				reg = <0x10a00000 0xc0>;
-				reg-io-width = <4>;
 				interrupts = <GIC_SPI 634
 					      IRQ_TYPE_LEVEL_HIGH 0>;
 				clocks = <&dummy_clk 0>, <&dummy_clk 0>;
-- 
2.43.0.429.g432eaa2c6b-goog


