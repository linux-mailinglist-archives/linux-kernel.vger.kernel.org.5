Return-Path: <linux-kernel+bounces-126878-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9072E8942B1
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 18:55:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 50C0F283663
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 16:55:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16B56481B8;
	Mon,  1 Apr 2024 16:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=otheo.eu header.i=@otheo.eu header.b="jVcjMl9g"
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 066C463E
	for <linux-kernel@vger.kernel.org>; Mon,  1 Apr 2024 16:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711990510; cv=none; b=OTWpwLZABsqtzO/a2SdW16LOqLO2Li28WtKJaJ1GvaJApY2qQhdG8qSKvcmMMV0dLjQxRb5/YosOHxVTq3P7T+orW1Bs3Uyapq9gwj5ZGLhFgATilaOgooOdrSpM72COsMieNzDdJH2hBNRhTK7F8a9N5/lt5soYGPe9/VAKyTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711990510; c=relaxed/simple;
	bh=loXoyHITmAJbZaVlOq0ifrygJQTZAQ0Rp1mbsUGkQRw=;
	h=Date:From:To:Cc:Subject:Message-Id:Mime-Version:Content-Type; b=gISxigVamqv7Xy/pztXk6Zu9QOoKkCjkpscWlI0jkFlUZYNYHmxj+kZH14/6nD0Nq7rN9h0zm8+n0ay6uY62/hyvkK8bJue6x4qCbeQSf5tPwtMkrD62eCOk/SsHUvX+TZAaY/ThWALzaPYmw8vZvX0zGN45HAA4L02XQcR4ZA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=otheo.eu; spf=pass smtp.mailfrom=otheo.eu; dkim=pass (2048-bit key) header.d=otheo.eu header.i=@otheo.eu header.b=jVcjMl9g; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=otheo.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=otheo.eu
Received: by mail.gandi.net (Postfix) with ESMTPSA id 84503240005;
	Mon,  1 Apr 2024 16:55:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=otheo.eu; s=gm1;
	t=1711990503;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=5w8wZrGlYuVnKoSzFP/wqr+258TW0RnrxR13Qe/v/kA=;
	b=jVcjMl9gSLV4gWgdD0yyB7QPwDkqgxtJZpXicWujpd1j77GwylPEILHcS6TJ13NattA3ix
	ehRUKKSIUrs/yxvA6KOmDea02DrSR8bGR8fsU6eqSzXqcz1k/b4URWLyMoBLCfr0hcdWNN
	lxV/dAAkUXE35wZV5qQGI3TaX9WxPxsG5Ai+t0DHVSiaTpVp1ptedtPqZr3Z3oXFzbMFvo
	6k/34MxMmC3voxbA3L912+91fI1MktRrO9cphtnREmPG1s3Bpbu3LyDTcXguCoFPDZXrnS
	yJgcxH0w9w1Y9+av9/DiECefuHhcQODfuTLlfCKYkvvzz8WeuWvOqtq1DROsaA==
Date: Mon, 1 Apr 2024 18:54:51 +0200
From: Javier Pello <devel@otheo.eu>
To: linux-kernel@vger.kernel.org
Cc: x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar
 <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen
 <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH 0/1] Split lock detected in kernel mode on x86-32 with PAE
Message-Id: <20240401185451.6897208962d3fc47a12ffb5a@otheo.eu>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; i686-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-GND-Sasl: #01#@otheo.eu

Dear list,

I am hitting a problem with split locks after recently updating the
kernel on my system to 6.8.2. Some tasks occasionally get stuck on
program termination, and dmesg shows output like the following:

