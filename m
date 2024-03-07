Return-Path: <linux-kernel+bounces-95632-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4254B875082
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 14:43:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 665761C22C25
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 13:43:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFE3D131E32;
	Thu,  7 Mar 2024 13:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="v2yoGAAJ"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F4E5130E2A
	for <linux-kernel@vger.kernel.org>; Thu,  7 Mar 2024 13:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709818764; cv=none; b=JtBt3y1TnWEvlFf1mVcjjLmnYRr9g9rhYuv+q9a/KiFJNlFSiYySFazHy2x93m0+ji+5xKfYKBqpXckN/sxzzLaSOWpBHInEOIZenIQtFco6JaOrGYvVlLa3IUmqgnrgDX09tfPDu0ES3K/iWGxKKWwRHZ5IZFthTFEzi4+nQ6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709818764; c=relaxed/simple;
	bh=VPN+QZb9VZkKh5kItaUodUVreCEyz/HdCSJnkxIsnOo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=MTpEPhqxM03zyyWFrRv2+x0Ljy8B71mdNM2O+0ANjmYHYxIgCFEmN4DcwyJwVTAymrHlFFOjZT9vBiGP7kAB2Zx7w35NE0SWremRXSNyKd6rIsXqkBQsSTThBq+iDmyQ9JpEE6qNDkLwyspSOWl5kr7zeldpJUWeeqks7MF57Wc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yosryahmed.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=v2yoGAAJ; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yosryahmed.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dc64e0fc7c8so1345041276.2
        for <linux-kernel@vger.kernel.org>; Thu, 07 Mar 2024 05:39:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709818762; x=1710423562; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=MPmHpgEfpH39wv9P3N7+5I+Np9ZrrLnfHGs5cKPvN1A=;
        b=v2yoGAAJ0qWegqFvuKBU3Ukuw0KMddfc2RLiiFghnSVF1e7kofSi+aRik/yaS+gS2H
         l2fbevK4Ux0VgzX7qiGxfgvFLDYE24mI4ACB92hLACB3XGDzofRa4FeG423kz2TVcKJN
         ZVI5I2sToySJEkygFFodB/g3sOcTzsTlg8FajcDfExbdK2uIi73MSQK/jdn0UA7WHq0l
         Pt0h9cBTjo8XmOlF8zeOr+dAHObsLORq95TLvX28J/Xsg7yxxQI/AFXXV37pf+jm+M2a
         rg9MjAJRLfZazr6a+yu4AhDa30NY+8IuaGwxt9DSqSrzc7iowtTPP/C6Xc2ztS8YvMq/
         Qkug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709818762; x=1710423562;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MPmHpgEfpH39wv9P3N7+5I+Np9ZrrLnfHGs5cKPvN1A=;
        b=bQi9c1rWZDF89BNShRMh4s2JAVGk317DHkOhLGD0Xj6uF3kgpwVcXANMeCKeheA2ky
         TmIsBNiR8MAapI4kyPi2hJ93LIup27gNtLx1y229fCgP8+7vgiUaLA9jRlGXSBaol+Ub
         Yve8mMo5FuCoRx9RkH4kIphuwWJsyS22t1qPSHjUoYFKX2xLFVK7eQjvUjPYvDCLVq/0
         DXPKSMjF3Ft2RAmM7HySfUJBDcUIjUBgxotoxDMigp6r/uMoe5hH5QqCLem0apqtCOeJ
         sBjumb+qYLafTgKb5ysXyBWUhPvsg/KhXnI/WC/hvSDmxSk49Hg+Tq7ycDu/W6ysDmxS
         nxbg==
X-Forwarded-Encrypted: i=1; AJvYcCXiw2uFG8pWwRqiFqFQcFVIxi2N0Az7TO+BhSbKYPz/pAzYaP/7MG6EB/9e0h8icov6NdYuiySC7Kse0f+DYX5nd2cI1Xk8x83sBo5g
X-Gm-Message-State: AOJu0YwIcPRJd09YJagvoG3m6uqz286DPLhyKVQzV/SlK5q7KUS5v/yO
	SUNpe3x1qejhTLYRmYHTqwmy0HsK1E6WD44N730kT5DB9eD1C2CJ63aVlfdNjgkff6Qm2SjD2M6
	dD2cElJP8rvUsfmXCkg==
X-Google-Smtp-Source: AGHT+IERNwqp0BbMH+HdatOkbB3X7SeaUZ0qNtYllODJdaNR0SQYYHmwI9BfJm6ZZYu3OtMlHLptB1kSZCzrhOZk
X-Received: from yosry.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:29b4])
 (user=yosryahmed job=sendgmr) by 2002:a05:6902:2183:b0:dcb:fb69:eadc with
 SMTP id dl3-20020a056902218300b00dcbfb69eadcmr781549ybb.6.1709818762290; Thu,
 07 Mar 2024 05:39:22 -0800 (PST)
