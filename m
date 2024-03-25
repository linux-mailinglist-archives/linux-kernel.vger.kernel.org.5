Return-Path: <linux-kernel+bounces-117518-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0204888AC27
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 18:46:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF4BE2C5959
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 17:45:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE55A14A9D;
	Mon, 25 Mar 2024 16:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BBUCPAz0"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34A1B84A26
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 16:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711385625; cv=none; b=davVpWmujV+B8QhRiSroSXc0SitY7d4LdAuRceCt07PWOGXbQjfaEU6rfiue6j0jitrbq0ChSZ7Fk0Yi00f+oW7k7l9dUbyYSh28Vw+4YXwz+XW40qDiraxfjj+6Qeyyu9al8hh70R/9Nw9ertS+XXtkwVIVPxgPgq8Vf1UcuoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711385625; c=relaxed/simple;
	bh=JxFNqk1udzBJf0wb9hzCshesMQ7wj/gJiBIIdlgKlnQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d4pUtLQ/Kcrt7s1AplNxVedkfv0cbSVytNhoyCz3Eyi8cPYKRef4bF00MUGmxRcPp1r76LfgUEwLaYvk36jSINZrmSKAjHqu8DDXEVsFM2STKXX899jsX3oRYWXrcM4B5rTuXwQNeomAZommlca5AwQQTMqx+I5Qy16egVJc3Yw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BBUCPAz0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 285A8C433F1;
	Mon, 25 Mar 2024 16:53:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711385624;
	bh=JxFNqk1udzBJf0wb9hzCshesMQ7wj/gJiBIIdlgKlnQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BBUCPAz08ws6G27uwdiYhJaiZaAMK7cNJLpZ3myQHlDdWdUAFQob1dxDd7GbxJDXC
	 k6naSdjnDeynjjzTHXDxmX/sg5j/MpwZUwme4C+kkQdZb05BeggwrFCrA3cMQRhTye
	 V6FcJfKXPjEN46BvjPOqWyJG6J+gnBNpyDXxIU0pmN2bmMy7or9UKvEwU4aGYV76+H
	 UI88J060emfq8sn9e7+H8iy+rsYI4/JaSAqgtL3YmWp2xs3a6phKS5b7cZBNlZDRE8
	 fd/IKf4ULYTZzOIzybOI4+UBb8g+ZSZ4DGIhi4fhhJMfwgxtk+ROyxU0+2qJ+y/bLe
	 XZi9O/tukUQrg==
From: Jisheng Zhang <jszhang@kernel.org>
To: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Thomas Gleixner <tglx@linutronix.de>
Cc: linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 4/5] clocksource/drivers/timer-clint: Use get_cycles()
Date: Tue, 26 Mar 2024 00:40:20 +0800
Message-ID: <20240325164021.3229-5-jszhang@kernel.org>
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

Per riscv privileged spec, "The time CSR is a read-only shadow of the
memory-mapped mtime register", "On RV32I the timeh CSR is a read-only
shadow of the upper 32 bits of the memory-mapped mtime register, while
time shadows only the lower 32 bits of mtime.", so it's fine to use
time CSR to implement sched_clock and clint clockevent/clocksource.

Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
---
 drivers/clocksource/timer-clint.c | 25 +------------------------
 1 file changed, 1 insertion(+), 24 deletions(-)

diff --git a/drivers/clocksource/timer-clint.c b/drivers/clocksource/timer-clint.c
index 56acaa93b6c3..4537c77e623c 100644
--- a/drivers/clocksource/timer-clint.c
+++ b/drivers/clocksource/timer-clint.c
@@ -32,7 +32,6 @@
 static u32 __iomem *clint_ipi_base;
 static unsigned int clint_ipi_irq;
 static u64 __iomem *clint_timer_cmp;
-static u64 __iomem *clint_timer_val;
 static unsigned long clint_timer_freq;
 static unsigned int clint_timer_irq;
 
@@ -60,31 +59,10 @@ static void clint_ipi_interrupt(struct irq_desc *desc)
 }
 #endif
 
-#ifdef CONFIG_64BIT
-#define clint_get_cycles()	readq_relaxed(clint_timer_val)
-#else
-#define clint_get_cycles()	readl_relaxed(clint_timer_val)
-#define clint_get_cycles_hi()	readl_relaxed(((u32 *)clint_timer_val) + 1)
-#endif
-
-#ifdef CONFIG_64BIT
 static u64 notrace clint_get_cycles64(void)
 {
-	return clint_get_cycles();
-}
-#else /* CONFIG_64BIT */
-static u64 notrace clint_get_cycles64(void)
-{
-	u32 hi, lo;
-
-	do {
-		hi = clint_get_cycles_hi();
-		lo = clint_get_cycles();
-	} while (hi != clint_get_cycles_hi());
-
-	return ((u64)hi << 32) | lo;
+	return get_cycles64();
 }
-#endif /* CONFIG_64BIT */
 
 static u64 clint_rdtime(struct clocksource *cs)
 {
@@ -205,7 +183,6 @@ static int __init clint_timer_init_dt(struct device_node *np)
 
 	clint_ipi_base = base + CLINT_IPI_OFF;
 	clint_timer_cmp = base + CLINT_TIMER_CMP_OFF;
-	clint_timer_val = base + CLINT_TIMER_VAL_OFF;
 	clint_timer_freq = riscv_timebase;
 
 	pr_info("%pOFP: timer running at %ld Hz\n", np, clint_timer_freq);
-- 
2.43.0


