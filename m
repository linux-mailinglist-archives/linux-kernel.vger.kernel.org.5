Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EC5D799115
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 22:38:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344549AbjIHUir (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 16:38:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241303AbjIHUip (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 16:38:45 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6C7ECD6
        for <linux-kernel@vger.kernel.org>; Fri,  8 Sep 2023 13:38:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694205502; x=1725741502;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=qITvL8k5xRkrCVLF4OPNwjcjAY5mrhXmGAsL4D1jNcA=;
  b=ZzYwioYG0h6bCJfA8jU3HYwc4PgasdqGju0vptujg4tmwNh5prLcbu50
   VXpdVw3KzEqEHtoSGtPUr6M3eRjrbQCaXIptQAELnCWXngn2ZHFEIyqli
   8/1bmE7NXTRDGrhEuCKchNrpQmYhCjcs17+AcYKt//Ur6P6LDIsNVBCkM
   7yZTmGgmVprKgolj0Ke3T/aTy5oI3mEw3506DBNaDxPfI5oqor3LHdd1+
   HtYnehdXmcj/unzyIqpp+N/UVFaL3k6wiG0vHaT0VK2w0T4VZRkK7HqJQ
   YwWLaSWAIATRBFJnjJXIHTFkMsOGPkfsmxWpp00yvvRQvVzK+fnuAn8Lp
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10827"; a="376650582"
X-IronPort-AV: E=Sophos;i="6.02,237,1688454000"; 
   d="scan'208";a="376650582"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2023 13:37:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10827"; a="832781667"
X-IronPort-AV: E=Sophos;i="6.02,237,1688454000"; 
   d="scan'208";a="832781667"
Received: from imilose-mobl.amr.corp.intel.com (HELO rpedgeco-desk4.intel.com) ([10.209.14.33])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2023 13:37:19 -0700
From:   Rick Edgecombe <rick.p.edgecombe@intel.com>
To:     x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Andy Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>, hjl.tools@gmail.com,
        linux-kernel@vger.kernel.org
Cc:     rick.p.edgecombe@intel.com
Subject: [PATCH 1/3] x86/shstk: Handle vfork clone failure correctly
Date:   Fri,  8 Sep 2023 13:36:53 -0700
Message-Id: <20230908203655.543765-2-rick.p.edgecombe@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230908203655.543765-1-rick.p.edgecombe@intel.com>
References: <20230908203655.543765-1-rick.p.edgecombe@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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

Reported-by: H.J. Lu <hjl.tools@gmail.com>
Tested-by: H.J. Lu <hjl.tools@gmail.com>
Fixes: b2926a36b97a ("x86/shstk: Handle thread shadow stack")
Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
---
 arch/x86/include/asm/mmu_context.h |  3 +--
 arch/x86/kernel/shstk.c            | 22 ++++++++++++++++++++--
 2 files changed, 21 insertions(+), 4 deletions(-)

diff --git a/arch/x86/include/asm/mmu_context.h b/arch/x86/include/asm/mmu_context.h
index 416901d406f8..8dac45a2c7fc 100644
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
index fd689921a1db..ad63252ebebc 100644
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
 
-- 
2.34.1

