Return-Path: <linux-kernel+bounces-99807-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F752878DB3
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 05:00:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A8E75B21066
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 04:00:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13F35BE62;
	Tue, 12 Mar 2024 03:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CydKUjFs"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8691DB664
	for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 03:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710215998; cv=none; b=lb1sYMtVAEz51Cc8ryMjy+uAKVOcz97J2pKjbdXnPKarkbRMHR3Yvr/6IPRFzpcDMcWKOvi/DcVHsfnVgK42Jx8g6Fy+qIJh0f9iU3TABs3jgzVpw2NVh9gyGuIeH+9O4mt5FBYzXHcYmE5iy8ZhEpJeMcfPOz1KNd9RE/ADXMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710215998; c=relaxed/simple;
	bh=m/auRA+yyVu/UsBSlA7tfXY1w6rfbh8RvewRXf/T0l4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Jmo1v7OCycGryB9gGDI5sX7FembXos+ptZpTHJoKB4T9nX9UN7GFA7/c1u7yrY5+0w1xeE78fHTfa8M7D5GwujuJnNkMT5EcH44xj+7ovjfEQpcRjnCZU2JEMc1mk18dF1hB61b2k+evi9/aPYiZu+6zHBVzLvKptCZt5Ax9plA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yosryahmed.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CydKUjFs; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yosryahmed.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dcd94cc48a1so8321339276.3
        for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 20:59:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1710215995; x=1710820795; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=GoKed6yKAS+GwnXsUmVoWRiO+MONN8g5vxEH6EyDAwM=;
        b=CydKUjFsTnQq15UupCxAbiLlyyInCPUYPpvGi7fR4i0/xgcVrByqg5uZU1nzFbBJTd
         OWtACPlDBDew3dPSKIlAqqk+dDdbjSeFIIh3RFazbLpsKAd5osAN8+v1C4tO+vF1q4Tw
         ClyPtehjM32kp+tTupRvCg+g6hi5/rQXmf/YsQjZ5XQGU7GWcRH9XCyPmXZN79a3Y/jv
         IKIhzinZXc0mXjRfXJBxJy+3EyfC7Vg/0ULxJuSD4+S5V4a/0l6dAQ+91GO+wXu+QuOM
         ScffZBP077hOn7qWgitXiBlfjl6GsyUOdxOXBYFz1VWF4vGisb4zpF2hazwpE7d5EvHU
         QOvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710215995; x=1710820795;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GoKed6yKAS+GwnXsUmVoWRiO+MONN8g5vxEH6EyDAwM=;
        b=MRtekV7X5QX9VEvi3LkWJcuccudQT+azArei4nvh2NH0t2Rn4zk+mS34CMlqMKNZ87
         eD3CyznvHk4x1bYQ76moIquWQIbXvySIApmPR5ZaOsUgs6z7K/mAUoeMisgmERUdW3Du
         4xK+fclCiXb08I5O+RvJhu7+ws2hsGDFK5y2JlNqh94tA45dNa9mhbPUIo9vmcLcnibB
         8193+m9kaZ0L3WbRF4BeNQGN92rcRGxLJQx9xCC3u2MXFk9LT+TXDS5nF/XeFN9lzQBg
         68V6ca/N1hg/hvKbIc2/YSrVA3n77Mn2BUiI2LhRkrvUTFVNK5tNzwhq2OrsStM1aCL1
         HK+Q==
X-Forwarded-Encrypted: i=1; AJvYcCUlBn2uVogndXiJUGduiDvGl9j2tsbwCaMwXU2JHC1hx6ZO5M67g/2F0OmXxiZ/ffl4ovn7VKAJWPF2eMeN+m6yMH1TWUZoZ5PfhLcs
X-Gm-Message-State: AOJu0YxvIw7b01JjVjC1jjAd+jWOJRP3SEzp3FqQTIWzmLLiO2VO064s
	ZJwIvxXHsAwarZMXl5PcGj2NOHhRLcxwBgXnFLCX2s383ZVF6CPKDVYO/fyKcOA569rpl5PNvsZ
	UyDsiu27AD4DdcefPew==
X-Google-Smtp-Source: AGHT+IExFRL/azN3q8HgBq6A2xtMpxQXpFaPTK8KJYQ1jXBub6ECtGohzNaeSuMsvvLKLtLSLkGboXwUHiFLXv1f
X-Received: from yosry.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:29b4])
 (user=yosryahmed job=sendgmr) by 2002:a05:6902:1081:b0:dc7:8e30:e2e3 with
 SMTP id v1-20020a056902108100b00dc78e30e2e3mr2416970ybu.2.1710215995630; Mon,
 11 Mar 2024 20:59:55 -0700 (PDT)
