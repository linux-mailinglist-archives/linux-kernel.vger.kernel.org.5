Return-Path: <linux-kernel+bounces-57513-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 50D5684DA0C
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 07:26:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 03B6EB23614
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 06:26:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DE9267E67;
	Thu,  8 Feb 2024 06:26:26 +0000 (UTC)
Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 913A067C6D
	for <linux-kernel@vger.kernel.org>; Thu,  8 Feb 2024 06:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707373586; cv=none; b=q+EPlkLoeEaI3tzKFfcRtjmUKQNM+YlJeqk2jgeEIto4AaB/r3x1FtCz4SS3t5xunUljnju4mTXrpgH3ZUoUbCJezsImgss6Eri9/kasB0NY6BDQZLOQ4sEQlRMkCBezbgZYfJQtShsTpgQRmy0x5SGWMzuJMjXzJ4UvPSVCABo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707373586; c=relaxed/simple;
	bh=jCdznYeqTxnAdPqUo3goftYDv+lHb7g10nhlhcikrfU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=AXSOLMicz94VH+fi+3aRA3f7GxyJSgw6R2KgZdXewP5z/1U2Fmm23MWzUDQJUF9X6CK+edAphJkZOj/JKJ0dJ4wUxypLcYL+LbtXPBur6rHWFS5AjdCDSRqJQw2PjPu8CHMJWiDQyY6KtrX3zdpZl/TnwO29Z27J9DKOZeeHaTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-d85ff70000001748-74-65c4740a3ee5
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
Subject: [RESEND PATCH v7 1/8] x86/tlb: Add APIs manipulating tlb batch's arch data
Date: Thu,  8 Feb 2024 15:26:01 +0900
Message-Id: <20240208062608.44351-2-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240208062608.44351-1-byungchul@sk.com>
References: <20240208062608.44351-1-byungchul@sk.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrILMWRmVeSWpSXmKPExsXC9ZZnoS53yZFUg23r2CzmrF/DZvF5wz82
	ixcb2hktvq7/xWzx9FMfi8XlXXPYLO6t+c9qcX7XWlaLHUv3MVlcOrCAyeL6roeMFsd7DzBZ
	zL/3mc1i86apzBbHp0xltPj9A6jj5KzJLA6CHt9b+1g8ds66y+6xYFOpx+YVWh6L97xk8ti0
	qpPNY9OnSewe786dY/c4MeM3i8e8k4Ee7/ddZfPY+svOo3HqNTaPz5vkPN7Nf8sWwB/FZZOS
	mpNZllqkb5fAlXH79kumglV8FUt+tLM1ME7j6WLk5JAQMJGYuHUdM4y97csFRhCbTUBd4saN
	n2BxEQEziYOtf9i7GLk4mAU+Mkms/t7BApIQFgiWuL7qExuIzSKgKrF5zx8mEJtXwFRi55T9
	LBBD5SVWbzgANogTaNDObadYQWwhoJoXsyezgQyVEGhnl1g57wYjRIOkxMEVN1gmMPIuYGRY
	xSiUmVeWm5iZY6KXUZmXWaGXnJ+7iREYEctq/0TvYPx0IfgQowAHoxIP74nyw6lCrIllxZW5
	hxglOJiVRHjNdhxIFeJNSaysSi3Kjy8qzUktPsQozcGiJM5r9K08RUggPbEkNTs1tSC1CCbL
	xMEp1cAYub/cWXVhd03Z9S05PF7Xdm3dYl1vu2DF2RQjw4scU14tneW8if863wu9GczeKjN+
	+aVN4VOseqx8V0WQ31JV0Puyxo2LHOy9T+6/e3dQfVV95bJ2+wdJH07Ybn3pwKLpVvFeuvNM
	dujHoEmHD6r9Dcq4J/CA6VdausbTXccb+fSjWQoW6lxXYinOSDTUYi4qTgQAo4YPLYQCAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrBLMWRmVeSWpSXmKPExsXC5WfdrMtVciTVoPW6qcWc9WvYLD5v+Mdm
	8WJDO6PF1/W/mC2efupjsTg89ySrxeVdc9gs7q35z2pxftdaVosdS/cxWVw6sIDJ4vquh4wW
	x3sPMFnMv/eZzWLzpqnMFsenTGW0+P0DqOPkrMksDkIe31v7WDx2zrrL7rFgU6nH5hVaHov3
	vGTy2LSqk81j06dJ7B7vzp1j9zgx4zeLx7yTgR7v911l81j84gOTx9Zfdh6NU6+xeXzeJOfx
	bv5btgCBKC6blNSczLLUIn27BK6M27dfMhWs4qtY8qOdrYFxGk8XIyeHhICJxLYvFxhBbDYB
	dYkbN34yg9giAmYSB1v/sHcxcnEwC3xkklj9vYMFJCEsECxxfdUnNhCbRUBVYvOeP0wgNq+A
	qcTOKftZIIbKS6zecABsECfQoJ3bTrGC2EJANS9mT2abwMi1gJFhFaNIZl5ZbmJmjqlecXZG
	ZV5mhV5yfu4mRmB4L6v9M3EH45fL7ocYBTgYlXh4T5QfThViTSwrrsw9xCjBwawkwmu240Cq
	EG9KYmVValF+fFFpTmrxIUZpDhYlcV6v8NQEIYH0xJLU7NTUgtQimCwTB6dUAyN76BPlyY/y
	tq+8Iv+2ci1/eYl90+u8zrdxLNd364df1HT9bzPRaeGy75+m/nJ49pt3JXe9XwK/8srQ1TNW
	uZ0/YX70wHrVR2o93nc25UhOXFWtsKj6z8FJEcGTbu70XDtJwMpI6+aOxQ2/31o+f/LgxWvW
	h1u+bn6iONPhb9/6rc92GdWqnJifrsRSnJFoqMVcVJwIAFYAZeNrAgAA
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


