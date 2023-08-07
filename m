Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B46977269E
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 15:53:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234534AbjHGNx0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 09:53:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234523AbjHGNwy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 09:52:54 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A9E91730
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 06:52:48 -0700 (PDT)
Message-ID: <20230807135026.854491808@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1691416366;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=pV6oTjHlZpDv1EoB3lKno45EpFKoJahAlGz3jQzkcpE=;
        b=RYJC16Qg+xko8CIrW97uwJtJjai3Te5eCtMaVLupODScJPGvUnR9g3d/tsF2bK26F8xLZv
        DsvmHhb7jZotBd1Ex6My1pZS5HGwtDEMnshcdvLqytoswSc9MKgPm5u/cbqYZHVtjZ0T8T
        c5Zc3QI+2A/5Ris10Z4do2zkj9eoEhnzE5ILMccs2YTw5C+Us+E9g/nelH0X422odp0S+A
        u6cOn8A2caWEKxNQDoz0C0BKdddbHB+BDtHJlAE+Zf3V4JquWk9E2iEPIa813euSCpGUUy
        sXyiQr2ss8QE0xOjSxeoLmKF/EKt95qY+/W2yg10fQ/8vnTyZnHBzXMtr1PCIA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1691416366;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=pV6oTjHlZpDv1EoB3lKno45EpFKoJahAlGz3jQzkcpE=;
        b=cdkdbtDQ4oLgW4u1nsn3j+7DcH7Uq1oK/zJW4YGMKdupOouSKUb/OOOJ6F79VQVOJz+B/B
        F+DRsCqxathE/KCg==
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
Subject: [patch 08/53] x86/apic: Remove check_apicid_used() and
 ioapic_phys_id_map()
References: <20230807130108.853357011@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Mon,  7 Aug 2023 15:52:45 +0200 (CEST)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No more users.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/include/asm/apic.h           |    3 ---
 arch/x86/include/asm/mpspec.h         |    6 ------
 arch/x86/kernel/apic/apic_noop.c      |    2 --
 arch/x86/kernel/apic/bigsmp_32.c      |   13 -------------
 arch/x86/kernel/apic/probe_32.c       |    2 --
 arch/x86/kernel/apic/x2apic_cluster.c |    2 --
 6 files changed, 28 deletions(-)

--- a/arch/x86/include/asm/apic.h
+++ b/arch/x86/include/asm/apic.h
@@ -292,9 +292,7 @@ struct apic {
 	int	(*acpi_madt_oem_check)(char *oem_id, char *oem_table_id);
 	bool	(*apic_id_registered)(void);
 
-	bool	(*check_apicid_used)(physid_mask_t *map, u32 apicid);
 	void	(*init_apic_ldr)(void);
-	void	(*ioapic_phys_id_map)(physid_mask_t *phys_map, physid_mask_t *retmap);
 	u32	(*cpu_present_to_apicid)(int mps_cpu);
 
 	u32	(*get_apic_id)(u32 id);
@@ -527,7 +525,6 @@ extern int default_apic_id_valid(u32 api
 extern u32 apic_default_calc_apicid(unsigned int cpu);
 extern u32 apic_flat_calc_apicid(unsigned int cpu);
 
-extern void default_ioapic_phys_id_map(physid_mask_t *phys_map, physid_mask_t *retmap);
 extern u32 default_cpu_present_to_apicid(int mps_cpu);
 
 #else /* CONFIG_X86_LOCAL_APIC */
--- a/arch/x86/include/asm/mpspec.h
+++ b/arch/x86/include/asm/mpspec.h
@@ -92,12 +92,6 @@ typedef struct physid_mask physid_mask_t
 #define physids_empty(map)					\
 	bitmap_empty((map).mask, MAX_LOCAL_APIC)
 
-static inline void physids_promote(unsigned long physids, physid_mask_t *map)
-{
-	physids_clear(*map);
-	map->mask[0] = physids;
-}
-
 static inline void physid_set_mask_of_physid(int physid, physid_mask_t *map)
 {
 	physids_clear(*map);
--- a/arch/x86/kernel/apic/apic_noop.c
+++ b/arch/x86/kernel/apic/apic_noop.c
@@ -51,8 +51,6 @@ struct apic apic_noop __ro_after_init =
 
 	.disable_esr			= 0,
 
-	.check_apicid_used		= default_check_apicid_used,
-	.ioapic_phys_id_map		= default_ioapic_phys_id_map,
 	.cpu_present_to_apicid		= default_cpu_present_to_apicid,
 
 	.max_apic_id			= 0xFE,
--- a/arch/x86/kernel/apic/bigsmp_32.c
+++ b/arch/x86/kernel/apic/bigsmp_32.c
@@ -18,17 +18,6 @@ static u32 bigsmp_get_apic_id(u32 x)
 	return (x >> 24) & 0xFF;
 }
 
-static bool bigsmp_check_apicid_used(physid_mask_t *map, u32 apicid)
-{
-	return false;
-}
-
-static void bigsmp_ioapic_phys_id_map(physid_mask_t *phys_map, physid_mask_t *retmap)
-{
-	/* For clustered we don't have a good way to do this yet - hack */
-	physids_promote(0xFFL, retmap);
-}
-
 static void bigsmp_send_IPI_allbutself(int vector)
 {
 	default_send_IPI_mask_allbutself_phys(cpu_online_mask, vector);
@@ -80,8 +69,6 @@ static struct apic apic_bigsmp __ro_afte
 
 	.disable_esr			= 1,
 
-	.check_apicid_used		= bigsmp_check_apicid_used,
-	.ioapic_phys_id_map		= bigsmp_ioapic_phys_id_map,
 	.cpu_present_to_apicid		= default_cpu_present_to_apicid,
 
 	.max_apic_id			= 0xFE,
--- a/arch/x86/kernel/apic/probe_32.c
+++ b/arch/x86/kernel/apic/probe_32.c
@@ -45,9 +45,7 @@ static struct apic apic_default __ro_aft
 
 	.disable_esr			= 0,
 
-	.check_apicid_used		= default_check_apicid_used,
 	.init_apic_ldr			= default_init_apic_ldr,
-	.ioapic_phys_id_map		= default_ioapic_phys_id_map,
 	.cpu_present_to_apicid		= default_cpu_present_to_apicid,
 
 	.max_apic_id			= 0xFE,
--- a/arch/x86/kernel/apic/x2apic_cluster.c
+++ b/arch/x86/kernel/apic/x2apic_cluster.c
@@ -232,9 +232,7 @@ static struct apic apic_x2apic_cluster _
 
 	.disable_esr			= 0,
 
-	.check_apicid_used		= NULL,
 	.init_apic_ldr			= init_x2apic_ldr,
-	.ioapic_phys_id_map		= NULL,
 	.cpu_present_to_apicid		= default_cpu_present_to_apicid,
 
 	.max_apic_id			= UINT_MAX,

