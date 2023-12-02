Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D93E3801CE6
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Dec 2023 14:08:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229949AbjLBNIL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Dec 2023 08:08:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229671AbjLBNIK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Dec 2023 08:08:10 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 442B0119;
        Sat,  2 Dec 2023 05:08:16 -0800 (PST)
Date:   Sat, 02 Dec 2023 13:08:12 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1701522493;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Ahtf6qtGLkSFfzmKo7NT7kkLqGD19uzWB44u2/ZhTpI=;
        b=L9PND/m0+A3zEJvrkuKQ/MakGvjD/5B66zjE4CZEK0P2U/uSg5TlOGU2NTv5A++yunWgpB
        GKC2AAKEJxKQOmLSoyyiHoiHIr1ce+6x9ZEmhSWYK0XqdAhnu2bMBBha0ZuqlUEeXxHHR+
        c0xsnjTDvS2XkW14I0qymYgljALCJpmrMKXVkXu+ybBDWgfMVF/VAsJokPPTlhApkYD1U4
        g20oTh8cBIdyx1O6s6WNeTwOVVQ+Hja8DBh5njl7TQP3vWMykM3RjdvHGVgTTYSc88EeWS
        4wICZNk0UF+Cf4oxlbZmj30+K0vOmgrF2G3rlRkJ8qQv1R/69SwbKJC9q8aL9A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1701522493;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Ahtf6qtGLkSFfzmKo7NT7kkLqGD19uzWB44u2/ZhTpI=;
        b=ce9VhqqKCeR9Zs6Zb8m/ol+M10bds++4dJzmwwgqpFQVN/p6K/HKeDJXb5xv+14qOnFl+7
        0qY0wDvoiqiBeuAA==
From:   "tip-bot2 for Uros Bizjak" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/percpu] x86/callthunks: Correct calculation of dest address
 in is_callthunk()
Cc:     Nathan Chancellor <nathan@kernel.org>,
        Uros Bizjak <ubizjak@gmail.com>,
        Ingo Molnar <mingo@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20231201085727.3647051-1-ubizjak@gmail.com>
References: <20231201085727.3647051-1-ubizjak@gmail.com>
MIME-Version: 1.0
Message-ID: <170152249271.398.7485179912974283410.tip-bot2@tip-bot2>
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

Commit-ID:     fc50065325f8b88d6986f089ae103b5db858ab96
Gitweb:        https://git.kernel.org/tip/fc50065325f8b88d6986f089ae103b5db858ab96
Author:        Uros Bizjak <ubizjak@gmail.com>
AuthorDate:    Fri, 01 Dec 2023 09:57:27 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Sat, 02 Dec 2023 10:51:28 +01:00

x86/callthunks: Correct calculation of dest address in is_callthunk()

GCC didn't warn on the invalid use of relocation destination
pointer, so the calculated destination value was applied to
the uninitialized pointer location in error.

Fixes: 17bce3b2ae2d ("x86/callthunks: Handle %rip-relative relocations in call thunk template")
Reported-by: Nathan Chancellor <nathan@kernel.org>
Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Closes: https://lore.kernel.org/lkml/20231201035457.GA321497@dev-arch.thelio-3990X/
Link: https://lore.kernel.org/r/20231201085727.3647051-1-ubizjak@gmail.com
---
 arch/x86/kernel/callthunks.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/callthunks.c b/arch/x86/kernel/callthunks.c
index f56fa30..2324c7f 100644
--- a/arch/x86/kernel/callthunks.c
+++ b/arch/x86/kernel/callthunks.c
@@ -312,7 +312,7 @@ static bool is_callthunk(void *addr)
 	if (!thunks_initialized || skip_addr((void *)dest))
 		return false;
 
-	*pad = dest - tmpl_size;
+	pad = (void *)(dest - tmpl_size);
 
 	memcpy(insn_buff, skl_call_thunk_template, tmpl_size);
 	apply_relocation(insn_buff, tmpl_size, pad,
