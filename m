Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1979C77B4CC
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 10:55:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232958AbjHNIzF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 04:55:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234967AbjHNIyF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 04:54:05 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AB5591
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 01:54:04 -0700 (PDT)
Message-ID: <20230814085113.113097126@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1692003242;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=7SOzmaEyGyIDUT14N4JmbxJU+8tyxoAvV5vfItI8g6Q=;
        b=a8MF9II0CmhB+rgzxrFUNrea9PLndHQA7HloQ9fozBnW1QVkxoHMIeWA4w4lDgCY4CFEpo
        qgZaqNF4J7N6wGO0e/KEnehc3xPLLlTzcgFpLa8QpWGpOZGjTzdzT44bDRq2ulWcMbFXtl
        A89FVQSTOfKs5I+I1mltIog+vwOp988j/OtNXwIdyLspiyMIM2BHzyBWCtdFJm7QOu5s8E
        9LoQPvJLNyEqo0oInMVrqVEV2ortytD5Airo/dZ2cfVzWhrbIVeZw9E4To28FophBJAwM8
        DakTySDWziZuqwKlGZPfTCarwvoobjmHWi1Z8uCT8aIOVJyDOKEwt4RnjXE3Lg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1692003242;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=7SOzmaEyGyIDUT14N4JmbxJU+8tyxoAvV5vfItI8g6Q=;
        b=p0xIMa+LKqhP59qtSyqFfFUjqTQMvMKme/dnMH2u9SGwgtvkJfgFmdyuJe3P6M7IOStma2
        coIICOov5P+2GGBg==
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
Subject: [patch V4 18/41] x86/apic: Use u32 for phys_pkg_id()
References: <20230814085006.593997112@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Mon, 14 Aug 2023 10:54:02 +0200 (CEST)
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
register width even if that callback going to be removed soonish.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Juergen Gross <jgross@suse.com>
Tested-by: Sohil Mehta <sohil.mehta@intel.com>
Tested-by: Michael Kelley <mikelley@microsoft.com>
Reviewed-by: Arjan van de Ven <arjan@linux.intel.com>

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



