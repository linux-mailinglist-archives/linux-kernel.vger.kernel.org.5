Return-Path: <linux-kernel+bounces-44272-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 59039841FC1
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 10:39:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ED68D1F23377
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 09:39:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D744E657C0;
	Tue, 30 Jan 2024 09:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yQCaAXXb"
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF0756089B
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 09:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706607512; cv=none; b=ovUCY1VjJKCo62em//nHvyT8ti5u1NgRYi3jqPC9QchyjG36w/8VO23vSkUVH7nNo7VPYwUCIaTzc1xqTYNALFF2vqquvVfUI9SbH77n+L8KMjEt0v+zXQw2zFVOtxC1BC8AHnuiOdqXs4LQu7GeM7BpMdxZRFk/hOCBS1Sy8/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706607512; c=relaxed/simple;
	bh=KmlVQI5t6vRCllo/cOaAJqkCPGhX9wTEE9PDUFITUjE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FDBOWKfu3DpmErhcl7rbknnKmim3BH+uOtWiKvqoOf7z8bUxwe33uuTfvc3V2OX3lfn35gb/iPJZC/8nnoWHKdvIXlIPsRkeNGe9EGghQL5NGhbbiPwqK9e3A8mpZVSmCKQ6V0Ga8ub8cwnru1smM3kAK/wG0ozrwIPJIwjyZSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=yQCaAXXb; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-55f15762840so1646322a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 01:38:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706607509; x=1707212309; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TAQSA+kK9jYgf9iRBFCJiMz1V0l84ZXoobUQ8ktAm0o=;
        b=yQCaAXXbt9/VBWNTUatbrRUbuxcKR3GlRGwqpgUcaro7C9RK5gO2EC+rtK10qrfVhY
         vD78PqQ9Qr5UI/IuM+4LgGTS0nQNlxhHF/9M4nBIOTju5ZkfFWnB3fyKYChK3fIESymk
         uLXevaiAMx06iE6RimyEgqnDX55Nvo/n/9DTOR1p37XOFd605q6O11Ettwe1Q2DFwTVM
         QLDFgJGIxqqeYTJRxl/FC57aVwun0rPS48NpjoV0IT9u//S7Xt6fQJVUm3kWgfdJdf57
         3foYMkd3mitmRQbX60dcvQr+00tgMRgS8kDbFrQOz4P1U164Kqlrze3d6Nf2KM24esyF
         fz4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706607509; x=1707212309;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TAQSA+kK9jYgf9iRBFCJiMz1V0l84ZXoobUQ8ktAm0o=;
        b=HOfwAee7EunYPiOjsoLEpCULvI17OsJN3VWWHhbV3k74R2KhMQ1xLsqZ0y5BvuTwDf
         EeavbjozJx+mkxIyB//zclAJhIQ/sIfb+hGzAv4BBey9vHiTyskW5disZ2WzT751gPCC
         YvJ5i0eaHUAPX0VS6y/uwu/GUThcp45eBloeZzUuDrMYQhdLnAMeeCIvbJZHYxtwKrK3
         jTjQQAQVfuF11A6dhYcaMrowslOIHEAoBbhNRwPuVIcHKDuAQg/RbTDcjgaKndhV5AjT
         W74R1B3t74dkWQ76F2ivz2soX6NNrboyxjgEz9iyErKUijvPKC6oVovYvdvSKtU8LrCB
         +QSA==
X-Gm-Message-State: AOJu0YzWYbzEEwwhex76oaE6o/XX95+7JSlccwvgPWjEapn+ZF5AtTZV
	gLIzJ5mXxgr4Iv6/INnkvqbetQjWhLMOB9yB+9eOPloI0NNw0xt84CVilYsabVA=
X-Google-Smtp-Source: AGHT+IF/m5mOArbCMzdGKzrOsjS0gVO6XRzIQWNVZ+HOi84zCHVgcM0i192IppW0vZqT+Xw+n90eTw==
X-Received: by 2002:aa7:d7c4:0:b0:55f:aa:12a7 with SMTP id e4-20020aa7d7c4000000b0055f00aa12a7mr3320283eds.16.1706607508887;
        Tue, 30 Jan 2024 01:38:28 -0800 (PST)
