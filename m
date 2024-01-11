Return-Path: <linux-kernel+bounces-23087-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8529682A782
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 07:23:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3C9541F238E7
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 06:23:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 116B26FB3;
	Thu, 11 Jan 2024 06:23:33 +0000 (UTC)
Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B68CC6AA6
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 06:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-d6dff70000001748-de-659f85c70830
From: Byungchul Park <byungchul@sk.com>
To: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Cc: kernel_team@skhynix.com,
	akpm@linux-foundation.org,
	ying.huang@intel.com,
	namit@vmware.com,
	xhao@linux.alibaba.com,
	mgorman@techsingularity.net,
	hughd@google.com,
	willy@infradead.org,
	david@redhat.com,
	peterz@infradead.org,
	luto@kernel.org,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com
Subject: [v5 1/7] x86/tlb: Add APIs manipulating tlb batch's arch data
Date: Thu, 11 Jan 2024 15:07:51 +0900
Message-Id: <20240111060757.13563-2-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240111060757.13563-1-byungchul@sk.com>
References: <20240111060757.13563-1-byungchul@sk.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrELMWRmVeSWpSXmKPExsXC9ZZnke6J1vmpBg+usFrMWb+GzeLzhn9s
	Fi82tDNafF3/i9ni6ac+FovLu+awWdxb85/V4vyutawWO5buY7K4dGABk8X1XQ8ZLY73HmCy
	2LxpKrPF7x9AdXOmWFmcnDWZxUHA43trH4vHgk2lHptXaHks3vOSyWPTqk42j02fJrF7vDt3
	jt3jxIzfLB47H1p6zDsZ6PF+31U2j62/7Dw+b5LzeDf/LVsAXxSXTUpqTmZZapG+XQJXxu3b
	L5kKVvFVLPnRztbAOI2ni5GTQ0LARGLby5dMXYwcYPa8TZkgYTYBdYkbN34yg9giAmYSB1v/
	sHcxcnEwCzxgkpj7dgUjSEJYwE2i/8M3JhCbRUBVYtHNTlYQm1fAVOLdzR5WiPnyEqs3HAAb
	xAk06MLhWYwgu4SAah611UGUfGeTeLK0FMKWlDi44gbLBEbeBYwMqxiFMvPKchMzc0z0Mirz
	Miv0kvNzNzECQ35Z7Z/oHYyfLgQfYhTgYFTi4X2waF6qEGtiWXFl7iFGCQ5mJRFehc9zUoV4
	UxIrq1KL8uOLSnNSiw8xSnOwKInzGn0rTxESSE8sSc1OTS1ILYLJMnFwSjUwTrb4OvVb5d9S
	D6ZpXYaRl+LjdnRMndy4f3VFTuefjZqHeTySHUVfrylIWJGwti3NqKsmLMJ6y7xNaUenur6z
	3dhvm7B3TfjV5dv9v/YY9K3ZNLcv+leuuqj5dr6EY5eTGr4GzfNI59/59dLaxd9PHKzv+nT9
	4zK+ednHN/h+M7uxNdTxtvM/fyWW4oxEQy3mouJEAAWL0dt1AgAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrFLMWRmVeSWpSXmKPExsXC5WfdrHu8dX6qwdM+C4s569ewWXze8I/N
	4sWGdkaLr+t/MVs8/dTHYnF47klWi8u75rBZ3Fvzn9Xi/K61rBY7lu5jsrh0YAGTxfVdDxkt
	jvceYLLYvGkqs8XvH0B1c6ZYWZycNZnFQdDje2sfi8eCTaUem1doeSze85LJY9OqTjaPTZ8m
	sXu8O3eO3ePEjN8sHjsfWnrMOxno8X7fVTaPxS8+MHls/WXn8XmTnMe7+W/ZAvijuGxSUnMy
	y1KL9O0SuDJu337JVLCKr2LJj3a2BsZpPF2MHBwSAiYS8zZldjFycrAJqEvcuPGTGcQWETCT
	ONj6h72LkYuDWeABk8TctysYQRLCAm4S/R++MYHYLAKqEotudrKC2LwCphLvbvaA2RIC8hKr
	NxwAG8QJNOjC4VmMILuEgGoetdVNYORawMiwilEkM68sNzEzx1SvODujMi+zQi85P3cTIzCE
	l9X+mbiD8ctl90OMAhyMSjy8Bi/npQqxJpYVV+YeYpTgYFYS4VX4PCdViDclsbIqtSg/vqg0
	J7X4EKM0B4uSOK9XeGqCkEB6YklqdmpqQWoRTJaJg1OqgdHRV6F6dvfDWYfPVhxTevCV/ZZT
	UfEO4XX+Pckit20DZh7cy3HyovC9rDdHZBw1/untvNm9f4rPFY2DQdrTbklzq4c6btu0Ikda
	IKPsssTEG8edT6wzaCjM3xqdXHTvyaFCVgvzXqeWi9/CRPIrmf85ey7jNVWdkrNucvb8G2Gl
	D668dZ3esEOJpTgj0VCLuag4EQDnu2KHXQIAAA==
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


