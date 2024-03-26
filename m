Return-Path: <linux-kernel+bounces-119593-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E51B988CAD8
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 18:29:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 13F3E1C61D8E
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 17:29:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56AA686AD8;
	Tue, 26 Mar 2024 17:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dt5oyABq"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FF4E1CF9B
	for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 17:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711474107; cv=none; b=dBWdqiP1RShkCxDihk8Zm1VSJ+gjOpXTvnfRBmsIRkL8M9kWfV8t4XaTzRtLJNsDR36+Tsb5lpBVMHUBdwPgZhX9Ksg1wbghlCyVWbCLKGWdRw6+nyLSL0l+UyueIAnM006XwjhRA6dnLMC133KYordEsL8JUiSkh6LbJWEMNKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711474107; c=relaxed/simple;
	bh=1qEcfv26Kc+hs++DwUriK/YZOiC+xb9h+NCuPIzYyW0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G+8F64utgIrsKVEEX8WYr93BvggTOzraKfs47rBW3K1osTusYOLbywOEbvDRAZtDraGBpkD3F87vqVGUQhJ/wZQjDlYD8dT9vj68VRifzq0vuWceWWUuUY4u7Br9IY667x9PRGzGKtJv7JwqwT2i9kAAOvP3J3u9I/SS1m7ycWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=dt5oyABq; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-41400a9844aso275535e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 10:28:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711474102; x=1712078902; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s72YFMp+lmG1G1HVXeWW7zD59QwXFY/GQWuU/zwBGN4=;
        b=dt5oyABqLjQeWuZULDUMRvPK7GnwVKnJOQQQKPsvSeP0QWwEbfImSUE3FUlfrRKbei
         Q+Ms3Si1WgaNte7t0OlJ2C8BIm8mQFt40ARwjA0CdXpST0sMnqwzauZ3A/KY74wok3Gg
         m+rArZmHPdTa5vyPq82SisQsrqtpSn1Q4OILdGlXwQX0oKpEyK0oLweGEv+7wP8Vr2CY
         rtdbevSWQLc1zh0h/FbOPbFWufBgQYXjGH9ZXom5NBEFgn+NffnuGcxBr4RaSWQbJDWP
         PQZ1LenzT3IrIssSWca3upQyvYQonhIQpe0d1HS3AQP4DmyMUKVLUQHhPZMbIMPD7PR1
         wVyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711474102; x=1712078902;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s72YFMp+lmG1G1HVXeWW7zD59QwXFY/GQWuU/zwBGN4=;
        b=Y+fed6f3UWoBp4eR1lUvMwvtoujibZTWfovxR+fbPIaQGZXVtDhoaPuccJFAusyr0n
         +FH4XNR4r59Y5h6sQSUZeDw+UtOzOXO9qnJLz8fEnVt0DHVmdf1Yr43mU6MdS5yFhYBF
         X2f9LEnMcDR1TPY+SX/1L5lyDJ2364JouOec2FV7WXxlqUisyKG7i9Yfh+Tk6QWkylHo
         fvuWXr6qIFaLeAeJai1P7jMM+9v4QJREYHU03Yc8qF8mA17dEchSCUPdt5gGjjN7S6BT
         SZJGxbwj+OSpCTeFRV+9NgiZfOId2anIjh7Fl6UYrv7pVrT7L1UrV1ZNrJtNTmjeGW/3
         opPA==
X-Forwarded-Encrypted: i=1; AJvYcCVxjEeZRd+bNnJjGbf22RYo1vzZn57pFcR/mZAhrV5iQ3bTfepExgrw2lKE/PFKFA0OXqKwUxiRm+YpPeyvg9CHzF1vdi4l36nk8aJM
X-Gm-Message-State: AOJu0YwlVZiWfVA7D/rkctV41+Tl/FP5q2qHs6IcMA5Y/poRc1oXcYHt
	3e2sWSiFrmfKI1YSPD6gGHsjADb9am5DMXBP8VmjyYnGWA7Ye9JZua9W+mE8wRi5dFHsb9KzuU8
	iMgs=
