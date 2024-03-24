Return-Path: <linux-kernel+bounces-112715-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A991F887D42
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 15:59:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DBD1D281643
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 14:59:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7C0418624;
	Sun, 24 Mar 2024 14:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="oqZQngw0";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ttXlGNap"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2162FCA64
	for <linux-kernel@vger.kernel.org>; Sun, 24 Mar 2024 14:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711292378; cv=none; b=R5jZt/rL9tQM7wBokHNee2K/y514s3exZZTwvqdNQsF4o/Ssy7Ak9wAb9CPUhzy3GjHI/dO6CkUw92kOykstMH6Xma9fYg2B+hpZqB+32C1Y3Lvx0K9CGrTnePVkmfj9vw3GDOwNT3A/6F+LrLlwiKtpDampsMmp+dczj1RykkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711292378; c=relaxed/simple;
	bh=ZDF6oUwD+dvqUuzV82iofflPWXNsFYfywovWeXpE+ig=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ToMon2OmQUy9LCCzn0/iUgEEeZXT8EYcf0DoYibL4zqgA6e7WQfpoLtEDV2hscf6W5X4mKlxaWN8jf30PxDpc7WZyOwKzJpTzx9x+wF6s1ULR1SYu0WDCrAePogjCdh+d3B/HNCRvEv6jIkf60g04vbCb+i1EckH77EW5CzBd8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=oqZQngw0; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ttXlGNap; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1711292368;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5f0NMcKM7wXcrsDC1hMJ6x1bZ3lKg8NF2TfNJQEWZJc=;
	b=oqZQngw0QYrMfu8c9dB7oSW8nyndySGW3udXUmX6teCsOWYIuFODuliFfiKFDVU82dLlfG
	1fTP2MoHSyejMPi1HkmDVjn9q+rugav0QTxLpX6gu+UntDPk9VqB/is5SZBCW4trjHIfQp
	qOahRetQ0JGRd3061pNUjOkC5i4ur5iFkjsDNSOHF/BfhGpK9QVnh+e1Wsla1vfqPVvbcm
	hLhaHIuiw97CyXgrHYVYGrfvwBcUOnO6yY0ARbkblOd0NDnES7h9svdTk3FLZzh/C0iLHw
	tXobkFKVe2XJvb5GFJAOqA9IjK0V2gvPTRtXMYPszZ53sm7JnLQER30+NVfcyA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1711292368;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5f0NMcKM7wXcrsDC1hMJ6x1bZ3lKg8NF2TfNJQEWZJc=;
	b=ttXlGNapdvdXTlhBBoSd0w1gSKgOWKnLnztAWq4xF7sWfIsXGIg/KOevSZB/GiUiWLcoK7
	w4KojLosBLIZb0Cg==
To: Saurabh Sengar <ssengar@linux.microsoft.com>,
 dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org,
 mingo@redhat.com, bp@alien8.de, x86@kernel.org, hpa@zytor.com,
 linux-kernel@vger.kernel.org
Cc: ssengar@microsoft.com, sgeorgejohn@microsoft.com
Subject: Re: [PATCH] x86/numa: Map NUMA node to CPUs as per DeviceTree
In-Reply-To: <1710265404-23146-1-git-send-email-ssengar@linux.microsoft.com>
References: <1710265404-23146-1-git-send-email-ssengar@linux.microsoft.com>
Date: Sun, 24 Mar 2024 15:59:27 +0100
Message-ID: <87v85bfzg0.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Tue, Mar 12 2024 at 10:43, Saurabh Sengar wrote:
> Currently for DeviceTree bootup, x86 code does the default mapping of
> CPUs to NUMA, which is wrong. This can cause incorrect mapping and WARN
> on a SMT enabled system like below:
>
> [0.417551] ------------[ cut here ]------------
> [0.417551] Saurabh sched: CPU #1's smt-sibling CPU #0 is not on the same node! [node: 1 != 0]. Ignoring dependency.
> [0.417551] WARNING: CPU: 1 PID: 0 at topology_sane.isra.0+0x5c/0x6d
> [0.417551] Modules linked in:
> [0.417551] CPU: 1 PID: 0 Comm: swapper/1 Not tainted 6.1.71-microsoft-hcl+ #4
> [0.417551] RIP: 0010:topology_sane.isra.0+0x5c/0x6d
> [0.417551] Code: 41 39 dc 74 27 80 3d 32 ae 2d 00 00 75 1e 41 89 d9 45 89 e0 44 89 d6 48 c7 c7 00 a6 4a 88 c6 05 19 ae 2d 00 01 e8 6e 1f cb ff <0f> 0b 41 39 dc 5b 41 5c 0f 94 c0 5d c3 cc cc cc cc 55 48 8b 05 05
> [0.417551] RSP: 0000:ffffc9000013feb0 EFLAGS: 00010086
> [0.417551] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
> [0.417551] RDX: 0000000000000003 RSI: 0000000000000086 RDI: 00000000ffffffff
> [0.417551] RBP: ffffc9000013fec0 R08: ffffffff88778160 R09: ffffffff88778160
> [0.417551] R10: ffff888227fe26da R11: ffff888227fe26c1 R12: 0000000000000001
> [0.417551] R13: 0000000000000000 R14: ffff888216415040 R15: 0000000000000000
> [0.417551] FS:  0000000000000000(0000) GS:ffff888216400000(0000) knlGS:0000000000000000
> [0.417551] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [0.417551] CR2: 0000000000000000 CR3: 0000000208809001 CR4: 0000000000330ea0
> [0.417551] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> [0.417551] DR3: 0000000000000000 DR6: 00000000fffe07f0 DR7: 0000000000000400
> [0.417551] Call Trace:
> [0.417551]  <TASK>
> [0.417551]  ? show_regs.cold+0x1a/0x1f
> [0.417551]  ? __warn+0x6e/0xc0
> [0.417551]  ? report_bug+0x101/0x1a0
> [0.417551]  ? handle_bug+0x40/0x70
> [0.417551]  ? exc_invalid_op+0x19/0x70
> [0.417551]  ? asm_exc_invalid_op+0x1b/0x20
> [0.417551]  ? topology_sane.isra.0+0x5c/0x6d
> [0.417551]  match_smt+0xf6/0xfc
> [0.417551]  set_cpu_sibling_map.cold+0x24f/0x512
> [0.417551]  start_secondary+0x5c/0x110
> [0.417551]  secondary_startup_64_no_verify+0xcd/0xdb
> [0.417551]  </TASK>
> [0.417551] ---[ end trace 0000000000000000 ]---

