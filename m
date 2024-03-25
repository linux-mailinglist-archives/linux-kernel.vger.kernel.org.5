Return-Path: <linux-kernel+bounces-117517-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C49B188AC25
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 18:45:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 62F491F67925
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 17:45:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 886DD6F515;
	Mon, 25 Mar 2024 16:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sbe2U8cH"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFECF111A2
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 16:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711385622; cv=none; b=LBKwjqut86GHsgr5Mf445J9f8ZPkp52x0D9IgZqA9BgufykcdIXGRUlxMokEAmDmchC59MDeQPJYAPLFy7ccgsvt9eMwsjMiZN4eo88nAwUcgX5c10ncGVQwMhX+yfAV9ClpaNO9R59JglQ8Z3PVin+MlXrwKwkcE24thhge9Ao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711385622; c=relaxed/simple;
	bh=NrGlxqgZh3B1ZksAfxarZEX2wTrdfyxjcZNnuUN0fWY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tnxgLKPr2q9NO9TC3GGLgNDs2rSjNId/y+DhGJRNO3smsnX6CfT1MrPqH9HfEvL9YliT5DfhU3zmJJcpTWZtW3ZPHX6gNrWlLVL2OHcwb/OKZjVPLBv9K5kseA+hVxHZ5IdIPNHM6pIJr8d3AZAT0fNskrhkZ3z3IUJ7Y7DP2uQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sbe2U8cH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23E98C433C7;
	Mon, 25 Mar 2024 16:53:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711385622;
	bh=NrGlxqgZh3B1ZksAfxarZEX2wTrdfyxjcZNnuUN0fWY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sbe2U8cHcKbsb3NjqeI+VDc1Bq5b3EylZM6uqyiPyKXZ3EuJuhgYjfp6Tf1WyBsNa
	 dP4VEkfxtxGFCZqC8jHHbhJQ/1+MxsNMSLxTMGQ1HsQb2YvGSFCKTgWuWwUmUHPb2V
	 /ByEg7Vas3QPjTBvMMPzmQpyoluP9C3KnGMwgCeOn/2Cod4L7saQFCa/FI5JJfiQXx
	 DLeSGwQKaumx1Aqo+ho0dZjVC18qWDt4LzXuCzrPLOAgviB8jMQrdK5Do/O+2yl8Jr
	 MCo+Dc69iwxnjqQiwCG5+Ftiebcub+WIp6whR7p2BMc9kYBMSFAcemQ91LgPNgZ/cJ
	 RikMAyfdIif3g==
From: Jisheng Zhang <jszhang@kernel.org>
To: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Thomas Gleixner <tglx@linutronix.de>
Cc: linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 3/5] clocksource/drivers/timer-clint: Remove clint_time_val
Date: Tue, 26 Mar 2024 00:40:19 +0800
Message-ID: <20240325164021.3229-4-jszhang@kernel.org>
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

The usage have been removed, so it's time to remove clint_time_val.

Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
---
 arch/riscv/include/asm/clint.h    | 26 --------------------------
 drivers/clocksource/timer-clint.c | 17 -----------------
 2 files changed, 43 deletions(-)
 delete mode 100644 arch/riscv/include/asm/clint.h

diff --git a/arch/riscv/include/asm/clint.h b/arch/riscv/include/asm/clint.h
deleted file mode 100644
index 0789fd37b40a..000000000000
--- a/arch/riscv/include/asm/clint.h
+++ /dev/null
@@ -1,26 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-only */
-/*
- * Copyright (C) 2020 Google, Inc
- */
-
-#ifndef _ASM_RISCV_CLINT_H
-#define _ASM_RISCV_CLINT_H
-
-#include <linux/types.h>
-#include <asm/mmio.h>
-
-#ifdef CONFIG_RISCV_M_MODE
-/*
- * This lives in the CLINT driver, but is accessed directly by timex.h to avoid
- * any overhead when accessing the MMIO timer.
- *
- * The ISA defines mtime as a 64-bit memory-mapped register that increments at
- * a constant frequency, but it doesn't define some other constraints we depend
- * on (most notably ordering constraints, but also some simpler stuff like the
- * memory layout).  Thus, this is called "clint_time_val" instead of something
- * like "riscv_mtime", to signify that these non-ISA assumptions must hold.
- */
-extern u64 __iomem *clint_time_val;
-#endif
-
-#endif
diff --git a/drivers/clocksource/timer-clint.c b/drivers/clocksource/timer-clint.c
index 09fd292eb83d..56acaa93b6c3 100644
--- a/drivers/clocksource/timer-clint.c
+++ b/drivers/clocksource/timer-clint.c
@@ -24,10 +24,6 @@
 #include <linux/smp.h>
 #include <linux/timex.h>
 
-#ifndef CONFIG_RISCV_M_MODE
-#include <asm/clint.h>
-#endif
-
 #define CLINT_IPI_OFF		0
 #define CLINT_TIMER_CMP_OFF	0x4000
 #define CLINT_TIMER_VAL_OFF	0xbff8
@@ -40,11 +36,6 @@ static u64 __iomem *clint_timer_val;
 static unsigned long clint_timer_freq;
 static unsigned int clint_timer_irq;
 
-#ifdef CONFIG_RISCV_M_MODE
-u64 __iomem *clint_time_val;
-EXPORT_SYMBOL(clint_time_val);
-#endif
-
 #ifdef CONFIG_SMP
 static void clint_send_ipi(unsigned int cpu)
 {
@@ -217,14 +208,6 @@ static int __init clint_timer_init_dt(struct device_node *np)
 	clint_timer_val = base + CLINT_TIMER_VAL_OFF;
 	clint_timer_freq = riscv_timebase;
 
-#ifdef CONFIG_RISCV_M_MODE
-	/*
-	 * Yes, that's an odd naming scheme.  time_val is public, but hopefully
-	 * will die in favor of something cleaner.
-	 */
-	clint_time_val = clint_timer_val;
-#endif
-
 	pr_info("%pOFP: timer running at %ld Hz\n", np, clint_timer_freq);
 
 	rc = clocksource_register_hz(&clint_clocksource, clint_timer_freq);
-- 
2.43.0


