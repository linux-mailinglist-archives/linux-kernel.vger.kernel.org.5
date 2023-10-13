Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E1E97C823C
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 11:38:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231308AbjJMJiT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 05:38:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231194AbjJMJiJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 05:38:09 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E69BC9;
        Fri, 13 Oct 2023 02:38:07 -0700 (PDT)
Date:   Fri, 13 Oct 2023 09:38:05 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1697189885;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7Fr/mYsTbxjMk8a+Dy+XO5W/1MZroba8ucAOzvnctbo=;
        b=HDrSxQIdfmEUxagEneUjhqy8MZxN/V8e1wuELKojVvwBqx1wM+VTjuQ9zxt4/gFGyAOk2a
        kRxYm1h/hPsWabOVRaJgyOReRY1gGo/kJAu7kQu9s1oYobA/b+0X4ZHWZcIMEDhFhFi6s7
        pLs5Zcptvh0YmThCX9cmJuxnvNtg0B91VkzmZR/9oyliAqJMy+/zhPA7cW4klESbcLab5g
        olh1euvS+1+m3rKyqh589DnupHDcFcKT1zkl+QVVX4Bn/9wJ0MII9E7BE4NHRO9F/mym5X
        WDHONiPvYF6osnmRXOOh+n2KXwv392O/qazTZbyL6BtWtqtEVIfmm7fhcctAFA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1697189885;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7Fr/mYsTbxjMk8a+Dy+XO5W/1MZroba8ucAOzvnctbo=;
        b=gNcLfA3GE1ehKYeMNx7ubzhPvJ/vkXmHZH3XHVxQycgT5lwBkMt6/Pgn6h47ne6tFjzhFP
        xXtctmkvSEh2PyDw==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/core] x86/apic: Use u32 for phys_pkg_id()
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Juergen Gross <jgross@suse.com>,
        Sohil Mehta <sohil.mehta@intel.com>,
        Michael Kelley <mikelley@microsoft.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Arjan van de Ven <arjan@linux.intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230814085113.113097126@linutronix.de>
References: <20230814085113.113097126@linutronix.de>
MIME-Version: 1.0
Message-ID: <169718988510.3135.15158304535215734141.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/core branch of tip:

Commit-ID:     01ccf9bbd25fa32baa6ed8ae16700cf2e4487cf5
Gitweb:        https://git.kernel.org/tip/01ccf9bbd25fa32baa6ed8ae16700cf2e4487cf5
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Mon, 14 Aug 2023 10:18:43 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 10 Oct 2023 14:38:19 +02:00

x86/apic: Use u32 for phys_pkg_id()

APIC IDs are used with random data types u16, u32, int, unsigned int,
unsigned long.

Make it all consistently use u32 because that reflects the hardware
register width even if that callback going to be removed soonish.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Juergen Gross <jgross@suse.com>
Tested-by: Sohil Mehta <sohil.mehta@intel.com>
Tested-by: Michael Kelley <mikelley@microsoft.com>
Tested-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Tested-by: Zhang Rui <rui.zhang@intel.com>
Reviewed-by: Arjan van de Ven <arjan@linux.intel.com>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/20230814085113.113097126@linutronix.de

---
 arch/x86/include/asm/apic.h          | 2 +-
 arch/x86/kernel/apic/apic_flat_64.c  | 2 +-
 arch/x86/kernel/apic/apic_noop.c     | 2 +-
 arch/x86/kernel/apic/apic_numachip.c | 2 +-
 arch/x86/kernel/apic/bigsmp_32.c     | 2 +-
 arch/x86/kernel/apic/local.h         | 2 +-
 arch/x86/kernel/apic/probe_32.c      | 2 +-
 arch/x86/kernel/apic/x2apic_phys.c   | 2 +-
 arch/x86/kernel/apic/x2apic_uv_x.c   | 2 +-
 arch/x86/kernel/vsmp_64.c            | 2 +-
 arch/x86/xen/apic.c                  | 2 +-
 11 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/arch/x86/include/asm/apic.h b/arch/x86/include/asm/apic.h
index 42a6adf..0788c46 100644
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
diff --git a/arch/x86/kernel/apic/apic_flat_64.c b/arch/x86/kernel/apic/apic_flat_64.c
index a5364a4..ca05aca 100644
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
diff --git a/arch/x86/kernel/apic/apic_noop.c b/arch/x86/kernel/apic/apic_noop.c
index f834a20..28ea342 100644
--- a/arch/x86/kernel/apic/apic_noop.c
+++ b/arch/x86/kernel/apic/apic_noop.c
@@ -29,7 +29,7 @@ static void noop_send_IPI_self(int vector) { }
 static void noop_apic_icr_write(u32 low, u32 id) { }
 static int noop_wakeup_secondary_cpu(int apicid, unsigned long start_eip) { return -1; }
 static u64 noop_apic_icr_read(void) { return 0; }
