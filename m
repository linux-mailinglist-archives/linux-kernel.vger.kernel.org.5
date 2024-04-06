Return-Path: <linux-kernel+bounces-133914-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 939D589AA9F
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Apr 2024 13:36:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DB4BBB21D38
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Apr 2024 11:36:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBC4F376E0;
	Sat,  6 Apr 2024 11:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GBDDrChk"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20209374CB
	for <linux-kernel@vger.kernel.org>; Sat,  6 Apr 2024 11:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712403327; cv=none; b=iOI1FN4FApQ8H9cJ77kZMS6G9fxwM34bJvREqtpubHJ1qH93UQuBu2xOKyB/gu3lDsGCJjQPi7JpA3kFaiy4YL532Wv9ha16QB0v2FZ1AbQh+Vq4i0K0m4/cvL1OMvynLnVprhRn2/T5aaHulv/3y/36MM2E+yZGoZrfFbik3g4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712403327; c=relaxed/simple;
	bh=R97Q2QZSx04EEg2PLja5HX11nqpX6+6Z/tNLhIWtFfk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZMmtgzcYrqr9dzT5WLZWIyAT0R/m/Rhl5fxfH3nZZJcE3AK1OQZVn68pEkuzmEsnHnh13RAI58941RayZDzA0V9xsXGVjbR4YpTZlAZYi+yiYJUIRGUaxtH8fme/kytfUAn+qhkLdw1VMrOeKPQyJl8fXvT7o4ptUYJmX3UsAeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GBDDrChk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DD54C433C7;
	Sat,  6 Apr 2024 11:35:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712403326;
	bh=R97Q2QZSx04EEg2PLja5HX11nqpX6+6Z/tNLhIWtFfk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GBDDrChk1RUq4DtnWONvFCFXv1lrG6pW0ZHR2l8oUKM0hzrs63WR0FLoz0PP9FwEB
	 fUzdWpR9hmpGQAl/Jc94fGxDJRBr6VNV9g/FVmcXpYcEjVHpXlBOKXGBf2KhgfNbwd
	 2mGvpKF/07K0hb1i2zLkobtmewHREGYShNg3IfLOUpYI5a0cwPfV0vSBgFg7CO3TLa
	 5E4HPquhMzxBoAxRlOvzr4A/pHviHN5HPHwaOzxeo1u4ihNyKjf/SNfxHiHEzklIf0
	 fUlWKp5vYZ9Pbh05QW2A/5xEY1ARe9jicwbtDx43kWjHuNqJnvti9S2skkgT5foVJG
	 +Ip4WtUlN8iZw==
From: Jisheng Zhang <jszhang@kernel.org>
To: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Samuel Holland <samuel.holland@sifive.com>
Cc: linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/3] clocksource/drivers/timer-clint: Add T-Head C9xx clint
Date: Sat,  6 Apr 2024 19:21:59 +0800
Message-ID: <20240406112159.1634-4-jszhang@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240406112159.1634-1-jszhang@kernel.org>
References: <20240406112159.1634-1-jszhang@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The mtimecmp in T-Head C9xx clint only supports 32bit read/write,
implement such support.

Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
---
 drivers/clocksource/timer-clint.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/drivers/clocksource/timer-clint.c b/drivers/clocksource/timer-clint.c
index 0d3890e00b75..655ea81071ff 100644
--- a/drivers/clocksource/timer-clint.c
+++ b/drivers/clocksource/timer-clint.c
@@ -39,6 +39,7 @@ static u64 __iomem *clint_timer_cmp;
 static u64 __iomem *clint_timer_val;
 static unsigned long clint_timer_freq;
 static unsigned int clint_timer_irq;
+static bool is_c900_clint;
 
 #ifdef CONFIG_RISCV_M_MODE
 u64 __iomem *clint_time_val;
@@ -135,6 +136,19 @@ static int clint_clock_shutdown(struct clock_event_device *evt)
 	return 0;
 }
 
+static int c900_clint_clock_next_event(unsigned long delta,
+				       struct clock_event_device *ce)
+{
+	void __iomem *r = clint_timer_cmp +
+			  cpuid_to_hartid_map(smp_processor_id());
+	u64 val = clint_get_cycles64() + delta;
+
+	csr_set(CSR_IE, IE_TIE);
+	writel_relaxed(val, r);
+	writel_relaxed(val >> 32, r + 4);
+	return 0;
+}
+
 static DEFINE_PER_CPU(struct clock_event_device, clint_clock_event) = {
 	.name				= "clint_clockevent",
 	.features			= CLOCK_EVT_FEAT_ONESHOT,
@@ -148,6 +162,9 @@ static int clint_timer_starting_cpu(unsigned int cpu)
 {
 	struct clock_event_device *ce = per_cpu_ptr(&clint_clock_event, cpu);
 
+	if (is_c900_clint)
+		ce->set_next_event = c900_clint_clock_next_event;
+
 	ce->cpumask = cpumask_of(cpu);
 	clockevents_config_and_register(ce, clint_timer_freq, 100, ULONG_MAX);
 
@@ -291,5 +308,12 @@ static int __init clint_timer_init_dt(struct device_node *np)
 	return rc;
 }
 
+static int __init c900_clint_timer_init_dt(struct device_node *np)
+{
+	is_c900_clint = true;
+	return clint_timer_init_dt(np);
+}
+
 TIMER_OF_DECLARE(clint_timer, "riscv,clint0", clint_timer_init_dt);
 TIMER_OF_DECLARE(clint_timer1, "sifive,clint0", clint_timer_init_dt);
+TIMER_OF_DECLARE(clint_timer2, "thead,c900-clint", c900_clint_timer_init_dt);
-- 
2.43.0


