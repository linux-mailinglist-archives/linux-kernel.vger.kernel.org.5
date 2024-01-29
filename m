Return-Path: <linux-kernel+bounces-43235-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EBCF7841144
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 18:48:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 99B071F28E4E
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 17:48:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B430157E61;
	Mon, 29 Jan 2024 17:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wAOjQ2bb"
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52BEC3F9DC
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 17:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706550435; cv=none; b=c0TWmIg0eK3CwtViCq/2gwjs0umiq2r3q7oQqpkbVhsWygflzPlRftFEGqfqRZ6gZGMwFVPX+KgUWqE3rBNt66yflj5Nt0RqSny8W0UBrRAJ0s9uG5JLelG4NrJFzJC/u+hw/MACh5CbRYyFFr96FsnhEUEVqfBs4anZ5eqDFAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706550435; c=relaxed/simple;
	bh=5SkzBWqg5XsN99LRODxpScj73dZpSEexX9iVzejqvag=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=A3hC9Ylo36TMy3OcS26N75WGEIVSks/FqnKDDD2RH2LM0AP5Y23tUIkotRKXJ3UUC7dlvb5uRT2j5tMLXOVDouPOl2kFbU26abJPfUvEtP9u5PzByr9oMF8rSN/yldYTxRiY0BhhI3j8jWuuih4hBmUddItp2gu9i1TmNMz9F4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=wAOjQ2bb; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-55a9008c185so5228334a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 09:47:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706550429; x=1707155229; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dW6z0PXAWbDu11OK6iP//ej1RhU41xLpgjvot5fMaQE=;
        b=wAOjQ2bbX4JrHBtrQ486G2EZxfu81m9mKrxPQ9Ak6nBYdlnc+gddEstYI2XWB4YPUa
         as0gjJyAkYSnnIX0kP6een3thvn6nNBqVbGEVAwcCIO7MUxNxEtHHapgi+Zj/w7k4ybT
         DnA4+kmWYP0QFJOxn+f9RyNDF2AOXXP66QMG9J/x3AmPT5ax1oU0WuWrzaH+1/1jgMMa
         PKrs+cxPCo5NRQLl7NQDn5lD/rqugqrVeGj4/QuBxtcbndhiD9pn/5Czy4fVPxngbjh9
         zUNFTU373YP4tM9axwichNCz8EaiwMOCCTwXGVHP00NOmRw71gmjgmm27mV31wx+tyTQ
         jdYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706550429; x=1707155229;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dW6z0PXAWbDu11OK6iP//ej1RhU41xLpgjvot5fMaQE=;
        b=q+JGKjA6Z1PxVoCgQ5dMUHhSql045hvqBlDhzUPCgSMHVNBmfd28LuDi4AHDaWRZW/
         UgHIlNidQ3sdZeGSTPyYsICLH4dEFyJPCPLx0Nn3P+Hhncx6R0UnxcluOY69zOOSuzY5
         54h0IAUrOeBR+0UWnGFbHF8CU3p5pjyBs4ljSq97cTjXAvw2yWdkJRYYI1+leH/LeHDY
         xb6/AesvCfw/kQBBdSScDnp9FjIJl9BbZH9MrTLsKOkApzQIuzXTF8oKEeV7HYN49Tfl
         Dd/0DYdtvDGBWrOmnRS1ETYATMuBGtXAW7reEh9S4UjThcQhH9NmMJmVbqqq0wBlMl7+
         o3lg==
X-Gm-Message-State: AOJu0YzAT159XprSNohEVRcLXO4DwnB4tR9Knw9/FsC7zeCRLK/PM01h
	jkouLDZHuhKgkodd/u6EGvIGZDEI6Mt2NR5tpmlB0Kn031B2kKjg5Ww4JGkjWFs=
X-Google-Smtp-Source: AGHT+IGt2KTsJ4YXmvFPqTryS1s4+N4fhHWr0IqAevITSyWhnndE8QsGNTLb6yd3mrXG8aDB1ZBgaA==
X-Received: by 2002:a05:6402:22cd:b0:55e:f980:4666 with SMTP id dm13-20020a05640222cd00b0055ef9804666mr2798706edb.9.1706550429315;
        Mon, 29 Jan 2024 09:47:09 -0800 (PST)
Received: from puffmais.c.googlers.com.com (94.189.141.34.bc.googleusercontent.com. [34.141.189.94])
        by smtp.gmail.com with ESMTPSA id u10-20020a05640207ca00b0055f08fa9286sm1000999edy.23.2024.01.29.09.47.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jan 2024 09:47:08 -0800 (PST)
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
	devicetree@vger.kernel.org
Subject: [PATCH v3 5/7] arm64: dts: exynos: gs101: enable cmu-peric1 clock controller
Date: Mon, 29 Jan 2024 17:46:04 +0000
Message-ID: <20240129174703.1175426-6-andre.draszik@linaro.org>
X-Mailer: git-send-email 2.43.0.429.g432eaa2c6b-goog
In-Reply-To: <20240129174703.1175426-1-andre.draszik@linaro.org>
References: <20240129174703.1175426-1-andre.draszik@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Enable the cmu-peric1 clock controller. It feeds additional USI, I3C
and PWM interfaces / busses.

Note that &sysreg_peric1 needs a clock to be able to access its
registers and now that Linux knows about this clock, we need to add it
in this commit as well so as to keep &sysreg_peric1 working, so that
the clock can be enabled as and when needed.

Signed-off-by: André Draszik <andre.draszik@linaro.org>
Reviewed-by: Sam Protsenko <semen.protsenko@linaro.org>
Reviewed-by: Peter Griffin <peter.griffin@linaro.org>

---
v2:
* merge patch #8 from original series version 1 into this patch, i.e.
add the clock to &sysreg_peric1 in this commit & update commit message
* collect Reviewed-by: tags
---
 arch/arm64/boot/dts/exynos/google/gs101.dtsi | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm64/boot/dts/exynos/google/gs101.dtsi b/arch/arm64/boot/dts/exynos/google/gs101.dtsi
index aaac04df5e65..e1bcf490309a 100644
--- a/arch/arm64/boot/dts/exynos/google/gs101.dtsi
+++ b/arch/arm64/boot/dts/exynos/google/gs101.dtsi
@@ -429,9 +429,20 @@ serial_0: serial@10a00000 {
 			};
 		};
 
+		cmu_peric1: clock-controller@10c00000 {
+			compatible = "google,gs101-cmu-peric1";
+			reg = <0x10c00000 0x4000>;
+			#clock-cells = <1>;
+			clocks = <&ext_24_5m>,
+				 <&cmu_top CLK_DOUT_CMU_PERIC1_BUS>,
+				 <&cmu_top CLK_DOUT_CMU_PERIC1_IP>;
+			clock-names = "oscclk", "bus", "ip";
+		};
+
 		sysreg_peric1: syscon@10c20000 {
 			compatible = "google,gs101-peric1-sysreg", "syscon";
 			reg = <0x10c20000 0x10000>;
+			clocks = <&cmu_peric1 CLK_GOUT_PERIC1_SYSREG_PERIC1_PCLK>;
 		};
 
 		pinctrl_peric1: pinctrl@10c40000 {
-- 
2.43.0.429.g432eaa2c6b-goog


