Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8C817C7514
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 19:50:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379672AbjJLRun (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 13:50:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379651AbjJLRuj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 13:50:39 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D504D6;
        Thu, 12 Oct 2023 10:50:37 -0700 (PDT)
Date:   Thu, 12 Oct 2023 17:50:35 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1697133036;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=u1tRzLxcoMbWxvG+mukyL8m7+kfZ7rIvBFU2zqRdBCY=;
        b=FmPglg7N3Aq85KxQQgdo5HL3aSPu7ftnaFGkOOGFO2xC602jFOlZ+PhVxCo64AgWP9rSRg
        eIbmngOwHh9UgO4YURmni+ZJD4yaskMTyB7NeAsWzFX41NmWMC2tvLTh+KtBnIOzQdwPwd
        VsDpU0QgW7R7tTThZa2KLMuIjX8SnsS7hqzFZteTcFyFugswI01WGKnJg3X4NoAAhQN/VZ
        /tveEwAnhjGA3jsBtfPDixagLq3x8TMOiyOJHbW6xWVBHtTI0FSXb+7qQWEGgbOgt4MDjJ
        S88k937aVijiM6vGrRvi2GsWiz94Sq9vxDTdJIGkiEhB8vfedrk8L9A88Lw11Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1697133036;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=u1tRzLxcoMbWxvG+mukyL8m7+kfZ7rIvBFU2zqRdBCY=;
        b=FhqAUCdVyd07m193GPDhmDCWLsDA7wnltmxS0XPHKrZjQaq93+DmqQfn5COEKlCZ5eajat
        /bOnQV6hfVO6EcDQ==
From:   "tip-bot2 for David Kaplan" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/bugs] x86/retpoline: Ensure default return thunk isn't used
 at runtime
Cc:     David Kaplan <david.kaplan@amd.com>,
        "Borislav Petkov (AMD)" <bp@alien8.de>,
        Ingo Molnar <mingo@kernel.org>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20231012141031.GHZSf+V1NjjUJTc9a9@fat_crate.local>
References: <20231012141031.GHZSf+V1NjjUJTc9a9@fat_crate.local>
MIME-Version: 1.0
Message-ID: <169713303534.3135.10558074245117750218.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/bugs branch of tip:

Commit-ID:     91174087dcc7565d8bf0d576544e42d5b1de6f39
Gitweb:        https://git.kernel.org/tip/91174087dcc7565d8bf0d576544e42d5b1de6f39
Author:        David Kaplan <david.kaplan@amd.com>
AuthorDate:    Thu, 12 Oct 2023 16:10:31 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Thu, 12 Oct 2023 19:44:34 +02:00

x86/retpoline: Ensure default return thunk isn't used at runtime

All CPU bugs that require a return thunk define a special return thunk
to use (e.g., srso_return_thunk).  The default thunk,
__x86_return_thunk, should never be used after apply_returns()
completes.  Otherwise this could lead to potential speculation holes.

Enforce this by replacing this thunk with a ud2 when alternatives are
applied.  Alternative instructions are applied after apply_returns().

The default thunk is only used during kernel boot, it is not used during
module init since that occurs after apply_returns().

Signed-off-by: David Kaplan <david.kaplan@amd.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Josh Poimboeuf <jpoimboe@kernel.org>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/20231012141031.GHZSf+V1NjjUJTc9a9@fat_crate.local
---
 arch/x86/lib/retpoline.S | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/arch/x86/lib/retpoline.S b/arch/x86/lib/retpoline.S
index 6376d01..fe05c13 100644
--- a/arch/x86/lib/retpoline.S
+++ b/arch/x86/lib/retpoline.S
@@ -356,15 +356,17 @@ SYM_FUNC_END(call_depth_return_thunk)
  * This function name is magical and is used by -mfunction-return=thunk-extern
  * for the compiler to generate JMPs to it.
  *
- * This code is only used during kernel boot or module init.  All
+ * This code is only used during kernel boot.  All
  * 'JMP __x86_return_thunk' sites are changed to something else by
  * apply_returns().
+ *
+ * This thunk is turned into a ud2 to ensure it is never used at runtime.
+ * Alternative instructions are applied after apply_returns().
  */
 SYM_CODE_START(__x86_return_thunk)
 	UNWIND_HINT_FUNC
 	ANNOTATE_NOENDBR
-	ANNOTATE_UNRET_SAFE
-	ret
+	ALTERNATIVE __stringify(ANNOTATE_UNRET_SAFE;ret),"ud2", X86_FEATURE_ALWAYS
 	int3
 SYM_CODE_END(__x86_return_thunk)
 EXPORT_SYMBOL(__x86_return_thunk)
