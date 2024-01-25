Return-Path: <linux-kernel+bounces-39043-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8338783CA22
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 18:35:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 23B6F1F269D8
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 17:35:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2E63131736;
	Thu, 25 Jan 2024 17:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="WP0rzOgN"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA0BA22089
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 17:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706204100; cv=none; b=HGaCDRyk4KY4oo3NPDPxZZeRvOKFLL9CuZ+BSofLGajTWXbnaNuthwmiWDsM2UIkMrWgsMKFQsAR+w/XxrJPJ0V9werwRCE9qlmYpBORAngBiRk87fNaLMXMplss0C1TzSZgfju5zyg+xL812i/SAgI76PQgeD4/S4D6OC0nOuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706204100; c=relaxed/simple;
	bh=Jn8Mc4RpAgdStA0f7MeGBcH7wYwOehXInowhcwQGF8U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=o44NGWQQiOwoW2g1lMdE1cKTNW4cpEhfxMw41e+SNfqyIsTOyqgVdenYSn0KpMuqgeDGB72rxEooojx57EXTRmGUrj/2U57I8wEeMZdIgc2xawwxmKxXzkBbPvwcnCrj60Hr/SivSou2BEU/UFqcAcw9d0KNGWz4aXoH3cxO8kM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=WP0rzOgN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06CE7C433C7;
	Thu, 25 Jan 2024 17:35:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1706204100;
	bh=Jn8Mc4RpAgdStA0f7MeGBcH7wYwOehXInowhcwQGF8U=;
	h=From:To:Cc:Subject:Date:From;
	b=WP0rzOgNFPr/PC6Mca6T8KKT2P9BE6Ya8ZMBHkE5S2+yHAdq8UVQJM5XZpvdWzXlI
	 500Rx42tI2MRd6JAXkVYFPdMzATppao3AJeE8pVVk/9KVJy4t/qbhwIrkr4ccukhQ2
	 QVoRtG5OSnf+L/svFSoVr3ImkEmXKISwp3GP954Y=
From: Linus Torvalds <torvalds@linux-foundation.org>
To: Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@kernel.org>
Cc: arch/x86 maintainers <x86@kernel.org>,
	linux-kernel@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH] x86: mm: get rid of conditional IF flag handling in page fault path
Date: Thu, 25 Jan 2024 09:34:57 -0800
Message-ID: <20240125173457.1281880-1-torvalds@linux-foundation.org>
X-Mailer: git-send-email 2.43.0.5.g38fb137bdb
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We had this nonsensical code that would happily handle kernel page
faults with interrupts disabled, which makes no sense at all.

It turns out that this is legacy code that _used_ to make sense, back
when we enabled irqs as early as possible, and we used to have this code
sequence essentially immediately after reading the faulting address from
register %cr2.

Back then, we could have kernel page faults to populate the vmalloc area
with interrupts disabled, and they would need to stay disabled for that
case.

However, the code in question has been moved down in the page fault
handling, and is now in the "handle faults in user addresses" section,
and apparently nobody ever noticed that it no longer makes sense to
handle these page faults with interrupts conditionally disabled.

So replace the conditional irq enable

        if (regs->flags & X86_EFLAGS_IF)
                local_irq_enable();

with an unconditional one, and add a temporary WARN_ON_ONCE() if some
codepath actually does do page faults with interrupts disabled (without
also doing a pagefault_disable(), of course).

NOTE! We used to allow user space to disable interrupts with iopl(3).
That is no longer true since commits

 a24ca9976843 ("x86/iopl: Remove legacy IOPL option")
 b968e84b509d ("x86/iopl: Fake iopl(3) CLI/STI usage")

so the WARN_ON_ONCE() is valid for both the kernel and user situation.

For some of the history relevant to this code, see particularly commit
8c914cb704a1 ("x86_64: actively synchronize vmalloc area when
registering certain callbacks") which moved this below the vmalloc fault
handling.

Now that the user_mode() check is irrelevant, we can also move the
FAULT_FLAG_USER flag setting down to where the other flag settings are
done.

Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
---
 arch/x86/mm/fault.c | 27 ++++++++++++++-------------
 1 file changed, 14 insertions(+), 13 deletions(-)

diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
index 679b09cfe241..150e002e0884 100644
--- a/arch/x86/mm/fault.c
+++ b/arch/x86/mm/fault.c
@@ -1302,21 +1302,14 @@ void do_user_addr_fault(struct pt_regs *regs,
 		return;
 	}
 
-	/*
-	 * It's safe to allow irq's after cr2 has been saved and the
-	 * vmalloc fault has been handled.
-	 *
-	 * User-mode registers count as a user access even for any
-	 * potential system fault or CPU buglet:
-	 */
-	if (user_mode(regs)) {
-		local_irq_enable();
-		flags |= FAULT_FLAG_USER;
-	} else {
-		if (regs->flags & X86_EFLAGS_IF)
-			local_irq_enable();
+	/* Legacy check - remove this after verifying that it doesn't trigger */
+	if (WARN_ON_ONCE(!(regs->flags & X86_EFLAGS_IF))) {
+		bad_area_nosemaphore(regs, error_code, address);
+		return;
 	}
 
+	local_irq_enable();
+
 	perf_sw_event(PERF_COUNT_SW_PAGE_FAULTS, 1, regs, address);
 
 	/*
@@ -1332,6 +1325,14 @@ void do_user_addr_fault(struct pt_regs *regs,
 	if (error_code & X86_PF_INSTR)
 		flags |= FAULT_FLAG_INSTRUCTION;
 
+	/*
+	 * We set FAULT_FLAG_USER based on the register state, not
+	 * based on X86_PF_USER. User space accesses that cause
+	 * system page faults are still user accesses.
+	 */
+	if (user_mode(regs))
+		flags |= FAULT_FLAG_USER;
+
 #ifdef CONFIG_X86_64
 	/*
 	 * Faults in the vsyscall page might need emulation.  The
-- 
2.43.0.5.g38fb137bdb


