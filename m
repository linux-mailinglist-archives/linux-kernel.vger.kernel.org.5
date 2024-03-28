Return-Path: <linux-kernel+bounces-122896-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 54D9088FF23
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 13:35:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BBCBA1F24550
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 12:35:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E40CC8004E;
	Thu, 28 Mar 2024 12:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ONX2w3L4"
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A494D7F487
	for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 12:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711629291; cv=none; b=pHXsz4IfpM7aQDOnYQ5WJdmS8zXhqVK32w52voUPi4HqrsiJ0PbEhbVjYdrHue6K9KXaSk9bbk5OqpgwPN4/nMqrgN14VobmvDUcJ3Z0uUrhAUQrEfK46voYfGq5rCMs7Q/nN18iynHiYlHlnOmF2XM+W80NMQ0kVaxWAbsoDdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711629291; c=relaxed/simple;
	bh=AeymmzYOVhV6ILBFdgZM5v3j4YNp4ZKQ8Dg8Z67qRwA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XGwdvwVYiS/UKmRXSj5LVZ1z2V+LucQKEC9AbTLUUTzZstFrMaTlbspnYNScYfMyjAj8y0CTz2uDn/n8SzXZfQMaQIONl1LUIvDDVEz4HLcUclwHj25tuTrb+vJvYBzX0NOcCr0pujnXCOcnTJ5FvT82cNBPUiCqLhJf6IlmWo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ONX2w3L4; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-34261edaf7eso581620f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 05:34:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711629287; x=1712234087; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JZ0vv1wQnvryEwq3rhsZ/X7XAHDM6osgJBQ005R7xBw=;
        b=ONX2w3L455L8KoxKD9jWmjLDD2nSQEGNGeiZ59OHdMGvw/0+V2JTpV3IWJsMTlT9DR
         kzVy4DMrffviUkxyN82HQd6qc+aD2D5DXoYytqmFgqPuBU36lJ8UYT0Lp2+foJOmCTdj
         /FOV+SzOPc/NNmXmnzOxg+Tu00zKDzNM+OaneAazQfJcH89uSvO8n2zqS1jWn7FbvKAo
         mKO1jmNvb9KaoVOOIcaFDrdgACTVcKjCD1T5qexjpl+p0UErRPtbAi2iyRL1JszvBY+9
         goJPCCB1WOHOR8xeaCZzwsZYz+OGhostpJLuTQg+MS/q4zI26H+PhmtOASj4urBvsqnf
         7N4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711629287; x=1712234087;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JZ0vv1wQnvryEwq3rhsZ/X7XAHDM6osgJBQ005R7xBw=;
        b=m1koy4G9Oxihc3Zt8qdcUV8LrfD27ZphfxwSnaUcMThNTP8K4Y/+6QiFlOJkErCMaL
         RhbCYl25SouPRV7nI0+I9cxH+7yyY/O6ukbn7nwE6sD4S+z3sBpy4tgZCgMFJd8Ovvqx
         uxt/+WIhJIQknCyAoouwvVV1grbp4SOI3+cTca4lT4hEMFESdnms+EcjFP/Xu5XR5Hsd
         DoIfZiJdva6cCyor4FSJWwJVoKLUTF1YP9PTDMpoLb5RhSERJ9SZ4zZQGZ/U7U1bxZjD
         RpkPt8IXQDkRzo4nhvvTZkz4ocb6/tWQCu65fN24ueFS+Wpt9LIEoTGTxXAhhgqxo5sn
         Uwyw==
X-Forwarded-Encrypted: i=1; AJvYcCV1nAI1jdaYuDjbclSU9ai2PiP6Q9cX66HeOr6xzgpCd5/D4P9qcsKIA1S3oMLzz+LqiExowPQt7zfESV2ZnnXRvjAWem1xyflgHFmv
X-Gm-Message-State: AOJu0YybbsMU/95ArapDBhKQd1OlHhxpLiT7lJ6xW3IfpOt8KUxpOwqw
	iklNkvIkjGSvvNrAJLqUEzk/KdKn2yhx5Ouh9I9U51IrU1e0OEwTpe4qmP/1i5Y=
X-Google-Smtp-Source: AGHT+IGFNHOP84yRVpbydpE4oIv0WdGd/p3WZ93Ua0lXB3ARSXpZbu2w0NOolGbkZr9E3N7yAevC1g==
X-Received: by 2002:a5d:64ef:0:b0:341:b846:9b5d with SMTP id g15-20020a5d64ef000000b00341b8469b5dmr2770700wri.52.1711629286962;
        Thu, 28 Mar 2024 05:34:46 -0700 (PDT)
Received: from ta2.c.googlers.com.com (158.100.79.34.bc.googleusercontent.com. [34.79.100.158])
        by smtp.gmail.com with ESMTPSA id u6-20020adfa186000000b00341e2146b53sm1639671wru.106.2024.03.28.05.34.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Mar 2024 05:34:46 -0700 (PDT)
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
Subject: [PATCH v3 3/3] clk: samsung: gs101: propagate PERIC0 USI SPI clock rate
Date: Thu, 28 Mar 2024 12:34:40 +0000
Message-ID: <20240328123440.1387823-4-tudor.ambarus@linaro.org>
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
Reviewed-by: Peter Griffin <peter.griffin@linaro.org>
Acked-by: André Draszik <andre.draszik@linaro.org>
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


