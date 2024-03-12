Return-Path: <linux-kernel+bounces-99806-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DC3E3878DB2
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 05:00:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A93DD1C21875
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 04:00:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 720FFB67F;
	Tue, 12 Mar 2024 03:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ofi5QQsi"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BF6EB651
	for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 03:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710215996; cv=none; b=MxoOwp2lxEcH72uJ9ySMXgjhK+UAO+ZXLpsVOkTSME7ngnSkGRDVpzah4AoW7+d5gimMDcuzYc466Yqwj2P+SCRR1Es0k+1cd003dXQ3MUBfLODipJddUHSbg2kFTMy2NerQRVJC0ulhgIHkULI1fDaH/aofYW6jIvKhgDlOjKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710215996; c=relaxed/simple;
	bh=/xAeJJNCtXuVIj2w2SCBuL5oJF5SU5U+dl21TGId92M=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=ZtyNg1HjzX0y4FlzknhRTp89TAzgNBFv3bqRgwl/LvZiLOgUfCgbFcwBtJLgW8nOfkB0i1jLO30Z0WPBC+ltMn6Ga0TzvcRaoitiTpkl6CKosU/mTjcobxDjP6g6+7YcejrYm8SmnKaxqM91wrjIxL5xRJmJwd4SBrgS8JGXfqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yosryahmed.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Ofi5QQsi; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yosryahmed.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dbf618042daso7799211276.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 20:59:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1710215994; x=1710820794; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=H0vvm77KC92mPCMDKE7JIHK7Q88ob4yruXgItrPO0iI=;
        b=Ofi5QQsiZqnIQ2kHZAXmB63TZorvBU+zx0bv4pWdMs1sYDZmHAfNJ8+RxunzwOzpjK
         KNkYgIRYhQ6dYCelrCMrgGfy84SoPtmnuISTCo9ovbmKF6BVJIZ2GI9ImWbo61aIQZ4/
         OT8ptOQCYmL0DX/V3azwRXoiVpiWCd/wgtm+81rQ9Q/8kEqyNbOVStx3CxS47uQio+ZK
         OCCo1JlqtuJKCbqAko28GXCVsjhqr3sstOQY9c2UkTLi7ccZIy8zLYAaUxlrTpjMXXnn
         yw39NI1wG354eQYLEVtOzN9ZPcDED2Fvgp9EeXt2BpNJbbn2pbgtXlLd/lqpEwmSkbv/
         MuAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710215994; x=1710820794;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=H0vvm77KC92mPCMDKE7JIHK7Q88ob4yruXgItrPO0iI=;
        b=FIDzy2pczuXpZgwqhdjZ8gQmF8presHNmWirPFf+zgn5bGeDSEPPfzISMNAE5OUJoc
         RnKlpuCYpZGgFsJAW7kPaGJrIkHGoifvikurqVu1hby3O5cfoXR4TTyDn4zlZWO+NYVZ
         YgDeCy705btdeYkxrPQXSE2ogXRSce9KSgOQB+HKSDKCON0wdogsgebyuyr43ZtjhAh9
         7iWzHj1mR7dRcx1I0vuZF0VC8YfUcIKQy6UJFwOWnLQlGEGxHkp9FzIlyMFvj+jCe+Ex
         6ADiQJrYTVLRg1P7Wvt4re2tmYxOaw3w7Rs56QarjvM4d7qgUFWFr7aBN770uSOpJHV2
         nX+Q==
X-Forwarded-Encrypted: i=1; AJvYcCVZaBpcsZkpBL5Qm6N++727BHmCLu1q4Bns48f9sS3A6D+uWLbN5cYkCPYqHvbaJEf2Z6qqJRQ6cbteZ5lOk/qdBDJ18tyX/0CI7egy
X-Gm-Message-State: AOJu0YxsO/k+prSyag4SU+haLTdjt5vDLTN7M3bsxb3Cn0UpmhARt2RV
	iUd7VSNvIQa2Pww7itMqxSyeggPil91aENBkbf8jPnM9wNCziO7+MSn1hiTFzxBrDyLBz6eF+7/
	NZJAU57h56Ad5yRHAxw==
X-Google-Smtp-Source: AGHT+IE3j2RbmWLGWhXwtCN+tJydKqNDYdq63uVBUe/GpO70ij5hxpAGdtBQ8Cwz7kcE3p6RwDKKNDFJe0VFKiIx
X-Received: from yosry.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:29b4])
 (user=yosryahmed job=sendgmr) by 2002:a05:6902:f02:b0:dcd:2f2d:7a0f with SMTP
 id et2-20020a0569020f0200b00dcd2f2d7a0fmr427882ybb.9.1710215994014; Mon, 11
 Mar 2024 20:59:54 -0700 (PDT)
Date: Tue, 12 Mar 2024 03:59:49 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Message-ID: <20240312035951.3535980-1-yosryahmed@google.com>
Subject: [PATCH 1/3] x86/mm: Use IPIs to synchronize LAM enablement
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


