Return-Path: <linux-kernel+bounces-39738-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C14883D592
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 10:10:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9348E1F26BA6
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 09:10:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1CDC664D8;
	Fri, 26 Jan 2024 08:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NbDDGcq3"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 320E5664B5
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 08:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706256411; cv=none; b=UQ0LXS7Np+3+98D7tXzcuKmph6VIREZh+VvnBBNCoV7ff6AJXTeFmwJsQvwT2Awl0QIBFhco1+UxQZywDYIsbd5vvjpi39BfVG7KIFEJlKiAORo8Vvd4VfYmwLm28CoJr3B3lsuZMBO140WB/VXAaXtACAjS90CcmMIsTlFQ6rE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706256411; c=relaxed/simple;
	bh=roIzFVzAQtEdsG7tKFoEo4L5+d6j6ErK0tCvb2uHKIU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=eg1dGvq9hgEdeUE0PokL2Fhg2lx3yjvF3mXxqoGwgXEu1hJXeTtY6oQaun2TJ8qHq0bbr7K//g/MHtMsimWatJV/7+wU069f5qQ0s8IxbAmORpLX77nZc/Xk2sqIe3lfkUuTDM2Smjexc6BDVVq7+yWQzDO/ZJsTcJYkkyBDLG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yosryahmed.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NbDDGcq3; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yosryahmed.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dc3645c083aso210586276.2
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 00:06:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706256409; x=1706861209; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=qO38tEb5zM4VymKs6ibKE+57i3iPVkOa3/Idb5enOqs=;
        b=NbDDGcq3YWx3EjGHhk7q5NH+FWS7+lbX4BSQnfjfqicdqv44+pKqdLiweoNM4Uyi+x
         3P40bqYAHrlkEbLdwb44sr9KotnM1jXL8l6w9D1LeW9/HGDbiov4ucmOqXJYCPmKmiyq
         tjluhKAvOBhPx8RqZyataGu5uYIEOiFnBJEpkL9RSSkB+w6wr4DO1QrmcXm9eTUDJqY8
         rFWCH4MU05yTZ+Gk5Q0cjIqWkfEAnbuPbDqxkQ/+ZxRzOZ3ym2iyH7WhxIb1S8d+dy8b
         VxL0pGwgmyCbsxbpvVdeFYaDrbGCI5TEHtOG/68pDh64IXKM9JUB7Orf4q+AUbVXTVNU
         BUmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706256409; x=1706861209;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qO38tEb5zM4VymKs6ibKE+57i3iPVkOa3/Idb5enOqs=;
        b=MVgF8i/qnzyKe0jn4sCcTLfaN7hRK+pNhA8MVKaEnC+SOq58R/vvWawyZBLIXMlnd4
         5FYvFeTG/Kp2aldA0N8ab0dcdAK8HSFjSIvvk3mYzJoJHkFjhCl4BZ625qaXiSMY89QJ
         lbk4GzKP0rWByoi5Btkw2j/r/1V3B9SZrSax643lXvcgSgcksDCYYO7xcX5qO/ShVQhF
         KcS0jQ0b6wejJornaKbU/UjquAX4yjHEggwcUwzG6fgP4oW+cTk5h7aCYlVnzelXAfHF
         EVcIDG5z2bj+dY/4w2U37rn3MNzuqyi91hOOH4DFlYqcsNtSm5IUJYxeQF4n3HESYl8z
         abrw==
X-Gm-Message-State: AOJu0YyiCHmpZo+gfHn7S2jUXd4ts95fTPf8IW0kxa6KWoTpOmESYemX
	ScZp5xLy+CTjI5k1hzrOEXAuvEbNdTbcGZGVfuVIzpYhnX8nBynBl1Xaz6ZZK74dWMwAtOWPZco
	TNhmqQq97A0ZxEFFe3w==
X-Google-Smtp-Source: AGHT+IGtSc7FTilAvbWm1bnuTEL3QKF1axH5jK6w0o1wwqlROcZ4vY9lg44aTpbRR3M0/L4W8/DAZIlzpDwiNTHT
X-Received: from yosry.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:29b4])
 (user=yosryahmed job=sendgmr) by 2002:a05:6902:2085:b0:dc2:5525:f6b with SMTP
 id di5-20020a056902208500b00dc255250f6bmr539405ybb.7.1706256409103; Fri, 26
 Jan 2024 00:06:49 -0800 (PST)
Date: Fri, 26 Jan 2024 08:06:44 +0000
In-Reply-To: <20240126080644.1714297-1-yosryahmed@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240126080644.1714297-1-yosryahmed@google.com>
X-Mailer: git-send-email 2.43.0.429.g432eaa2c6b-goog
Message-ID: <20240126080644.1714297-2-yosryahmed@google.com>
Subject: [PATCH 2/2] x86/mm: clarify "prev" usage in switch_mm_irqs_off()
From: Yosry Ahmed <yosryahmed@google.com>
To: Ingo Molnar <mingo@redhat.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, Andy Lutomirski <luto@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Andrew Morton <akpm@linux-foundation.org>, x86@kernel.org, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Yosry Ahmed <yosryahmed@google.com>
Content-Type: text/plain; charset="UTF-8"

In the x86 implementation of switch_mm_irqs_off(), we do not use the
"prev" argument passed in by the caller, we use exclusively use
"real_prev", which is cpu_tlbstate.loaded_mm. This is not obvious at the
first sight.

Furthermore, a comment describes a condition that happens
when called with prev == next, but this should not affect the function
in any way since prev is unused. Apparently, the comment is intended to
clarify why we don't rely on prev == next to decide whether we need to
update CR3, but again, it is not obvious. The comment also references
the fact that leave_mm() calls with prev == NULL and tsk == NULL, but
this also shouldn't matter because prev is unused and tsk is only used
in one function which has a NULL check.

