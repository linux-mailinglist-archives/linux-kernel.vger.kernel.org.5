Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 963967A6933
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 18:53:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231743AbjISQxD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 12:53:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229648AbjISQxB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 12:53:01 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63E89D6;
        Tue, 19 Sep 2023 09:52:55 -0700 (PDT)
Date:   Tue, 19 Sep 2023 16:52:53 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1695142373;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=NMeI9uputI/pj8YoMC32t3WcmDkFWOVztpcbTOrmJbw=;
        b=hszdx5JwGyr4GTEUnHjRktznD1q//wmaU4hQ071L2YpFYKQ4Uy/1ClRvMDneNT5xP4uipa
        M1mTNMcikuvLJ5oo6poyuf4fsdKFPHkhLgkPWHXfuefwNKgsQjR2j5/U3IYKBUi58H2AHX
        7Yj6z35W9c/JIM/In5eZ805j8f/DRiREAi4CwK3mUvBf6sxrBY4MIrwYidyBlLLVpnnUVQ
        13x5wcmvPUHym3MCbpx7muHhpiWLYw2Rk4d99v6EMmOJ6z+sO3SEyPTYc7gLXfTwybAt+m
        ZDMBC+/R4KaOzQ4DsiCJhZCEvyiSkNdLQ6gsj0+pAcGxEU6HL69N5bdl/B08oA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1695142373;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=NMeI9uputI/pj8YoMC32t3WcmDkFWOVztpcbTOrmJbw=;
        b=yLPc2AcoHeTkLp3VpeHbViumCIdWPCI4rlvuqiECxmzoOzjsqNDebyJdHDbE5rsA2pH9iv
        tcBBQZMQs52m5WDQ==
From:   "tip-bot2 for Rick Edgecombe" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/shstk: Remove useless clone error handling
Cc:     Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H.J. Lu" <hjl.tools@gmail.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <169514237318.27769.7169875590985275390.tip-bot2@tip-bot2>
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

Commit-ID:     748c90c693363d05c6b2f3915edc7999a2f71837
Gitweb:        https://git.kernel.org/tip/748c90c693363d05c6b2f3915edc7999a2f71837
Author:        Rick Edgecombe <rick.p.edgecombe@intel.com>
AuthorDate:    Fri, 08 Sep 2023 13:36:54 -07:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Tue, 19 Sep 2023 09:18:34 -07:00

x86/shstk: Remove useless clone error handling

When clone fails after the shadow stack is allocated, any allocated shadow
stack is cleaned up in exit_thread() in copy_process(). So the logic in
copy_thread() is unneeded, and also will not handle failures that happen
outside of copy_thread().

In addition, since there is a second attempt to unmap the same shadow
stack, there is a race where an newly mapped region could get unmapped.

So remove the logic in copy_thread() and rely on exit_thread() to handle
clone failure.

Fixes: b2926a36b97a ("x86/shstk: Handle thread shadow stack")
Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Tested-by: H.J. Lu <hjl.tools@gmail.com>
Link: https://lore.kernel.org/all/20230908203655.543765-3-rick.p.edgecombe%40intel.com
---
 arch/x86/kernel/process.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/arch/x86/kernel/process.c b/arch/x86/kernel/process.c
index 9f09091..b6f4e83 100644
--- a/arch/x86/kernel/process.c
+++ b/arch/x86/kernel/process.c
@@ -257,13 +257,6 @@ int copy_thread(struct task_struct *p, const struct kernel_clone_args *args)
 	if (!ret && unlikely(test_tsk_thread_flag(current, TIF_IO_BITMAP)))
 		io_bitmap_share(p);
 
-	/*
-	 * If copy_thread() if failing, don't leak the shadow stack possibly
-	 * allocated in shstk_alloc_thread_stack() above.
-	 */
-	if (ret)
-		shstk_free(p);
-
 	return ret;
 }
 
