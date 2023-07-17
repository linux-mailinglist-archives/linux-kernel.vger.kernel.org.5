Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08D5475704C
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 01:14:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231267AbjGQXOq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 19:14:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230219AbjGQXOo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 19:14:44 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 504CF10B
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 16:14:38 -0700 (PDT)
Message-ID: <20230717223223.133987570@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1689635675;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=M0jSiCsQ7CMtXtLpUe8NnWl6LgxPIdT2LQPqXY/B010=;
        b=ERBnEIn79Bu9QSKIoMn+fHdK4gIfX8KEiTmh8bJE5iNHtOcSS3NkSFTc3RZ9wQTc+ZVw9O
        SIUDyRXPWb/iERKMUtrU1NWucmjEASGwGp0XcRWJVpREbAm1ftrSAdFRyOkFrQ0MVgL99s
        Lcncxdpx2p16ogw8Kr/7+DET0U9sW7ILHBUgpKXhhsxKgAdx81lvKLX8oFMxxrw2SWqQAD
        V+u40tZiRwS0Av9AZppWlIrYOQCLLNit/kzeF5O7eq3d8+32O4IM8kwA6N8ra//WOBlPKx
        Yl8u536+11Z6SaynRB1HN4M5LwdMe721i+WMfbXN9bZH4wAFOA9b1cGx9EgKSw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1689635675;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=M0jSiCsQ7CMtXtLpUe8NnWl6LgxPIdT2LQPqXY/B010=;
        b=0FkHf1ads7F4traM8giao9RtwB8UYif28wOFycU0DCs5KlpAQXiirEv68DhTAkL9tSiOiP
        SYJTc5IDenMcAvBg==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Wei Liu <wei.liu@kernel.org>,
        Arjan van de Ven <arjan@linux.intel.com>,
        Juergen Gross <jgross@suse.com>
Subject: [patch 01/58] x86/cpu: Make identify_boot_cpu() static
References: <20230717223049.327865981@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Tue, 18 Jul 2023 01:14:35 +0200 (CEST)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It's not longer used outside the source file.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/include/asm/processor.h |    1 -
 arch/x86/kernel/cpu/common.c     |    2 +-
 2 files changed, 1 insertion(+), 2 deletions(-)

--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -190,7 +190,6 @@ static inline unsigned long long l1tf_pf
 }
 
 extern void early_cpu_init(void);
-extern void identify_boot_cpu(void);
 extern void identify_secondary_cpu(struct cpuinfo_x86 *);
 extern void print_cpu_info(struct cpuinfo_x86 *);
 void print_cpu_msr(struct cpuinfo_x86 *);
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -1937,7 +1937,7 @@ void enable_sep_cpu(void)
 }
 #endif
 
-void __init identify_boot_cpu(void)
+static __init void identify_boot_cpu(void)
 {
 	identify_cpu(&boot_cpu_data);
 	if (HAS_KERNEL_IBT && cpu_feature_enabled(X86_FEATURE_IBT))

