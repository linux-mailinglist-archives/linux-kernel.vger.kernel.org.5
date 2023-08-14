Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD1BB77B4E6
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 10:57:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235625AbjHNI4l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 04:56:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235352AbjHNIyi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 04:54:38 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2566712D
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 01:54:37 -0700 (PDT)
Message-ID: <20230814085114.360997471@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1692003275;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=6kotpziBexnHaTc7L0AVu1xBQOcptwc2pW/uxqW6phU=;
        b=scQsBQUFqdazkZs172qVq7XlaYQ1BcF/HLAYIIVEght/4M6cAgPTf4AkcREkvi5/tOgDZ4
        mlrpRw5V39ZtBVqxAEg1TvON4wq+uQgJT5PHu7N5bHFGjNbQaD9Hzj/vZime4RGAa6mmmo
        CJCd+dVbkfrvBKhNV7EWBneL/3bwSm1gKjnMDhoGw2Y7UCEipcs3LWF0br3R3jiLmQVUcG
        D+gLcBuX84aDlns8ZZC69IZBWsBIAqQML9RVWNV4p2SzPVbT61ZT9LiW54HzoiBWjyMRrT
        kiwWQXgPy4yo4TXJ7TFJN4cysPQ5hgAU+AsU/XG5rSajeXyvTyfJx91CsZx3eA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1692003275;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=6kotpziBexnHaTc7L0AVu1xBQOcptwc2pW/uxqW6phU=;
        b=wmw3X3ffrJos8ej72EVgYnrH7NkMPPAzYMYuhJnstfz1X8rsn6Wbxu4jZDJmk4X89Ehk85
        2jXNTi8liaMDiqCg==
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
Subject: [patch V4 39/41] x86/apic: Remove unused phys_pkg_id() callback
References: <20230814085006.593997112@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Mon, 14 Aug 2023 10:54:35 +0200 (CEST)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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
Tested-by: Juergen Gross <jgross@suse.com>
Tested-by: Sohil Mehta <sohil.mehta@intel.com>
Tested-by: Michael Kelley <mikelley@microsoft.com>

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



