Return-Path: <linux-kernel+bounces-93843-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 19C6987357C
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 12:17:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 95D081F26C79
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 11:17:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F8097641F;
	Wed,  6 Mar 2024 11:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Ow+cs96j";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="eaL8lOUs"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2213B60B86
	for <linux-kernel@vger.kernel.org>; Wed,  6 Mar 2024 11:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709723826; cv=none; b=ElNEet0F5IOSE9j9YP1cfEy+UvIHsmIQ3ZuNg+Z6fXDbtNGRkYpbE474+/PuwkYSA+sq43xZkOukCafCEjbQI0whUlGQ3iA0K/8e7IIzE9Ng7c8/MjwmPhv8jF5QqGThyQ6wx2ndz5jQ5NxWVFdngjHWHtw5Sohk6VDNSQyZHfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709723826; c=relaxed/simple;
	bh=yPhu6vsgw7QHRremDIPX3LuWb6KtRig10SaljRpXJkY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=KmJH/vqHU8OHFwarVDvMvq8H5YNz7+rQP+nQehw4BIa/0bSU/+O7fbg0U5ju8H7hBuKlN4q9+2K6D+Q95TIZzb+eQyhYT1cxykMn/0OYtN3nZgWqJqXZU97oiwLxvZNk/iyWsxDXYV967urGmMzBCpbwbTdvxiriPxOzHEANCOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Ow+cs96j; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=eaL8lOUs; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1709723823;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wHW7H+NnnbWVk08yTAlKOKjJd2SCypABbCCbkHaG7Vo=;
	b=Ow+cs96j/6gNiW7ugoO8KIHrlmdKEYATkv3Qp2J1cAYRQGeeZuDDo4ZB6TjBcUHc5CClse
	IsUzkr7wRRxAqqnRdL6OcDTwn4cJkxl/CDEy0JTo8WqVCMSR72h42WAH3FEoPqmdEdFxwc
	5YYMOlUIN6ptqqejEJegduqvqlyZbIJr3WiMJRxGQ7ReIc2mJMCtWJ4cp1tg4psQDk3lTW
	P8hliVjJbYl0iU44fZbfcfdfbIGIAHPKO+2HUTZpt6XpHb7MagRr0jIGzh4aFdaHxJT7EM
	arnVMC0qC5efS/DbrjhERNKbP85lUqxKf8n+tW+k9iKWwVBv/wdqPuLtFajzlg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1709723823;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wHW7H+NnnbWVk08yTAlKOKjJd2SCypABbCCbkHaG7Vo=;
	b=eaL8lOUs19jzuN8LRnhhQqMAae254/4Yl5w46eEg77gAgLRMNLdWaZMaZyZ9QJUJtx14l5
	Ib6lkP/D8EZmCtAQ==
To: Borislav Petkov <bp@alien8.de>
Cc: "Liang, Kan" <kan.liang@linux.intel.com>, x86-ml <x86@kernel.org>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, Adrian Hunter
 <adrian.hunter@intel.com>, Alexander Antonov
 <alexander.antonov@linux.intel.com>, lkml <linux-kernel@vger.kernel.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: unchecked MSR access error: WRMSR to 0xd84 (tried to write
 0x0000000000010003) at rIP: 0xffffffffa025a1b8
 (snbep_uncore_msr_init_box+0x38/0x60 [intel_uncore])
In-Reply-To: <20240305121014.GCZecLppQTzWmpI_yR@fat_crate.local>
References: <20240304201233.GDZeYrMc9exmV21PFB@fat_crate.local>
 <87sf15ugsz.ffs@tglx> <20240305121014.GCZecLppQTzWmpI_yR@fat_crate.local>
Date: Wed, 06 Mar 2024 12:17:02 +0100
Message-ID: <87a5nbvccx.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Tue, Mar 05 2024 at 13:10, Borislav Petkov wrote:
> I guess ship it but we'll pay attention to what else ends up
> complaining.

Here is an updated version which handles it in the topology core code so
that MPPARSE is covered as well.

Thanks,

        tglx
---
Subject: x86/topology: Ignore non-present APIC IDs in a present package
From: Thomas Gleixner <tglx@linutronix.de>
Date: Tue, 05 Mar 2024 10:57:26 +0100