Date: Tue, 12 Mar 2024 03:59:50 +0000
In-Reply-To: <20240312035951.3535980-1-yosryahmed@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240312035951.3535980-1-yosryahmed@google.com>
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Message-ID: <20240312035951.3535980-2-yosryahmed@google.com>
Subject: [PATCH 2/3] x86/mm: Fix LAM inconsistency during context switch
From: Yosry Ahmed <yosryahmed@google.com>
To: x86@kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>, 
	Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, 
	Rick Edgecombe <rick.p.edgecombe@intel.com>, Andrew Morton <akpm@linux-foundation.org>, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Yosry Ahmed <yosryahmed@google.com>
Content-Type: text/plain; charset="UTF-8"

LAM can only be enabled when a process is single-threaded.  But _kernel_
threads can temporarily use a single-threaded process's mm.  That means
that a context-switching kernel thread can race and observe the mm's LAM
metadata (mm->context.lam_cr3_mask) change.

The context switch code does two logical things with that metadata:
populate CR3 and populate 'cpu_tlbstate.lam'.  If it hits this race,
'cpu_tlbstate.lam' and CR3 can end up out of sync.

This de-synchronization is currently harmless.  But it is confusing and
might lead to warnings or real bugs.

Update set_tlbstate_lam_mode() to take in the LAM mask and untag mask
instead of an mm_struct pointer, and while we are at it, rename it to
cpu_tlbstate_update_lam(). This should also make it clearer that we are
updating cpu_tlbstate. In switch_mm_irqs_off(), read the LAM mask once
and use it for both the cpu_tlbstate update and the CR3 update.

Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
---
 arch/x86/include/asm/mmu_context.h | 8 +++++++-
 arch/x86/include/asm/tlbflush.h    | 9 ++++-----
 arch/x86/kernel/process_64.c       | 6 ++++--
 arch/x86/mm/tlb.c                  | 8 +++++---
 4 files changed, 20 insertions(+), 11 deletions(-)

diff --git a/arch/x86/include/asm/mmu_context.h b/arch/x86/include/asm/mmu_context.h
index 8dac45a2c7fcf..19091ebb86338 100644
--- a/arch/x86/include/asm/mmu_context.h
+++ b/arch/x86/include/asm/mmu_context.h
@@ -88,7 +88,13 @@ static inline void switch_ldt(struct mm_struct *prev, struct mm_struct *next)
 #ifdef CONFIG_ADDRESS_MASKING
 static inline unsigned long mm_lam_cr3_mask(struct mm_struct *mm)
 {
-	return mm->context.lam_cr3_mask;
+	/*
+	 * When switch_mm_irqs_off() is called for a kthread, it may race with
+	 * LAM enablement. switch_mm_irqs_off() uses the LAM mask to do two
+	 * things: populate CR3 and populate 'cpu_tlbstate.lam'. Make sure it
+	 * reads a single value for both.
+	 */
+	return READ_ONCE(mm->context.lam_cr3_mask);
 }
 
 static inline void dup_lam(struct mm_struct *oldmm, struct mm_struct *mm)
diff --git a/arch/x86/include/asm/tlbflush.h b/arch/x86/include/asm/tlbflush.h
index 25726893c6f4d..69e79fff41b80 100644
--- a/arch/x86/include/asm/tlbflush.h
+++ b/arch/x86/include/asm/tlbflush.h
@@ -399,11 +399,10 @@ static inline  u64 tlbstate_lam_cr3_mask(void)
 	return lam << X86_CR3_LAM_U57_BIT;
 }
 
-static inline void set_tlbstate_lam_mode(struct mm_struct *mm)
+static inline void cpu_tlbstate_update_lam(unsigned long lam, u64 untag_mask)
 {
-	this_cpu_write(cpu_tlbstate.lam,
-		       mm->context.lam_cr3_mask >> X86_CR3_LAM_U57_BIT);
-	this_cpu_write(tlbstate_untag_mask, mm->context.untag_mask);
+	this_cpu_write(cpu_tlbstate.lam, lam >> X86_CR3_LAM_U57_BIT);
+	this_cpu_write(tlbstate_untag_mask, untag_mask);
 }
 
 #else