Clarify things by renaming (prev -> unused) and (real_prev -> prev),
also move and rewrite the comment as an explanation for why we don't
rely on "prev" supplied by the caller in x86 code and use our own.
Hopefully this makes reading the code easier.

Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
---
 arch/x86/mm/tlb.c | 35 ++++++++++++++++-------------------
 1 file changed, 16 insertions(+), 19 deletions(-)

diff --git a/arch/x86/mm/tlb.c b/arch/x86/mm/tlb.c
index 80b0caa82a91b..bf9605caf24f7 100644
--- a/arch/x86/mm/tlb.c
+++ b/arch/x86/mm/tlb.c
@@ -492,10 +492,16 @@ void cr4_update_pce(void *ignored)
 static inline void cr4_update_pce_mm(struct mm_struct *mm) { }
 #endif
 
-void switch_mm_irqs_off(struct mm_struct *prev, struct mm_struct *next,
+/*
+ * The "prev" argument passed by the caller does not always match CR3. For
+ * example, the scheduler passes in active_mm when switching from lazy TLB mode
+ * to normal mode, but switch_mm_irqs_off() can be called from x86 code without
+ * updating active_mm. Use cpu_tlbstate.loaded_mm instead.
+ */
+void switch_mm_irqs_off(struct mm_struct *unused, struct mm_struct *next,
 			struct task_struct *tsk)
 {
-	struct mm_struct *real_prev = this_cpu_read(cpu_tlbstate.loaded_mm);
+	struct mm_struct *prev = this_cpu_read(cpu_tlbstate.loaded_mm);
 	u16 prev_asid = this_cpu_read(cpu_tlbstate.loaded_mm_asid);
 	unsigned long new_lam = mm_lam_cr3_mask(next);
 	bool was_lazy = this_cpu_read(cpu_tlbstate_shared.is_lazy);
@@ -504,15 +510,6 @@ void switch_mm_irqs_off(struct mm_struct *prev, struct mm_struct *next,
 	bool need_flush;
 	u16 new_asid;
 
-	/*
-	 * NB: The scheduler will call us with prev == next when switching
-	 * from lazy TLB mode to normal mode if active_mm isn't changing.
-	 * When this happens, we don't assume that CR3 (and hence
-	 * cpu_tlbstate.loaded_mm) matches next.
-	 *
-	 * NB: leave_mm() calls us with prev == NULL and tsk == NULL.
-	 */
-
 	/* We don't want flush_tlb_func() to run concurrently with us. */
 	if (IS_ENABLED(CONFIG_PROVE_LOCKING))
 		WARN_ON_ONCE(!irqs_disabled());
@@ -527,7 +524,7 @@ void switch_mm_irqs_off(struct mm_struct *prev, struct mm_struct *next,
 	 * isn't free.
 	 */
 #ifdef CONFIG_DEBUG_VM
-	if (WARN_ON_ONCE(__read_cr3() != build_cr3(real_prev->pgd, prev_asid,
+	if (WARN_ON_ONCE(__read_cr3() != build_cr3(prev->pgd, prev_asid,
 						   tlbstate_lam_cr3_mask()))) {
 		/*
 		 * If we were to BUG here, we'd be very likely to kill
@@ -559,7 +556,7 @@ void switch_mm_irqs_off(struct mm_struct *prev, struct mm_struct *next,
 	 * provides that full memory barrier and core serializing
 	 * instruction.
 	 */
-	if (real_prev == next) {
+	if (prev == next) {
 		/* Not actually switching mm's */
 		VM_WARN_ON(this_cpu_read(cpu_tlbstate.ctxs[prev_asid].ctx_id) !=
 			   next->context.ctx_id);
@@ -574,7 +571,7 @@ void switch_mm_irqs_off(struct mm_struct *prev, struct mm_struct *next,
 		 * mm_cpumask. The TLB shootdown code can figure out from
 		 * cpu_tlbstate_shared.is_lazy whether or not to send an IPI.
 		 */
-		if (WARN_ON_ONCE(real_prev != &init_mm &&
+		if (WARN_ON_ONCE(prev != &init_mm &&
 				 !cpumask_test_cpu(cpu, mm_cpumask(next))))
 			cpumask_set_cpu(cpu, mm_cpumask(next));
 
@@ -616,10 +613,10 @@ void switch_mm_irqs_off(struct mm_struct *prev, struct mm_struct *next,
 		 * Skip kernel threads; we never send init_mm TLB flushing IPIs,
 		 * but the bitmap manipulation can cause cache line contention.
 		 */
-		if (real_prev != &init_mm) {
+		if (prev != &init_mm) {
 			VM_WARN_ON_ONCE(!cpumask_test_cpu(cpu,
-						mm_cpumask(real_prev)));
-			cpumask_clear_cpu(cpu, mm_cpumask(real_prev));
+						mm_cpumask(prev)));
+			cpumask_clear_cpu(cpu, mm_cpumask(prev));
 		}
 
 		/*
@@ -656,9 +653,9 @@ void switch_mm_irqs_off(struct mm_struct *prev, struct mm_struct *next,
 	this_cpu_write(cpu_tlbstate.loaded_mm, next);
 	this_cpu_write(cpu_tlbstate.loaded_mm_asid, new_asid);
 
-	if (next != real_prev) {
+	if (next != prev) {
 		cr4_update_pce_mm(next);
-		switch_ldt(real_prev, next);
+		switch_ldt(prev, next);
 	}
 }
 
-- 
2.43.0.429.g432eaa2c6b-goog


