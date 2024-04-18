Return-Path: <linux-kernel+bounces-149561-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C6B9D8A92DF
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 08:16:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 047D41C20CCB
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 06:16:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53DD078286;
	Thu, 18 Apr 2024 06:15:56 +0000 (UTC)
Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC3136A8A0
	for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 06:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713420955; cv=none; b=S5u/zKiS4q3+swhIKvblwTzpN9FnBKPnai1LXxVuBkOWKlTxulM2itqMIReVAgbVH4jb6TXOf6Gb+S2nmhN+a5GSFlg6qhDiCrmCV/wkj/0YDigQv4W2vg9ZxUZif5b33fDOw9FbaWE64+ydQ1REJ5E6I/ekOMLotmDP2w5jGcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713420955; c=relaxed/simple;
	bh=Gvdnrdhu2FdXMBBsWQE2ekKa7OCnN7+KcT/XIeS8gnI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=MgL93xEZek5EIv9rTAbfbVo3Z5ctdlI/ZWEb7J1p+50fTVQtEW3drULMuXDGcLZWEKpEDpk/tlPVcRvrjhY7yXPSpcagrG7DJa2Wa+mJ3mmYTy5UdOXHtGTu4gVvaQaiGNMCNcVkfLJX27rcHoIR3JxSkoUGOud8zVbcqUD/FZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-d6dff70000001748-0c-6620ba922584
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
Subject: [PATCH v9 rebase on mm-unstable 4/8] x86/tlb, mm/rmap: separate arch_tlbbatch_clear() out of arch_tlbbatch_flush()
Date: Thu, 18 Apr 2024 15:15:32 +0900
Message-Id: <20240418061536.11645-5-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240418061536.11645-1-byungchul@sk.com>
References: <20240418061536.11645-1-byungchul@sk.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrCLMWRmVeSWpSXmKPExsXC9ZZnke7kXQppBqf3slnMWb+GzeLzhn9s
	Fi82tDNafF3/i9ni6ac+FovLu+awWdxb85/V4vyutawWO5buY7K4dGABk8Xx3gNMFvPvfWaz
	2LxpKrPF8SlTGS1+/wAqPjlrMouDgMf31j4Wj52z7rJ7LNhU6rF5hZbH4j0vmTw2repk89j0
	aRK7x7tz59g9Tsz4zeIx72Sgx/t9V9k8tv6y82iceo3N4/MmuQC+KC6blNSczLLUIn27BK6M
	KZPWsBQc56ho3TqFsYGxlb2LkZNDQsBEYu27N3D2/7snWUBsNgF1iRs3fjKD2CICZhIHW/+A
	1TAL3GWSONDPBmILC1RLfG5cCFbDIqAq8fj/O0YQm1fAVKJnbwMjxEx5idUbDoDVcALN6X9/
	CCjOwSEEVHPhbwhEyXs2ieb38RC2pMTBFTdYJjDyLmBkWMUolJlXlpuYmWOil1GZl1mhl5yf
	u4kRGPbLav9E72D8dCH4EKMAB6MSD+/JA/JpQqyJZcWVuYcYJTiYlUR4W4Rl04R4UxIrq1KL
	8uOLSnNSiw8xSnOwKInzGn0rTxESSE8sSc1OTS1ILYLJMnFwSjUwCk3uZfrSsPH9zIkXi08F
	slde/X+n9kHNY0eXeM3Lq05Ps3W3aPkYuFfntZlJz7nEXQKFrXUv1ha9/zmPvXFKfOhinRcv
	0h7oa1VuTq6Vdbzw4BvnI6Wa3VPu+DjOn6G58vaZ2ye8xbc72TzpTHlefDwkaNZB68/pS/Y8
	z9rCusi0Y93uKVOfrFZiKc5INNRiLipOBAAneZAsdwIAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrDLMWRmVeSWpSXmKPExsXC5WfdrDtpl0Kawa5tVhZz1q9hs/i84R+b
	xYsN7YwWX9f/YrZ4+qmPxeLw3JOsFpd3zWGzuLfmP6vF+V1rWS12LN3HZHHpwAImi+O9B5gs
	5t/7zGaxedNUZovjU6YyWvz+AVR8ctZkFgdBj++tfSweO2fdZfdYsKnUY/MKLY/Fe14yeWxa
	1cnmsenTJHaPd+fOsXucmPGbxWPeyUCP9/uusnksfvGByWPrLzuPxqnX2Dw+b5IL4I/isklJ
	zcksSy3St0vgypgyaQ1LwXGOitatUxgbGFvZuxg5OSQETCT+3z3JAmKzCahL3LjxkxnEFhEw
	kzjY+geshlngLpPEgX42EFtYoFric+NCsBoWAVWJx//fMYLYvAKmEj17GxghZspLrN5wAKyG
	E2hO//tDQHEODiGgmgt/QyYwci1gZFjFKJKZV5abmJljqlecnVGZl1mhl5yfu4kRGMbLav9M
	3MH45bL7IUYBDkYlHt4TB+TThFgTy4orcw8xSnAwK4nwtgjLpgnxpiRWVqUW5ccXleakFh9i
	lOZgURLn9QpPTRASSE8sSc1OTS1ILYLJMnFwSjUwqnh2HZLUbfrcdOa06EoheQvdyx/NTvxa
	WHLpcdaiPzXKK1x2Po9dWyr4eMPBP8yx6YZx6y5pz16kN7FO63rjvWTPXVPeVG21yf1nbpK5
	u1uNbcvBouX5tSXX9SfeKN79qcPc+WvY2ZTNrtEFH8vP6l52PqT7qGlCsXR3su6FjyuitVx4
	2GTvKLEUZyQaajEXFScCAPLLS9dfAgAA
X-CFilter-Loop: Reflected
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

This is a preparation for migrc mechanism that requires to avoid
redundant tlb flushes by manipulating tlb batch's arch data.  To achieve
that, it's needed to separate the part clearing the tlb batch's arch
data out of arch_tlbbatch_flush().

Signed-off-by: Byungchul Park <byungchul@sk.com>
---
 arch/x86/mm/tlb.c | 2 --
 mm/rmap.c         | 1 +
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/x86/mm/tlb.c b/arch/x86/mm/tlb.c
index 44ac64f3a047..24bce69222cd 100644
--- a/arch/x86/mm/tlb.c
+++ b/arch/x86/mm/tlb.c
@@ -1265,8 +1265,6 @@ void arch_tlbbatch_flush(struct arch_tlbflush_unmap_batch *batch)
 		local_irq_enable();
 	}
 
-	cpumask_clear(&batch->cpumask);
-
 	put_flush_tlb_info();
 	put_cpu();
 }
diff --git a/mm/rmap.c b/mm/rmap.c
index c37ff1648cf1..513e49840da7 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -673,6 +673,7 @@ void try_to_unmap_flush(void)
 		return;
 
 	arch_tlbbatch_flush(&tlb_ubc->arch);
+	arch_tlbbatch_clear(&tlb_ubc->arch);
 	tlb_ubc->flush_required = false;
 	tlb_ubc->writable = false;
 }
-- 
2.17.1