Borislav reported that one of his systems has a broken MADT table which
advertises eight present APICs and 24 non-present APICs in the same
package.

The non-present ones are considered hot-pluggable by the topology
evaluation code, which is obviously bogus as there is no way to hot-plug
within the same package.

As the topology evaluation code accounts for hot-pluggable CPUs in a
package, the maximum number of cores per package is computed wrong, which
in turn causes the uncore performance counter driver to access non-existing
MSRs. It will probably confuse other entities which rely on the maximum
number of cores and threads per package too.

Cure this by ignoring hot-pluggable APIC IDs within a present package.

In theory it would be reasonable to just do this unconditionally, but then
there is this thing called reality^Wvirtualization which ruins
everything. Virtualization is the only existing user of "physical" hotplug
and the virtualization tools allow the above scenario. Whether that is
actually in use or not is unknown.

As it can be argued that the virtualization case is not affected by the
issues which exposed the reported problem, allow the bogosity if the kernel
determined that it is running in a VM for now.

Reported-by: Borislav Petkov (AMD) <bp@alien8.de>
Fixes: 89b0f15f408f ("x86/cpu/topology: Get rid of cpuinfo::x86_max_cores")
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/kernel/cpu/topology.c |   38 +++++++++++++++++++++++++++++---------
 1 file changed, 29 insertions(+), 9 deletions(-)

--- a/arch/x86/kernel/cpu/topology.c
+++ b/arch/x86/kernel/cpu/topology.c
@@ -157,6 +157,20 @@ static __init bool check_for_real_bsp(u3
 	return true;
 }
 
+static unsigned int topo_unit_count(u32 lvlid, enum x86_topology_domains at_level,
+				    unsigned long *map)
+{
+	unsigned int id, end, cnt = 0;
+
+	/* Calculate the exclusive end */
+	end = lvlid + (1U << x86_topo_system.dom_shifts[at_level]);
+
+	/* Unfortunately there is no bitmap_weight_range() */
+	for (id = find_next_bit(map, end, lvlid); id < end; id = find_next_bit(map, end, ++id))
+		cnt++;
+	return cnt;
+}
+
 static __init void topo_register_apic(u32 apic_id, u32 acpi_id, bool present)
 {
 	int cpu, dom;
@@ -178,6 +192,20 @@ static __init void topo_register_apic(u3
 		cpuid_to_apicid[cpu] = apic_id;
 		topo_set_cpuids(cpu, apic_id, acpi_id);
 	} else {
+		u32 pkgid = topo_apicid(apic_id, TOPO_PKG_DOMAIN);
+
+		/*
+		 * Check for present APICs in the same package when running
+		 * on bare metal. Allow the bogosity in a guest.
+		 */
+		if (hypervisor_is_type(X86_HYPER_NATIVE) &&
+		    topo_unit_count(pkgid, TOPO_PKG_DOMAIN, phys_cpu_present_map)) {
+			pr_info_once("Ignoring hot-pluggable APIC ID %x in present package.\n",
+				     apic_id);
+			topo_info.nr_rejected_cpus++;
+			return;
+		}
+
 		topo_info.nr_disabled_cpus++;
 	}
 
@@ -280,7 +308,6 @@ unsigned int topology_unit_count(u32 api
 {
 	/* Remove the bits below @at_level to get the proper level ID of @apicid */
 	unsigned int lvlid = topo_apicid(apicid, at_level);
-	unsigned int id, end, cnt = 0;
 
 	if (lvlid >= MAX_LOCAL_APIC)
 		return 0;
@@ -290,14 +317,7 @@ unsigned int topology_unit_count(u32 api
 		return 0;
 	if (which_units == at_level)
 		return 1;
-
-	/* Calculate the exclusive end */
-	end = lvlid + (1U << x86_topo_system.dom_shifts[at_level]);
-	/* Unfortunately there is no bitmap_weight_range() */
-	for (id = find_next_bit(apic_maps[which_units].map, end, lvlid);
-	     id < end; id = find_next_bit(apic_maps[which_units].map, end, ++id))
-		cnt++;
-	return cnt;
+	return topo_unit_count(lvlid, at_level, apic_maps[which_units].map);
 }
 
 #ifdef CONFIG_ACPI_HOTPLUG_CPU

