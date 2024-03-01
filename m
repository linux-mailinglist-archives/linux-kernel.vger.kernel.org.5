Return-Path: <linux-kernel+bounces-87801-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9377686D935
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 02:52:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B9591B23D64
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 01:52:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E22C39AD3;
	Fri,  1 Mar 2024 01:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rtKtajJq"
Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com [209.85.160.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BC6A36118
	for <linux-kernel@vger.kernel.org>; Fri,  1 Mar 2024 01:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709257884; cv=none; b=cE7uFjxDj9xiz81p7BCcsDay4PHuCQcvQmJfvvRF1MC3nOaxReBbM8otejUFZm/yLUvWmqSFBKNA2ORGUeXm7XkL4mhbumk/uiZx54dhmlwUZSCa+yxsFAydQN9rVc6zPrKdPxpIq9g/ar7yATrk7z4IOd9tDKOH1YzJIRbkwtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709257884; c=relaxed/simple;
	bh=kl1t9Pc5DhqHnFPFJUPWMY+7F2IOQNkBqMT6NGsQgjE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=oboTzyQ4ZfJO+c75MoLKyS97WieuU++zjmSZ4c26+PBxwKJVdFRLR3pprMwA8sSdK3LcR6OuqwpxqyjvjGuTrV01MpX8Ybuh8A7OVOBCzr6u/k5u4A9WwS9mi5V2ltDt1mcT9kfdAPkIUrIj2pARgtF4cMf56Tv1m/yDzA+LOnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=rtKtajJq; arc=none smtp.client-ip=209.85.160.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-21f0c82e97fso905343fac.2
        for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 17:51:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709257880; x=1709862680; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4FAn42rOPbKVXnGoqf326mqcoB/ooi7OxKLSVKIg0FE=;
        b=rtKtajJqUm7KbpeKtlo4YzafgaF1xMsqmOPHb9oyvy5Qpp6HEZQqFeIZ7FYs1CodvJ
         0y5d6sg4TCjxmoKMoELiE6uCFVHiLV3cHDQf2IFPYNQL3jdGpdEBQLxhuvYKAqQ3qCjF
         tCnH4c3rMWtGg6ZE1MXed5dPQrZaP7ycvgMXjdlM+cH1RFaTVeXiPU+E9ejg5T4HQsUV
         9wSdaCOLx2ehYR1pwGugEKKCv90Vg70FAN9MO+OEAvGYSd6o9PVeEHdftS4gIoOEynEF
         dhZ/5yuSAQP4D0Uw7EdwbZDgQ+9q1KwLRUNqnk2BKffOBo9Aa9pUuASK9ORpNcbse5wR
         LsJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709257880; x=1709862680;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4FAn42rOPbKVXnGoqf326mqcoB/ooi7OxKLSVKIg0FE=;
        b=Tapen4EnbB6jSLCJwRvIfQKDEgaqaLO+YiiTOb3T5hUWggEomrfXvcYByr7Lvf6NTk
         fkjBQ1Pjuy1pj+Ed6JXtownAToUtH1EZU4xQZsl4QMxSsECEZ3UkpfzK9NflSNpqxvfX
         bE/2UL05AffVy9B6111UTMRo0uHK9GuTtTh6DxphP0l6dEvuQcdnpAZDuunpTYnWqAfC
         x7oG7YJ1sHvMo60Sik0UUl8scdQCgWK2hUNGD4X/8DX7xFILYgsYx4hfqV5CR0yuCyUZ
         IdenIwolJWzK12e645/GIJNwCD8p+EC77DmPYtHFlp6W2Sm0JVTtlxbDtbJb8BFmg8lf
         khqA==
X-Forwarded-Encrypted: i=1; AJvYcCVhe3pb4BCSUlYufx7JGFHOEwWyzkIz0KafMNqynpZsdbSeWgDrC5hiMShsCMe6Ocr/PYiyuNCVwxywklpogjvCtV6fXByDfP+ulxqM
X-Gm-Message-State: AOJu0Yy7e/y4TpG3YvbfvtoV5FjqvqeHaVQFnNX0Z9e2lWyjiK2H1eku
	Uoyucihd09WJhjL8L2GgKUmEaPbGI60FWruYX68SYw5VZqIchbmHycw+hSjnQb0=
X-Google-Smtp-Source: AGHT+IGlg9UdjnnW0qR5yoy5g9K7yb1q3stXEtjeaZn4ZJ9vhuute+o+iDm0qcQeVyTYgYOqmASN8Q==
X-Received: by 2002:a05:6871:a69e:b0:21e:8025:4aa7 with SMTP id wh30-20020a056871a69e00b0021e80254aa7mr297241oab.14.1709257880266;
        Thu, 29 Feb 2024 17:51:20 -0800 (PST)
Received: from localhost ([136.62.192.75])
        by smtp.gmail.com with ESMTPSA id gy22-20020a056870289600b00220a82352c9sm347524oab.17.2024.02.29.17.51.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Feb 2024 17:51:19 -0800 (PST)
From: Sam Protsenko <semen.protsenko@linaro.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Sylwester Nawrocki <s.nawrocki@samsung.com>,
	Chanwoo Choi <cw00.choi@samsung.com>,
	Alim Akhtar <alim.akhtar@samsung.com>,
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
Subject: [PATCH v4 2/3] clk: samsung: exynos850: Add CMU_CPUCL0 and CMU_CPUCL1
Date: Thu, 29 Feb 2024 19:51:17 -0600
Message-Id: <20240301015118.30072-2-semen.protsenko@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240301015118.30072-1-semen.protsenko@linaro.org>
References: <20240301015118.30072-1-semen.protsenko@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Implement support for CPU clock management units:
  - CMU_CPUCL0: clocks for cluster 0: 4 x Cortex-A55 (cpu0..cpu3)
  - CMU_CPUCL1: clocks for cluster 1: 4 x Cortex-A55 (cpu4..cpu7)

CPU PLLs are generating main CPU clocks for each cluster, and there are
alternate ("switch") clocks that can be used temporarily while
re-configuring the PLL for a new rate. ACLK, ATCLK, PCLKDBG and
PERIPHCLK clocks are driving corresponding buses. CLK_CLUSTERx_SCLK are
actual leaf CPU clocks and should be used to change CPU rates. Also some
CoreSight clocks can be derived from DBG_USER (debug clock).

PLL table was extracted from ECT table. ECT stands for "Exynos
Characteristic Table", it's a Samsung specific binary data populated by
BL2 bootloader in RAM at 0x90000000 address, containing PLL tables for
various CMUs and other hardware specific information.

The particular PLL type used in CMU_CPUCL0 and CMU_CPUCL1 (pll0822x) is
an integer PLL with middle FVCO. The equation to calculate its output
rate is:

    fout = fin * M / (P*2^S)

where:

    fin = 26 MHz (OSCCLK frequency)
    M = 64..1023
    P = 1..63
    S = 0..6

The PLL table tries to keep "P" value low to reduce the locking time,
which for pll0822x is "t = P * 150" (in OSCCLK cycles).

Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
---
Changes in v4:
  - none

Changes in v3:
  - none

Changes in v2:
  - none

 drivers/clk/samsung/clk-exynos850.c | 440 +++++++++++++++++++++++++++-
 1 file changed, 439 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/samsung/clk-exynos850.c b/drivers/clk/samsung/clk-exynos850.c
index 82cfa22c0788..6215471c4ac6 100644
--- a/drivers/clk/samsung/clk-exynos850.c
+++ b/drivers/clk/samsung/clk-exynos850.c
@@ -14,13 +14,16 @@
 #include <dt-bindings/clock/exynos850.h>
 
 #include "clk.h"
+#include "clk-cpu.h"
 #include "clk-exynos-arm64.h"
 
 /* NOTE: Must be equal to the last clock ID increased by one */
-#define CLKS_NR_TOP			(CLK_DOUT_G3D_SWITCH + 1)
+#define CLKS_NR_TOP			(CLK_DOUT_CPUCL1_SWITCH + 1)
 #define CLKS_NR_APM			(CLK_GOUT_SYSREG_APM_PCLK + 1)
 #define CLKS_NR_AUD			(CLK_GOUT_AUD_CMU_AUD_PCLK + 1)
 #define CLKS_NR_CMGP			(CLK_GOUT_SYSREG_CMGP_PCLK + 1)
+#define CLKS_NR_CPUCL0			(CLK_CLUSTER0_SCLK + 1)
+#define CLKS_NR_CPUCL1			(CLK_CLUSTER1_SCLK + 1)
 #define CLKS_NR_G3D			(CLK_GOUT_G3D_SYSREG_PCLK + 1)
 #define CLKS_NR_HSI			(CLK_GOUT_HSI_CMU_HSI_PCLK + 1)
 #define CLKS_NR_IS			(CLK_GOUT_IS_SYSREG_PCLK + 1)
@@ -47,6 +50,10 @@
 #define CLK_CON_MUX_MUX_CLKCMU_CORE_CCI		0x1018
 #define CLK_CON_MUX_MUX_CLKCMU_CORE_MMC_EMBD	0x101c
 #define CLK_CON_MUX_MUX_CLKCMU_CORE_SSS		0x1020
+#define CLK_CON_MUX_MUX_CLKCMU_CPUCL0_DBG	0x1024
+#define CLK_CON_MUX_MUX_CLKCMU_CPUCL0_SWITCH	0x1028
+#define CLK_CON_MUX_MUX_CLKCMU_CPUCL1_DBG	0x102c
+#define CLK_CON_MUX_MUX_CLKCMU_CPUCL1_SWITCH	0x1030
 #define CLK_CON_MUX_MUX_CLKCMU_DPU		0x1034
 #define CLK_CON_MUX_MUX_CLKCMU_G3D_SWITCH	0x1038
 #define CLK_CON_MUX_MUX_CLKCMU_HSI_BUS		0x103c
@@ -69,6 +76,10 @@
 #define CLK_CON_DIV_CLKCMU_CORE_CCI		0x1824
 #define CLK_CON_DIV_CLKCMU_CORE_MMC_EMBD	0x1828
 #define CLK_CON_DIV_CLKCMU_CORE_SSS		0x182c
+#define CLK_CON_DIV_CLKCMU_CPUCL0_DBG		0x1830
+#define CLK_CON_DIV_CLKCMU_CPUCL0_SWITCH	0x1834
+#define CLK_CON_DIV_CLKCMU_CPUCL1_DBG		0x1838
+#define CLK_CON_DIV_CLKCMU_CPUCL1_SWITCH	0x183c
 #define CLK_CON_DIV_CLKCMU_DPU			0x1840
 #define CLK_CON_DIV_CLKCMU_G3D_SWITCH		0x1844
 #define CLK_CON_DIV_CLKCMU_HSI_BUS		0x1848
@@ -97,6 +108,10 @@
 #define CLK_CON_GAT_GATE_CLKCMU_CORE_CCI	0x2020
 #define CLK_CON_GAT_GATE_CLKCMU_CORE_MMC_EMBD	0x2024
 #define CLK_CON_GAT_GATE_CLKCMU_CORE_SSS	0x2028
+#define CLK_CON_GAT_GATE_CLKCMU_CPUCL0_DBG	0x202c
+#define CLK_CON_GAT_GATE_CLKCMU_CPUCL0_SWITCH	0x2030
+#define CLK_CON_GAT_GATE_CLKCMU_CPUCL1_DBG	0x2034
+#define CLK_CON_GAT_GATE_CLKCMU_CPUCL1_SWITCH	0x2038
 #define CLK_CON_GAT_GATE_CLKCMU_DPU		0x203c
 #define CLK_CON_GAT_GATE_CLKCMU_G3D_SWITCH	0x2040
 #define CLK_CON_GAT_GATE_CLKCMU_HSI_BUS		0x2044
@@ -130,6 +145,10 @@ static const unsigned long top_clk_regs[] __initconst = {
 	CLK_CON_MUX_MUX_CLKCMU_CORE_CCI,
 	CLK_CON_MUX_MUX_CLKCMU_CORE_MMC_EMBD,
 	CLK_CON_MUX_MUX_CLKCMU_CORE_SSS,
+	CLK_CON_MUX_MUX_CLKCMU_CPUCL0_DBG,
+	CLK_CON_MUX_MUX_CLKCMU_CPUCL0_SWITCH,
+	CLK_CON_MUX_MUX_CLKCMU_CPUCL1_DBG,
+	CLK_CON_MUX_MUX_CLKCMU_CPUCL1_SWITCH,
 	CLK_CON_MUX_MUX_CLKCMU_DPU,
 	CLK_CON_MUX_MUX_CLKCMU_G3D_SWITCH,
 	CLK_CON_MUX_MUX_CLKCMU_HSI_BUS,
@@ -152,6 +171,10 @@ static const unsigned long top_clk_regs[] __initconst = {
 	CLK_CON_DIV_CLKCMU_CORE_CCI,
 	CLK_CON_DIV_CLKCMU_CORE_MMC_EMBD,
 	CLK_CON_DIV_CLKCMU_CORE_SSS,
+	CLK_CON_DIV_CLKCMU_CPUCL0_DBG,
+	CLK_CON_DIV_CLKCMU_CPUCL0_SWITCH,
+	CLK_CON_DIV_CLKCMU_CPUCL1_DBG,
+	CLK_CON_DIV_CLKCMU_CPUCL1_SWITCH,
 	CLK_CON_DIV_CLKCMU_DPU,
 	CLK_CON_DIV_CLKCMU_G3D_SWITCH,
 	CLK_CON_DIV_CLKCMU_HSI_BUS,
@@ -180,6 +203,10 @@ static const unsigned long top_clk_regs[] __initconst = {
 	CLK_CON_GAT_GATE_CLKCMU_CORE_CCI,
 	CLK_CON_GAT_GATE_CLKCMU_CORE_MMC_EMBD,
 	CLK_CON_GAT_GATE_CLKCMU_CORE_SSS,
+	CLK_CON_GAT_GATE_CLKCMU_CPUCL0_DBG,
+	CLK_CON_GAT_GATE_CLKCMU_CPUCL0_SWITCH,
+	CLK_CON_GAT_GATE_CLKCMU_CPUCL1_DBG,
+	CLK_CON_GAT_GATE_CLKCMU_CPUCL1_SWITCH,
 	CLK_CON_GAT_GATE_CLKCMU_DPU,
 	CLK_CON_GAT_GATE_CLKCMU_G3D_SWITCH,
 	CLK_CON_GAT_GATE_CLKCMU_HSI_BUS,
@@ -234,6 +261,14 @@ PNAME(mout_core_mmc_embd_p)	= { "oscclk", "dout_shared0_div2",
 				    "oscclk", "oscclk" };
 PNAME(mout_core_sss_p)		= { "dout_shared0_div3", "dout_shared1_div3",
 				    "dout_shared0_div4", "dout_shared1_div4" };
+/* List of parent clocks for Muxes in CMU_TOP: for CMU_CPUCL0 */
+PNAME(mout_cpucl0_switch_p)	= { "fout_shared0_pll", "fout_shared1_pll",
+				    "dout_shared0_div2", "dout_shared1_div2" };
+PNAME(mout_cpucl0_dbg_p)	= { "dout_shared0_div4", "dout_shared1_div4" };
+/* List of parent clocks for Muxes in CMU_TOP: for CMU_CPUCL1 */
+PNAME(mout_cpucl1_switch_p)	= { "fout_shared0_pll", "fout_shared1_pll",
+				    "dout_shared0_div2", "dout_shared1_div2" };
+PNAME(mout_cpucl1_dbg_p)	= { "dout_shared0_div4", "dout_shared1_div4" };
 /* List of parent clocks for Muxes in CMU_TOP: for CMU_G3D */
 PNAME(mout_g3d_switch_p)	= { "dout_shared0_div2", "dout_shared1_div2",
 				    "dout_shared0_div3", "dout_shared1_div3" };
@@ -300,6 +335,18 @@ static const struct samsung_mux_clock top_mux_clks[] __initconst = {
 	MUX(CLK_MOUT_CORE_SSS, "mout_core_sss", mout_core_sss_p,
 	    CLK_CON_MUX_MUX_CLKCMU_CORE_SSS, 0, 2),
 
+	/* CPUCL0 */
+	MUX(CLK_MOUT_CPUCL0_DBG, "mout_cpucl0_dbg", mout_cpucl0_dbg_p,
+	    CLK_CON_MUX_MUX_CLKCMU_CPUCL0_DBG, 0, 1),
+	MUX(CLK_MOUT_CPUCL0_SWITCH, "mout_cpucl0_switch", mout_cpucl0_switch_p,
+	    CLK_CON_MUX_MUX_CLKCMU_CPUCL0_SWITCH, 0, 2),
+
+	/* CPUCL1 */
+	MUX(CLK_MOUT_CPUCL1_DBG, "mout_cpucl1_dbg", mout_cpucl1_dbg_p,
+	    CLK_CON_MUX_MUX_CLKCMU_CPUCL1_DBG, 0, 1),
+	MUX(CLK_MOUT_CPUCL1_SWITCH, "mout_cpucl1_switch", mout_cpucl1_switch_p,
+	    CLK_CON_MUX_MUX_CLKCMU_CPUCL1_SWITCH, 0, 2),
+
 	/* DPU */
 	MUX(CLK_MOUT_DPU, "mout_dpu", mout_dpu_p,
 	    CLK_CON_MUX_MUX_CLKCMU_DPU, 0, 2),
@@ -378,6 +425,18 @@ static const struct samsung_div_clock top_div_clks[] __initconst = {
 	DIV(CLK_DOUT_CORE_SSS, "dout_core_sss", "gout_core_sss",
 	    CLK_CON_DIV_CLKCMU_CORE_SSS, 0, 4),
 
+	/* CPUCL0 */
+	DIV(CLK_DOUT_CPUCL0_DBG, "dout_cpucl0_dbg", "gout_cpucl0_dbg",
+	    CLK_CON_DIV_CLKCMU_CPUCL0_DBG, 0, 3),
+	DIV(CLK_DOUT_CPUCL0_SWITCH, "dout_cpucl0_switch", "gout_cpucl0_switch",
+	    CLK_CON_DIV_CLKCMU_CPUCL0_SWITCH, 0, 3),
+
+	/* CPUCL1 */
+	DIV(CLK_DOUT_CPUCL1_DBG, "dout_cpucl1_dbg", "gout_cpucl1_dbg",
+	    CLK_CON_DIV_CLKCMU_CPUCL1_DBG, 0, 3),
+	DIV(CLK_DOUT_CPUCL1_SWITCH, "dout_cpucl1_switch", "gout_cpucl1_switch",
+	    CLK_CON_DIV_CLKCMU_CPUCL1_SWITCH, 0, 3),
+
 	/* DPU */
 	DIV(CLK_DOUT_DPU, "dout_dpu", "gout_dpu",
 	    CLK_CON_DIV_CLKCMU_DPU, 0, 4),
@@ -442,6 +501,18 @@ static const struct samsung_gate_clock top_gate_clks[] __initconst = {
 	GATE(CLK_GOUT_AUD, "gout_aud", "mout_aud",
 	     CLK_CON_GAT_GATE_CLKCMU_AUD, 21, 0, 0),
 
+	/* CPUCL0 */
+	GATE(CLK_GOUT_CPUCL0_DBG, "gout_cpucl0_dbg", "mout_cpucl0_dbg",
+	     CLK_CON_GAT_GATE_CLKCMU_CPUCL0_DBG, 21, 0, 0),
+	GATE(CLK_GOUT_CPUCL0_SWITCH, "gout_cpucl0_switch", "mout_cpucl0_switch",
+	     CLK_CON_GAT_GATE_CLKCMU_CPUCL0_SWITCH, 21, 0, 0),
+
+	/* CPUCL1 */
+	GATE(CLK_GOUT_CPUCL1_DBG, "gout_cpucl1_dbg", "mout_cpucl1_dbg",
+	     CLK_CON_GAT_GATE_CLKCMU_CPUCL1_DBG, 21, 0, 0),
+	GATE(CLK_GOUT_CPUCL1_SWITCH, "gout_cpucl1_switch", "mout_cpucl1_switch",
+	     CLK_CON_GAT_GATE_CLKCMU_CPUCL1_SWITCH, 21, 0, 0),
+
 	/* DPU */
 	GATE(CLK_GOUT_DPU, "gout_dpu", "mout_dpu",
 	     CLK_CON_GAT_GATE_CLKCMU_DPU, 21, 0, 0),
@@ -1030,6 +1101,373 @@ static const struct samsung_cmu_info cmgp_cmu_info __initconst = {
 	.clk_name		= "gout_clkcmu_cmgp_bus",
 };
 
+/* ---- CMU_CPUCL0 ---------------------------------------------------------- */
+
+/* Register Offset definitions for CMU_CPUCL0 (0x10900000) */
+#define PLL_LOCKTIME_PLL_CPUCL0				0x0000
+#define PLL_CON0_PLL_CPUCL0				0x0100
+#define PLL_CON1_PLL_CPUCL0				0x0104
+#define PLL_CON3_PLL_CPUCL0				0x010c
+#define PLL_CON0_MUX_CLKCMU_CPUCL0_DBG_USER		0x0600
+#define PLL_CON0_MUX_CLKCMU_CPUCL0_SWITCH_USER		0x0610
+#define CLK_CON_MUX_MUX_CLK_CPUCL0_PLL			0x100c
+#define CLK_CON_DIV_DIV_CLK_CLUSTER0_ACLK		0x1800
+#define CLK_CON_DIV_DIV_CLK_CLUSTER0_ATCLK		0x1808
+#define CLK_CON_DIV_DIV_CLK_CLUSTER0_PCLKDBG		0x180c
+#define CLK_CON_DIV_DIV_CLK_CLUSTER0_PERIPHCLK		0x1810
+#define CLK_CON_DIV_DIV_CLK_CPUCL0_CMUREF		0x1814
+#define CLK_CON_DIV_DIV_CLK_CPUCL0_CPU			0x1818
+#define CLK_CON_DIV_DIV_CLK_CPUCL0_PCLK			0x181c
+#define CLK_CON_GAT_CLK_CPUCL0_CLUSTER0_ATCLK		0x2000
+#define CLK_CON_GAT_CLK_CPUCL0_CLUSTER0_PCLK		0x2004
+#define CLK_CON_GAT_CLK_CPUCL0_CLUSTER0_PERIPHCLK	0x2008
+#define CLK_CON_GAT_CLK_CPUCL0_CLUSTER0_SCLK		0x200c
+#define CLK_CON_GAT_CLK_CPUCL0_CMU_CPUCL0_PCLK		0x2010
+#define CLK_CON_GAT_GATE_CLK_CPUCL0_CPU			0x2020
+
+static const unsigned long cpucl0_clk_regs[] __initconst = {
+	PLL_LOCKTIME_PLL_CPUCL0,
+	PLL_CON0_PLL_CPUCL0,
+	PLL_CON1_PLL_CPUCL0,
+	PLL_CON3_PLL_CPUCL0,
+	PLL_CON0_MUX_CLKCMU_CPUCL0_DBG_USER,
+	PLL_CON0_MUX_CLKCMU_CPUCL0_SWITCH_USER,
+	CLK_CON_MUX_MUX_CLK_CPUCL0_PLL,
+	CLK_CON_DIV_DIV_CLK_CLUSTER0_ACLK,
+	CLK_CON_DIV_DIV_CLK_CLUSTER0_ATCLK,
+	CLK_CON_DIV_DIV_CLK_CLUSTER0_PCLKDBG,
+	CLK_CON_DIV_DIV_CLK_CLUSTER0_PERIPHCLK,
+	CLK_CON_DIV_DIV_CLK_CPUCL0_CMUREF,
+	CLK_CON_DIV_DIV_CLK_CPUCL0_CPU,
+	CLK_CON_DIV_DIV_CLK_CPUCL0_PCLK,
+	CLK_CON_GAT_CLK_CPUCL0_CLUSTER0_ATCLK,
+	CLK_CON_GAT_CLK_CPUCL0_CLUSTER0_PCLK,
+	CLK_CON_GAT_CLK_CPUCL0_CLUSTER0_PERIPHCLK,
+	CLK_CON_GAT_CLK_CPUCL0_CLUSTER0_SCLK,
+	CLK_CON_GAT_CLK_CPUCL0_CMU_CPUCL0_PCLK,
+	CLK_CON_GAT_GATE_CLK_CPUCL0_CPU,
+};
+
+/* List of parent clocks for Muxes in CMU_CPUCL0 */
+PNAME(mout_pll_cpucl0_p)		 = { "oscclk", "fout_cpucl0_pll" };
+PNAME(mout_cpucl0_switch_user_p)	 = { "oscclk", "dout_cpucl0_switch" };
+PNAME(mout_cpucl0_dbg_user_p)		 = { "oscclk", "dout_cpucl0_dbg" };
+PNAME(mout_cpucl0_pll_p)		 = { "mout_pll_cpucl0",
+					     "mout_cpucl0_switch_user" };
+
+static const struct samsung_pll_rate_table cpu_pll_rates[] __initconst = {
+	PLL_35XX_RATE(26 * MHZ, 2210000000U, 255, 3, 0),
+	PLL_35XX_RATE(26 * MHZ, 2106000000U, 243, 3, 0),
+	PLL_35XX_RATE(26 * MHZ, 2002000000U, 231, 3, 0),
+	PLL_35XX_RATE(26 * MHZ, 1846000000U, 213, 3, 0),
+	PLL_35XX_RATE(26 * MHZ, 1742000000U, 201, 3, 0),
+	PLL_35XX_RATE(26 * MHZ, 1586000000U, 183, 3, 0),
+	PLL_35XX_RATE(26 * MHZ, 1456000000U, 168, 3, 0),
+	PLL_35XX_RATE(26 * MHZ, 1300000000U, 150, 3, 0),
+	PLL_35XX_RATE(26 * MHZ, 1157000000U, 267, 3, 1),
+	PLL_35XX_RATE(26 * MHZ, 1053000000U, 243, 3, 1),
+	PLL_35XX_RATE(26 * MHZ, 949000000U,  219, 3, 1),
+	PLL_35XX_RATE(26 * MHZ, 806000000U,  186, 3, 1),
+	PLL_35XX_RATE(26 * MHZ, 650000000U,  150, 3, 1),
+	PLL_35XX_RATE(26 * MHZ, 546000000U,  252, 3, 2),
+	PLL_35XX_RATE(26 * MHZ, 442000000U,  204, 3, 2),
+	PLL_35XX_RATE(26 * MHZ, 351000000U,  162, 3, 2),
+	PLL_35XX_RATE(26 * MHZ, 247000000U,  114, 3, 2),
+	PLL_35XX_RATE(26 * MHZ, 182000000U,  168, 3, 3),
+	PLL_35XX_RATE(26 * MHZ, 130000000U,  120, 3, 3),
+};
+
+static const struct samsung_pll_clock cpucl0_pll_clks[] __initconst = {
+	PLL(pll_0822x, CLK_FOUT_CPUCL0_PLL, "fout_cpucl0_pll", "oscclk",
+	    PLL_LOCKTIME_PLL_CPUCL0, PLL_CON3_PLL_CPUCL0, cpu_pll_rates),
+};
+
+static const struct samsung_mux_clock cpucl0_mux_clks[] __initconst = {
+	MUX_F(CLK_MOUT_PLL_CPUCL0, "mout_pll_cpucl0", mout_pll_cpucl0_p,
+	      PLL_CON0_PLL_CPUCL0, 4, 1,
+	      CLK_SET_RATE_PARENT | CLK_RECALC_NEW_RATES, 0),
+	MUX_F(CLK_MOUT_CPUCL0_SWITCH_USER, "mout_cpucl0_switch_user",
+	      mout_cpucl0_switch_user_p,
+	      PLL_CON0_MUX_CLKCMU_CPUCL0_SWITCH_USER, 4, 1,
+	      CLK_SET_RATE_PARENT, 0),
+	MUX(CLK_MOUT_CPUCL0_DBG_USER, "mout_cpucl0_dbg_user",
+	    mout_cpucl0_dbg_user_p,
+	    PLL_CON0_MUX_CLKCMU_CPUCL0_DBG_USER, 4, 1),
+	MUX_F(CLK_MOUT_CPUCL0_PLL, "mout_cpucl0_pll", mout_cpucl0_pll_p,
+	      CLK_CON_MUX_MUX_CLK_CPUCL0_PLL, 0, 1, CLK_SET_RATE_PARENT, 0),
+};
+
+static const struct samsung_div_clock cpucl0_div_clks[] __initconst = {
+	DIV_F(CLK_DOUT_CPUCL0_CPU, "dout_cpucl0_cpu", "mout_cpucl0_pll",
+	      CLK_CON_DIV_DIV_CLK_CPUCL0_CPU, 0, 1,
+	      CLK_GET_RATE_NOCACHE, CLK_DIVIDER_READ_ONLY),
+	DIV_F(CLK_DOUT_CPUCL0_CMUREF, "dout_cpucl0_cmuref", "dout_cpucl0_cpu",
+	      CLK_CON_DIV_DIV_CLK_CPUCL0_CMUREF, 0, 3,
+	      CLK_GET_RATE_NOCACHE, CLK_DIVIDER_READ_ONLY),
+	DIV_F(CLK_DOUT_CPUCL0_PCLK, "dout_cpucl0_pclk", "dout_cpucl0_cpu",
+	      CLK_CON_DIV_DIV_CLK_CPUCL0_PCLK, 0, 4,
+	      CLK_GET_RATE_NOCACHE, CLK_DIVIDER_READ_ONLY),
+
+	/* EMBEDDED_CMU_CPUCL0 */
+	DIV_F(CLK_DOUT_CLUSTER0_ACLK, "dout_cluster0_aclk", "gout_cluster0_cpu",
+	      CLK_CON_DIV_DIV_CLK_CLUSTER0_ACLK, 0, 4,
+	      CLK_GET_RATE_NOCACHE, CLK_DIVIDER_READ_ONLY),
+	DIV_F(CLK_DOUT_CLUSTER0_ATCLK, "dout_cluster0_atclk",
+	      "gout_cluster0_cpu", CLK_CON_DIV_DIV_CLK_CLUSTER0_ATCLK, 0, 4,
+	      CLK_GET_RATE_NOCACHE, CLK_DIVIDER_READ_ONLY),
+	DIV_F(CLK_DOUT_CLUSTER0_PCLKDBG, "dout_cluster0_pclkdbg",
+	      "gout_cluster0_cpu", CLK_CON_DIV_DIV_CLK_CLUSTER0_PCLKDBG, 0, 4,
+	      CLK_GET_RATE_NOCACHE, CLK_DIVIDER_READ_ONLY),
+	DIV_F(CLK_DOUT_CLUSTER0_PERIPHCLK, "dout_cluster0_periphclk",
+	      "gout_cluster0_cpu", CLK_CON_DIV_DIV_CLK_CLUSTER0_PERIPHCLK, 0, 4,
+	      CLK_GET_RATE_NOCACHE, CLK_DIVIDER_READ_ONLY),
+};
+
+static const struct samsung_gate_clock cpucl0_gate_clks[] __initconst = {
+	GATE(CLK_GOUT_CPUCL0_CMU_CPUCL0_PCLK, "gout_cpucl0_cmu_cpucl0_pclk",
+	     "dout_cpucl0_pclk",
+	     CLK_CON_GAT_CLK_CPUCL0_CMU_CPUCL0_PCLK, 21, CLK_IGNORE_UNUSED, 0),
+
+	/* EMBEDDED_CMU_CPUCL0 */
+	GATE(CLK_GOUT_CLUSTER0_CPU, "gout_cluster0_cpu", "dout_cpucl0_cpu",
+	     CLK_CON_GAT_GATE_CLK_CPUCL0_CPU, 21, CLK_IGNORE_UNUSED, 0),
+	GATE(CLK_GOUT_CLUSTER0_SCLK, "gout_cluster0_sclk", "gout_cluster0_cpu",
+	     CLK_CON_GAT_CLK_CPUCL0_CLUSTER0_SCLK, 21, CLK_IGNORE_UNUSED, 0),
+	GATE(CLK_GOUT_CLUSTER0_ATCLK, "gout_cluster0_atclk",
+	     "dout_cluster0_atclk",
+	     CLK_CON_GAT_CLK_CPUCL0_CLUSTER0_ATCLK, 21, CLK_IGNORE_UNUSED, 0),
+	GATE(CLK_GOUT_CLUSTER0_PERIPHCLK, "gout_cluster0_periphclk",
+	     "dout_cluster0_periphclk",
+	     CLK_CON_GAT_CLK_CPUCL0_CLUSTER0_PERIPHCLK, 21,
+	     CLK_IGNORE_UNUSED, 0),
+	GATE(CLK_GOUT_CLUSTER0_PCLK, "gout_cluster0_pclk",
+	     "dout_cluster0_pclkdbg",
+	     CLK_CON_GAT_CLK_CPUCL0_CLUSTER0_PCLK, 21, CLK_IGNORE_UNUSED, 0),
+};
+
+/*
+ * Each parameter is going to be written into the corresponding DIV register. So
+ * the actual divider value for each parameter will be 1/(param+1). All these
+ * parameters must be in the range of 0..15, as the divider range for all of
+ * these DIV clocks is 1..16. The default values for these dividers is
+ * (1, 3, 3, 1).
+ */
+#define E850_CPU_DIV0(aclk, atclk, pclkdbg, periphclk) \
+	(((aclk) << 16) | ((atclk) << 12) | ((pclkdbg) << 8) | \
+	 ((periphclk) << 4))
+
+static const struct exynos_cpuclk_cfg_data exynos850_cluster_clk_d[] __initconst
+= {
+	{ 2210000, E850_CPU_DIV0(1, 3, 3, 1) },
+	{ 2106000, E850_CPU_DIV0(1, 3, 3, 1) },
+	{ 2002000, E850_CPU_DIV0(1, 3, 3, 1) },
+	{ 1846000, E850_CPU_DIV0(1, 3, 3, 1) },
+	{ 1742000, E850_CPU_DIV0(1, 3, 3, 1) },
+	{ 1586000, E850_CPU_DIV0(1, 3, 3, 1) },
+	{ 1456000, E850_CPU_DIV0(1, 3, 3, 1) },
+	{ 1300000, E850_CPU_DIV0(1, 3, 3, 1) },
+	{ 1157000, E850_CPU_DIV0(1, 3, 3, 1) },
+	{ 1053000, E850_CPU_DIV0(1, 3, 3, 1) },
+	{ 949000,  E850_CPU_DIV0(1, 3, 3, 1) },
+	{ 806000,  E850_CPU_DIV0(1, 3, 3, 1) },
+	{ 650000,  E850_CPU_DIV0(1, 3, 3, 1) },
+	{ 546000,  E850_CPU_DIV0(1, 3, 3, 1) },
+	{ 442000,  E850_CPU_DIV0(1, 3, 3, 1) },
+	{ 351000,  E850_CPU_DIV0(1, 3, 3, 1) },
+	{ 247000,  E850_CPU_DIV0(1, 3, 3, 1) },
+	{ 182000,  E850_CPU_DIV0(1, 3, 3, 1) },
+	{ 130000,  E850_CPU_DIV0(1, 3, 3, 1) },
+	{ 0 }
+};
+
+static const struct samsung_cpu_clock cpucl0_cpu_clks[] __initconst = {
+	CPU_CLK(CLK_CLUSTER0_SCLK, "cluster0_clk", CLK_MOUT_PLL_CPUCL0,
+		CLK_MOUT_CPUCL0_SWITCH_USER, 0, 0x0, CPUCLK_LAYOUT_E850_CL0,
+		exynos850_cluster_clk_d),
+};
+
+static const struct samsung_cmu_info cpucl0_cmu_info __initconst = {
+	.pll_clks		= cpucl0_pll_clks,
+	.nr_pll_clks		= ARRAY_SIZE(cpucl0_pll_clks),
+	.mux_clks		= cpucl0_mux_clks,
+	.nr_mux_clks		= ARRAY_SIZE(cpucl0_mux_clks),
+	.div_clks		= cpucl0_div_clks,
+	.nr_div_clks		= ARRAY_SIZE(cpucl0_div_clks),
+	.gate_clks		= cpucl0_gate_clks,
+	.nr_gate_clks		= ARRAY_SIZE(cpucl0_gate_clks),
+	.cpu_clks		= cpucl0_cpu_clks,
+	.nr_cpu_clks		= ARRAY_SIZE(cpucl0_cpu_clks),
+	.nr_clk_ids		= CLKS_NR_CPUCL0,
+	.clk_regs		= cpucl0_clk_regs,
+	.nr_clk_regs		= ARRAY_SIZE(cpucl0_clk_regs),
+	.clk_name		= "dout_cpucl0_switch",
+	.manual_plls		= true,
+};
+
+static void __init exynos850_cmu_cpucl0_init(struct device_node *np)
+{
+	exynos_arm64_register_cmu(NULL, np, &cpucl0_cmu_info);
+}
+
+/* Register CMU_CPUCL0 early, as CPU clocks should be available ASAP */
+CLK_OF_DECLARE(exynos850_cmu_cpucl0, "samsung,exynos850-cmu-cpucl0",
+	       exynos850_cmu_cpucl0_init);
+
+/* ---- CMU_CPUCL1 ---------------------------------------------------------- */
+
+/* Register Offset definitions for CMU_CPUCL1 (0x10800000) */
+#define PLL_LOCKTIME_PLL_CPUCL1				0x0000
+#define PLL_CON0_PLL_CPUCL1				0x0100
+#define PLL_CON1_PLL_CPUCL1				0x0104
+#define PLL_CON3_PLL_CPUCL1				0x010c
+#define PLL_CON0_MUX_CLKCMU_CPUCL1_DBG_USER		0x0600
+#define PLL_CON0_MUX_CLKCMU_CPUCL1_SWITCH_USER		0x0610
+#define CLK_CON_MUX_MUX_CLK_CPUCL1_PLL			0x1000
+#define CLK_CON_DIV_DIV_CLK_CLUSTER1_ACLK		0x1800
+#define CLK_CON_DIV_DIV_CLK_CLUSTER1_ATCLK		0x1808
+#define CLK_CON_DIV_DIV_CLK_CLUSTER1_PCLKDBG		0x180c
+#define CLK_CON_DIV_DIV_CLK_CLUSTER1_PERIPHCLK		0x1810
+#define CLK_CON_DIV_DIV_CLK_CPUCL1_CMUREF		0x1814
+#define CLK_CON_DIV_DIV_CLK_CPUCL1_CPU			0x1818
+#define CLK_CON_DIV_DIV_CLK_CPUCL1_PCLK			0x181c
+#define CLK_CON_GAT_CLK_CPUCL1_CLUSTER1_ATCLK		0x2000
+#define CLK_CON_GAT_CLK_CPUCL1_CLUSTER1_PCLK		0x2004
+#define CLK_CON_GAT_CLK_CPUCL1_CLUSTER1_PERIPHCLK	0x2008
+#define CLK_CON_GAT_CLK_CPUCL1_CLUSTER1_SCLK		0x200c
+#define CLK_CON_GAT_CLK_CPUCL1_CMU_CPUCL1_PCLK		0x2010
+#define CLK_CON_GAT_GATE_CLK_CPUCL1_CPU			0x2020
+
+static const unsigned long cpucl1_clk_regs[] __initconst = {
+	PLL_LOCKTIME_PLL_CPUCL1,
+	PLL_CON0_PLL_CPUCL1,
+	PLL_CON1_PLL_CPUCL1,
+	PLL_CON3_PLL_CPUCL1,
+	PLL_CON0_MUX_CLKCMU_CPUCL1_DBG_USER,
+	PLL_CON0_MUX_CLKCMU_CPUCL1_SWITCH_USER,
+	CLK_CON_MUX_MUX_CLK_CPUCL1_PLL,
+	CLK_CON_DIV_DIV_CLK_CLUSTER1_ACLK,
+	CLK_CON_DIV_DIV_CLK_CLUSTER1_ATCLK,
+	CLK_CON_DIV_DIV_CLK_CLUSTER1_PCLKDBG,
+	CLK_CON_DIV_DIV_CLK_CLUSTER1_PERIPHCLK,
+	CLK_CON_DIV_DIV_CLK_CPUCL1_CMUREF,
+	CLK_CON_DIV_DIV_CLK_CPUCL1_CPU,
+	CLK_CON_DIV_DIV_CLK_CPUCL1_PCLK,
+	CLK_CON_GAT_CLK_CPUCL1_CLUSTER1_ATCLK,
+	CLK_CON_GAT_CLK_CPUCL1_CLUSTER1_PCLK,
+	CLK_CON_GAT_CLK_CPUCL1_CLUSTER1_PERIPHCLK,
+	CLK_CON_GAT_CLK_CPUCL1_CLUSTER1_SCLK,
+	CLK_CON_GAT_CLK_CPUCL1_CMU_CPUCL1_PCLK,
+	CLK_CON_GAT_GATE_CLK_CPUCL1_CPU,
+};
+
+/* List of parent clocks for Muxes in CMU_CPUCL0 */
+PNAME(mout_pll_cpucl1_p)		 = { "oscclk", "fout_cpucl1_pll" };
+PNAME(mout_cpucl1_switch_user_p)	 = { "oscclk", "dout_cpucl1_switch" };
+PNAME(mout_cpucl1_dbg_user_p)		 = { "oscclk", "dout_cpucl1_dbg" };
+PNAME(mout_cpucl1_pll_p)		 = { "mout_pll_cpucl1",
+					     "mout_cpucl1_switch_user" };
+
+static const struct samsung_pll_clock cpucl1_pll_clks[] __initconst = {
+	PLL(pll_0822x, CLK_FOUT_CPUCL1_PLL, "fout_cpucl1_pll", "oscclk",
+	    PLL_LOCKTIME_PLL_CPUCL1, PLL_CON3_PLL_CPUCL1, cpu_pll_rates),
+};
+
+static const struct samsung_mux_clock cpucl1_mux_clks[] __initconst = {
+	MUX_F(CLK_MOUT_PLL_CPUCL1, "mout_pll_cpucl1", mout_pll_cpucl1_p,
+	      PLL_CON0_PLL_CPUCL1, 4, 1,
+	      CLK_SET_RATE_PARENT | CLK_RECALC_NEW_RATES, 0),
+	MUX_F(CLK_MOUT_CPUCL1_SWITCH_USER, "mout_cpucl1_switch_user",
+	      mout_cpucl1_switch_user_p,
+	      PLL_CON0_MUX_CLKCMU_CPUCL1_SWITCH_USER, 4, 1,
+	      CLK_SET_RATE_PARENT, 0),
+	MUX(CLK_MOUT_CPUCL1_DBG_USER, "mout_cpucl1_dbg_user",
+	    mout_cpucl1_dbg_user_p,
+	    PLL_CON0_MUX_CLKCMU_CPUCL1_DBG_USER, 4, 1),
+	MUX_F(CLK_MOUT_CPUCL1_PLL, "mout_cpucl1_pll", mout_cpucl1_pll_p,
+	      CLK_CON_MUX_MUX_CLK_CPUCL1_PLL, 0, 1, CLK_SET_RATE_PARENT, 0),
+};
+
+static const struct samsung_div_clock cpucl1_div_clks[] __initconst = {
+	DIV_F(CLK_DOUT_CPUCL1_CPU, "dout_cpucl1_cpu", "mout_cpucl1_pll",
+	      CLK_CON_DIV_DIV_CLK_CPUCL1_CPU, 0, 1,
+	      CLK_GET_RATE_NOCACHE, CLK_DIVIDER_READ_ONLY),
+	DIV_F(CLK_DOUT_CPUCL1_CMUREF, "dout_cpucl1_cmuref", "dout_cpucl1_cpu",
+	      CLK_CON_DIV_DIV_CLK_CPUCL1_CMUREF, 0, 3,
+	      CLK_GET_RATE_NOCACHE, CLK_DIVIDER_READ_ONLY),
+	DIV_F(CLK_DOUT_CPUCL1_PCLK, "dout_cpucl1_pclk", "dout_cpucl1_cpu",
+	      CLK_CON_DIV_DIV_CLK_CPUCL1_PCLK, 0, 4,
+	      CLK_GET_RATE_NOCACHE, CLK_DIVIDER_READ_ONLY),
+
+	/* EMBEDDED_CMU_CPUCL1 */
+	DIV_F(CLK_DOUT_CLUSTER1_ACLK, "dout_cluster1_aclk", "gout_cluster1_cpu",
+	      CLK_CON_DIV_DIV_CLK_CLUSTER1_ACLK, 0, 4,
+	      CLK_GET_RATE_NOCACHE, CLK_DIVIDER_READ_ONLY),
+	DIV_F(CLK_DOUT_CLUSTER1_ATCLK, "dout_cluster1_atclk",
+	      "gout_cluster1_cpu", CLK_CON_DIV_DIV_CLK_CLUSTER1_ATCLK, 0, 4,
+	      CLK_GET_RATE_NOCACHE, CLK_DIVIDER_READ_ONLY),
+	DIV_F(CLK_DOUT_CLUSTER1_PCLKDBG, "dout_cluster1_pclkdbg",
+	      "gout_cluster1_cpu", CLK_CON_DIV_DIV_CLK_CLUSTER1_PCLKDBG, 0, 4,
+	      CLK_GET_RATE_NOCACHE, CLK_DIVIDER_READ_ONLY),
+	DIV_F(CLK_DOUT_CLUSTER1_PERIPHCLK, "dout_cluster1_periphclk",
+	      "gout_cluster1_cpu", CLK_CON_DIV_DIV_CLK_CLUSTER1_PERIPHCLK, 0, 4,
+	      CLK_GET_RATE_NOCACHE, CLK_DIVIDER_READ_ONLY),
+};
+
+static const struct samsung_gate_clock cpucl1_gate_clks[] __initconst = {
+	GATE(CLK_GOUT_CPUCL1_CMU_CPUCL1_PCLK, "gout_cpucl1_cmu_cpucl1_pclk",
+	     "dout_cpucl1_pclk",
+	     CLK_CON_GAT_CLK_CPUCL1_CMU_CPUCL1_PCLK, 21, CLK_IGNORE_UNUSED, 0),
+
+	/* EMBEDDED_CMU_CPUCL1 */
+	GATE(CLK_GOUT_CLUSTER1_CPU, "gout_cluster1_cpu", "dout_cpucl1_cpu",
+	     CLK_CON_GAT_GATE_CLK_CPUCL1_CPU, 21, CLK_IGNORE_UNUSED, 0),
+	GATE(CLK_GOUT_CLUSTER1_SCLK, "gout_cluster1_sclk", "gout_cluster1_cpu",
+	     CLK_CON_GAT_CLK_CPUCL1_CLUSTER1_SCLK, 21, CLK_IGNORE_UNUSED, 0),
+	GATE(CLK_GOUT_CLUSTER1_ATCLK, "gout_cluster1_atclk",
+	     "dout_cluster1_atclk",
+	     CLK_CON_GAT_CLK_CPUCL1_CLUSTER1_ATCLK, 21, CLK_IGNORE_UNUSED, 0),
+	GATE(CLK_GOUT_CLUSTER1_PERIPHCLK, "gout_cluster1_periphclk",
+	     "dout_cluster1_periphclk",
+	     CLK_CON_GAT_CLK_CPUCL1_CLUSTER1_PERIPHCLK, 21,
+	     CLK_IGNORE_UNUSED, 0),
+	GATE(CLK_GOUT_CLUSTER1_PCLK, "gout_cluster1_pclk",
+	     "dout_cluster1_pclkdbg",
+	     CLK_CON_GAT_CLK_CPUCL1_CLUSTER1_PCLK, 21, CLK_IGNORE_UNUSED, 0),
+};
+
+static const struct samsung_cpu_clock cpucl1_cpu_clks[] __initconst = {
+	CPU_CLK(CLK_CLUSTER1_SCLK, "cluster1_clk", CLK_MOUT_PLL_CPUCL1,
+		CLK_MOUT_CPUCL1_SWITCH_USER, 0, 0x0, CPUCLK_LAYOUT_E850_CL1,
+		exynos850_cluster_clk_d),
+};
+
+static const struct samsung_cmu_info cpucl1_cmu_info __initconst = {
+	.pll_clks		= cpucl1_pll_clks,
+	.nr_pll_clks		= ARRAY_SIZE(cpucl1_pll_clks),
+	.mux_clks		= cpucl1_mux_clks,
+	.nr_mux_clks		= ARRAY_SIZE(cpucl1_mux_clks),
+	.div_clks		= cpucl1_div_clks,
+	.nr_div_clks		= ARRAY_SIZE(cpucl1_div_clks),
+	.gate_clks		= cpucl1_gate_clks,
+	.nr_gate_clks		= ARRAY_SIZE(cpucl1_gate_clks),
+	.cpu_clks		= cpucl1_cpu_clks,
+	.nr_cpu_clks		= ARRAY_SIZE(cpucl1_cpu_clks),
+	.nr_clk_ids		= CLKS_NR_CPUCL1,
+	.clk_regs		= cpucl1_clk_regs,
+	.nr_clk_regs		= ARRAY_SIZE(cpucl1_clk_regs),
+	.clk_name		= "dout_cpucl1_switch",
+	.manual_plls		= true,
+};
+
+static void __init exynos850_cmu_cpucl1_init(struct device_node *np)
+{
+	exynos_arm64_register_cmu(NULL, np, &cpucl1_cmu_info);
+}
+
+/* Register CMU_CPUCL1 early, as CPU clocks should be available ASAP */
+CLK_OF_DECLARE(exynos850_cmu_cpucl1, "samsung,exynos850-cmu-cpucl1",
+	       exynos850_cmu_cpucl1_init);
+
 /* ---- CMU_G3D ------------------------------------------------------------- */
 
 /* Register Offset definitions for CMU_G3D (0x11400000) */
-- 
2.39.2


