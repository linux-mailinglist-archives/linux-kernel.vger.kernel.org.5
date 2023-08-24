Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAD58786B3D
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 11:12:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238933AbjHXJLi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 05:11:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240652AbjHXJLY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 05:11:24 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 793351995;
        Thu, 24 Aug 2023 02:11:17 -0700 (PDT)
Date:   Thu, 24 Aug 2023 09:11:15 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1692868276;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OIBq/MXL35PqjAeQT5yhbYhs75J3OcnCkErqRI+xPmM=;
        b=IOWdzYpQlExi06Dl87O055MR3RwZpPDAxny+SfkNyqTc1ZYhvmanfBu0SQGOZOgAFrqvy1
        a9Ui4CModLB70XlQVEphj6tBUV3ItOMx5SjYNEZqTO90nkjdJviVDWosFzn4Lw63g7vTmi
        7F135C4lhcVb+2sITNe2hcqLRerRWMYgKXLqGf3ZIr5vS+mJsgQ3S25Q37kn/Zy8tdCXsk
        AKm2xdLdMhahSYpbOqv/jqGmRJ8WvTjjwlrebYzcM0P12Nn4yCBbbCOPSBB0V0BfWQ2Ctk
        7pK/60vPfxwIIi4CEwepZXkCcnFMpwLAbxTXEvnsacnCevoNbmckRhUjkl4C1Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1692868276;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OIBq/MXL35PqjAeQT5yhbYhs75J3OcnCkErqRI+xPmM=;
        b=v6FL/K6KUrZEoA/1c3+g5j/ga5CxUrCLEnqj2VvsdNNj2FazmM6yNOvxjBE7C0kW3IKPQm
        M5icRjsyD4ikvSAA==
From:   "tip-bot2 for Rick Edgecombe" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/fpu: Invalidate FPU state correctly on exec()
Cc:     Lei Wang <lei4.wang@intel.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Lijun Pan <lijun.pan@intel.com>,
        Sohil Mehta <sohil.mehta@intel.com>, stable@vger.kernel.org,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20230818170305.502891-1-rick.p.edgecombe@intel.com>
References: <20230818170305.502891-1-rick.p.edgecombe@intel.com>
MIME-Version: 1.0
Message-ID: <169286827548.27769.3257744272966160176.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     1f69383b203e28cf8a4ca9570e572da1699f76cd
Gitweb:        https://git.kernel.org/tip/1f69383b203e28cf8a4ca9570e572da1699=
f76cd
Author:        Rick Edgecombe <rick.p.edgecombe@intel.com>
AuthorDate:    Fri, 18 Aug 2023 10:03:05 -07:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 24 Aug 2023 11:01:45 +02:00

x86/fpu: Invalidate FPU state correctly on exec()

The thread flag TIF_NEED_FPU_LOAD indicates that the FPU saved state is
valid and should be reloaded when returning to userspace. However, the
kernel will skip doing this if the FPU registers are already valid as
determined by fpregs_state_valid(). The logic embedded there considers
the state valid if two cases are both true:

  1: fpu_fpregs_owner_ctx points to the current tasks FPU state
  2: the last CPU the registers were live in was the current CPU.

This is usually correct logic. A CPU=E2=80=99s fpu_fpregs_owner_ctx is set to
the current FPU during the fpregs_restore_userregs() operation, so it
indicates that the registers have been restored on this CPU. But this
alone doesn=E2=80=99t preclude that the task hasn=E2=80=99t been rescheduled =
to a
different CPU, where the registers were modified, and then back to the
current CPU. To verify that this was not the case the logic relies on the
second condition. So the assumption is that if the registers have been
restored, AND they haven=E2=80=99t had the chance to be modified (by being
loaded on another CPU), then they MUST be valid on the current CPU.

Besides the lazy FPU optimizations, the other cases where the FPU
registers might not be valid are when the kernel modifies the FPU register
state or the FPU saved buffer. In this case the operation modifying the
FPU state needs to let the kernel know the correspondence has been
broken. The comment in =E2=80=9Carch/x86/kernel/fpu/context.h=E2=80=9D has:
/*
...
 * If the FPU register state is valid, the kernel can skip restoring the
 * FPU state from memory.
 *
 * Any code that clobbers the FPU registers or updates the in-memory
 * FPU state for a task MUST let the rest of the kernel know that the
 * FPU registers are no longer valid for this task.
 *
 * Either one of these invalidation functions is enough. Invalidate
 * a resource you control: CPU if using the CPU for something else
 * (with preemption disabled), FPU for the current task, or a task that
 * is prevented from running by the current task.
 */

