Return-Path: <linux-kernel+bounces-127171-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B10878947B7
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 01:30:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 672F928371F
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 23:30:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F241C58AA8;
	Mon,  1 Apr 2024 23:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GtQvJacL"
Received: from mail-vk1-f202.google.com (mail-vk1-f202.google.com [209.85.221.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66FEE56B99
	for <linux-kernel@vger.kernel.org>; Mon,  1 Apr 2024 23:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712014201; cv=none; b=GDLnQWIdYD45V6WxiHEwzfbq/EZPkG4tEtP5JwAfq03Mm7fAgcyslz0NaV4zDxbL5HRh0cyxqai0waX3DogxQCAcmXzoFaoIKMqB+1+LZE/b8+XUxlkgjCl+F+eYp6v44OTTtFtU1QJGmROT/oglqMVDNQbTkx+Np3eidCEx2Kw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712014201; c=relaxed/simple;
	bh=/sojkNHgAkXV2li3H4WMuqhMOGJZX+4+iRjYtJcWaOM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=d4TU4tq8+W2Rkp/z/jVVJRqsyBLbi4b5vuikg0KiTptYRQ0ROdIcYNav9psD0BTIWriruCuEf1MyHU7FmKxtunSt3yK8qEt0ObbQ2DIsSQI+nmea92LeJSCwTvu9XOODsstETu6nNhar72hIZKG2WuzOadKDM8hYqKoJQR0ZbXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jthoughton.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GtQvJacL; arc=none smtp.client-ip=209.85.221.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jthoughton.bounces.google.com
Received: by mail-vk1-f202.google.com with SMTP id 71dfb90a1353d-4d457af2d41so1886014e0c.3
        for <linux-kernel@vger.kernel.org>; Mon, 01 Apr 2024 16:29:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712014197; x=1712618997; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=XjV19huKRvwcv3bjf5GpogmLoEGdyfdviROgtmpM2BI=;
        b=GtQvJacLFGy8AEBpRIUED1qWman0u+sYzN2LTmlvRmNb0c1Rbx/JZwH9tre5/Ckp06
         nMD/WWUrr6jN7f50DQa0x9IDfE0DJi3Cac9LYRXu5HIUkpvh9ah5bjU0QxHtQa5ZcgDh
         1YBWKKbyo38dYTe+VupFioIMocvCem6e9K54F9c0EuhHlOO2jioc3+FkQGoEMgUso7GF
         Aa36XHhLwgFS2j7ea8rwvKuTD1WSDSC37yb1Pc5F0LKpPW/oXRveZnWoXtUDwTj4aF8o
         2LRaEADrX2h+Dq+XUSFBXfHf0wghDDpHi0yJRSs8sMH+Z5xI/yD2+8X548vPoQsA3+YQ
         uU/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712014197; x=1712618997;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XjV19huKRvwcv3bjf5GpogmLoEGdyfdviROgtmpM2BI=;
        b=w3nRQrPjKQP3ZU8OkOCsJrhMdl2nG2ArlFQO3OFf7whaETzvSDG8zBo06focdBa6cj
         L6E8V1BJcYvSnUkmdD6TwE8rRZCaWP0apP/VIWSPsmaOOVYoL98K7AdyI1gWiU6T29T6
         DKTSqpbfLMXFWZKuXel/cHcMm+SFLX/QZTcGUC19fOPVT9LRKyi3LgUoucx+6K+o/xc6
         PBfrnUuVEfVQMuicp91ReZur2sVtor74v4X/lYXVhBevFYuy4kig+ntsJPKCer6cDIC0
         3B8bm2fzaSiQH7Xf/FyTwvVbYOM6LDPaSu+yGWBiWXT8LrW3rSk2zFk+bw9d+pcn10Sq
         S+5g==
X-Forwarded-Encrypted: i=1; AJvYcCV9y1LW3NSXDBhr3aQ9WBv7eqOSa+QWeIbdlzd5e7eoldTF22DwIBfvTzkAYnqpHwsjTRCpVdxdL+zsmLKWN4eIvAFEXjeUyq6QE9oz
X-Gm-Message-State: AOJu0YylF5Rx0AR1wsJSJ/yQW9xHrH6dqBb3SreuOLcseMej7NJR99K/
	mMj1pRhN8HFgElZOshoYpfaTDgYCefeUUAqp0IsnGBvUNUEUmdmHcz+mRGvZ12lpoFFAa+ekxCZ
	tPHOdCL8k9GA+1aIT5w==
X-Google-Smtp-Source: AGHT+IFUopEMKakeSmmDQQkpzKxlNJ65mvpQqylZZQK+yo+BzjzMVCQHtrhU8U2Q57twwQQQfTybPo3O3BawFKgE
X-Received: from jthoughton.c.googlers.com ([fda3:e722:ac3:cc00:14:4d90:c0a8:2a4f])
 (user=jthoughton job=sendgmr) by 2002:ac5:c281:0:b0:4d8:73c1:9ec7 with SMTP
 id h1-20020ac5c281000000b004d873c19ec7mr84232vkk.0.1712014197363; Mon, 01 Apr
 2024 16:29:57 -0700 (PDT)
Date: Mon,  1 Apr 2024 23:29:40 +0000
In-Reply-To: <20240401232946.1837665-1-jthoughton@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240401232946.1837665-1-jthoughton@google.com>
X-Mailer: git-send-email 2.44.0.478.gd926399ef9-goog
Message-ID: <20240401232946.1837665-2-jthoughton@google.com>
Subject: [PATCH v3 1/7] mm: Add a bitmap into mmu_notifier_{clear,test}_young
From: James Houghton <jthoughton@google.com>
To: Andrew Morton <akpm@linux-foundation.org>, Paolo Bonzini <pbonzini@redhat.com>
Cc: Yu Zhao <yuzhao@google.com>, David Matlack <dmatlack@google.com>, 
	Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>, 
	Sean Christopherson <seanjc@google.com>, Jonathan Corbet <corbet@lwn.net>, James Morse <james.morse@arm.com>, 
	Suzuki K Poulose <suzuki.poulose@arm.com>, Zenghui Yu <yuzenghui@huawei.com>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Shaoqin Huang <shahuang@redhat.com>, 
	Gavin Shan <gshan@redhat.com>, Ricardo Koller <ricarkol@google.com>, 
	Raghavendra Rao Ananta <rananta@google.com>, Ryan Roberts <ryan.roberts@arm.com>, 
	David Rientjes <rientjes@google.com>, Axel Rasmussen <axelrasmussen@google.com>, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	kvmarm@lists.linux.dev, kvm@vger.kernel.org, linux-mm@kvack.org, 
	linux-trace-kernel@vger.kernel.org, James Houghton <jthoughton@google.com>
Content-Type: text/plain; charset="UTF-8"

The bitmap is provided for secondary MMUs to use if they support it. For
test_young(), after it returns, the bitmap represents the pages that
were young in the interval [start, end). For clear_young, it represents
the pages that we wish the secondary MMU to clear the accessed/young bit
for.

If a bitmap is not provided, the mmu_notifier_{test,clear}_young() API
should be unchanged except that if young PTEs are found and the
architecture supports passing in a bitmap, instead of returning 1,
MMU_NOTIFIER_YOUNG_FAST is returned.

This allows MGLRU's look-around logic to work faster, resulting in a 4%
improvement in real workloads[1]. Also introduce MMU_NOTIFIER_YOUNG_FAST
to indicate to main mm that doing look-around is likely to be
beneficial.

If the secondary MMU doesn't support the bitmap, it must return
an int that contains MMU_NOTIFIER_YOUNG_BITMAP_UNRELIABLE.

[1]: https://lore.kernel.org/all/20230609005935.42390-1-yuzhao@google.com/

Suggested-by: Yu Zhao <yuzhao@google.com>
Signed-off-by: James Houghton <jthoughton@google.com>
---
 include/linux/mmu_notifier.h | 93 +++++++++++++++++++++++++++++++++---
 include/trace/events/kvm.h   | 13 +++--
 mm/mmu_notifier.c            | 20 +++++---
 virt/kvm/kvm_main.c          | 19 ++++++--
 4 files changed, 123 insertions(+), 22 deletions(-)

diff --git a/include/linux/mmu_notifier.h b/include/linux/mmu_notifier.h
index f349e08a9dfe..daaa9db625d3 100644
--- a/include/linux/mmu_notifier.h
+++ b/include/linux/mmu_notifier.h
@@ -61,6 +61,10 @@ enum mmu_notifier_event {
 
 #define MMU_NOTIFIER_RANGE_BLOCKABLE (1 << 0)
 
+#define MMU_NOTIFIER_YOUNG			(1 << 0)
+#define MMU_NOTIFIER_YOUNG_BITMAP_UNRELIABLE	(1 << 1)
+#define MMU_NOTIFIER_YOUNG_FAST			(1 << 2)
+
 struct mmu_notifier_ops {
 	/*
 	 * Called either by mmu_notifier_unregister or when the mm is
@@ -106,21 +110,36 @@ struct mmu_notifier_ops {
 	 * clear_young is a lightweight version of clear_flush_young. Like the
 	 * latter, it is supposed to test-and-clear the young/accessed bitflag
 	 * in the secondary pte, but it may omit flushing the secondary tlb.
+	 *
+	 * If @bitmap is given but is not supported, return
+	 * MMU_NOTIFIER_YOUNG_BITMAP_UNRELIABLE.
+	 *
+	 * If the walk is done "quickly" and there were young PTEs,
+	 * MMU_NOTIFIER_YOUNG_FAST is returned.
 	 */
 	int (*clear_young)(struct mmu_notifier *subscription,
 			   struct mm_struct *mm,
 			   unsigned long start,
-			   unsigned long end);
+			   unsigned long end,
+			   unsigned long *bitmap);
 
 	/*
 	 * test_young is called to check the young/accessed bitflag in
 	 * the secondary pte. This is used to know if the page is
 	 * frequently used without actually clearing the flag or tearing
 	 * down the secondary mapping on the page.
+	 *
+	 * If @bitmap is given but is not supported, return
+	 * MMU_NOTIFIER_YOUNG_BITMAP_UNRELIABLE.
+	 *
+	 * If the walk is done "quickly" and there were young PTEs,
+	 * MMU_NOTIFIER_YOUNG_FAST is returned.
 	 */
 	int (*test_young)(struct mmu_notifier *subscription,
 			  struct mm_struct *mm,
-			  unsigned long address);
+			  unsigned long start,
+			  unsigned long end,
+			  unsigned long *bitmap);
 
 	/*
 	 * change_pte is called in cases that pte mapping to page is changed:
@@ -388,10 +407,11 @@ extern int __mmu_notifier_clear_flush_young(struct mm_struct *mm,
 					  unsigned long start,
 					  unsigned long end);
 extern int __mmu_notifier_clear_young(struct mm_struct *mm,
-				      unsigned long start,
-				      unsigned long end);
+				      unsigned long start, unsigned long end,
+				      unsigned long *bitmap);
 extern int __mmu_notifier_test_young(struct mm_struct *mm,
-				     unsigned long address);
+				     unsigned long start, unsigned long end,
+				     unsigned long *bitmap);
 extern void __mmu_notifier_change_pte(struct mm_struct *mm,
 				      unsigned long address, pte_t pte);
 extern int __mmu_notifier_invalidate_range_start(struct mmu_notifier_range *r);
@@ -427,7 +447,25 @@ static inline int mmu_notifier_clear_young(struct mm_struct *mm,
 					   unsigned long end)
 {
 	if (mm_has_notifiers(mm))
-		return __mmu_notifier_clear_young(mm, start, end);
+		return __mmu_notifier_clear_young(mm, start, end, NULL);
+	return 0;
+}
+
+/*
+ * When @bitmap is not provided, clear the young bits in the secondary
+ * MMUs for all of the pages in the interval [start, end).
+ *
+ * If any subscribed secondary MMU does not support @bitmap, this function
+ * will return an integer containing MMU_NOTIFIER_YOUNG_BITMAP_UNRELIABLE.
+ * Some work may have been done in the secondary MMU.
+ */
+static inline int mmu_notifier_clear_young_bitmap(struct mm_struct *mm,
+						  unsigned long start,
+						  unsigned long end,
+						  unsigned long *bitmap)
+{
+	if (mm_has_notifiers(mm))
+		return __mmu_notifier_clear_young(mm, start, end, bitmap);
 	return 0;
 }
 
@@ -435,7 +473,25 @@ static inline int mmu_notifier_test_young(struct mm_struct *mm,
 					  unsigned long address)
 {
 	if (mm_has_notifiers(mm))
-		return __mmu_notifier_test_young(mm, address);
+		return __mmu_notifier_test_young(mm, address, address + 1,
+						 NULL);
+	return 0;
+}
+
+/*
+ * When @bitmap is not provided, test the young bits in the secondary
+ * MMUs for all of the pages in the interval [start, end).
+ *
+ * If any subscribed secondary MMU does not support @bitmap, this function
+ * will return an integer containing MMU_NOTIFIER_YOUNG_BITMAP_UNRELIABLE.
+ */
+static inline int mmu_notifier_test_young_bitmap(struct mm_struct *mm,
+						 unsigned long start,
+						 unsigned long end,
+						 unsigned long *bitmap)
+{
+	if (mm_has_notifiers(mm))
+		return __mmu_notifier_test_young(mm, start, end, bitmap);
 	return 0;
 }
 
@@ -644,12 +700,35 @@ static inline int mmu_notifier_clear_flush_young(struct mm_struct *mm,
 	return 0;
 }
 
+static inline int mmu_notifier_clear_young(struct mm_struct *mm,
+					   unsigned long start,
+					   unsigned long end)
+{
+	return 0;
+}
+
+static inline int mmu_notifier_clear_young_bitmap(struct mm_struct *mm,
+						  unsigned long start,
+						  unsigned long end,
+						  unsigned long *bitmap)
+{
+	return 0;
+}
+
 static inline int mmu_notifier_test_young(struct mm_struct *mm,
 					  unsigned long address)
 {
 	return 0;
 }
 
+static inline int mmu_notifier_test_young_bitmap(struct mm_struct *mm,
+						 unsigned long start,
+						 unsigned long end,
+						 unsigned long *bitmap)
+{
+	return 0;
+}
+
 static inline void mmu_notifier_change_pte(struct mm_struct *mm,
 					   unsigned long address, pte_t pte)
 {
diff --git a/include/trace/events/kvm.h b/include/trace/events/kvm.h
index 011fba6b5552..e4ace8cfdbba 100644
--- a/include/trace/events/kvm.h
+++ b/include/trace/events/kvm.h
@@ -490,18 +490,21 @@ TRACE_EVENT(kvm_age_hva,
 );
 
 TRACE_EVENT(kvm_test_age_hva,
-	TP_PROTO(unsigned long hva),
-	TP_ARGS(hva),
+	TP_PROTO(unsigned long start, unsigned long end),
+	TP_ARGS(start, end),
 
 	TP_STRUCT__entry(
-		__field(	unsigned long,	hva		)
+		__field(	unsigned long,	start		)
+		__field(	unsigned long,	end		)
 	),
 
 	TP_fast_assign(
-		__entry->hva		= hva;
+		__entry->start		= start;
+		__entry->end		= end;
 	),
 
-	TP_printk("mmu notifier test age hva: %#016lx", __entry->hva)
+	TP_printk("mmu notifier test age hva: %#016lx -- %#016lx",
+		  __entry->start, __entry->end)
 );
 
 #endif /* _TRACE_KVM_MAIN_H */
diff --git a/mm/mmu_notifier.c b/mm/mmu_notifier.c
index ec3b068cbbe6..e70c6222944c 100644
--- a/mm/mmu_notifier.c
+++ b/mm/mmu_notifier.c
@@ -384,7 +384,8 @@ int __mmu_notifier_clear_flush_young(struct mm_struct *mm,
 
 int __mmu_notifier_clear_young(struct mm_struct *mm,
 			       unsigned long start,
-			       unsigned long end)
+			       unsigned long end,
+			       unsigned long *bitmap)
 {
 	struct mmu_notifier *subscription;
 	int young = 0, id;
@@ -395,7 +396,8 @@ int __mmu_notifier_clear_young(struct mm_struct *mm,
 				 srcu_read_lock_held(&srcu)) {
 		if (subscription->ops->clear_young)
 			young |= subscription->ops->clear_young(subscription,
-								mm, start, end);
+								mm, start, end,
+								bitmap);
 	}
 	srcu_read_unlock(&srcu, id);
 
@@ -403,7 +405,8 @@ int __mmu_notifier_clear_young(struct mm_struct *mm,
 }
 
 int __mmu_notifier_test_young(struct mm_struct *mm,
-			      unsigned long address)
+			      unsigned long start, unsigned long end,
+			      unsigned long *bitmap)
 {
 	struct mmu_notifier *subscription;
 	int young = 0, id;
@@ -413,9 +416,14 @@ int __mmu_notifier_test_young(struct mm_struct *mm,
 				 &mm->notifier_subscriptions->list, hlist,
 				 srcu_read_lock_held(&srcu)) {
 		if (subscription->ops->test_young) {
-			young = subscription->ops->test_young(subscription, mm,
-							      address);
-			if (young)
+			young |= subscription->ops->test_young(subscription, mm,
+							       start, end,
+							       bitmap);
+			if (young && !bitmap)
+				/*
+				 * We're not using a bitmap, so there is no
+				 * need to check any more secondary MMUs.
+				 */
 				break;
 		}
 	}
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index fb49c2a60200..ca4b1ef9dfc2 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -917,10 +917,15 @@ static int kvm_mmu_notifier_clear_flush_young(struct mmu_notifier *mn,
 static int kvm_mmu_notifier_clear_young(struct mmu_notifier *mn,
 					struct mm_struct *mm,
 					unsigned long start,
-					unsigned long end)
+					unsigned long end,
+					unsigned long *bitmap)
 {
 	trace_kvm_age_hva(start, end);
 
+	/* We don't support bitmaps. Don't test or clear anything. */
+	if (bitmap)
+		return MMU_NOTIFIER_YOUNG_BITMAP_UNRELIABLE;
+
 	/*
 	 * Even though we do not flush TLB, this will still adversely
 	 * affect performance on pre-Haswell Intel EPT, where there is
@@ -939,11 +944,17 @@ static int kvm_mmu_notifier_clear_young(struct mmu_notifier *mn,
 
 static int kvm_mmu_notifier_test_young(struct mmu_notifier *mn,
 				       struct mm_struct *mm,
-				       unsigned long address)
+				       unsigned long start,
+				       unsigned long end,
+				       unsigned long *bitmap)
 {
-	trace_kvm_test_age_hva(address);
+	trace_kvm_test_age_hva(start, end);
+
+	/* We don't support bitmaps. Don't test or clear anything. */
+	if (bitmap)
+		return MMU_NOTIFIER_YOUNG_BITMAP_UNRELIABLE;
 
-	return kvm_handle_hva_range_no_flush(mn, address, address + 1,
+	return kvm_handle_hva_range_no_flush(mn, start, end,
 					     kvm_test_age_gfn);
 }
 
-- 
2.44.0.478.gd926399ef9-goog


