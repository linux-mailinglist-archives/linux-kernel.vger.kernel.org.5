Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF1F27FFD57
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 22:16:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376842AbjK3VQ1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 16:16:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376829AbjK3VQ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 16:16:26 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC40DC4;
        Thu, 30 Nov 2023 13:16:31 -0800 (PST)
Date:   Thu, 30 Nov 2023 21:16:28 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1701378989;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PtG/pJNQ7Od6jW99MrxTBwU7p8L9C5Q2DPh/DamRQNY=;
        b=2gelQeEcnPGYDIKblA3e0q2C3luQCLUh8zslN9yEdngo/cHsxyIO1q1fAGiI93xkmjvLdG
        RJyt18grKlYW+PO+Ws/NRoKKODfFF3q/34grzfTlBh8gt7XDfRo3RDX+3eSMWhAamy4vLN
        pQtethRjqdhdk4JIWBRnbwC0A5QsGb2k5jKVqt0RmTEm3iL1b3PE1VyGpD4NT66Kd/Pw2y
        j0eMTRk7CVGyJNW3UR/vJsTpjCskgVMjASXnRO0x6RVlvYaqS3OXuAg7oe26bxvtfIONVu
        8xgSwsgkYNjckaqWkWG9v7u/R9SGs9NDa42b8SYC3T6nztACB4B7vpyu7DFYpw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1701378989;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PtG/pJNQ7Od6jW99MrxTBwU7p8L9C5Q2DPh/DamRQNY=;
        b=UOv04alInXHYPKlrEmzLQUaWcsmSx+/WpEfbSE2S/3meQjCAvXJkUCpMMCXoGm3CAdMdCQ
        1C/Uk3RTm0RHa8CA==
From:   "tip-bot2 for Uros Bizjak" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/percpu] x86/smp: Use atomic_try_cmpxchg in native_stop_other_cpus()
Cc:     Uros Bizjak <ubizjak@gmail.com>, Ingo Molnar <mingo@kernel.org>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20231123203605.3474745-2-ubizjak@gmail.com>
References: <20231123203605.3474745-2-ubizjak@gmail.com>
MIME-Version: 1.0
Message-ID: <170137898888.398.2140410650044568209.tip-bot2@tip-bot2>
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

Commit-ID:     9e9d673b2c84719937db5d6ab1d8cbcd7d45e974
Gitweb:        https://git.kernel.org/tip/9e9d673b2c84719937db5d6ab1d8cbcd7d45e974
Author:        Uros Bizjak <ubizjak@gmail.com>
AuthorDate:    Thu, 23 Nov 2023 21:34:23 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Thu, 30 Nov 2023 20:25:09 +01:00

x86/smp: Use atomic_try_cmpxchg in native_stop_other_cpus()

Use atomic_try_cmpxchg() instead of atomic_cmpxchg(*ptr, old, new) == old.

X86 CMPXCHG instruction returns success in ZF flag, so this change saves a
compare after the CMPXCHG.

Tested by building a native Fedora-38 kernel and rebooting
a 12-way SMP system using "shutdown -r" command some 100 times.

No functional change intended.

Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20231123203605.3474745-2-ubizjak@gmail.com
---
 arch/x86/kernel/smp.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/smp.c b/arch/x86/kernel/smp.c
index 65dd44e..1bb7952 100644
--- a/arch/x86/kernel/smp.c
+++ b/arch/x86/kernel/smp.c
@@ -148,15 +148,16 @@ static int register_stop_handler(void)
 
 static void native_stop_other_cpus(int wait)
 {
-	unsigned int this_cpu;
+	unsigned int old_cpu, this_cpu;
 	unsigned long flags, timeout;
 
 	if (reboot_force)
 		return;
 
 	/* Only proceed if this is the first CPU to reach this code */
+	old_cpu = -1;
 	this_cpu = smp_processor_id();
-	if (atomic_cmpxchg(&stopping_cpu, -1, this_cpu) != -1)
+	if (!atomic_try_cmpxchg(&stopping_cpu, &old_cpu, this_cpu))
 		return;
 
 	/* For kexec, ensure that offline CPUs are out of MWAIT and in HLT */
