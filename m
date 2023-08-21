Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4411782E77
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 18:35:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236254AbjHUQfe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 12:35:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231682AbjHUQfd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 12:35:33 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 849DA91
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 09:35:31 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 368572F4;
        Mon, 21 Aug 2023 09:36:12 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 7041D3F64C;
        Mon, 21 Aug 2023 09:35:30 -0700 (PDT)
From:   Mark Rutland <mark.rutland@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     luto@kernel.org, mark.rutland@arm.com, peterz@infradead.org,
        tglx@linutronix.de
Subject: [PATCH] entry: remove empty addr_limit_user_check()
Date:   Mon, 21 Aug 2023 17:35:26 +0100
Message-Id: <20230821163526.2319443-1-mark.rutland@arm.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Back when set_fs() was a generic API for altering the address limit,
addr_limit_user_check() was a safety measure to prevent userspace being
able to issue syscalls with an unbound limit.

With the the removal of set_fs() as a generic API, the last user of
addr_limit_user_check() was removed in commit:

  b5a5a01d8e9a44ec ("arm64: uaccess: remove addr_limit_user_check()")

... as since that commit, no architecture defines TIF_FSCHECK, and hence
addr_limit_user_check() always expands to nothing.

Remove addr_limit_user_check(), updating the comment in
exit_to_user_mode_prepare() to no longer refer to it. At the same time,
the comment is reworded to be a little more generic so as to cover
kmap_assert_nomap() in addition to lockdep_sys_exit().

There should be no functional change as a result of this patch.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-kernel@vger.kernel.org
---
 include/linux/syscalls.h | 16 ----------------
 kernel/entry/common.c    |  3 +--
 2 files changed, 1 insertion(+), 18 deletions(-)

diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
index 03e3d0121d5e3..c4b9b66b0d053 100644
--- a/include/linux/syscalls.h
+++ b/include/linux/syscalls.h
@@ -283,22 +283,6 @@ static inline int is_syscall_trace_event(struct trace_event_call *tp_event)
 #define SYSCALL32_DEFINE6 SYSCALL_DEFINE6
 #endif
 
-/*
- * Called before coming back to user-mode. Returning to user-mode with an
- * address limit different than USER_DS can allow to overwrite kernel memory.
- */
-static inline void addr_limit_user_check(void)
-{
-#ifdef TIF_FSCHECK
-	if (!test_thread_flag(TIF_FSCHECK))
-		return;
-#endif
-
-#ifdef TIF_FSCHECK
-	clear_thread_flag(TIF_FSCHECK);
-#endif
-}
-
 /*
  * These syscall function prototypes are kept in the same order as
  * include/uapi/asm-generic/unistd.h. Architecture specific entries go below,
diff --git a/kernel/entry/common.c b/kernel/entry/common.c
index be61332c66b54..d7ee4bc3f2ba3 100644
--- a/kernel/entry/common.c
+++ b/kernel/entry/common.c
@@ -205,8 +205,7 @@ static void exit_to_user_mode_prepare(struct pt_regs *regs)
 
 	arch_exit_to_user_mode_prepare(regs, ti_work);
 
-	/* Ensure that the address limit is intact and no locks are held */
-	addr_limit_user_check();
+	/* Ensure that kernel state is sane for a return to userspace */
 	kmap_assert_nomap();
 	lockdep_assert_irqs_disabled();
 	lockdep_sys_exit();
-- 
2.30.2

