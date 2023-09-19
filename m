Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7CA47A6935
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 18:53:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231894AbjISQxH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 12:53:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231208AbjISQxC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 12:53:02 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8418D7;
        Tue, 19 Sep 2023 09:52:55 -0700 (PDT)
Date:   Tue, 19 Sep 2023 16:52:53 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1695142374;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=m+AZzA3esFSruRGBDJpj3n7WdACPkg/+kQPdyo3yLWI=;
        b=hqrGCukhgfLloI0rpevc7zVN+rM37ZcJeIZOH3Di5JH+HzjnbmMtBKBUtG8MT/BM+F/in8
        GyhlyTArBUXiwI8rJUg2gKSAtVSvZFxRnD+BiR8tiqK1MlPiUcOuhPYB3CD1obi4Lwbp7V
        84b8DEDQpAYOG1+uwTRKvgG4sx8LkOvNkVOdQjOeJHphD7MXpqaIXt+E3rBrZiZm3B7BwL
        ziH8g+BRq+9eVfJ2yPzwnszGGMdZlk7rq2qdHDUDZuxZsmFGeQuApZzc2rIRYpd0hq1Mq6
        6ZzI0Bn8sqTV8obEoTD89f/h6R9jF6bnDfjyy3ZuBx1ZiNBTDTcO2nosFQn+7Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1695142374;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=m+AZzA3esFSruRGBDJpj3n7WdACPkg/+kQPdyo3yLWI=;
        b=r+FA/KNtvo18Tzra1Jq2Ar1ck9hpe65Dnku8RZXoYF7i9mewzMdF/7Md3UayQ3+BKT5Olo
        7vKYKN+HGHGNoKAA==
From:   "tip-bot2 for Rick Edgecombe" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/shstk: Handle vfork clone failure correctly
Cc:     "H.J. Lu" <hjl.tools@gmail.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <169514237375.27769.13557625283763910359.tip-bot2@tip-bot2>
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

Commit-ID:     331955600ddf55a2c6d92a00f95b0865f1c74fc3
Gitweb:        https://git.kernel.org/tip/331955600ddf55a2c6d92a00f95b0865f1c74fc3
Author:        Rick Edgecombe <rick.p.edgecombe@intel.com>
AuthorDate:    Fri, 08 Sep 2023 13:36:53 -07:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Tue, 19 Sep 2023 09:18:34 -07:00

x86/shstk: Handle vfork clone failure correctly

Shadow stacks are allocated automatically and freed on exit, depending
on the clone flags. The two cases where new shadow stacks are not
allocated are !CLONE_VM (fork()) and CLONE_VFORK (vfork()). For
!CLONE_VM, although a new stack is not allocated, it can be freed normally
because it will happen in the child's copy of the VM.

However, for CLONE_VFORK the parent and the child are actually using the
same shadow stack. So the kernel doesn't need to allocate *or* free a
shadow stack for a CLONE_VFORK child. CLONE_VFORK children already need
special tracking to avoid returning to userspace until the child exits or
execs. Shadow stack uses this same tracking to avoid freeing CLONE_VFORK
shadow stacks.

However, the tracking is not setup until the clone has succeeded
(internally). Which means, if a CLONE_VFORK fails, the existing logic will
not know it is a CLONE_VFORK and proceed to unmap the parents shadow stack.
This error handling cleanup logic runs via exit_thread() in the
bad_fork_cleanup_thread label in copy_process(). The issue was seen in
the glibc test "posix/tst-spawn3-pidfd" while running with shadow stack
using currently out-of-tree glibc patches.

Fix it by not unmapping the vfork shadow stack in the error case as well.
Since clone is implemented in core code, it is not ideal to pass the clone
flags along the error path in order to have shadow stack code have
symmetric logic in the freeing half of the thread shadow stack handling.

Instead use the existing state for thread shadow stacks to track whether
the thread is managing its own shadow stack. For CLONE_VFORK, simply set
shstk->base and shstk->size to 0, and have it mean the thread is not
managing a shadow stack and so should skip cleanup work. Implement this
by breaking up the CLONE_VFORK and !CLONE_VM cases in
shstk_alloc_thread_stack() to separate conditionals since, the logic is
now different between them. In the case of CLONE_VFORK && !CLONE_VM, the
existing behavior is to not clean up the shadow stack in the child (which
should go away quickly with either be exit or exec), so maintain that
behavior by handling the CLONE_VFORK case first in the allocation path.

This new logioc cleanly handles the case of normal, successful
CLONE_VFORK's skipping cleaning up their shadow stack's on exit as well.
So remove the existing, vfork shadow stack freeing logic. This is in
deactivate_mm() where vfork_done is used to tell if it is a vfork child
that can skip cleaning up the thread shadow stack.

Fixes: b2926a36b97a ("x86/shstk: Handle thread shadow stack")
Reported-by: H.J. Lu <hjl.tools@gmail.com>
Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Tested-by: H.J. Lu <hjl.tools@gmail.com>
Link: https://lore.kernel.org/all/20230908203655.543765-2-rick.p.edgecombe%40intel.com
---
 arch/x86/include/asm/mmu_context.h |  3 +--
 arch/x86/kernel/shstk.c            | 22 ++++++++++++++++++++--
 2 files changed, 21 insertions(+), 4 deletions(-)

diff --git a/arch/x86/include/asm/mmu_context.h b/arch/x86/include/asm/mmu_context.h
index 416901d..8dac45a 100644
--- a/arch/x86/include/asm/mmu_context.h
+++ b/arch/x86/include/asm/mmu_context.h
@@ -186,8 +186,7 @@ do {						\
 #else
 #define deactivate_mm(tsk, mm)			\
 do {						\
-	if (!tsk->vfork_done)			\
-		shstk_free(tsk);		\
+	shstk_free(tsk);			\
 	load_gs_index(0);			\
 	loadsegment(fs, 0);			\
 } while (0)
diff --git a/arch/x86/kernel/shstk.c b/arch/x86/kernel/shstk.c
index fd68992..ad63252 100644
--- a/arch/x86/kernel/shstk.c
+++ b/arch/x86/kernel/shstk.c
@@ -205,10 +205,21 @@ unsigned long shstk_alloc_thread_stack(struct task_struct *tsk, unsigned long cl
 		return 0;
 
 	/*
-	 * For CLONE_VM, except vfork, the child needs a separate shadow
+	 * For CLONE_VFORK the child will share the parents shadow stack.
+	 * Make sure to clear the internal tracking of the thread shadow
+	 * stack so the freeing logic run for child knows to leave it alone.
+	 */
+	if (clone_flags & CLONE_VFORK) {
+		shstk->base = 0;
+		shstk->size = 0;
+		return 0;
+	}
+
+	/*
+	 * For !CLONE_VM the child will use a copy of the parents shadow
 	 * stack.
 	 */
-	if ((clone_flags & (CLONE_VFORK | CLONE_VM)) != CLONE_VM)
+	if (!(clone_flags & CLONE_VM))
 		return 0;
 
 	size = adjust_shstk_size(stack_size);
@@ -408,6 +419,13 @@ void shstk_free(struct task_struct *tsk)
 	if (!tsk->mm || tsk->mm != current->mm)
 		return;
 
+	/*
+	 * If shstk->base is NULL, then this task is not managing its
+	 * own shadow stack (CLONE_VFORK). So skip freeing it.
+	 */
+	if (!shstk->base)
+		return;
+
 	unmap_shadow_stack(shstk->base, shstk->size);
 }
 
