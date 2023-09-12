Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDFDD79D568
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 17:54:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236471AbjILPy7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 11:54:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236472AbjILPyy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 11:54:54 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 986D610E5;
        Tue, 12 Sep 2023 08:54:50 -0700 (PDT)
Date:   Tue, 12 Sep 2023 15:54:48 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1694534089;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=p1oFME0Jidi+UhsgoJHi2a1vbMzwZWMIBlYUJ39K9aE=;
        b=eNXCYq99ULs6Y60luIxFjl8OvocUbXFYup8bSXjvS4HP/Bse4UCtkBJ4s/Qlb7BfoeP2Ri
        lrQq211O+HKbkxR61+vkY75J7iB17+XXi3JhOMYZCLVnK6BkCiUdBBBoexaduDWJQiVdlw
        PfTifjCSvLA8EY7Ttno/ZGOK4GmF/HR3KlpDn+l3odwsHEFzUKLHh9OdbmbJyQXPXfQJHI
        nO5Mk5hOjtloQxtX7IYq9jpz9IoNKjqer4Q5iT7tW4VzrJtPYfsmHX3wk8sdydERzf8xkE
        IMf3otlldRZZkUUzW8CFZ06l1vi05J0+kpeITtq41e6Z+0Q97la3ESsPsrTQsg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1694534089;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=p1oFME0Jidi+UhsgoJHi2a1vbMzwZWMIBlYUJ39K9aE=;
        b=fIlPD4oX0BS2szKgNnVsgHJ0aUfJAvnsvGa/TchcpVEBLbXG2aSQ6KHFZ/WS9tRmwDDBRa
        34sQuKX43Jr4KkCw==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/ibt: Suppress spurious ENDBR
Cc:     David Kaplan <David.Kaplan@amd.com>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230802110323.016197440@infradead.org>
References: <20230802110323.016197440@infradead.org>
MIME-Version: 1.0
Message-ID: <169453408866.27769.11485253343334355054.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     25e73b7e3f72a25aa30cbb2eecb49036e0acf066
Gitweb:        https://git.kernel.org/tip/25e73b7e3f72a25aa30cbb2eecb49036e0acf066
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Wed, 02 Aug 2023 12:55:46 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 12 Sep 2023 17:50:53 +02:00

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
Reviewed-by: Andrew Cooper <andrew.cooper3@citrix.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
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
