Return-Path: <linux-kernel+bounces-149399-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 20C258A90A1
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 03:28:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 842B71F225B5
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 01:28:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E0968488;
	Thu, 18 Apr 2024 01:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eT3eZnKO"
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2714019A
	for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 01:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713403720; cv=none; b=n+L8NioxFFkiRs3wmJnL/Lu7LhZcVEUlDT9kJvw9nLQZ5HKx/ANiFIKkm09v+Vnq9Ugkdy6bajREJ2nktpLR0PQqv1wZpWgu97LBULRbTC9RG1+5D8s/MMd1pK6Cy07t1vHiITYrifExBEK0UuR/5vPpp8ES0rOS0zZF6kDWcjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713403720; c=relaxed/simple;
	bh=D9uAxfhXCIibdUQvBdEAguSzWPl/w/50yeP3Yso4sDY=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=eP4RzwdeSwuTFHtjiaPpNyTLWBAvQmXQ1VKS3C56pqBd5L+sfK4f+eyq6TMcq0N80iwJJRTxZ+nNiDqRUsZ01ebCW495+JDHwlf68pGAZZ+Rqvel/my1S6lDz6RLfia5k7p9zuNPuBaaapQ1QpSk3RVEdqOFr3pKzCkFvrTJtCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yosryahmed.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=eT3eZnKO; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yosryahmed.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-5d8bff2b792so333665a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 18:28:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713403718; x=1714008518; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=FYDQyLdFdWMdeiUN2dEgWolx8IdIlWszL4UA+NDjWJ0=;
        b=eT3eZnKOldVPe7K82MsF4QaeqJSwao0PfngldjfOYNu0iJRNF6toUGZZ8ppTPiD2Jb
         z+f9/SISFwDgCpkyZ/TKHdvUon5lgtcYdtZOH1CeZmeN78vPSDKsHuHj7Q7PxXVVTIrb
         XIqf98c4DahuWYVB2RGBvobCUj9B+YVt1AVTxyKGWw7SCwFElH1HioInME0KhqAV7FS1
         +Ww1nlEPLe0JjnJu9kXAzJQVVIOg2mq4ROfApEYB41MBygZh9jCc05y2W0UNbULqfblN
         4wPfDzg0ojdpH/B0iLhpQ7q25H3OPtA/Ofn2K7Vno81Iv8OslCCB7O1GourmCCSavw0g
         Ke3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713403718; x=1714008518;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FYDQyLdFdWMdeiUN2dEgWolx8IdIlWszL4UA+NDjWJ0=;
        b=dE2Qvl+Y7UH/kuFRGj/5xSdrpPQx6Ncp+PKBunyLECKotPSUPnYXzytHYz8E5JdleG
         mfOp9ZucJxG6Bk1FIuQKh1U65WamquprWhQI61bJoom3EVQMiHTBLIyPSBUo+8w+F20N
         JhDMV5hmad2Aq0/wNkviHufWENfC5gxNHVqqmT7AGzVUrZJ2+CzXf0VmxcvpYF1+avur
         WUThFHRtt+iy7oRm/9Dzx74pac2xw3WpveZeVHpQfc5yoZ/95as6W73nCCX6+sa2kQgX
         2rFriqQ97+pFumHL+wk8ky3A1O+mmiFtw1DkpAv7PPXiXgZjiNeXtGfz32I9JRpI3BzX
         nA/g==
X-Forwarded-Encrypted: i=1; AJvYcCUGr7q0UAgyOoF4YbjhdD7C2bTjkNMwLxYQ1RDZqSApI9KUkZcDVUeUaDHOsPNP+JU4B4abLPX2CV5CDH7fTJmdcFtIA7+RYe5dyw5Q
X-Gm-Message-State: AOJu0YxXClBi30RLPxLEHvPlyjRxnj551mI6qipNqLoVuS7P0IeME+BY
	yIQBNmGM+rAKdFjpIFLwNIxXcDWsVMQ1t8rhepXbg5rtaw9d2C4E6UkRis/pYg4xKFLReY+VknS
	6hcbaf0FQsKpR4xe7Og==
