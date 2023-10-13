Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 345BE7C822E
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 11:38:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231241AbjJMJiN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 05:38:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230512AbjJMJiI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 05:38:08 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 578BEBE;
        Fri, 13 Oct 2023 02:38:05 -0700 (PDT)
Date:   Fri, 13 Oct 2023 09:38:03 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1697189884;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wvykBSg8m0Q1xA5BZ7F/jqR4FIzxpwGYfb6UZQ016/0=;
        b=ogvC0Ii/A9JdjRoEHABoWKkyShDYaPc6kHMKTT/4OTwqcqpExBdwp+81MTazfcyBl+IkHQ
        +dIGwD9FHRRsFsAM+6DthQphJ9lbKGXl/rHpLFqmptKnWZwmy8NdvsL4kPuuV4FKEjDYmS
        p4lySpLg/OMJ8TD3hCoWuyMChKxU53NwI5sI7YIzOwBzpXMZgYE35+coITUupiP08nvXX0
        O1IskfDTe85xAqjCXd1jMJxSnB4fBidyrxLWs3DHNzTmC+FHOtdBL22Og9qicW5j5ewRig
        MAWadzl/QIKHuf6CuIa7cmDhetN49MerldxbQvq3FXHVo9Ow/XncerAiaf2Teg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1697189884;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wvykBSg8m0Q1xA5BZ7F/jqR4FIzxpwGYfb6UZQ016/0=;
        b=oGPC7omCb1GCJMaFBZRaNSfZ40MYbe4OYx3trhbjMcCGHSHtQHC7LsKz7lkf4lkS2kP9os
        O9icP0JcxM3zm+Dg==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/core] x86/cpu/topology: Cure the abuse of cpuinfo for
 persisting logical ids
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Juergen Gross <jgross@suse.com>,
        Sohil Mehta <sohil.mehta@intel.com>,
        Michael Kelley <mikelley@microsoft.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Zhang Rui <rui.zhang@intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230814085113.292947071@linutronix.de>
References: <20230814085113.292947071@linutronix.de>
MIME-Version: 1.0
Message-ID: <169718988316.3135.12947465467392664307.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/core branch of tip:

Commit-ID:     90781f0c4c41a41043e39d9acbc66cc3644769ba
Gitweb:        https://git.kernel.org/tip/90781f0c4c41a41043e39d9acbc66cc3644769ba
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Mon, 14 Aug 2023 10:18:46 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 10 Oct 2023 14:38:19 +02:00

x86/cpu/topology: Cure the abuse of cpuinfo for persisting logical ids

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
Tested-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Tested-by: Zhang Rui <rui.zhang@intel.com>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/20230814085113.292947071@linutronix.de

---
 arch/x86/kernel/smpboot.c | 33 +++++++++++++++++++++++----------
 1 file changed, 23 insertions(+), 10 deletions(-)

diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
index 04a1136..54541a1 100644
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
@@ -337,10 +350,8 @@ int topology_phys_to_logical_pkg(unsigned int phys_pkg)
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
@@ -358,11 +369,9 @@ static int topology_phys_to_logical_die(unsigned int die_id, unsigned int cur_cp
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
@@ -387,6 +396,8 @@ int topology_update_package_map(unsigned int pkg, unsigned int cpu)
 			cpu, pkg, new);
 	}
 found:
+	per_cpu(logical_maps.phys_pkg_id, cpu) = pkg;
+	per_cpu(logical_maps.logical_pkg_id, cpu) = new;
 	cpu_data(cpu).topo.logical_pkg_id = new;
 	return 0;
 }
@@ -410,6 +421,8 @@ int topology_update_die_map(unsigned int die, unsigned int cpu)
 			cpu, die, new);
 	}
 found:
+	per_cpu(logical_maps.phys_die_id, cpu) = die;
+	per_cpu(logical_maps.logical_die_id, cpu) = new;
 	cpu_data(cpu).topo.logical_die_id = new;
 	return 0;
 }