X-Google-Smtp-Source: AGHT+IEz2r0q4H1hHnBn2XZThzX8EBt5V2oflBLLA7sG4QWvQfNfX7G219uNlZgMasWEl58Bot97Lw==
X-Received: by 2002:a05:600c:1c2a:b0:414:37f:18dc with SMTP id j42-20020a05600c1c2a00b00414037f18dcmr1945243wms.1.1711474102167;
        Tue, 26 Mar 2024 10:28:22 -0700 (PDT)
Received: from ta2.c.googlers.com.com (158.100.79.34.bc.googleusercontent.com. [34.79.100.158])
        by smtp.gmail.com with ESMTPSA id fl12-20020a05600c0b8c00b004148f9c5822sm2063281wmb.22.2024.03.26.10.28.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Mar 2024 10:28:21 -0700 (PDT)
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
Subject: [PATCH v2 3/3] clk: samsung: gs101: propagate PERIC0 USI SPI clock rate
Date: Tue, 26 Mar 2024 17:28:13 +0000
Message-ID: <20240326172813.801470-4-tudor.ambarus@linaro.org>
X-Mailer: git-send-email 2.44.0.396.g6e790dbe36-goog
In-Reply-To: <20240326172813.801470-1-tudor.ambarus@linaro.org>
References: <20240326172813.801470-1-tudor.ambarus@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When SPI transfer is being prepared, the spi-s3c64xx driver will call
clk_set_rate() to change the rate of SPI source clock (IPCLK). But IPCLK
is a gate (leaf) clock, so it must propagate the rate change up the
clock tree, so that corresponding MUX/DIV clocks can actually change
their values. Add CLK_SET_RATE_PARENT flag to corresponding clocks for
all USI instances in GS101 PERIC0: USI{1-8, 14}. This change involves the
following clocks:

PERIC0 USI*:

    Clock                              Div range    MUX Selection
    -------------------------------------------------------------------
    gout_peric0_peric0_top0_ipclk_*    -            -
    dout_peric0_usi*_usi               /1..16       -
    mout_peric0_usi*_usi_user          -            {24.5 MHz, 400 MHz}

With input clock of 400 MHz this scheme provides the following IPCLK
rate range, for each USI block:

    PERIC0 USI*:       1.5 MHz ... 400 MHz

Accounting for internal /4 divider in SPI blocks, and because the max
SPI frequency is limited at 50 MHz, it gives us next SPI SCK rates:

    PERIC0 USI_SPI*:   384 KHz ... 49.9 MHz

Which shall be fine for the applications of the SPI bus.

Note that with this we allow the reparenting of the MUX_USIx clocks to
OSCCLK. Each instance of the USI IP has its own MUX_USI clock, thus the
reparenting of a MUX_USI clock corresponds to a single instance of the
USI IP. The datasheet mentions OSCCLK just in the low-power mode
context, but the downstream driver reparents too the MUX_USI clocks to
OSCCLK. Follow the downstream driver and do the same.

Fixes: 893f133a040b ("clk: samsung: gs101: add support for cmu_peric0")
Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
---
 drivers/clk/samsung/clk-gs101.c | 135 +++++++++++++++++---------------
 1 file changed, 72 insertions(+), 63 deletions(-)

