Return-Path: <linux-kernel+bounces-92062-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F088871A53
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 11:14:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B1D101C21431
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 10:14:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B5B154772;
	Tue,  5 Mar 2024 10:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="S4dCSSIi";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="EWRjZc2g"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AAD253387
	for <linux-kernel@vger.kernel.org>; Tue,  5 Mar 2024 10:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709633649; cv=none; b=cxe+yoY64jU3YcsVdBjJjP1SA5Rkis8Lp/TmHXzF9kqmG+0GjxS5Y1EwMnVrPHudnA2FapIkTGEaJGwp5/4BZYeEWaOJ45JQZx6Nk2kpRePoFx6tKkYIaJtTEgetY2O7yVMkacp+eTlGVGX9LkjKCh6bHyrMotEuQb5jfJ2Rv6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709633649; c=relaxed/simple;
	bh=H/c2UZ2y2XLlrHkZ73uRroAkAxocenVdcMMBGSXjD2g=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:MIME-Version:
	 Content-Type; b=U/o6NFM99UNIqibyHBcFD0Y0N/gVyXEffJsClbYr8Cosme2ciuR50O2nMfaKhgL/3dTw7+yf/no6dlhan5ELux9xrjsIXJCHZz4OgTyQIe8knAaUhBMRArV/Tp+yosQ/JVL4mA9zowa9T8lSq2iC9/23Cd7lqGN6SDphhOW+1n4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=S4dCSSIi; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=EWRjZc2g; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1709633645;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to; bh=EVi1pZ2LZ4wej2Y5KXy8NQ0YPegBTTbJinGxtAuFsAI=;
	b=S4dCSSIiGpnytafg3d1n28jROy8RANNGs16PSrCw8MI7iLEt4sEQvUD6g4MQ1ovF7m6gL0
	UcQ7+A1SrMdoFbPmWhWSYJYhb/y5YXEnDgvd2opsySIwzOorHHUiJDzHPK9dTqOgIBSmAU
	hZf81K8Ed4zoPtxjqcl/3uVjCfVA2MWV3EC2Lw4q9bD6BI206K3LUw6/zPYDSLHNxn7jV0
	A4w6VyVrk+aDZEtKl5XVqr3A3aVwhQfLxoXVtcAUBqthWYM3ruenXWdds053qSqv2/+aJY
	lPeUCFKO9rNVrZd/uPy828XpV5+XLdcPkqij2ZDxYZIPXnWe8nFSc7BwVGO2bw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1709633645;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to; bh=EVi1pZ2LZ4wej2Y5KXy8NQ0YPegBTTbJinGxtAuFsAI=;
	b=EWRjZc2g7PtkTXzFfbDjAfj6WUTQR5LhF3caGkDUu1hI7cnT8qu6W1jTRJ/8e6ai0RgqsK
	d8JKBcXwY2OuQICw==
To: Borislav Petkov <bp@alien8.de>, "Liang, Kan" <kan.liang@linux.intel.com>
Cc: x86-ml <x86@kernel.org>, Alexander Shishkin
 <alexander.shishkin@linux.intel.com>, Adrian Hunter
 <adrian.hunter@intel.com>, Alexander Antonov
 <alexander.antonov@linux.intel.com>, lkml <linux-kernel@vger.kernel.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: unchecked MSR access error: WRMSR to 0xd84 (tried to write
 0x0000000000010003) at rIP: 0xffffffffa025a1b8
 (snbep_uncore_msr_init_box+0x38/0x60 [intel_uncore])
In-Reply-To: <20240304201233.GDZeYrMc9exmV21PFB@fat_crate.local>
Date: Tue, 05 Mar 2024 11:14:04 +0100
Message-ID: <87sf15ugsz.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Mon, Mar 04 2024 at 21:12, Borislav Petkov wrote:
> On Mon, Mar 04, 2024 at 02:22:50PM -0500, Liang, Kan wrote:
>> The number of available CBOXs on a SNBEP machine is determined at boot
>> time. It should not be larger than the maximum number of cores.
>> The recent commit 89b0f15f408f ("x86/cpu/topology: Get rid of
>> cpuinfo::x86_max_cores") change the boot_cpu_data.x86_max_cores to
>> topology_num_cores_per_package().
>> I guess the new function probably returns a different maximum number of
>> cores on the machine. But I don't have a SNBEP on my hands. Could you
>> please help to check whether a different maximum number of cores is
>> returned?

It's a MADT problem. MADT advertises 4 present cores and 12 hotpluggable
cores on the same package. At least that's what the topology evaluation
figures out based on MADT and presumably CPUID leaf 0xb.

CPU topo: Allowing 8 present CPUs plus 24 hotplug CPUs

/sys/kernel/debug/x86/topo/domains which is based on leaf 0xb has:
 
domain: Thread     shift: 1 dom_size:     2 max_threads:     2
domain: Core       shift: 5 dom_size:    16 max_threads:    32
domain: Module     shift: 5 dom_size:     1 max_threads:    32
domain: Tile       shift: 5 dom_size:     1 max_threads:    32
domain: Die        shift: 5 dom_size:     1 max_threads:    32
domain: DieGrp     shift: 5 dom_size:     1 max_threads:    32
domain: Package    shift: 5 dom_size:     1 max_threads:    32

So the algorithm is correct and works as designed :)

How to handle that becomes interesting.

The above situation decribed by leaf 0xb and MADT can happen on
virtualization, i.e. the only actual user of "physical" CPU hotplug,
because virtualization people do not necessarily care about package
topology much. It works so it must be correct :)

It seems that none of the consumers of topology_num_cores_per_package()
can actually be used on virt, so a reasonable restriction is to reject
non-present CPUs on bare metal. Something like the below.

Thanks

        tglx
---
--- a/arch/x86/kernel/acpi/boot.c
+++ b/arch/x86/kernel/acpi/boot.c
@@ -24,6 +24,7 @@
 #include <linux/pgtable.h>
 
 #include <asm/e820/api.h>
+#include <asm/hypervisor.h>
 #include <asm/irqdomain.h>
 #include <asm/pci_x86.h>
 #include <asm/io_apic.h>
@@ -169,11 +170,19 @@ static bool __init acpi_is_processor_usa
 	if (lapic_flags & ACPI_MADT_ENABLED)
 		return true;
 
-	if (!acpi_support_online_capable ||
-	    (lapic_flags & ACPI_MADT_ONLINE_CAPABLE))
+	if (lapic_flags & ACPI_MADT_ONLINE_CAPABLE)
 		return true;
 
-	return false;
+	if (acpi_support_online_capable)
+		return false;
+
+	/* Physical hotplug on bare metal is not supported */
+	if (hypervisor_is_type(X86_HYPER_NATIVE)) {
+		pr_info_once("Ignoring non-present APIC ID on bare metal\n");
+		return false;
+	}
+
+	return true;
 }
 
 static int __init

