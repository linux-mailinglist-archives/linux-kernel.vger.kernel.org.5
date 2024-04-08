Return-Path: <linux-kernel+bounces-135452-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E301A89C550
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 15:55:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 754F0B2EF4A
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 13:38:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C6177EF1D;
	Mon,  8 Apr 2024 13:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="j2NPu2v5";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="iuMm+nvq"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7276578285
	for <linux-kernel@vger.kernel.org>; Mon,  8 Apr 2024 13:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712583073; cv=none; b=u4fCNGymv9H5VdUb4QefORbpRQDTES23+IfmpRrmOm3XdGN6M0WoxW4dfobkna/K1bcFjquo/dqgvpj4EcOlqH1Xe4bJUM27kSi36U9QNuv1QXkgUqkc8x4PJei3q/IFvPdLOtr5RGWRTzGol9dtPtrmlLjwCi94N4Jx6dQA7og=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712583073; c=relaxed/simple;
	bh=U+TxDpNxchTE2/GIdmhTEkofyrVXhhjnmFxCseLaaao=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=NO1gZSLkjVDpq8Vai99h4dqGeYEHpqNETaAYCPPDrGsGTmQenRZMUyXi49UqhStmKj+zVtE+gV9gfk1PFFFE59oO7qbIgtj3JVrikjh4LTSg7t7Xrx/QOegMsOZmSY7n6/YLmoqGFwXov+3XwXHJtWL7MV/4ap5rUqBb1ssZOHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=j2NPu2v5; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=iuMm+nvq; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1712583070;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kIE/Zx18HsTE3h79BZccA0yg8HSgBKuWXBZ95h1ChA0=;
	b=j2NPu2v546fgFEfKTl2l9n1P+sqUf3V1qJi1k6rTm9dEZLdT5QmjAHBSEMR08kTZV6BvF/
	Jdbk1jwRDaeTmcZekpiukWHrnbfDAYAv8yx9L8v2d6uEbDUbiVNngG482Vrtr3Hkavz5zz
	8EO9YTQroOXgNpsgIket5O0uUN4NA9u4AJBJbgEe1Ddx6xdgOknVyo9apavYby0kAyeRVF
	0egu1NSsFqxmqN1GdO3B7BmmC7JDYKpMhH5I8iIllt7p9ZKB0M268mOmsIlbNkpc8Vy4qx
	/goUyqypk/LleniGSX2aiPeVUfN0Khaw2xB6iHNJcigfc+oaRK3xqDD6GiuO3Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1712583070;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kIE/Zx18HsTE3h79BZccA0yg8HSgBKuWXBZ95h1ChA0=;
	b=iuMm+nvq9gwLs51UtsXHO1ovbzBYvGzwUg0kfywv5JXUbYx9Ql1sm7ZGmVrIhiL6Uh03kj
	9td8tvtr4UnDfgAg==
To: Alexey Dobriyan <adobriyan@gmail.com>
Cc: adobriyan@gmail.com, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
 linux-kernel@vger.kernel.org, peterz@infradead.org,
 Jonathan.Cameron@huawei.com, linuxarm@huawei.com, linux@roeck-us.net,
 Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Subject: Re: [PATCH 1/2] x86/cpu/topology: don't write to immutable
 cpu_present_mask
In-Reply-To: <20240407152643.3245-1-adobriyan@gmail.com>
References: <20240407152643.3245-1-adobriyan@gmail.com>
Date: Mon, 08 Apr 2024 15:31:10 +0200
Message-ID: <87ttkc6kwx.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Sun, Apr 07 2024 at 18:26, Alexey Dobriyan wrote:
> Workaround the following oops:
>
> 	topology_hotplug_apic
> 	topo_set_cpuids
> 		set_cpu_possible(cpu, true);
> 		// write to __ro_after_init section after init

Duh, yes.

> adobriyan: I'm not sure what's going on, can it set unset bit here?
> If not, then why does it repeat the job and set already set bits.
>
> Anyhow, let's not oops peoples' machines for now.

Adding a bandaid to paper over the non-understood real problem is
definitely not a good plan. I take this patch as a bug report.

Proper fix below.

Thanks,

        tglx
---
Subject: x86/topology: Don't update cpu_possible_map in topo_set_cpuids()
From: Thomas Gleixner <tglx@linutronix.de>
Date: Mon, 08 Apr 2024 15:22:01 +0200

topo_set_cpuids() updates cpu_present_map and cpu_possible map. It is
invoked during enumeration and "physical hotplug" operations. In the
latter case this results in a kernel crash because cpu_possible_map is
marked read only after init completes.

There is no reason to update cpu_possible_map in that function. During
enumeration cpu_possible_map is not relevant and gets fully initialized
after enumeration completed. On "physical hotplug" the bit is already set
because the kernel allows only CPUs to be plugged which have been
enumerated and associated to a CPU number during early boot.

Remove the bogus update of cpu_possible_map.

Fixes: 0e53e7b656cf ("x86/cpu/topology: Sanitize the APIC admission logic")
Reported-by: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/kernel/cpu/topology.c |    7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

--- a/arch/x86/kernel/cpu/topology.c
+++ b/arch/x86/kernel/cpu/topology.c
@@ -123,7 +123,6 @@ static void topo_set_cpuids(unsigned int
 	early_per_cpu(x86_cpu_to_apicid, cpu) = apic_id;
 	early_per_cpu(x86_cpu_to_acpiid, cpu) = acpi_id;
 #endif
-	set_cpu_possible(cpu, true);
 	set_cpu_present(cpu, true);
 }
 
@@ -210,7 +209,11 @@ static __init void topo_register_apic(u3
 		topo_info.nr_disabled_cpus++;
 	}
 
-	/* Register present and possible CPUs in the domain maps */
+	/*
+	 * Register present and possible CPUs in the domain
+	 * maps. cpu_possible_map will be updated in
+	 * topology_init_possible_cpus() after enumeration is done.
+	 */
 	for (dom = TOPO_SMT_DOMAIN; dom < TOPO_MAX_DOMAIN; dom++)
 		set_bit(topo_apicid(apic_id, dom), apic_maps[dom].map);
 }


