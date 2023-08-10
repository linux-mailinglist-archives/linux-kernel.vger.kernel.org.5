Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 949D777805D
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 20:37:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235706AbjHJShm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 14:37:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235620AbjHJShf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 14:37:35 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FDAE2718
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 11:37:35 -0700 (PDT)
Message-ID: <20230810160805.249932786@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1691692653;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=0JPnaj3cEEDg9kfAdYzRsElPoyj/8+m1dAg/elVKOy0=;
        b=0/fN3PChyKL0HYnGHcp+08GLkN57JlCxlYeEGuIJMBDiB23r1MJsqkAeIJ+aZSp1sCXQuu
        UeStf4apgxKJhhIK+JvokTYTT26VNjy2S1HOiTU02wxhEXxkM4+kVlmNdCZScnwj8b31W5
        gAKCtHsx++AkXk+KTThVhggSWE+kOSGeERIzcX2Fa/Ks1VmSexCOwL2Mv16a+xNAxEFLM5
        OKjqYWnOdtVEoOOFg+JicWt9sZebrC2WYf7XFSHqK7TvJ8Pa5KOGyBN+v6wekV8o8Yalzm
        X4dNVSYdT0RF0f/z0/Oi/j0cV+LPHUGwYGaVhsFC5a/dm+yZaJ6N19N+SU9dvQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1691692653;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=0JPnaj3cEEDg9kfAdYzRsElPoyj/8+m1dAg/elVKOy0=;
        b=axrq3mlyZqJAinbj9uXKy65atjoCuGvHGlwKHxELThzF8q72FBbQnqnAOatGUBANNs7QLV
        f+rWzAVE3MWckBBA==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Borislav Petkov <bp@alien8.de>,
        Ashok Raj <ashok.raj@intel.com>,
        Arjan van de Ven <arjan@linux.intel.com>
Subject: [patch 05/30] x86/microcode: Make reload_early_microcode() static
References: <20230810153317.850017756@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Thu, 10 Aug 2023 20:37:33 +0200 (CEST)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Gleixner <tglx@linutronix.de>

fe055896c040 ("x86/microcode: Merge the early microcode loader") left this
needlessly public. Git archaeology provided by Borislav.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

---
 arch/x86/include/asm/microcode.h     |    2 --
 arch/x86/kernel/cpu/microcode/core.c |    2 +-
 2 files changed, 1 insertion(+), 3 deletions(-)
---
--- a/arch/x86/include/asm/microcode.h
+++ b/arch/x86/include/asm/microcode.h
@@ -128,13 +128,11 @@ static inline unsigned int x86_cpuid_fam
 #ifdef CONFIG_MICROCODE
 extern void __init load_ucode_bsp(void);
 extern void load_ucode_ap(void);
-void reload_early_microcode(unsigned int cpu);
 extern bool initrd_gone;
 void microcode_bsp_resume(void);
 #else
 static inline void __init load_ucode_bsp(void)			{ }
 static inline void load_ucode_ap(void)				{ }
-static inline void reload_early_microcode(unsigned int cpu)	{ }
 static inline void microcode_bsp_resume(void)			{ }
 #endif
 
--- a/arch/x86/kernel/cpu/microcode/core.c
+++ b/arch/x86/kernel/cpu/microcode/core.c
@@ -293,7 +293,7 @@ struct cpio_data find_microcode_in_initr
 #endif
 }
 
-void reload_early_microcode(unsigned int cpu)
+static void reload_early_microcode(unsigned int cpu)
 {
 	int vendor, family;
 

