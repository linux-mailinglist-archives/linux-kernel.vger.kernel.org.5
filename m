Return-Path: <linux-kernel+bounces-43214-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 101C9841104
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 18:43:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7BA9C1F2305F
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 17:43:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C92FA157E65;
	Mon, 29 Jan 2024 17:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EequLv23"
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 255723F9D2
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 17:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706550126; cv=none; b=eSVbenF2zh2ywRUZhdmzZTbA9d5b8jy0fAilyMT7tB/q3iM6RUPtleY/UumIznpICP2qIh5YKHlXnMKA2nVEGOQlVcbDsJ/bHWGfBVOcJBBBm7KcS/M8ykYhYQW9Gj/mzUm4umZork+eq/v28uNafBVw7xKbr9lZbL4OD5cedHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706550126; c=relaxed/simple;
	bh=MzKqQYAf4J7xFt58g7FEQavapmIFYk/oe/opxrAwtP0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YMWViCKHGBUFrpBSqf/iB4PJpai6UH1Apv2FJ3Gtfdy+etV0yi0ddzoB9NgWTgGeHjkAwpSxooeV71S+Kqj22+gJXHXy4Im3s3Vy55kQNjvkzme3b8oUlITc4lPyOQGMTD5PN0HxhmZiQfRdbmjjQ92DpuLoroP6MLiixNLeUGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=EequLv23; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a30f7c9574eso321363666b.0
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 09:42:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706550121; x=1707154921; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4kFvvb7KxMiCW3NkmMA30eEaA0xbCDfQtJlmVVydMYo=;
        b=EequLv23Hx1BdNEbkWkueUTpxj0eSuHhvzU1MbqTGjdu+wB0z9uSkHzES8f1oiakv1
         CwG7dbxh/A6jyLoz8kfHC+kVQPGw1pyuzy7Capuv5jPVQnnYqvnt6tlQGZRWJ+AmB/d7
         GE+uJDDFxdhp6Fej/oWa6iIWk0unpLfR3m8NP/C8UPG88MGelneDJl3ZIM4e7nVwMdFb
         KjjonmRzFWx6bUmvTZe1+DM9qAgPLoQlnDc4qvIQN2j1omkXkQkooy6LOOow7XRfmHAZ
         RQWOqE727OhNvpPa4s9JeKm9EIAZYzULybyJmYWBpyllFhdadUw90Xcmw0KMUvrkPfUe
         UWTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706550121; x=1707154921;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4kFvvb7KxMiCW3NkmMA30eEaA0xbCDfQtJlmVVydMYo=;
        b=aF4DRXI5uzITYJxlP806bMR45pyhKV/GmAQierkWDtmVhMtynq0rIAFcesfzhLYRYR
         uTzKsHHU3Z+FRLTbjAzRnRKtGW2O1RjyEKwcP4WXdnz+7MQG38RzO842FKQacMsnY08y
         w+3w0vfu5Pg4wIVX9grkFNx/jsM6urzWhBBpmOwqkRSTxTEjcaVz5f91M5Qf/j9SJOkW
         60yUflBm58ztEiQUdUSOpTMiKJ2oQGHuzHpDPJZnnxMWRm3ZTz8muFAdALTzHISRYlaL
         9TPY1RsfvnlOfW4X7zvdGBhI2BfslbMYqjyj8IjSB2Ph51LauQDunqNOPb4yD4dqRTeG
         oRBg==
X-Gm-Message-State: AOJu0Yzm/BeQkOaJt86B9YNIz42jC1d3Q2OENIci2KFWen25DBr7M39u
	laJahLkIanT68dtX1wTKpObNre96JD+pIZAAg3/nsVzCOohCG2jeA2V+F3y2Uq0=
X-Google-Smtp-Source: AGHT+IFZTgHXgMpNaiKZwF6iRp8Pkb7whw4mhSi61h9pIv7MUwgR0vUGQviRcQQ3A//4UGSAZgiSIg==
X-Received: by 2002:a17:906:f14f:b0:a35:ee95:7e69 with SMTP id gw15-20020a170906f14f00b00a35ee957e69mr1273474ejb.28.1706550121177;
        Mon, 29 Jan 2024 09:42:01 -0800 (PST)
Received: from puffmais.c.googlers.com.com (94.189.141.34.bc.googleusercontent.com. [34.141.189.94])
        by smtp.gmail.com with ESMTPSA id qx25-20020a170906fcd900b00a311a360433sm4237765ejb.143.2024.01.29.09.42.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jan 2024 09:42:00 -0800 (PST)
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
	inux-kernel@vger.kernel.org,
	alim.akhtar@samsung.com,
	s.nawrocki@samsung.com,
	tomasz.figa@gmail.com,
	cw00.choi@samsung.com,
	linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org,
	linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: [PATCH v2 3/7] clk: samsung: gs101: add support for cmu_peric1
Date: Mon, 29 Jan 2024 17:40:06 +0000
Message-ID: <20240129174151.1174248-4-andre.draszik@linaro.org>
X-Mailer: git-send-email 2.43.0.429.g432eaa2c6b-goog
In-Reply-To: <20240129174151.1174248-1-andre.draszik@linaro.org>
References: <20240129174151.1174248-1-andre.draszik@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

CMU_PERIC1 is the clock management unit used for the peric1 block which
is used for additional USI, I3C and PWM interfaces/busses. Add support
for muxes, dividers and gates of cmu_peric1, except for
CLK_GOUT_PERIC1_IP which isn't well described in the datasheet and
which downstream also ignores (similar to cmu_peric0).

Two clocks have been marked as CLK_IS_CRITICAL for the following
reason:
    * disabling them makes it impossible to access any peric1
      registers, (including those two registers).
    * disabling gout_peric1_lhm_axi_p_peric1_i_clk sometimes has the
      additional effect of making the whole system unresponsive.

