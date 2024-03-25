Return-Path: <linux-kernel+bounces-117519-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 93DD588AC28
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 18:46:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7FFFD2C7017
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 17:46:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E36CD12CDB4;
	Mon, 25 Mar 2024 16:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aQw3HWi2"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3776D129E6C
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 16:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711385627; cv=none; b=S790Nls7MSOcvmQjftRlXHWOm7LJ3fq6C9JHg14/NUFeKQr9RNrgShUhwxaFTGANJwBOUheoUkjaW6B1L+E354opT4q5XCLA/FXCQg9rqM3ycRh/CHsy8f4tW0NQhuy2YsIKbwoJqeaXur5Pq3uDKvHFjZZLUarp0ZyMhWpNqrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711385627; c=relaxed/simple;
	bh=USjwiJfYFCW4AFS9tztvFTk4Lr/QV8A+qsGGTHmlU9g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rHuiTHO6ntytkdw88OmRrOiU1nxNs/Lo6iPfusIJqLyy866F1wrpUTDqJ3tMezXWJcj8aZLfj0Rg+8VKXUCgJSLyGu8ZjPpRDAsPC78YK0HzKNQY3fKi1sOcvh3mcG2zEW8lZAXuesYULKUa0BN9kX4q3Xsve9qTUY3nK0zMVK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aQw3HWi2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FF7FC43399;
	Mon, 25 Mar 2024 16:53:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711385626;
	bh=USjwiJfYFCW4AFS9tztvFTk4Lr/QV8A+qsGGTHmlU9g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aQw3HWi2KumzvUq+QquuTX8sj1Ig+lvifx/LxjM0xOX73RKrN2zBTC1N6EUqN0M8I
	 G7xEyRIaPeb9H3u8Jkox4cQ9xCrthzl1Q/mZ+InXlYwaN9bLqdyscnmnjBzaBdGKPQ
	 kEpHbE+85Yo9a5HfHkdeRMem8ECfQ4McQlJPRS6wgnc+oT8kmgtodWVeHp6PQan8Mn
	 i87UfCVVPyUMJs2+5hIQ9cZKcX8aXZHItnkOKxhZFObkKc/8whsC3vxYU3Jv+F1QqV
	 Sw7PYJNMpiNreRIRDFpBAQRHbgu309evfKT4rbLA5qY8JoM0jmrkajj+qPwN3Dn4i2
	 QOuyLrlxiFh8Q==
From: Jisheng Zhang <jszhang@kernel.org>
To: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Thomas Gleixner <tglx@linutronix.de>
Cc: linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 5/5] clocksource/drivers/timer-clint: Add T-Head C9xx clint support
Date: Tue, 26 Mar 2024 00:40:21 +0800
Message-ID: <20240325164021.3229-6-jszhang@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240325164021.3229-1-jszhang@kernel.org>
References: <20240325164021.3229-1-jszhang@kernel.org>
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
index 4537c77e623c..71188732e8a3 100644
--- a/drivers/clocksource/timer-clint.c
+++ b/drivers/clocksource/timer-clint.c
@@ -34,6 +34,7 @@ static unsigned int clint_ipi_irq;
 static u64 __iomem *clint_timer_cmp;
 static unsigned long clint_timer_freq;
 static unsigned int clint_timer_irq;
+static bool is_c900_clint;
 
 #ifdef CONFIG_SMP
 static void clint_send_ipi(unsigned int cpu)
@@ -88,6 +89,19 @@ static int clint_clock_next_event(unsigned long delta,
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
 	.name		= "clint_clockevent",
 	.features	= CLOCK_EVT_FEAT_ONESHOT,
@@ -99,6 +113,9 @@ static int clint_timer_starting_cpu(unsigned int cpu)
 {
 	struct clock_event_device *ce = per_cpu_ptr(&clint_clock_event, cpu);
 
+	if (is_c900_clint)
+		ce->set_next_event = c900_clint_clock_next_event;
+
 	ce->cpumask = cpumask_of(cpu);
 	clockevents_config_and_register(ce, clint_timer_freq, 100, ULONG_MAX);
 
@@ -233,5 +250,12 @@ static int __init clint_timer_init_dt(struct device_node *np)
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
+TIMER_OF_DECLARE(clint_timer2, "thead,c900-clint", clint_timer_init_dt);
-- 
2.43.0


