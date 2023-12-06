Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30C12806411
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 02:26:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230246AbjLFBWW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 20:22:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229617AbjLFBWU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 20:22:20 -0500
Received: from mailtransmit04.runbox.com (mailtransmit04.runbox.com [IPv6:2a0c:5a00:149::25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D68B1AA
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 17:22:26 -0800 (PST)
Received: from mailtransmit02.runbox ([10.9.9.162] helo=aibo.runbox.com)
        by mailtransmit04.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <mhal@rbox.co>)
        id 1rAg80-0004wL-9t; Wed, 06 Dec 2023 01:51:04 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
        s=selector2; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject
        :Cc:To:From; bh=Eh4a50UJw1U24Jhx2ZLm8s+KtiKgydFK1QvQUJGwRr0=; b=fUM5tCE1R2xY7
        UiLvuF9da7qe6p3oxO7b+ZVy3a425Kb+1QhiIvskQDJl4msFhfQYwH1BY4z+BpSqwxUKH+MCz0bBb
        gM7R4+K1ZfUWgBaBVNMIdEzhOxyz/nhjCShS4bdeOy43oyUHIG5a1m8NaGTjgytZURxgC7rgfIHhq
        z2T3upqrR/+lQ7EM+a/Yj14HHWVfqQKeEgOaBpPBOli+2C7v+v9Jt9Lwf3azuQ/MmqAFYoE7yHyGj
        F904t7BL/AYGMI1CtTQP10eI02xtBKhi2/e7erw1tbbC1DU8bHO//4AYIjR0clJVvcKM5kZn+obZb
        5FVtLm09Yh8lmxAeSM9TQ==;
Received: from [10.9.9.74] (helo=submission03.runbox)
        by mailtransmit02.runbox with esmtp (Exim 4.86_2)
        (envelope-from <mhal@rbox.co>)
        id 1rAg7z-0001zn-Sz; Wed, 06 Dec 2023 01:51:04 +0100
Received: by submission03.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.93)
        id 1rAg7j-00CFCn-FV; Wed, 06 Dec 2023 01:50:47 +0100
From:   Michal Luczaj <mhal@rbox.co>
To:     x86@kernel.org
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, shuah@kernel.org, luto@kernel.org,
        torvalds@linuxfoundation.org, linux-kernel@vger.kernel.org,
        Michal Luczaj <mhal@rbox.co>
Subject: [PATCH 0/2] x86: UMIP emulation leaking kernel addresses
Date:   Wed,  6 Dec 2023 01:43:43 +0100
Message-ID: <20231206004654.2986026-1-mhal@rbox.co>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

User space executing opcode SGDT on a UMIP-enabled CPU results in
#GP(0). In an effort to support legacy applications, #GP handler calls
fixup_umip_exception() to patch up the exception and return a dummy
value:

	if (static_cpu_has(X86_FEATURE_UMIP)) {
		if (user_mode(regs) && fixup_umip_exception(regs))
			goto exit;
	}

SGDT is emulated by decoding the instruction and copying dummy data to
the memory address specified by the operand:

	uaddr = insn_get_addr_ref(&insn, regs);
	if ((unsigned long)uaddr == -1L)
		return false;

	nr_copied = copy_to_user(uaddr, dummy_data, dummy_data_size);
	if (nr_copied  > 0) {
		/*
		 * If copy fails, send a signal and tell caller that
		 * fault was fixed up.
		 */
		force_sig_info_umip_fault(uaddr, regs);
		return true;
	}

Decoder handles segmentation, so for "sgdt %ss:(%rax)" the value of
`uaddr` will be correctly (in compatibility mode) shifted by the base
address of the segment. There's a catch though: decoder does not check
segment's DPL, nor its type.

ptrace() can be used to prepare a RPL=3 selector for a S=0/DPL=0
segment, potentially one with a kernel space base address. On return to
user space, CPU will reject such selector load; exception will be
raised. But because the #GP handler sees no distinction between
SGDT-induced #GP(0) and IRET-induced #GP(selector), emulator will kick
in and process the malformed @regs->ss.

If the first 4 GiB of user space are unmapped or non-writable,
copy_to_user() will fail, and signal to user will reveal `uaddr` -- i.e.
the (part of) kernel address. On x86_64, addresses of GDT_ENTRY_TSS (for
each CPU) and GDT_ENTRY_LDT (when in use) can be fully leaked in a few
steps.

Introducing a DPL check in insn_get_seg_base(), or even in get_desc(),
seems enough to prevent the decoder from disclosing data.

diff --git a/arch/x86/lib/insn-eval.c b/arch/x86/lib/insn-eval.c
index 558a605929db..4c1eea736519 100644
--- a/arch/x86/lib/insn-eval.c
+++ b/arch/x86/lib/insn-eval.c
@@ -725,6 +725,18 @@ unsigned long insn_get_seg_base(struct pt_regs *regs, int seg_reg_idx)
 	if (!get_desc(&desc, sel))
 		return -1L;
 
+	/*
+	 * Some segment selectors coming from @regs do not necessarily reflect
+	 * the state of CPU; see get_segment_selector(). Their values might
+	 * have been altered by ptrace. Thus, the instruction decoder can be
+	 * tricked into "dereferencing" a segment descriptor that would
+	 * otherwise cause a CPU exception -- for example due to mismatched
+	 * privilege levels. This opens up the possibility to expose kernel
+	 * space base address of DPL=0 segments.
+	 */
+	if (desc.dpl < (regs->cs & SEGMENT_RPL_MASK))
+		return -1L;
+
 	return get_desc_base(&desc);
 }
 
That said, I guess instead of trying to harden the decoder, it would be
better to ensure any emulation is attempted only when @regs do for sure
reflect the state of CPU. I.e. when #GP comes directly from the user
space, not via a bad IRET.

In other words, can the context be somehow tainted during bad IRET
handling -- signalling to the #GP handler that emulation should be
avoided?

Now, I'm far from being competent, but here's an idea I've tried: tell
the #GP handler that UMIP-related exceptions come only as #GP(0):

 	if (static_cpu_has(X86_FEATURE_UMIP)) {
-		if (user_mode(regs) && fixup_umip_exception(regs))
+		if (user_mode(regs) && !error_code && fixup_umip_exception(regs))
 			goto exit;
 	}

To my understanding of Intel SDM, a bad IRET can theoretically cause a
#GP(0), too. So for that occasion, would it be okay to "poison" the
value of error code in fixup_bad_iret()? Along the lines of:

 	/* Copy the remainder of the stack from the current stack. */
 	__memcpy(&tmp, bad_regs, offsetof(struct pt_regs, ip));
 
+	/* Suppress the error code. */
+	tmp.orig_ax = -1UL;
+
 	/* Update the entry stack */
 	__memcpy(new_stack, &tmp, sizeof(tmp));

Admittedly, this feels hackish. And I've realized there's also the case
of ESPFIX: #DF handler explicitly sets up a #GP(0) frame before
forwarding the execution to the #GP handler.

Thanks,
Michal

Michal Luczaj (2):
  x86/traps: Attempt UMIP fixup only on #GP(0)
  selftests/x86: UMIP DPL=0 segment base address info leak test

 arch/x86/kernel/traps.c                     |   2 +-
 tools/testing/selftests/x86/Makefile        |   6 +-
 tools/testing/selftests/x86/umip_leak_seg.c | 249 ++++++++++++++++++++
 3 files changed, 255 insertions(+), 2 deletions(-)
 create mode 100644 tools/testing/selftests/x86/umip_leak_seg.c

-- 
2.43.0