-static int noop_phys_pkg_id(int cpuid_apic, int index_msb) { return 0; }
+static u32 noop_phys_pkg_id(u32 cpuid_apic, int index_msb) { return 0; }
 static unsigned int noop_get_apic_id(unsigned long x) { return 0; }
 static void noop_apic_eoi(void) { }
 
diff --git a/arch/x86/kernel/apic/apic_numachip.c b/arch/x86/kernel/apic/apic_numachip.c
index 32a5e03..c35181c 100644
--- a/arch/x86/kernel/apic/apic_numachip.c
+++ b/arch/x86/kernel/apic/apic_numachip.c
@@ -56,7 +56,7 @@ static u32 numachip2_set_apic_id(unsigned int id)
 	return id << 24;
 }
 
-static int numachip_phys_pkg_id(int initial_apic_id, int index_msb)
+static u32 numachip_phys_pkg_id(u32 initial_apic_id, int index_msb)
 {
 	return initial_apic_id >> index_msb;
 }
diff --git a/arch/x86/kernel/apic/bigsmp_32.c b/arch/x86/kernel/apic/bigsmp_32.c
index 52ac447..3c95e0b 100644
--- a/arch/x86/kernel/apic/bigsmp_32.c
+++ b/arch/x86/kernel/apic/bigsmp_32.c
@@ -29,7 +29,7 @@ static void bigsmp_ioapic_phys_id_map(physid_mask_t *phys_map, physid_mask_t *re
 	physids_promote(0xFFL, retmap);
 }
 
-static int bigsmp_phys_pkg_id(int cpuid_apic, int index_msb)
+static u32 bigsmp_phys_pkg_id(u32 cpuid_apic, int index_msb)
 {
 	return cpuid_apic >> index_msb;
 }
diff --git a/arch/x86/kernel/apic/local.h b/arch/x86/kernel/apic/local.h
index 860d90b..2bf0d1c 100644
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
diff --git a/arch/x86/kernel/apic/probe_32.c b/arch/x86/kernel/apic/probe_32.c
index 9a06df6..2867fa6 100644
--- a/arch/x86/kernel/apic/probe_32.c
+++ b/arch/x86/kernel/apic/probe_32.c
@@ -18,7 +18,7 @@
 
 #include "local.h"
 
-static int default_phys_pkg_id(int cpuid_apic, int index_msb)
+static u32 default_phys_pkg_id(u32 cpuid_apic, int index_msb)
 {
 	return cpuid_apic >> index_msb;
 }
diff --git a/arch/x86/kernel/apic/x2apic_phys.c b/arch/x86/kernel/apic/x2apic_phys.c
index 788cdb4..55cbcec 100644
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
diff --git a/arch/x86/kernel/apic/x2apic_uv_x.c b/arch/x86/kernel/apic/x2apic_uv_x.c
index d9f5d74..3589ab6 100644
--- a/arch/x86/kernel/apic/x2apic_uv_x.c
+++ b/arch/x86/kernel/apic/x2apic_uv_x.c
@@ -789,7 +789,7 @@ static unsigned int uv_read_apic_id(void)
 	return x2apic_get_apic_id(apic_read(APIC_ID));
 }
 
-static int uv_phys_pkg_id(int initial_apicid, int index_msb)
+static u32 uv_phys_pkg_id(u32 initial_apicid, int index_msb)
 {
 	return uv_read_apic_id() >> index_msb;
 }
diff --git a/arch/x86/kernel/vsmp_64.c b/arch/x86/kernel/vsmp_64.c
index 65e96b7..d3fc017 100644
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
diff --git a/arch/x86/xen/apic.c b/arch/x86/xen/apic.c
index c830ad4..40538b2 100644
--- a/arch/x86/xen/apic.c
+++ b/arch/x86/xen/apic.c
@@ -110,7 +110,7 @@ static int xen_madt_oem_check(char *oem_id, char *oem_table_id)
 	return xen_pv_domain();
 }
 
-static int xen_phys_pkg_id(int initial_apic_id, int index_msb)
+static u32 xen_phys_pkg_id(u32 initial_apic_id, int index_msb)
 {
 	return initial_apic_id >> index_msb;
 }
