Return-Path: <linux-kernel+bounces-40942-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF45783E894
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 01:37:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0ED0C1C226E9
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 00:37:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 557B48C14;
	Sat, 27 Jan 2024 00:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="C+FtbD1r"
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35D6B17C3
	for <linux-kernel@vger.kernel.org>; Sat, 27 Jan 2024 00:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706315830; cv=none; b=E3AX3r3m+DY4IdtLTjdFASB52SjSFXmcj2K+ylZcel2PBjoGOlNFZO3eLkSz/RpcbwKJL7CIxoGA7V96GyQAYtEhHuWzwEe6Wmhni02huDiJFza8VldjVXlb2N/8KF3xcv4vYsWXqA7KUA9b4DBqrRZWilKF9ODOW24Dj3Xn7NQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706315830; c=relaxed/simple;
	bh=6vWY/fqEbxu5raMhZbkehuR0JCHTq/UAt99T8/e22jU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QXxJlZ5bin+i3sJ1tiPywZsP5MSX8+jTZjixHrC3OsqUo44i3aOog4hiE3vQV3Uqp0OGOp/MRf8NHwZCJkCEmEH+m3yOyHyoVgBFaMvJye4Qkv64PI7AcNuexiqE6s7a8h5g9VHL9pH5TJExDf93l7YA3xIrERQhDECiYy5ZHMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=C+FtbD1r; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-33922d2cb92so1354174f8f.1
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 16:37:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706315826; x=1706920626; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SHiTLNqXAy/ffui/0jj45ErOQ8cZX/p93S1sxrZ6DNI=;
        b=C+FtbD1rR0iJ20cdDwkXKfWW0E03Sdrn+9ZMlDolngQvUnXEZVZJwZZZsQ04UriKx7
         8rkyXhuUykCeSWSYqZv/NM5VdS8rv7BY566u1Qq/uOV85pZxmQwILCDetvgvAYArt9Ke
         VCbsHGFURfGlWC4updUNsvsbdHDcb6MKLh5crST/IAFvPqO3wD1olPx9BAzK0Fu7+5K6
         ZdNVYlpJzr5loHp2BrHZGlKn/aatqEFVe/IvKiCcu4uz1sZ0WIPrgBWu07Nxk9ALkCrr
         kY8FQTe793baqhKPPC899S+yUfll/bau/bAkKBinwfqBdZN3fkTIXtOBOZLmZqUr2mCu
         BHXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706315826; x=1706920626;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SHiTLNqXAy/ffui/0jj45ErOQ8cZX/p93S1sxrZ6DNI=;
        b=KNW1yU/EiI0E0R0a91kHCUZXIkjedPUP7ULc03QH99WRYFkfut6zJS9kwaNRsK+58+
         qS2kVOZkAPN5jVHQ+H8Gs0ubEEIAEXRfNB4uDdkIVqDZbXSyzFyTd5jAvbvzgttBG9V+
         qM2mJs4AbddfLT0DjSvnj4Ae0vLX1iTHYdvEI5Ka13iIgaX4zYCn+HVprcMtnC6Z8VrV
         tT2iagrlRDNynNjDNAzOvFT8th+fiVKNUn7opNVXcMUn/nJ6OY/MUtRYIic+eVvkmHUg
         qbiRmu1xhOashLR13n9fHYJ1qz/3EuUyBrJB//v2raUu5yGj1UTYOqyEme4o1/7k6k1I
         Y9Bg==
X-Gm-Message-State: AOJu0YyLXb2WqirnZ9pCdTTHIlJ9PHvOW5Whx1F/dK1lJRHvPahy+AdP
	ngeeYBuBNJEZkWcpDTBSLGSQYMQ3gFaCtkVn8V6fx3QuErKUUkdV3013Mj+GNoE=
X-Google-Smtp-Source: AGHT+IGorEDbWQE6VfxFvlvSCPqIp6nl1sPSWqI+VAkqF7VgEu3yF8ZBjC3O57a4HzCVQzahFOXsXA==
X-Received: by 2002:a05:6000:1370:b0:337:bb78:8b3e with SMTP id q16-20020a056000137000b00337bb788b3emr210753wrz.197.1706315826560;
        Fri, 26 Jan 2024 16:37:06 -0800 (PST)
Received: from puffmais.c.googlers.com.com (229.112.91.34.bc.googleusercontent.com. [34.91.112.229])
        by smtp.gmail.com with ESMTPSA id vi1-20020a170907d40100b00a2f48a43c3esm1152235ejc.7.2024.01.26.16.37.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jan 2024 16:37:06 -0800 (PST)
From: =?UTF-8?q?Andr=C3=A9=20Draszik?= <andre.draszik@linaro.org>
To: peter.griffin@linaro.org,
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
	mturquette@baylibre.com,
	sboyd@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org,
	linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: [PATCH 4/5] arm64: dts: exynos: gs101: use correct clocks for usi_uart
Date: Sat, 27 Jan 2024 00:35:53 +0000
Message-ID: <20240127003607.501086-5-andre.draszik@linaro.org>
X-Mailer: git-send-email 2.43.0.429.g432eaa2c6b-goog
In-Reply-To: <20240127003607.501086-1-andre.draszik@linaro.org>
References: <20240127003607.501086-1-andre.draszik@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Wrong pclk clocks have been used in this usi8 instance here. For USI
and UART, we need the ipclk and pclk, where pclk is the bus clock.
Without it, nothing can work.
It is unclear what exactly is using USI0_UART_CLK, but it is not
required for the IP to be operational at this stage, while pclk is.
This also brings the DT in line with the clock names expected by the
usi and uart drivers.

Update the DTSI accordingly.

Fixes: d97b6c902a40 ("arm64: dts: exynos: gs101: update USI UART to use peric0 clocks")
Signed-off-by: André Draszik <andre.draszik@linaro.org>
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


