Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7502E7D51A1
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 15:22:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343569AbjJXNW5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 09:22:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234487AbjJXNWD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 09:22:03 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55A3119A0;
        Tue, 24 Oct 2023 06:21:07 -0700 (PDT)
Date:   Tue, 24 Oct 2023 13:21:04 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1698153665;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gdUwx0H61gTB8NR9dIpzgdjW5wYXel7BrvBQyLGBxd4=;
        b=tmlkb1/ZrYyd45t1+sB3LFpDtBQfWHfmX/il2lHuxDzYDske6/J0HbluW9QLLhJvSslfZ3
        N1Z9Y1No1KDYOXFENt/5lO0Z6cqkx/iI3iSBf+Y4oV6gPONxXrxjK1/aCN+dK4eXyPZsB4
        kmFlhz4oRoVbN6CPv6lahYq3QOHiM7u89HqU40Yy++hYsmd1p6bRp9Lx/dJqP0bIBLvW+o
        bJGuwASAI6Z/75B1QuMSzCXTC8OerywYx743N3I4+yOWFHD3w8jGUiOafZPjoh4I+FhkKr
        223RMssjmkUSQf4Y3qicNfLhtxsHj2EARRE0Xxcw8WfQpbt+x6ppbVDWsNL5CA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1698153665;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gdUwx0H61gTB8NR9dIpzgdjW5wYXel7BrvBQyLGBxd4=;
        b=f1t9brjflWwWyRmYruCWb4UU55AuuPhl0lnDyAxu6OhHP0toTpEqr9OlDOYBedJQJo+gZO
        M9ucSt5Icm2eOuBg==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/microcode] x86/microcode: Remove pointless apply() invocation
Cc:     "Borislav Petkov (AMD)" <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20231017211723.018821624@linutronix.de>
References: <20231017211723.018821624@linutronix.de>
MIME-Version: 1.0
Message-ID: <169815366429.3135.13131206121862202196.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/microcode branch of tip:

Commit-ID:     b48b26f992a3828b4ae274669f99ce68451d4904
Gitweb:        https://git.kernel.org/tip/b48b26f992a3828b4ae274669f99ce68451d4904
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Tue, 17 Oct 2023 23:23:49 +02:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Tue, 24 Oct 2023 15:05:54 +02:00

x86/microcode: Remove pointless apply() invocation

Microcode is applied on the APs during early bringup. There is no point
in trying to apply the microcode again during the hotplug operations and
neither at the point where the microcode device is initialized.

Collect CPU info and microcode revision in setup_online_cpu() for now.
This will move to the CPU hotplug callback later.

  [ bp: Leave the starting notifier for the following scenario:

    - boot, late load, suspend to disk, resume

    without the starting notifier, only the last core manages to update the
    microcode upon resume:

    # rdmsr -a 0x8b
    10000bf
    10000bf
    10000bf
    10000bf
    10000bf
    10000dc <----

    This is on an AMD F10h machine.

    For the future, one should check whether potential unification of
    the CPU init path could cover the resume path too so that this can
    be simplified even more.

  tglx: This is caused by the odd handling of APs which try to find the
  microcode blob in builtin or initrd instead of caching the microcode
  blob during early init before the APs are brought up. Will be cleaned
  up in a later step. ]

Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20231017211723.018821624@linutronix.de
---
 arch/x86/kernel/cpu/microcode/core.c | 23 ++++++-----------------
 1 file changed, 6 insertions(+), 17 deletions(-)

diff --git a/arch/x86/kernel/cpu/microcode/core.c b/arch/x86/kernel/cpu/microcode/core.c
index 2b742fe..cfc1f7a 100644
--- a/arch/x86/kernel/cpu/microcode/core.c
+++ b/arch/x86/kernel/cpu/microcode/core.c
@@ -487,17 +487,6 @@ static void microcode_fini_cpu(int cpu)
 		microcode_ops->microcode_fini_cpu(cpu);
 }
 
-static enum ucode_state microcode_init_cpu(int cpu)
-{
-	struct ucode_cpu_info *uci = ucode_cpu_info + cpu;
-
-	memset(uci, 0, sizeof(*uci));
-
-	microcode_ops->collect_cpu_info(cpu, &uci->cpu_sig);
-
-	return microcode_ops->apply_microcode(cpu);
-}
-
 /**
  * microcode_bsp_resume - Update boot CPU microcode during resume.
  */
@@ -552,14 +541,14 @@ static int mc_cpu_down_prep(unsigned int cpu)
 static void setup_online_cpu(struct work_struct *work)
 {
 	int cpu = smp_processor_id();
-	enum ucode_state err;
+	struct ucode_cpu_info *uci = ucode_cpu_info + cpu;
 
-	err = microcode_init_cpu(cpu);
-	if (err == UCODE_ERROR) {
-		pr_err("Error applying microcode on CPU%d\n", cpu);
-		return;
-	}
+	memset(uci, 0, sizeof(*uci));
 
+	microcode_ops->collect_cpu_info(cpu, &uci->cpu_sig);
+	cpu_data(cpu).microcode = uci->cpu_sig.rev;
+	if (!cpu)
+		boot_cpu_data.microcode = uci->cpu_sig.rev;
 	mc_cpu_online(cpu);
 }
 
