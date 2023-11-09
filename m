Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0099E7E6B4E
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 14:41:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232193AbjKINlj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 08:41:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230055AbjKINlh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 08:41:37 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F83B171B;
        Thu,  9 Nov 2023 05:41:35 -0800 (PST)
Date:   Thu, 09 Nov 2023 13:41:31 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1699537292;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=B5L7TrDn+iOraFgK4bd/yleetT2/5lD4JNly4xY6Cuw=;
        b=GJXodOzUOj86wDLUdXqiBEmN0qzpscmX+UODIJBa6k/ZPPQc4qre48pQKEOaS3PjNU/N3W
        2MyC5Oab7pb/MAe3nDGlf03Hm6B/ln/+5XDlMYdpOa/PTt7sp/YdTh/v0bx0Rk3Nm7eWkt
        MB4lD2cuJXOeCtLcR3t1+HpjPTI3MXT6i5yrIFtXgKHS0goqCFnhxhV7tsbNLzFWdplDR8
        NFYDM21Tlrki7sEljC/eCo4jyzdWE6ETivjIY/5078hyJ7G/t4Fokx2pb7tQBXCRwPgmEa
        TGfKsTK/50et4GV9Ge1Flb3/ufdTbYaLiTVvVPgG3ZSyXP+nP2A3kHdDg+kurQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1699537292;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=B5L7TrDn+iOraFgK4bd/yleetT2/5lD4JNly4xY6Cuw=;
        b=jeX9WlYiyrb2EcUUCxIgMOqeY4kbgIDfTINs1mpQ+oAv7S/aEEtNJlYHJpEFHLjn9uYt9N
        ZWDPDRYkrMi/xpBw==
From:   "tip-bot2 for Zhang Rui" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/acpi: Ignore invalid x2APIC entries
Cc:     Zhang Rui <rui.zhang@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230702162802.344176-1-rui.zhang@intel.com>
References: <20230702162802.344176-1-rui.zhang@intel.com>
MIME-Version: 1.0
Message-ID: <169953729188.3135.6804572126118798018.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     ec9aedb2aa1ab7ac420c00b31f5edc5be15ec167
Gitweb:        https://git.kernel.org/tip/ec9aedb2aa1ab7ac420c00b31f5edc5be15ec167
Author:        Zhang Rui <rui.zhang@intel.com>
AuthorDate:    Mon, 03 Jul 2023 00:28:02 +08:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 09 Nov 2023 14:33:30 +01:00

x86/acpi: Ignore invalid x2APIC entries

Currently, the kernel enumerates the possible CPUs by parsing both ACPI
MADT Local APIC entries and x2APIC entries. So CPUs with "valid" APIC IDs,
even if they have duplicated APIC IDs in Local APIC and x2APIC, are always
enumerated.

Below is what ACPI MADT Local APIC and x2APIC describes on an
Ivebridge-EP system,

[02Ch 0044   1]                Subtable Type : 00 [Processor Local APIC]
[02Fh 0047   1]                Local Apic ID : 00
...
[164h 0356   1]                Subtable Type : 00 [Processor Local APIC]
[167h 0359   1]                Local Apic ID : 39
[16Ch 0364   1]                Subtable Type : 00 [Processor Local APIC]
[16Fh 0367   1]                Local Apic ID : FF
...
[3ECh 1004   1]                Subtable Type : 09 [Processor Local x2APIC]
[3F0h 1008   4]                Processor x2Apic ID : 00000000
...
[B5Ch 2908   1]                Subtable Type : 09 [Processor Local x2APIC]
[B60h 2912   4]                Processor x2Apic ID : 00000077

As a result, kernel shows "smpboot: Allowing 168 CPUs, 120 hotplug CPUs".
And this wastes significant amount of memory for the per-cpu data.
Plus this also breaks https://lore.kernel.org/all/87edm36qqb.ffs@tglx/,
because __max_logical_packages is over-estimated by the APIC IDs in
the x2APIC entries.

