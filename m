Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5638C7AC7B6
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Sep 2023 13:33:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229618AbjIXLdh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Sep 2023 07:33:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjIXLdf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Sep 2023 07:33:35 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97870DA;
        Sun, 24 Sep 2023 04:33:29 -0700 (PDT)
Date:   Sun, 24 Sep 2023 11:33:26 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1695555207;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sQ5Vz++03aAd/jaHF9EEyceiSFGpFYiJ8gae6ba/jkk=;
        b=xOKb5Mq3gRkg3ndXQ6fZWQAu45wTHvR2LbJIssb2RJcFLDhlq7k1OkDDabvEQxQtNH0DNv
        N1wtuU4ZJPiqocHQ7kds4OZyo7FBgor4QF9R1oMrSnQ5l8ULaO/bAfrU3fr1nQkl9QXjvk
        IWrGGMKmnM9zrMC1NsTJpILoJ559lLmeqfSLovhEGu4SaGbtMrfqp317MG1aT3sfLF5SbI
        MFBMd2yZ/kRK8AK+lIG8bZxqOD62sA4PTfP4lJaWAvF78/915c/QCavK+/aTmdb1hSfqGp
        PfGewSoKpSuKyvYN3LCuOPlkeiO9PvTLgL1lsDZJLOrWqbmvx5/sZhRzjQaLiw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1695555207;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sQ5Vz++03aAd/jaHF9EEyceiSFGpFYiJ8gae6ba/jkk=;
        b=y3CLop16d3hRurJ7gbKT94OsI/gA7mpgdeusZPL56h5jM89wDX7CIOTrR0/+JJQRZ1SHPA
        ML1pr0RUKbFEt+DA==
From:   "tip-bot2 for Hugh Dickins" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/mm] x86_64: Show CR4.PSE on auxiliaries like on BSP
Cc:     Hugh Dickins <hughd@google.com>, Ingo Molnar <mingo@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <103ad03a-8c93-c3e2-4226-f79af4d9a074@google.com>
References: <103ad03a-8c93-c3e2-4226-f79af4d9a074@google.com>
MIME-Version: 1.0
Message-ID: <169555520691.27769.2960713930630159681.tip-bot2@tip-bot2>
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

The following commit has been merged into the x86/mm branch of tip:

Commit-ID:     f4c5ca9850124fb5715eff06cffb1beed837500c
Gitweb:        https://git.kernel.org/tip/f4c5ca9850124fb5715eff06cffb1beed837500c
Author:        Hugh Dickins <hughd@google.com>
AuthorDate:    Mon, 14 Aug 2023 19:53:18 -07:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Sun, 24 Sep 2023 13:23:54 +02:00

x86_64: Show CR4.PSE on auxiliaries like on BSP

Set CR4.PSE in secondary_startup_64: the Intel SDM is clear that it does
not matter whether it's 0 or 1 when 4-level-pts are enabled, but it's
distracting to find CR4 different on BSP and auxiliaries - on x86_64,
BSP alone got to add the PSE bit, in probe_page_size_mask().

Peter Zijlstra adds:

   "I think the point is that PSE bit is completely without
    meaning in long mode.

    But yes, having the same CR4 bits set across BSP and APs is
    definitely sane."

Signed-off-by: Hugh Dickins <hughd@google.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/103ad03a-8c93-c3e2-4226-f79af4d9a074@google.com
---
 arch/x86/kernel/head_64.S | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/head_64.S b/arch/x86/kernel/head_64.S
index ea69959..3ddce02 100644
--- a/arch/x86/kernel/head_64.S
+++ b/arch/x86/kernel/head_64.S
@@ -180,8 +180,8 @@ SYM_INNER_LABEL(secondary_startup_64_no_verify, SYM_L_GLOBAL)
 	movl	$0, %ecx
 #endif
 
-	/* Enable PAE mode, PGE and LA57 */
-	orl	$(X86_CR4_PAE | X86_CR4_PGE), %ecx
+	/* Enable PAE mode, PSE, PGE and LA57 */
+	orl	$(X86_CR4_PAE | X86_CR4_PSE | X86_CR4_PGE), %ecx
 #ifdef CONFIG_X86_5LEVEL
 	testl	$1, __pgtable_l5_enabled(%rip)
 	jz	1f
