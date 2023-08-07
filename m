Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84DEE7726B8
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 15:54:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234698AbjHGNyg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 09:54:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234552AbjHGNx2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 09:53:28 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B5E210D9
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 06:53:22 -0700 (PDT)
Message-ID: <20230807135028.004788526@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1691416401;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=SKlzH88G4hUFDWBSbGuVUg+96Wfddo4akvXYLyLOQ0U=;
        b=vrJ4kiRElUPDhd5ikOKv+S14H4YOQL8Bp8OblgGZVQMv3oy1scK69+GIg1Cd0QmFtSkBe/
        NhyxK6A2SLwbZ6O1bGmvjMKjcoV4pqXkY0ChqTjKARMu2S/1sp2TXquw8zpIbT4dE6BvvK
        2okS/+bAHAHxo7JSmFdLqS+g9nl55jYhaJdN71Qg4pHuQy0fGlBweyDCQCidaWGkH9pbq8
        IXUrHy8AhByBSJgX5cPfJtz0XflZYcyFYFE4TYa2H9t6x00swfYPNU6m+u5ZDft/CT8Xui
        c9zkphgAlQBCmXFtfYBx5Be86huRP+ifA45K3+lCKAz/lf5+piIDM0BGla9pig==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1691416401;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=SKlzH88G4hUFDWBSbGuVUg+96Wfddo4akvXYLyLOQ0U=;
        b=vGkLYQFg9IyCb4CuMg3u0ak1In3y9Aw8zkFF315GdSQ+L2R/cmHuKyVVCQTOg2aGZXPirl
        hUVUl5QtH1GZHdCA==
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
Subject: [patch 30/53] x86/xen/smp_pv: Register fake APICs
References: <20230807130108.853357011@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Mon,  7 Aug 2023 15:53:20 +0200 (CEST)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

XENPV does not use the APIC. It's just piggy packing on the infrastructure
and fiddles with global variables as it sees fit.

These global variables are going away, so let XENPV register pseudo APIC
IDs to keep the accounting correct and keep up the illusion that XEN/PV is
something sane.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/xen/smp_pv.c |   35 +++++++++--------------------------
 1 file changed, 9 insertions(+), 26 deletions(-)

--- a/arch/x86/xen/smp_pv.c
+++ b/arch/x86/xen/smp_pv.c
@@ -29,6 +29,7 @@
 #include <asm/idtentry.h>
 #include <asm/desc.h>
 #include <asm/cpu.h>
+#include <asm/apic.h>
 #include <asm/io_apic.h>
 
 #include <xen/interface/xen.h>
@@ -150,34 +151,16 @@ int xen_smp_intr_init_pv(unsigned int cp
 
 static void __init xen_pv_smp_config(void)
 {
-	int i, rc;
-	unsigned int subtract = 0;
+	u32 apicid = 0;
+	int i;
 
-	num_processors = 0;
-	disabled_cpus = 0;
-	for (i = 0; i < nr_cpu_ids; i++) {
-		rc = HYPERVISOR_vcpu_op(VCPUOP_is_up, i, NULL);
-		if (rc >= 0) {
-			num_processors++;
-			set_cpu_possible(i, true);
-		} else {
-			set_cpu_possible(i, false);
-			set_cpu_present(i, false);
-			subtract++;
-		}
+	topology_register_boot_apic(apicid++);
+
+	for (i = 1; i < nr_cpu_ids; i++) {
+		if (HYPERVISOR_vcpu_op(VCPUOP_is_up, i, NULL) < 0)
+			break;
+		topology_register_apic(apicid++, CPU_ACPIID_INVALID, true);
 	}
-#ifdef CONFIG_HOTPLUG_CPU
-	/* This is akin to using 'nr_cpus' on the Linux command line.
-	 * Which is OK as when we use 'dom0_max_vcpus=X' we can only
-	 * have up to X, while nr_cpu_ids is greater than X. This
-	 * normally is not a problem, except when CPU hotplugging
-	 * is involved and then there might be more than X CPUs
-	 * in the guest - which will not work as there is no
-	 * hypercall to expand the max number of VCPUs an already
-	 * running guest has. So cap it up to X. */
-	if (subtract)
-		set_nr_cpu_ids(nr_cpu_ids - subtract);
-#endif
 	/* Pretend to be a proper enumerated system */
 	smp_found_config = 1;
 }

