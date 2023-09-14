Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADFFB7A029B
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 13:28:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237868AbjINL1W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 07:27:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236561AbjINL1K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 07:27:10 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B158FE3;
        Thu, 14 Sep 2023 04:27:06 -0700 (PDT)
Date:   Thu, 14 Sep 2023 11:27:04 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1694690825;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8HdXGUSJKQbHfnEXB2jRQSQa/65gSLcEGBjb3RqZL44=;
        b=1LQNxdTUjWiGLgXQlkJET2MljmbHWE2l+akz8PrlfepF7/AFpIhjxUM79f8GyTw9TLxCYt
        fBVNnOMgm3o3TO+7fWULi76C6BhihZ4pJFT7gEXiDviraxm0cUBB22JmLM7TwR61WFWkEn
        Y39fwBnH/JyKU1uBA5gOF1CA56ndP4QQydVmB1IuZT+ZgMhs4kwQ3nHr55Rt4QDGsV3gWi
        zGvBIB73QsQ81clCDqpRZuU6wjiTEaBNk9IPVNWQODMs7AwMsEY23eKveemOgbxu31d37h
        g6VpdaKJKANwyyvW6cLdSUFhr3JKYkfH1HNnTE4Y0h9EfwUtMvr4YWz8vq/KFw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1694690825;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8HdXGUSJKQbHfnEXB2jRQSQa/65gSLcEGBjb3RqZL44=;
        b=lgtKJaclaFfIvSNdckQgY2lL9LItv259m5pg+Hl4jZnVgm+gIiADyLvPOwSgbiYyp3RZFk
        C75nuh/7EnARaWAQ==
From:   "tip-bot2 for Nikolay Borisov" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/entry] x86: Introduce ia32_enabled()
Cc:     Nikolay Borisov <nik.borisov@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230623111409.3047467-2-nik.borisov@suse.com>
References: <20230623111409.3047467-2-nik.borisov@suse.com>
MIME-Version: 1.0
Message-ID: <169469082483.27769.779107571531413575.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/entry branch of tip:

Commit-ID:     1da5c9bc119d3a749b519596b93f9b2667e93c4a
Gitweb:        https://git.kernel.org/tip/1da5c9bc119d3a749b519596b93f9b2667e93c4a
Author:        Nikolay Borisov <nik.borisov@suse.com>
AuthorDate:    Fri, 23 Jun 2023 14:14:04 +03:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 14 Sep 2023 13:19:53 +02:00

x86: Introduce ia32_enabled()

IA32 support on 64bit kernels depends on whether CONFIG_IA32_EMULATION
is selected or not. As it is a compile time option it doesn't
provide the flexibility to have distributions set their own policy for
IA32 support and give the user the flexibility to override it.

As a first step introduce ia32_enabled() which abstracts whether IA32
compat is turned on or off. Upcoming patches will implement
the ability to set IA32 compat state at boot time.

Signed-off-by: Nikolay Borisov <nik.borisov@suse.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20230623111409.3047467-2-nik.borisov@suse.com

---
 arch/x86/entry/common.c     |  4 ++++
 arch/x86/include/asm/ia32.h | 16 +++++++++++++++-
 2 files changed, 19 insertions(+), 1 deletion(-)

diff --git a/arch/x86/entry/common.c b/arch/x86/entry/common.c
index 6c28264..cfbd3ae 100644
--- a/arch/x86/entry/common.c
+++ b/arch/x86/entry/common.c
@@ -96,6 +96,10 @@ static __always_inline int syscall_32_enter(struct pt_regs *regs)
 	return (int)regs->orig_ax;
 }
 
+#ifdef CONFIG_IA32_EMULATION
+bool __ia32_enabled __ro_after_init = true;
+#endif
+
 /*
  * Invoke a 32-bit syscall.  Called with IRQs on in CONTEXT_KERNEL.
  */
diff --git a/arch/x86/include/asm/ia32.h b/arch/x86/include/asm/ia32.h
index fada857..5a2ae24 100644
--- a/arch/x86/include/asm/ia32.h
+++ b/arch/x86/include/asm/ia32.h
@@ -68,6 +68,20 @@ extern void ia32_pick_mmap_layout(struct mm_struct *mm);
 
 #endif
 
-#endif /* CONFIG_IA32_EMULATION */
+extern bool __ia32_enabled;
+
+static inline bool ia32_enabled(void)
+{
+	return __ia32_enabled;
+}
+
+#else /* !CONFIG_IA32_EMULATION */
+
+static inline bool ia32_enabled(void)
+{
+	return IS_ENABLED(CONFIG_X86_32);
+}
+
+#endif
 
 #endif /* _ASM_X86_IA32_H */