[0.000000] Split lock detected
[0.000000] : 0000 [#1] SMP
[0.000000] CPU: 10 PID: 1330 Comm: a.out Not tainted 6.8.2 #2
[0.000000] Hardware name: Gigabyte Technology Co., Ltd. H610M S2H DDR4/H610M S2H DDR4, BIOS FL 11/15/2022
[0.000000] EIP: __split_huge_pmd+0x468/0xa0c
[0.000000] Code: e0 0c 83 c8 67 89 55 bc 8b 55 d8 89 45 b8 8b 45 d4 8b 4d bc 89 55 b4 8b 55 b4 89 45 b0 8b 45 b8 89 7d b8 89 df 89 c3 8b 45 b0 <f0> 0f c7 4d d4 75 f9 8d 45 d4 89 fb 8b 7d b8 31 c9 89 fa e8 6c cf
[0.000000] EAX: c36797c0 EBX: b85cd067 ECX: 00000004 EDX: 00000000
[0.000000] ESI: ef0bf000 EDI: 00000000 EBP: cf3bfe28 ESP: cf3bfda4
[0.000000] DS: 007b ES: 007b FS: 00d8 GS: 0033 SS: 0068 EFLAGS: 00210282
[0.000000] CR0: 80050033 CR2: b7344000 CR3: 0a47a320 CR4: 00352ef0
[0.000000] Call Trace:
[0.000000]  ? show_regs+0x70/0x78
[0.000000]  ? die+0x29/0x74
[0.000000]  ? exc_alignment_check+0x9e/0xa0
[0.000000]  ? exc_stack_segment+0x3c/0x3c
[0.000000]  ? handle_exception+0x14d/0x14d
[0.000000]  ? copy_page_range+0x26b/0xc8c
[0.000000]  ? exc_stack_segment+0x3c/0x3c
[0.000000]  ? __split_huge_pmd+0x468/0xa0c
[0.000000]  ? exc_stack_segment+0x3c/0x3c
[0.000000]  ? __split_huge_pmd+0x468/0xa0c
[0.000000]  vma_adjust_trans_huge+0xb8/0x160
[0.000000]  __split_vma+0x1f9/0x2e0
[0.000000]  do_vmi_align_munmap.isra.0+0x90/0x3ac
[0.000000]  do_vmi_munmap+0x69/0xa4
[0.000000]  __vm_munmap+0x6e/0xa8
[0.000000]  __ia32_sys_munmap+0x12/0x14
[0.000000]  __do_fast_syscall_32+0x5a/0xd8
[0.000000]  do_fast_syscall_32+0x29/0x5c
[0.000000]  do_SYSENTER_32+0x15/0x20
[0.000000]  entry_SYSENTER_32+0xa2/0x102
[0.000000] EIP: 0xb7eec569
[0.000000] Code: 03 74 c0 01 10 05 03 74 b8 01 10 06 03 74 b4 01 10 07 03 74 b0 01 10 08 03 74 d8 01 00 00 00 00 00 51 52 55 89 e5 0f 34 cd 80 <5d> 5a 59 c3 90 90 90 90 8d 76 00 58 b8 77 00 00 00 cd 80 90 8d 76
[0.000000] EAX: ffffffda EBX: b4e68000 ECX: 00198000 EDX: b4e68000
[0.000000] ESI: 00000000 EDI: b4ff8000 EBP: 00000002 ESP: bf91e23c
[0.000000] DS: 007b ES: 007b FS: 0000 GS: 0033 SS: 007b EFLAGS: 00200292
[0.000000] Modules linked in: kvm_intel kvm irqbypass
[0.000000] ---[ end trace 0000000000000000 ]---
[0.000000] EIP: __split_huge_pmd+0x468/0xa0c
[0.000000] Code: e0 0c 83 c8 67 89 55 bc 8b 55 d8 89 45 b8 8b 45 d4 8b 4d bc 89 55 b4 8b 55 b4 89 45 b0 8b 45 b8 89 7d b8 89 df 89 c3 8b 45 b0 <f0> 0f c7 4d d4 75 f9 8d 45 d4 89 fb 8b 7d b8 31 c9 89 fa e8 6c cf
[0.000000] EAX: c36797c0 EBX: b85cd067 ECX: 00000004 EDX: 00000000
[0.000000] ESI: ef0bf000 EDI: 00000000 EBP: cf3bfe28 ESP: cf3bfda4
[0.000000] DS: 007b ES: 007b FS: 00d8 GS: 0033 SS: 0068 EFLAGS: 00210282
[0.000000] CR0: 80050033 CR2: b7344000 CR3: 0a47a320 CR4: 00352ef0
[0.000000] note: a.out[1330] exited with irqs disabled

The offending process does not exit after this, although the issue
seems to be in kernel code. The problem is not perfectly reproducible,
but close enough: Most processes behave normally, but certain tasks
(a particular browser session, for instance) are prone to end up like
this more often than not.

I have done some analysis of the problem and the critical point seems
to be in __split_huge_pmd+0x468/0xa0c. Disassembly of this location
shows

    2c28:   f0 0f c7 4d d4  lock cmpxchg8b QWORD PTR [ebp-0x2c]
    2c2d:   75 f9           jne 2c28 <__split_huge_pmd+0x468>

On my kernel this code maps to __split_huge_pmd_locked in
mm/huge_memory.c, around line 2581

    pgtable = pgtable_trans_huge_withdraw(mm, pmd);
    pmd_populate(mm, &_pmd, pgtable);

where pmd_populate seems to ultimately call native_set_pmd in
arch/x86/include/asm/pgtable-3level.h, as I am running an x86-32 kernel
with PAE, and native_set_pmd relies on the macro

#define pxx_xchg64(_pxx, _ptr, _val) ({				\
	_pxx##val_t *_p = (_pxx##val_t *)_ptr;			\
	_pxx##val_t _o = *_p;					\
	do { } while (!try_cmpxchg64(_p, &_o, (_val)));		\
	native_make_##_pxx(_o);					\
})

where the busy loop translates into the assembly above. Now, as seen
from the assembly, variable _pmd is a qword that lies at ebp-0x2c,
and the trace shows that ebp is 0xcf3bfe28 at that point, which means
that the 8 bytes of _pmd cross a 512-byte alignment boundary, and this
is consistent with its being split across cache lines (if they are of
that size or less, which I do not know).

I have a few other logs like this one, and all of them are similar in
that all of them happen at __split_huge_pmd+0x468/0xa0c and in all of
them the value of ebp ends in 0xe28.

Since the issue seems to be that native_set_pmd tries to perform an
atomic compare-and-exchange operation on the location of its first
(pointer) argument, and since such an operation triggers an exception
if the target location spans two cache lines, I patched the kernel
to avoid that by raising the alignment of pmd_t to 8 bytes, and did the
same to pte_t and pud_t, for the same reason. I have been using the
proposed patch for a few days and the exceptions are gone.

Note that the patch also raises the alignment of p4dval_t, pgdval_t and
pgprotval_t, even though I do not see any immediate reason to do this,
because, well, my goal was to get the bug fixed and I thought that I
would rather overshoot first and fine-tune later. Any insight into
whether the extra alignment is required also for these types would be
appreciated.

Javier Pello (1):
  x86/mm/pae: Align up pteval_t, pmdval_t and pudval_t to avoid split locks

 arch/x86/include/asm/pgtable-3level_types.h | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

-- 
2.43.3

