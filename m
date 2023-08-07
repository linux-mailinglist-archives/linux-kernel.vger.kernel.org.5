Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6DF07726CE
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 15:56:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232915AbjHGN4Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 09:56:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234575AbjHGNze (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 09:55:34 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 251532719
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 06:53:48 -0700 (PDT)
Message-ID: <20230807135028.800668666@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1691416424;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=AfQzecPadC51W0+MsVlK3HeQl1U7zVudClCfarez7gY=;
        b=o3DfM5U0t2/heXbjNrpNe+8MgvT4QU3LQfgTHRXocTWlyqrnHGZNM70YEC67f6seJ6oYyC
        fxveX/aTf8tLgHbBB0UQEMmtkGmC1U7BmWy2D85o3o5rU3I4N/RcTLLb4q9xTyddK4z0jn
        Z+vX5Cm/t18OeSXWodBOBacNzfaytosgpaNoejFmDnFwmG0Uda10M1rfZHc2umSzSU/VdL
        gcJ4nNBgc8R/3EOwSgWxgoh4eTWpRospBv3KlZ0AlFUv92Frqerr4e0BYNHGBaTzTXn8la
        ipk5LpKdJpA+f1XJXXy8So30LuuXvNG0XnL1jIlXWviUvsMlfy9TzB929UMSLw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1691416424;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=AfQzecPadC51W0+MsVlK3HeQl1U7zVudClCfarez7gY=;
        b=IDoTbYofzNkQBexjtr281rhNB0OHaOZL+AMofq4QKR4XiiVdvkCJjeRknNnfvs6D2zO3LR
        aNw5JcxvNd3IaFCA==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Tom Lendacky <thomas.lendacky@amd.com>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Arjan van de Ven <arjan@linux.intel.com>,
        Huang Rui <ray.huang@amd.com>, Juergen Gross <jgross@suse.com>,
        Dimitri Sivanich <dimitri.sivanich@hpe.com>,
        Michael Kelley <mikelley@microsoft.com>,
        Sohil Mehta <sohil.mehta@intel.com>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Zhang Rui <rui.zhang@intel.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Feng Tang <feng.tang@intel.com>,
        Andy Shevchenko <andy@infradead.org>
Subject: [patch 45/53] x86/cpu/topology: Simplify cpu_mark_primary_thread()
References: <20230807130108.853357011@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Mon,  7 Aug 2023 15:53:44 +0200 (CEST)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No point in creating a mask via fls(). smp_num_siblings is guaranteed to be
a power of 2. So just using (smp_num_siblings - 1) has the same effect.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/kernel/cpu/topology.c |    5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

--- a/arch/x86/kernel/cpu/topology.c
+++ b/arch/x86/kernel/cpu/topology.c
@@ -86,10 +86,7 @@ bool arch_match_cpu_phys_id(int cpu, u64
 #ifdef CONFIG_SMP
 static void cpu_mark_primary_thread(unsigned int cpu, unsigned int apicid)
 {
-	/* Isolate the SMT bit(s) in the APICID and check for 0 */
-	u32 mask = (1U << (fls(smp_num_siblings) - 1)) - 1;
-
-	if (smp_num_siblings == 1 || !(apicid & mask))
+	if (!(apicid & (smp_num_siblings - 1)))
 		cpumask_set_cpu(cpu, &__cpu_primary_thread_mask);
 }
 #else

