Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80ED27748CD
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 21:40:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236613AbjHHTko (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 15:40:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234467AbjHHTk2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 15:40:28 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7EA2DD19F
        for <linux-kernel@vger.kernel.org>; Tue,  8 Aug 2023 12:10:44 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1691521842;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5iBTvR2+8yNLWKWG3Pj95vvtGm0hL6HXFWmG9K71GBQ=;
        b=oSirbWWiyhCXmcu8hAGfKJK5mLTIeBnSdtz4a3hSq0jettmMNOKGay4tOqmTJjkyqmUbf5
        kcqiY0zxWRYcDMyYGuFJ6SpjARkfm+ndtS4h7wToG3frbL7WhosaoYkrAVN7B5gtyqHrvH
        HB1RoQbQZnaCwhnBKfroAr1wWPm/v69DGDBzD0CcMoLLfK7IVTWvove8dy6J2svjPbGYRA
        J5J7ljRmeLrY5eKFuUXAElc1yToh+X3xNrrD4z6wyH8egu5OCSvNq+VbcwLOwPwFjJo3SX
        q1ITxKZfTVn/xlawd3LeomAORHiIMCtMO95vZ6W4SDKS+isl5VFhOIqT31aSKg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1691521842;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5iBTvR2+8yNLWKWG3Pj95vvtGm0hL6HXFWmG9K71GBQ=;
        b=KKHHR+vOTrI4JrWZhwfp6TLPaWm5+2VnldUmWs93NMS0u9tL4F3czym2sVPOtw/RUHM2bC
        eLIYAItZ+KSPG1AQ==
To:     Sohil Mehta <sohil.mehta@intel.com>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Tom Lendacky <thomas.lendacky@amd.com>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Arjan van de Ven <arjan@linux.intel.com>,
        Huang Rui <ray.huang@amd.com>, Juergen Gross <jgross@suse.com>,
        Dimitri Sivanich <dimitri.sivanich@hpe.com>,
        Michael Kelley <mikelley@microsoft.com>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Zhang Rui <rui.zhang@intel.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Feng Tang <feng.tang@intel.com>,
        Andy Shevchenko <andy@infradead.org>
Subject: Re: [patch 00/53] x86/topology: The final installment
In-Reply-To: <c8ca9e16-ce03-1fe0-cf9f-f6cc2302dbac@intel.com>
References: <20230807130108.853357011@linutronix.de>
 <c8ca9e16-ce03-1fe0-cf9f-f6cc2302dbac@intel.com>
Date:   Tue, 08 Aug 2023 21:10:41 +0200
Message-ID: <87h6p9l58u.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 08 2023 at 11:29, Sohil Mehta wrote:
> On 8/7/2023 6:52 AM, Thomas Gleixner wrote:
> However, I am a bit confused with the dmesg results.
>
> Dmesg output
> ------------
> CPU topo: Max. logical packages:   4
> CPU topo: Max. logical dies:       4
> CPU topo: Max. dies per package:   1
> CPU topo: Max. threads per core:   2
> CPU topo: Num. cores per package:    16
> CPU topo: Num. threads per package:  32

That's indeed weird. Can you please provide:

     - the output of 'cpuid -r'
     - the output of /sys/kernel/debug/x86/topo/domains
     - the APIC IDs of all CPUs (see below patch)

> Questions
> ---------
> 1) Before this series, the Max logical packages used to be logged as 8
> in dmesg. But now it shows up as 4. Is that expected?
> To me, it seems that to get to 160 potential CPUs with 10cores/20threads
> per package, the Max logical packages should be 8.

As the number of cores per package is not consistent, this is not a
surprise. 160/32 = 5, but yes something is fishy there.

Oh. Is this perhaps one of those machines where the APICs are enumerated
twice. Can you apply the patch below?

The ACPI part is a modified variant of:

    https://lore.kernel.org/r/23ccb5aad770fb52014dca9fb1e4353b5c3cede9.camel@intel.com

Please apply the topology hunks first without the ACPI changes and then
try the ACPI change on top.

Thanks,

        tglx
---
 arch/x86/kernel/acpi/boot.c    |   31 ++++++++++++++++---------------
 arch/x86/kernel/cpu/topology.c |    2 ++
 2 files changed, 18 insertions(+), 15 deletions(-)

--- a/arch/x86/kernel/acpi/boot.c
+++ b/arch/x86/kernel/acpi/boot.c
@@ -171,6 +171,8 @@ static bool __init acpi_is_processor_usa
 	return false;
 }
 
+static bool has_lapic_cpus;
+
 static int __init
 acpi_parse_x2apic(union acpi_subtable_headers *header, const unsigned long end)
 {
@@ -241,6 +243,14 @@ acpi_parse_lapic(union acpi_subtable_hea
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
@@ -1084,21 +1094,12 @@ static int __init acpi_parse_madt_lapic_
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
+		count = acpi_table_parse_madt(ACPI_MADT_TYPE_LOCAL_LAPIC,
+					acpi_parse_lapic, MAX_LOCAL_APIC);
+		if (count)
+			has_lapic_cpus = true;
+		x2count = acpi_table_parse_madt(ACPI_MADT_TYPE_LOCAL_X2APIC,
+					acpi_parse_x2apic, MAX_LOCAL_APIC);
 	}
 	if (!count && !x2count) {
 		pr_err("No LAPIC entries present\n");
--- a/arch/x86/kernel/cpu/topology.c
+++ b/arch/x86/kernel/cpu/topology.c
@@ -159,6 +159,8 @@ void __init topology_register_apic(u32 a
 		return;
 	}
 
+	pr_info("Register %03x %d\n", apic_id, present);
+
 	if (present) {
 		/*
 		 * Prevent double registration, which is valid in case of

