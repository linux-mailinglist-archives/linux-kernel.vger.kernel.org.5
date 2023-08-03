Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5440276EEE4
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 17:59:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237315AbjHCP7c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 11:59:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237271AbjHCP7T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 11:59:19 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E536119;
        Thu,  3 Aug 2023 08:59:18 -0700 (PDT)
Date:   Thu, 03 Aug 2023 15:59:15 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1691078356;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zKBJ1Mftgu7rnvcKZd3VnHGaq1AMQ1K5u82pzJNkbX8=;
        b=KjS+DcOCDXCVy6XOvAk5XB3F6+sj39W9P+4cdwZtFYX1KfNXx6ubQ4a2BMHCWAZD9LdCxc
        w9hqhIfBmLqPjev9FVWUoivlJvcR1/N8sF1U30LvGORu6WhNCrdUuKiH/6GMDByJ+BmX6m
        60S/k+HILqWh1/KwIlw3VRH4pLaKX+VaPReqFk5OkQXsnSwh1djXi/uJ1bBs6FJAEqJoUx
        n+/aJLXVHz3RNX5z3+wQK+ZeLaJaNuf6nn969Os4pj6XSArWwIIQCPUWmkKtqD4wzy0SJx
        s2iGTAjnHBI2nztyKzTzLKuP5+0dM6X0j0wRKEWWJE5gjeAS9XTb3GIq0JNxsQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1691078356;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zKBJ1Mftgu7rnvcKZd3VnHGaq1AMQ1K5u82pzJNkbX8=;
        b=cMDtf/OB0sSj0NCVe1TGEAZRgLLBtn3K9K0iVgAt6IvUaBj2KMfp8B1OaUzFKoPp2EJCuD
        OOYsjm29cIvOTnAg==
From:   "tip-bot2 for Arnd Bergmann" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cleanups] x86/apic: Hide unused safe_smp_processor_id() on
 32-bit UP
Cc:     Arnd Bergmann <arnd@arndb.de>,
        "Borislav Petkov (AMD)" <bp@alien8.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230725134837.1534228-2-arnd@kernel.org>
References: <20230725134837.1534228-2-arnd@kernel.org>
MIME-Version: 1.0
Message-ID: <169107835581.28540.12068505666604846343.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/cleanups branch of tip:

Commit-ID:     ac1c6283c45a77431af33fbae435f1a29f23a9f4
Gitweb:        https://git.kernel.org/tip/ac1c6283c45a77431af33fbae435f1a29f23a9f4
Author:        Arnd Bergmann <arnd@arndb.de>
AuthorDate:    Tue, 25 Jul 2023 15:48:33 +02:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Mon, 31 Jul 2023 11:32:25 +02:00

x86/apic: Hide unused safe_smp_processor_id() on 32-bit UP

When CONFIG_SMP is disabled in a 32-bit config, the prototype for
safe_smp_processor_id() is hidden, which causes a W=1 warning:

  arch/x86/kernel/apic/ipi.c:316:5: error: no previous prototype for 'safe_smp_processor_id' [-Werror=missing-prototypes]

Since there are no callers in this configuration, just hide the definition
as well.

  [ bp: Clarify it is a 32-bit config. ]

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/r/20230725134837.1534228-2-arnd@kernel.org
---
 arch/x86/kernel/apic/ipi.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/x86/kernel/apic/ipi.c b/arch/x86/kernel/apic/ipi.c
index 2a6509e..9bfd6e3 100644
--- a/arch/x86/kernel/apic/ipi.c
+++ b/arch/x86/kernel/apic/ipi.c
@@ -301,6 +301,7 @@ void default_send_IPI_mask_logical(const struct cpumask *cpumask, int vector)
 	local_irq_restore(flags);
 }
 
+#ifdef CONFIG_SMP
 /* must come after the send_IPI functions above for inlining */
 static int convert_apicid_to_cpu(int apic_id)
 {
@@ -329,3 +330,4 @@ int safe_smp_processor_id(void)
 	return cpuid >= 0 ? cpuid : 0;
 }
 #endif
+#endif
