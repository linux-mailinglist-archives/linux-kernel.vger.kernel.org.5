Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 322B8766CC9
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 14:13:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236490AbjG1MN5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 08:13:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235681AbjG1MNP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 08:13:15 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA7A130F9;
        Fri, 28 Jul 2023 05:13:02 -0700 (PDT)
Message-ID: <20230728120930.507111034@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1690546381;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=W4xJH6LNgggvbfJwkBitKsfr5A0Xep6DiT5K2fgkXGw=;
        b=kbqWVwwOzXpAft31szPAljDVPfjIblzxpOgU/0ALd58Z90/UObD4LkwKM6676TUNaM67nE
        5DTSKxXu78WS+4TshVrx0yYTQEJhwQLUHHGK9t1MdYYD8CMxzbt/93Ztj1YlJSnE1xs5hT
        aILVnUgoQfxwyJ31EHTcp/bJnQw1YKf7PCMC59WpEoFuG3ufy0f9+X8fADW50M04hNRyEG
        w982dqy480CJeOGkv7iG021Cs93aDWg1PEOeMdHVm13WfHiNBZguunYkK6iv1nO9/UCX3Z
        +MHOilHVZc87CGNlH/0P01sYa9HNTVj+DMrTdPhf8bAW5+Jua86qITMxN5Q3uA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1690546381;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=W4xJH6LNgggvbfJwkBitKsfr5A0Xep6DiT5K2fgkXGw=;
        b=4QoM3dLWvdVm6eqIf2FsVieDCiPNIhPXjfsQvnvU+Q5oSUg4SioE9lAzulimAeUTU8DYE8
        kMu+pOwRfHgVZUAQ==
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
Subject: [patch v2 15/38] x86/apic: Use u32 for phys_pkg_id()
References: <20230728105650.565799744@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Fri, 28 Jul 2023 14:13:01 +0200 (CEST)
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
register width even if that callback going to be removed soonish.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/include/asm/apic.h          |    2 +-
 arch/x86/kernel/apic/apic_flat_64.c  |    2 +-
 arch/x86/kernel/apic/apic_noop.c     |    2 +-
 arch/x86/kernel/apic/apic_numachip.c |    2 +-
 arch/x86/kernel/apic/bigsmp_32.c     |    2 +-
 arch/x86/kernel/apic/local.h         |    2 +-
 arch/x86/kernel/apic/probe_32.c      |    2 +-
 arch/x86/kernel/apic/x2apic_phys.c   |    2 +-
 arch/x86/kernel/apic/x2apic_uv_x.c   |    2 +-
 arch/x86/kernel/vsmp_64.c            |    2 +-
 arch/x86/xen/apic.c                  |    2 +-
 11 files changed, 11 insertions(+), 11 deletions(-)

--- a/arch/x86/include/asm/apic.h
+++ b/arch/x86/include/asm/apic.h
@@ -296,7 +296,7 @@ struct apic {
 	void	(*init_apic_ldr)(void);
 	void	(*ioapic_phys_id_map)(physid_mask_t *phys_map, physid_mask_t *retmap);
 	u32	(*cpu_present_to_apicid)(int mps_cpu);
-	int	(*phys_pkg_id)(int cpuid_apic, int index_msb);
+	u32	(*phys_pkg_id)(u32 cpuid_apic, int index_msb);
 
 	u32	(*get_apic_id)(unsigned long x);
 	u32	(*set_apic_id)(unsigned int id);
--- a/arch/x86/kernel/apic/apic_flat_64.c
+++ b/arch/x86/kernel/apic/apic_flat_64.c
@@ -66,7 +66,7 @@ static u32 set_apic_id(unsigned int id)
 	return (id & 0xFF) << 24;
 }
 
-static int flat_phys_pkg_id(int initial_apic_id, int index_msb)
+static u32 flat_phys_pkg_id(u32 initial_apic_id, int index_msb)
 {
 	return initial_apic_id >> index_msb;
 }
