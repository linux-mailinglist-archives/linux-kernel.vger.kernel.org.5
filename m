Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C33F7726CF
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 15:56:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234621AbjHGN43 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 09:56:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232402AbjHGNzy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 09:55:54 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75772199C
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 06:53:57 -0700 (PDT)
Message-ID: <20230807135028.852716187@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1691416426;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=aiPd1kJ39cEUiKercbaDdBw1XcAUDDQu1AI+a4ZUPac=;
        b=NU7iSmQfUQwNrqJyCFAczRCZqUyKGATvOAUgm2VAVI3hydE0Djlcpn+HIWW4cVv5fHBMs+
        h3z1aOSg8ZvOpur5AGs2hSqc6+o9sN8ZJ/kcZ6VphfRKxKvChB08vwFr/2lNgQAiPK6G/G
        i/R0n3Fkzb4lX4kNB5bKQgZPsaWFzQ+ZOe3pGjWn542YrPTbvERhsZUMkDo6TSO/AlVzyo
        Ti5365Vm/TOXVhjT1zOEPeZC+d1Gr/qv80awJovr895uvAbldkrQk28jatlY7quWM0Qjra
        EUO9f61Ey5gRitQ4SNJp7inm3oNnynRmNd9Ee80A3jgzhIdg6pdMtpir3Enhqw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1691416426;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=aiPd1kJ39cEUiKercbaDdBw1XcAUDDQu1AI+a4ZUPac=;
        b=c0u5DRuWzz5yn+Xx0JLP4M+VQZfLcyZJhQUSKfjoCKpytodMjdCpVMXz8faPw1TLOMmmoX
        C3GH3ySuicSvuEBA==
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
Subject: [patch 46/53] x86/cpu/topology: Provide logical pkg/die mapping
References: <20230807130108.853357011@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Mon,  7 Aug 2023 15:53:45 +0200 (CEST)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With the topology bitmaps in place the logical package and die IDs can
trivially be retrieved by determining the bitmap weight of the relevant
topology domain level up to and including the physical ID in question.

Provide a function to that effect.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/include/asm/topology.h |    2 ++
 arch/x86/kernel/cpu/topology.c  |   28 ++++++++++++++++++++++++++++
 2 files changed, 30 insertions(+)

--- a/arch/x86/include/asm/topology.h
+++ b/arch/x86/include/asm/topology.h
@@ -156,6 +156,8 @@ static inline unsigned int topology_max_
 	return __max_dies_per_package;
 }
 
+int topology_get_logical_id(u32 apicid, enum x86_topology_domains at_level);
+
 #ifdef CONFIG_SMP
 #define topology_cluster_id(cpu)		(cpu_data(cpu).topo.l2c_id)
 #define topology_die_cpumask(cpu)		(per_cpu(cpu_die_map, cpu))
--- a/arch/x86/kernel/cpu/topology.c
+++ b/arch/x86/kernel/cpu/topology.c
@@ -199,6 +199,34 @@ void __init topology_register_boot_apic(
 	topology_register_apic(apic_id, CPU_ACPIID_INVALID, true);
 }
 
+/**
+ * topology_get_logical_id - Retrieve the logical ID at a given topology domain level
+ * @apicid:		The APIC ID for which to lookup the logical ID
+ * @at_level:		The topology domain level to use
+ *
+ * @apicid must be a full APIC ID, not the normalized variant. It's valid to have
+ * all bits below the domain level specified by @at_level to be clear. So both
+ * real APIC IDs and backshifted normalized APIC IDs work correctly.
+ *
+ * Returns:
+ *  - >= 0:	The requested logical ID
+ *  - -ERANGE:	@apicid is out of range
+ *  - -ENODEV:	@apicid is not registered
+ */
+int topology_get_logical_id(u32 apicid, enum x86_topology_domains at_level)
+{
+	/* Remove the bits below @at_level to get the proper level ID of @apicid */
+	unsigned int lvlid = topo_apicid(apicid, at_level);
+
+	if (lvlid >= MAX_LOCAL_APIC)
+		return -ERANGE;
+	if (!test_bit(lvlid, apic_maps[at_level].map))
+		return -ENODEV;
+	/* Get the number of set bits before @lvlid. */
+	return bitmap_weight(apic_maps[at_level].map, lvlid);
+}
+EXPORT_SYMBOL_GPL(topology_get_logical_id);
+
 #ifdef CONFIG_ACPI_HOTPLUG_CPU
 /**
  * topology_hotplug_apic - Handle a physical hotplugged APIC after boot