X-Google-Smtp-Source: AGHT+IEqdMaTCeR+5N661ePS75QOvFa8jZaaiw9BcHvMUuJwBncrqCmIT7qsnybEQWIN2tFvBp2petyzPSOYJ3zy
X-Received: from yosry.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:29b4])
 (user=yosryahmed job=sendgmr) by 2002:a63:e57:0:b0:5dc:20e1:c894 with SMTP id
 23-20020a630e57000000b005dc20e1c894mr3697pgo.4.1713403718174; Wed, 17 Apr
 2024 18:28:38 -0700 (PDT)
Date: Thu, 18 Apr 2024 01:28:33 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.44.0.683.g7961c838ac-goog
Message-ID: <20240418012835.3360429-1-yosryahmed@google.com>
Subject: [PATCH tip:x86/mm v3 1/3] x86/mm: Use IPIs to synchronize LAM enablement
From: Yosry Ahmed <yosryahmed@google.com>
To: x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, 
	"H. Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
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

v2 -> v3:
- Rebased on top of the latest tip:x86/mm after v6.9-rc3.
- Collected R-b on patch 2 (thanks!).

---
 arch/x86/kernel/process_64.c | 13 +++++++++++--
 arch/x86/mm/tlb.c            |  7 +++----
 2 files changed, 14 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kernel/process_64.c b/arch/x86/kernel/process_64.c
index 7062b84dd467d..c27798f23ef82 100644
--- a/arch/x86/kernel/process_64.c
+++ b/arch/x86/kernel/process_64.c
@@ -798,6 +798,16 @@ static long prctl_map_vdso(const struct vdso_image *image, unsigned long addr)
 
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
@@ -830,8 +840,7 @@ static int prctl_enable_tagged_addr(struct mm_struct *mm, unsigned long nr_bits)
 		return -EINVAL;
 	}
 
-	write_cr3(__read_cr3() | mm->context.lam_cr3_mask);
-	set_tlbstate_lam_mode(mm);
+	on_each_cpu_mask(mm_cpumask(mm), enable_lam_func, mm, true);
 	set_bit(MM_CONTEXT_LOCK_LAM, &mm->context.flags);
 
 	mmap_write_unlock(mm);
diff --git a/arch/x86/mm/tlb.c b/arch/x86/mm/tlb.c
index 44ac64f3a047c..a041d2ecd8380 100644
--- a/arch/x86/mm/tlb.c
+++ b/arch/x86/mm/tlb.c
@@ -503,9 +503,9 @@ void switch_mm_irqs_off(struct mm_struct *unused, struct mm_struct *next,
 {
 	struct mm_struct *prev = this_cpu_read(cpu_tlbstate.loaded_mm);
 	u16 prev_asid = this_cpu_read(cpu_tlbstate.loaded_mm_asid);
-	unsigned long new_lam = mm_lam_cr3_mask(next);
 	bool was_lazy = this_cpu_read(cpu_tlbstate_shared.is_lazy);
 	unsigned cpu = smp_processor_id();
+	unsigned long new_lam;
 	u64 next_tlb_gen;
 	bool need_flush;
 	u16 new_asid;
@@ -619,9 +619,7 @@ void switch_mm_irqs_off(struct mm_struct *unused, struct mm_struct *next,
 			cpumask_clear_cpu(cpu, mm_cpumask(prev));
 		}
 
-		/*
-		 * Start remote flushes and then read tlb_gen.
-		 */
+		/* Start receiving IPIs and then read tlb_gen (and LAM below) */
 		if (next != &init_mm)
 			cpumask_set_cpu(cpu, mm_cpumask(next));
 		next_tlb_gen = atomic64_read(&next->context.tlb_gen);
@@ -633,6 +631,7 @@ void switch_mm_irqs_off(struct mm_struct *unused, struct mm_struct *next,
 		barrier();
 	}
 
+	new_lam = mm_lam_cr3_mask(next);
 	set_tlbstate_lam_mode(next);
 	if (need_flush) {
 		this_cpu_write(cpu_tlbstate.ctxs[new_asid].ctx_id, next->context.ctx_id);
-- 
2.44.0.683.g7961c838ac-goog


