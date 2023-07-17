Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C146757063
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 01:16:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231451AbjGQXQl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 19:16:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231444AbjGQXQe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 19:16:34 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7DBE1737
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 16:15:46 -0700 (PDT)
Message-ID: <20230717223224.444954484@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1689635710;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=cjdrCvZHnH3sO0Olcvdwl8Hi5blCr2ZcSnmxA24BUR4=;
        b=y+8T2oDvcEKeyeCklnaCk/WqabLO+VADf6/86pJOumvRNn807m/oM/f4/ZaF5eqKLpUJMe
        WyyZIKdKMOnXFZNL85mdijnrsPok8rCWBoj9m6n7YP9eOec6BJKerMR02JPrpKCRR/SgkY
        LbcIieBr6+SgFB4gdawQZfkdS50w1fmwXJeSWkXHPVewa1s7kHPQ1X7++8wM3nWpPW+NM6
        OmjEhNgCSCHKySE0xdxT3/CixuiiJVA+YYByUOX79ZvuNHnvmLaKE0elftUvvTdKaXXqVD
        q4HbBJSqcwbs9y+B1XUrZAHXcZmTZa8zUsfTe6b7+Z1lIaWCSNLjhKvSKWJFCw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1689635710;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=cjdrCvZHnH3sO0Olcvdwl8Hi5blCr2ZcSnmxA24BUR4=;
        b=dMchqiD6AEKV99oENrDA29LWzQtH/vD5fWx6eCd9Xl/jF7vVCTzTSpOQGbuMgA35gtqdJP
        gX912dygNeZJVnCQ==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Wei Liu <wei.liu@kernel.org>,
        Arjan van de Ven <arjan@linux.intel.com>,
        Juergen Gross <jgross@suse.com>
Subject: [patch 23/58] x86/apic: Mop up early_per_cpu() abuse
References: <20230717223049.327865981@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Tue, 18 Jul 2023 01:15:10 +0200 (CEST)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
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
 

