Return-Path: <linux-kernel+bounces-69422-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F3A38588D2
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 23:36:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CEF1A2828D9
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 22:36:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 729A21509B7;
	Fri, 16 Feb 2024 22:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nPIKj6BG"
Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5A7614D44D
	for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 22:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708122784; cv=none; b=K/FsCM+j3yMZIptCeiIXNLSD/2S1Xkg6q1iKt5TTCiUJrdZp+CHMvfLhR+ZqPFM3O7F65/Kn32zPxnbYhryxNtAikH/2J4ENae9riG9b6LB+CUvTcul6evh1LhdXV/8yMlWRclu9qCTtcDHvQ/Y4AGm/mEx9SRKuQP2Gm9cTUpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708122784; c=relaxed/simple;
	bh=IpYTwVvtbGsA5DUmVNUVd0AssLWUdtfSYxsrxvQPaCI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=sGY0eEDQh7No5aUXsi9EqHj+bafehNyp3MCr7ggnrURFEOVlRQ+wdHoWv5O5UFK34WkJ/kJCvCoUipPzBUgbqJ6jKdbRv+IqGYq6lc4GsFvEoHrE5nCBIFNmIWAQBhhBJ+4YIiYjTM+a9ik8Gv5+m3WoM4M+p0F/viRd1kyT7MA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=nPIKj6BG; arc=none smtp.client-ip=209.85.167.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oi1-f175.google.com with SMTP id 5614622812f47-3c0496f494cso2366077b6e.1
        for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 14:33:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708122779; x=1708727579; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hqedr2Cf8uu/ojchTl0vqAT7pyl8JaYNxl2fhHgkUDU=;
        b=nPIKj6BGNEUwUY5wJ8eHJsXcPeR/CmInExnkB3YDvRe/jjYn3X6y/XZx8IHOpEhMbS
         7recHhiYEzRJNXlTZ8ze9xzsVqJV+XyJ0ZDLoaIENOpscbwdhoPawvClZ1NTe3xPC9Jm
         TFdk8v8wmRLf6Ruus73Zzo76pqQmSmfPySh95IMiBiLy2VFqcv1k+vze42o+LbyRO8nV
         IBjkd6coac2SVtMOyQZEgylqh/y5P19tNHZC0g1o2bSg+L/h0R9C0EJ/49LAPn27KHnQ
         Qxz7OrLQvmprIckMPKAtMF03rKlS8xwL4wp0O+yM0jVv7sqZBKHts1tYRDRFUKxikp81
         nh5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708122779; x=1708727579;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hqedr2Cf8uu/ojchTl0vqAT7pyl8JaYNxl2fhHgkUDU=;
        b=IFicB4jhc4w1B0lxlN2U1ISdZPxSoFJrusdRQaRf5iHtcEwt7kNWGtzjmo33svrim8
         KRIY6Ub8nrDpCWfpCbDZZ6NzUfjnIPyVfTHVV9SojWdh7io7+LkIpGjG5uq8jf2J6WyJ
         t1Fw/ld0juG3EYPyaEFD43t5V5bhUy7b/sk0a2WHdbzvCHWrmcYoYPbwo6G61DdZ3CTj
         UsRHesCoZv0BS9tf5sVsGTpU3IOwWsOncKpn8BRTF8KEfj3gamivT5svXGcvN1mn1nAW
         ZG04iKU0CyNdy5yfz/UHmxJ/VujELaE3hoZIlWWGONtaYpd9Cj69zrwjdNBKpOt8xMUE
         kMPA==
X-Forwarded-Encrypted: i=1; AJvYcCXhM/Wnd2hQU1g6lVJG2GFPW29xQmqVmSbjc4TloWkq/pYpgI5pNg5bSAJHIJ2CpNSj4KXRi6IRf6js8ASevMd+F6tGXWgcpocOo9PZ
X-Gm-Message-State: AOJu0YwH8/z4RzXk6SXb6AaAm+Cr7zGiHMdHCibCnc3yecMXWhwum2rK
	aomjD75/ZZdaHclZ62Ob748qVEV7jXhNBHIyYyLsmKp/EkEygIoziSp7Kdy6OTc=
