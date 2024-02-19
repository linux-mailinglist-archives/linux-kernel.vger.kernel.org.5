Return-Path: <linux-kernel+bounces-70768-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B82F859BF9
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 07:24:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7DF0D1C20C29
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 06:24:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADBA6200BA;
	Mon, 19 Feb 2024 06:24:24 +0000 (UTC)
Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7C841F941
	for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 06:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708323864; cv=none; b=NYoi5MXWRcWz/c59WJsBCpsAgZ38zOru8FgvPgbqaKMU0U/ohUJmnsYlNDk+jYuLdqZjYoek1N/8GqYCKE7ToQvXHTYeI5mGOub4m1KVSzGMB/DK2E6K0Vl6ZhdkVyQ6y6MbgKqEktpi4FpDCTYjzM1a3dPE4HjnHT9rVUCMFOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708323864; c=relaxed/simple;
	bh=jCdznYeqTxnAdPqUo3goftYDv+lHb7g10nhlhcikrfU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=Upxw7KNFf0yorZByzhQAda0G3BWn/LZ4hgDZ1dVPu2W/hjj5lMJ9VD4PKMadlnG7IhL0xzbDFdXao/6uizHlbLPx7yxtV9zSpWdxxEbASeZ5L8A88maiSavLfzs5OfhIZJPcfBDYqysdRsGVrtmNziaqVUXxjdJyIpQH/dJEDm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-d6dff70000001748-bd-65d2ef615024
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
Subject: [PATCH v8 1/8] x86/tlb: Add APIs manipulating tlb batch's arch data
Date: Mon, 19 Feb 2024 15:04:00 +0900
Message-Id: <20240219060407.25254-2-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240219060407.25254-1-byungchul@sk.com>
References: <20240219060407.25254-1-byungchul@sk.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrALMWRmVeSWpSXmKPExsXC9ZZnkW7i+0upBt8fqFrMWb+GzeLzhn9s
	Fi82tDNafF3/i9ni6ac+FovLu+awWdxb85/V4vyutawWO5buY7K4dGABk8X1XQ8ZLY73HmCy
	mH/vM5vF5k1TmS2OT5nKaPH7B1DHyVmTWRwEPb639rF47Jx1l91jwaZSj80rtDwW73nJ5LFp
	VSebx6ZPk9g93p07x+5xYsZvFo95JwM93u+7yuax9ZedR+PUa2wenzfJebyb/5YtgD+KyyYl
	NSezLLVI3y6BK+P27ZdMBav4Kpb8aGdrYJzG08XIySEhYCKx8vp0Nhj73PUDYDabgLrEjRs/
	mUFsEQEziYOtf9i7GLk4mAU+Mkms/t7BApIQFvCRWHz/H5jNIqAq0T3zHROIzStgKnFq2gYW
	iKHyEqs3HAAaxMHBCTRo90EhkLAQUMmJq5OZQGZKCLSzS/y7s50Vol5S4uCKGywTGHkXMDKs
	YhTKzCvLTczMMdHLqMzLrNBLzs/dxAiMh2W1f6J3MH66EHyIUYCDUYmHN0PkUqoQa2JZcWXu
	IUYJDmYlEV73pgupQrwpiZVVqUX58UWlOanFhxilOViUxHmNvpWnCAmkJ5akZqemFqQWwWSZ
	ODilGhjl/X6+u7dnlu2ZRwY71ty++sdgFYPOt4qkaT4eF6ZceLywbZVx62wRNpHKr36577VM
	HOqfH5NYG3WYYcd2tT/x5VIPJ1n6X0ubFbeo7NPtlvVRm9JPy/fNcN6gnb434MgDB8XHt3kZ
	nl55pz61IK+E33KRjPr+6JxL+Q5XbjKXB5fUKl7bv++oEktxRqKhFnNRcSIAuMXYj4MCAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrOLMWRmVeSWpSXmKPExsXC5WfdrJv4/lKqwZevUhZz1q9hs/i84R+b
	xYsN7YwWX9f/YrZ4+qmPxeLw3JOsFpd3zWGzuLfmP6vF+V1rWS12LN3HZHHpwAImi+u7HjJa
	HO89wGQx/95nNovNm6YyWxyfMpXR4vcPoI6TsyazOAh5fG/tY/HYOesuu8eCTaUem1doeSze
	85LJY9OqTjaPTZ8msXu8O3eO3ePEjN8sHvNOBnq833eVzWPxiw9MHlt/2Xk0Tr3G5vF5k5zH
	u/lv2QIEorhsUlJzMstSi/TtErgybt9+yVSwiq9iyY92tgbGaTxdjJwcEgImEueuH2ADsdkE
	1CVu3PjJDGKLCJhJHGz9w97FyMXBLPCRSWL19w4WkISwgI/E4vv/wGwWAVWJ7pnvmEBsXgFT
	iVPTNrBADJWXWL3hANAgDg5OoEG7DwqBhIWASk5cncw0gZFrASPDKkaRzLyy3MTMHFO94uyM
	yrzMCr3k/NxNjMDgXlb7Z+IOxi+X3Q8xCnAwKvHwZohcShViTSwrrsw9xCjBwawkwuvedCFV
	iDclsbIqtSg/vqg0J7X4EKM0B4uSOK9XeGqCkEB6YklqdmpqQWoRTJaJg1OqgdHK2n/Sdu7V
	/xe/iok3ct0vt4ZJpKPoyqFNhhYaFd6TWU5/dn/l+ObD9QxrvaN3Z2S4VmhcMhZ8uNh1OZPF
	+tiAU83Hln/jTmg6bfLN66XQtfu7VkQd4vyxcIPwk+UvT1VHrNiVrfz8zdUHSuvnP128TV9B
	L1eKZX+k3f8PxRppdi5Vaz3SlfuUWIozEg21mIuKEwGcMv88agIAAA==
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


