Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 676AC7C8441
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 13:19:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231182AbjJMLSi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 07:18:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231124AbjJMLSd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 07:18:33 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFA43C0;
        Fri, 13 Oct 2023 04:18:29 -0700 (PDT)
Date:   Fri, 13 Oct 2023 11:18:27 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1697195907;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ihpIi2zGpV5iO/jJMKvvrWvIgzFRX85SMyep/niyOVw=;
        b=VveKxmNqOx7pw67Y8bqrI1W0+budg++VYzA6N/TVK1zRbilqaVLpaQRDUCG+CZ/DST9fwt
        1T/2QW5pmt0FdYVtSu8OuGNnVY25UR9oRbBVMAWIkDonAAmDCB0lDyCOvVsMTSEYZ18+H5
        RtYydfb7Ti7ydrDqHG8+EGVClvJ4CIqjs/jDzSbOALLhoRCmyTpGpfW7P27swMmH7U9u3X
        oV9Ahehk+cKsurYoEdAOrA3xqvWUbaKmZs+l0uq2tOBDWnMU/VjNI+rPS1ipMffA1/3QXa
        U4Dw7Eg83a3VWRc/M7E/GiT8ccAR1g1biPajS3h0b+mtF8SD0Wd5it6fY7Br2g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1697195907;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ihpIi2zGpV5iO/jJMKvvrWvIgzFRX85SMyep/niyOVw=;
        b=Q5fTleJKNiHeF1s0R7vK/nO0PDS6X07j7xhaUw56bYEBmZW9c26wwnDJVFUb7js4jlzOe6
        7ZUf7F/8o9+ZNKBQ==
From:   "tip-bot2 for Brian Gerst" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/entry] x86/entry/64: Use TASK_SIZE_MAX for canonical RIP test
Cc:     Brian Gerst <brgerst@gmail.com>, Ingo Molnar <mingo@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Denys Vlasenko <dvlasenk@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Uros Bizjak <ubizjak@gmail.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20231011224351.130935-3-brgerst@gmail.com>
References: <20231011224351.130935-3-brgerst@gmail.com>
MIME-Version: 1.0
Message-ID: <169719590716.3135.10309736631158969894.tip-bot2@tip-bot2>
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

The following commit has been merged into the x86/entry branch of tip:

Commit-ID:     58978b44df7276f7c75a2c6aad6c201421cd4daa
Gitweb:        https://git.kernel.org/tip/58978b44df7276f7c75a2c6aad6c201421cd4daa
Author:        Brian Gerst <brgerst@gmail.com>
AuthorDate:    Wed, 11 Oct 2023 18:43:50 -04:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 13 Oct 2023 13:05:28 +02:00

x86/entry/64: Use TASK_SIZE_MAX for canonical RIP test

Using shifts to determine if an address is canonical is difficult for
the compiler to optimize when the virtual address width is variable
(LA57 feature) without using inline assembly.  Instead, compare RIP
against TASK_SIZE_MAX.  The only user executable address outside of that
range is the deprecated vsyscall page, which can fall back to using IRET.

Signed-off-by: Brian Gerst <brgerst@gmail.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Brian Gerst <brgerst@gmail.com>
Cc: Denys Vlasenko <dvlasenk@redhat.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Uros Bizjak <ubizjak@gmail.com>
Link: https://lore.kernel.org/r/20231011224351.130935-3-brgerst@gmail.com
---
 arch/x86/entry/common.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/x86/entry/common.c b/arch/x86/entry/common.c
index 9021465..4c7154d 100644
--- a/arch/x86/entry/common.c
+++ b/arch/x86/entry/common.c
@@ -110,10 +110,10 @@ __visible noinstr bool do_syscall_64(struct pt_regs *regs, int nr)
 	 * in kernel space.  This essentially lets the user take over
 	 * the kernel, since userspace controls RSP.
 	 *
-	 * Change top bits to match the most significant bit (47th or 56th bit
-	 * depending on paging mode) in the address.
+	 * TASK_SIZE_MAX covers all user-accessible addresses other than
+	 * the deprecated vsyscall page.
 	 */
-	if (unlikely(!__is_canonical_address(regs->ip, __VIRTUAL_MASK_SHIFT + 1)))
+	if (unlikely(regs->ip >= TASK_SIZE_MAX))
 		return false;
 
 	/*
