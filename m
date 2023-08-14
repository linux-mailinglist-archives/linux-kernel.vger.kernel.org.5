Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF35777B4DD
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 10:56:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232753AbjHNI4b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 04:56:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234663AbjHNIye (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 04:54:34 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7327A18E
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 01:54:32 -0700 (PDT)
Message-ID: <20230814085114.183018283@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1692003271;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=53nlX+r/fEq0JBYCW+1MqV4BLn6IkJJvtfrqLhkPQXE=;
        b=eNgC1LsoEznrxFiuUNUWa33Gw7F3kPsxszaafBI1YkLk/VMqXpxggYRauYy/zBtlquCfw5
        N6RSOQF3FXQXMqEYpzUyCFFE+EcrtVSiXP5t0QeTCvcpRk40mh3nyVYmknvJ/1NrFlKxAB
        CWwn0HlQ5w3gjVj/7A4Lr0SEBLqaIGyiKnZJ9YunpZNXCw+FZv1ThbO/+Tj443f55zDh/F
        xPBKLS/H1nItKZK56ZITZZFCBS0ju0vIUAzCytbAvE4aG4Zo8MCTwzB1MWSFJ2JyecYsFu
        AQGWzRg9djwNBtgYVGJMSKhU/Y8gyg1RKQxQKlc4h71T9tQqz8YWkAaZS0XstQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1692003271;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=53nlX+r/fEq0JBYCW+1MqV4BLn6IkJJvtfrqLhkPQXE=;
        b=ccngd3SNxF6qfuRpIxGi97cI9OLxWSkpv8b7gUwj+60KeFNXlRnMxjqtySuZFqJgFU7Xny
        9dwvGjNahKtL44Ag==
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
Subject: [patch V4 36/41] x86/cpu: Make topology_amd_node_id() use the actual
 node info
References: <20230814085006.593997112@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Mon, 14 Aug 2023 10:54:30 +0200 (CEST)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that everything is converted switch it over and remove the intermediate
operation.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Juergen Gross <jgross@suse.com>
Tested-by: Sohil Mehta <sohil.mehta@intel.com>
Tested-by: Michael Kelley <mikelley@microsoft.com>

---
 arch/x86/include/asm/topology.h       |    4 ++--
 arch/x86/kernel/cpu/topology_common.c |    7 ++-----
 2 files changed, 4 insertions(+), 7 deletions(-)

--- a/arch/x86/include/asm/topology.h
+++ b/arch/x86/include/asm/topology.h
@@ -136,7 +136,7 @@ extern const struct cpumask *cpu_cluster
 #define topology_core_id(cpu)			(cpu_data(cpu).topo.core_id)
 #define topology_ppin(cpu)			(cpu_data(cpu).ppin)
 
-#define topology_amd_node_id(cpu)		(cpu_data(cpu).topo.die_id)
+#define topology_amd_node_id(cpu)		(cpu_data(cpu).topo.amd_node_id)
 
 extern unsigned int __max_die_per_package;
 
@@ -171,7 +171,7 @@ extern unsigned int __amd_nodes_per_pkg;
 
 static inline unsigned int topology_amd_nodes_per_pkg(void)
 {
-	return __max_die_per_package;
+	return __amd_nodes_per_pkg;
 }
 
 extern struct cpumask __cpu_primary_thread_mask;
--- a/arch/x86/kernel/cpu/topology_common.c
+++ b/arch/x86/kernel/cpu/topology_common.c
@@ -151,9 +151,7 @@ static void topo_set_ids(struct topo_sca
 	c->topo.core_id = (apicid & topo_domain_mask(TOPO_PKG_DOMAIN)) >>
 		x86_topo_system.dom_shifts[TOPO_SMT_DOMAIN];
 
-	/* Temporary workaround */
-	if (tscan->amd_nodes_per_pkg)
-		c->topo.amd_node_id = c->topo.die_id = tscan->amd_node_id;
+	c->topo.amd_node_id = tscan->amd_node_id;
 
 	if (c->x86_vendor == X86_VENDOR_AMD)
 		cpu_topology_fixup_amd(tscan);
@@ -239,6 +237,5 @@ void __init cpu_init_topology(struct cpu
 	 * AMD systems have Nodes per package which cannot be mapped to
 	 * APIC ID (yet).
 	 */
-	if (c->x86_vendor == X86_VENDOR_AMD || c->x86_vendor == X86_VENDOR_HYGON)
-		__amd_nodes_per_pkg = __max_die_per_package = tscan.amd_nodes_per_pkg;
+	__amd_nodes_per_pkg = tscan.amd_nodes_per_pkg;
 }



