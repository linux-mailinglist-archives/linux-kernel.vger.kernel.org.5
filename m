Return-Path: <linux-kernel+bounces-80445-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 972CE86687E
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 04:07:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4CE221F213AC
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 03:07:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AA6D19470;
	Mon, 26 Feb 2024 03:06:37 +0000 (UTC)
Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD32EC8C7
	for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 03:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708916797; cv=none; b=CTh+5r9QRhqlJT4dvgxTnakuz8vL8c7WLU2ZLIve1sm4LDVFHAyfhQgeSkMl9nKt+bkUaD4lDTQH2vpKxmokol2M8LqlzHsfVT4cVtpFPMPAh/vjCb033E6BoeqyrTEVYWfMoQ03RQxpbWYFQ3Zng2zJv9unj5z/HW1XWK9MusM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708916797; c=relaxed/simple;
	bh=jCdznYeqTxnAdPqUo3goftYDv+lHb7g10nhlhcikrfU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=Sf7taoxI7lfq2xqYOtjQRgBkR3pBwTmHm3WJ4qdcxiUlm5KRA+aE26wHqVp6SUNVz65kMq8LdNUxjZRcPc1QSIE9iCQ4FMk3XBXI6V6v3cJf5nA1o3ed84qmCbB4oE5FEelrHdug5U06HROnSKgqarEX1p/1Y5WKvrnAfd9SMHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-d6dff70000001748-27-65dc002fde00
From: Byungchul Park <byungchul@sk.com>
To: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Cc: kernel_team@skhynix.com,
	akpm@linux-foundation.org,
	ying.huang@intel.com,
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
Subject: [RESEND PATCH v8 1/8] x86/tlb: Add APIs manipulating tlb batch's arch data
Date: Mon, 26 Feb 2024 12:06:06 +0900
Message-Id: <20240226030613.22366-2-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240226030613.22366-1-byungchul@sk.com>
References: <20240226030613.22366-1-byungchul@sk.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrKLMWRmVeSWpSXmKPExsXC9ZZnka4+w51UgxdrDS3mrF/DZvF5wz82
	ixcb2hktvq7/xWzx9FMfi8XlXXPYLO6t+c9qcX7XWlaLHUv3MVlcOrCAyeJ47wEmi/n3PrNZ
	bN40ldni+JSpjBa/fwAVn5w1mcVBwON7ax+Lx85Zd9k9Fmwq9di8Qstj8Z6XTB6bVnWyeWz6
	NInd4925c+weJ2b8ZvGYdzLQ4/2+q2weW3/ZeTROvcbm8XmTXABfFJdNSmpOZllqkb5dAlfG
	7dsvmQpW8VUs+dHO1sA4jaeLkZNDQsBEYvfzC0ww9tqN61lBbDYBdYkbN34yg9giAmYSB1v/
	sIPYzAJ3mSQO9LOB2MICwRIvLqwCq2ERUJXYf+QMI4jNK2Aqsf7lfKiZ8hKrNxwAquHg4ASa
	8/6/IUhYCKjkb+9VoHIuoJLPbBJP3k9lhaiXlDi44gbLBEbeBYwMqxiFMvPKchMzc0z0Mirz
	Miv0kvNzNzECA39Z7Z/oHYyfLgQfYhTgYFTi4V3w4XaqEGtiWXFl7iFGCQ5mJRHecJmbqUK8
	KYmVValF+fFFpTmpxYcYpTlYlMR5jb6VpwgJpCeWpGanphakFsFkmTg4pRoYuVz6bB9Jzriy
	X8VMq9yz6u+fJIHjl14utgvvvFLz+vG1NI32YqXOFV2vJ50/LLDgY+mTsIK2WZfiXQ9Ylqms
	VXUwXRJdkpDhGPPLS7Y//Rjzt6/fqvSSU7dythmc7Z21dKH+x6TGK6rHZ768+PTCrp+Xt1SI
	7mS0ckp/fjTwS0lLMWtOttYjJZbijERDLeai4kQANQUZ3XgCAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrDLMWRmVeSWpSXmKPExsXC5WfdrKvPcCfV4EKrusWc9WvYLD5v+Mdm
	8WJDO6PF1/W/mC2efupjsTg89ySrxeVdc9gs7q35z2pxftdaVosdS/cxWVw6sIDJ4njvASaL
	+fc+s1ls3jSV2eL4lKmMFr9/ABWfnDWZxUHQ43trH4vHzll32T0WbCr12LxCy2PxnpdMHptW
	dbJ5bPo0id3j3blz7B4nZvxm8Zh3MtDj/b6rbB6LX3xg8tj6y86jceo1No/Pm+QC+KO4bFJS
	czLLUov07RK4Mm7ffslUsIqvYsmPdrYGxmk8XYycHBICJhJrN65nBbHZBNQlbtz4yQxiiwiY
	SRxs/cMOYjML3GWSONDPBmILCwRLvLiwCqyGRUBVYv+RM4wgNq+AqcT6l/OZIGbKS6zecACo
	hoODE2jO+/+GIGEhoJK/vVcZJzByLWBkWMUokplXlpuYmWOqV5ydUZmXWaGXnJ+7iREYxstq
	/0zcwfjlsvshRgEORiUe3gUfbqcKsSaWFVfmHmKU4GBWEuENl7mZKsSbklhZlVqUH19UmpNa
	fIhRmoNFSZzXKzw1QUggPbEkNTs1tSC1CCbLxMEp1cA475ylarTBfS6DxKkLHoZMUPNqZ6s3
	WRz5f/LmNdb/N0pH8RdsrHrgPX93wpIshQkpPFs3NSscv3LOdKJmk32G8v6Ie4zpVY93Fs+p
	VWzeqnklMXD2Go0du2Zfr86Snpe0Lv3CTd5bydZLFm+Ry/BRTzY/NyfwyaOXi75ZlzX8/qAU
	UhH7KyVciaU4I9FQi7moOBEA6KTWhl8CAAA=
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


