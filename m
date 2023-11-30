Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 322857FFD60
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 22:16:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376913AbjK3VQf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 16:16:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376851AbjK3VQ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 16:16:27 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF4B4C4;
        Thu, 30 Nov 2023 13:16:33 -0800 (PST)
Date:   Thu, 30 Nov 2023 21:16:31 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1701378992;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VhWz3VZ/wxhJ6SUUEHoXbRcnWDzveXaRiWv2PlqBIwM=;
        b=zMH9ERIkkUzKp1cm8wDSSvWURBYzetOMEjn1X/sahR4ZPhOSqBC0jpJq8VdJQeri45/CzN
        0pF6MI53aLRDsu1mTQk/oEyJszy1rJWFWZDRytkLwCvPrTsCoWcb6VG+tTsjOxPJqD2qwT
        NudSJZ/oXLH8FwdcgBBWiBPKF/sF6jUodTtOe5FWuBwltWkBFdQBkNWaksvENs+iuRpROC
        qmKtuwjAdV1mnNVSt14s7E1tgG+T1+oCMWU4O2PLBffgUelERzCO59o5GFEOmXu3qP15rm
        KntRo/d8ysUKZ6XaajuTq2T7gxAxkO8npdqdxv8I8sSoOb0+eANR+fnlx84ivg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1701378992;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VhWz3VZ/wxhJ6SUUEHoXbRcnWDzveXaRiWv2PlqBIwM=;
        b=F+VNUuuAMRy8rpf3/KtBYurYFgcbfck5k30h7l5B3NeTBE8XTC7bXFk2i/osFsKszXkMeb
        P3vuO4IBjRrrUnAA==
From:   "tip-bot2 for Uros Bizjak" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/percpu] x86/acpi: Use %rip-relative addressing in wakeup_64.S
Cc:     Uros Bizjak <ubizjak@gmail.com>, Ingo Molnar <mingo@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20231103104900.409470-1-ubizjak@gmail.com>
References: <20231103104900.409470-1-ubizjak@gmail.com>
MIME-Version: 1.0
Message-ID: <170137899159.398.1084765322792442893.tip-bot2@tip-bot2>
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

Commit-ID:     0978d64f9406122c369d5f46e1eb855646f6c32c
Gitweb:        https://git.kernel.org/tip/0978d64f9406122c369d5f46e1eb855646f6c32c
Author:        Uros Bizjak <ubizjak@gmail.com>
AuthorDate:    Fri, 03 Nov 2023 11:48:22 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Thu, 30 Nov 2023 20:09:49 +01:00

x86/acpi: Use %rip-relative addressing in wakeup_64.S

This is a "nice-to-have" change with minor code generation benefits:

 - Instruction with %rip-relative address operand is one byte shorter than
   its absolute address counterpart,

 - it is also compatible with position independent executable (-fpie) builds,

 - it is also consistent with what the compiler emits by default when
   a symbol is accessed.

No functional changes intended.

Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Acked-by: Rafael J. Wysocki <rafael@kernel.org>
Link: https://lore.kernel.org/r/20231103104900.409470-1-ubizjak@gmail.com
---
 arch/x86/kernel/acpi/wakeup_64.S | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/arch/x86/kernel/acpi/wakeup_64.S b/arch/x86/kernel/acpi/wakeup_64.S
index d5d8a35..94ff83f 100644
--- a/arch/x86/kernel/acpi/wakeup_64.S
+++ b/arch/x86/kernel/acpi/wakeup_64.S
@@ -17,7 +17,7 @@
 	 * Hooray, we are in Long 64-bit mode (but still running in low memory)
 	 */
 SYM_FUNC_START(wakeup_long64)
-	movq	saved_magic, %rax
+	movq	saved_magic(%rip), %rax
 	movq	$0x123456789abcdef0, %rdx
 	cmpq	%rdx, %rax
 	je	2f
@@ -33,14 +33,14 @@ SYM_FUNC_START(wakeup_long64)
 	movw	%ax, %es
 	movw	%ax, %fs
 	movw	%ax, %gs
-	movq	saved_rsp, %rsp
+	movq	saved_rsp(%rip), %rsp
 
-	movq	saved_rbx, %rbx
-	movq	saved_rdi, %rdi
-	movq	saved_rsi, %rsi
-	movq	saved_rbp, %rbp
+	movq	saved_rbx(%rip), %rbx
+	movq	saved_rdi(%rip), %rdi
+	movq	saved_rsi(%rip), %rsi
+	movq	saved_rbp(%rip), %rbp
 
-	movq	saved_rip, %rax
+	movq	saved_rip(%rip), %rax
 	ANNOTATE_RETPOLINE_SAFE
 	jmp	*%rax
 SYM_FUNC_END(wakeup_long64)
@@ -72,11 +72,11 @@ SYM_FUNC_START(do_suspend_lowlevel)
 
 	movq	$.Lresume_point, saved_rip(%rip)
 
-	movq	%rsp, saved_rsp
-	movq	%rbp, saved_rbp
-	movq	%rbx, saved_rbx
-	movq	%rdi, saved_rdi
-	movq	%rsi, saved_rsi
+	movq	%rsp, saved_rsp(%rip)
+	movq	%rbp, saved_rbp(%rip)
+	movq	%rbx, saved_rbx(%rip)
+	movq	%rdi, saved_rdi(%rip)
+	movq	%rsi, saved_rsi(%rip)
 
 	addq	$8, %rsp
 	movl	$3, %edi
