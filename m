Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0721380C8FA
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 13:06:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234493AbjLKMGV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 07:06:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234454AbjLKMGP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 07:06:15 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68B3BFD;
        Mon, 11 Dec 2023 04:06:20 -0800 (PST)
Date:   Mon, 11 Dec 2023 12:06:18 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1702296379;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VfTPl/nW9rDgb6I9nd5VFUQTJIv7AQKSpG+8w24XWxg=;
        b=2B0cL0HwQk/aPIxgPF+q3+qmJmNCR2zriNdqdInHiEhpQqEmxHpUqJ/2MkWq4FCsixWtUz
        2zvwuM+bNqmw2oweLeQLb9Jd64G+WkwRlrewYava2VEStdMPvalbRxv8IVNK27/cctY3NR
        eSEtWHoPHG4i0jLkSXz/d6xw5cyb8Um5I0wT5XzyRnnvKveyUDCWKHA7ProO1iTvsSs+Pn
        S9W93ggkargHHzmDdbvrrFs0hHyU46/Z7K2EKebSwWfMVGoHuNXSvF55CcBty0Yi25ECmT
        mlt1hZjSM6oXNhjSLhrsqH+uqOB7uJJTkKPEowIQTosXVDgYZ5UbS460wre1kw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1702296379;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VfTPl/nW9rDgb6I9nd5VFUQTJIv7AQKSpG+8w24XWxg=;
        b=MTpmbXwLJP4DtyKIdC+P4R64LflOAoTXmLRUR1JyGN9kGMpqEIcJVqIhKMTk7SkswX6K+p
        ZLsVldSOFqLFMrCA==
From:   "tip-bot2 for Uros Bizjak" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/percpu] x86/traps: Use current_top_of_stack() helper in traps.c
Cc:     Uros Bizjak <ubizjak@gmail.com>, Ingo Molnar <mingo@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20231204210320.114429-2-ubizjak@gmail.com>
References: <20231204210320.114429-2-ubizjak@gmail.com>
MIME-Version: 1.0
Message-ID: <170229637816.398.6506455819507623200.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/percpu branch of tip:

Commit-ID:     13408c6ae684181d53c870cceddbd3a62ae34c3e
Gitweb:        https://git.kernel.org/tip/13408c6ae684181d53c870cceddbd3a62ae34c3e
Author:        Uros Bizjak <ubizjak@gmail.com>
AuthorDate:    Mon, 04 Dec 2023 22:02:30 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Mon, 11 Dec 2023 11:47:15 +01:00

x86/traps: Use current_top_of_stack() helper in traps.c

Use current_top_of_stack() helper in sync_regs() and vc_switch_off_ist()
instead of open-coding the reading of  the top_of_stack percpu variable
explicitly.

Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Link: https://lore.kernel.org/r/20231204210320.114429-2-ubizjak@gmail.com
---
 arch/x86/kernel/traps.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
index c876f1d..78b1d1a 100644
--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -772,7 +772,7 @@ DEFINE_IDTENTRY_RAW(exc_int3)
  */
 asmlinkage __visible noinstr struct pt_regs *sync_regs(struct pt_regs *eregs)
 {
-	struct pt_regs *regs = (struct pt_regs *)this_cpu_read(pcpu_hot.top_of_stack) - 1;
+	struct pt_regs *regs = (struct pt_regs *)current_top_of_stack() - 1;
 	if (regs != eregs)
 		*regs = *eregs;
 	return regs;
@@ -790,7 +790,7 @@ asmlinkage __visible noinstr struct pt_regs *vc_switch_off_ist(struct pt_regs *r
 	 * trust it and switch to the current kernel stack
 	 */
 	if (ip_within_syscall_gap(regs)) {
-		sp = this_cpu_read(pcpu_hot.top_of_stack);
+		sp = current_top_of_stack();
 		goto sync;
 	}
 
