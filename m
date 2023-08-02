Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C17076CAA7
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 12:21:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233427AbjHBKVQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 06:21:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233212AbjHBKVF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 06:21:05 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EB952690
        for <linux-kernel@vger.kernel.org>; Wed,  2 Aug 2023 03:21:02 -0700 (PDT)
Message-ID: <20230802101932.819070039@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1690971661;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=KworwVT2v0HpqXoPWJdJcjW+bA4KcReILTYRuVf21jU=;
        b=p/BKVW6rK2byUO6m6m7keMSO0k6eLcnu+ZVZBAHzwkKkaL3qYNTYBJ3+Xxld6PSFMKwvC3
        qWoIjVCE/RY+re/+YUeII8FzRmk2USFYEDcsuoKIo5uXntaTtsq0pFwQzAuJJTkf+ahj7N
        sBWrYiOuOBsMuCgOjldGH8LtQG1rG/rq/BmFbxGfLXukoH3wm3ei11leQHzIazrDaRU0ez
        9F8IdQFefXVgyY4kXQ8W1GMKwal2cCr1teVVwuc8ZLrqlZgn4EtyA821Y3F/1wRqACVv29
        7MxNifWr6s8J2FMrTtQxmneu2XfyDhkV0JnXusQ81t/1KIyLZeGPs/1BYxnMyA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1690971661;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=KworwVT2v0HpqXoPWJdJcjW+bA4KcReILTYRuVf21jU=;
        b=gmJPpEGfssLMz9LV7H2vKKjNS/3GGIo7SH/jpzhq9puu8MBthGCUE3NrNk5AhkEU6AGch8
        PCOsmBFyD+08lYBw==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Tom Lendacky <thomas.lendacky@amd.com>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Arjan van de Ven <arjan@linux.intel.com>,
        Huang Rui <ray.huang@amd.com>, Juergen Gross <jgross@suse.com>,
        Dimitri Sivanich <dimitri.sivanich@hpe.com>,
        Michael Kelley <mikelley@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>
Subject: [patch V3 02/40] x86/apic: Fake primary thread mask for XEN/PV
References: <20230802101635.459108805@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Wed,  2 Aug 2023 12:21:01 +0200 (CEST)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The SMT control mechanism got added as speculation attack vector
mitigation. The implemented logic relies on the primary thread mask to
be set up properly.

This turns out to be an issue with XEN/PV guests because their CPU hotplug
mechanics do not enumerate APICs and therefore the mask is never correctly
populated.

This went unnoticed so far because by chance XEN/PV ends up with
smp_num_siblings == 2. So smt_hot-plug_control stays at its default value
CPU_SMT_ENABLED and the primary thread mask is never evaluated in the
context of CPU hotplug.

This stopped "working" with the upcoming overhaul of the topology
evaluation which legitimately provides a fake topology for XEN/PV. That
sets smp_num_siblings to 1, which causes the core CPU hot-plug core to
refuse to bring up the APs.

This happens because smt_hotplug_control is set to CPU_SMT_NOT_SUPPORTED
which causes cpu_smt_allowed() to evaluate the unpopulated primary thread
mask with the conclusion that all non-boot CPUs are not valid to be
plugged.

The core code has already been made more robust against this kind of fail,
but the primary thread mask really wants to be populated to avoid other
issues all over the place.

Just fake the mask by pretending that all XEN/PV vCPUs are primary threads,
which is consistent because all of XEN/PVs topology is fake or non-existent.

Fixes: 6a4d2657e048 ("x86/smp: Provide topology_is_primary_thread()")
Fixes: f54d4434c281 ("x86/apic: Provide cpu_primary_thread mask")
Reported-by: Juergen Gross <jgross@suse.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/kernel/apic/apic.c |   11 +++++++++++
 1 file changed, 11 insertions(+)

--- a/arch/x86/kernel/apic/apic.c
+++ b/arch/x86/kernel/apic/apic.c
@@ -36,6 +36,8 @@
 #include <linux/smp.h>
 #include <linux/mm.h>
 
+#include <xen/xen.h>
+
 #include <asm/trace/irq_vectors.h>
 #include <asm/irq_remapping.h>
 #include <asm/pc-conf-reg.h>
@@ -2344,6 +2346,15 @@ static int __init smp_init_primary_threa
 {
 	unsigned int cpu;
 
+	/*
+	 * XEN/PV provides either none or useless topology information.
+	 * Pretend that all vCPUs are primary threads.
+	 */
+	if (xen_pv_domain()) {
+		cpumask_copy(&__cpu_primary_thread_mask, cpu_possible_mask);
+		return 0;
+	}
+
 	for (cpu = 0; cpu < nr_logical_cpuids; cpu++)
 		cpu_mark_primary_thread(cpu, cpuid_to_apicid[cpu]);
 	return 0;

