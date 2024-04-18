Return-Path: <linux-kernel+bounces-149559-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4738F8A92DE
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 08:16:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EDB32281F6F
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 06:16:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBDF671753;
	Thu, 18 Apr 2024 06:15:54 +0000 (UTC)
Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 761B44EB32
	for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 06:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713420954; cv=none; b=hZgFtjHEQebwDv5N1HiAodqHTdMZVfwET7uFR3rGdFC0QNvlQ74b6ABS4aVK2dfLOaMAQDreZ1cJm2u37AgSE29yQbt+DJTUpwUSTYCX4wngV1L0nTpVY3VpxX6B57sNpEqnIuP1g14Jjj8peHqsU+fMZbnNFKuFiH+Q++32THQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713420954; c=relaxed/simple;
	bh=2MKSxAJ2mBZDz9V39JhFe+05XOOJBWLN/9CInRv7UqI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=mMqm/x5ZrVT0Ib0izvBE/xauTtswiTSi53rlOGrT3tGG+m3GLH5FzJryCI5JdSj4EXQPfVxOrqa3qAbe6eFbY+BSM2L70SYJ9kVNLz2W2kZQVAbz4TTnsaxdnWknwuyFWW/fks75Hb8psHrlWaNjhsguul0OSa9VE86oMvU62RA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-d6dff70000001748-fd-6620ba924102
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
Subject: [PATCH v9 rebase on mm-unstable 1/8] x86/tlb: add APIs manipulating tlb batch's arch data
Date: Thu, 18 Apr 2024 15:15:29 +0900
Message-Id: <20240418061536.11645-2-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240418061536.11645-1-byungchul@sk.com>
References: <20240418061536.11645-1-byungchul@sk.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrCLMWRmVeSWpSXmKPExsXC9ZZnke6kXQppBi2zjS3mrF/DZvF5wz82
	ixcb2hktvq7/xWzx9FMfi8XlXXPYLO6t+c9qcX7XWlaLHUv3MVlcOrCAyeJ47wEmi/n3PrNZ
	bN40ldni+JSpjBa/fwAVn5w1mcVBwON7ax+Lx85Zd9k9Fmwq9di8Qstj8Z6XTB6bVnWyeWz6
	NInd4925c+weJ2b8ZvGYdzLQ4/2+q2weW3/ZeTROvcbm8XmTXABfFJdNSmpOZllqkb5dAldG
	w70XLAVr+Cp6P81naWCcydPFyMEhIWAisXuxShcjJ5h5/FETE4jNJqAucePGT2YQW0TATOJg
	6x92EJtZ4C6TxIF+NhBbWCBJ4uP+GWA2i4CqxKOHXawgNq+AqcTSnd2MEDPlJVZvOAA2hxNo
	Tv/7Q4wga4WAai78Deli5AIqec8m8epUKxNEvaTEwRU3WCYw8i5gZFjFKJSZV5abmJljopdR
	mZdZoZecn7uJERj2y2r/RO9g/HQh+BCjAAejEg/vyQPyaUKsiWXFlbmHGCU4mJVEeFuEZdOE
	eFMSK6tSi/Lji0pzUosPMUpzsCiJ8xp9K08REkhPLEnNTk0tSC2CyTJxcEo1MFqb/PT/tpbn
	3aTwWxt1nfR13k+2FJSUv/im4+WhY5eUFp0UeMYVnOjg/c65nn+i+umv/J+37n/x483RF/oX
	P/0UCVWV/vcurv68zwnzqoJ35pKhjmIJ85Xk9KOc9X5u8ZSZxa1/w+jU2VeJnQpXThvee3BF
	k1vpCeOxNSdDGKIKE9y1tbeqiSqxFGckGmoxFxUnAgDQigswdwIAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrDLMWRmVeSWpSXmKPExsXC5WfdrDtpl0KawZRfGhZz1q9hs/i84R+b
	xYsN7YwWX9f/YrZ4+qmPxeLw3JOsFpd3zWGzuLfmP6vF+V1rWS12LN3HZHHpwAImi+O9B5gs
	5t/7zGaxedNUZovjU6YyWvz+AVR8ctZkFgdBj++tfSweO2fdZfdYsKnUY/MKLY/Fe14yeWxa
	1cnmsenTJHaPd+fOsXucmPGbxWPeyUCP9/uusnksfvGByWPrLzuPxqnX2Dw+b5IL4I/isklJ
	zcksSy3St0vgymi494KlYA1fRe+n+SwNjDN5uhg5OSQETCSOP2piArHZBNQlbtz4yQxiiwiY
	SRxs/cMOYjML3GWSONDPBmILCyRJfNw/A8xmEVCVePSwixXE5hUwlVi6s5sRYqa8xOoNB8Dm
	cALN6X9/CCjOwSEEVHPhb8gERq4FjAyrGEUy88pyEzNzTPWKszMq8zIr9JLzczcxAsN4We2f
	iTsYv1x2P8QowMGoxMN74oB8mhBrYllxZe4hRgkOZiUR3hZh2TQh3pTEyqrUovz4otKc1OJD
	jNIcLErivF7hqQlCAumJJanZqakFqUUwWSYOTqkGxoVt8vsezf/IU1n9/PvbOR9t2n9fmGn/
	TD+yb6VQSPA1wyWcZp5SnRtL3z1YE5jHp7yUY4eehY6k6N7XebFz9/F9OzFrqb+kGHf1u4Wn
	Gv2yfjdqyk38tXg9u8QrEfaNVxwZi8J8pj53dm5NmpTDcVF9/r7KW5On+/TtPuLJKPxhy9uq
	3GdP9ZRYijMSDbWYi4oTARgcRMNfAgAA
X-CFilter-Loop: Reflected
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

This is a preparation for migrc mechanism that needs to recognize
read-only tlb entries during migration by separating tlb batch arch data
into two, one is for read-only entries and the other is for writable
ones, and merging those two when needed.

Migrc also needs to optimize tlb shootdown by skipping CPUs that have
already performed tlb flush needed for a while.  To support it, added
APIs manipulating arch data for x86.

Signed-off-by: Byungchul Park <byungchul@sk.com>
---
 arch/x86/include/asm/tlbflush.h | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/arch/x86/include/asm/tlbflush.h b/arch/x86/include/asm/tlbflush.h
index 25726893c6f4..a14f77c5cdde 100644
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
+	return !cpumask_andnot(&bdst->cpumask, &bdst->cpumask, &bsrc->cpumask);
+}
+
 static inline bool pte_flags_need_flush(unsigned long oldflags,
 					unsigned long newflags,
 					bool ignore_access)
-- 
2.17.1