diff --git a/drivers/clk/samsung/clk-gs101.c b/drivers/clk/samsung/clk-gs101.c
index ddf2d57eed68..bd3c1b02715b 100644
--- a/drivers/clk/samsung/clk-gs101.c
+++ b/drivers/clk/samsung/clk-gs101.c
@@ -2763,33 +2763,33 @@ static const struct samsung_mux_clock peric0_mux_clks[] __initconst = {
 	MUX(CLK_MOUT_PERIC0_USI0_UART_USER,
 	    "mout_peric0_usi0_uart_user", mout_peric0_usi0_uart_user_p,
 	    PLL_CON0_MUX_CLKCMU_PERIC0_USI0_UART_USER, 4, 1),
-	MUX(CLK_MOUT_PERIC0_USI14_USI_USER,
-	    "mout_peric0_usi14_usi_user", mout_peric0_usi_usi_user_p,
-	    PLL_CON0_MUX_CLKCMU_PERIC0_USI14_USI_USER, 4, 1),
-	MUX(CLK_MOUT_PERIC0_USI1_USI_USER,
-	    "mout_peric0_usi1_usi_user", mout_peric0_usi_usi_user_p,
-	    PLL_CON0_MUX_CLKCMU_PERIC0_USI1_USI_USER, 4, 1),
-	MUX(CLK_MOUT_PERIC0_USI2_USI_USER,
-	    "mout_peric0_usi2_usi_user", mout_peric0_usi_usi_user_p,
-	    PLL_CON0_MUX_CLKCMU_PERIC0_USI2_USI_USER, 4, 1),
-	MUX(CLK_MOUT_PERIC0_USI3_USI_USER,
-	    "mout_peric0_usi3_usi_user", mout_peric0_usi_usi_user_p,
-	    PLL_CON0_MUX_CLKCMU_PERIC0_USI3_USI_USER, 4, 1),
-	MUX(CLK_MOUT_PERIC0_USI4_USI_USER,
-	    "mout_peric0_usi4_usi_user", mout_peric0_usi_usi_user_p,
-	    PLL_CON0_MUX_CLKCMU_PERIC0_USI4_USI_USER, 4, 1),
-	MUX(CLK_MOUT_PERIC0_USI5_USI_USER,
-	    "mout_peric0_usi5_usi_user", mout_peric0_usi_usi_user_p,
-	    PLL_CON0_MUX_CLKCMU_PERIC0_USI5_USI_USER, 4, 1),
-	MUX(CLK_MOUT_PERIC0_USI6_USI_USER,
-	    "mout_peric0_usi6_usi_user", mout_peric0_usi_usi_user_p,
-	    PLL_CON0_MUX_CLKCMU_PERIC0_USI6_USI_USER, 4, 1),
-	MUX(CLK_MOUT_PERIC0_USI7_USI_USER,
-	    "mout_peric0_usi7_usi_user", mout_peric0_usi_usi_user_p,
-	    PLL_CON0_MUX_CLKCMU_PERIC0_USI7_USI_USER, 4, 1),
-	MUX(CLK_MOUT_PERIC0_USI8_USI_USER,
-	    "mout_peric0_usi8_usi_user", mout_peric0_usi_usi_user_p,
-	    PLL_CON0_MUX_CLKCMU_PERIC0_USI8_USI_USER, 4, 1),
+	nMUX(CLK_MOUT_PERIC0_USI14_USI_USER,
+	     "mout_peric0_usi14_usi_user", mout_peric0_usi_usi_user_p,
+	     PLL_CON0_MUX_CLKCMU_PERIC0_USI14_USI_USER, 4, 1),
+	nMUX(CLK_MOUT_PERIC0_USI1_USI_USER,
+	     "mout_peric0_usi1_usi_user", mout_peric0_usi_usi_user_p,
+	     PLL_CON0_MUX_CLKCMU_PERIC0_USI1_USI_USER, 4, 1),
+	nMUX(CLK_MOUT_PERIC0_USI2_USI_USER,
+	     "mout_peric0_usi2_usi_user", mout_peric0_usi_usi_user_p,
+	     PLL_CON0_MUX_CLKCMU_PERIC0_USI2_USI_USER, 4, 1),
+	nMUX(CLK_MOUT_PERIC0_USI3_USI_USER,
+	     "mout_peric0_usi3_usi_user", mout_peric0_usi_usi_user_p,
+	     PLL_CON0_MUX_CLKCMU_PERIC0_USI3_USI_USER, 4, 1),
+	nMUX(CLK_MOUT_PERIC0_USI4_USI_USER,
+	     "mout_peric0_usi4_usi_user", mout_peric0_usi_usi_user_p,
+	     PLL_CON0_MUX_CLKCMU_PERIC0_USI4_USI_USER, 4, 1),
+	nMUX(CLK_MOUT_PERIC0_USI5_USI_USER,
+	     "mout_peric0_usi5_usi_user", mout_peric0_usi_usi_user_p,
+	     PLL_CON0_MUX_CLKCMU_PERIC0_USI5_USI_USER, 4, 1),
+	nMUX(CLK_MOUT_PERIC0_USI6_USI_USER,
+	     "mout_peric0_usi6_usi_user", mout_peric0_usi_usi_user_p,
+	     PLL_CON0_MUX_CLKCMU_PERIC0_USI6_USI_USER, 4, 1),
+	nMUX(CLK_MOUT_PERIC0_USI7_USI_USER,
+	     "mout_peric0_usi7_usi_user", mout_peric0_usi_usi_user_p,
+	     PLL_CON0_MUX_CLKCMU_PERIC0_USI7_USI_USER, 4, 1),
+	nMUX(CLK_MOUT_PERIC0_USI8_USI_USER,
+	     "mout_peric0_usi8_usi_user", mout_peric0_usi_usi_user_p,
+	     PLL_CON0_MUX_CLKCMU_PERIC0_USI8_USI_USER, 4, 1),
 };
 
 static const struct samsung_div_clock peric0_div_clks[] __initconst = {
@@ -2798,33 +2798,42 @@ static const struct samsung_div_clock peric0_div_clks[] __initconst = {
 	DIV(CLK_DOUT_PERIC0_USI0_UART,
 	    "dout_peric0_usi0_uart", "mout_peric0_usi0_uart_user",
 	    CLK_CON_DIV_DIV_CLK_PERIC0_USI0_UART, 0, 4),
-	DIV(CLK_DOUT_PERIC0_USI14_USI,
-	    "dout_peric0_usi14_usi", "mout_peric0_usi14_usi_user",
-	    CLK_CON_DIV_DIV_CLK_PERIC0_USI14_USI, 0, 4),
-	DIV(CLK_DOUT_PERIC0_USI1_USI,
-	    "dout_peric0_usi1_usi", "mout_peric0_usi1_usi_user",
-	    CLK_CON_DIV_DIV_CLK_PERIC0_USI1_USI, 0, 4),
-	DIV(CLK_DOUT_PERIC0_USI2_USI,
-	    "dout_peric0_usi2_usi", "mout_peric0_usi2_usi_user",
-	    CLK_CON_DIV_DIV_CLK_PERIC0_USI2_USI, 0, 4),
-	DIV(CLK_DOUT_PERIC0_USI3_USI,
-	    "dout_peric0_usi3_usi", "mout_peric0_usi3_usi_user",
-	    CLK_CON_DIV_DIV_CLK_PERIC0_USI3_USI, 0, 4),
-	DIV(CLK_DOUT_PERIC0_USI4_USI,
-	    "dout_peric0_usi4_usi", "mout_peric0_usi4_usi_user",
-	    CLK_CON_DIV_DIV_CLK_PERIC0_USI4_USI, 0, 4),
-	DIV(CLK_DOUT_PERIC0_USI5_USI,
-	    "dout_peric0_usi5_usi", "mout_peric0_usi5_usi_user",
-	    CLK_CON_DIV_DIV_CLK_PERIC0_USI5_USI, 0, 4),
-	DIV(CLK_DOUT_PERIC0_USI6_USI,
-	    "dout_peric0_usi6_usi", "mout_peric0_usi6_usi_user",
-	    CLK_CON_DIV_DIV_CLK_PERIC0_USI6_USI, 0, 4),
-	DIV(CLK_DOUT_PERIC0_USI7_USI,
-	    "dout_peric0_usi7_usi", "mout_peric0_usi7_usi_user",
-	    CLK_CON_DIV_DIV_CLK_PERIC0_USI7_USI, 0, 4),
-	DIV(CLK_DOUT_PERIC0_USI8_USI,
-	    "dout_peric0_usi8_usi", "mout_peric0_usi8_usi_user",
-	    CLK_CON_DIV_DIV_CLK_PERIC0_USI8_USI, 0, 4),
+	DIV_F(CLK_DOUT_PERIC0_USI14_USI,
+	      "dout_peric0_usi14_usi", "mout_peric0_usi14_usi_user",
+	      CLK_CON_DIV_DIV_CLK_PERIC0_USI14_USI, 0, 4,
+	      CLK_SET_RATE_PARENT, 0),
+	DIV_F(CLK_DOUT_PERIC0_USI1_USI,
+	      "dout_peric0_usi1_usi", "mout_peric0_usi1_usi_user",
+	      CLK_CON_DIV_DIV_CLK_PERIC0_USI1_USI, 0, 4,
+	      CLK_SET_RATE_PARENT, 0),
+	DIV_F(CLK_DOUT_PERIC0_USI2_USI,
+	      "dout_peric0_usi2_usi", "mout_peric0_usi2_usi_user",
+	      CLK_CON_DIV_DIV_CLK_PERIC0_USI2_USI, 0, 4,
+	      CLK_SET_RATE_PARENT, 0),
+	DIV_F(CLK_DOUT_PERIC0_USI3_USI,
+	      "dout_peric0_usi3_usi", "mout_peric0_usi3_usi_user",
+	      CLK_CON_DIV_DIV_CLK_PERIC0_USI3_USI, 0, 4,
+	      CLK_SET_RATE_PARENT, 0),
+	DIV_F(CLK_DOUT_PERIC0_USI4_USI,
+	      "dout_peric0_usi4_usi", "mout_peric0_usi4_usi_user",
+	      CLK_CON_DIV_DIV_CLK_PERIC0_USI4_USI, 0, 4,
+	      CLK_SET_RATE_PARENT, 0),
+	DIV_F(CLK_DOUT_PERIC0_USI5_USI,
+	      "dout_peric0_usi5_usi", "mout_peric0_usi5_usi_user",
+	      CLK_CON_DIV_DIV_CLK_PERIC0_USI5_USI, 0, 4,
+	      CLK_SET_RATE_PARENT, 0),
+	DIV_F(CLK_DOUT_PERIC0_USI6_USI,
+	      "dout_peric0_usi6_usi", "mout_peric0_usi6_usi_user",
+	      CLK_CON_DIV_DIV_CLK_PERIC0_USI6_USI, 0, 4,
+	      CLK_SET_RATE_PARENT, 0),
+	DIV_F(CLK_DOUT_PERIC0_USI7_USI,
+	      "dout_peric0_usi7_usi", "mout_peric0_usi7_usi_user",
+	      CLK_CON_DIV_DIV_CLK_PERIC0_USI7_USI, 0, 4,
+	      CLK_SET_RATE_PARENT, 0),
+	DIV_F(CLK_DOUT_PERIC0_USI8_USI,
+	      "dout_peric0_usi8_usi", "mout_peric0_usi8_usi_user",
+	      CLK_CON_DIV_DIV_CLK_PERIC0_USI8_USI, 0, 4,
+	      CLK_SET_RATE_PARENT, 0),
 };
 
 static const struct samsung_gate_clock peric0_gate_clks[] __initconst = {
@@ -2857,11 +2866,11 @@ static const struct samsung_gate_clock peric0_gate_clks[] __initconst = {
 	GATE(CLK_GOUT_PERIC0_PERIC0_TOP0_IPCLK_0,
 	     "gout_peric0_peric0_top0_ipclk_0", "dout_peric0_usi1_usi",
 	     CLK_CON_GAT_GOUT_BLK_PERIC0_UID_PERIC0_TOP0_IPCLKPORT_IPCLK_0,
-	     21, 0, 0),
+	     21, CLK_SET_RATE_PARENT, 0),
 	GATE(CLK_GOUT_PERIC0_PERIC0_TOP0_IPCLK_1,
 	     "gout_peric0_peric0_top0_ipclk_1", "dout_peric0_usi2_usi",
 	     CLK_CON_GAT_GOUT_BLK_PERIC0_UID_PERIC0_TOP0_IPCLKPORT_IPCLK_1,
-	     21, 0, 0),
+	     21, CLK_SET_RATE_PARENT, 0),
 	GATE(CLK_GOUT_PERIC0_PERIC0_TOP0_IPCLK_10,
 	     "gout_peric0_peric0_top0_ipclk_10", "dout_peric0_i3c",
 	     CLK_CON_GAT_GOUT_BLK_PERIC0_UID_PERIC0_TOP0_IPCLKPORT_IPCLK_10,
@@ -2889,27 +2898,27 @@ static const struct samsung_gate_clock peric0_gate_clks[] __initconst = {
 	GATE(CLK_GOUT_PERIC0_PERIC0_TOP0_IPCLK_2,
 	     "gout_peric0_peric0_top0_ipclk_2", "dout_peric0_usi3_usi",
 	     CLK_CON_GAT_GOUT_BLK_PERIC0_UID_PERIC0_TOP0_IPCLKPORT_IPCLK_2,
-	     21, 0, 0),
+	     21, CLK_SET_RATE_PARENT, 0),
 	GATE(CLK_GOUT_PERIC0_PERIC0_TOP0_IPCLK_3,
 	     "gout_peric0_peric0_top0_ipclk_3", "dout_peric0_usi4_usi",
 	     CLK_CON_GAT_GOUT_BLK_PERIC0_UID_PERIC0_TOP0_IPCLKPORT_IPCLK_3,
-	     21, 0, 0),
+	     21, CLK_SET_RATE_PARENT, 0),
 	GATE(CLK_GOUT_PERIC0_PERIC0_TOP0_IPCLK_4,
 	     "gout_peric0_peric0_top0_ipclk_4", "dout_peric0_usi5_usi",
 	     CLK_CON_GAT_GOUT_BLK_PERIC0_UID_PERIC0_TOP0_IPCLKPORT_IPCLK_4,
-	     21, 0, 0),
+	     21, CLK_SET_RATE_PARENT, 0),
 	GATE(CLK_GOUT_PERIC0_PERIC0_TOP0_IPCLK_5,
 	     "gout_peric0_peric0_top0_ipclk_5", "dout_peric0_usi6_usi",
 	     CLK_CON_GAT_GOUT_BLK_PERIC0_UID_PERIC0_TOP0_IPCLKPORT_IPCLK_5,
-	     21, 0, 0),
+	     21, CLK_SET_RATE_PARENT, 0),
 	GATE(CLK_GOUT_PERIC0_PERIC0_TOP0_IPCLK_6,
 	     "gout_peric0_peric0_top0_ipclk_6", "dout_peric0_usi7_usi",
 	     CLK_CON_GAT_GOUT_BLK_PERIC0_UID_PERIC0_TOP0_IPCLKPORT_IPCLK_6,
-	     21, 0, 0),
+	     21, CLK_SET_RATE_PARENT, 0),
 	GATE(CLK_GOUT_PERIC0_PERIC0_TOP0_IPCLK_7,
 	     "gout_peric0_peric0_top0_ipclk_7", "dout_peric0_usi8_usi",
 	     CLK_CON_GAT_GOUT_BLK_PERIC0_UID_PERIC0_TOP0_IPCLKPORT_IPCLK_7,
-	     21, 0, 0),
+	     21, CLK_SET_RATE_PARENT, 0),
 	GATE(CLK_GOUT_PERIC0_PERIC0_TOP0_IPCLK_8,
 	     "gout_peric0_peric0_top0_ipclk_8", "dout_peric0_i3c",
 	     CLK_CON_GAT_GOUT_BLK_PERIC0_UID_PERIC0_TOP0_IPCLKPORT_IPCLK_8,
@@ -2990,7 +2999,7 @@ static const struct samsung_gate_clock peric0_gate_clks[] __initconst = {
 	GATE(CLK_GOUT_PERIC0_PERIC0_TOP1_IPCLK_2,
 	     "gout_peric0_peric0_top1_ipclk_2", "dout_peric0_usi14_usi",
 	     CLK_CON_GAT_GOUT_BLK_PERIC0_UID_PERIC0_TOP1_IPCLKPORT_IPCLK_2,
-	     21, 0, 0),
+	     21, CLK_SET_RATE_PARENT, 0),
 	/* Disabling this clock makes the system hang. Mark the clock as critical. */
 	GATE(CLK_GOUT_PERIC0_PERIC0_TOP1_PCLK_0,
 	     "gout_peric0_peric0_top1_pclk_0", "mout_peric0_bus_user",
-- 
2.44.0.396.g6e790dbe36-goog


