Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D30737726D3
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 15:56:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232007AbjHGN4r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 09:56:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234609AbjHGN4Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 09:56:16 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CFAC3586
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 06:54:07 -0700 (PDT)
Message-ID: <20230807135029.009917769@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1691416430;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=Es3P3wUc8dTCX9Wd6cL1INpIUVEDH8jUOH/8KtNoObI=;
        b=JmooD2zOj8ZSgid2qaMEmTu0hVqCsJ/pfVNVxByLZNFYmJyOQw3qGRis4XgW04AHeRRn2Q
        LlobDT5i4qfXxuNikzUiYOA595Dxo7VWipOCwv+xJT4JQ0lMtxg9Fq8wSXQGrJx2QPRdgK
        Vd0BoA+tl3qiHwAt8xUQubIw7a4hsQGrYcJrSnNSLI92QZ4frbN41mRaca3WryQtyC4l/w
        upxCrke/7xK/UE0WfnRWOiXdaZzYQEBdD92BOrn87BSccs3IyWbr93qaHk4ogjj0mT5My8
        IrNuC+yXcYRP7yUqBzUtRJw/uIMqbZUtbyTrGCYTSohNNJAXWm0hkeJuSviOXA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1691416430;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=Es3P3wUc8dTCX9Wd6cL1INpIUVEDH8jUOH/8KtNoObI=;
        b=0rYCcFEPJqde2sSSM+Q1geAOPdxC8o0eSV/c7KAL2Rp7xHdaqeytT9E9GTXf1IAjyPMBO3
        H5dOeX9uMVOq3cBA==
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
Subject: [patch 49/53] x86: Use topology functions instead of smp_num_siblings
 where applicable
References: <20230807130108.853357011@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Mon,  7 Aug 2023 15:53:50 +0200 (CEST)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Accessors exist for a reason.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/include/asm/perf_event_p4.h |   11 ++---------
 arch/x86/kernel/process.c            |    2 +-
 arch/x86/kernel/smpboot.c            |    2 +-
 3 files changed, 4 insertions(+), 11 deletions(-)

--- a/arch/x86/include/asm/perf_event_p4.h
+++ b/arch/x86/include/asm/perf_event_p4.h
@@ -180,19 +180,12 @@ static inline u64 p4_clear_ht_bit(u64 co
 
 static inline int p4_ht_active(void)
 {
-#ifdef CONFIG_SMP
-	return smp_num_siblings > 1;
-#endif
-	return 0;
+	return topology_smt_supported();
 }
 
 static inline int p4_ht_thread(int cpu)
 {
-#ifdef CONFIG_SMP
-	if (smp_num_siblings == 2)
-		return cpu != cpumask_first(this_cpu_cpumask_var_ptr(cpu_sibling_map));
-#endif
-	return 0;
+	return !topology_is_primary_thread(cpu);
 }
 
 static inline int p4_should_swap_ts(u64 config, int cpu)
--- a/arch/x86/kernel/process.c
+++ b/arch/x86/kernel/process.c
@@ -924,7 +924,7 @@ static __cpuidle void mwait_idle(void)
 void select_idle_routine(const struct cpuinfo_x86 *c)
 {
 #ifdef CONFIG_SMP
-	if (boot_option_idle_override == IDLE_POLL && smp_num_siblings > 1)
+	if (boot_option_idle_override == IDLE_POLL && topology_smt_supported())
 		pr_warn_once("WARNING: polling idle and HT enabled, performance may degrade\n");
 #endif
 	if (x86_idle_set() || boot_option_idle_override == IDLE_POLL)
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -573,7 +573,7 @@ static void __init build_sched_topology(
 
 void set_cpu_sibling_map(int cpu)
 {
-	bool has_smt = smp_num_siblings > 1;
+	bool has_smt = topology_smt_supported();
 	bool has_mp = has_smt || boot_cpu_data.x86_max_cores > 1;
 	struct cpuinfo_x86 *c = &cpu_data(cpu);
 	struct cpuinfo_x86 *o;

