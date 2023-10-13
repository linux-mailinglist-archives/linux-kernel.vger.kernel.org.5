Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47C6D7C8236
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 11:38:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231274AbjJMJiR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 05:38:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231196AbjJMJiJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 05:38:09 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27DCD95;
        Fri, 13 Oct 2023 02:38:06 -0700 (PDT)
Date:   Fri, 13 Oct 2023 09:38:03 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1697189884;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ENnhf9WHod1cSTNqvSjKz8Kte6sw5odisd1m07h2aa4=;
        b=KdSqqnYXU5Q7DIAFL5ILfEW/HjEi8VdURSRpyx/WGz1olklGQNJ+c9y1eWXIWLAe/5keAb
        IFlWs0IKFOs9aaVoQ7diK8VKfXS0hfDqHzLdmqmdssQh54f4dvTD4jNn0WQxrOrUwnCb+N
        /1tS3CT8TM3Z6IMXRYxdWYzkaWndx+Xu+vyqlkSTb7m8YENyBr2B9IqnNjv0MCLWJrYW/S
        2UctPcQo/ZDJPinFXf6sZgnBPUOvfQAsEZoBUYYIyM2RU0c0JDDS36jlPUbMH2nehijvU5
        0+nomvn5GCkmrk+TQF6pEaxc27qCyYGTN3NxPevyyxu8om3Pz0qZ/R2E4hM+uA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1697189884;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ENnhf9WHod1cSTNqvSjKz8Kte6sw5odisd1m07h2aa4=;
        b=Qz6OSDWZA83fEwAGebQWeR0QJhzsF1C+ZGqdopW89tC2mMwJvG0UOXMgrIhUYcei2yUong
        20PkiuRV2QZvEWBw==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/core] x86/apic: Use u32 for wakeup_secondary_cpu[_64]()
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Juergen Gross <jgross@suse.com>,
        Sohil Mehta <sohil.mehta@intel.com>,
        Michael Kelley <mikelley@microsoft.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Arjan van de Ven <arjan@linux.intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230814085113.233274223@linutronix.de>
References: <20230814085113.233274223@linutronix.de>
MIME-Version: 1.0
Message-ID: <169718988398.3135.6679425161184932040.tip-bot2@tip-bot2>
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

Commit-ID:     db4a4086a223bd5cbfa5a66701c493124d808d55
Gitweb:        https://git.kernel.org/tip/db4a4086a223bd5cbfa5a66701c493124d808d55
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Mon, 14 Aug 2023 10:18:45 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 10 Oct 2023 14:38:19 +02:00

x86/apic: Use u32 for wakeup_secondary_cpu[_64]()

APIC IDs are used with random data types u16, u32, int, unsigned int,
unsigned long.

Make it all consistently use u32 because that reflects the hardware
register width.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Juergen Gross <jgross@suse.com>
Tested-by: Sohil Mehta <sohil.mehta@intel.com>
Tested-by: Michael Kelley <mikelley@microsoft.com>
Tested-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Tested-by: Zhang Rui <rui.zhang@intel.com>
Reviewed-by: Arjan van de Ven <arjan@linux.intel.com>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/20230814085113.233274223@linutronix.de

---
 arch/x86/hyperv/hv_vtl.c             | 2 +-
 arch/x86/include/asm/apic.h          | 8 ++++----
 arch/x86/kernel/acpi/boot.c          | 2 +-
 arch/x86/kernel/apic/apic_noop.c     | 2 +-
 arch/x86/kernel/apic/apic_numachip.c | 2 +-
 arch/x86/kernel/apic/x2apic_uv_x.c   | 2 +-
 arch/x86/kernel/sev.c                | 2 +-
 7 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/arch/x86/hyperv/hv_vtl.c b/arch/x86/hyperv/hv_vtl.c
index 36a5622..052c5b5 100644
--- a/arch/x86/hyperv/hv_vtl.c
+++ b/arch/x86/hyperv/hv_vtl.c
@@ -196,7 +196,7 @@ static int hv_vtl_apicid_to_vp_id(u32 apic_id)
 	return ret;
 }
 