Date: Thu,  7 Mar 2024 13:39:15 +0000
In-Reply-To: <20240307133916.3782068-1-yosryahmed@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240307133916.3782068-1-yosryahmed@google.com>
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Message-ID: <20240307133916.3782068-3-yosryahmed@google.com>
Subject: [RFC PATCH 2/3] x86/mm: make sure LAM is up-to-date during context switching
From: Yosry Ahmed <yosryahmed@google.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@intel.com>, Peter Zijlstra <peterz@infradead.org>, 
	Andy Lutomirski <luto@kernel.org>, "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, x86@kernel.org, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Yosry Ahmed <yosryahmed@google.com>
Content-Type: text/plain; charset="UTF-8"

During context switching, if we are not switching to new mm and no TLB
flush is needed, we do not write CR3. However, it is possible that a
user thread enables LAM while a kthread is running on a different CPU
with the old LAM CR3 mask. If the kthread context switches into any
thread of that user process, it may not write CR3 with the new LAM mask,
which would cause the user thread to run with a misconfigured CR3 that
disables LAM on the CPU.

Fix this by making sure we write a new CR3 if LAM is not up-to-date. No
problems were observed in practice, this was found by code inspection.

Not that it is possible that mm->context.lam_cr3_mask changes throughout
switch_mm_irqs_off(). But since LAM can only be enabled by a
single-threaded process on its own behalf, in that case we cannot be
switching to a user thread in that same process, we can only be
switching to another kthread using the borrowed mm or a different user
process, which should be fine.

Fixes: 82721d8b25d7 ("x86/mm: Handle LAM on context switch")
Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
---
 arch/x86/mm/tlb.c | 50 ++++++++++++++++++++++++++++-------------------
 1 file changed, 30 insertions(+), 20 deletions(-)

diff --git a/arch/x86/mm/tlb.c b/arch/x86/mm/tlb.c
index 2975d3f89a5de..3610c23499085 100644
--- a/arch/x86/mm/tlb.c
+++ b/arch/x86/mm/tlb.c
@@ -503,11 +503,12 @@ void switch_mm_irqs_off(struct mm_struct *unused, struct mm_struct *next,
 {
 	struct mm_struct *prev = this_cpu_read(cpu_tlbstate.loaded_mm);
 	u16 prev_asid = this_cpu_read(cpu_tlbstate.loaded_mm_asid);
+	u64 cpu_tlb_gen = this_cpu_read(cpu_tlbstate.ctxs[prev_asid].tlb_gen);
 	bool was_lazy = this_cpu_read(cpu_tlbstate_shared.is_lazy);
+	bool need_flush = false, need_lam_update = false;
 	unsigned cpu = smp_processor_id();
 	unsigned long new_lam;
 	u64 next_tlb_gen;
-	bool need_flush;
 	u16 new_asid;
 
 	/* We don't want flush_tlb_func() to run concurrently with us. */
@@ -570,32 +571,41 @@ void switch_mm_irqs_off(struct mm_struct *unused, struct mm_struct *next,
 				 !cpumask_test_cpu(cpu, mm_cpumask(next))))
 			cpumask_set_cpu(cpu, mm_cpumask(next));
 
+		/*
+		 * tlbstate_lam_cr3_mask() may be outdated if a different thread
+		 * has enabled LAM while we were borrowing its mm on this CPU.
+		 * Make sure we update CR3 in case we are switching to another
+		 * thread in that process.
+		 */
+		if (tlbstate_lam_cr3_mask() != mm_lam_cr3_mask(next))
+			need_lam_update = true;
+
 		/*
 		 * If the CPU is not in lazy TLB mode, we are just switching
 		 * from one thread in a process to another thread in the same
 		 * process. No TLB flush required.
 		 */
-		if (!was_lazy)
-			return;
+		if (was_lazy) {
+			/*
+			 * Read the tlb_gen to check whether a flush is needed.
+			 * If the TLB is up to date, just use it.  The barrier
+			 * synchronizes with the tlb_gen increment in the TLB
+			 * shootdown code.
+			 */
+			smp_mb();
+			next_tlb_gen = atomic64_read(&next->context.tlb_gen);
+			if (cpu_tlb_gen < next_tlb_gen) {
+				/*
+				 * TLB contents went out of date while we were
+				 * in lazy mode.
+				 */
+				new_asid = prev_asid;
+				need_flush = true;
+			}
+		}
 
-		/*
-		 * Read the tlb_gen to check whether a flush is needed.
-		 * If the TLB is up to date, just use it.
-		 * The barrier synchronizes with the tlb_gen increment in
-		 * the TLB shootdown code.
-		 */
-		smp_mb();
-		next_tlb_gen = atomic64_read(&next->context.tlb_gen);
-		if (this_cpu_read(cpu_tlbstate.ctxs[prev_asid].tlb_gen) ==
-				next_tlb_gen)
+		if (!need_flush && !need_lam_update)
 			return;
-
-		/*
-		 * TLB contents went out of date while we were in lazy
-		 * mode. Fall through to the TLB switching code below.
-		 */
-		new_asid = prev_asid;
-		need_flush = true;
 	} else {
 		/*
 		 * Apply process to process speculation vulnerability
-- 
2.44.0.278.ge034bb2e1d-goog


