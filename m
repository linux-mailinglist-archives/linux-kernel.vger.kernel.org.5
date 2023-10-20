Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E10457D0EA1
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 13:37:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377236AbjJTLhd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 07:37:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377166AbjJTLhU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 07:37:20 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6510D4C;
        Fri, 20 Oct 2023 04:37:18 -0700 (PDT)
Date:   Fri, 20 Oct 2023 11:37:12 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1697801837;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tW7YSgvT1sIejWKhmFk87XKju2fsmJGO/qsh36cwBFg=;
        b=dRNM0VnUet/tRImlmov45zmlUUj76ZIVDZR3f/n1pChP+I7dw32LGM7uCfQj1tIKgkuV0v
        qTpADEd6yfebor2/2oS/ghuMt+y363GXiIU06StPuSgGs0pzf7EHf9pFJ0NOpZIXLK9+Sa
        /qtDpE5N7wrfAv1OA47jJS2j/2W4N3uEOtyvL1DPPe8FCtqo3iHAOr2gBqBkSX3GmMsvi+
        qnCBfj3kPMd6Y42fwaSmTGRJ5xhO4aSHXfmOU/th5vDcZ/iQ2CCPFApThrhN7Qbou0PcqP
        eLIz4tgkoeKHJVWl3SHzCyQx2HZ4B49TwOowslie7dI/WtRhk5QvCYt4Q0Gd5A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1697801837;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tW7YSgvT1sIejWKhmFk87XKju2fsmJGO/qsh36cwBFg=;
        b=itJR1fpxYCK3P6ny2rzPYxaBGcwfOzrZqo4rol5pC2czz+8+Xke3BcQTb+53KjAlrDklNn
        wGL/rVasFM5YSNDA==
From:   "tip-bot2 for Borislav Petkov (AMD)" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/bugs] x86/retpoline: Document some thunk handling aspects
Cc:     Ingo Molnar <mingo@kernel.org>,
        "Borislav Petkov (AMD)" <bp@alien8.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20231010171020.462211-1-david.kaplan@amd.com>
References: <20231010171020.462211-1-david.kaplan@amd.com>
MIME-Version: 1.0
Message-ID: <169780183267.3135.3911908270721154685.tip-bot2@tip-bot2>
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

Commit-ID:     9d9c22cc444af01ce254872b729af26864c43a3a
Gitweb:        https://git.kernel.org/tip/9d9c22cc444af01ce254872b729af26864c43a3a
Author:        Borislav Petkov (AMD) <bp@alien8.de>
AuthorDate:    Fri, 20 Oct 2023 13:17:14 +02:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Fri, 20 Oct 2023 13:17:14 +02:00

x86/retpoline: Document some thunk handling aspects

After a lot of experimenting (see thread Link points to) document for
now the issues and requirements for future improvements to the thunk
handling and potential issuing of a diagnostic when the default thunk
hasn't been patched out.

This documentation is only temporary and that close before the merge
window it is only a placeholder for those future improvements.

Suggested-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/r/20231010171020.462211-1-david.kaplan@amd.com
---
 arch/x86/lib/retpoline.S | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/x86/lib/retpoline.S b/arch/x86/lib/retpoline.S
index d410aba..a48077c 100644
--- a/arch/x86/lib/retpoline.S
+++ b/arch/x86/lib/retpoline.S
@@ -129,6 +129,13 @@ SYM_CODE_END(__x86_indirect_jump_thunk_array)
 
 #ifdef CONFIG_RETHUNK
 
+/*
+ * Be careful here: that label cannot really be removed because in
+ * some configurations and toolchains, the JMP __x86_return_thunk the
+ * compiler issues is either a short one or the compiler doesn't use
+ * relocations for same-section JMPs and that breaks the returns
+ * detection logic in apply_returns() and in objtool.
+ */
 	.section .text..__x86.return_thunk
 
 #ifdef CONFIG_CPU_SRSO
@@ -361,6 +368,14 @@ SYM_FUNC_END(call_depth_return_thunk)
  * This code is only used during kernel boot or module init.  All
  * 'JMP __x86_return_thunk' sites are changed to something else by
  * apply_returns().
+ *
+ * This should be converted eventually to call a warning function which
+ * should scream loudly when the default return thunk is called after
+ * alternatives have been applied.
+ *
+ * That warning function cannot BUG() because the bug splat cannot be
+ * displayed in all possible configurations, leading to users not really
+ * knowing why the machine froze.
  */
 SYM_CODE_START(__x86_return_thunk)
 	UNWIND_HINT_FUNC
