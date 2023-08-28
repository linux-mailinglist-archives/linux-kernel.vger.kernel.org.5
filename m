Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 253DA78B148
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 15:02:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232243AbjH1NBi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 09:01:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232601AbjH1NBO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 09:01:14 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89797136
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 06:01:11 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1693227670;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=hfsWusLl7sAG9bJfCh+FnPubAtTCX2cDtC8XikEZYfI=;
        b=tHCuREfJhEf8tBvKwZkRl8HSQ47Mvlc7WhTQr55zu9ehLU9WwFUnoqj/Kdp6+QYba7VEDu
        4lmdjA8ZqqlTxbDAkLsiVD5BHh/Ra2Na8o5ZedMxSRiDx4EJMCDLedr3dD2vyWPG9hSfdG
        NZldddnF3ZMBX5GnBmTdGsZK2KweCirvWKy4071ybOinZX47DAe1dvI74HiLKND/f2ywoX
        EZum085HwJHwgEMmO6LlsXmydSQuWAoeubi975kV84aHi/T+oYkfp99Mv/grEXN9C9wvPB
        8UjWkbkoHeAENuuLWG0t7+d5rxAIIITBgymqibqeCKUwaH65/YOigLPAdrRl4w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1693227670;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=hfsWusLl7sAG9bJfCh+FnPubAtTCX2cDtC8XikEZYfI=;
        b=RuPdBrtF/hxK4zjVvSOzGfHT1ZOrgDUAQDCn909WRcr8616H+2kUGjufxEhjN4t64c/lOc
        lJd4+f9ItLhPEhDQ==
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [GIT pull] core/entry for v6.6-rc1
Message-ID: <169322654636.420889.373907562030292433.tglx@xen13.tec.linutronix.de>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Date:   Mon, 28 Aug 2023 15:01:10 +0200 (CEST)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull the latest core/entry branch from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git core-entry-2023-=
08-28

up to:  1dfe3a5a7cef: entry: Remove empty addr_limit_user_check()


A single update to the core entry code, which removes the empty user
address limit check which is a leftover of the removed TIF_FSCHECK.

Thanks,

	tglx

------------------>
Mark Rutland (1):
      entry: Remove empty addr_limit_user_check()


 include/linux/syscalls.h | 16 ----------------
 kernel/entry/common.c    |  3 +--
 2 files changed, 1 insertion(+), 18 deletions(-)

diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
index 03e3d0121d5e..c4b9b66b0d05 100644
--- a/include/linux/syscalls.h
+++ b/include/linux/syscalls.h
@@ -283,22 +283,6 @@ static inline int is_syscall_trace_event(struct trace_ev=
ent_call *tp_event)
 #define SYSCALL32_DEFINE6 SYSCALL_DEFINE6
 #endif
=20
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
index be61332c66b5..d7ee4bc3f2ba 100644
--- a/kernel/entry/common.c
+++ b/kernel/entry/common.c
@@ -205,8 +205,7 @@ static void exit_to_user_mode_prepare(struct pt_regs *reg=
s)
=20
 	arch_exit_to_user_mode_prepare(regs, ti_work);
=20
-	/* Ensure that the address limit is intact and no locks are held */
-	addr_limit_user_check();
+	/* Ensure that kernel state is sane for a return to userspace */
 	kmap_assert_nomap();
 	lockdep_assert_irqs_disabled();
 	lockdep_sys_exit();

