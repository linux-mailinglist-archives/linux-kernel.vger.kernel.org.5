Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0930766CCB
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 14:14:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236494AbjG1MOD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 08:14:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236025AbjG1MNX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 08:13:23 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4F523C31;
        Fri, 28 Jul 2023 05:13:06 -0700 (PDT)
Message-ID: <20230728120930.672330175@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1690546385;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=LotaVQs4RlrtT3Fsb/omzWTh9eCCKi/NbM3QS9xGwX0=;
        b=yNqXWhzplelPEC6EqufzV+PoVxUllAeo/Wi+p1hFo5vurLPMbYblXp4jGlR+9otM3JuTtM
        +viqKycR0ud2Z6znI05wUqOWt04KOT7tsUi4dJOl2lSxrZAMpL3uPBkBr0TGce0RXYhxqE
        dKWkAES7ZFTztoI33OonKhlt3QUZdgdBl3g1OyipOdBa5TrCCX0Vd7mDwFYvQEzck8N8Y1
        68KZSE5vB3RAPQwCjf+G3FkMB0lRTdyDAwMrMyla4RBp6/xMzDaOxEFA3OjogF6NApMA7O
        3nG+FCaeEg+iLV2GGB6qLt/548OkVmdrTJFrcXEk0oA1Q1sUoQ+KuH+Ri3/bQg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1690546385;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=LotaVQs4RlrtT3Fsb/omzWTh9eCCKi/NbM3QS9xGwX0=;
        b=wQFyFMOjMztzLvHuRRL8abQLdZo6Iawb1LV3/u9l0jn7S5GkkfyF2TuM8sNXVifAIuRJhj
        7k0sg+o64YADRaCQ==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Tom Lendacky <thomas.lendacky@amd.com>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Arjan van de Ven <arjan@linux.intel.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        Dick Kennedy <dick.kennedy@broadcom.com>,
        James Smart <james.smart@broadcom.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>,
        linux-hwmon@vger.kernel.org, Jean Delvare <jdelvare@suse.com>,
        Huang Rui <ray.huang@amd.com>, Juergen Gross <jgross@suse.com>,
        Steve Wahl <steve.wahl@hpe.com>,
        Mike Travis <mike.travis@hpe.com>,
        Dimitri Sivanich <dimitri.sivanich@hpe.com>,
        Russ Anderson <russ.anderson@hpe.com>
Subject: [patch v2 18/38] x86/cpu/topology: Cure the abuse of cpuinfo for
 persisting logical ids
References: <20230728105650.565799744@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Fri, 28 Jul 2023 14:13:05 +0200 (CEST)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
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