Received: from puffmais.c.googlers.com.com (94.189.141.34.bc.googleusercontent.com. [34.141.189.94])
        by smtp.gmail.com with ESMTPSA id q10-20020aa7cc0a000000b0055ef56f4575sm2281225edt.39.2024.01.30.01.38.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jan 2024 01:38:28 -0800 (PST)
From: =?UTF-8?q?Andr=C3=A9=20Draszik?= <andre.draszik@linaro.org>
To: peter.griffin@linaro.org,
	mturquette@baylibre.com,
	sboyd@kernel.org,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@android.com,
	tudor.ambarus@linaro.org,
	willmcvicker@google.com,
	semen.protsenko@linaro.org,
	alim.akhtar@samsung.com,
	s.nawrocki@samsung.com,
	tomasz.figa@gmail.com,
	cw00.choi@samsung.com,
	linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org,
	linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org,
	=?UTF-8?q?Andr=C3=A9=20Draszik?= <andre.draszik@linaro.org>
Subject: [PATCH v2 4/6] arm64: dts: exynos: gs101: use correct clocks for usi_uart
Date: Tue, 30 Jan 2024 09:36:43 +0000
Message-ID: <20240130093812.1746512-5-andre.draszik@linaro.org>
X-Mailer: git-send-email 2.43.0.429.g432eaa2c6b-goog
In-Reply-To: <20240130093812.1746512-1-andre.draszik@linaro.org>
References: <20240130093812.1746512-1-andre.draszik@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Wrong pclk clocks have been used in this usi_uart instance here. For
USI and UART, we need the ipclk and pclk, where pclk is the bus clock.
Without it, nothing can work.

It is unclear what exactly is using USI0_UART_CLK, but it is not
required for the IP to be operational at this stage, while pclk is.
This also brings the DT in line with the clock names expected by the
usi and uart drivers.

Update the DTSI accordingly.

Fixes: d97b6c902a40 ("arm64: dts: exynos: gs101: update USI UART to use peric0 clocks")
Signed-off-by: André Draszik <andre.draszik@linaro.org>
Reviewed-by: Sam Protsenko <semen.protsenko@linaro.org>
Reviewed-by: Tudor Ambarus <tudor.ambarus@linaro.org>
Tested-by: Tudor Ambarus <tudor.ambarus@linaro.org>

---
v2:
* fix a typo in and add an empty line to the commit message
* collect Reviewed-by: Tested-by: tags
---
 arch/arm64/boot/dts/exynos/google/gs101.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/exynos/google/gs101.dtsi b/arch/arm64/boot/dts/exynos/google/gs101.dtsi
index e5b665be2d62..f93e937d2726 100644
--- a/arch/arm64/boot/dts/exynos/google/gs101.dtsi
+++ b/arch/arm64/boot/dts/exynos/google/gs101.dtsi
@@ -410,7 +410,7 @@ usi_uart: usi@10a000c0 {
 			ranges;
 			#address-cells = <1>;
 			#size-cells = <1>;
-			clocks = <&cmu_peric0 CLK_GOUT_PERIC0_CLK_PERIC0_USI0_UART_CLK>,
+			clocks = <&cmu_peric0 CLK_GOUT_PERIC0_PERIC0_TOP1_PCLK_0>,
 				 <&cmu_peric0 CLK_GOUT_PERIC0_PERIC0_TOP1_IPCLK_0>;
 			clock-names = "pclk", "ipclk";
 			samsung,sysreg = <&sysreg_peric0 0x1020>;
@@ -422,7 +422,7 @@ serial_0: serial@10a00000 {
 				reg = <0x10a00000 0xc0>;
 				interrupts = <GIC_SPI 634
 					      IRQ_TYPE_LEVEL_HIGH 0>;
-				clocks = <&cmu_peric0 CLK_GOUT_PERIC0_CLK_PERIC0_USI0_UART_CLK>,
+				clocks = <&cmu_peric0 CLK_GOUT_PERIC0_PERIC0_TOP1_PCLK_0>,
 					 <&cmu_peric0 CLK_GOUT_PERIC0_PERIC0_TOP1_IPCLK_0>;
 				clock-names = "uart", "clk_uart_baud0";
 				samsung,uart-fifosize = <256>;
-- 
2.43.0.429.g432eaa2c6b-goog


