Return-Path: <linux-kernel+bounces-122895-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A335C88FF22
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 13:35:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5869A2936E1
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 12:35:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23B3B7F7C2;
	Thu, 28 Mar 2024 12:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="L2LVcLxM"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF3747F476
	for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 12:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711629290; cv=none; b=IR5PZljNyhAv2aX2cbeIvF5myaWWEVPmaKZVJgyggE9Qg30EKQeODnXll54dHBrys9p9p3xcd2O1Yl6VgMM7C6j40IpplpDVLLwZo43S0/iGrLVvVeMXw9T4Kvc74I4AVlmWeSCoklOjmAgpPmv/mPf+7EcUMVCwq/RWaXLmqtc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711629290; c=relaxed/simple;
	bh=G9rajGk0d4ZQFcRW6N7DSPqkzn3MfbXX+XgYTkYr7rE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nHtexqoHfN+vtwlPeDBha5MUoPrqFl2ghB7r/WFMVCOGIWycI4Zqdki155UcnhrhBThNo5c3FVAojLteZDwcGeHp+dvKzQW5SYVfKJ42mhF+BvZcqfZBbwhCN7vI69ii3SUZSetovv12pZixFDUbiTBDGzNH6hEKMsfAwQWB+lY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=L2LVcLxM; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4141156f245so6395375e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 05:34:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711629286; x=1712234086; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T+QixHXzYFVjgJw5tBEGG1f8mkq14aJzxd8vq8TimAA=;
        b=L2LVcLxMcRoO1TyXkv7FeF1xtRZTtZvrNE45QhlsNT9fF4OpaQBAxGI4hasc7UwnsC
         ouySrmGOmbx2Y94dMbuyaMV0y1woS8WycLbcSKbOjIsl+z4JOU/3avY4SaEjIyxPTRco
         hmuSBiwWaxX32YJC5ADmDhs7UrjWod5FLUh4kr8d7W7C9SrHCyL9HxMw8Grh4RNzzcyc
         vXhPkWRRmTo2qHEVlM72xxqGpCZbBrEu4alxU17zWJt16Eb2cRnL9VfvrWw2YGQNOMzh
         YdFIdnZoEWC8GvYljamSaDEPgPxmipCRgTuAgyHTvw+cdVeqMRqXd4aZeGX2M79qaDKA
         eWVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711629286; x=1712234086;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T+QixHXzYFVjgJw5tBEGG1f8mkq14aJzxd8vq8TimAA=;
        b=q0D57cMZSDVNsrYx9RX8P6BWnYUuNmnrl82W0V6jjeQYc8qrhmlqLKo1aoJOELkAed
         2YFLrHTPvhipmekbGkLzykUyhgzSXx2dGPE0wT3EfWzAeODIFJFU1p4WORjTtqDXfLId
         FZXawDTSrRbdCOfcdAynOfVzyF0lAP259ahgtzqu7d6Qc3GFj7TH6lIa0fIn+b7EcuDw
         Vt5GFMtMx+LzFLSqMbya7ol+nHPF7msqVPztvk3p4P5fyfJ1uckyDNVbl4XyYWEC7kKg
         4URb+rIp9fVx7mw5ugcYsbhUiMhLHRJo/6SwtAa95Fx7q/+n2S6udG3YPW5ZPF2EDZN2
         JixQ==
X-Forwarded-Encrypted: i=1; AJvYcCWzM8Ed/vU3lGkrjnFNjWoUmNVGpvzBo272AOaVaPOCbmWZATKhduMXOGoCfZlUwrTFiUP0HBf4ud77qXNke+XqladkKE5/WhcyH9bV
X-Gm-Message-State: AOJu0Yw4lueslcZqGLGf5+eyci2XNg+IReMkNIjAazKdocl4pmrECHBv
	hquE9emBYner/FUyL/QTjJSZF/jxsP1rEcYrDtkAxHox6JG1hfBS/TiOrO9NN12tn+yrpBG3bHv
	E