Can you please trim the backtrace like documented. 95% of the pasted
information above is completely irrelevant to understand the issue.

 CPU #1's smt-sibling CPU #0 is not on the same node! [node: 1 != 0]. Ignoring dependency.
 WARNING: CPU: 1 PID: 0 at topology_sane.isra.0+0x5c/0x6d
  match_smt+0xf6/0xfc
  set_cpu_sibling_map.cold+0x24f/0x512
  start_secondary+0x5c/0x110

is more than sufficient, no?

> +static void __init of_parse_and_init_cpus(void)
> +{
> +	struct device_node *dn;
> +	int cpuid = 0;
> +	int nid;
> +
> +	for_each_of_cpu_node(dn) {
> +		if (cpuid >= NR_CPUS) {

This condition is wrong. nr_cpu_ids != NR_CPUS.

> +			pr_warn("NR_CPUS too small for %d cpuid\n", cpuid);

What's this for? The APIC enumeration code warns about this already.

> +			return;
> +		}
> +		nid = of_node_to_nid(dn);
> +		numa_set_node(cpuid, nid);
> +		cpuid++;
> +	}
> +}
> +
>  static int __init numa_init(int (*init_func)(void))
>  {
>  	int i;
> @@ -645,6 +662,9 @@ static int __init numa_init(int (*init_func)(void))
>  	if (ret < 0)
>  		return ret;
>  
> +	if (acpi_disabled)
> +		of_parse_and_init_cpus();

numa_init() is invoked from x86_numa_init() with the various NUMA init
functions as argument and x86_numa_init() already has OF NUMA logic:

#ifdef CONFIG_ACPI_NUMA
		if (!numa_init(x86_acpi_numa_init))
			return;
#endif
#ifdef CONFIG_AMD_NUMA
		if (!numa_init(amd_numa_init))
			return;
#endif
		if (acpi_disabled && !numa_init(of_numa_init))
			return;

of_numa_init() does not do the numa_set_node() part, but that's not a
justification to glue this into numa_init() which is firmware
independent except for the firmware specific callback argument.

Also x86_numa_init() is invoked _before_ the APIC ID to Linux CPU number
association happens, so doing the CPU number to node mapping at this
point is just wrong for any CPU number != 0.

It "works" for OF just by chance as the actual APIC enumeration which
associates Linux CPU numbers works in the same order, but that does not
make it correct in any way.

x86_acpi_numa_init() and amd_numa_init() set up the nodes like
of_numa_init() does and aside of that save the APIC ID to node mapping.

Aside of that the numa_set_node() variant happens to "work" for Intel
CPUs as srat_detect_node() falls back to cpu_to_node() when
numa_cpu_node() returns NO_NUMA_NODE.

Though the AMD variant falls back to cpu_info.topo.llc_id which is not
necessarily the same result as what the device tree enumerated.

I can see why you glued it into numa_init():

  of_node_to_nid() requires node_possible_map to be initialized, which
  happens in numa_register_memblks() invoked from numa_init() if the
  firmware specific callback which enumerates the nodes was successful.

Of course the change log is silent about this.

But there is no reason to scan this right in numa_init() as nothing
needs the information to be set at this point, unless I'm missing
something obscure, which might be the case when staring at this NUMA
enumeration maze.

The CPU to node mapping based on the APIC ID to node mapping happens in
init_cpu_to_node() which is after the APIC enumeration and the
finalizing of cpu_possible_map completed. At this point the CPU number
to APIC ID mapping is stable.

So the uncompiled below should just work, no?

Thanks,

        tglx
---
--- a/arch/x86/kernel/devicetree.c
+++ b/arch/x86/kernel/devicetree.c
@@ -24,6 +24,7 @@
 #include <asm/pci_x86.h>
 #include <asm/setup.h>
 #include <asm/i8259.h>
+#include <asm/numa.h>
 #include <asm/prom.h>
 
 __initdata u64 initial_dtb;
@@ -137,6 +138,7 @@ static void __init dtb_cpu_setup(void)
 			continue;
 		}
 		topology_register_apic(apic_id, CPU_ACPIID_INVALID, true);
+		set_apicid_to_node(apic_id, of_node_to_nid(dn));
 	}
 }
 

