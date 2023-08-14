Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AC3677B520
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 11:08:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235430AbjHNJHl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 05:07:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235345AbjHNJHG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 05:07:06 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2B0B10F;
        Mon, 14 Aug 2023 02:07:05 -0700 (PDT)
Date:   Mon, 14 Aug 2023 09:07:03 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1692004024;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wetadB97bIqAsdJEg4W3RZMOv6KS2WmfR8lmdg07hhI=;
        b=j5WcKhicADTjPKScxe2225FSF/tYOrL9dNz/9Zy/7FPQlEnkdTgdKaJYD+eGgaXOCbqOjP
        wg8m7dEYDpzH8AyRocY4tDytzX4w3t+COI3JxKGN5s5orQJPnEZcIlQh/7ue2pkn2Lr7DX
        qCPNMAhE87cTNcsqeIv1ZXK7VTVxZHpePWkV0dZQaJzM+epf0cuh5UKM90GIIQynNuNdtl
        Safdpa+RvpOovIHLcViAqN9QVE5yweM2VNEjcMSMVDO2RnFq7OCSEY4VMMZKmUCViQlaAL
        7hCyhJFwKjOpzC+w0cq5PnPVniTwNi06Fqw9P67eZfl8QumGye/+wNGaVIf1Ww==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1692004024;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wetadB97bIqAsdJEg4W3RZMOv6KS2WmfR8lmdg07hhI=;
        b=t1JsRtyOs8nnLOrUtRxAmW1LoiDD6I3/dxdE2XAzhXqPv4F75ZEmWcir83KHCipbcKVi9a
        k+AAhUcVjeLch4BQ==
From:   "tip-bot2 for Sean Christopherson" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/retpoline: Don't clobber RFLAGS during srso_safe_ret()
Cc:     Srikanth Aithal <sraithal@amd.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Sean Christopherson <seanjc@google.com>,
        "Borislav Petkov (AMD)" <bp@alien8.de>, stable@vger.kernel.org,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20230811155255.250835-1-seanjc@google.com>
References: <20230811155255.250835-1-seanjc@google.com>
MIME-Version: 1.0
Message-ID: <169200402376.27769.4513228712223783276.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     ba5ca5e5e6a1d55923e88b4a83da452166f5560e
Gitweb:        https://git.kernel.org/tip/ba5ca5e5e6a1d55923e88b4a83da452166f5560e
Author:        Sean Christopherson <seanjc@google.com>
AuthorDate:    Fri, 11 Aug 2023 08:52:55 -07:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Mon, 14 Aug 2023 10:47:55 +02:00

x86/retpoline: Don't clobber RFLAGS during srso_safe_ret()

Use LEA instead of ADD when adjusting %rsp in srso_safe_ret{,_alias}()
so as to avoid clobbering flags.  Drop one of the INT3 instructions to
account for the LEA consuming one more byte than the ADD.

KVM's emulator makes indirect calls into a jump table of sorts, where
the destination of each call is a small blob of code that performs fast
emulation by executing the target instruction with fixed operands.

E.g. to emulate ADC, fastop() invokes adcb_al_dl():

  adcb_al_dl:
    <+0>:  adc    %dl,%al
    <+2>:  jmp    <__x86_return_thunk>

A major motivation for doing fast emulation is to leverage the CPU to
handle consumption and manipulation of arithmetic flags, i.e. RFLAGS is
both an input and output to the target of the call.  fastop() collects
the RFLAGS result by pushing RFLAGS onto the stack and popping them back
into a variable (held in %rdi in this case):

  asm("push %[flags]; popf; " CALL_NOSPEC " ; pushf; pop %[flags]\n"

  <+71>: mov    0xc0(%r8),%rdx
  <+78>: mov    0x100(%r8),%rcx
  <+85>: push   %rdi
  <+86>: popf
  <+87>: call   *%rsi
  <+89>: nop
  <+90>: nop
  <+91>: nop
  <+92>: pushf
  <+93>: pop    %rdi

and then propagating the arithmetic flags into the vCPU's emulator state:

  ctxt->eflags = (ctxt->eflags & ~EFLAGS_MASK) | (flags & EFLAGS_MASK);

  <+64>:  and    $0xfffffffffffff72a,%r9
  <+94>:  and    $0x8d5,%edi
  <+109>: or     %rdi,%r9
  <+122>: mov    %r9,0x10(%r8)

The failures can be most easily reproduced by running the "emulator"
test in KVM-Unit-Tests.

If you're feeling a bit of deja vu, see commit b63f20a778c8
("x86/retpoline: Don't clobber RFLAGS during CALL_NOSPEC on i386").

In addition, this breaks booting of clang-compiled guest on
a gcc-compiled host where the host contains the %rsp-modifying SRSO
mitigations.

  [ bp: Massage commit message, extend, remove addresses. ]

Fixes: fb3bd914b3ec ("x86/srso: Add a Speculative RAS Overflow mitigation")
Closes: https://lore.kernel.org/all/de474347-122d-54cd-eabf-9dcc95ab9eae@amd.com
Reported-by: Srikanth Aithal <sraithal@amd.com>
Reported-by: Nathan Chancellor <nathan@kernel.org>
Signed-off-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Tested-by: Nathan Chancellor <nathan@kernel.org>
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/20230810013334.GA5354@dev-arch.thelio-3990X/
Link: https://lore.kernel.org/r/20230811155255.250835-1-seanjc@google.com
---
 arch/x86/lib/retpoline.S | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/arch/x86/lib/retpoline.S b/arch/x86/lib/retpoline.S
index 2cff585..132cedb 100644
--- a/arch/x86/lib/retpoline.S
+++ b/arch/x86/lib/retpoline.S
@@ -164,7 +164,7 @@ __EXPORT_THUNK(srso_untrain_ret_alias)
 /* Needs a definition for the __x86_return_thunk alternative below. */
 SYM_START(srso_safe_ret_alias, SYM_L_GLOBAL, SYM_A_NONE)
 #ifdef CONFIG_CPU_SRSO
-	add $8, %_ASM_SP
+	lea 8(%_ASM_SP), %_ASM_SP
 	UNWIND_HINT_FUNC
 #endif
 	ANNOTATE_UNRET_SAFE
@@ -239,7 +239,7 @@ __EXPORT_THUNK(zen_untrain_ret)
  * SRSO untraining sequence for Zen1/2, similar to zen_untrain_ret()
  * above. On kernel entry, srso_untrain_ret() is executed which is a
  *
- * movabs $0xccccccc308c48348,%rax
+ * movabs $0xccccc30824648d48,%rax
  *
  * and when the return thunk executes the inner label srso_safe_ret()
  * later, it is a stack manipulation and a RET which is mispredicted and
@@ -252,11 +252,10 @@ SYM_START(srso_untrain_ret, SYM_L_GLOBAL, SYM_A_NONE)
 	.byte 0x48, 0xb8
 
 SYM_INNER_LABEL(srso_safe_ret, SYM_L_GLOBAL)
-	add $8, %_ASM_SP
+	lea 8(%_ASM_SP), %_ASM_SP
 	ret
 	int3
 	int3
-	int3
 	lfence
 	call srso_safe_ret
 	int3
