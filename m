Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B9CA7D0ED8
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 13:40:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377427AbjJTLkZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 07:40:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377292AbjJTLj5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 07:39:57 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8600110EF;
        Fri, 20 Oct 2023 04:38:28 -0700 (PDT)
Date:   Fri, 20 Oct 2023 11:37:57 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1697801878;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AZcNLxKeb32JyJPRq2x/CTuJGV0ABU/61W1t5tr23c8=;
        b=q0Un3Q1615mjy87usfabxnmfLoIopEfb/CZ2H21q0i5hmDrqJcc08qsdkDs1TYnFXdLPel
        +naRKOdwmBrBoNI8GYUOfMmrx/5iMQXchWI/pP28jGPGADp5cxidZwiJNq4NOcnmiKhZCR
        9OUB3aCCGhe+CctC4dQNWQxpSbVFAAwhF+oZuJk/jpvcCEi4j/7FwsJv/36ezWJheiUeN/
        jgzX1WBMnCd82ZaheXSz7Wd4FJPKPLzCvj5jO/+HLQuls6s4O/7woCLf/t+hfD28jAkrdS
        WEwkYJnO4kZs6y1F71V3234uBBHRrQ5XFI8Cno4tlhQBlC3JBV2JTNHSKmzkag==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1697801878;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AZcNLxKeb32JyJPRq2x/CTuJGV0ABU/61W1t5tr23c8=;
        b=lggB6MI+YS+gpxGDXVQ0sFKdx3kfGJGk3Ff05/kkOfQJ+CBRbVW04OybhwkFP912oGLpOJ
        Ezn2CQgDF35mmgCg==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/microcode] x86/microcode/intel: Reuse intel_cpu_collect_info()
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        "Borislav Petkov (AMD)" <bp@alien8.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20231002115902.741173606@linutronix.de>
References: <20231002115902.741173606@linutronix.de>
MIME-Version: 1.0
Message-ID: <169780187740.3135.15267123687598374991.tip-bot2@tip-bot2>
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

Commit-ID:     c7ebbcef2052ac09e4fb511926c7275b96d3cc1c
Gitweb:        https://git.kernel.org/tip/c7ebbcef2052ac09e4fb511926c7275b96d3cc1c
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Mon, 02 Oct 2023 13:59:49 +02:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Thu, 19 Oct 2023 14:28:03 +02:00

x86/microcode/intel: Reuse intel_cpu_collect_info()

No point for an almost duplicate function.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/r/20231002115902.741173606@linutronix.de
---
 arch/x86/kernel/cpu/microcode/intel.c | 16 +---------------
 1 file changed, 1 insertion(+), 15 deletions(-)

diff --git a/arch/x86/kernel/cpu/microcode/intel.c b/arch/x86/kernel/cpu/microcode/intel.c
index 4e5a88d..134df28 100644
--- a/arch/x86/kernel/cpu/microcode/intel.c
+++ b/arch/x86/kernel/cpu/microcode/intel.c
@@ -419,21 +419,7 @@ void reload_ucode_intel(void)
 
 static int collect_cpu_info(int cpu_num, struct cpu_signature *csig)
 {
-	struct cpuinfo_x86 *c = &cpu_data(cpu_num);
-	unsigned int val[2];
-
-	memset(csig, 0, sizeof(*csig));
-
-	csig->sig = cpuid_eax(0x00000001);
-
-	if ((c->x86_model >= 5) || (c->x86 > 6)) {
-		/* get processor flags from MSR 0x17 */
-		rdmsr(MSR_IA32_PLATFORM_ID, val[0], val[1]);
-		csig->pf = 1 << ((val[1] >> 18) & 7);
-	}
-
-	csig->rev = c->microcode;
-
+	intel_collect_cpu_info(csig);
 	return 0;
 }
 
