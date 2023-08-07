Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91EDB7726CA
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 15:55:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234604AbjHGNzn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 09:55:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234700AbjHGNyj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 09:54:39 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EEF32136
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 06:53:40 -0700 (PDT)
Message-ID: <20230807135028.590964892@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1691416418;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=o9SLDTJj0ahrwCVinyEBp+cl3PdBP7t2Ahe9Zy+O4Hg=;
        b=qxJvIkaob+sckp0E/Da7Q7nfjiLdwKRN313sR467mp0de3ZCApwTHm16s7a3z5aRCxal1g
        3kP3eHzRW1I/0VO2eRYYlsGpMTctiBssw6PNIPNzJaRPef2xoixxzRRF4pWff84MQbiV37
        QKEYHo0CWE1HKAonM5dEbii6DS5gYUmLg+EHT0wAkgOa5hh47EL1Mn47LOVL6s/xKQK/ow
        d0a2HBYxeFa/WuzGMQwU3imkV8gM6LSTj/yzRIEAlreID2OpLzUeJ2l+RQGGIIz0qf6gcW
        wjmeShMeLOwedLmc2TPFdRDNzVTdWqPHqhRcOH7L3t3Sz4nSZO+AKatinqnF5A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1691416418;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=o9SLDTJj0ahrwCVinyEBp+cl3PdBP7t2Ahe9Zy+O4Hg=;
        b=1oHVvXW3zugTioz7NcC7YLqdyBQOGBYt7nb34N5AFkST+ZYjs85CN3l8F3biTdkhWKuf+r
        /a432DbYL5kUfxBQ==
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
Subject: [patch 41/53] x86/xen/smp_pv: Count number of vCPUs early
References: <20230807130108.853357011@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Mon,  7 Aug 2023 15:53:37 +0200 (CEST)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

XEN/PV has a completely broken vCPU enumeration scheme, which just works by
chance and provides zero topology information. Each vCPU ends up being a
single core package.

Dom0 provides MADT which can be used for topology information, but that
table is the unmodified host table, which means that there can be more CPUs
registered than the number of vCPUs XEN provides for the dom0 guest.

DomU does not have ACPI and both rely on counting the possible vCPUs via an
hypercall.

To prepare for using CPUID topology information either via MADT or via fake
APIC IDs count the number of possible CPUs during early boot and adjust
nr_cpu_ids() accordingly.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/xen/enlighten_pv.c |    3 +++
 arch/x86/xen/smp.h          |    2 ++
 arch/x86/xen/smp_pv.c       |   14 ++++++++++++++
 3 files changed, 19 insertions(+)

--- a/arch/x86/xen/enlighten_pv.c
+++ b/arch/x86/xen/enlighten_pv.c
@@ -189,6 +189,9 @@ static void __init xen_pv_init_platform(
 		xen_set_mtrr_data();
 	else
 		mtrr_overwrite_state(NULL, 0, MTRR_TYPE_WRBACK);
+
+	/* Adjust nr_cpu_ids before "enumeration" happens */
+	xen_smp_count_cpus();
 }
 
 static void __init xen_pv_guest_late_init(void)
--- a/arch/x86/xen/smp.h
+++ b/arch/x86/xen/smp.h
@@ -19,6 +19,7 @@ extern void xen_smp_intr_free(unsigned i
 int xen_smp_intr_init_pv(unsigned int cpu);
 void xen_smp_intr_free_pv(unsigned int cpu);
 
+void xen_smp_count_cpus(void);
 void xen_smp_cpus_done(unsigned int max_cpus);
 
 void xen_smp_send_reschedule(int cpu);
@@ -44,6 +45,7 @@ static inline int xen_smp_intr_init_pv(u
 	return 0;
 }
 static inline void xen_smp_intr_free_pv(unsigned int cpu) {}
+static inline void xen_smp_count_cpus(void) { }
 #endif /* CONFIG_SMP */
 
 #endif
--- a/arch/x86/xen/smp_pv.c
+++ b/arch/x86/xen/smp_pv.c
@@ -411,6 +411,20 @@ static irqreturn_t xen_irq_work_interrup
 	return IRQ_HANDLED;
 }
 
+void __init xen_smp_count_cpus(void)
+{
+	unsigned int cpus;
+
+	for (cpus = 0; cpus < nr_cpu_ids; cpus++) {
+		if (HYPERVISOR_vcpu_op(VCPUOP_is_up, cpus, NULL) < 0)
+			break;
+	}
+
+	pr_info("Xen PV: Detected %u vCPUS\n", cpus);
+	if (cpus < nr_cpu_ids)
+		set_nr_cpu_ids(cpus);
+}
+
 static const struct smp_ops xen_smp_ops __initconst = {
 	.smp_prepare_boot_cpu = xen_pv_smp_prepare_boot_cpu,
 	.smp_prepare_cpus = xen_pv_smp_prepare_cpus,

