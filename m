Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F14B975F85F
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 15:36:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230260AbjGXNgV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 09:36:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231709AbjGXNfs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 09:35:48 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D72AA1FF0
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 06:35:12 -0700 (PDT)
Message-ID: <20230724132045.974342070@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1690205664;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=1bhj7lWCPL93WVUL7hHxugShRN0AQvpospwY1BweZqQ=;
        b=ckVj3JCV3dv/37iKRoN5qqW+aBeLUVnEOmGBYrUqsa17ciPGpkOV/J6hUExyGULcN4yJfh
        pb2vAbKEvnrltGyTHx909cR/MnpBFK8do/IoyQX6v2EeX1ZE4wdJh1lNCGMmcRwMFhTmGT
        bRQPZ/H+d7aZKNlVrTkQ6lEinQwYeJIFmoxLXlHgzbLdoV3aGuka9tEtF3dcwV2K035lp2
        C84RbsOF/xgPrYi/bLOEWN0gJf63Sju/jMeYUQyPfISZBE64E+7MsDqSxUSKi9ryYu38sd
        sls2gvlpwG4Auh7mhHIXJ3byWtrAyICPgx3csp+wscAKVxMxq/seNwV7Ah/7Gg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1690205664;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=1bhj7lWCPL93WVUL7hHxugShRN0AQvpospwY1BweZqQ=;
        b=QMFL50RDDDt3tMtaP0kPWnvamVc7kHV1MrCZ/6ZhtYhiNPieUpKGQx/8ZybUPdrve23Rhp
        NO5Nmw7W/S5tmjBQ==
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
Subject: [patch V2 23/58] x86/apic: Mop up early_per_cpu() abuse
References: <20230724131206.500814398@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Mon, 24 Jul 2023 15:34:23 +0200 (CEST)
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
 

