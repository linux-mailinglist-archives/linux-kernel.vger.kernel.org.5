Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9F2D7852E5
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 10:41:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234782AbjHWIlO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 04:41:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234885AbjHWIhC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 04:37:02 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B05510C7;
        Wed, 23 Aug 2023 01:35:29 -0700 (PDT)
Date:   Wed, 23 Aug 2023 08:35:27 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1692779728;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=83ap6gNjbZy8vamHzdazsWvNwO536xb4WpHK1tf2Qrg=;
        b=XMjf6Qkd1Y6T84xTqorejUc3i2jbtS/xkFYPhYRrsZKjNmn9RTbY7mwbOsR9SfvdAAm7X5
        EJ19DGnM1zYTPQHelmzhhuHidHRi1P87dWyVmCFV/v5w93IfQ/aqZHR1xAbmewG3GfGh/5
        iojK9gXa/eSafujVls2WlwCHaCNaanlI8Dmpjw6kywnbaFycIQuNhBbDTGfVFQ5xftcyAy
        W9GNlQCDXO1+b/YohTT/mesFpBdkpGDv/j5PxO4Z8C+Hgtf+wMUvxMVguWqU+1Y8+Gl4ZN
        gV9fz0lMJUQPZSf16ad57zQa1lFCZPBvZvMF3n8qkko1LuAuRJLiZiWdweeyvg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1692779728;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=83ap6gNjbZy8vamHzdazsWvNwO536xb4WpHK1tf2Qrg=;
        b=xATyOqGdBuKuZ9jmd51n371L5OH+tOXSYRvb75NXqFxIm1QUc129l+7aK6z5PVL4668a2S
        ystWlYPl41zNiSCA==
From:   "tip-bot2 for Mark Rutland" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/entry] entry: Remove empty addr_limit_user_check()
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230821163526.2319443-1-mark.rutland@arm.com>
References: <20230821163526.2319443-1-mark.rutland@arm.com>
MIME-Version: 1.0
Message-ID: <169277972713.27769.12372205097599743330.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the core/entry branch of tip:

Commit-ID:     1dfe3a5a7cefbe2162cecb759f3933baea22c393
Gitweb:        https://git.kernel.org/tip/1dfe3a5a7cefbe2162cecb759f3933baea22c393
Author:        Mark Rutland <mark.rutland@arm.com>
AuthorDate:    Mon, 21 Aug 2023 17:35:26 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 23 Aug 2023 10:32:39 +02:00

entry: Remove empty addr_limit_user_check()

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

No functional change.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20230821163526.2319443-1-mark.rutland@arm.com

---
 include/linux/syscalls.h | 16 ----------------
 kernel/entry/common.c    |  3 +--
 2 files changed, 1 insertion(+), 18 deletions(-)

diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
index 03e3d01..c4b9b66 100644
--- a/include/linux/syscalls.h
+++ b/include/linux/syscalls.h
@@ -284,22 +284,6 @@ static inline int is_syscall_trace_event(struct trace_event_call *tp_event)
 #endif
 
 /*
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
-/*
  * These syscall function prototypes are kept in the same order as
  * include/uapi/asm-generic/unistd.h. Architecture specific entries go below,
  * followed by deprecated or obsolete system calls.
diff --git a/kernel/entry/common.c b/kernel/entry/common.c
index be61332..d7ee4bc 100644
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
