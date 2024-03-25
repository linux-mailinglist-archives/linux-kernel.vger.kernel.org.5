Return-Path: <linux-kernel+bounces-117516-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3434288AC24
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 18:45:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5DCEC322530
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 17:45:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD9B95DF05;
	Mon, 25 Mar 2024 16:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TqpK//uS"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29B635D497
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 16:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711385622; cv=none; b=CncF3Tl3aYOdb81TKN8bMOy8efmtOq0AhP1rGRx42hY8VCf1MQ3Ev52qh0M6u/cHj1dbvJEQPUqlgXR/jRO+I30IIyiyvlRexVl3LZncQBrP7igqxO9NzjMp7dtqN1j/HdqnYNSaa4Z0fR2pQVzILp/AVwDBiq+RnQiSzVIPMBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711385622; c=relaxed/simple;
	bh=w6ZM0qzs2PGzaQXvUXmLy9gFSChzi3ytqtQ7RsJPkIE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q9D+RTPOmdMilVpuh2KjX+Z6ZuJ5kQL0blHOd/TjVIFQ+8euHluhCylEuDxGQAmSTJ5KpTmHYBJYMDZ6FA4LQDt7Fl2c4kw9qGsxduNSvZf/iQQsdY7+b5U0QQlZxZ5UAMj7tssZEoHTxsoUUi5n51aV25cpPGL0kflDV9NMEdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TqpK//uS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1ECE4C433F1;
	Mon, 25 Mar 2024 16:53:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711385620;
	bh=w6ZM0qzs2PGzaQXvUXmLy9gFSChzi3ytqtQ7RsJPkIE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TqpK//uSQEaK2p8j5RufU/zoTdsqlJw9JaorQ6kkKPd4MTQwJgbjlLTxTI6S3nS7K
	 BPva1d2LxjAXvyR93epam3JmVqaLdtPWjtZmwPBIZmuAL44cT/GoxvwiBj7/WCLkvT
	 45zGIyPMbG1FaCOV0OraeQKppFqC7Ml2wQABrVv2U8eNs5iYuDmu26OWqQcPFxovTj
	 JRly5wAASJkRRvtBGFMjoZ3EoTPYm7867mTqnJXydye4VSabI3bZGTw/OtVj5AlzAH
	 bogv6Zx9BSin3R+FSuPeXGrDU+epew4dyKbKvQHqNQZ8kxPoePqh5NkQdFrg4OY++g
	 lKd7Mtvm7a2TA==
From: Jisheng Zhang <jszhang@kernel.org>
To: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Thomas Gleixner <tglx@linutronix.de>
Cc: linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/5] riscv: nommu: use CSR_TIME* for get_cycles* implementation
Date: Tue, 26 Mar 2024 00:40:18 +0800
Message-ID: <20240325164021.3229-3-jszhang@kernel.org>
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
time shadows only the lower 32 bits of mtime." Since get_cycles() only
reads the timer, it's fine to use CSR_TIME to implement get_cycles().

Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
---
 arch/riscv/include/asm/timex.h | 40 ----------------------------------
 1 file changed, 40 deletions(-)

diff --git a/arch/riscv/include/asm/timex.h b/arch/riscv/include/asm/timex.h
index a06697846e69..a3fb85d505d4 100644
--- a/arch/riscv/include/asm/timex.h
+++ b/arch/riscv/include/asm/timex.h
@@ -10,44 +10,6 @@
 
 typedef unsigned long cycles_t;
 
-#ifdef CONFIG_RISCV_M_MODE
-
-#include <asm/clint.h>
-
-#ifdef CONFIG_64BIT
-static inline cycles_t get_cycles(void)
-{
-	return readq_relaxed(clint_time_val);
-}
-#else /* !CONFIG_64BIT */
-static inline u32 get_cycles(void)
-{
-	return readl_relaxed(((u32 *)clint_time_val));
-}
-#define get_cycles get_cycles
-
-static inline u32 get_cycles_hi(void)
-{
-	return readl_relaxed(((u32 *)clint_time_val) + 1);
-}
-#define get_cycles_hi get_cycles_hi
-#endif /* CONFIG_64BIT */
-
-/*
- * Much like MIPS, we may not have a viable counter to use at an early point
- * in the boot process. Unfortunately we don't have a fallback, so instead
- * we just return 0.
- */
-static inline unsigned long random_get_entropy(void)
-{
-	if (unlikely(clint_time_val == NULL))
-		return random_get_entropy_fallback();
-	return get_cycles();
-}
-#define random_get_entropy()	random_get_entropy()
-
-#else /* CONFIG_RISCV_M_MODE */
-
 static inline cycles_t get_cycles(void)
 {
 	return csr_read(CSR_TIME);
@@ -60,8 +22,6 @@ static inline u32 get_cycles_hi(void)
 }
 #define get_cycles_hi get_cycles_hi
 
-#endif /* !CONFIG_RISCV_M_MODE */
-
 #ifdef CONFIG_64BIT
 static inline u64 get_cycles64(void)
 {
-- 
2.43.0