X-Google-Smtp-Source: AGHT+IEg9bXN3pX43iAB0Sl1xHuJwsJg1t2ngWepln87O+0j1btTlnVLBn8xAFxqRjumR0gBJD0eJw==
X-Received: by 2002:a05:600c:4e8e:b0:414:8065:2d23 with SMTP id f14-20020a05600c4e8e00b0041480652d23mr2331235wmq.20.1711629286314;
        Thu, 28 Mar 2024 05:34:46 -0700 (PDT)
Received: from ta2.c.googlers.com.com (158.100.79.34.bc.googleusercontent.com. [34.79.100.158])
        by smtp.gmail.com with ESMTPSA id u6-20020adfa186000000b00341e2146b53sm1639671wru.106.2024.03.28.05.34.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Mar 2024 05:34:45 -0700 (PDT)
From: Tudor Ambarus <tudor.ambarus@linaro.org>
To: peter.griffin@linaro.org,
	krzysztof.kozlowski@linaro.org
Cc: alim.akhtar@samsung.com,
	linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	andre.draszik@linaro.org,
	willmcvicker@google.com,
	kernel-team@android.com,
	s.nawrocki@samsung.com,
	cw00.choi@samsung.com,
	mturquette@baylibre.com,
	sboyd@kernel.org,
	semen.protsenko@linaro.org,
	linux-clk@vger.kernel.org,
	jaewon02.kim@samsung.com,
	Tudor Ambarus <tudor.ambarus@linaro.org>
Subject: [PATCH v3 2/3] clk: samsung: gs101: propagate PERIC1 USI SPI clock rate
Date: Thu, 28 Mar 2024 12:34:39 +0000
Message-ID: <20240328123440.1387823-3-tudor.ambarus@linaro.org>
X-Mailer: git-send-email 2.44.0.396.g6e790dbe36-goog
In-Reply-To: <20240328123440.1387823-1-tudor.ambarus@linaro.org>
References: <20240328123440.1387823-1-tudor.ambarus@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

When SPI transfer is being prepared, the spi-s3c64xx driver will call
clk_set_rate() to change the rate of SPI source clock (IPCLK). But IPCLK
is a gate (leaf) clock, so it must propagate the rate change up the
clock tree, so that corresponding MUX/DIV clocks can actually change
their values. Add CLK_SET_RATE_PARENT flag to corresponding clocks for
all USI instances in GS101 PERIC1: USI{0, 9, 10, 11, 12, 13}. This change
involves the following clocks:

PERIC1 USI*:

    Clock                              Div range    MUX Selection
    -------------------------------------------------------------------
    gout_peric1_peric1_top0_ipclk_*    -            -
    dout_peric1_usi*_usi               /1..16       -
    mout_peric1_usi*_usi_user          -            {24.5 MHz, 400 MHz}

With input clock of 400 MHz this scheme provides the following IPCLK
rate range, for each USI block:

    PERIC1 USI*:       1.5 MHz ... 400 MHz

Accounting for internal /4 divider in SPI blocks, and because the max
SPI frequency is limited at 50 MHz, it gives us next SPI SCK rates:

    PERIC1 USI_SPI*:   384 KHz ... 49.9 MHz

Which shall be fine for the applications of the SPI bus.

Note that with this we allow the reparenting of the MUX_USIx clocks to
OSCCLK. Each instance of the USI IP has its own MUX_USI clock, thus the
reparenting of a MUX_USI clock corresponds to a single instance of the
USI IP. The datasheet mentions OSCCLK just in the low-power mode
context, but the downstream driver reparents too the MUX_USI clocks to
OSCCLK. Follow the downstream driver and do the same.

