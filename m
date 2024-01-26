Return-Path: <linux-kernel+bounces-39756-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E86383D5C5
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 10:15:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED25A28341B
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 09:15:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 092991BF29;
	Fri, 26 Jan 2024 08:19:05 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95A98C2FE;
	Fri, 26 Jan 2024 08:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706257144; cv=none; b=e760NwmiLXud/MMY0nbRdFaBkSs/fe7sWrCRZVb6ooiBgxacbQwJ9+bCwo1OQGYlydWx7I/YKXCuT3A7RbepnNyFfooF6XLABODOfvrxZPaRTP5AivmHVn8yTgKoZRF+onO6d4FL0Q7GG38APBxlyb7d89JFNk0L9UgfP611Ous=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706257144; c=relaxed/simple;
	bh=f+Gwy14SwFK7pcA8QYgiUXjBJlBmX4ONW24NcH5+dtU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=tT/AtgKI4dqjyecpLhrQWguRgxDhcyxI+BSxGgX/7ccLLx3XjZGKDxI7/0hi3ehZBg3ToJ13XQWfKcU4C/xT0CLDR42m1K/LE8gkzZQw6h4Z/183rlw9QOKAEpczifjyk1BOLT4UiwBDZQhQ3i5uLMituCBVaI1mhfdrL7jaiJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46EB6C433F1;
	Fri, 26 Jan 2024 08:19:02 +0000 (UTC)
From: Huacai Chen <chenhuacai@loongson.cn>
To: Huacai Chen <chenhuacai@kernel.org>
Cc: loongarch@lists.linux.dev,
	Xuefeng Li <lixuefeng@loongson.cn>,
	Guo Ren <guoren@kernel.org>,
	Xuerui Wang <kernel@xen0n.name>,
	Jiaxun Yang <jiaxun.yang@flygoat.com>,
	linux-kernel@vger.kernel.org,
	loongson-kernel@lists.loongnix.cn,
	Huacai Chen <chenhuacai@loongson.cn>
Subject: [PATCH] LoongArch/smp: Call rcutree_report_cpu_starting() at tlb_init()
Date: Fri, 26 Jan 2024 16:18:43 +0800
Message-Id: <20240126081843.2749-1-chenhuacai@loongson.cn>
X-Mailer: git-send-email 2.39.3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Machines which have more than 8 nodes fail to boot SMP after commit
a2ccf46333d7b2cf96 ("LoongArch/smp: Call rcutree_report_cpu_starting()
earlier"). Because such machines use tlb-based per-cpu base address
rather than dmw-based per-cpu base address, resulting per-cpu variables
can only be accessed after tlb_init(). But rcutree_report_cpu_starting()
is now called before tlb_init() and accesses per-cpu variables indeed.

Since the original patch want to avoid the lockdep warning caused by
page allocation in tlb_init(), we can move rcutree_report_cpu_starting()
to tlb_init() where after tlb exception configuration but before page
allocation.

Fixes: a2ccf46333d7b2cf96 ("LoongArch/smp: Call rcutree_report_cpu_starting() earlier")
Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
---
 arch/loongarch/kernel/smp.c |  1 -
 arch/loongarch/mm/tlb.c     | 16 ++++++++++------
 2 files changed, 10 insertions(+), 7 deletions(-)

diff --git a/arch/loongarch/kernel/smp.c b/arch/loongarch/kernel/smp.c
index a16e3dbe9f09..2b49d30eb7c0 100644
--- a/arch/loongarch/kernel/smp.c
+++ b/arch/loongarch/kernel/smp.c
@@ -509,7 +509,6 @@ asmlinkage void start_secondary(void)
 	sync_counter();
 	cpu = raw_smp_processor_id();
 	set_my_cpu_offset(per_cpu_offset(cpu));
-	rcutree_report_cpu_starting(cpu);
 
 	cpu_probe();
 	constant_clockevent_init();
diff --git a/arch/loongarch/mm/tlb.c b/arch/loongarch/mm/tlb.c
index 2c0a411f23aa..0b95d32b30c9 100644
--- a/arch/loongarch/mm/tlb.c
+++ b/arch/loongarch/mm/tlb.c
@@ -284,12 +284,16 @@ static void setup_tlb_handler(int cpu)
 		set_handler(EXCCODE_TLBNR * VECSIZE, handle_tlb_protect, VECSIZE);
 		set_handler(EXCCODE_TLBNX * VECSIZE, handle_tlb_protect, VECSIZE);
 		set_handler(EXCCODE_TLBPE * VECSIZE, handle_tlb_protect, VECSIZE);
-	}
+	} else {
+		int vec_sz __maybe_unused;
+		void *addr __maybe_unused;
+		struct page *page __maybe_unused;
+
+		/* Avoid lockdep warning */
+		rcutree_report_cpu_starting(cpu);
+
 #ifdef CONFIG_NUMA
-	else {
-		void *addr;
-		struct page *page;
-		const int vec_sz = sizeof(exception_handlers);
+		vec_sz = sizeof(exception_handlers);
 
 		if (pcpu_handlers[cpu])
 			return;
@@ -305,8 +309,8 @@ static void setup_tlb_handler(int cpu)
 		csr_write64(pcpu_handlers[cpu], LOONGARCH_CSR_EENTRY);
 		csr_write64(pcpu_handlers[cpu], LOONGARCH_CSR_MERRENTRY);
 		csr_write64(pcpu_handlers[cpu] + 80*VECSIZE, LOONGARCH_CSR_TLBRENTRY);
-	}
 #endif
+	}
 }
 
 void tlb_init(int cpu)
-- 
2.39.3


