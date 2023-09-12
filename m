Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38A2F79CF78
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 13:09:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234660AbjILLJT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 07:09:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234254AbjILLIn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 07:08:43 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64E371735;
        Tue, 12 Sep 2023 04:08:34 -0700 (PDT)
Date:   Tue, 12 Sep 2023 11:08:32 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1694516913;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LbBprMwnbPPLEsY2vhOkPL097RyL9EsvHkcx1RT2pw4=;
        b=UXmXsl5f1f1WItwXW0rTTAr/bVbnDs93VWND9UG9ktZEPL6QxJ3fQeY6lC8LqVivesT6u6
        uhQtub1Okm7/pmstWO4l5aB+V8WwqVHBFD0qraxFXGLxZdVB20nyKHTgzvS/oyhugNJgXT
        8419RU19e+JKUGprt4MWP+i3MJ+6zoRRHewx067nR+gOd9uB+wSpZZyuCVAuLnA97vtL2R
        YbFICEFmWimb8mKyJddRy6HfP8YoV7FTwTNM20mskxeGppoauHSdQFGxhCn3dp8L17aK8v
        H56F9EEOevpUT4oIM+zsnOOc22HM0Odm1k4r4JlPYcFqWgRBJ/vo1Nq+pt2+Jg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1694516913;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LbBprMwnbPPLEsY2vhOkPL097RyL9EsvHkcx1RT2pw4=;
        b=d0zORbHSTTua6HBsA/I1aQNGUd7sr6j6/WUvmtW+Avjh6Q1QEJjngBR6dmDsduWldqjpOD
        X0qNIJp9dRsVSfBQ==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/ibt: Suppress spurious ENDBR
Cc:     David Kaplan <David.Kaplan@amd.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Andrew Cooper <andrew.cooper3@citrix.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230802110323.016197440@infradead.org>
References: <20230802110323.016197440@infradead.org>
MIME-Version: 1.0
Message-ID: <169451691250.27769.12189082412488879527.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     70524a25365bab3dfe968691aa436fff765a8dde
Gitweb:        https://git.kernel.org/tip/70524a25365bab3dfe968691aa436fff765a8dde
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Wed, 02 Aug 2023 12:55:46 +02:00
Committer:     root <root@noisy.programming.kicks-ass.net>
CommitterDate: Tue, 12 Sep 2023 12:40:28 +02:00

x86/ibt: Suppress spurious ENDBR

It was reported that under certain circumstances GCC emits ENDBR
instructions for _THIS_IP_ usage. Specifically, when it appears at the
start of a basic block -- but not elsewhere.

Since _THIS_IP_ is never used for control flow, these ENDBR
instructions are completely superfluous. Override the _THIS_IP_
definition for x86_64 to avoid this.

Less ENDBR instructions is better.

Fixes: 156ff4a544ae ("x86/ibt: Base IBT bits")
Reported-by: David Kaplan <David.Kaplan@amd.com>
Signed-off-by: "Peter Zijlstra (Intel)" <peterz@infradead.org>
Reviewed-by: Andrew Cooper <andrew.cooper3@citrix.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/20230802110323.016197440@infradead.org
---
 arch/x86/include/asm/linkage.h      | 8 ++++++++
 include/linux/instruction_pointer.h | 5 +++++
 2 files changed, 13 insertions(+)

diff --git a/arch/x86/include/asm/linkage.h b/arch/x86/include/asm/linkage.h
index 97a3de7..5ff49fd 100644
--- a/arch/x86/include/asm/linkage.h
+++ b/arch/x86/include/asm/linkage.h
@@ -8,6 +8,14 @@
 #undef notrace
 #define notrace __attribute__((no_instrument_function))
 
+#ifdef CONFIG_64BIT
+/*
+ * The generic version tends to create spurious ENDBR instructions under
+ * certain conditions.
+ */
+#define _THIS_IP_ ({ unsigned long __here; asm ("lea 0(%%rip), %0" : "=r" (__here)); __here; })
+#endif
+
 #ifdef CONFIG_X86_32
 #define asmlinkage CPP_ASMLINKAGE __attribute__((regparm(0)))
 #endif /* CONFIG_X86_32 */
diff --git a/include/linux/instruction_pointer.h b/include/linux/instruction_pointer.h
index cda1f70..aa0b3ff 100644
--- a/include/linux/instruction_pointer.h
+++ b/include/linux/instruction_pointer.h
@@ -2,7 +2,12 @@
 #ifndef _LINUX_INSTRUCTION_POINTER_H
 #define _LINUX_INSTRUCTION_POINTER_H
 
+#include <asm/linkage.h>
+
 #define _RET_IP_		(unsigned long)__builtin_return_address(0)
+
+#ifndef _THIS_IP_
 #define _THIS_IP_  ({ __label__ __here; __here: (unsigned long)&&__here; })
+#endif
 
 #endif /* _LINUX_INSTRUCTION_POINTER_H */