-static int hv_vtl_wakeup_secondary_cpu(int apicid, unsigned long start_eip)
+static int hv_vtl_wakeup_secondary_cpu(u32 apicid, unsigned long start_eip)
 {
 	int vp_id;
 
diff --git a/arch/x86/include/asm/apic.h b/arch/x86/include/asm/apic.h
index e7b45f2..b0d192f 100644
--- a/arch/x86/include/asm/apic.h
+++ b/arch/x86/include/asm/apic.h
@@ -302,9 +302,9 @@ struct apic {
 	u32	(*set_apic_id)(u32 apicid);
 
 	/* wakeup_secondary_cpu */
-	int	(*wakeup_secondary_cpu)(int apicid, unsigned long start_eip);
+	int	(*wakeup_secondary_cpu)(u32 apicid, unsigned long start_eip);
 	/* wakeup secondary CPU using 64-bit wakeup point */
-	int	(*wakeup_secondary_cpu_64)(int apicid, unsigned long start_eip);
+	int	(*wakeup_secondary_cpu_64)(u32 apicid, unsigned long start_eip);
 
 	char	*name;
 };
@@ -322,8 +322,8 @@ struct apic_override {
 	void	(*send_IPI_self)(int vector);
 	u64	(*icr_read)(void);
 	void	(*icr_write)(u32 low, u32 high);
-	int	(*wakeup_secondary_cpu)(int apicid, unsigned long start_eip);
-	int	(*wakeup_secondary_cpu_64)(int apicid, unsigned long start_eip);
+	int	(*wakeup_secondary_cpu)(u32 apicid, unsigned long start_eip);
+	int	(*wakeup_secondary_cpu_64)(u32 apicid, unsigned long start_eip);
 };
 
 /*
diff --git a/arch/x86/kernel/acpi/boot.c b/arch/x86/kernel/acpi/boot.c
index f3e4d35..c545070 100644
--- a/arch/x86/kernel/acpi/boot.c
+++ b/arch/x86/kernel/acpi/boot.c
@@ -359,7 +359,7 @@ acpi_parse_lapic_nmi(union acpi_subtable_headers * header, const unsigned long e
 }
 
 #ifdef CONFIG_X86_64
-static int acpi_wakeup_cpu(int apicid, unsigned long start_ip)
+static int acpi_wakeup_cpu(u32 apicid, unsigned long start_ip)
 {
 	/*
 	 * Remap mailbox memory only for the first call to acpi_wakeup_cpu().
diff --git a/arch/x86/kernel/apic/apic_noop.c b/arch/x86/kernel/apic/apic_noop.c
index f111486..b00d52a 100644
--- a/arch/x86/kernel/apic/apic_noop.c
+++ b/arch/x86/kernel/apic/apic_noop.c
@@ -27,7 +27,7 @@ static void noop_send_IPI_allbutself(int vector) { }
 static void noop_send_IPI_all(int vector) { }
 static void noop_send_IPI_self(int vector) { }
 static void noop_apic_icr_write(u32 low, u32 id) { }
-static int noop_wakeup_secondary_cpu(int apicid, unsigned long start_eip) { return -1; }
+static int noop_wakeup_secondary_cpu(u32 apicid, unsigned long start_eip) { return -1; }
 static u64 noop_apic_icr_read(void) { return 0; }
 static u32 noop_phys_pkg_id(u32 cpuid_apic, int index_msb) { return 0; }
 static u32 noop_get_apic_id(u32 apicid) { return 0; }
diff --git a/arch/x86/kernel/apic/apic_numachip.c b/arch/x86/kernel/apic/apic_numachip.c
index af350b4..456a14c 100644
--- a/arch/x86/kernel/apic/apic_numachip.c
+++ b/arch/x86/kernel/apic/apic_numachip.c
@@ -71,7 +71,7 @@ static void numachip2_apic_icr_write(int apicid, unsigned int val)
 	numachip2_write32_lcsr(NUMACHIP2_APIC_ICR, (apicid << 12) | val);
 }
 
-static int numachip_wakeup_secondary(int phys_apicid, unsigned long start_rip)
+static int numachip_wakeup_secondary(u32 phys_apicid, unsigned long start_rip)
 {
 	numachip_apic_icr_write(phys_apicid, APIC_DM_INIT);
 	numachip_apic_icr_write(phys_apicid, APIC_DM_STARTUP |
diff --git a/arch/x86/kernel/apic/x2apic_uv_x.c b/arch/x86/kernel/apic/x2apic_uv_x.c
index 46d4de2..6efc499 100644
--- a/arch/x86/kernel/apic/x2apic_uv_x.c
+++ b/arch/x86/kernel/apic/x2apic_uv_x.c
@@ -701,7 +701,7 @@ static __init void build_uv_gr_table(void)
 	}
 }
 
-static int uv_wakeup_secondary(int phys_apicid, unsigned long start_rip)
+static int uv_wakeup_secondary(u32 phys_apicid, unsigned long start_rip)
 {
 	unsigned long val;
 	int pnode;
diff --git a/arch/x86/kernel/sev.c b/arch/x86/kernel/sev.c
index 2787826..edf9b74 100644
--- a/arch/x86/kernel/sev.c
+++ b/arch/x86/kernel/sev.c
@@ -940,7 +940,7 @@ static void snp_cleanup_vmsa(struct sev_es_save_area *vmsa)
 		free_page((unsigned long)vmsa);
 }
 
-static int wakeup_cpu_via_vmgexit(int apic_id, unsigned long start_ip)
+static int wakeup_cpu_via_vmgexit(u32 apic_id, unsigned long start_ip)
 {
 	struct sev_es_save_area *cur_vmsa, *vmsa;
 	struct ghcb_state state;
