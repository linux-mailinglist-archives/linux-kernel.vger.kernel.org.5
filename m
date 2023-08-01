Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E8CD76B23D
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 12:48:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232350AbjHAKsy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 06:48:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234105AbjHAKr4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 06:47:56 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C3332D48
        for <linux-kernel@vger.kernel.org>; Tue,  1 Aug 2023 03:47:13 -0700 (PDT)
Message-ID: <20230801103816.475813693@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1690886831;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=1bhj7lWCPL93WVUL7hHxugShRN0AQvpospwY1BweZqQ=;
        b=323dqJw90MiESEEiWlZuY/lQHbiHlZkTw4EAoFjoiDcnIQkGOO3bDgRmwOCxdT2Kub8xul
        /NYoCzGNEJ159pPQlCwcp5JDRE9wZQkZ7j7583uvwFgeo73eMTHwQRQE2MoAAhKsT6Yrm6
        asfGK/R892SxHi/deZs1/Nk2Tu1UJNGUrS3P1KOLlb6w0BEWOwnd+O7cV0FhPTdV1q8wGl
        K3IHwfFzMMnoI0awOaLeteUOCK/v77fWRamso537ga16gW6yfi9tB+9Aid0e4lo+ZHbOrd
        LjtJ1AYGP0JsNjZeSjZL7hdVOuuZoFjYT6l1itXVll3nBhyYqqXr7cCHBc6A7g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1690886831;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=1bhj7lWCPL93WVUL7hHxugShRN0AQvpospwY1BweZqQ=;
        b=QKw1Dj1sUj9ALxvFOjjUQpyEL95kTcR80QNGOR+uLyfpv6wmRTwsjhPTrRrqOqa5e6MIa0
        CkX9+8wBotATmlCg==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Andrew Cooper <andrew.cooper3@citrix.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Wei Liu <wei.liu@kernel.org>,
        Arjan van de Ven <arjan@linux.intel.com>,
        Juergen Gross <jgross@suse.com>,
        Michael Kelley <mikelley@microsoft.com>,
        Peter Keresztes Schmidt <peter@keresztesschmidt.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>
Subject: [patch V3 24/60] x86/apic: Mop up early_per_cpu() abuse
References: <20230801103042.936020332@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Tue,  1 Aug 2023 12:47:10 +0200 (CEST)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

UV X2APIC uses the per CPU variable from:

  native_smp_prepare_cpus()
    uv_system_init()
      uv_system_init_hub()

which is long after the per CPU areas have been set up.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/kernel/apic/x2apic_uv_x.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/x86/kernel/apic/x2apic_uv_x.c
+++ b/arch/x86/kernel/apic/x2apic_uv_x.c
@@ -1843,7 +1843,7 @@ static void __init uv_system_init_hub(vo
 
 	/* Initialize per CPU info: */
 	for_each_possible_cpu(cpu) {
-		int apicid = early_per_cpu(x86_cpu_to_apicid, cpu);
+		int apicid = per_cpu(x86_cpu_to_apicid, cpu);
 		unsigned short bid;
 		unsigned short pnode;
 

