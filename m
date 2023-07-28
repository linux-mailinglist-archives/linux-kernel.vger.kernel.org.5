Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15989766CBE
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 14:13:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236440AbjG1MNi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 08:13:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235989AbjG1MNB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 08:13:01 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47505268B;
        Fri, 28 Jul 2023 05:13:00 -0700 (PDT)
Message-ID: <20230728120930.393454382@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1690546378;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=ZpujbDnKtKDSL5RBSdIZ4PFgwYRWpF+NGFguVXH8Iqo=;
        b=Dt4c3GI/uH1CtRHMqAx7aMPQt/hsPsr7oslzBVtQb7/eJfTlHvgsZfZiJMhpPq2nDWv11A
        m5ZWvdthqFFYZXJQHY4+Q/nw8MHNOn446oc1/gl+O8wdI+FdiW0RptTzoORfyCweWm4c5b
        gR23ufjz+akCv09zIlwTCNsofDxJTU1nmulM62txMTqnPnqAXJPk8SOqQgN8XPSuWPaOcg
        LB21WpfL5SfMv7nkVWwFTc92V/nThUhncHFFcol+Rvo+IX0mRcLBG7sH+IO+ij9HvSTPKK
        xAogulpBnq4G2EXIOQueKFkBZMBlHag03OCObWbXFiipBoIdzO3FO4LrrJthrw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1690546378;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=ZpujbDnKtKDSL5RBSdIZ4PFgwYRWpF+NGFguVXH8Iqo=;
        b=sa9a1TbpxDEC8tqSsyc8C8ruLGPDkoFGT/OsNRO2pqdgQKae16rFSAk3Ew3DYwcp6BghN6
        SsqcUTf4I0GEAeCA==
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
Subject: [patch v2 13/38] x86/apic: Use u32 for check_apicid_used()
References: <20230728105650.565799744@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Fri, 28 Jul 2023 14:12:58 +0200 (CEST)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
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

