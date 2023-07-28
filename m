Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7746766D00
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 14:17:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235412AbjG1MRU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 08:17:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236573AbjG1MQT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 08:16:19 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFA6A3C35;
        Fri, 28 Jul 2023 05:13:38 -0700 (PDT)
Message-ID: <20230728120931.670346058@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1690546407;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=ERFK+VFh6rECY3YAEH1UcTGlweh3EwxmdvhVGEi5pZg=;
        b=a7U75a44tK481qN0qUGw08Za0yzjGyAf8b4wVCIo3s4Ar5XdPs0LqTW/6KRgiSV4PuWXL2
        M4hSVxxTzFaZ4zM24sYrRzo0IKd44qzfON/0vgzqJC0v2VcvHtVoHz9CcCIBfpM674V0EZ
        g/Fo9RZVnM4UNRN4v5ohJPMW+oF8qwotIkVZu6u9e0hzzi8/1wc2aracf8P8jw7weR6AEb
        xFPFdzAJfgxYkpaTB5k6IDa6Zp6S5yCtv45BRGkscboKlW25sh51zRyJNVDdiHEo+I9yOO
        +KtF9fFm+357FWT7kJslPEWTzNb4sNRAKNpADB3txJLI6EABps8u/OyQExtkSw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1690546407;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=ERFK+VFh6rECY3YAEH1UcTGlweh3EwxmdvhVGEi5pZg=;
        b=9Rn1PQDl9/Kal5HExVNqsl6Bdwq18J5sVLyeCfYvpo6+jF1rghhD8x2z9ZQVRuKpqrEAzt
        v1SxQ54kmsXvPXCw==
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
Subject: [patch v2 36/38] x86/apic: Remove unused phys_pkg_id() callback
References: <20230728105650.565799744@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Fri, 28 Jul 2023 14:13:27 +0200 (CEST)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that the core code does not use this monstrosity anymore, it's time to
put it to rest.

The only real purpose was to read the APIC ID on UV and VSMP systems for
the actual evaluation. That's what the core code does now.

For doing the actual shift operation there is truly no APIC callback
required.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/include/asm/apic.h           |    1 -
 arch/x86/kernel/apic/apic_flat_64.c   |    7 -------
 arch/x86/kernel/apic/apic_noop.c      |    3 ---
 arch/x86/kernel/apic/apic_numachip.c  |    7 -------
 arch/x86/kernel/apic/bigsmp_32.c      |    6 ------
 arch/x86/kernel/apic/local.h          |    1 -
 arch/x86/kernel/apic/probe_32.c       |    6 ------
 arch/x86/kernel/apic/x2apic_cluster.c |    1 -
 arch/x86/kernel/apic/x2apic_phys.c    |    6 ------
 arch/x86/kernel/apic/x2apic_uv_x.c    |   11 -----------
 arch/x86/kernel/vsmp_64.c             |   13 -------------
 arch/x86/xen/apic.c                   |    6 ------
 12 files changed, 68 deletions(-)

--- a/arch/x86/include/asm/apic.h
+++ b/arch/x86/include/asm/apic.h
@@ -296,7 +296,6 @@ struct apic {
 	void	(*init_apic_ldr)(void);
 	void	(*ioapic_phys_id_map)(physid_mask_t *phys_map, physid_mask_t *retmap);
 	u32	(*cpu_present_to_apicid)(int mps_cpu);
-	u32	(*phys_pkg_id)(u32 cpuid_apic, int index_msb);
 
 	u32	(*get_apic_id)(u32 id);
 	u32	(*set_apic_id)(u32 apicid);
--- a/arch/x86/kernel/apic/apic_flat_64.c
+++ b/arch/x86/kernel/apic/apic_flat_64.c
@@ -66,11 +66,6 @@ static u32 set_apic_id(u32 id)
 	return (id & 0xFF) << 24;
 }
 
