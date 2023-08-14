Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B9E577B4CF
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 10:55:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235184AbjHNIzM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 04:55:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234980AbjHNIyJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 04:54:09 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD40C10B
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 01:54:08 -0700 (PDT)
Message-ID: <20230814085113.292947071@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1692003247;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=77oFfcRh1dz2uih5llyqW8UL7n2yCgxBjdO2NZc4Y68=;
        b=qsnivYD0+xmerPdy98Wtnzybf4ZAAw9DNxH+tEtrcCN9T+3asRO4AN46sWtQzbIM9K+r41
        hpUa5/GZ3gYPDFpHO6gXDIe5nbDwotehtBZ+HQOCWPbnhioqz3tD9pgz4Vn11uf0/VncM3
        dLC5TKqnwt4jNHtn26p9WmivrMO5vpFd/lpjS8RkUs4BVmZeHt5/g1qHVO37G6MFG7Tb/b
        xrkgsdjNfuU7QG292fxlHm2B3gr8E6/jw/jHSf1bxtfe78letw1jxv7XU7ZlbIFS70pKAz
        6Sp0rX2DGjXBnMA7mpIyFWSNwkJXm16fuT5gkR8de8AibjbMPp5o1thWJzNmwg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1692003247;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=77oFfcRh1dz2uih5llyqW8UL7n2yCgxBjdO2NZc4Y68=;
        b=hrTTYywU313iKWFC3zyAtgZXWOV7LL3VByT1vffPcCs1cydL+gi5Hhadkckk16MsphpwGD
        avZ6X6eYAAYA1ICQ==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Tom Lendacky <thomas.lendacky@amd.com>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Arjan van de Ven <arjan@linux.intel.com>,
        Huang Rui <ray.huang@amd.com>, Juergen Gross <jgross@suse.com>,
        Dimitri Sivanich <dimitri.sivanich@hpe.com>,
        Michael Kelley <mikelley@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Pu Wen <puwen@hygon.cn>,
        Qiuxu Zhuo <qiuxu.zhuo@intel.com>,
        Sohil Mehta <sohil.mehta@intel.com>
Subject: [patch V4 21/41] x86/cpu/topology: Cure the abuse of cpuinfo for
 persisting logical ids
References: <20230814085006.593997112@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Mon, 14 Aug 2023 10:54:07 +0200 (CEST)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Per CPU cpuinfo is used to persist the logical package and die IDs. That's
really not the right place simply because cpuinfo is subject to be
reinitialized when a CPU goes through an offline/online cycle.

This works by chance today, but that's far from correct and neither obvious
nor documented.

Add a per cpu datastructure which persists those logical IDs, which allows
to cleanup the CPUID evaluation code.

This is a temporary workaround until the larger topology management is in
place, which makes all of this logical management mechanics obsolete.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Juergen Gross <jgross@suse.com>
Tested-by: Sohil Mehta <sohil.mehta@intel.com>
Tested-by: Michael Kelley <mikelley@microsoft.com>

---
 arch/x86/kernel/smpboot.c |   33 +++++++++++++++++++++++----------
 1 file changed, 23 insertions(+), 10 deletions(-)

--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -124,7 +124,20 @@ struct mwait_cpu_dead {
  */
 static DEFINE_PER_CPU_ALIGNED(struct mwait_cpu_dead, mwait_cpu_dead);
 
-/* Logical package management. We might want to allocate that dynamically */
+/* Logical package management. */
+struct logical_maps {
+	u32	phys_pkg_id;
+	u32	phys_die_id;
+	u32	logical_pkg_id;
+	u32	logical_die_id;
+};
+
+/* Temporary workaround until the full topology mechanics is in place */
+static DEFINE_PER_CPU_READ_MOSTLY(struct logical_maps, logical_maps) = {
+	.phys_pkg_id	= U32_MAX,
+	.phys_die_id	= U32_MAX,
+};
+
 unsigned int __max_logical_packages __read_mostly;
 EXPORT_SYMBOL(__max_logical_packages);
 static unsigned int logical_packages __read_mostly;
@@ -345,10 +358,8 @@ int topology_phys_to_logical_pkg(unsigne
 	int cpu;
 
 	for_each_possible_cpu(cpu) {
-		struct cpuinfo_x86 *c = &cpu_data(cpu);
-
-		if (c->initialized && c->topo.pkg_id == phys_pkg)
-			return c->topo.logical_pkg_id;
+		if (per_cpu(logical_maps.phys_pkg_id, cpu) == phys_pkg)
+			return per_cpu(logical_maps.logical_pkg_id, cpu);
 	}
 	return -1;
 }
@@ -366,11 +377,9 @@ static int topology_phys_to_logical_die(
 	int cpu, proc_id = cpu_data(cur_cpu).topo.pkg_id;
 
 	for_each_possible_cpu(cpu) {
-		struct cpuinfo_x86 *c = &cpu_data(cpu);
-
-		if (c->initialized && c->topo.die_id == die_id &&
-		    c->topo.pkg_id == proc_id)
-			return c->topo.logical_die_id;
+		if (per_cpu(logical_maps.phys_pkg_id, cpu) == proc_id &&
+		    per_cpu(logical_maps.phys_die_id, cpu) == die_id)
+			return per_cpu(logical_maps.logical_die_id, cpu);
 	}
 	return -1;
 }
@@ -395,6 +404,8 @@ int topology_update_package_map(unsigned
 			cpu, pkg, new);
 	}
 found:
+	per_cpu(logical_maps.phys_pkg_id, cpu) = pkg;
+	per_cpu(logical_maps.logical_pkg_id, cpu) = new;
 	cpu_data(cpu).topo.logical_pkg_id = new;
 	return 0;
 }
@@ -418,6 +429,8 @@ int topology_update_die_map(unsigned int
 			cpu, die, new);
 	}
 found:
+	per_cpu(logical_maps.phys_die_id, cpu) = die;
+	per_cpu(logical_maps.logical_die_id, cpu) = new;
 	cpu_data(cpu).topo.logical_die_id = new;
 	return 0;
 }