X-Google-Smtp-Source: AGHT+IG+ne10+UGzrxsIM3qTjARf9KX9TPUBRYEZ1G+65MMHUS0yyLw6vNMSFgUqvmX17ex/zLMMnw==
X-Received: by 2002:a05:6808:3193:b0:3bf:f4b2:2164 with SMTP id cd19-20020a056808319300b003bff4b22164mr7924507oib.28.1708122779339;
        Fri, 16 Feb 2024 14:32:59 -0800 (PST)
Received: from localhost ([136.62.192.75])
        by smtp.gmail.com with ESMTPSA id cr3-20020a056808368300b003bff074dd43sm126449oib.58.2024.02.16.14.32.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Feb 2024 14:32:59 -0800 (PST)
From: Sam Protsenko <semen.protsenko@linaro.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Sylwester Nawrocki <s.nawrocki@samsung.com>,
	Chanwoo Choi <cw00.choi@samsung.com>
Cc: Alim Akhtar <alim.akhtar@samsung.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Tomasz Figa <tomasz.figa@gmail.com>,
	linux-samsung-soc@vger.kernel.org,
	linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 16/16] arm64: dts: exynos: Add CPU clocks
Date: Fri, 16 Feb 2024 16:32:45 -0600
Message-Id: <20240216223245.12273-17-semen.protsenko@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240216223245.12273-1-semen.protsenko@linaro.org>
References: <20240216223245.12273-1-semen.protsenko@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Define CPU cluster 0 and CPU cluster 1 CMUs, which generate CPU clocks,
and add corresponding CPU clocks to CPU nodes.

Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
---
 arch/arm64/boot/dts/exynos/exynos850.dtsi | 26 +++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/arch/arm64/boot/dts/exynos/exynos850.dtsi b/arch/arm64/boot/dts/exynos/exynos850.dtsi
index 2ba67c3d0681..0706c8534ceb 100644
--- a/arch/arm64/boot/dts/exynos/exynos850.dtsi
+++ b/arch/arm64/boot/dts/exynos/exynos850.dtsi
@@ -93,6 +93,8 @@ cpu0: cpu@0 {
 			compatible = "arm,cortex-a55";
 			reg = <0x0>;
 			enable-method = "psci";
+			clocks = <&cmu_cpucl0 CLK_CLUSTER0_SCLK>;
+			clock-names = "cluster0_clk";
 		};
 		cpu1: cpu@1 {
 			device_type = "cpu";
@@ -117,6 +119,8 @@ cpu4: cpu@100 {
 			compatible = "arm,cortex-a55";
 			reg = <0x100>;
 			enable-method = "psci";
+			clocks = <&cmu_cpucl1 CLK_CLUSTER1_SCLK>;
+			clock-names = "cluster1_clk";
 		};
 		cpu5: cpu@101 {
 			device_type = "cpu";
@@ -254,6 +258,28 @@ cmu_peri: clock-controller@10030000 {
 				      "dout_peri_uart", "dout_peri_ip";
 		};
 
+		cmu_cpucl1: clock-controller@10800000 {
+			compatible = "samsung,exynos850-cmu-cpucl1";
+			reg = <0x10800000 0x8000>;
+			#clock-cells = <1>;
+
+			clocks = <&oscclk>, <&cmu_top CLK_DOUT_CPUCL1_SWITCH>,
+				 <&cmu_top CLK_DOUT_CPUCL1_DBG>;
+			clock-names = "oscclk", "dout_cpucl1_switch",
+				      "dout_cpucl1_dbg";
+		};
+
+		cmu_cpucl0: clock-controller@10900000 {
+			compatible = "samsung,exynos850-cmu-cpucl0";
+			reg = <0x10900000 0x8000>;
+			#clock-cells = <1>;
+
+			clocks = <&oscclk>, <&cmu_top CLK_DOUT_CPUCL0_SWITCH>,
+				 <&cmu_top CLK_DOUT_CPUCL0_DBG>;
+			clock-names = "oscclk", "dout_cpucl0_switch",
+				      "dout_cpucl0_dbg";
+		};
+
 		cmu_g3d: clock-controller@11400000 {
 			compatible = "samsung,exynos850-cmu-g3d";
 			reg = <0x11400000 0x8000>;
-- 
2.39.2