-static u32 flat_phys_pkg_id(u32 initial_apic_id, int index_msb)
-{
-	return initial_apic_id >> index_msb;
-}
-
 static int flat_probe(void)
 {
 	return 1;
@@ -89,7 +84,6 @@ static struct apic apic_flat __ro_after_
 
 	.init_apic_ldr			= default_init_apic_ldr,
 	.cpu_present_to_apicid		= default_cpu_present_to_apicid,
-	.phys_pkg_id			= flat_phys_pkg_id,
 
 	.max_apic_id			= 0xFE,
 	.get_apic_id			= flat_get_apic_id,
@@ -159,7 +153,6 @@ static struct apic apic_physflat __ro_af
 	.disable_esr			= 0,
 
 	.cpu_present_to_apicid		= default_cpu_present_to_apicid,
-	.phys_pkg_id			= flat_phys_pkg_id,
 
 	.max_apic_id			= 0xFE,
 	.get_apic_id			= flat_get_apic_id,
--- a/arch/x86/kernel/apic/apic_noop.c
+++ b/arch/x86/kernel/apic/apic_noop.c
@@ -29,7 +29,6 @@ static void noop_send_IPI_self(int vecto
 static void noop_apic_icr_write(u32 low, u32 id) { }
 static int noop_wakeup_secondary_cpu(u32 apicid, unsigned long start_eip) { return -1; }
 static u64 noop_apic_icr_read(void) { return 0; }
-static u32 noop_phys_pkg_id(u32 cpuid_apic, int index_msb) { return 0; }
 static u32 noop_get_apic_id(u32 apicid) { return 0; }
 static void noop_apic_eoi(void) { }
 
@@ -56,8 +55,6 @@ struct apic apic_noop __ro_after_init =
 	.ioapic_phys_id_map		= default_ioapic_phys_id_map,
 	.cpu_present_to_apicid		= default_cpu_present_to_apicid,
 
-	.phys_pkg_id			= noop_phys_pkg_id,
-
 	.max_apic_id			= 0xFE,
 	.get_apic_id			= noop_get_apic_id,
 
--- a/arch/x86/kernel/apic/apic_numachip.c
+++ b/arch/x86/kernel/apic/apic_numachip.c
@@ -56,11 +56,6 @@ static u32 numachip2_set_apic_id(u32 id)
 	return id << 24;
 }
 
-static u32 numachip_phys_pkg_id(u32 initial_apic_id, int index_msb)
-{
-	return initial_apic_id >> index_msb;
-}
-
 static void numachip1_apic_icr_write(int apicid, unsigned int val)
 {
 	write_lcsr(CSR_G3_EXT_IRQ_GEN, (apicid << 16) | val);
@@ -228,7 +223,6 @@ static const struct apic apic_numachip1
 	.disable_esr			= 0,
 
 	.cpu_present_to_apicid		= default_cpu_present_to_apicid,
-	.phys_pkg_id			= numachip_phys_pkg_id,
 
 	.max_apic_id			= UINT_MAX,
 	.get_apic_id			= numachip1_get_apic_id,
@@ -265,7 +259,6 @@ static const struct apic apic_numachip2
 	.disable_esr			= 0,
 
 	.cpu_present_to_apicid		= default_cpu_present_to_apicid,
-	.phys_pkg_id			= numachip_phys_pkg_id,
 
 	.max_apic_id			= UINT_MAX,
 	.get_apic_id			= numachip2_get_apic_id,
--- a/arch/x86/kernel/apic/bigsmp_32.c
+++ b/arch/x86/kernel/apic/bigsmp_32.c
@@ -29,11 +29,6 @@ static void bigsmp_ioapic_phys_id_map(ph
 	physids_promote(0xFFL, retmap);
 }
 
-static u32 bigsmp_phys_pkg_id(u32 cpuid_apic, int index_msb)
-{
-	return cpuid_apic >> index_msb;
-}
-
 static void bigsmp_send_IPI_allbutself(int vector)
 {
 	default_send_IPI_mask_allbutself_phys(cpu_online_mask, vector);
@@ -88,7 +83,6 @@ static struct apic apic_bigsmp __ro_afte
 	.check_apicid_used		= bigsmp_check_apicid_used,
 	.ioapic_phys_id_map		= bigsmp_ioapic_phys_id_map,
 	.cpu_present_to_apicid		= default_cpu_present_to_apicid,
-	.phys_pkg_id			= bigsmp_phys_pkg_id,
 
 	.max_apic_id			= 0xFE,
 	.get_apic_id			= bigsmp_get_apic_id,
--- a/arch/x86/kernel/apic/local.h
+++ b/arch/x86/kernel/apic/local.h
@@ -17,7 +17,6 @@
 void __x2apic_send_IPI_dest(unsigned int apicid, int vector, unsigned int dest);
 u32 x2apic_get_apic_id(u32 id);
 u32 x2apic_set_apic_id(u32 id);
-u32 x2apic_phys_pkg_id(u32 initial_apicid, int index_msb);
 
 void x2apic_send_IPI_all(int vector);
 void x2apic_send_IPI_allbutself(int vector);
--- a/arch/x86/kernel/apic/probe_32.c
+++ b/arch/x86/kernel/apic/probe_32.c
@@ -18,11 +18,6 @@
 
 #include "local.h"
 
-static u32 default_phys_pkg_id(u32 cpuid_apic, int index_msb)
-{
-	return cpuid_apic >> index_msb;
-}
-
 static u32 default_get_apic_id(u32 x)
 {
 	unsigned int ver = GET_APIC_VERSION(apic_read(APIC_LVR));
@@ -54,7 +49,6 @@ static struct apic apic_default __ro_aft
 	.init_apic_ldr			= default_init_apic_ldr,
 	.ioapic_phys_id_map		= default_ioapic_phys_id_map,
 	.cpu_present_to_apicid		= default_cpu_present_to_apicid,
-	.phys_pkg_id			= default_phys_pkg_id,
 
 	.max_apic_id			= 0xFE,
 	.get_apic_id			= default_get_apic_id,
--- a/arch/x86/kernel/apic/x2apic_cluster.c
+++ b/arch/x86/kernel/apic/x2apic_cluster.c
@@ -236,7 +236,6 @@ static struct apic apic_x2apic_cluster _
 	.init_apic_ldr			= init_x2apic_ldr,
 	.ioapic_phys_id_map		= NULL,
 	.cpu_present_to_apicid		= default_cpu_present_to_apicid,
-	.phys_pkg_id			= x2apic_phys_pkg_id,
 
 	.max_apic_id			= UINT_MAX,
 	.x2apic_set_max_apicid		= true,
--- a/arch/x86/kernel/apic/x2apic_phys.c
+++ b/arch/x86/kernel/apic/x2apic_phys.c
@@ -134,11 +134,6 @@ u32 x2apic_set_apic_id(u32 id)
 	return id;
 }
 
-u32 x2apic_phys_pkg_id(u32 initial_apicid, int index_msb)
-{
-	return initial_apicid >> index_msb;
-}
-
 static struct apic apic_x2apic_phys __ro_after_init = {
 
 	.name				= "physical x2apic",
@@ -151,7 +146,6 @@ static struct apic apic_x2apic_phys __ro
 	.disable_esr			= 0,
 
 	.cpu_present_to_apicid		= default_cpu_present_to_apicid,
-	.phys_pkg_id			= x2apic_phys_pkg_id,
 
 	.max_apic_id			= UINT_MAX,
 	.x2apic_set_max_apicid		= true,
--- a/arch/x86/kernel/apic/x2apic_uv_x.c
+++ b/arch/x86/kernel/apic/x2apic_uv_x.c
@@ -785,16 +785,6 @@ static u32 set_apic_id(u32 id)
 	return id;
 }
 
-static unsigned int uv_read_apic_id(void)
-{
-	return x2apic_get_apic_id(apic_read(APIC_ID));
-}
-
-static u32 uv_phys_pkg_id(u32 initial_apicid, int index_msb)
-{
-	return uv_read_apic_id() >> index_msb;
-}
-
 static int uv_probe(void)
 {
 	return apic == &apic_x2apic_uv_x;
@@ -812,7 +802,6 @@ static struct apic apic_x2apic_uv_x __ro
 	.disable_esr			= 0,
 
 	.cpu_present_to_apicid		= default_cpu_present_to_apicid,
-	.phys_pkg_id			= uv_phys_pkg_id,
 
 	.max_apic_id			= UINT_MAX,
 	.get_apic_id			= x2apic_get_apic_id,
--- a/arch/x86/kernel/vsmp_64.c
+++ b/arch/x86/kernel/vsmp_64.c
@@ -127,25 +127,12 @@ static void __init vsmp_cap_cpus(void)
 #endif
 }
 
-static u32 apicid_phys_pkg_id(u32 initial_apic_id, int index_msb)
-{
-	return read_apic_id() >> index_msb;
-}
-
-static void vsmp_apic_post_init(void)
-{
-	/* need to update phys_pkg_id */
-	apic->phys_pkg_id = apicid_phys_pkg_id;
-}
-
 void __init vsmp_init(void)
 {
 	detect_vsmp_box();
 	if (!is_vsmp_box())
 		return;
 
-	x86_platform.apic_post_init = vsmp_apic_post_init;
-
 	vsmp_cap_cpus();
 
 	set_vsmp_ctl();
--- a/arch/x86/xen/apic.c
+++ b/arch/x86/xen/apic.c
@@ -110,11 +110,6 @@ static int xen_madt_oem_check(char *oem_
 	return xen_pv_domain();
 }
 
-static u32 xen_phys_pkg_id(u32 initial_apic_id, int index_msb)
-{
-	return initial_apic_id >> index_msb;
-}
-
 static u32 xen_cpu_present_to_apicid(int cpu)
 {
 	if (cpu_present(cpu))
@@ -133,7 +128,6 @@ static struct apic xen_pv_apic __ro_afte
 	.disable_esr			= 0,
 
 	.cpu_present_to_apicid		= xen_cpu_present_to_apicid,
-	.phys_pkg_id			= xen_phys_pkg_id, /* detect_ht */
 
 	.max_apic_id			= UINT_MAX,
 	.get_apic_id			= xen_get_apic_id,

