Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D8237B9F8C
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 16:26:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232620AbjJEOZ2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 10:25:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234684AbjJEOX3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 10:23:29 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F1DE8A6C;
        Thu,  5 Oct 2023 01:28:38 -0700 (PDT)
Date:   Thu, 05 Oct 2023 08:28:34 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1696494515;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YucGbdDF5rXO/3LM0GhuKq1HGZTiO+P+5WGnwqeqkWc=;
        b=KsQC+GbW79cK3JhmCtjPnfqphoYRUUFj+lUm5sXyJqJyGlwoltq0GfUfhRwuEqhBbPqLGj
        oslcsESJ1GavS85ZOBYwwuPA7dWXZTtzfX+rqcLHmMGEn7wDIpkqOkV2EVXYOlx5lMw8mT
        jjmEnlD6dmVA9OkKr0xMWwahoScoQQ/lweVJYbWt5rLQROT6hcir2n0Cr8OneM35Q04BHa
        nCq+mdsWFHirw8PUuFXIOQw8hPkSPQaOq9Mp8q57kVMiLZSFkmgm/MapCK3qbLvrpQ1KIy
        Cclq+1ZxwctvHIwjOVTyBnDYK5kvSjqsBkyYbzK1TXByZLtwgdZq/ZAr+V+D0g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1696494515;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YucGbdDF5rXO/3LM0GhuKq1HGZTiO+P+5WGnwqeqkWc=;
        b=PmMYqEeFlhABGsF/RA8/HefHZ6+uYUPvHk/SCr/feYCXzsZZ/glMJKNa8L0qkBt2vFVhzF
        RD6DrKTiLEEXwgBQ==
From:   "tip-bot2 for Brian Gerst" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/entry] x86/entry/32: Remove SEP test for SYSEXIT
Cc:     Brian Gerst <brgerst@gmail.com>, Ingo Molnar <mingo@kernel.org>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20230721161018.50214-6-brgerst@gmail.com>
References: <20230721161018.50214-6-brgerst@gmail.com>
MIME-Version: 1.0
Message-ID: <169649451472.3135.6242296709533472348.tip-bot2@tip-bot2>
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

Commit-ID:     bab9fa6dc5e4483749838877deebe038de3ce97e
Gitweb:        https://git.kernel.org/tip/bab9fa6dc5e4483749838877deebe038de3ce97e
Author:        Brian Gerst <brgerst@gmail.com>
AuthorDate:    Fri, 21 Jul 2023 12:10:16 -04:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Thu, 05 Oct 2023 10:06:43 +02:00

x86/entry/32: Remove SEP test for SYSEXIT

SEP must be already be present in order for do_fast_syscall_32() to be
called on native 32-bit, so checking it again is unnecessary.

Signed-off-by: Brian Gerst <brgerst@gmail.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20230721161018.50214-6-brgerst@gmail.com
---
 arch/x86/entry/common.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/x86/entry/common.c b/arch/x86/entry/common.c
index f1f3bf1..0551bcb 100644
--- a/arch/x86/entry/common.c
+++ b/arch/x86/entry/common.c
@@ -238,8 +238,7 @@ __visible noinstr bool do_fast_syscall_32(struct pt_regs *regs)
 	 * We don't allow syscalls at all from VM86 mode, but we still
 	 * need to check VM, because we might be returning from sys_vm86.
 	 */
-	return static_cpu_has(X86_FEATURE_SEP) &&
-		regs->cs == __USER_CS && regs->ss == __USER_DS &&
+	return regs->cs == __USER_CS && regs->ss == __USER_DS &&
 		regs->ip == landing_pad &&
 		(regs->flags & (X86_EFLAGS_RF | X86_EFLAGS_TF | X86_EFLAGS_VM)) == 0;
 #endif