According to https://uefi.org/specs/ACPI/6.5/05_ACPI_Software_Programming_Model.html#processor-local-x2apic-structure:

  "[Compatibility note] On some legacy OSes, Logical processors with APIC
   ID values less than 255 (whether in XAPIC or X2APIC mode) must use the
   Processor Local APIC structure to convey their APIC information to OSPM,
   and those processors must be declared in the DSDT using the Processor()
   keyword. Logical processors with APIC ID values 255 and greater must use
   the Processor Local x2APIC structure and be declared using the Device()
   keyword."

Therefore prevent the registration of x2APIC entries with an APIC ID less
than 255 if the local APIC table enumerates valid APIC IDs.

[ tglx: Simplify the logic ]

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Peter Zijlstra <peterz@infradead.org>
Link: https://lore.kernel.org/r/20230702162802.344176-1-rui.zhang@intel.com
---
 arch/x86/kernel/acpi/boot.c | 34 +++++++++++++++-------------------
 1 file changed, 15 insertions(+), 19 deletions(-)

diff --git a/arch/x86/kernel/acpi/boot.c b/arch/x86/kernel/acpi/boot.c
index c55c0ef..fc5bce1 100644
--- a/arch/x86/kernel/acpi/boot.c
+++ b/arch/x86/kernel/acpi/boot.c
@@ -63,6 +63,7 @@ int acpi_fix_pin2_polarity __initdata;
 
 #ifdef CONFIG_X86_LOCAL_APIC
 static u64 acpi_lapic_addr __initdata = APIC_DEFAULT_PHYS_BASE;
+static bool has_lapic_cpus __initdata;
 static bool acpi_support_online_capable;
 #endif
 
@@ -233,6 +234,14 @@ acpi_parse_x2apic(union acpi_subtable_headers *header, const unsigned long end)
 		return 0;
 
 	/*
+	 * According to https://uefi.org/specs/ACPI/6.5/05_ACPI_Software_Programming_Model.html#processor-local-x2apic-structure
+	 * when MADT provides both valid LAPIC and x2APIC entries, the APIC ID
+	 * in x2APIC must be equal or greater than 0xff.
+	 */
+	if (has_lapic_cpus && apic_id < 0xff)
+		return 0;
+
+	/*
 	 * We need to register disabled CPU as well to permit
 	 * counting disabled CPUs. This allows us to size
 	 * cpus_possible_map more accurately, to permit
@@ -1114,10 +1123,7 @@ static int __init early_acpi_parse_madt_lapic_addr_ovr(void)
 
 static int __init acpi_parse_madt_lapic_entries(void)
 {
-	int count;
-	int x2count = 0;
-	int ret;
-	struct acpi_subtable_proc madt_proc[2];
+	int count, x2count = 0;
 
 	if (!boot_cpu_has(X86_FEATURE_APIC))
 		return -ENODEV;
@@ -1126,21 +1132,11 @@ static int __init acpi_parse_madt_lapic_entries(void)
 				      acpi_parse_sapic, MAX_LOCAL_APIC);
 
 	if (!count) {
-		memset(madt_proc, 0, sizeof(madt_proc));
-		madt_proc[0].id = ACPI_MADT_TYPE_LOCAL_APIC;
-		madt_proc[0].handler = acpi_parse_lapic;
-		madt_proc[1].id = ACPI_MADT_TYPE_LOCAL_X2APIC;
-		madt_proc[1].handler = acpi_parse_x2apic;
-		ret = acpi_table_parse_entries_array(ACPI_SIG_MADT,
-				sizeof(struct acpi_table_madt),
-				madt_proc, ARRAY_SIZE(madt_proc), MAX_LOCAL_APIC);
-		if (ret < 0) {
-			pr_err("Error parsing LAPIC/X2APIC entries\n");
-			return ret;
-		}
-
-		count = madt_proc[0].count;
-		x2count = madt_proc[1].count;
+		count = acpi_table_parse_madt(ACPI_MADT_TYPE_LOCAL_APIC,
+					acpi_parse_lapic, MAX_LOCAL_APIC);
+		has_lapic_cpus = count > 0;
+		x2count = acpi_table_parse_madt(ACPI_MADT_TYPE_LOCAL_X2APIC,
+					acpi_parse_x2apic, MAX_LOCAL_APIC);
 	}
 	if (!count && !x2count) {
 		pr_err("No LAPIC entries present\n");
