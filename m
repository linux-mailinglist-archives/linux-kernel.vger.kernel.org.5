Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 366837726D7
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 15:57:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234572AbjHGN5S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 09:57:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232312AbjHGN45 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 09:56:57 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F20E74222
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 06:54:31 -0700 (PDT)
Message-ID: <20230807135029.166295656@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1691416435;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=gGPnBkTfW+8B5SQXJHv1hpNWRmiBwz+4UGwUc972rDw=;
        b=gUx+AJ4BNaJQrnonAOcot/xmdvpaOMg6OhvZ2XZ2EsQGYvVALa8wQyI1Rw7PAdCZy0qSwH
        Yqc4yKmozV6zAaG6CqeGst/MuASRp5t/yXP8b/g4NIFUkzmf6uXhuClATg9Fltv6Iz9ESR
        yEQJUeaFjKrXYAB6zQh96OwItVovZrcHyCmcg4vEy7Thp2numswApE+yDbUTftDkMIqAug
        Xi1GR1KNazhvbRagclkmiQRp2oaxi3wDcuelpyxpsyZd/9APWxZd3gMfbykBkT4XAthVCd
        lC1lBcnVt6AnRKfzAVXvR4jJ/kynSy4GSTAXQjHuNpmnD/0TsIcR4X4PhQ8D/Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1691416435;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=gGPnBkTfW+8B5SQXJHv1hpNWRmiBwz+4UGwUc972rDw=;
        b=jsdqZR++153ohXhEKjnvEMV/nlkzpS3n+K0Ps0yPvvZC2iOtFWrkmlbOJVUThtoYKP+S2d
        FKzyUz+C04J3vTAQ==
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
Subject: [patch 52/53] x86/cpu/topology: Provide
 __num_[cores|threads]_per_package
References: <20230807130108.853357011@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Mon,  7 Aug 2023 15:53:55 +0200 (CEST)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Expose properly accounted information and accessors so the fiddling with
other topology variables can be replaced.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/include/asm/topology.h |   12 ++++++++++++
 arch/x86/kernel/cpu/common.c    |    6 ++++++
 arch/x86/kernel/cpu/topology.c  |    8 +++++++-
 3 files changed, 25 insertions(+), 1 deletion(-)

--- a/arch/x86/include/asm/topology.h
+++ b/arch/x86/include/asm/topology.h
@@ -146,6 +146,8 @@ extern const struct cpumask *cpu_cluster
 extern unsigned int __max_dies_per_package;
 extern unsigned int __max_logical_packages;
 extern unsigned int __max_threads_per_core;
+extern unsigned int __num_threads_per_package;
+extern unsigned int __num_cores_per_package;
 
 static inline unsigned int topology_max_packages(void)
 {
@@ -157,6 +159,16 @@ static inline unsigned int topology_max_
 	return __max_dies_per_package;
 }
 
+static inline unsigned int topology_num_cores_per_package(void)
+{
+	return __num_cores_per_package;
+}
+
+static inline unsigned int topology_num_threads_per_package(void)
+{
+	return __num_threads_per_package;
+}
+
 int topology_get_logical_id(u32 apicid, enum x86_topology_domains at_level);
 
 static inline int topology_phys_to_logical_pkg(unsigned int pkg)
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -81,6 +81,12 @@ EXPORT_SYMBOL(__max_dies_per_package);
 unsigned int __max_logical_packages __ro_after_init = 1;
 EXPORT_SYMBOL(__max_logical_packages);
 
+unsigned int __num_cores_per_package __ro_after_init = 1;
+EXPORT_SYMBOL(__num_cores_per_package);
+
+unsigned int __num_threads_per_package __ro_after_init = 1;
+EXPORT_SYMBOL(__num_threads_per_package);
+
 static struct ppin_info {
 	int	feature;
 	int	msr_ppin_ctl;
--- a/arch/x86/kernel/cpu/topology.c
+++ b/arch/x86/kernel/cpu/topology.c
@@ -391,7 +391,7 @@ void __init topology_init_possible_cpus(
 	unsigned int disabled = topo_info.nr_disabled_cpus;
 	unsigned int cnta, cntb, cpu, dom, allowed = 1;
 	unsigned int total = assigned + disabled;
-	u32 apicid;
+	u32 apicid, firstid;
 
 	if (!restrict_to_up()) {
 		if (total > 1)
@@ -430,6 +430,12 @@ void __init topology_init_possible_cpus(
 	__max_threads_per_core = 1U << (get_count_order(cntb) - get_count_order(cnta));
 	pr_info("Max. threads per core: %3u\n", __max_threads_per_core);
 
+	firstid = find_first_bit(apic_maps[TOPO_SMT_DOMAIN].map, MAX_LOCAL_APIC);
+	__num_cores_per_package = topology_unit_count(firstid, TOPO_CORE_DOMAIN, TOPO_PKG_DOMAIN);
+	pr_info("Num. cores per package:   %3u\n", __num_cores_per_package);
+	__num_threads_per_package = topology_unit_count(firstid, TOPO_SMT_DOMAIN, TOPO_PKG_DOMAIN);
+	pr_info("Num. threads per package: %3u\n", __num_threads_per_package);
+
 	pr_info("Allowing %u present CPUs plus %u hotplug CPUs\n", assigned, disabled);
 	if (topo_info.nr_rejected_cpus)
 		pr_info("Rejected CPUs %u\n", topo_info.nr_rejected_cpus);