Fixes: 63b4bd1259d9 ("clk: samsung: gs101: add support for cmu_peric1")
Reviewed-by: Peter Griffin <peter.griffin@linaro.org>
Acked-by: André Draszik <andre.draszik@linaro.org>
Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
---
 drivers/clk/samsung/clk-gs101.c | 90 ++++++++++++++++++---------------
 1 file changed, 48 insertions(+), 42 deletions(-)

diff --git a/drivers/clk/samsung/clk-gs101.c b/drivers/clk/samsung/clk-gs101.c
index d065e343a85d..ddf2d57eed68 100644
--- a/drivers/clk/samsung/clk-gs101.c
+++ b/drivers/clk/samsung/clk-gs101.c
@@ -3230,47 +3230,53 @@ static const struct samsung_mux_clock peric1_mux_clks[] __initconst = {
 	MUX(CLK_MOUT_PERIC1_I3C_USER,
 	    "mout_peric1_i3c_user", mout_peric1_nonbususer_p,
 	    PLL_CON0_MUX_CLKCMU_PERIC1_I3C_USER, 4, 1),
-	MUX(CLK_MOUT_PERIC1_USI0_USI_USER,
-	    "mout_peric1_usi0_usi_user", mout_peric1_nonbususer_p,
-	    PLL_CON0_MUX_CLKCMU_PERIC1_USI0_USI_USER, 4, 1),
-	MUX(CLK_MOUT_PERIC1_USI10_USI_USER,
-	    "mout_peric1_usi10_usi_user", mout_peric1_nonbususer_p,
-	    PLL_CON0_MUX_CLKCMU_PERIC1_USI10_USI_USER, 4, 1),
-	MUX(CLK_MOUT_PERIC1_USI11_USI_USER,
-	    "mout_peric1_usi11_usi_user", mout_peric1_nonbususer_p,
-	    PLL_CON0_MUX_CLKCMU_PERIC1_USI11_USI_USER, 4, 1),
-	MUX(CLK_MOUT_PERIC1_USI12_USI_USER,
-	    "mout_peric1_usi12_usi_user", mout_peric1_nonbususer_p,
-	    PLL_CON0_MUX_CLKCMU_PERIC1_USI12_USI_USER, 4, 1),
-	MUX(CLK_MOUT_PERIC1_USI13_USI_USER,
-	    "mout_peric1_usi13_usi_user", mout_peric1_nonbususer_p,
-	    PLL_CON0_MUX_CLKCMU_PERIC1_USI13_USI_USER, 4, 1),
-	MUX(CLK_MOUT_PERIC1_USI9_USI_USER,
-	    "mout_peric1_usi9_usi_user", mout_peric1_nonbususer_p,
-	    PLL_CON0_MUX_CLKCMU_PERIC1_USI9_USI_USER, 4, 1),
+	nMUX(CLK_MOUT_PERIC1_USI0_USI_USER,
+	     "mout_peric1_usi0_usi_user", mout_peric1_nonbususer_p,
+	     PLL_CON0_MUX_CLKCMU_PERIC1_USI0_USI_USER, 4, 1),
+	nMUX(CLK_MOUT_PERIC1_USI10_USI_USER,
+	     "mout_peric1_usi10_usi_user", mout_peric1_nonbususer_p,
+	     PLL_CON0_MUX_CLKCMU_PERIC1_USI10_USI_USER, 4, 1),
+	nMUX(CLK_MOUT_PERIC1_USI11_USI_USER,
+	     "mout_peric1_usi11_usi_user", mout_peric1_nonbususer_p,
+	     PLL_CON0_MUX_CLKCMU_PERIC1_USI11_USI_USER, 4, 1),
+	nMUX(CLK_MOUT_PERIC1_USI12_USI_USER,
+	     "mout_peric1_usi12_usi_user", mout_peric1_nonbususer_p,
+	     PLL_CON0_MUX_CLKCMU_PERIC1_USI12_USI_USER, 4, 1),
+	nMUX(CLK_MOUT_PERIC1_USI13_USI_USER,
+	     "mout_peric1_usi13_usi_user", mout_peric1_nonbususer_p,
+	     PLL_CON0_MUX_CLKCMU_PERIC1_USI13_USI_USER, 4, 1),
+	nMUX(CLK_MOUT_PERIC1_USI9_USI_USER,
+	     "mout_peric1_usi9_usi_user", mout_peric1_nonbususer_p,
+	     PLL_CON0_MUX_CLKCMU_PERIC1_USI9_USI_USER, 4, 1),
 };
 
 static const struct samsung_div_clock peric1_div_clks[] __initconst = {
 	DIV(CLK_DOUT_PERIC1_I3C, "dout_peric1_i3c", "mout_peric1_i3c_user",
 	    CLK_CON_DIV_DIV_CLK_PERIC1_I3C, 0, 4),
-	DIV(CLK_DOUT_PERIC1_USI0_USI,
-	    "dout_peric1_usi0_usi", "mout_peric1_usi0_usi_user",
-	    CLK_CON_DIV_DIV_CLK_PERIC1_USI0_USI, 0, 4),
-	DIV(CLK_DOUT_PERIC1_USI10_USI,
-	    "dout_peric1_usi10_usi", "mout_peric1_usi10_usi_user",
-	    CLK_CON_DIV_DIV_CLK_PERIC1_USI10_USI, 0, 4),
-	DIV(CLK_DOUT_PERIC1_USI11_USI,
-	    "dout_peric1_usi11_usi", "mout_peric1_usi11_usi_user",
-	    CLK_CON_DIV_DIV_CLK_PERIC1_USI11_USI, 0, 4),
-	DIV(CLK_DOUT_PERIC1_USI12_USI,
-	    "dout_peric1_usi12_usi", "mout_peric1_usi12_usi_user",
-	    CLK_CON_DIV_DIV_CLK_PERIC1_USI12_USI, 0, 4),
-	DIV(CLK_DOUT_PERIC1_USI13_USI,
-	    "dout_peric1_usi13_usi", "mout_peric1_usi13_usi_user",
-	    CLK_CON_DIV_DIV_CLK_PERIC1_USI13_USI, 0, 4),
-	DIV(CLK_DOUT_PERIC1_USI9_USI,
-	    "dout_peric1_usi9_usi", "mout_peric1_usi9_usi_user",
-	    CLK_CON_DIV_DIV_CLK_PERIC1_USI9_USI, 0, 4),
+	DIV_F(CLK_DOUT_PERIC1_USI0_USI,
+	      "dout_peric1_usi0_usi", "mout_peric1_usi0_usi_user",
+	      CLK_CON_DIV_DIV_CLK_PERIC1_USI0_USI, 0, 4,
+	      CLK_SET_RATE_PARENT, 0),
+	DIV_F(CLK_DOUT_PERIC1_USI10_USI,
+	      "dout_peric1_usi10_usi", "mout_peric1_usi10_usi_user",
+	      CLK_CON_DIV_DIV_CLK_PERIC1_USI10_USI, 0, 4,
+	      CLK_SET_RATE_PARENT, 0),
+	DIV_F(CLK_DOUT_PERIC1_USI11_USI,
+	      "dout_peric1_usi11_usi", "mout_peric1_usi11_usi_user",
+	      CLK_CON_DIV_DIV_CLK_PERIC1_USI11_USI, 0, 4,
+	      CLK_SET_RATE_PARENT, 0),
+	DIV_F(CLK_DOUT_PERIC1_USI12_USI,
+	      "dout_peric1_usi12_usi", "mout_peric1_usi12_usi_user",
+	      CLK_CON_DIV_DIV_CLK_PERIC1_USI12_USI, 0, 4,
+	      CLK_SET_RATE_PARENT, 0),
+	DIV_F(CLK_DOUT_PERIC1_USI13_USI,
+	      "dout_peric1_usi13_usi", "mout_peric1_usi13_usi_user",
+	      CLK_CON_DIV_DIV_CLK_PERIC1_USI13_USI, 0, 4,
+	      CLK_SET_RATE_PARENT, 0),
+	DIV_F(CLK_DOUT_PERIC1_USI9_USI,
+	      "dout_peric1_usi9_usi", "mout_peric1_usi9_usi_user",
+	      CLK_CON_DIV_DIV_CLK_PERIC1_USI9_USI, 0, 4,
+	      CLK_SET_RATE_PARENT, 0),
 };
 
 static const struct samsung_gate_clock peric1_gate_clks[] __initconst = {
@@ -3305,27 +3311,27 @@ static const struct samsung_gate_clock peric1_gate_clks[] __initconst = {
 	GATE(CLK_GOUT_PERIC1_PERIC1_TOP0_IPCLK_1,
 	     "gout_peric1_peric1_top0_ipclk_1", "dout_peric1_usi0_usi",
 	     CLK_CON_GAT_GOUT_BLK_PERIC1_UID_PERIC1_TOP0_IPCLKPORT_IPCLK_1,
-	     21, 0, 0),
+	     21, CLK_SET_RATE_PARENT, 0),
 	GATE(CLK_GOUT_PERIC1_PERIC1_TOP0_IPCLK_2,
 	     "gout_peric1_peric1_top0_ipclk_2", "dout_peric1_usi9_usi",
 	     CLK_CON_GAT_GOUT_BLK_PERIC1_UID_PERIC1_TOP0_IPCLKPORT_IPCLK_2,
-	     21, 0, 0),
+	     21, CLK_SET_RATE_PARENT, 0),
 	GATE(CLK_GOUT_PERIC1_PERIC1_TOP0_IPCLK_3,
 	     "gout_peric1_peric1_top0_ipclk_3", "dout_peric1_usi10_usi",
 	     CLK_CON_GAT_GOUT_BLK_PERIC1_UID_PERIC1_TOP0_IPCLKPORT_IPCLK_3,
-	     21, 0, 0),
+	     21, CLK_SET_RATE_PARENT, 0),
 	GATE(CLK_GOUT_PERIC1_PERIC1_TOP0_IPCLK_4,
 	     "gout_peric1_peric1_top0_ipclk_4", "dout_peric1_usi11_usi",
 	     CLK_CON_GAT_GOUT_BLK_PERIC1_UID_PERIC1_TOP0_IPCLKPORT_IPCLK_4,
-	     21, 0, 0),
+	     21, CLK_SET_RATE_PARENT, 0),
 	GATE(CLK_GOUT_PERIC1_PERIC1_TOP0_IPCLK_5,
 	     "gout_peric1_peric1_top0_ipclk_5", "dout_peric1_usi12_usi",
 	     CLK_CON_GAT_GOUT_BLK_PERIC1_UID_PERIC1_TOP0_IPCLKPORT_IPCLK_5,
-	     21, 0, 0),
+	     21, CLK_SET_RATE_PARENT, 0),
 	GATE(CLK_GOUT_PERIC1_PERIC1_TOP0_IPCLK_6,
 	     "gout_peric1_peric1_top0_ipclk_6", "dout_peric1_usi13_usi",
 	     CLK_CON_GAT_GOUT_BLK_PERIC1_UID_PERIC1_TOP0_IPCLKPORT_IPCLK_6,
-	     21, 0, 0),
+	     21, CLK_SET_RATE_PARENT, 0),
 	GATE(CLK_GOUT_PERIC1_PERIC1_TOP0_IPCLK_8,
 	     "gout_peric1_peric1_top0_ipclk_8", "dout_peric1_i3c",
 	     CLK_CON_GAT_GOUT_BLK_PERIC1_UID_PERIC1_TOP0_IPCLKPORT_IPCLK_8,
-- 
2.44.0.396.g6e790dbe36-goog


