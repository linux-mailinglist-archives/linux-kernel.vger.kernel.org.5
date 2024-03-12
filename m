Return-Path: <linux-kernel+bounces-100480-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62B6487986D
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 16:57:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 864091C21295
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 15:57:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 868CC7E572;
	Tue, 12 Mar 2024 15:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MDJEwM1j"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E7A258AD4
	for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 15:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710259013; cv=none; b=FRKF2cp6cI44a4s3yqM5zQTXTbhypKBLUd3Rp2abSAv2Z0mquozxQ8GKhwi62jRNfVsXoX2VbzDdfvTxgR3xOOD6K1CnLDZRIqFbAMkPZCpfcZ6ho5vBpHXvgxdSJMQGFlcX4VF6zLNbRzih4HWaHh3fNgAmG01IxP9n32t6Kag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710259013; c=relaxed/simple;
	bh=Tt+QKLROjKedEr90kK6xMJjCGHQglvwoFJENFv8MOhY=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=S90kXunlSBGcP+VZT86HuWV1U1VzU3f+BD1arjz+z0GqLacjT/mMBtJ+8jP2Z1Mxe1PWn+yKoDR/uq/GWDjDxOO5ANhUzQWzYj6svbnf5ipE+yL0FJsQlZ1D+3Drydktc8bbESrFsYRuLjEKsc4D/u93LxiV8YxyVn+TBGL0viM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yosryahmed.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MDJEwM1j; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yosryahmed.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dce775fa8adso9791484276.1
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 08:56:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1710259011; x=1710863811; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Utpo4un8WURVOryq3iaezlwySVNXykpwBlPdcQcpqSc=;
        b=MDJEwM1j5HM8whxgMQJ80QlLe5ehsfJmGXe6qwbJDC9tGyNpvVrS/5w2On9w0sPFJL
         hCjUMvXt7gAFQlxu0FwAIlp6xZTXHZL8KcvAgGgS3w4ZqOZzLgnB6vQQSfyCZQx0Ojrn
         WwOAg4mhgG2zVk7p2nDZHH8FjUzomITzKCw5iBg+A5gbWYQy0l1nR2JTxAP6CwM0Wkdg
         wbOaSjdJ40nBpNOY1PIBC+m+7NvwoTHcSQgJrbxI5a1HulVt6oX38nKL7IXm8Du/GSdY
         QKWJ/aZexZEbN08C75U444TFDS0bJLLJr5g+uDAaR7k8i8zHMRI97ZX17EEqbmT8idln
         nSXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710259011; x=1710863811;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Utpo4un8WURVOryq3iaezlwySVNXykpwBlPdcQcpqSc=;
        b=RNmkAUXPFSidvGBE6wUGIeCkNrNiDsrQcp/xnZumUVGn8gyiC2lAC+3HGxztsYfAef
         RSZF/Ctk7FP9x/G05nhPMHcWtYiA8rjO73if3c9tO1i6QEodK2BjzIOwbhjhJNaT9q6O
         hT5LXHhVS2gsxejvRGUSH4rjLMM8ezFbIWc0/gz0rBbqJ0kLMKTvEsjkMrvibGWzbvvF
         wDYC7IxoSMaF7tjvjOND3i+wGRPE0xmwPfXNvdbo0oOxhV9SVBOF6o8aaDcASaiq5hOL
         jnfgWkCZIB8zhV9Er8ruHb4a1Pbxrk6bcdMr3snZYJQHITgZxxytBxnIh3Z+Pi4HjqTo
         pOSw==
X-Forwarded-Encrypted: i=1; AJvYcCWH9avVWyBAkDVwIhY1dKnnFf9IdS8OZIne8A8MzCZau80wUWV+2c7UF+rp/opEpl0mpqlw8Cm3gpwmsT3mvdGHwBgpP22HVQlLrFL5
X-Gm-Message-State: AOJu0Ywsjxi76eGBlYKU6gPolZCvn2tva9KOnt/pqQu0YqXP8ip01H3Q
	OFNGbxBf4IiXzhzI789F7FzwHmQFho/GxXanus0ddlxu08vmDNFgorsnHGObSTlXZWSpn0jGOef
	UeOQu1OSVs1RNEdwe+g==
X-Google-Smtp-Source: AGHT+IFTM3Svt5aG2KDAZZ5idfNa42+hKp13eDZYuCEzCHp68sCT3zJVywoPrbfqfLH7MdR0l2OCOvYs3V662FOa
X-Received: from yosry.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:29b4])
 (user=yosryahmed job=sendgmr) by 2002:a05:6902:10c2:b0:dc6:e1ed:bd1a with
 SMTP id w2-20020a05690210c200b00dc6e1edbd1amr2596454ybu.2.1710259011049; Tue,
 12 Mar 2024 08:56:51 -0700 (PDT)
Date: Tue, 12 Mar 2024 15:56:39 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Message-ID: <20240312155641.4003683-1-yosryahmed@google.com>
Subject: [PATCH v2 1/3] x86/mm: Use IPIs to synchronize LAM enablement
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
threads can temporarily use a single-threaded process's mm.

