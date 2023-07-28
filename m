Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65995766CF8
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 14:16:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236608AbjG1MQy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 08:16:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236513AbjG1MPn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 08:15:43 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06F0349E2;
        Fri, 28 Jul 2023 05:13:25 -0700 (PDT)
Message-ID: <20230728120931.505785260@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1690546403;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=u2nALLK7m8WtmbLIhAtObAjpwOgRje3zo0FH2XahcbM=;
        b=GIvlp94LV25tQrX80pxbX/N70wOTOXl1hgm7O+jOavcl0fQA2otJl17nloVDkKpxNsC+tf
        VqhBvakOcB+OEaQBOilNAcwansF4pm2rplTzJvmFkP8+2Dvv2PdTPZE/Ue8oh7acRjdqnz
        slBG2awD5EDNozNpnKV6AI6lDHA+8XcylXRRHAsHWm++PPHfr+QQCHueFPrAdHLfDzfCZ7
        v/I/fIYM0A7j7kwe6PFkKUiSvx/t9BzMIIwMsG0djbeI0Oadafq8sDzHNx/5udykaHWLTL
        3j2IWHY7Yp1v8V2DaBJhpotKV/aU3km1rfD4wCBhT6UThxZz04OTKt7TleAvPw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1690546403;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=u2nALLK7m8WtmbLIhAtObAjpwOgRje3zo0FH2XahcbM=;
        b=xHo81PcfzjVzlw4YP6rbYGVCqC/Pe6iPvoQokP8a/dLP6VigQIChE6ZgDwpueKeHkYjTNC
        spr9cjMUyha7RtCA==
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
Subject: [patch v2 33/38] x86/cpu: Make topology_amd_node_id() use the actual
 node info
References: <20230728105650.565799744@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Fri, 28 Jul 2023 14:13:23 +0200 (CEST)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that everything is converted switch it over and remove the intermediate
operation.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
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
@@ -143,9 +143,7 @@ static void topo_set_ids(struct topo_sca
 	/* Relative core ID */
 	c->topo.core_id = topo_relative_domain_id(apicid, TOPO_CORE_DOMAIN);
 
-	/* Temporary workaround */
-	if (tscan->amd_nodes_per_pkg)
-		c->topo.amd_node_id = c->topo.die_id = tscan->amd_node_id;
+	c->topo.amd_node_id = tscan->amd_node_id;
 
 	if (c->x86_vendor == X86_VENDOR_AMD)
 		cpu_topology_fixup_amd(tscan);
@@ -231,6 +229,5 @@ void __init cpu_init_topology(struct cpu
 	 * AMD systems have Nodes per package which cannot be mapped to
 	 * APIC ID (yet).
 	 */
-	if (c->x86_vendor == X86_VENDOR_AMD || c->x86_vendor == X86_VENDOR_HYGON)
-		__amd_nodes_per_pkg = __max_die_per_package = tscan.amd_nodes_per_pkg;
+	__amd_nodes_per_pkg = tscan.amd_nodes_per_pkg;
 }

