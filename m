Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66DBB781130
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 19:04:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378885AbjHRREL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 13:04:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378895AbjHRREI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 13:04:08 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3602D10C0
        for <linux-kernel@vger.kernel.org>; Fri, 18 Aug 2023 10:04:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692378247; x=1723914247;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=G9burYxqaVnGFyp4GdyW8NlixVYBwXMzhY3L7iyY7jc=;
  b=eiePXzRL85bkQVZf+tltRepWQpStThrS8cW7FL3YDA+2klli8B59G2sV
   yAUU/KWSjcSXYVotSy0gbNwna5oMXKZHmE6V6gfeWEL0iplE6SGX3BEgn
   Qb8SwdW/ijm5Cexb35/E7PIENmPzMgdTvbJukUKPttLrJ/ouczEruOya+
   /xznWazyO8leBhzP0eNyOE/a/jGaY3sfJHAhW9UN82TFiexVEV7pWCVmq
   xfuQlE39Sz5pYuI0NmK+nTaHzlAEPQFlNe9Oge1u+oup60BmHljZhh2pW
   cA/ai+GiGEMNRErngRWu3O3kPss7oLHL/2lR48S9ytnDc3WDbDoLcCtkP
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10806"; a="437057583"
X-IronPort-AV: E=Sophos;i="6.01,183,1684825200"; 
   d="scan'208";a="437057583"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2023 10:04:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10806"; a="728673351"
X-IronPort-AV: E=Sophos;i="6.01,183,1684825200"; 
   d="scan'208";a="728673351"
Received: from sbidasar-mobl.amr.corp.intel.com (HELO rpedgeco-desk4.intel.com) ([10.209.36.254])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2023 10:04:06 -0700
From:   Rick Edgecombe <rick.p.edgecombe@intel.com>
To:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org,
        hpa@zytor.com, dave.hansen@linux.intel.com, luto@kernel.org,
        peterz@infradead.org
Cc:     linux-kernel@vger.kernel.org,
        Rick Edgecombe <rick.p.edgecombe@intel.com>
Subject: [PATCH] x86: Use __fpu_invalidate_fpregs_state() in exec
Date:   Fri, 18 Aug 2023 10:03:05 -0700
Message-Id: <20230818170305.502891-1-rick.p.edgecombe@intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The thread flag TIF_NEED_FPU_LOAD indicates that the FPU saved state is
valid and should be reloaded when returning to userspace. However, the
kernel will skip doing this if the FPU registers are already valid as
determined by fpregs_state_valid(). The logic embedded there considers
the state valid if two cases are both true:
  1: fpu_fpregs_owner_ctx points to the current tasks FPU state
  2: the last CPU the registers were live in was the current CPU.

This is usually correct logic. A CPU’s fpu_fpregs_owner_ctx is set to
the current FPU during the fpregs_restore_userregs() operation, so it
indicates that the registers have been restored on this CPU. But this
alone doesn’t preclude that the task hasn’t been rescheduled to a
different CPU, where the registers were modified, and then back to the
current CPU. To verify that this was not the case the logic relies on the
second condition. So the assumption is that if the registers have been
restored, AND they haven’t had the chance to be modified (by being
loaded on another CPU), then they MUST be valid on the current CPU.

Besides the lazy FPU optimizations, the other cases where the FPU
registers might not be valid are when the kernel modifies the FPU register
state or the FPU saved buffer. In this case the operation modifying the
FPU state needs to let the kernel know the correspondence has been
broken. The comment in “arch/x86/kernel/fpu/context.h” has:
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
__fpu_invalidate_fpregs_state(), which wipes the FPU’s last_cpu
tracking. The exec path instead relies on fpregs_deactivate(), which sets
the CPU’s FPU context to NULL. This was observed to fail to restore the
reset FPU state to the registers when returning to userspace in the
following scenario:

1. A task is executing in userspace on CPU0
	- CPU0’s FPU context points to tasks
	- fpu->last_cpu=CPU0
2. The task exec()’s
3. While in the kernel the task reschedules to CPU1
	- CPU0 gets a thread executing in the kernel (such that no other
		FPU context is activated)
	- Scheduler sets task’s fpu->last_cpu=CPU0
4. Continuing the exec, the task gets to
   fpu_flush_thread()->fpu_reset_fpregs()
	- Sets CPU1’s fpu context to NULL
	- Copies the init state to the task’s FPU buffer
	- Sets TIF_NEED_FPU_LOAD on the task
5. The task reschedules back to CPU0 before completing the exec and
	returning to userspace
	- During the reschedule, scheduler finds TIF_NEED_FPU_LOAD is set
	- Skips saving the registers and updating task’s fpu→last_cpu,
		because TIF_NEED_FPU_LOAD is the canonical source.
6. Now CPU0’s FPU context is still pointing to the task’s, and
   fpu->last_cpu is still CPU0. So fpregs_state_valid() returns true even
   though the reset FPU state has not been restored.

So the root cause is that exec() is doing the wrong kind of invalidate. It
should reset fpu->last_cpu via __fpu_invalidate_fpregs_state(). Further,
fpu__drop() doesn't really seem appropriate as the task (and FPU) are not
going away, they are just getting reset as part of an exec. So switch to
__fpu_invalidate_fpregs_state().

Also, delete the misleading comment that says that either kind of
invalidate will be enough, because it’s not always the case.

Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>

---
Hi,

This was spotted on a specific pre-production setup running an
out-of-tree glibc and the x86/shstk tip branch. The symptom observed
was a shadow stack segfault in ld-linux. The test case was a kernel
build with a high number of threads and it was able to generate the
segfault relatively reliably.

I was surprised to find that the root cause was not related to supervisor
xsave and instead seems to be a general FPU bug where the FPU state will
not be reset during exec if rescheduling happens twice in certain points
during the operation. It seems to be so old that I had a hard time
figuring which commit to blame.

A guess at how this was able to lurk so long is the combination of two
factors. One is that this specific test environment and workload seemed
to like to generate this specific pattern of scheduling for some reason.
So the fact it was reliably reproduced there could be not be indicative of
the typical case. The other factor is that CET features will rather loudly
alert to any corrupted FPU state due to the enforcement nature of that
state. So maybe this FPU reset miss during exec happened less commonly in
the wild, but most existing apps can survive it silently.

But since it's still a bit surprising, I would appreciate some extra
scrutiny on the reasoning. I verified the FPU state was not getting reset
during exec’s that experienced rescheduling to another CPU and back at
times as described in the commit log. Then following the logic in the
code, failing to restore the FPU would be expected. And fixing that logic
fixed the observed issue. But still surprised this wasn't seen before now.

Thanks,
Rick
---
 arch/x86/kernel/fpu/context.h | 3 +--
 arch/x86/kernel/fpu/core.c    | 2 +-
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/fpu/context.h b/arch/x86/kernel/fpu/context.h
index af5cbdd9bd29..f6d856bd50bc 100644
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
index e03b6b107b20..a86d37052a64 100644
--- a/arch/x86/kernel/fpu/core.c
+++ b/arch/x86/kernel/fpu/core.c
@@ -713,7 +713,7 @@ static void fpu_reset_fpregs(void)
 	struct fpu *fpu = &current->thread.fpu;
 
 	fpregs_lock();
-	fpu__drop(fpu);
+	__fpu_invalidate_fpregs_state(fpu);
 	/*
 	 * This does not change the actual hardware registers. It just
 	 * resets the memory image and sets TIF_NEED_FPU_LOAD so a
-- 
2.34.1

