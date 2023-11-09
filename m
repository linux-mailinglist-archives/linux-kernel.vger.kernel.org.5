Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 842A97E71F6
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 20:09:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234664AbjKITJf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 14:09:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232252AbjKITJa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 14:09:30 -0500
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40DC73C19
        for <linux-kernel@vger.kernel.org>; Thu,  9 Nov 2023 11:09:28 -0800 (PST)
Received: by mail-oi1-x234.google.com with SMTP id 5614622812f47-3b3f55e1bbbso736515b6e.2
        for <linux-kernel@vger.kernel.org>; Thu, 09 Nov 2023 11:09:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1699556967; x=1700161767; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Cok/6QDcu01N4rxWO1B4I41pS5bLVYULNmU5fZjQBK4=;
        b=mhy2qw+11/jLASKVKP21FMVxpotsxmMbpj8wgqL7AcEhCOUYMdmUXf9wuRWNYtcxCX
         9ajXfyNdEJW5TPpkSUF5Y+V187A0SydtgqDskrEhkQx16AnfTKrD8INrOVzON8difWck
         D8C9Gcypn4BmxSpv5zUOERJqsXOkePEadvfwIIKdbjfF33BQcgAl1FfiA4cWl/+viHYQ
         vh0Zu67y4vA0CtdOY7B3JkS8gp1DDSrvMyjWc0GfBPj0VYlckG6QJwzotFK+qvm2rVUp
         H6FEcYqAyEcd5b/UO2VvfDP+/wddRNGWAsK5shQD+s/Aaf9TOQsG1Iui3DO86PM+C+ig
         qeVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699556967; x=1700161767;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Cok/6QDcu01N4rxWO1B4I41pS5bLVYULNmU5fZjQBK4=;
        b=UVNF/OFA52/ZtVJwkAdrDOSS+fM92HXi8LTKxwN6rKFG16YcGI2fx9H6hzBv2GggXC
         g3Ji3Ch52GUkfWjYue8KZPQPAvzyhX2sOPimVgq+1GXgi/HNTxOLsSt59YFROm7aG6hB
         qakhPLG6Yk/I2bZGUCcFGTyUb/sUV/5Kct/X9k10HWwl6G2U/Ihbmu1n4rNHErs3IvQm
         HSpO2j7rmBSch8dULohH+G0GI3F1Uh/wSH5YzLJLM5T99LTAZ9+A37l0cwVY2na9vJI/
         M8A3zC7pBsrvor0csk0elNOJsgIK+YvrzYeW6uJbzhPIr5X/hWZhJjqeHYpVfj/sqwsk
         9mHA==
X-Gm-Message-State: AOJu0YwnsE3qeCvzw0NKYEagL/x4/1KUtcT2IYlFPhp9xaJUYD/wJ4JP
        zWvEKgwz5ZxrK4Hh90857XtpMw==
X-Google-Smtp-Source: AGHT+IHbf7XzJO2IHLx0HE2HSmlzoxu0v7rycrHdx65CzgwvGhhsTn2pnu6/biWySCXxUjt1Xfp60g==
X-Received: by 2002:a05:6808:2e8a:b0:3b2:e3b5:b88 with SMTP id gt10-20020a0568082e8a00b003b2e3b50b88mr3016290oib.26.1699556967494;
        Thu, 09 Nov 2023 11:09:27 -0800 (PST)
Received: from localhost ([136.62.192.75])
        by smtp.gmail.com with ESMTPSA id bl35-20020a05680830a300b003a43759b9cdsm63456oib.29.2023.11.09.11.09.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Nov 2023 11:09:27 -0800 (PST)
From:   Sam Protsenko <semen.protsenko@linaro.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        Chanwoo Choi <cw00.choi@samsung.com>
Cc:     Alim Akhtar <alim.akhtar@samsung.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        linux-samsung-soc@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] clk: samsung: Improve kernel-doc comments
Date:   Thu,  9 Nov 2023 13:09:25 -0600
Message-Id: <20231109190925.2066-2-semen.protsenko@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231109190925.2066-1-semen.protsenko@linaro.org>
References: <20231109190925.2066-1-semen.protsenko@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Unify and improve the style of kernel-doc comments in Samsung CCF
framework. Resemble more idiomatic style described in [1] and commonly
used throughout most of the kernel code.

[1] Documentation/doc-guide/kernel-doc.rst

Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
---
 drivers/clk/samsung/clk-cpu.h |  30 +++----
 drivers/clk/samsung/clk.h     | 158 ++++++++++++++++++----------------
 2 files changed, 100 insertions(+), 88 deletions(-)

