Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7188677B4CA
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 10:55:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235063AbjHNIy6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 04:54:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234953AbjHNIyB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 04:54:01 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 115D410B
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 01:54:01 -0700 (PDT)
Message-ID: <20230814085112.981956102@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1692003239;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=ziamZBTASNl2sFH0KVh93VbhwlbtdBcXmYqEKL7Hxj8=;
        b=PkLkFohf/fNeia304l0kzv2sDu58RFwyXCVX+0jc6tXfoUML77STHzaHuSGg+AGmVf6Lhl
        UcFIMj8t/rAgvoTtpsne2tgW25VmugdPfAIRI9LVbzPVsGOslt9s3YTOcG2Ddr1WlNckcq
        rIu3/Puska9uROKnyK4EJgt+0uMDdeXzJf19ONpIO6jxNEPkDrxjOXrBQjRDTjEhNo2sQW
        N2RS2t/pJNeUMbUHxX625za+MMIehlYcLfYR6FWinsZ8hABpg7icJw06GuIUmMl8mVxMR2
        956EY/v8rQPFFXh1Zooet/v9khJmwra+r6UTszKT+KSBAbNHMQ3UV2A2ygP+OQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1692003239;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=ziamZBTASNl2sFH0KVh93VbhwlbtdBcXmYqEKL7Hxj8=;
        b=zJryGnTmfF3L9cjCLZ68mnFRcqCDoPeoE6qMJ3u+7F/JEb4Jxxg8g33HZjFaCkHkB8dLzI
        rIXesLfQuvjeP8Cg==
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
Subject: [patch V4 16/41] x86/apic: Use u32 for check_apicid_used()
References: <20230814085006.593997112@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Mon, 14 Aug 2023 10:53:59 +0200 (CEST)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

APIC IDs are used with random data types u16, u32, int, unsigned int,
unsigned long.

Make it all consistently use u32 because that reflects the hardware
register width and move the default implementation to local.h as there are
no users outside the apic directory.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Juergen Gross <jgross@suse.com>
Tested-by: Sohil Mehta <sohil.mehta@intel.com>
Tested-by: Michael Kelley <mikelley@microsoft.com>
Reviewed-by: Arjan van de Ven <arjan@linux.intel.com>

---
 arch/x86/include/asm/apic.h         |    3 +--
 arch/x86/kernel/apic/apic_common.c  |    2 +-
 arch/x86/kernel/apic/apic_flat_64.c |    2 --
 arch/x86/kernel/apic/apic_noop.c    |    2 ++
 arch/x86/kernel/apic/bigsmp_32.c    |    2 +-
 arch/x86/kernel/apic/local.h        |    1 +
 6 files changed, 6 insertions(+), 6 deletions(-)

--- a/arch/x86/include/asm/apic.h
+++ b/arch/x86/include/asm/apic.h
@@ -292,7 +292,7 @@ struct apic {
 	int	(*acpi_madt_oem_check)(char *oem_id, char *oem_table_id);
 	bool	(*apic_id_registered)(void);
 
-	bool	(*check_apicid_used)(physid_mask_t *map, int apicid);
+	bool	(*check_apicid_used)(physid_mask_t *map, u32 apicid);
 	void	(*init_apic_ldr)(void);
 	void	(*ioapic_phys_id_map)(physid_mask_t *phys_map, physid_mask_t *retmap);
 	int	(*cpu_present_to_apicid)(int mps_cpu);
@@ -538,7 +538,6 @@ extern int default_apic_id_valid(u32 api
 extern u32 apic_default_calc_apicid(unsigned int cpu);
 extern u32 apic_flat_calc_apicid(unsigned int cpu);
 
-extern bool default_check_apicid_used(physid_mask_t *map, int apicid);
 extern void default_ioapic_phys_id_map(physid_mask_t *phys_map, physid_mask_t *retmap);
 extern int default_cpu_present_to_apicid(int mps_cpu);
 
--- a/arch/x86/kernel/apic/apic_common.c
+++ b/arch/x86/kernel/apic/apic_common.c
@@ -18,7 +18,7 @@ u32 apic_flat_calc_apicid(unsigned int c
 	return 1U << cpu;
 }
 
-bool default_check_apicid_used(physid_mask_t *map, int apicid)
+bool default_check_apicid_used(physid_mask_t *map, u32 apicid)
 {
 	return physid_isset(apicid, *map);
 }
--- a/arch/x86/kernel/apic/apic_flat_64.c
+++ b/arch/x86/kernel/apic/apic_flat_64.c
@@ -158,8 +158,6 @@ static struct apic apic_physflat __ro_af
 
 	.disable_esr			= 0,
 
-	.check_apicid_used		= NULL,
-	.ioapic_phys_id_map		= NULL,
 	.cpu_present_to_apicid		= default_cpu_present_to_apicid,
 	.phys_pkg_id			= flat_phys_pkg_id,
 
--- a/arch/x86/kernel/apic/apic_noop.c
+++ b/arch/x86/kernel/apic/apic_noop.c
@@ -18,6 +18,8 @@
 
 #include <asm/apic.h>
 
+#include "local.h"
+
 static void noop_send_IPI(int cpu, int vector) { }
 static void noop_send_IPI_mask(const struct cpumask *cpumask, int vector) { }
 static void noop_send_IPI_mask_allbutself(const struct cpumask *cpumask, int vector) { }
--- a/arch/x86/kernel/apic/bigsmp_32.c
+++ b/arch/x86/kernel/apic/bigsmp_32.c
@@ -18,7 +18,7 @@ static unsigned bigsmp_get_apic_id(unsig
 	return (x >> 24) & 0xFF;
 }
 
-static bool bigsmp_check_apicid_used(physid_mask_t *map, int apicid)
+static bool bigsmp_check_apicid_used(physid_mask_t *map, u32 apicid)
 {
 	return false;
 }
--- a/arch/x86/kernel/apic/local.h
+++ b/arch/x86/kernel/apic/local.h
@@ -64,6 +64,7 @@ void default_send_IPI_all(int vector);
 void default_send_IPI_self(int vector);
 
 bool default_apic_id_registered(void);
+bool default_check_apicid_used(physid_mask_t *map, u32 apicid);
 
 #ifdef CONFIG_X86_32
 void default_send_IPI_mask_sequence_logical(const struct cpumask *mask, int vector);



