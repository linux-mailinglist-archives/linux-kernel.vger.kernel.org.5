Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76D1877F59D
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 13:48:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350469AbjHQLr5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 07:47:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350546AbjHQLrw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 07:47:52 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA91B359F;
        Thu, 17 Aug 2023 04:47:33 -0700 (PDT)
Date:   Thu, 17 Aug 2023 11:47:26 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1692272847;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1ZNm0+YhzoKEbhcNneMVVsLgitVZJn187VVdpZJuX9w=;
        b=qwvv9gaK5dnrkKopP1S0zQdb/JiKgBLs5CXVxXB84vS9pEZcRHvkYHUgpdKbPykzw12YHT
        7PsFGPkjK7aQehNHY02XCVK6rj6ZcX6DonBJ7uWg3It3A6SIAIxMhGBAGdaOgFyUxdVLuF
        VvEr3NRqcMjgvdWsf6w2lGvzMobwVA7YJ6e4G0o9ymKM1sRSKr8FM28GBv2MgYo+n0RupJ
        7/74fznYWsJrMcqGBozaqYRZttKK4ZcOGATZYw2xzT/W69R3hQbXOYy9PP1v+KGskM9+pC
        GtVpjtWZznzvkVuNTWRPdIdVff2QS9vTrIBYSTVzbPFoBrAy6J6lpOI92lLwsw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1692272847;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1ZNm0+YhzoKEbhcNneMVVsLgitVZJn187VVdpZJuX9w=;
        b=ELOfG4J9ZwyKNxSuoEvAOkfVpK6XpBF0OZh4Z37CTKtshPFHUHoMzswCkj/U28nj+nZeHs
        UUzksgFZmRBCQ3BQ==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/static_call: Fix __static_call_fixup()
Cc:     Christian Bricart <christian@bricart.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230816104419.GA982867@hirez.programming.kicks-ass.net>
References: <20230816104419.GA982867@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Message-ID: <169227284649.27769.26954089938187197.tip-bot2@tip-bot2>
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

Commit-ID:     54097309620ef0dc2d7083783dc521c6a5fef957
Gitweb:        https://git.kernel.org/tip/54097309620ef0dc2d7083783dc521c6a5fef957
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Wed, 16 Aug 2023 12:44:19 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 17 Aug 2023 13:24:09 +02:00

x86/static_call: Fix __static_call_fixup()

Christian reported spurious module load crashes after some of Song's
module memory layout patches.

Turns out that if the very last instruction on the very last page of the
module is a 'JMP __x86_return_thunk' then __static_call_fixup() will
trip a fault and die.

And while the module rework made this slightly more likely to happen,
it's always been possible.

Fixes: ee88d363d156 ("x86,static_call: Use alternative RET encoding")
Reported-by: Christian Bricart <christian@bricart.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Josh Poimboeuf <jpoimboe@kernel.org>
Link: https://lkml.kernel.org/r/20230816104419.GA982867@hirez.programming.kicks-ass.net
---
 arch/x86/kernel/static_call.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/x86/kernel/static_call.c b/arch/x86/kernel/static_call.c
index b70670a..77a9316 100644
--- a/arch/x86/kernel/static_call.c
+++ b/arch/x86/kernel/static_call.c
@@ -186,6 +186,19 @@ EXPORT_SYMBOL_GPL(arch_static_call_transform);
  */
 bool __static_call_fixup(void *tramp, u8 op, void *dest)
 {
+	unsigned long addr = (unsigned long)tramp;
+	/*
+	 * Not all .return_sites are a static_call trampoline (most are not).
+	 * Check if the 3 bytes after the return are still kernel text, if not,
+	 * then this definitely is not a trampoline and we need not worry
+	 * further.
+	 *
+	 * This avoids the memcmp() below tripping over pagefaults etc..
+	 */
+	if (((addr >> PAGE_SHIFT) != ((addr + 7) >> PAGE_SHIFT)) &&
+	    !kernel_text_address(addr + 7))
+		return false;
+
 	if (memcmp(tramp+5, tramp_ud, 3)) {
 		/* Not a trampoline site, not our problem. */
 		return false;
