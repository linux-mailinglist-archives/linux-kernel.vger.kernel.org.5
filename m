Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8093C76DA86
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 00:19:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230280AbjHBWTf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 18:19:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229610AbjHBWT3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 18:19:29 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B85072703;
        Wed,  2 Aug 2023 15:19:26 -0700 (PDT)
Date:   Wed, 02 Aug 2023 22:19:22 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1691014764;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=LNRvVa6+ZCTmAy1D1RLwyuNTOalFwUFV4pzniqzVN0A=;
        b=ttWGX0FX7b/yFG9HQGkGA3VjOmysOUUqGgdoebCxR4d8fe4vPQDxCVuWFk63n7xZDcNa1b
        HTk+UOhY9x5BeqI5Wgx/oOjst4ruDl8hVuOwKnTB0YOsLtNmX22KkENuLHQFLGBy5okmFj
        keNdGWizqHd12Ah07YRy741/JYPvveZ3n90Buxz9+k7RiDuvNTkTj1P9s7V97bwPww/5zT
        q5c7mIn8cenYtWLVuhC2byNbL0wmaFgCg7OWdEzqU9lVfyLAzW2uAl+WT03hCF7MbgjxTk
        wVWGz6Yj0t+ZUpfS3Qa54lqwYkaA79Koyp0wk4YjjdgOXtIrSZ6yJje6UzD3iA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1691014764;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=LNRvVa6+ZCTmAy1D1RLwyuNTOalFwUFV4pzniqzVN0A=;
        b=8azskVm0mzQZL+VVCmpqqgPXyblXCY7psZ/TP7jwzcU+q/bDIeTwuHH2Oe6QhQiFj5JwCZ
        CslYqtaWcrHGE/CQ==
From:   "tip-bot2 for Rick Edgecombe" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/shstk] x86/shstk: Don't retry vm_munmap() on -EINTR
Cc:     Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <169101476285.28540.9496788715875076111.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/shstk branch of tip:

Commit-ID:     c6b53dcec07c842af75123d9b29684bdbd36a407
Gitweb:        https://git.kernel.org/tip/c6b53dcec07c842af75123d9b29684bdbd36a407
Author:        Rick Edgecombe <rick.p.edgecombe@intel.com>
AuthorDate:    Thu, 06 Jul 2023 16:38:58 -07:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Wed, 02 Aug 2023 15:01:51 -07:00

x86/shstk: Don't retry vm_munmap() on -EINTR

The existing comment around handling vm_munmap() failure when freeing a
shadow stack is wrong. It asserts that vm_munmap() returns -EINTR when
the mmap lock is only being held for a short time, and so the caller
should retry. Based on this wrong understanding, unmap_shadow_stack() will
loop retrying vm_munmap().

What -EINTR actually means in this case is that the process is going
away (see ae79878), and the whole MM will be torn down soon. In order
to facilitate this, the task should not linger in the kernel, but
actually do the opposite. So don't loop in this scenario, just abandon
the operation and let exit_mmap() clean it up. Also, update the comment
to reflect the actual meaning of the error code.

Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Link: https://lore.kernel.org/all/20230706233858.446232-1-rick.p.edgecombe%40intel.com
---
 arch/x86/kernel/shstk.c | 38 +++++++++++++++++---------------------
 1 file changed, 17 insertions(+), 21 deletions(-)

diff --git a/arch/x86/kernel/shstk.c b/arch/x86/kernel/shstk.c
index 47f5204..cd10d07 100644
--- a/arch/x86/kernel/shstk.c
+++ b/arch/x86/kernel/shstk.c
@@ -134,28 +134,24 @@ static unsigned long adjust_shstk_size(unsigned long size)
 
 static void unmap_shadow_stack(u64 base, u64 size)
 {
-	while (1) {
-		int r;
-
-		r = vm_munmap(base, size);
-
-		/*
-		 * vm_munmap() returns -EINTR when mmap_lock is held by
-		 * something else, and that lock should not be held for a
-		 * long time.  Retry it for the case.
-		 */
-		if (r == -EINTR) {
-			cond_resched();
-			continue;
-		}
+	int r;
 
-		/*
-		 * For all other types of vm_munmap() failure, either the
-		 * system is out of memory or there is bug.
-		 */
-		WARN_ON_ONCE(r);
-		break;
-	}
+	r = vm_munmap(base, size);
+
+	/*
+	 * mmap_write_lock_killable() failed with -EINTR. This means
+	 * the process is about to die and have it's MM cleaned up.
+	 * This task shouldn't ever make it back to userspace. In this
+	 * case it is ok to leak a shadow stack, so just exit out.
+	 */
+	if (r == -EINTR)
+		return;
+
+	/*
+	 * For all other types of vm_munmap() failure, either the
+	 * system is out of memory or there is bug.
+	 */
+	WARN_ON_ONCE(r);
 }
 
 static int shstk_setup(void)
