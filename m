Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F06B7A0297
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 13:28:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237644AbjINL1P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 07:27:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233393AbjINL1J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 07:27:09 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74BDCE3;
        Thu, 14 Sep 2023 04:27:05 -0700 (PDT)
Date:   Thu, 14 Sep 2023 11:27:03 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1694690823;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kf6VRRqhWvA8boUZqcpc/MRGoYGxVjM8NNnYnSRa7uE=;
        b=CFGjwNmpuAEgdme0vO3/8C5kjhVlOdBwx1SCCv3WN9GXKSRctzUa87ktHzkq2LnzkzBUqp
        RaEnxkzgT3zLzCstadjbBb/7YSq0M5fCpyxPyV0GBcnM1lMRkS5hfovlzyLrFuprA7Jtw8
        xjEFw9KxtUwMt835UcKDwb21OAdY5hzweNlh0KJcN8OPqoOK2d3QmB4UvRsjQtOBN3zQ3u
        pm0ux8mUBaViQa1AiyiZIZuPDQzTOjNEmy3henLYyRtUetnQcxcXQwnIGSsFiXCv222aeK
        6QOz19yia53lQLEnophDST1AZdqhLhagsvAuTv1wYGzcYsn0zbGl+m+KYvfPzQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1694690823;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kf6VRRqhWvA8boUZqcpc/MRGoYGxVjM8NNnYnSRa7uE=;
        b=0eR8CZANFYxxd4f1bwmyTDhWKgt7CqauMWpMQBgiO/tpvNHiTxqgfY0Z019FUkyUTd4rQk
        Xuf6jDCnc1h/aBBA==
From:   "tip-bot2 for Nikolay Borisov" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/entry] x86/elf: Make loading of 32bit processes depend on
 ia32_enabled()
Cc:     Nikolay Borisov <nik.borisov@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230623111409.3047467-5-nik.borisov@suse.com>
References: <20230623111409.3047467-5-nik.borisov@suse.com>
MIME-Version: 1.0
Message-ID: <169469082322.27769.6028739507798340170.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/entry branch of tip:

Commit-ID:     5ae2702d7c482edbf002499e23a2e22ac4047af1
Gitweb:        https://git.kernel.org/tip/5ae2702d7c482edbf002499e23a2e22ac4047af1
Author:        Nikolay Borisov <nik.borisov@suse.com>
AuthorDate:    Fri, 23 Jun 2023 14:14:07 +03:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 14 Sep 2023 13:19:53 +02:00

x86/elf: Make loading of 32bit processes depend on ia32_enabled()

Major aspect of ia32 emulation is the ability to load 32bit processes.
That's currently decided (among others) by compat_elf_check_arch().

Make the macro use ia32_enabled() to decide if IA32 compat is
enabled before loading a 32bit process.

Signed-off-by: Nikolay Borisov <nik.borisov@suse.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20230623111409.3047467-5-nik.borisov@suse.com

---
 arch/x86/include/asm/elf.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/elf.h b/arch/x86/include/asm/elf.h
index 18fd06f..a0234df 100644
--- a/arch/x86/include/asm/elf.h
+++ b/arch/x86/include/asm/elf.h
@@ -7,6 +7,7 @@
  */
 #include <linux/thread_info.h>
 
+#include <asm/ia32.h>
 #include <asm/ptrace.h>
 #include <asm/user.h>
 #include <asm/auxvec.h>
@@ -149,7 +150,7 @@ do {						\
 	((x)->e_machine == EM_X86_64)
 
 #define compat_elf_check_arch(x)					\
-	(elf_check_arch_ia32(x) ||					\
+	((elf_check_arch_ia32(x) && ia32_enabled()) ||			\
 	 (IS_ENABLED(CONFIG_X86_X32_ABI) && (x)->e_machine == EM_X86_64))
 
 static inline void elf_common_init(struct thread_struct *t,
