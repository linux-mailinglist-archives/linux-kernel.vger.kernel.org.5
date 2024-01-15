Return-Path: <linux-kernel+bounces-25714-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DAFD882D4E9
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 09:20:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E404F1C208DA
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 08:20:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27C8863CD;
	Mon, 15 Jan 2024 08:20:10 +0000 (UTC)
Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66A775CA1
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jan 2024 08:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-d85ff70000001748-75-65a4eab4da69
From: Byungchul Park <byungchul@sk.com>
To: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Cc: kernel_team@skhynix.com,
	akpm@linux-foundation.org,
	ying.huang@intel.com,
	namit@vmware.com,
	vernhao@tencent.com,
	mgorman@techsingularity.net,
	hughd@google.com,
	willy@infradead.org,
	david@redhat.com,
	peterz@infradead.org,
	luto@kernel.org,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	rjgolo@gmail.com
Subject: [PATCH v6 1/7] x86/tlb: Add APIs manipulating tlb batch's arch data
Date: Mon, 15 Jan 2024 17:19:47 +0900
Message-Id: <20240115081953.2521-2-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240115081953.2521-1-byungchul@sk.com>
References: <20240115081953.2521-1-byungchul@sk.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrALMWRmVeSWpSXmKPExsXC9ZZnoe6WV0tSDXZN5LGYs34Nm8XnDf/Y
	LF5saGe0+Lr+F7PF0099LBaXd81hs7i35j+rxflda1ktdizdx2Rx6cACJovrux4yWhzvPcBk
	Mf/eZzaLzZumMlscnzKV0eL3D6COk7MmszgIenxv7WPx2DnrLrvHgk2lHptXaHks3vOSyWPT
	qk42j02fJrF7vDt3jt3jxIzfLB7zTgZ6vN93lc1j6y87j8ap19g8Pm+S83g3/y1bAH8Ul01K
	ak5mWWqRvl0CV8bt2y+ZClbxVSz50c7WwDiNp4uRg0NCwERiU4NxFyMnmLns9nJGEJtNQF3i
	xo2fzCC2iICZxMHWP+xdjFwczAIfmSRWf+9gAUkIC/hIvG16CVbEIqAq8fvGSTYQmxdo0Jxr
	DSwQQ+UlVm84AFbDKWAq8e7jcXYQWwiopuXuOlaQoRIC7ewST1adYodokJQ4uOIGywRG3gWM
	DKsYhTLzynITM3NM9DIq8zIr9JLzczcxAuNhWe2f6B2Mny4EH2IU4GBU4uH98XdxqhBrYllx
	Ze4hRgkOZiUR3uo7S1KFeFMSK6tSi/Lji0pzUosPMUpzsCiJ8xp9K08REkhPLEnNTk0tSC2C
	yTJxcEo1MHKmheSanGLfknzfh89jQ/eZsjpmuQmx9eud/hVnJZtsZ/kQe2OFs8FZ9mXLO9t5
	1ut6+O5dG1KaLrp01cxoG0b7I23TWraZePttCe6JLrdg+WR3j9lw77Q5v7fFqU/82enPlnfM
	aG1vteG3mpMHBY5V8nhJ5Qp9dXwoLfizxfNee7/Du5PnlViKMxINtZiLihMBByu8QYMCAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrBLMWRmVeSWpSXmKPExsXC5WfdrLvl1ZJUg9WvGC3mrF/DZvF5wz82
	ixcb2hktvq7/xWzx9FMfi8XhuSdZLS7vmsNmcW/Nf1aL87vWslrsWLqPyeLSgQVMFtd3PWS0
	ON57gMli/r3PbBabN01ltjg+ZSqjxe8fQB0nZ01mcRDy+N7ax+Kxc9Zddo8Fm0o9Nq/Q8li8
	5yWTx6ZVnWwemz5NYvd4d+4cu8eJGb9ZPOadDPR4v+8qm8fiFx+YPLb+svNonHqNzePzJjmP
	d/PfsgUIRHHZpKTmZJalFunbJXBl3L79kqlgFV/Fkh/tbA2M03i6GDk5JARMJJbdXs4IYrMJ
	qEvcuPGTGcQWETCTONj6h72LkYuDWeAjk8Tq7x0sIAlhAR+Jt00vwYpYBFQlft84yQZi8wIN
	mnOtgQViqLzE6g0HwGo4BUwl3n08zg5iCwHVtNxdxzqBkWsBI8MqRpHMvLLcxMwcU73i7IzK
	vMwKveT83E2MwPBeVvtn4g7GL5fdDzEKcDAq8fD++Ls4VYg1say4MvcQowQHs5IIb/WdJalC
	vCmJlVWpRfnxRaU5qcWHGKU5WJTEeb3CUxOEBNITS1KzU1MLUotgskwcnFINjLtmvf6U1GIv
	4rvzC98p3/BJJ19arL37uFbRSl/dp/zHu6SePwxO4t9nhM2yOzQtaFtS8LvHJpqbfPhV7/jN
	4vq65n7Nhgdfoict2ypnmriMt+8y9+NrTLv6N34rW26r5bxvadM6F/l1K/N3b+C5+Pr6GsmT
	jyZ/Y51lsswy8s37qunmGq51bvFKLMUZiYZazEXFiQBY1mM4awIAAA==
X-CFilter-Loop: Reflected
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

This is a preparation for migrc mechanism that needs to recognize
read-only TLB entries during batched TLB flush by separating tlb batch's
arch data into two, one is for read-only entries and the other is for
writable ones, and merging those two when needed.

Migrc also needs to optimize CPUs to flush by clearing ones that have
already performed TLB flush needed.

To support it, added APIs manipulating arch data for x86.

Signed-off-by: Byungchul Park <byungchul@sk.com>
---
 arch/x86/include/asm/tlbflush.h | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/arch/x86/include/asm/tlbflush.h b/arch/x86/include/asm/tlbflush.h
index 25726893c6f4..fa7e16dbeb44 100644
--- a/arch/x86/include/asm/tlbflush.h
+++ b/arch/x86/include/asm/tlbflush.h
@@ -5,6 +5,7 @@
 #include <linux/mm_types.h>
 #include <linux/mmu_notifier.h>
 #include <linux/sched.h>
+#include <linux/cpumask.h>
 
 #include <asm/processor.h>
 #include <asm/cpufeature.h>
@@ -293,6 +294,23 @@ static inline void arch_flush_tlb_batched_pending(struct mm_struct *mm)
 
 extern void arch_tlbbatch_flush(struct arch_tlbflush_unmap_batch *batch);
 
+static inline void arch_tlbbatch_clear(struct arch_tlbflush_unmap_batch *batch)
+{
+	cpumask_clear(&batch->cpumask);
+}
+
+static inline void arch_tlbbatch_fold(struct arch_tlbflush_unmap_batch *bdst,
+		struct arch_tlbflush_unmap_batch *bsrc)
+{
+	cpumask_or(&bdst->cpumask, &bdst->cpumask, &bsrc->cpumask);
+}
+
+static inline bool arch_tlbbatch_done(struct arch_tlbflush_unmap_batch *bdst,
+		struct arch_tlbflush_unmap_batch *bsrc)
+{
+	return cpumask_andnot(&bdst->cpumask, &bdst->cpumask, &bsrc->cpumask);
+}
+
 static inline bool pte_flags_need_flush(unsigned long oldflags,
 					unsigned long newflags,
 					bool ignore_access)
-- 
2.17.1