@@ -413,7 +412,7 @@ static inline u64 tlbstate_lam_cr3_mask(void)
 	return 0;
 }
 
-static inline void set_tlbstate_lam_mode(struct mm_struct *mm)
+static inline void cpu_tlbstate_update_lam(unsigned long lam, u64 untag_mask)
 {
 }
 #endif
diff --git a/arch/x86/kernel/process_64.c b/arch/x86/kernel/process_64.c
index 76e91fc68c5f3..748d2b3bdb985 100644
--- a/arch/x86/kernel/process_64.c
+++ b/arch/x86/kernel/process_64.c
@@ -753,10 +753,12 @@ static long prctl_map_vdso(const struct vdso_image *image, unsigned long addr)
 static void enable_lam_func(void *__mm)
 {
 	struct mm_struct *mm = __mm;
+	unsigned long lam = mm_lam_cr3_mask(mm);
+	u64 untag_mask = mm_untag_mask(mm);
 
 	if (this_cpu_read(cpu_tlbstate.loaded_mm) == mm) {
-		write_cr3(__read_cr3() | mm->context.lam_cr3_mask);
-		set_tlbstate_lam_mode(mm);
+		write_cr3(__read_cr3() | lam);
+		cpu_tlbstate_update_lam(lam, untag_mask);
 	}
 }
 
diff --git a/arch/x86/mm/tlb.c b/arch/x86/mm/tlb.c
index e8feb2e154db2..b2f74c451b3d7 100644
--- a/arch/x86/mm/tlb.c
+++ b/arch/x86/mm/tlb.c
@@ -11,6 +11,7 @@
 #include <linux/sched/smt.h>
 #include <linux/task_work.h>
 #include <linux/mmu_notifier.h>
+#include <linux/mmu_context.h>
 
 #include <asm/tlbflush.h>
 #include <asm/mmu_context.h>
@@ -635,7 +636,6 @@ void switch_mm_irqs_off(struct mm_struct *prev, struct mm_struct *next,
 	}
 
 	new_lam = mm_lam_cr3_mask(next);
-	set_tlbstate_lam_mode(next);
 	if (need_flush) {
 		this_cpu_write(cpu_tlbstate.ctxs[new_asid].ctx_id, next->context.ctx_id);
 		this_cpu_write(cpu_tlbstate.ctxs[new_asid].tlb_gen, next_tlb_gen);
@@ -654,6 +654,7 @@ void switch_mm_irqs_off(struct mm_struct *prev, struct mm_struct *next,
 
 	this_cpu_write(cpu_tlbstate.loaded_mm, next);
 	this_cpu_write(cpu_tlbstate.loaded_mm_asid, new_asid);
+	cpu_tlbstate_update_lam(new_lam, mm_untag_mask(next));
 
 	if (next != real_prev) {
 		cr4_update_pce_mm(next);
@@ -700,6 +701,7 @@ void initialize_tlbstate_and_flush(void)
 	int i;
 	struct mm_struct *mm = this_cpu_read(cpu_tlbstate.loaded_mm);
 	u64 tlb_gen = atomic64_read(&init_mm.context.tlb_gen);
+	unsigned long lam = mm_lam_cr3_mask(mm);
 	unsigned long cr3 = __read_cr3();
 
 	/* Assert that CR3 already references the right mm. */
@@ -707,7 +709,7 @@ void initialize_tlbstate_and_flush(void)
 
 	/* LAM expected to be disabled */
 	WARN_ON(cr3 & (X86_CR3_LAM_U48 | X86_CR3_LAM_U57));
-	WARN_ON(mm_lam_cr3_mask(mm));
+	WARN_ON(lam);
 
 	/*
 	 * Assert that CR4.PCIDE is set if needed.  (CR4.PCIDE initialization
@@ -726,7 +728,7 @@ void initialize_tlbstate_and_flush(void)
 	this_cpu_write(cpu_tlbstate.next_asid, 1);
 	this_cpu_write(cpu_tlbstate.ctxs[0].ctx_id, mm->context.ctx_id);
 	this_cpu_write(cpu_tlbstate.ctxs[0].tlb_gen, tlb_gen);
-	set_tlbstate_lam_mode(mm);
+	cpu_tlbstate_update_lam(lam, mm_untag_mask(mm));
 
 	for (i = 1; i < TLB_NR_DYN_ASIDS; i++)
 		this_cpu_write(cpu_tlbstate.ctxs[i].ctx_id, 0);
-- 
2.44.0.278.ge034bb2e1d-goog