diff --git a/drivers/clk/samsung/clk-cpu.h b/drivers/clk/samsung/clk-cpu.h
index 103f64193e42..0164bd9ad021 100644
--- a/drivers/clk/samsung/clk-cpu.h
+++ b/drivers/clk/samsung/clk-cpu.h
@@ -11,10 +11,10 @@
 #include "clk.h"
 
 /**
- * struct exynos_cpuclk_cfg_data: config data to setup cpu clocks.
- * @prate: frequency of the primary parent clock (in KHz).
- * @div0: value to be programmed in the div_cpu0 register.
- * @div1: value to be programmed in the div_cpu1 register.
+ * struct exynos_cpuclk_cfg_data - config data to setup cpu clocks
+ * @prate: frequency of the primary parent clock (in KHz)
+ * @div0: value to be programmed in the div_cpu0 register
+ * @div1: value to be programmed in the div_cpu1 register
  *
  * This structure holds the divider configuration data for dividers in the CPU
  * clock domain. The parent frequency at which these divider values are valid is
@@ -29,17 +29,17 @@ struct exynos_cpuclk_cfg_data {
 };
 
 /**
- * struct exynos_cpuclk: information about clock supplied to a CPU core.
- * @hw:	handle between CCF and CPU clock.
- * @alt_parent: alternate parent clock to use when switching the speed
- *	of the primary parent clock.
- * @ctrl_base:	base address of the clock controller.
- * @lock: cpu clock domain register access lock.
- * @cfg: cpu clock rate configuration data.
- * @num_cfgs: number of array elements in @cfg array.
- * @clk_nb: clock notifier registered for changes in clock speed of the
- *	primary parent clock.
- * @flags: configuration flags for the CPU clock.
+ * struct exynos_cpuclk - information about clock supplied to a CPU core
+ * @hw:		handle between CCF and CPU clock
+ * @alt_parent:	alternate parent clock to use when switching the speed
+ *		of the primary parent clock
+ * @ctrl_base:	base address of the clock controller
+ * @lock:	cpu clock domain register access lock
+ * @cfg:	cpu clock rate configuration data
+ * @num_cfgs:	number of array elements in @cfg array
+ * @clk_nb:	clock notifier registered for changes in clock speed of the
+ *		primary parent clock
+ * @flags:	configuration flags for the CPU clock
  *
  * This structure holds information required for programming the CPU clock for
  * various clock speeds.
diff --git a/drivers/clk/samsung/clk.h b/drivers/clk/samsung/clk.h
index 4f17d5890a81..516b716407e5 100644
--- a/drivers/clk/samsung/clk.h
+++ b/drivers/clk/samsung/clk.h
@@ -14,11 +14,11 @@
 #include "clk-pll.h"
 
 /**
- * struct samsung_clk_provider: information about clock provider
- * @reg_base: virtual address for the register base.
- * @dev: clock provider device needed for runtime PM.
- * @lock: maintains exclusion between callbacks for a given clock-provider.
- * @clk_data: holds clock related data like clk_hw* and number of clocks.
+ * struct samsung_clk_provider - information about clock provider
+ * @reg_base: virtual address for the register base
+ * @dev: clock provider device needed for runtime PM
+ * @lock: maintains exclusion between callbacks for a given clock-provider
+ * @clk_data: holds clock related data like clk_hw* and number of clocks
  */
 struct samsung_clk_provider {
 	void __iomem *reg_base;
@@ -29,10 +29,10 @@ struct samsung_clk_provider {
 };
 
 /**
- * struct samsung_clock_alias: information about mux clock
- * @id: platform specific id of the clock.
- * @dev_name: name of the device to which this clock belongs.
- * @alias: optional clock alias name to be assigned to this clock.
+ * struct samsung_clock_alias - information about mux clock
+ * @id: platform specific id of the clock
+ * @dev_name: name of the device to which this clock belongs
+ * @alias: optional clock alias name to be assigned to this clock
  */
 struct samsung_clock_alias {
 	unsigned int		id;
@@ -50,12 +50,12 @@ struct samsung_clock_alias {
 #define MHZ (1000 * 1000)
 
 /**
- * struct samsung_fixed_rate_clock: information about fixed-rate clock
- * @id: platform specific id of the clock.
- * @name: name of this fixed-rate clock.
- * @parent_name: optional parent clock name.
- * @flags: optional fixed-rate clock flags.
- * @fixed_rate: fixed clock rate of this clock.
+ * struct samsung_fixed_rate_clock - information about fixed-rate clock
+ * @id: platform specific id of the clock
+ * @name: name of this fixed-rate clock
+ * @parent_name: optional parent clock name
+ * @flags: optional fixed-rate clock flags
+ * @fixed_rate: fixed clock rate of this clock
  */
 struct samsung_fixed_rate_clock {
 	unsigned int		id;
@@ -75,13 +75,13 @@ struct samsung_fixed_rate_clock {
 	}
 
 /**
- * struct samsung_fixed_factor_clock: information about fixed-factor clock
- * @id: platform specific id of the clock.
- * @name: name of this fixed-factor clock.
- * @parent_name: parent clock name.
- * @mult: fixed multiplication factor.
- * @div: fixed division factor.
- * @flags: optional fixed-factor clock flags.
+ * struct samsung_fixed_factor_clock - information about fixed-factor clock
+ * @id: platform specific id of the clock
+ * @name: name of this fixed-factor clock
+ * @parent_name: parent clock name
+ * @mult: fixed multiplication factor
+ * @div: fixed division factor
+ * @flags: optional fixed-factor clock flags
  */
 struct samsung_fixed_factor_clock {
 	unsigned int		id;
@@ -103,16 +103,16 @@ struct samsung_fixed_factor_clock {
 	}
 
 /**
- * struct samsung_mux_clock: information about mux clock
- * @id: platform specific id of the clock.
- * @name: name of this mux clock.
- * @parent_names: array of pointer to parent clock names.
- * @num_parents: number of parents listed in @parent_names.
- * @flags: optional flags for basic clock.
- * @offset: offset of the register for configuring the mux.
- * @shift: starting bit location of the mux control bit-field in @reg.
- * @width: width of the mux control bit-field in @reg.
- * @mux_flags: flags for mux-type clock.
+ * struct samsung_mux_clock - information about mux clock
+ * @id: platform specific id of the clock
+ * @name: name of this mux clock
+ * @parent_names: array of pointer to parent clock names
+ * @num_parents: number of parents listed in @parent_names
+ * @flags: optional flags for basic clock
+ * @offset: offset of the register for configuring the mux
+ * @shift: starting bit location of the mux control bit-field in @reg
+ * @width: width of the mux control bit-field in @reg
+ * @mux_flags: flags for mux-type clock
  */
 struct samsung_mux_clock {
 	unsigned int		id;
@@ -146,16 +146,16 @@ struct samsung_mux_clock {
 	__MUX(_id, cname, pnames, o, s, w, f, mf)
 
 /**
- * struct samsung_div_clock: information about div clock
- * @id: platform specific id of the clock.
- * @name: name of this div clock.
- * @parent_name: name of the parent clock.
- * @flags: optional flags for basic clock.
- * @offset: offset of the register for configuring the div.
- * @shift: starting bit location of the div control bit-field in @reg.
- * @width: width of the bitfield.
- * @div_flags: flags for div-type clock.
- * @table: array of divider/value pairs ending with a div set to 0.
+ * struct samsung_div_clock - information about div clock
+ * @id: platform specific id of the clock
+ * @name: name of this div clock
+ * @parent_name: name of the parent clock
+ * @flags: optional flags for basic clock
+ * @offset: offset of the register for configuring the div
+ * @shift: starting bit location of the div control bit-field in @reg
+ * @width: width of the bitfield
+ * @div_flags: flags for div-type clock
+ * @table: array of divider/value pairs ending with a div set to 0
  */
 struct samsung_div_clock {
 	unsigned int		id;
@@ -192,14 +192,14 @@ struct samsung_div_clock {
 	__DIV(_id, cname, pname, o, s, w, 0, 0, t)
 
 /**
- * struct samsung_gate_clock: information about gate clock
- * @id: platform specific id of the clock.
- * @name: name of this gate clock.
- * @parent_name: name of the parent clock.
- * @flags: optional flags for basic clock.
- * @offset: offset of the register for configuring the gate.
- * @bit_idx: bit index of the gate control bit-field in @reg.
- * @gate_flags: flags for gate-type clock.
+ * struct samsung_gate_clock - information about gate clock
+ * @id: platform specific id of the clock
+ * @name: name of this gate clock
+ * @parent_name: name of the parent clock
+ * @flags: optional flags for basic clock
+ * @offset: offset of the register for configuring the gate
+ * @bit_idx: bit index of the gate control bit-field in @reg
+ * @gate_flags: flags for gate-type clock
  */
 struct samsung_gate_clock {
 	unsigned int		id;
@@ -228,9 +228,9 @@ struct samsung_gate_clock {
 #define PNAME(x) static const char * const x[] __initconst
 
 /**
- * struct samsung_clk_reg_dump: register dump of clock controller registers.
- * @offset: clock register offset from the controller base address.
- * @value: the value to be register at offset.
+ * struct samsung_clk_reg_dump - register dump of clock controller registers
+ * @offset: clock register offset from the controller base address
+ * @value: the value to be register at offset
  */
 struct samsung_clk_reg_dump {
 	u32	offset;
@@ -238,15 +238,15 @@ struct samsung_clk_reg_dump {
 };
 
 /**
- * struct samsung_pll_clock: information about pll clock
- * @id: platform specific id of the clock.
- * @name: name of this pll clock.
- * @parent_name: name of the parent clock.
- * @flags: optional flags for basic clock.
- * @con_offset: offset of the register for configuring the PLL.
- * @lock_offset: offset of the register for locking the PLL.
- * @type: Type of PLL to be registered.
- * @rate_table: array of PLL settings for possible PLL rates.
+ * struct samsung_pll_clock - information about pll clock
+ * @id: platform specific id of the clock
+ * @name: name of this pll clock
+ * @parent_name: name of the parent clock
+ * @flags: optional flags for basic clock
+ * @con_offset: offset of the register for configuring the PLL
+ * @lock_offset: offset of the register for locking the PLL
+ * @type: type of PLL to be registered
+ * @rate_table: array of PLL settings for possible PLL rates
  */
 struct samsung_pll_clock {
 	unsigned int		id;
@@ -305,39 +305,51 @@ struct samsung_clock_reg_cache {
 	unsigned int rsuspend_num;
 };
 
+/**
+ * struct samsung_cmu_info - all clocks information needed for CMU registration
+ * @pll_clks: list of PLL clocks
+ * @nr_pll_clks: count of clocks in @pll_clks
+ * @mux_clks: list of mux clocks
+ * @nr_mux_clks: count of clocks in @mux_clks
+ * @div_clks: list of div clocks
+ * @nr_div_clks: count of clocks in @div_clks
+ * @gate_clks: list of gate clocks
+ * @nr_gate_clks: count of clocks in @gate_clks
+ * @fixed_clks: list of fixed clocks
+ * @nr_fixed_clks: count clocks in @fixed_clks
+ * @fixed_factor_clks: list of fixed factor clocks
+ * @nr_fixed_factor_clks: count of clocks in @fixed_factor_clks
+ * @nr_clk_ids: total number of clocks with IDs assigned
+ * @cpu_clks: list of CPU clocks
+ * @nr_cpu_clks: count of clocks in @cpu_clks
+ * @clk_regs: list of clock registers
+ * @nr_clk_regs: count of clock registers in @clk_regs
+ * @suspend_regs: list of clock registers to set before suspend
+ * @nr_suspend_regs: count of clock registers in @suspend_regs
+ * @clk_name: name of the parent clock needed for CMU register access
+ */
 struct samsung_cmu_info {
-	/* list of pll clocks and respective count */
 	const struct samsung_pll_clock *pll_clks;
 	unsigned int nr_pll_clks;
-	/* list of mux clocks and respective count */
 	const struct samsung_mux_clock *mux_clks;
 	unsigned int nr_mux_clks;
-	/* list of div clocks and respective count */
 	const struct samsung_div_clock *div_clks;
 	unsigned int nr_div_clks;
-	/* list of gate clocks and respective count */
 	const struct samsung_gate_clock *gate_clks;
 	unsigned int nr_gate_clks;
-	/* list of fixed clocks and respective count */
 	const struct samsung_fixed_rate_clock *fixed_clks;
 	unsigned int nr_fixed_clks;
-	/* list of fixed factor clocks and respective count */
 	const struct samsung_fixed_factor_clock *fixed_factor_clks;
 	unsigned int nr_fixed_factor_clks;
-	/* total number of clocks with IDs assigned*/
 	unsigned int nr_clk_ids;
-	/* list of cpu clocks and respective count */
 	const struct samsung_cpu_clock *cpu_clks;
 	unsigned int nr_cpu_clks;
 
-	/* list and number of clocks registers */
 	const unsigned long *clk_regs;
 	unsigned int nr_clk_regs;
 
-	/* list and number of clocks registers to set before suspend */
 	const struct samsung_clk_reg_dump *suspend_regs;
 	unsigned int nr_suspend_regs;
-	/* name of the parent clock needed for CMU register access */
 	const char *clk_name;
 };
 
-- 
2.39.2