One clock marked as CLK_IGNORE_UNUSED needs to be kept on until we have
updated the respective driver for the following reason:
    * gout_peric1_gpio_peric1_pclk is required by the pinctrl
      configuration. With this clock disabled, reconfiguring the pins
      (for USI/I2C, USI/UART) will hang during register access.
      Since pinctrl-samsung doesn't support a clock at the moment, we
      just keep the kernel from disabling it at boot, until we have an
      update for pinctrl-samsung, at which point we'll drop the flag.

Signed-off-by: André Draszik <andre.draszik@linaro.org>
Reviewed-by: Sam Protsenko <semen.protsenko@linaro.org>
Reviewed-by: Peter Griffin <peter.griffin@linaro.org>

---
v2:
* fix typo pingctrl -> pinctrl in commit message
* merge patch #9 from original series version 1 into this patch, i.e.
drop temporary CLK_IGNORE_UNUSED of gout_peric1_sysreg_peric1_pclk and
remove explanation why this was done in the first place from commit
message
* collect Reviewed-by: tags

Note for future reference: To ensure consistent naming throughout this
driver, the clock names have been derived from the data sheet using the
following, with the expectation for all future additions to this file
to use the same:
    sed \
        -e 's|^PLL_LOCKTIME_PLL_\([^_]\+\)|fout_\L\1_pll|' \
        \
        -e 's|^PLL_CON0_MUX_CLKCMU_\([^_]\+\)_\(.*\)|mout_\L\1_\2|' \
        -e 's|^PLL_CON0_PLL_\(.*\)|mout_pll_\L\1|' \
        -e 's|^CLK_CON_MUX_MUX_CLK_\(.*\)|mout_\L\1|' \
        -e '/^PLL_CON[1-4]_[^_]\+_/d' \
        -e '/^[^_]\+_CMU_[^_]\+_CONTROLLER_OPTION/d' \
        -e '/^CLKOUT_CON_BLK_[^_]\+_CMU_[^_]\+_CLKOUT0/d' \
        \
        -e 's|_IPCLKPORT||' \
        -e 's|_RSTNSYNC||' \
        \
        -e 's|^CLK_CON_DIV_DIV_CLK_\([^_]\+\)_\(.*\)|dout_\L\1_\2|' \
        \
        -e 's|^CLK_CON_BUF_CLKBUF_\([^_]\+\)_\(.*\)|gout_\L\1_\2|' \
        -e 's|^CLK_CON_GAT_CLK_BLK_\([^_]\+\)_UID_\(.*\)|gout_\L\1_\2|' \
        -e 's|^gout_[^_]\+_[^_]\+_cmu_\([^_]\+\)_pclk$|gout_\1_\1_pclk|' \
        -e 's|^CLK_CON_GAT_GOUT_BLK_\([^_]\+\)_UID_\(.*\)|gout_\L\1_\2|' \
        -e 's|^CLK_CON_GAT_CLK_\([^_]\+\)_\(.*\)|gout_\L\1_clk_\L\1_\2|' \
        \
        -e '/^\(DMYQCH\|PCH\|QCH\|QUEUE\)_/d'
---
 drivers/clk/samsung/clk-gs101.c | 346 ++++++++++++++++++++++++++++++++
 1 file changed, 346 insertions(+)

diff --git a/drivers/clk/samsung/clk-gs101.c b/drivers/clk/samsung/clk-gs101.c
index 27debbafdce4..d55ed64d0e29 100644
--- a/drivers/clk/samsung/clk-gs101.c
+++ b/drivers/clk/samsung/clk-gs101.c
@@ -21,6 +21,7 @@
 #define CLKS_NR_APM	(CLK_APM_PLL_DIV16_APM + 1)
 #define CLKS_NR_MISC	(CLK_GOUT_MISC_XIU_D_MISC_ACLK + 1)
 #define CLKS_NR_PERIC0	(CLK_GOUT_PERIC0_SYSREG_PERIC0_PCLK + 1)
+#define CLKS_NR_PERIC1	(CLK_GOUT_PERIC1_SYSREG_PERIC1_PCLK + 1)
 
 /* ---- CMU_TOP ------------------------------------------------------------- */
 
@@ -3066,6 +3067,348 @@ static const struct samsung_cmu_info peric0_cmu_info __initconst = {
 	.clk_name		= "bus",
 };
 
