Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7A457B2737
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 23:11:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232326AbjI1VLv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 17:11:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232416AbjI1VLr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 17:11:47 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03AFECD7;
        Thu, 28 Sep 2023 14:11:44 -0700 (PDT)
Date:   Thu, 28 Sep 2023 21:11:43 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1695935503;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=U2Te0Ehq1sOf3rHkrQLmrN1+rshPRVWPdcTNxhnaR3c=;
        b=gbmBwInlV4KweySF5R8dtYpzqdbbmgb3MYwV/OyCcqSIUgBDudqomquWO0mfNGwcfQqto1
        fvso8U3K36pXJJhQ7DcWXztQsIoBiVtf1W5JmEL4ghb9sGVxTJqotj8uTe/m3vf5KcXiJ9
        YPN7V0+l7Yhehjg5JC22/2TzIxeqTg+Wjki/tRfPOHl8G+/EX/hmFQnj2u4fzaqW/zq7gV
        jI6kMzvORnI6by55/OsCarEEBFXH59zdGouLhg+AV6yNmPR4ZtCmjbbYzlp8F+uvp8451x
        WBS+0KTuLtwDqPP2ed/OoOTTEin4QeVXyIMPxVv9h0q5qTSZhixJb0rkPsmRMg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1695935503;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=U2Te0Ehq1sOf3rHkrQLmrN1+rshPRVWPdcTNxhnaR3c=;
        b=4PkkHED72mxpiOppzEPfjnGajLJVOMismn6k4NrjKT8Wuq/WOqpEyDlM8uUDD5JjCHBBzt
        u8xOVOIUxswp9dCg==
From:   "tip-bot2 for Adam Dunlap" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/mm] x86/sev-es: Set x86_virt_bits to the correct value
 straight away, instead of a two-phase approach
Cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        Adam Dunlap <acdunlap@google.com>,
        Ingo Molnar <mingo@kernel.org>, Jacob Xu <jacobhxu@google.com>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20230912002703.3924521-3-acdunlap@google.com>
References: <20230912002703.3924521-3-acdunlap@google.com>
MIME-Version: 1.0
Message-ID: <169593550300.27769.9551262175239448293.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/mm branch of tip:

Commit-ID:     fbf6449f84bf5e4ad09f2c09ee70ed7d629b5ff6
Gitweb:        https://git.kernel.org/tip/fbf6449f84bf5e4ad09f2c09ee70ed7d629b5ff6
Author:        Adam Dunlap <acdunlap@google.com>
AuthorDate:    Mon, 11 Sep 2023 17:27:03 -07:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Thu, 28 Sep 2023 22:49:35 +02:00

x86/sev-es: Set x86_virt_bits to the correct value straight away, instead of a two-phase approach

Instead of setting x86_virt_bits to a possibly-correct value and then
correcting it later, do all the necessary checks before setting it.

At this point, the #VC handler references boot_cpu_data.x86_virt_bits,
and in the previous version, it would be triggered by the CPUIDs between
the point at which it is set to 48 and when it is set to the correct
value.

Suggested-by: Dave Hansen <dave.hansen@linux.intel.com>
Signed-off-by: Adam Dunlap <acdunlap@google.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Tested-by: Jacob Xu <jacobhxu@google.com>
Link: https://lore.kernel.org/r/20230912002703.3924521-3-acdunlap@google.com
---
 arch/x86/kernel/cpu/common.c | 37 ++++++++++++++++++++---------------
 1 file changed, 22 insertions(+), 15 deletions(-)

diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index 382d4e6..8d7063e 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -1114,17 +1114,32 @@ void get_cpu_cap(struct cpuinfo_x86 *c)
 void get_cpu_address_sizes(struct cpuinfo_x86 *c)
 {
 	u32 eax, ebx, ecx, edx;
+	bool vp_bits_from_cpuid = true;
 
-	if (c->extended_cpuid_level >= 0x80000008) {
+	if (!cpu_has(c, X86_FEATURE_CPUID) ||
+	    (c->extended_cpuid_level < 0x80000008))
+		vp_bits_from_cpuid = false;
+
+	if (vp_bits_from_cpuid) {
 		cpuid(0x80000008, &eax, &ebx, &ecx, &edx);
 
 		c->x86_virt_bits = (eax >> 8) & 0xff;
 		c->x86_phys_bits = eax & 0xff;
+	} else {
+		if (IS_ENABLED(CONFIG_X86_64)) {
+			c->x86_clflush_size = 64;
+			c->x86_phys_bits = 36;
+			c->x86_virt_bits = 48;
+		} else {
+			c->x86_clflush_size = 32;
+			c->x86_virt_bits = 32;
+			c->x86_phys_bits = 32;
+
+			if (cpu_has(c, X86_FEATURE_PAE) ||
+			    cpu_has(c, X86_FEATURE_PSE36))
+				c->x86_phys_bits = 36;
+		}
 	}
-#ifdef CONFIG_X86_32
-	else if (cpu_has(c, X86_FEATURE_PAE) || cpu_has(c, X86_FEATURE_PSE36))
-		c->x86_phys_bits = 36;
-#endif
 	c->x86_cache_bits = c->x86_phys_bits;
 }
 
@@ -1579,15 +1594,6 @@ static void __init cpu_parse_early_param(void)
  */
 static void __init early_identify_cpu(struct cpuinfo_x86 *c)
 {
-#ifdef CONFIG_X86_64
-	c->x86_clflush_size = 64;
-	c->x86_phys_bits = 36;
-	c->x86_virt_bits = 48;
-#else
-	c->x86_clflush_size = 32;
-	c->x86_phys_bits = 32;
-	c->x86_virt_bits = 32;
-#endif
 	c->x86_cache_alignment = c->x86_clflush_size;
 
 	memset(&c->x86_capability, 0, sizeof(c->x86_capability));
@@ -1601,7 +1607,6 @@ static void __init early_identify_cpu(struct cpuinfo_x86 *c)
 		cpu_detect(c);
 		get_cpu_vendor(c);
 		get_cpu_cap(c);
-		get_cpu_address_sizes(c);
 		setup_force_cpu_cap(X86_FEATURE_CPUID);
 		cpu_parse_early_param();
 
@@ -1617,6 +1622,8 @@ static void __init early_identify_cpu(struct cpuinfo_x86 *c)
 		setup_clear_cpu_cap(X86_FEATURE_CPUID);
 	}
 
+	get_cpu_address_sizes(c);
+
 	setup_force_cpu_cap(X86_FEATURE_ALWAYS);
 
 	cpu_set_bug_bits(c);
