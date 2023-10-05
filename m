Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 867867BA52E
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 18:15:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241343AbjJEQOQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 12:14:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238453AbjJEQMW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 12:12:22 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7215E8A6B;
        Thu,  5 Oct 2023 01:28:38 -0700 (PDT)
Date:   Thu, 05 Oct 2023 08:28:36 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1696494516;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kQYKZeQP8pm0NjRWo5780Kw8NMCt/BBjxkH5yR+PxPw=;
        b=kbiPrJx1bvBuyseYnFTGoQF+55CE9AnAKQB+xVEo1EYYhegUW8amTYnZlKbtzhpGRfszSX
        fJhdsdyElQX8umq5olyDov7OyILJN6eqxX+3JdpVq9uSfM5RniKcNzVQRwz5sFPpXRwGRK
        Ubh5MiXs5tlO16hfCoTi0IsGgt8jejoTLbyu5EZBN2xssSoj0aXDBWEf5tZ1NxIXZ1FJAr
        ricHYpoYKiad6N6CjreWVhTqyHVnIF1HeW8X1Wc5Z27uIQnuyit8Qy6FhEkCQjl11ZWHTc
        LWx6k9JV0VAdfjmMZbraD9rg4d3luieqeCZ9c9tdubx5lUsYX+bv8TFjNyOTVw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1696494516;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kQYKZeQP8pm0NjRWo5780Kw8NMCt/BBjxkH5yR+PxPw=;
        b=LrXa3UOustYww++UDMFKZ7OOPP9T2KHeEkE8fDsMWEskHaKxs4s2b80JSp56A56MJIboA+
        V6m+6P0Pv3Po8ECg==
From:   "tip-bot2 for Brian Gerst" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/entry] x86/entry/compat: Combine return value test from
 syscall handler
Cc:     Brian Gerst <brgerst@gmail.com>, Ingo Molnar <mingo@kernel.org>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20230721161018.50214-4-brgerst@gmail.com>
References: <20230721161018.50214-4-brgerst@gmail.com>
MIME-Version: 1.0
Message-ID: <169649451603.3135.3339730852325076665.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/entry branch of tip:

Commit-ID:     eec62f61e134d6711f98d4005c6439f24d03d54f
Gitweb:        https://git.kernel.org/tip/eec62f61e134d6711f98d4005c6439f24d03d54f
Author:        Brian Gerst <brgerst@gmail.com>
AuthorDate:    Fri, 21 Jul 2023 12:10:14 -04:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Thu, 05 Oct 2023 10:06:42 +02:00

x86/entry/compat: Combine return value test from syscall handler

Move the sysret32_from_system_call label to remove a duplicate test of
the return value from the syscall handler.

Signed-off-by: Brian Gerst <brgerst@gmail.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20230721161018.50214-4-brgerst@gmail.com
---
 arch/x86/entry/entry_64_compat.S |  9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/arch/x86/entry/entry_64_compat.S b/arch/x86/entry/entry_64_compat.S
index 7015029..b162723 100644
--- a/arch/x86/entry/entry_64_compat.S
+++ b/arch/x86/entry/entry_64_compat.S
@@ -118,9 +118,6 @@ SYM_INNER_LABEL(entry_SYSENTER_compat_after_hwframe, SYM_L_GLOBAL)
 
 	movq	%rsp, %rdi
 	call	do_SYSENTER_32
-	/* XEN PV guests always use IRET path */
-	ALTERNATIVE "testl %eax, %eax; jz swapgs_restore_regs_and_return_to_usermode", \
-		    "jmp swapgs_restore_regs_and_return_to_usermode", X86_FEATURE_XENPV
 	jmp	sysret32_from_system_call
 
 .Lsysenter_fix_flags:
@@ -212,13 +209,15 @@ SYM_INNER_LABEL(entry_SYSCALL_compat_after_hwframe, SYM_L_GLOBAL)
 
 	movq	%rsp, %rdi
 	call	do_fast_syscall_32
+
+sysret32_from_system_call:
 	/* XEN PV guests always use IRET path */
 	ALTERNATIVE "testl %eax, %eax; jz swapgs_restore_regs_and_return_to_usermode", \
 		    "jmp swapgs_restore_regs_and_return_to_usermode", X86_FEATURE_XENPV
 
-	/* Opportunistic SYSRET */
-sysret32_from_system_call:
 	/*
+	 * Opportunistic SYSRET
+	 *
 	 * We are not going to return to userspace from the trampoline
 	 * stack. So let's erase the thread stack right now.
 	 */
