Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48BCC7C8244
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 11:38:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231382AbjJMJi2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 05:38:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231208AbjJMJiK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 05:38:10 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87C24BE;
        Fri, 13 Oct 2023 02:38:08 -0700 (PDT)
Date:   Fri, 13 Oct 2023 09:38:06 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1697189886;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oQKwGQtwqztvMgre7XLgIBQlyLqqnaOHhB81jRJR8/8=;
        b=O7tJ2n9dK7uFjv5G8/yc69SUsyb8s4Mvk31qKRWkgxJ9vzCbI/pCrDdacgaGMrgEe2MEfI
        uoJgnTemtyzPPTY6z0xfaWAWUCf4GaFzz6l+9H40W1JZAeQQLUgVZVIwqbU8+ZAHfgA96i
        /Xzk/aDMFCSJugZKVK4bngodddyxH6sI5GUdhqQPaSTeeq0dk2ZslMNMOzjDG1PWvnpt/Z
        BsQSErAGRHr+UaH+oiI9/NNIrUUTBrGCg5A68RzpbHkLJxVj/scoNPDWdzZLotHBPFodC0
        BsfTm9VCqQcBfX3rv6L2iTC/me+E/JVSGYmVRNrLw4UvkNysSgiS0r9jVsm/yw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1697189886;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oQKwGQtwqztvMgre7XLgIBQlyLqqnaOHhB81jRJR8/8=;
        b=Xfc9uj6oTOep2IPq/65F41+2acvcn9F3yDEpxRl8FU43wmX835BK98ctZ+xHaV7CiPc+qw
        Go3ARHELRbhx4eAQ==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/core] x86/apic: Use u32 for check_apicid_used()
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Juergen Gross <jgross@suse.com>,
        Sohil Mehta <sohil.mehta@intel.com>,
        Michael Kelley <mikelley@microsoft.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Arjan van de Ven <arjan@linux.intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230814085112.981956102@linutronix.de>
References: <20230814085112.981956102@linutronix.de>
MIME-Version: 1.0
Message-ID: <169718988617.3135.18121783861517995652.tip-bot2@tip-bot2>
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

Commit-ID:     5d376b8fb165eca33ea166ee43a637c8e912abd4
Gitweb:        https://git.kernel.org/tip/5d376b8fb165eca33ea166ee43a637c8e912abd4
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Mon, 14 Aug 2023 10:18:41 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 10 Oct 2023 14:38:18 +02:00

x86/apic: Use u32 for check_apicid_used()

APIC IDs are used with random data types u16, u32, int, unsigned int,
unsigned long.

Make it all consistently use u32 because that reflects the hardware
register width and move the default implementation to local.h as there are
no users outside the apic directory.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Juergen Gross <jgross@suse.com>
Tested-by: Sohil Mehta <sohil.mehta@intel.com>
Tested-by: Michael Kelley <mikelley@microsoft.com>
Tested-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Tested-by: Zhang Rui <rui.zhang@intel.com>
Reviewed-by: Arjan van de Ven <arjan@linux.intel.com>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/20230814085112.981956102@linutronix.de

---
 arch/x86/include/asm/apic.h         | 3 +--
 arch/x86/kernel/apic/apic_common.c  | 2 +-
 arch/x86/kernel/apic/apic_flat_64.c | 2 --
 arch/x86/kernel/apic/apic_noop.c    | 2 ++
 arch/x86/kernel/apic/bigsmp_32.c    | 2 +-
 arch/x86/kernel/apic/local.h        | 1 +
 6 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/x86/include/asm/apic.h b/arch/x86/include/asm/apic.h
index a7ac05c..e970697 100644
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
@@ -538,7 +538,6 @@ extern int default_apic_id_valid(u32 apicid);
 extern u32 apic_default_calc_apicid(unsigned int cpu);
 extern u32 apic_flat_calc_apicid(unsigned int cpu);
 
-extern bool default_check_apicid_used(physid_mask_t *map, int apicid);
 extern void default_ioapic_phys_id_map(physid_mask_t *phys_map, physid_mask_t *retmap);
 extern int default_cpu_present_to_apicid(int mps_cpu);
 
diff --git a/arch/x86/kernel/apic/apic_common.c b/arch/x86/kernel/apic/apic_common.c
index 7bc5d9b..ca73c3a 100644
--- a/arch/x86/kernel/apic/apic_common.c
+++ b/arch/x86/kernel/apic/apic_common.c
@@ -18,7 +18,7 @@ u32 apic_flat_calc_apicid(unsigned int cpu)
 	return 1U << cpu;
 }
 
-bool default_check_apicid_used(physid_mask_t *map, int apicid)
+bool default_check_apicid_used(physid_mask_t *map, u32 apicid)
 {
 	return physid_isset(apicid, *map);
 }
diff --git a/arch/x86/kernel/apic/apic_flat_64.c b/arch/x86/kernel/apic/apic_flat_64.c
index 032a84e..a5364a4 100644
--- a/arch/x86/kernel/apic/apic_flat_64.c
+++ b/arch/x86/kernel/apic/apic_flat_64.c
@@ -158,8 +158,6 @@ static struct apic apic_physflat __ro_after_init = {
 
 	.disable_esr			= 0,
 
-	.check_apicid_used		= NULL,
-	.ioapic_phys_id_map		= NULL,
 	.cpu_present_to_apicid		= default_cpu_present_to_apicid,
 	.phys_pkg_id			= flat_phys_pkg_id,
 
diff --git a/arch/x86/kernel/apic/apic_noop.c b/arch/x86/kernel/apic/apic_noop.c
index 966d7cf..f834a20 100644
--- a/arch/x86/kernel/apic/apic_noop.c
+++ b/arch/x86/kernel/apic/apic_noop.c
@@ -18,6 +18,8 @@
 
 #include <asm/apic.h>
 
+#include "local.h"
+
 static void noop_send_IPI(int cpu, int vector) { }
 static void noop_send_IPI_mask(const struct cpumask *cpumask, int vector) { }
 static void noop_send_IPI_mask_allbutself(const struct cpumask *cpumask, int vector) { }
diff --git a/arch/x86/kernel/apic/bigsmp_32.c b/arch/x86/kernel/apic/bigsmp_32.c
index 0e5535a..52ac447 100644
--- a/arch/x86/kernel/apic/bigsmp_32.c
+++ b/arch/x86/kernel/apic/bigsmp_32.c
@@ -18,7 +18,7 @@ static unsigned bigsmp_get_apic_id(unsigned long x)
 	return (x >> 24) & 0xFF;
 }
 
-static bool bigsmp_check_apicid_used(physid_mask_t *map, int apicid)
+static bool bigsmp_check_apicid_used(physid_mask_t *map, u32 apicid)
 {
 	return false;
 }
diff --git a/arch/x86/kernel/apic/local.h b/arch/x86/kernel/apic/local.h
index ec219c6..860d90b 100644
--- a/arch/x86/kernel/apic/local.h
+++ b/arch/x86/kernel/apic/local.h
@@ -64,6 +64,7 @@ void default_send_IPI_all(int vector);
 void default_send_IPI_self(int vector);
 
 bool default_apic_id_registered(void);
+bool default_check_apicid_used(physid_mask_t *map, u32 apicid);
 
 #ifdef CONFIG_X86_32
 void default_send_IPI_mask_sequence_logical(const struct cpumask *mask, int vector);