If LAM is enabled by a userspace process while a kthread is using its
mm, the kthread will not observe LAM enablement (i.e.  LAM will be
disabled in CR3). This could be fine for the kthread itself, as LAM only
affects userspace addresses. However, if the kthread context switches to
a thread in the same userspace process, CR3 may or may not be updated
because the mm_struct doesn't change (based on pending TLB flushes). If
CR3 is not updated, the userspace thread will run incorrectly with LAM
disabled, which may cause page faults when using tagged addresses.
Example scenario:

CPU 1                                   CPU 2
/* kthread */
kthread_use_mm()
                                        /* user thread */
                                        prctl_enable_tagged_addr()
                                        /* LAM enabled on CPU 2 */
/* LAM disabled on CPU 1 */
                                        context_switch() /* to CPU 1 */
/* Switching to user thread */
switch_mm_irqs_off()
/* CR3 not updated */
/* LAM is still disabled on CPU 1 */

Synchronize LAM enablement by sending an IPI from
prctl_enable_tagged_addr() to all CPUs running with the mm_struct to
enable LAM. This makes sure LAM is enabled on CPU 1 in the above
scenario before prctl_enable_tagged_addr() returns and userspace starts
using tagged addresses, and before it's possible to run the userspace
process on CPU 1.

In switch_mm_irqs_off(), move reading the LAM mask until after
mm_cpumask() is updated. This ensures that if an outdated LAM mask is
written to CR3, an IPI is received to update it right after IRQs are
re-enabled.

Fixes: 82721d8b25d7 ("x86/mm: Handle LAM on context switch")
Suggested-by: Andy Lutomirski <luto@kernel.org>
Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
Reviewed-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
---

v1 -> v2:
- Defer dereferences in enable_lam_func() until after we check
  cpu_tlbstate.loaded_mm.
- Collect Rbs.

---
 arch/x86/kernel/process_64.c | 13 +++++++++++--
 arch/x86/mm/tlb.c            |  7 +++----
 2 files changed, 14 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kernel/process_64.c b/arch/x86/kernel/process_64.c
index 33b268747bb7b..76e91fc68c5f3 100644
--- a/arch/x86/kernel/process_64.c
+++ b/arch/x86/kernel/process_64.c
@@ -750,6 +750,16 @@ static long prctl_map_vdso(const struct vdso_image *image, unsigned long addr)
 
 #define LAM_U57_BITS 6
 
+static void enable_lam_func(void *__mm)
+{
+	struct mm_struct *mm = __mm;
+
+	if (this_cpu_read(cpu_tlbstate.loaded_mm) == mm) {
+		write_cr3(__read_cr3() | mm->context.lam_cr3_mask);
+		set_tlbstate_lam_mode(mm);
+	}
+}
+
 static int prctl_enable_tagged_addr(struct mm_struct *mm, unsigned long nr_bits)
 {
 	if (!cpu_feature_enabled(X86_FEATURE_LAM))
@@ -782,8 +792,7 @@ static int prctl_enable_tagged_addr(struct mm_struct *mm, unsigned long nr_bits)
 		return -EINVAL;
 	}
 
-	write_cr3(__read_cr3() | mm->context.lam_cr3_mask);
-	set_tlbstate_lam_mode(mm);
+	on_each_cpu_mask(mm_cpumask(mm), enable_lam_func, mm, true);
 	set_bit(MM_CONTEXT_LOCK_LAM, &mm->context.flags);
 
 	mmap_write_unlock(mm);
diff --git a/arch/x86/mm/tlb.c b/arch/x86/mm/tlb.c
index 5768d386efab6..e8feb2e154db2 100644
--- a/arch/x86/mm/tlb.c
+++ b/arch/x86/mm/tlb.c
@@ -497,9 +497,9 @@ void switch_mm_irqs_off(struct mm_struct *prev, struct mm_struct *next,
 {
 	struct mm_struct *real_prev = this_cpu_read(cpu_tlbstate.loaded_mm);
 	u16 prev_asid = this_cpu_read(cpu_tlbstate.loaded_mm_asid);
-	unsigned long new_lam = mm_lam_cr3_mask(next);
 	bool was_lazy = this_cpu_read(cpu_tlbstate_shared.is_lazy);
 	unsigned cpu = smp_processor_id();
+	unsigned long new_lam;
 	u64 next_tlb_gen;
 	bool need_flush;
 	u16 new_asid;
@@ -622,9 +622,7 @@ void switch_mm_irqs_off(struct mm_struct *prev, struct mm_struct *next,
 			cpumask_clear_cpu(cpu, mm_cpumask(real_prev));
 		}
 
-		/*
-		 * Start remote flushes and then read tlb_gen.
-		 */
+		/* Start receiving IPIs and then read tlb_gen (and LAM below) */
 		if (next != &init_mm)
 			cpumask_set_cpu(cpu, mm_cpumask(next));
 		next_tlb_gen = atomic64_read(&next->context.tlb_gen);
@@ -636,6 +634,7 @@ void switch_mm_irqs_off(struct mm_struct *prev, struct mm_struct *next,
 		barrier();
 	}
 
+	new_lam = mm_lam_cr3_mask(next);
 	set_tlbstate_lam_mode(next);
 	if (need_flush) {
 		this_cpu_write(cpu_tlbstate.ctxs[new_asid].ctx_id, next->context.ctx_id);
-- 
2.44.0.278.ge034bb2e1d-goog


