Return-Path: <linux-kernel+bounces-32245-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7876B83590C
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 02:01:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AAEA51C2177F
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 01:01:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1032139E;
	Mon, 22 Jan 2024 01:01:04 +0000 (UTC)
Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3D23364
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 01:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705885264; cv=none; b=Wkfb2tGRdn3aleP/ia+qLoNAVSsBQ+eVdAKoLlk0FZh1jPT5iEpNfF5mSJPO1mqdCSec19pVmYYEqmNFXKrO1yOqRrkQ1S5Mt58fz1snriJAgEI0JIwWouGndPxBEJkfCNHNZvnCFwC+G2lI/rwHW9wLLtqGmXLPhbsOl2lzqno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705885264; c=relaxed/simple;
	bh=jCdznYeqTxnAdPqUo3goftYDv+lHb7g10nhlhcikrfU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=LZx/NdAz0hVTidEtgxSo6uf3yABF+7DlJBlGLsoqej40HvxHDZZy4tm7oV0bZjGtLjKTaLayy+kA24ck58V17D1QkT/WrnDJ3G71UQO7nwRiJNpqpzy+9dBo91Zj6Agzs9fSdN0qn/dVWJXdGW8C1//qYAYHVKBhFhRMwNT4chs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-d85ff70000001748-6d-65adbe43e950
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
Subject: [PATCH v7 1/8] x86/tlb: Add APIs manipulating tlb batch's arch data
Date: Mon, 22 Jan 2024 10:00:33 +0900
Message-Id: <20240122010040.74346-2-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240122010040.74346-1-byungchul@sk.com>
References: <20240122010040.74346-1-byungchul@sk.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrPLMWRmVeSWpSXmKPExsXC9ZZnka7zvrWpBgunSVnMWb+GzeLzhn9s
	Fi82tDNafF3/i9ni6ac+FovLu+awWdxb85/V4vyutawWO5buY7K4dGABk8X1XQ8ZLY73HmCy
	mH/vM5vF5k1TmS2OT5nKaPH7B1DHyVmTWRwEPb639rF47Jx1l91jwaZSj80rtDwW73nJ5LFp
	VSebx6ZPk9g93p07x+5xYsZvFo95JwM93u+7yuax9ZedR+PUa2wenzfJebyb/5YtgD+KyyYl
	NSezLLVI3y6BK+P27ZdMBav4Kpb8aGdrYJzG08XIwSEhYCJxZXNgFyMnmPnnxXt2EJtNQF3i
	xo2fzCC2iICZxMHWP0BxLg5mgY9MEqu/d7CAJIQFfCQmHm5mApnDIqAq8XmTE0iYV8BU4uDG
	14wQM+UlVm84ADaHE2jOlF9dTCC2EFDN3A87GUFmSgi0s0ts7p3PBtEgKXFwxQ2WCYy8CxgZ
	VjEKZeaV5SZm5pjoZVTmZVboJefnbmIERsOy2j/ROxg/XQg+xCjAwajEw+vAvjZViDWxrLgy
	9xCjBAezkggvv+qqVCHelMTKqtSi/Pii0pzU4kOM0hwsSuK8Rt/KU4QE0hNLUrNTUwtSi2Cy
	TBycUg2Mq44Xf1h3iJtfq3Lpgi+TuS5bvTrVez/0xVxXZn9fs1Mzzv/aUrjt2yStn3X5orzP
	BL0lxf6aXrm8XVrZQ8pIRqBwm+OlZKtD53yk1Ix05re7vZn+I3FPXNqsac+Vnlgmphrk6C4L
	te098muTMteG06GvGC9cSrfviLp4uVT27qzDZktdhJ8cU2Ipzkg01GIuKk4EAPEP+0yCAgAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrOLMWRmVeSWpSXmKPExsXC5WfdrOu8b22qwckZ/BZz1q9hs/i84R+b
	xYsN7YwWX9f/YrZ4+qmPxeLw3JOsFpd3zWGzuLfmP6vF+V1rWS12LN3HZHHpwAImi+u7HjJa
	HO89wGQx/95nNovNm6YyWxyfMpXR4vcPoI6TsyazOAh5fG/tY/HYOesuu8eCTaUem1doeSze
	85LJY9OqTjaPTZ8msXu8O3eO3ePEjN8sHvNOBnq833eVzWPxiw9MHlt/2Xk0Tr3G5vF5k5zH
	u/lv2QIEorhsUlJzMstSi/TtErgybt9+yVSwiq9iyY92tgbGaTxdjJwcEgImEn9evGcHsdkE
	1CVu3PjJDGKLCJhJHGz9AxTn4mAW+Mgksfp7BwtIQljAR2Li4WamLkYODhYBVYnPm5xAwrwC
	phIHN75mhJgpL7F6wwGwOZxAc6b86mICsYWAauZ+2Mk4gZFrASPDKkaRzLyy3MTMHFO94uyM
	yrzMCr3k/NxNjMDgXlb7Z+IOxi+X3Q8xCnAwKvHwOrCvTRViTSwrrsw9xCjBwawkwsuvuipV
	iDclsbIqtSg/vqg0J7X4EKM0B4uSOK9XeGqCkEB6YklqdmpqQWoRTJaJg1OqgTHftnX2xfx3
	FenT6ut/s2VKcJ9/P0X5S+rcc488mncab3jINtmTL5bhx+flJ8PMprJJv/2+6e6f40XNjtwH
	TiRp7hY0PyrlH2Vb6lzZ8G+n87uG50WGi89xLkqT+PEk5VbsYR2ObMHTm12uP57CJz5R+Hp0
	X98Bu3C/2eb+b7/P+vq2x3/ltMVKLMUZiYZazEXFiQAKYOYmagIAAA==
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


