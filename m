Return-Path: <linux-kernel+bounces-45919-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D13A8437D4
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 08:27:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8EE641C267CD
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 07:27:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7F1A56B8C;
	Wed, 31 Jan 2024 07:22:05 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A03656479;
	Wed, 31 Jan 2024 07:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706685725; cv=none; b=AItS0LPlBLO3jOcMNXhV+3Wa1qPxBiZTBoiMM6cimyHvEQ8e+v0BUr8xBaey1vgNFXHDF0+pK1PWujGmQLbWHYyoPQasU5bTVV9wM4qw1T+o5vYoaCj4qBwhdliDXFLkje95LSH840Krd77hJxs2WkrBjOPhSmHgYijgSDwAE4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706685725; c=relaxed/simple;
	bh=VSPOIQIi1SFSb7BcOqd2hNNK1gD3mDXV74OKv3NfOM4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Y4PH8T7zZZW/eVZpmaN/fu2cQE4ZO2cUvotkHqCCzDe3RVY7zOrH3/qk99Go9I1RQnmuIZaoEMBG5m0hTCqYlYuXuCwd5bnzUi1Cj7c4lnvKXpZhSpMxY6EI0dJmnhmEpp+SMbs2NY7iYnTDJ4AUGr7KZTFMucysv0JlvaiQCqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC2FEC433F1;
	Wed, 31 Jan 2024 07:22:01 +0000 (UTC)
From: Huacai Chen <chenhuacai@loongson.cn>
To: gregkh@linuxfoundation.org,
	Huacai Chen <chenhuacai@kernel.org>
Cc: loongarch@lists.linux.dev,
	stable@vger.kernel.org,
	Xuefeng Li <lixuefeng@loongson.cn>,
	Guo Ren <guoren@kernel.org>,
	Xuerui Wang <kernel@xen0n.name>,
	Jiaxun Yang <jiaxun.yang@flygoat.com>,
	linux-kernel@vger.kernel.org,
	loongson-kernel@lists.loongnix.cn,
	Huacai Chen <chenhuacai@loongson.cn>
Subject: [PATCH 6.1.y and 6.6.y] LoongArch/smp: Call rcutree_report_cpu_starting() at tlb_init()
Date: Wed, 31 Jan 2024 15:21:51 +0800
Message-Id: <20240131072151.1023985-1-chenhuacai@loongson.cn>
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

Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
---
 arch/loongarch/kernel/smp.c |  1 -
 arch/loongarch/mm/tlb.c     | 16 ++++++++++------
 2 files changed, 10 insertions(+), 7 deletions(-)

diff --git a/arch/loongarch/kernel/smp.c b/arch/loongarch/kernel/smp.c
index 3f3cdc7ffe7a..4b4ba3f9335d 100644
--- a/arch/loongarch/kernel/smp.c
+++ b/arch/loongarch/kernel/smp.c
@@ -506,7 +506,6 @@ asmlinkage void start_secondary(void)
 	sync_counter();
 	cpu = raw_smp_processor_id();
 	set_my_cpu_offset(per_cpu_offset(cpu));
-	rcu_cpu_starting(cpu);
 
 	cpu_probe();
 	constant_clockevent_init();
diff --git a/arch/loongarch/mm/tlb.c b/arch/loongarch/mm/tlb.c
index 2c51d755fbbc..e71150dd7f4b 100644
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
+		rcu_cpu_starting(cpu);
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


