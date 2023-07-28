Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4022766CCC
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 14:14:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234138AbjG1MOH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 08:14:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236053AbjG1MNX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 08:13:23 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A83F63C29;
        Fri, 28 Jul 2023 05:13:05 -0700 (PDT)
Message-ID: <20230728120930.617454900@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1690546384;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=5gVNK3rCq4noBF0xg9HsQLWamUWdjKHKucBFvU6ybvE=;
        b=G2xt2VMQ0POlA92nedDC+wu1TLMwvF68Xl6/B0JqQ001JqNPuPvQe7iJuLNQ/l5TNyo6bs
        KZhHwDYIdT1vr9BD4voWtUWuqEbZnjtKSh9JMC1MazsiwrXZlawWVaT+JWffgsnlOcJ/Lr
        bBY6sETe22ClCa0KXAFufp1hE3KM+BAISyalVByMB368H16IfhBzVoAq/t4nr1W01C0nSC
        z0F8AwGuN/i1F1LjD6YZ0yuWxlJ9rjxXyjtyxLaOz2VGZRYvh/K0/5fij1CAsclvF4oo7W
        8xMFamlpue6kPqSjXw/8WmBJ6X9HBM/IgZmyEyFIeUgjoORRYFnVEsXVx2yvvg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1690546384;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=5gVNK3rCq4noBF0xg9HsQLWamUWdjKHKucBFvU6ybvE=;
        b=QG238KyZZUyzVmtipu84Nj0/Jegu+8qNBqa2QpsmaNZEQIx29D0ntPxP0CO0Gzd42F6QYP
        4G4SB4vTFr5F1kCw==
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
Subject: [patch v2 17/38] x86/apic: Use u32 for wakeup_secondary_cpu[_64]()
References: <20230728105650.565799744@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Fri, 28 Jul 2023 14:13:03 +0200 (CEST)
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
register width.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/hyperv/hv_vtl.c             |    2 +-
 arch/x86/include/asm/apic.h          |    8 ++++----
 arch/x86/kernel/acpi/boot.c          |    2 +-
 arch/x86/kernel/apic/apic_noop.c     |    2 +-
 arch/x86/kernel/apic/apic_numachip.c |    2 +-
 arch/x86/kernel/apic/x2apic_uv_x.c   |    2 +-
 arch/x86/kernel/sev.c                |    2 +-
 7 files changed, 10 insertions(+), 10 deletions(-)

--- a/arch/x86/hyperv/hv_vtl.c
+++ b/arch/x86/hyperv/hv_vtl.c
@@ -192,7 +192,7 @@ static int hv_vtl_apicid_to_vp_id(u32 ap
 	return ret;
 }
 
-static int hv_vtl_wakeup_secondary_cpu(int apicid, unsigned long start_eip)
+static int hv_vtl_wakeup_secondary_cpu(u32 apicid, unsigned long start_eip)
 {
 	int vp_id;
 
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
--- a/arch/x86/kernel/acpi/boot.c
+++ b/arch/x86/kernel/acpi/boot.c
@@ -358,7 +358,7 @@ acpi_parse_lapic_nmi(union acpi_subtable
 }
 
 #ifdef CONFIG_X86_64
-static int acpi_wakeup_cpu(int apicid, unsigned long start_ip)
+static int acpi_wakeup_cpu(u32 apicid, unsigned long start_ip)
 {
 	/*
 	 * Remap mailbox memory only for the first call to acpi_wakeup_cpu().
--- a/arch/x86/kernel/apic/apic_noop.c
+++ b/arch/x86/kernel/apic/apic_noop.c
@@ -27,7 +27,7 @@ static void noop_send_IPI_allbutself(int
 static void noop_send_IPI_all(int vector) { }
 static void noop_send_IPI_self(int vector) { }
 static void noop_apic_icr_write(u32 low, u32 id) { }
-static int noop_wakeup_secondary_cpu(int apicid, unsigned long start_eip) { return -1; }
+static int noop_wakeup_secondary_cpu(u32 apicid, unsigned long start_eip) { return -1; }
 static u64 noop_apic_icr_read(void) { return 0; }
 static u32 noop_phys_pkg_id(u32 cpuid_apic, int index_msb) { return 0; }
 static u32 noop_get_apic_id(u32 apicid) { return 0; }
--- a/arch/x86/kernel/apic/apic_numachip.c
+++ b/arch/x86/kernel/apic/apic_numachip.c
@@ -71,7 +71,7 @@ static void numachip2_apic_icr_write(int
 	numachip2_write32_lcsr(NUMACHIP2_APIC_ICR, (apicid << 12) | val);
 }
 
-static int numachip_wakeup_secondary(int phys_apicid, unsigned long start_rip)
+static int numachip_wakeup_secondary(u32 phys_apicid, unsigned long start_rip)
 {
 	numachip_apic_icr_write(phys_apicid, APIC_DM_INIT);
 	numachip_apic_icr_write(phys_apicid, APIC_DM_STARTUP |
--- a/arch/x86/kernel/apic/x2apic_uv_x.c
+++ b/arch/x86/kernel/apic/x2apic_uv_x.c
@@ -702,7 +702,7 @@ static __init void build_uv_gr_table(voi
 	}
 }
 
-static int uv_wakeup_secondary(int phys_apicid, unsigned long start_rip)
+static int uv_wakeup_secondary(u32 phys_apicid, unsigned long start_rip)
 {
 	unsigned long val;
 	int pnode;
--- a/arch/x86/kernel/sev.c
+++ b/arch/x86/kernel/sev.c
@@ -940,7 +940,7 @@ static void snp_cleanup_vmsa(struct sev_
 		free_page((unsigned long)vmsa);
 }
 
-static int wakeup_cpu_via_vmgexit(int apic_id, unsigned long start_ip)
+static int wakeup_cpu_via_vmgexit(u32 apic_id, unsigned long start_ip)
 {
 	struct sev_es_save_area *cur_vmsa, *vmsa;
 	struct ghcb_state state;