--- a/arch/x86/kernel/apic/apic_noop.c
+++ b/arch/x86/kernel/apic/apic_noop.c
@@ -29,7 +29,7 @@ static void noop_send_IPI_self(int vecto
 static void noop_apic_icr_write(u32 low, u32 id) { }
 static int noop_wakeup_secondary_cpu(int apicid, unsigned long start_eip) { return -1; }
 static u64 noop_apic_icr_read(void) { return 0; }
-static int noop_phys_pkg_id(int cpuid_apic, int index_msb) { return 0; }
+static u32 noop_phys_pkg_id(u32 cpuid_apic, int index_msb) { return 0; }
 static unsigned int noop_get_apic_id(unsigned long x) { return 0; }
 static void noop_apic_eoi(void) { }
 
--- a/arch/x86/kernel/apic/apic_numachip.c
+++ b/arch/x86/kernel/apic/apic_numachip.c
@@ -56,7 +56,7 @@ static u32 numachip2_set_apic_id(unsigne
 	return id << 24;
 }
 
-static int numachip_phys_pkg_id(int initial_apic_id, int index_msb)
+static u32 numachip_phys_pkg_id(u32 initial_apic_id, int index_msb)
 {
 	return initial_apic_id >> index_msb;
 }
--- a/arch/x86/kernel/apic/bigsmp_32.c
+++ b/arch/x86/kernel/apic/bigsmp_32.c
@@ -29,7 +29,7 @@ static void bigsmp_ioapic_phys_id_map(ph
 	physids_promote(0xFFL, retmap);
 }
 
-static int bigsmp_phys_pkg_id(int cpuid_apic, int index_msb)
+static u32 bigsmp_phys_pkg_id(u32 cpuid_apic, int index_msb)
 {
 	return cpuid_apic >> index_msb;
 }
--- a/arch/x86/kernel/apic/local.h
+++ b/arch/x86/kernel/apic/local.h
@@ -17,7 +17,7 @@
 void __x2apic_send_IPI_dest(unsigned int apicid, int vector, unsigned int dest);
 unsigned int x2apic_get_apic_id(unsigned long id);
 u32 x2apic_set_apic_id(unsigned int id);
-int x2apic_phys_pkg_id(int initial_apicid, int index_msb);
+u32 x2apic_phys_pkg_id(u32 initial_apicid, int index_msb);
 
 void x2apic_send_IPI_all(int vector);
 void x2apic_send_IPI_allbutself(int vector);
--- a/arch/x86/kernel/apic/probe_32.c
+++ b/arch/x86/kernel/apic/probe_32.c
@@ -18,7 +18,7 @@
 
 #include "local.h"
 
-static int default_phys_pkg_id(int cpuid_apic, int index_msb)
+static u32 default_phys_pkg_id(u32 cpuid_apic, int index_msb)
 {
 	return cpuid_apic >> index_msb;
 }
--- a/arch/x86/kernel/apic/x2apic_phys.c
+++ b/arch/x86/kernel/apic/x2apic_phys.c
@@ -134,7 +134,7 @@ u32 x2apic_set_apic_id(unsigned int id)
 	return id;
 }
 
-int x2apic_phys_pkg_id(int initial_apicid, int index_msb)
+u32 x2apic_phys_pkg_id(u32 initial_apicid, int index_msb)
 {
 	return initial_apicid >> index_msb;
 }
--- a/arch/x86/kernel/apic/x2apic_uv_x.c
+++ b/arch/x86/kernel/apic/x2apic_uv_x.c
@@ -790,7 +790,7 @@ static unsigned int uv_read_apic_id(void
 	return x2apic_get_apic_id(apic_read(APIC_ID));
 }
 
-static int uv_phys_pkg_id(int initial_apicid, int index_msb)
+static u32 uv_phys_pkg_id(u32 initial_apicid, int index_msb)
 {
 	return uv_read_apic_id() >> index_msb;
 }
--- a/arch/x86/kernel/vsmp_64.c
+++ b/arch/x86/kernel/vsmp_64.c
@@ -127,7 +127,7 @@ static void __init vsmp_cap_cpus(void)
 #endif
 }
 
-static int apicid_phys_pkg_id(int initial_apic_id, int index_msb)
+static u32 apicid_phys_pkg_id(u32 initial_apic_id, int index_msb)
 {
 	return read_apic_id() >> index_msb;
 }
--- a/arch/x86/xen/apic.c
+++ b/arch/x86/xen/apic.c
@@ -110,7 +110,7 @@ static int xen_madt_oem_check(char *oem_
 	return xen_pv_domain();
 }
 
-static int xen_phys_pkg_id(int initial_apic_id, int index_msb)
+static u32 xen_phys_pkg_id(u32 initial_apic_id, int index_msb)
 {
 	return initial_apic_id >> index_msb;
 }