However, this is not completely true. When the kernel modifies the
registers or saved FPU state, it can only rely on
__fpu_invalidate_fpregs_state(), which wipes the FPU=E2=80=99s last_cpu
tracking. The exec path instead relies on fpregs_deactivate(), which sets
the CPU=E2=80=99s FPU context to NULL. This was observed to fail to restore t=
he
reset FPU state to the registers when returning to userspace in the
following scenario:

1. A task is executing in userspace on CPU0
	- CPU0=E2=80=99s FPU context points to tasks
	- fpu->last_cpu=3DCPU0

2. The task exec()=E2=80=99s

3. While in the kernel the task is preempted
	- CPU0 gets a thread executing in the kernel (such that no other
		FPU context is activated)
	- Scheduler sets task=E2=80=99s fpu->last_cpu=3DCPU0 when scheduling out

4. Task is migrated to CPU1

5. Continuing the exec(), the task gets to
   fpu_flush_thread()->fpu_reset_fpregs()
	- Sets CPU1=E2=80=99s fpu context to NULL
	- Copies the init state to the task=E2=80=99s FPU buffer
	- Sets TIF_NEED_FPU_LOAD on the task

6. The task reschedules back to CPU0 before completing the exec() and
   returning to userspace
	- During the reschedule, scheduler finds TIF_NEED_FPU_LOAD is set
	- Skips saving the registers and updating task=E2=80=99s fpu=E2=86=92last_cp=
u,
	  because TIF_NEED_FPU_LOAD is the canonical source.

7. Now CPU0=E2=80=99s FPU context is still pointing to the task=E2=80=99s, and
   fpu->last_cpu is still CPU0. So fpregs_state_valid() returns true even
   though the reset FPU state has not been restored.

So the root cause is that exec() is doing the wrong kind of invalidate. It
should reset fpu->last_cpu via __fpu_invalidate_fpregs_state(). Further,
fpu__drop() doesn't really seem appropriate as the task (and FPU) are not
going away, they are just getting reset as part of an exec. So switch to
__fpu_invalidate_fpregs_state().

Also, delete the misleading comment that says that either kind of
invalidate will be enough, because it=E2=80=99s not always the case.

Fixes: 33344368cb08 ("x86/fpu: Clean up the fpu__clear() variants")
Reported-by: Lei Wang <lei4.wang@intel.com>
Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Lijun Pan <lijun.pan@intel.com>
Reviewed-by: Sohil Mehta <sohil.mehta@intel.com>
Acked-by: Lijun Pan <lijun.pan@intel.com>
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/r/20230818170305.502891-1-rick.p.edgecombe@inte=
l.com

---
 arch/x86/kernel/fpu/context.h | 3 +--
 arch/x86/kernel/fpu/core.c    | 2 +-
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/fpu/context.h b/arch/x86/kernel/fpu/context.h
index af5cbdd..f6d856b 100644
--- a/arch/x86/kernel/fpu/context.h
+++ b/arch/x86/kernel/fpu/context.h
@@ -19,8 +19,7 @@
  * FPU state for a task MUST let the rest of the kernel know that the
  * FPU registers are no longer valid for this task.
  *
- * Either one of these invalidation functions is enough. Invalidate
- * a resource you control: CPU if using the CPU for something else
+ * Invalidate a resource you control: CPU if using the CPU for something else
  * (with preemption disabled), FPU for the current task, or a task that
  * is prevented from running by the current task.
  */
diff --git a/arch/x86/kernel/fpu/core.c b/arch/x86/kernel/fpu/core.c
index 1015af1..98e507c 100644
--- a/arch/x86/kernel/fpu/core.c
+++ b/arch/x86/kernel/fpu/core.c
@@ -679,7 +679,7 @@ static void fpu_reset_fpregs(void)
 	struct fpu *fpu =3D &current->thread.fpu;
=20
 	fpregs_lock();
-	fpu__drop(fpu);
+	__fpu_invalidate_fpregs_state(fpu);
 	/*
 	 * This does not change the actual hardware registers. It just
 	 * resets the memory image and sets TIF_NEED_FPU_LOAD so a