+/* ---- CMU_PERIC1 ---------------------------------------------------------- */
+
+/* Register Offset definitions for CMU_PERIC1 (0x10c00000) */
+#define PLL_CON0_MUX_CLKCMU_PERIC1_BUS_USER						0x0600
+#define PLL_CON1_MUX_CLKCMU_PERIC1_BUS_USER						0x0604
+#define PLL_CON0_MUX_CLKCMU_PERIC1_I3C_USER						0x0610
+#define PLL_CON1_MUX_CLKCMU_PERIC1_I3C_USER						0x0614
+#define PLL_CON0_MUX_CLKCMU_PERIC1_USI0_USI_USER					0x0620
+#define PLL_CON1_MUX_CLKCMU_PERIC1_USI0_USI_USER					0x0624
+#define PLL_CON0_MUX_CLKCMU_PERIC1_USI10_USI_USER					0x0630
+#define PLL_CON1_MUX_CLKCMU_PERIC1_USI10_USI_USER					0x0634
+#define PLL_CON0_MUX_CLKCMU_PERIC1_USI11_USI_USER					0x0640
+#define PLL_CON1_MUX_CLKCMU_PERIC1_USI11_USI_USER					0x0644
+#define PLL_CON0_MUX_CLKCMU_PERIC1_USI12_USI_USER					0x0650
+#define PLL_CON1_MUX_CLKCMU_PERIC1_USI12_USI_USER					0x0654
+#define PLL_CON0_MUX_CLKCMU_PERIC1_USI13_USI_USER					0x0660
+#define PLL_CON1_MUX_CLKCMU_PERIC1_USI13_USI_USER					0x0664
+#define PLL_CON0_MUX_CLKCMU_PERIC1_USI9_USI_USER					0x0670
+#define PLL_CON1_MUX_CLKCMU_PERIC1_USI9_USI_USER					0x0674
+#define PERIC1_CMU_PERIC1_CONTROLLER_OPTION						0x0800
+#define CLKOUT_CON_BLK_PERIC1_CMU_PERIC1_CLKOUT0					0x0810
+#define CLK_CON_DIV_DIV_CLK_PERIC1_I3C							0x1800
+#define CLK_CON_DIV_DIV_CLK_PERIC1_USI0_USI						0x1804
+#define CLK_CON_DIV_DIV_CLK_PERIC1_USI10_USI						0x1808
+#define CLK_CON_DIV_DIV_CLK_PERIC1_USI11_USI						0x180c
+#define CLK_CON_DIV_DIV_CLK_PERIC1_USI12_USI						0x1810
+#define CLK_CON_DIV_DIV_CLK_PERIC1_USI13_USI						0x1814
+#define CLK_CON_DIV_DIV_CLK_PERIC1_USI9_USI						0x1818
+#define CLK_CON_BUF_CLKBUF_PERIC1_IP							0x2000
+#define CLK_CON_GAT_CLK_BLK_PERIC1_UID_PERIC1_CMU_PERIC1_IPCLKPORT_PCLK			0x2004
+#define CLK_CON_GAT_CLK_BLK_PERIC1_UID_RSTNSYNC_CLK_PERIC1_I3C_IPCLKPORT_CLK		0x2008
+#define CLK_CON_GAT_CLK_BLK_PERIC1_UID_RSTNSYNC_CLK_PERIC1_OSCCLK_IPCLKPORT_CLK		0x200c
+#define CLK_CON_GAT_GOUT_BLK_PERIC1_UID_D_TZPC_PERIC1_IPCLKPORT_PCLK			0x2010
+#define CLK_CON_GAT_GOUT_BLK_PERIC1_UID_GPC_PERIC1_IPCLKPORT_PCLK			0x2014
+#define CLK_CON_GAT_GOUT_BLK_PERIC1_UID_GPIO_PERIC1_IPCLKPORT_PCLK			0x2018
+#define CLK_CON_GAT_GOUT_BLK_PERIC1_UID_LHM_AXI_P_PERIC1_IPCLKPORT_I_CLK		0x201c
+#define CLK_CON_GAT_GOUT_BLK_PERIC1_UID_PERIC1_TOP0_IPCLKPORT_IPCLK_1			0x2020
+#define CLK_CON_GAT_GOUT_BLK_PERIC1_UID_PERIC1_TOP0_IPCLKPORT_IPCLK_2			0x2024
+#define CLK_CON_GAT_GOUT_BLK_PERIC1_UID_PERIC1_TOP0_IPCLKPORT_IPCLK_3			0x2028
+#define CLK_CON_GAT_GOUT_BLK_PERIC1_UID_PERIC1_TOP0_IPCLKPORT_IPCLK_4			0x202c
+#define CLK_CON_GAT_GOUT_BLK_PERIC1_UID_PERIC1_TOP0_IPCLKPORT_IPCLK_5			0x2030
+#define CLK_CON_GAT_GOUT_BLK_PERIC1_UID_PERIC1_TOP0_IPCLKPORT_IPCLK_6			0x2034
+#define CLK_CON_GAT_GOUT_BLK_PERIC1_UID_PERIC1_TOP0_IPCLKPORT_IPCLK_8			0x2038
+#define CLK_CON_GAT_GOUT_BLK_PERIC1_UID_PERIC1_TOP0_IPCLKPORT_PCLK_1			0x203c
+#define CLK_CON_GAT_GOUT_BLK_PERIC1_UID_PERIC1_TOP0_IPCLKPORT_PCLK_15			0x2040
+#define CLK_CON_GAT_GOUT_BLK_PERIC1_UID_PERIC1_TOP0_IPCLKPORT_PCLK_2			0x2044
+#define CLK_CON_GAT_GOUT_BLK_PERIC1_UID_PERIC1_TOP0_IPCLKPORT_PCLK_3			0x2048
+#define CLK_CON_GAT_GOUT_BLK_PERIC1_UID_PERIC1_TOP0_IPCLKPORT_PCLK_4			0x204c
+#define CLK_CON_GAT_GOUT_BLK_PERIC1_UID_PERIC1_TOP0_IPCLKPORT_PCLK_5			0x2050
+#define CLK_CON_GAT_GOUT_BLK_PERIC1_UID_PERIC1_TOP0_IPCLKPORT_PCLK_6			0x2054
+#define CLK_CON_GAT_GOUT_BLK_PERIC1_UID_PERIC1_TOP0_IPCLKPORT_PCLK_8			0x2058
+#define CLK_CON_GAT_GOUT_BLK_PERIC1_UID_RSTNSYNC_CLK_PERIC1_BUSP_IPCLKPORT_CLK		0x205c
+#define CLK_CON_GAT_GOUT_BLK_PERIC1_UID_RSTNSYNC_CLK_PERIC1_USI0_USI_IPCLKPORT_CLK	0x2060
+#define CLK_CON_GAT_GOUT_BLK_PERIC1_UID_RSTNSYNC_CLK_PERIC1_USI10_USI_IPCLKPORT_CLK	0x2064
+#define CLK_CON_GAT_GOUT_BLK_PERIC1_UID_RSTNSYNC_CLK_PERIC1_USI11_USI_IPCLKPORT_CLK	0x2068
+#define CLK_CON_GAT_GOUT_BLK_PERIC1_UID_RSTNSYNC_CLK_PERIC1_USI12_USI_IPCLKPORT_CLK	0x206c
+#define CLK_CON_GAT_GOUT_BLK_PERIC1_UID_RSTNSYNC_CLK_PERIC1_USI13_USI_IPCLKPORT_CLK	0x2070
+#define CLK_CON_GAT_GOUT_BLK_PERIC1_UID_RSTNSYNC_CLK_PERIC1_USI9_USI_IPCLKPORT_CLK	0x2074
+#define CLK_CON_GAT_GOUT_BLK_PERIC1_UID_SYSREG_PERIC1_IPCLKPORT_PCLK			0x2078
+#define DMYQCH_CON_PERIC1_TOP0_QCH_S							0x3000
+#define PCH_CON_LHM_AXI_P_PERIC1_PCH							0x3004
+#define QCH_CON_D_TZPC_PERIC1_QCH							0x3008
+#define QCH_CON_GPC_PERIC1_QCH								0x300c
+#define QCH_CON_GPIO_PERIC1_QCH								0x3010
+#define QCH_CON_LHM_AXI_P_PERIC1_QCH							0x3014
+#define QCH_CON_PERIC1_CMU_PERIC1_QCH							0x3018
+#define QCH_CON_PERIC1_TOP0_QCH_I3C0							0x301c
+#define QCH_CON_PERIC1_TOP0_QCH_PWM							0x3020
+#define QCH_CON_PERIC1_TOP0_QCH_USI0_USI						0x3024
+#define QCH_CON_PERIC1_TOP0_QCH_USI10_USI						0x3028
+#define QCH_CON_PERIC1_TOP0_QCH_USI11_USI						0x302c
+#define QCH_CON_PERIC1_TOP0_QCH_USI12_USI						0x3030
+#define QCH_CON_PERIC1_TOP0_QCH_USI13_USI						0x3034
+#define QCH_CON_PERIC1_TOP0_QCH_USI9_USI						0x3038
+#define QCH_CON_SYSREG_PERIC1_QCH							0x303c
+#define QUEUE_CTRL_REG_BLK_PERIC1_CMU_PERIC1						0x3c00
+
+static const unsigned long peric1_clk_regs[] __initconst = {
+	PLL_CON0_MUX_CLKCMU_PERIC1_BUS_USER,
+	PLL_CON1_MUX_CLKCMU_PERIC1_BUS_USER,
+	PLL_CON0_MUX_CLKCMU_PERIC1_I3C_USER,
+	PLL_CON1_MUX_CLKCMU_PERIC1_I3C_USER,
+	PLL_CON0_MUX_CLKCMU_PERIC1_USI0_USI_USER,
+	PLL_CON1_MUX_CLKCMU_PERIC1_USI0_USI_USER,
+	PLL_CON0_MUX_CLKCMU_PERIC1_USI10_USI_USER,
+	PLL_CON1_MUX_CLKCMU_PERIC1_USI10_USI_USER,
+	PLL_CON0_MUX_CLKCMU_PERIC1_USI11_USI_USER,
+	PLL_CON1_MUX_CLKCMU_PERIC1_USI11_USI_USER,
+	PLL_CON0_MUX_CLKCMU_PERIC1_USI12_USI_USER,
+	PLL_CON1_MUX_CLKCMU_PERIC1_USI12_USI_USER,
+	PLL_CON0_MUX_CLKCMU_PERIC1_USI13_USI_USER,
+	PLL_CON1_MUX_CLKCMU_PERIC1_USI13_USI_USER,
+	PLL_CON0_MUX_CLKCMU_PERIC1_USI9_USI_USER,
+	PLL_CON1_MUX_CLKCMU_PERIC1_USI9_USI_USER,
+	PERIC1_CMU_PERIC1_CONTROLLER_OPTION,
+	CLKOUT_CON_BLK_PERIC1_CMU_PERIC1_CLKOUT0,
+	CLK_CON_DIV_DIV_CLK_PERIC1_I3C,
+	CLK_CON_DIV_DIV_CLK_PERIC1_USI0_USI,
+	CLK_CON_DIV_DIV_CLK_PERIC1_USI10_USI,
+	CLK_CON_DIV_DIV_CLK_PERIC1_USI11_USI,
+	CLK_CON_DIV_DIV_CLK_PERIC1_USI12_USI,
+	CLK_CON_DIV_DIV_CLK_PERIC1_USI13_USI,
+	CLK_CON_DIV_DIV_CLK_PERIC1_USI9_USI,
+	CLK_CON_BUF_CLKBUF_PERIC1_IP,
+	CLK_CON_GAT_CLK_BLK_PERIC1_UID_PERIC1_CMU_PERIC1_IPCLKPORT_PCLK,
+	CLK_CON_GAT_CLK_BLK_PERIC1_UID_RSTNSYNC_CLK_PERIC1_I3C_IPCLKPORT_CLK,
+	CLK_CON_GAT_CLK_BLK_PERIC1_UID_RSTNSYNC_CLK_PERIC1_OSCCLK_IPCLKPORT_CLK,
+	CLK_CON_GAT_GOUT_BLK_PERIC1_UID_D_TZPC_PERIC1_IPCLKPORT_PCLK,
+	CLK_CON_GAT_GOUT_BLK_PERIC1_UID_GPC_PERIC1_IPCLKPORT_PCLK,
+	CLK_CON_GAT_GOUT_BLK_PERIC1_UID_GPIO_PERIC1_IPCLKPORT_PCLK,
+	CLK_CON_GAT_GOUT_BLK_PERIC1_UID_LHM_AXI_P_PERIC1_IPCLKPORT_I_CLK,
+	CLK_CON_GAT_GOUT_BLK_PERIC1_UID_PERIC1_TOP0_IPCLKPORT_IPCLK_1,
+	CLK_CON_GAT_GOUT_BLK_PERIC1_UID_PERIC1_TOP0_IPCLKPORT_IPCLK_2,
+	CLK_CON_GAT_GOUT_BLK_PERIC1_UID_PERIC1_TOP0_IPCLKPORT_IPCLK_3,
+	CLK_CON_GAT_GOUT_BLK_PERIC1_UID_PERIC1_TOP0_IPCLKPORT_IPCLK_4,
+	CLK_CON_GAT_GOUT_BLK_PERIC1_UID_PERIC1_TOP0_IPCLKPORT_IPCLK_5,
+	CLK_CON_GAT_GOUT_BLK_PERIC1_UID_PERIC1_TOP0_IPCLKPORT_IPCLK_6,
+	CLK_CON_GAT_GOUT_BLK_PERIC1_UID_PERIC1_TOP0_IPCLKPORT_IPCLK_8,
+	CLK_CON_GAT_GOUT_BLK_PERIC1_UID_PERIC1_TOP0_IPCLKPORT_PCLK_1,
+	CLK_CON_GAT_GOUT_BLK_PERIC1_UID_PERIC1_TOP0_IPCLKPORT_PCLK_15,
+	CLK_CON_GAT_GOUT_BLK_PERIC1_UID_PERIC1_TOP0_IPCLKPORT_PCLK_2,
+	CLK_CON_GAT_GOUT_BLK_PERIC1_UID_PERIC1_TOP0_IPCLKPORT_PCLK_3,
+	CLK_CON_GAT_GOUT_BLK_PERIC1_UID_PERIC1_TOP0_IPCLKPORT_PCLK_4,
+	CLK_CON_GAT_GOUT_BLK_PERIC1_UID_PERIC1_TOP0_IPCLKPORT_PCLK_5,
+	CLK_CON_GAT_GOUT_BLK_PERIC1_UID_PERIC1_TOP0_IPCLKPORT_PCLK_6,
+	CLK_CON_GAT_GOUT_BLK_PERIC1_UID_PERIC1_TOP0_IPCLKPORT_PCLK_8,
+	CLK_CON_GAT_GOUT_BLK_PERIC1_UID_RSTNSYNC_CLK_PERIC1_BUSP_IPCLKPORT_CLK,
+	CLK_CON_GAT_GOUT_BLK_PERIC1_UID_RSTNSYNC_CLK_PERIC1_USI0_USI_IPCLKPORT_CLK,
+	CLK_CON_GAT_GOUT_BLK_PERIC1_UID_RSTNSYNC_CLK_PERIC1_USI10_USI_IPCLKPORT_CLK,
+	CLK_CON_GAT_GOUT_BLK_PERIC1_UID_RSTNSYNC_CLK_PERIC1_USI11_USI_IPCLKPORT_CLK,
+	CLK_CON_GAT_GOUT_BLK_PERIC1_UID_RSTNSYNC_CLK_PERIC1_USI12_USI_IPCLKPORT_CLK,
+	CLK_CON_GAT_GOUT_BLK_PERIC1_UID_RSTNSYNC_CLK_PERIC1_USI13_USI_IPCLKPORT_CLK,
+	CLK_CON_GAT_GOUT_BLK_PERIC1_UID_RSTNSYNC_CLK_PERIC1_USI9_USI_IPCLKPORT_CLK,
+	CLK_CON_GAT_GOUT_BLK_PERIC1_UID_SYSREG_PERIC1_IPCLKPORT_PCLK,
+	DMYQCH_CON_PERIC1_TOP0_QCH_S,
+	PCH_CON_LHM_AXI_P_PERIC1_PCH,
+	QCH_CON_D_TZPC_PERIC1_QCH,
+	QCH_CON_GPC_PERIC1_QCH,
+	QCH_CON_GPIO_PERIC1_QCH,
+	QCH_CON_LHM_AXI_P_PERIC1_QCH,
+	QCH_CON_PERIC1_CMU_PERIC1_QCH,
+	QCH_CON_PERIC1_TOP0_QCH_I3C0,
+	QCH_CON_PERIC1_TOP0_QCH_PWM,
+	QCH_CON_PERIC1_TOP0_QCH_USI0_USI,
+	QCH_CON_PERIC1_TOP0_QCH_USI10_USI,
+	QCH_CON_PERIC1_TOP0_QCH_USI11_USI,
+	QCH_CON_PERIC1_TOP0_QCH_USI12_USI,
+	QCH_CON_PERIC1_TOP0_QCH_USI13_USI,
+	QCH_CON_PERIC1_TOP0_QCH_USI9_USI,
+	QCH_CON_SYSREG_PERIC1_QCH,
+	QUEUE_CTRL_REG_BLK_PERIC1_CMU_PERIC1,
+};
+
+/* List of parent clocks for Muxes in CMU_PERIC1 */
+PNAME(mout_peric1_bus_user_p)		= { "oscclk", "dout_cmu_peric1_bus" };
+PNAME(mout_peric1_nonbususer_p)		= { "oscclk", "dout_cmu_peric1_ip" };
+
+static const struct samsung_mux_clock peric1_mux_clks[] __initconst = {
+	MUX(CLK_MOUT_PERIC1_BUS_USER, "mout_peric1_bus_user",
+	    mout_peric1_bus_user_p, PLL_CON0_MUX_CLKCMU_PERIC1_BUS_USER, 4, 1),
+	MUX(CLK_MOUT_PERIC1_I3C_USER,
+	    "mout_peric1_i3c_user", mout_peric1_nonbususer_p,
+	    PLL_CON0_MUX_CLKCMU_PERIC1_I3C_USER, 4, 1),
+	MUX(CLK_MOUT_PERIC1_USI0_USI_USER,
+	    "mout_peric1_usi0_usi_user", mout_peric1_nonbususer_p,
+	    PLL_CON0_MUX_CLKCMU_PERIC1_USI0_USI_USER, 4, 1),
+	MUX(CLK_MOUT_PERIC1_USI10_USI_USER,
+	    "mout_peric1_usi10_usi_user", mout_peric1_nonbususer_p,
+	    PLL_CON0_MUX_CLKCMU_PERIC1_USI10_USI_USER, 4, 1),
+	MUX(CLK_MOUT_PERIC1_USI11_USI_USER,
+	    "mout_peric1_usi11_usi_user", mout_peric1_nonbususer_p,
+	    PLL_CON0_MUX_CLKCMU_PERIC1_USI11_USI_USER, 4, 1),
+	MUX(CLK_MOUT_PERIC1_USI12_USI_USER,
+	    "mout_peric1_usi12_usi_user", mout_peric1_nonbususer_p,
+	    PLL_CON0_MUX_CLKCMU_PERIC1_USI12_USI_USER, 4, 1),
+	MUX(CLK_MOUT_PERIC1_USI13_USI_USER,
+	    "mout_peric1_usi13_usi_user", mout_peric1_nonbususer_p,
+	    PLL_CON0_MUX_CLKCMU_PERIC1_USI13_USI_USER, 4, 1),
+	MUX(CLK_MOUT_PERIC1_USI9_USI_USER,
+	    "mout_peric1_usi9_usi_user", mout_peric1_nonbususer_p,
+	    PLL_CON0_MUX_CLKCMU_PERIC1_USI9_USI_USER, 4, 1),
+};
+
+static const struct samsung_div_clock peric1_div_clks[] __initconst = {
+	DIV(CLK_DOUT_PERIC1_I3C, "dout_peric1_i3c", "mout_peric1_i3c_user",
+	    CLK_CON_DIV_DIV_CLK_PERIC1_I3C, 0, 4),
+	DIV(CLK_DOUT_PERIC1_USI0_USI,
+	    "dout_peric1_usi0_usi", "mout_peric1_usi0_usi_user",
+	    CLK_CON_DIV_DIV_CLK_PERIC1_USI0_USI, 0, 4),
+	DIV(CLK_DOUT_PERIC1_USI10_USI,
+	    "dout_peric1_usi10_usi", "mout_peric1_usi10_usi_user",
+	    CLK_CON_DIV_DIV_CLK_PERIC1_USI10_USI, 0, 4),
+	DIV(CLK_DOUT_PERIC1_USI11_USI,
+	    "dout_peric1_usi11_usi", "mout_peric1_usi11_usi_user",
+	    CLK_CON_DIV_DIV_CLK_PERIC1_USI11_USI, 0, 4),
+	DIV(CLK_DOUT_PERIC1_USI12_USI,
+	    "dout_peric1_usi12_usi", "mout_peric1_usi12_usi_user",
+	    CLK_CON_DIV_DIV_CLK_PERIC1_USI12_USI, 0, 4),
+	DIV(CLK_DOUT_PERIC1_USI13_USI,
+	    "dout_peric1_usi13_usi", "mout_peric1_usi13_usi_user",
+	    CLK_CON_DIV_DIV_CLK_PERIC1_USI13_USI, 0, 4),
+	DIV(CLK_DOUT_PERIC1_USI9_USI,
+	    "dout_peric1_usi9_usi", "mout_peric1_usi9_usi_user",
+	    CLK_CON_DIV_DIV_CLK_PERIC1_USI9_USI, 0, 4),
+};
+
+static const struct samsung_gate_clock peric1_gate_clks[] __initconst = {
+	GATE(CLK_GOUT_PERIC1_PCLK,
+	     "gout_peric1_peric1_pclk", "mout_peric1_bus_user",
+	     CLK_CON_GAT_CLK_BLK_PERIC1_UID_PERIC1_CMU_PERIC1_IPCLKPORT_PCLK,
+	     21, CLK_IS_CRITICAL, 0),
+	GATE(CLK_GOUT_PERIC1_CLK_PERIC1_I3C_CLK,
+	     "gout_peric1_clk_peric1_i3c_clk", "dout_peric1_i3c",
+	     CLK_CON_GAT_CLK_BLK_PERIC1_UID_RSTNSYNC_CLK_PERIC1_I3C_IPCLKPORT_CLK,
+	     21, 0, 0),
+	GATE(CLK_GOUT_PERIC1_CLK_PERIC1_OSCCLK_CLK,
+	     "gout_peric1_clk_peric1_oscclk_clk", "oscclk",
+	     CLK_CON_GAT_CLK_BLK_PERIC1_UID_RSTNSYNC_CLK_PERIC1_OSCCLK_IPCLKPORT_CLK,
+	     21, 0, 0),
+	GATE(CLK_GOUT_PERIC1_D_TZPC_PERIC1_PCLK,
+	     "gout_peric1_d_tzpc_peric1_pclk", "mout_peric1_bus_user",
+	     CLK_CON_GAT_GOUT_BLK_PERIC1_UID_D_TZPC_PERIC1_IPCLKPORT_PCLK,
+	     21, 0, 0),
+	GATE(CLK_GOUT_PERIC1_GPC_PERIC1_PCLK,
+	     "gout_peric1_gpc_peric1_pclk", "mout_peric1_bus_user",
+	     CLK_CON_GAT_GOUT_BLK_PERIC1_UID_GPC_PERIC1_IPCLKPORT_PCLK,
+	     21, 0, 0),
+	GATE(CLK_GOUT_PERIC1_GPIO_PERIC1_PCLK,
+	     "gout_peric1_gpio_peric1_pclk", "mout_peric1_bus_user",
+	     CLK_CON_GAT_GOUT_BLK_PERIC1_UID_GPIO_PERIC1_IPCLKPORT_PCLK,
+	     21, CLK_IGNORE_UNUSED, 0),
+	GATE(CLK_GOUT_PERIC1_LHM_AXI_P_PERIC1_I_CLK,
+	     "gout_peric1_lhm_axi_p_peric1_i_clk", "mout_peric1_bus_user",
+	     CLK_CON_GAT_GOUT_BLK_PERIC1_UID_LHM_AXI_P_PERIC1_IPCLKPORT_I_CLK,
+	     21, CLK_IS_CRITICAL, 0),
+	GATE(CLK_GOUT_PERIC1_PERIC1_TOP0_IPCLK_1,
+	     "gout_peric1_peric1_top0_ipclk_1", "dout_peric1_usi0_usi",
+	     CLK_CON_GAT_GOUT_BLK_PERIC1_UID_PERIC1_TOP0_IPCLKPORT_IPCLK_1,
+	     21, 0, 0),
+	GATE(CLK_GOUT_PERIC1_PERIC1_TOP0_IPCLK_2,
+	     "gout_peric1_peric1_top0_ipclk_2", "dout_peric1_usi9_usi",
+	     CLK_CON_GAT_GOUT_BLK_PERIC1_UID_PERIC1_TOP0_IPCLKPORT_IPCLK_2,
+	     21, 0, 0),
+	GATE(CLK_GOUT_PERIC1_PERIC1_TOP0_IPCLK_3,
+	     "gout_peric1_peric1_top0_ipclk_3", "dout_peric1_usi10_usi",
+	     CLK_CON_GAT_GOUT_BLK_PERIC1_UID_PERIC1_TOP0_IPCLKPORT_IPCLK_3,
+	     21, 0, 0),
+	GATE(CLK_GOUT_PERIC1_PERIC1_TOP0_IPCLK_4,
+	     "gout_peric1_peric1_top0_ipclk_4", "dout_peric1_usi11_usi",
+	     CLK_CON_GAT_GOUT_BLK_PERIC1_UID_PERIC1_TOP0_IPCLKPORT_IPCLK_4,
+	     21, 0, 0),
+	GATE(CLK_GOUT_PERIC1_PERIC1_TOP0_IPCLK_5,
+	     "gout_peric1_peric1_top0_ipclk_5", "dout_peric1_usi12_usi",
+	     CLK_CON_GAT_GOUT_BLK_PERIC1_UID_PERIC1_TOP0_IPCLKPORT_IPCLK_5,
+	     21, 0, 0),
+	GATE(CLK_GOUT_PERIC1_PERIC1_TOP0_IPCLK_6,
+	     "gout_peric1_peric1_top0_ipclk_6", "dout_peric1_usi13_usi",
+	     CLK_CON_GAT_GOUT_BLK_PERIC1_UID_PERIC1_TOP0_IPCLKPORT_IPCLK_6,
+	     21, 0, 0),
+	GATE(CLK_GOUT_PERIC1_PERIC1_TOP0_IPCLK_8,
+	     "gout_peric1_peric1_top0_ipclk_8", "dout_peric1_i3c",
+	     CLK_CON_GAT_GOUT_BLK_PERIC1_UID_PERIC1_TOP0_IPCLKPORT_IPCLK_8,
+	     21, 0, 0),
+	GATE(CLK_GOUT_PERIC1_PERIC1_TOP0_PCLK_1,
+	     "gout_peric1_peric1_top0_pclk_1", "mout_peric1_bus_user",
+	     CLK_CON_GAT_GOUT_BLK_PERIC1_UID_PERIC1_TOP0_IPCLKPORT_PCLK_1,
+	     21, 0, 0),
+	GATE(CLK_GOUT_PERIC1_PERIC1_TOP0_PCLK_15,
+	     "gout_peric1_peric1_top0_pclk_15", "mout_peric1_bus_user",
+	     CLK_CON_GAT_GOUT_BLK_PERIC1_UID_PERIC1_TOP0_IPCLKPORT_PCLK_15,
+	     21, 0, 0),
+	GATE(CLK_GOUT_PERIC1_PERIC1_TOP0_PCLK_2,
+	     "gout_peric1_peric1_top0_pclk_2", "mout_peric1_bus_user",
+	     CLK_CON_GAT_GOUT_BLK_PERIC1_UID_PERIC1_TOP0_IPCLKPORT_PCLK_2,
+	     21, 0, 0),
+	GATE(CLK_GOUT_PERIC1_PERIC1_TOP0_PCLK_3,
+	     "gout_peric1_peric1_top0_pclk_3", "mout_peric1_bus_user",
+	     CLK_CON_GAT_GOUT_BLK_PERIC1_UID_PERIC1_TOP0_IPCLKPORT_PCLK_3,
+	     21, 0, 0),
+	GATE(CLK_GOUT_PERIC1_PERIC1_TOP0_PCLK_4,
+	     "gout_peric1_peric1_top0_pclk_4", "mout_peric1_bus_user",
+	     CLK_CON_GAT_GOUT_BLK_PERIC1_UID_PERIC1_TOP0_IPCLKPORT_PCLK_4,
+	     21, 0, 0),
+	GATE(CLK_GOUT_PERIC1_PERIC1_TOP0_PCLK_5,
+	     "gout_peric1_peric1_top0_pclk_5", "mout_peric1_bus_user",
+	     CLK_CON_GAT_GOUT_BLK_PERIC1_UID_PERIC1_TOP0_IPCLKPORT_PCLK_5,
+	     21, 0, 0),
+	GATE(CLK_GOUT_PERIC1_PERIC1_TOP0_PCLK_6,
+	     "gout_peric1_peric1_top0_pclk_6", "mout_peric1_bus_user",
+	     CLK_CON_GAT_GOUT_BLK_PERIC1_UID_PERIC1_TOP0_IPCLKPORT_PCLK_6,
+	     21, 0, 0),
+	GATE(CLK_GOUT_PERIC1_PERIC1_TOP0_PCLK_8,
+	     "gout_peric1_peric1_top0_pclk_8", "mout_peric1_bus_user",
+	     CLK_CON_GAT_GOUT_BLK_PERIC1_UID_PERIC1_TOP0_IPCLKPORT_PCLK_8,
+	     21, 0, 0),
+	GATE(CLK_GOUT_PERIC1_CLK_PERIC1_BUSP_CLK,
+	     "gout_peric1_clk_peric1_busp_clk", "mout_peric1_bus_user",
+	     CLK_CON_GAT_GOUT_BLK_PERIC1_UID_RSTNSYNC_CLK_PERIC1_BUSP_IPCLKPORT_CLK,
+	     21, 0, 0),
+	GATE(CLK_GOUT_PERIC1_CLK_PERIC1_USI0_USI_CLK,
+	     "gout_peric1_clk_peric1_usi0_usi_clk", "dout_peric1_usi0_usi",
+	     CLK_CON_GAT_GOUT_BLK_PERIC1_UID_RSTNSYNC_CLK_PERIC1_USI0_USI_IPCLKPORT_CLK,
+	     21, 0, 0),
+	GATE(CLK_GOUT_PERIC1_CLK_PERIC1_USI10_USI_CLK,
+	     "gout_peric1_clk_peric1_usi10_usi_clk", "dout_peric1_usi10_usi",
+	     CLK_CON_GAT_GOUT_BLK_PERIC1_UID_RSTNSYNC_CLK_PERIC1_USI10_USI_IPCLKPORT_CLK,
+	     21, 0, 0),
+	GATE(CLK_GOUT_PERIC1_CLK_PERIC1_USI11_USI_CLK,
+	     "gout_peric1_clk_peric1_usi11_usi_clk", "dout_peric1_usi11_usi",
+	     CLK_CON_GAT_GOUT_BLK_PERIC1_UID_RSTNSYNC_CLK_PERIC1_USI11_USI_IPCLKPORT_CLK,
+	     21, 0, 0),
+	GATE(CLK_GOUT_PERIC1_CLK_PERIC1_USI12_USI_CLK,
+	     "gout_peric1_clk_peric1_usi12_usi_clk", "dout_peric1_usi12_usi",
+	     CLK_CON_GAT_GOUT_BLK_PERIC1_UID_RSTNSYNC_CLK_PERIC1_USI12_USI_IPCLKPORT_CLK,
+	     21, 0, 0),
+	GATE(CLK_GOUT_PERIC1_CLK_PERIC1_USI13_USI_CLK,
+	     "gout_peric1_clk_peric1_usi13_usi_clk", "dout_peric1_usi13_usi",
+	     CLK_CON_GAT_GOUT_BLK_PERIC1_UID_RSTNSYNC_CLK_PERIC1_USI13_USI_IPCLKPORT_CLK,
+	     21, 0, 0),
+	GATE(CLK_GOUT_PERIC1_CLK_PERIC1_USI9_USI_CLK,
+	     "gout_peric1_clk_peric1_usi9_usi_clk", "dout_peric1_usi9_usi",
+	     CLK_CON_GAT_GOUT_BLK_PERIC1_UID_RSTNSYNC_CLK_PERIC1_USI9_USI_IPCLKPORT_CLK,
+	     21, 0, 0),
+	GATE(CLK_GOUT_PERIC1_SYSREG_PERIC1_PCLK,
+	     "gout_peric1_sysreg_peric1_pclk", "mout_peric1_bus_user",
+	     CLK_CON_GAT_GOUT_BLK_PERIC1_UID_SYSREG_PERIC1_IPCLKPORT_PCLK,
+	     21, 0, 0),
+};
+
+static const struct samsung_cmu_info peric1_cmu_info __initconst = {
+	.mux_clks		= peric1_mux_clks,
+	.nr_mux_clks		= ARRAY_SIZE(peric1_mux_clks),
+	.div_clks		= peric1_div_clks,
+	.nr_div_clks		= ARRAY_SIZE(peric1_div_clks),
+	.gate_clks		= peric1_gate_clks,
+	.nr_gate_clks		= ARRAY_SIZE(peric1_gate_clks),
+	.nr_clk_ids		= CLKS_NR_PERIC1,
+	.clk_regs		= peric1_clk_regs,
+	.nr_clk_regs		= ARRAY_SIZE(peric1_clk_regs),
+	.clk_name		= "bus",
+};
+
 /* ---- platform_driver ----------------------------------------------------- */
 
 static int __init gs101_cmu_probe(struct platform_device *pdev)
@@ -3086,6 +3429,9 @@ static const struct of_device_id gs101_cmu_of_match[] = {
 	}, {
 		.compatible = "google,gs101-cmu-peric0",
 		.data = &peric0_cmu_info,
+	}, {
+		.compatible = "google,gs101-cmu-peric1",
+		.data = &peric1_cmu_info,
 	}, {
 	},
 };
-- 
2.43.0.429.g432eaa2c6b-goog


