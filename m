Return-Path: <linux-kernel+bounces-148054-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D3CD8A7D1E
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 09:34:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 475AF1C210D5
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 07:34:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 054E16F065;
	Wed, 17 Apr 2024 07:34:23 +0000 (UTC)
Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 367E4184D
	for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 07:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713339262; cv=none; b=KTZ4QRFqi+9xUdFdVk/MHe1hUYQOsz8hA92YVT1+UF1+yVFtUt7LG0SezXB/uBqiY435KRXUi8MN9Tl9dX4q/QSkJojCX2E/+8WpG8l6HMlhQG2CFCGxJwLYx0komFABGdQj3yUFjTxbADbrzgVT9t6pY7I3abh7Z5Vu3D01rEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713339262; c=relaxed/simple;
	bh=2MKSxAJ2mBZDz9V39JhFe+05XOOJBWLN/9CInRv7UqI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=c4HcZMFSjyVOw1asdJ33kf0FSJXf23U5QSe7ycTnj26UNHbPG/Gd8QxQ83MfcvX6IySyjticCk6mMgq9m4g+pX6hVL2Ic5B67KbRcAOlWKb5JANiziu2XTqtWMpjxhgiecovvE+NdUUMBFyocgvH/Bgq0SDgPGdKoBgJoFDZ5SQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-d6dff70000001748-92-661f77e2e210
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
Subject: [PATCH v9 1/8] x86/tlb: add APIs manipulating tlb batch's arch data
Date: Wed, 17 Apr 2024 16:18:40 +0900
Message-Id: <20240417071847.29584-2-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240417071847.29584-1-byungchul@sk.com>
References: <20240417071847.29584-1-byungchul@sk.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrGLMWRmVeSWpSXmKPExsXC9ZZnke6jcvk0g2eL+S3mrF/DZvF5wz82
	ixcb2hktvq7/xWzx9FMfi8XlXXPYLO6t+c9qcX7XWlaLHUv3MVlcOrCAyeJ47wEmi/n3PrNZ
	bN40ldni+JSpjBa/fwAVn5w1mcVBwON7ax+Lx85Zd9k9Fmwq9di8Qstj8Z6XTB6bVnWyeWz6
	NInd4925c+weJ2b8ZvGYdzLQ4/2+q2weW3/ZeTROvcbm8XmTXABfFJdNSmpOZllqkb5dAldG
	w70XLAVr+Cp6P81naWCcydPFyMkhIWAi8W72FGYY++nLfjCbTUBd4saNn2C2iICZxMHWP+wg
	NrPAXSaJA/1sILawgI/EqZl9YDaLgKpE7/9zYPW8AqYS8xfeZ4KYKS+xesMBsDgn0JzNzWvA
	6oWAar6f+AhkcwHVvGaTWPu7hRGiQVLi4IobLBMYeRcwMqxiFMrMK8tNzMwx0cuozMus0EvO
	z93ECAz9ZbV/oncwfroQfIhRgINRiYfXIEouTYg1say4MvcQowQHs5IIb4uwbJoQb0piZVVq
	UX58UWlOavEhRmkOFiVxXqNv5SlCAumJJanZqakFqUUwWSYOTqkGRgu7/neSpzNfWF7d2Lk2
	dC/DHIZZX3gaOacKqexSjTioVPPO7oNb4kpmpoPPZPmPhSwKClt2N5NzcYILa1bwnk1JvQnR
	ovdur2zmZ3YW+8EqyfmLceL7ULPpwtsPb77gFuQe0RvINuHedual/xecen1k2qELr+ISdhfI
	VCxmWxztHG+ykee+jxJLcUaioRZzUXEiANheHqx5AgAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrLLMWRmVeSWpSXmKPExsXC5WfdrPuoXD7NYNZCFos569ewWXze8I/N
	4sWGdkaLr+t/MVs8/dTHYnF47klWi8u75rBZ3Fvzn9Xi/K61rBY7lu5jsrh0YAGTxfHeA0wW
	8+99ZrPYvGkqs8XxKVMZLX7/ACo+OWsyi4Ogx/fWPhaPnbPusnss2FTqsXmFlsfiPS+ZPDat
	6mTz2PRpErvHu3Pn2D1OzPjN4jHvZKDH+31X2TwWv/jA5LH1l51H49RrbB6fN8kF8Edx2aSk
	5mSWpRbp2yVwZTTce8FSsIavovfTfJYGxpk8XYycHBICJhJPX/Yzg9hsAuoSN278BLNFBMwk
	Drb+YQexmQXuMkkc6GcDsYUFfCROzewDs1kEVCV6/58Dq+cVMJWYv/A+E8RMeYnVGw6AxTmB
	5mxuXgNWLwRU8/3ER7YJjFwLGBlWMYpk5pXlJmbmmOoVZ2dU5mVW6CXn525iBAbysto/E3cw
	frnsfohRgINRiYfXIEouTYg1say4MvcQowQHs5IIb4uwbJoQb0piZVVqUX58UWlOavEhRmkO
	FiVxXq/w1AQhgfTEktTs1NSC1CKYLBMHp1QDo8PJ4HcKjJfDDhsqXSyp/FZhuOwrY1C3surV
	C1NU/jpKbZdVnZJidkB0wrQXtVX+rya5Lb7RO5H/0cov/KffX2D235J4t9zZU7Rh326/o0ur
	8n85+M4Rs3q2LVbPe1Po81+dnhMeLlivkiIV/kV4u2/R/oVCWvcvtzp7tGo4nZmkYnDi+/q6
	d0osxRmJhlrMRcWJALm+JTdgAgAA
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


