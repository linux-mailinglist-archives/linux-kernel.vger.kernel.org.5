Return-Path: <linux-kernel+bounces-138691-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0841F89F918
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 16:00:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 739361F2DE12
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 14:00:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D45EC16131C;
	Wed, 10 Apr 2024 13:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="aHe0Mik0";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="nbM713Pd"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36F4A1607BA
	for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 13:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712757448; cv=none; b=DaWBfxxfgKMM4tqkE4QNDTllxdodsLW5wUqRFLs6Zv4kLztqC23+3rno5UtB8OxSv0elRKYnx1l/QUFy3wUIY/oqX9eP6dWayo1wyXM/+m110muk/y2KWn+LcUXiz17sHrBRTLLdyq29nm/jRmip58rPgwZmjGqxOfNjp4oxMTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712757448; c=relaxed/simple;
	bh=Vmjd766pnJwxCEOaOVeQ65Zc8wLnDzncLTsJ92dltjI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=PgpejmSncUd4DBgT6PGE+YGQBYFyw5gs5kUv62DwiDGT8+xYPxXbhaRDHvYQhw5on/GmJVvlztXgVQ1SBtQJ4mxIxWXQdwx2tsvfC5YDgP2u+ikn+pg6KhSrDgYyrN2Y8E58CO+TbOMf9ViS5XYK6j2v6tn9EUwnMyZWzJXEvd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=aHe0Mik0; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=nbM713Pd; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1712757444;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+P1h6K8iE4a/JK1Qad/ycomagIWrt5AkDlmzvXSjKOU=;
	b=aHe0Mik0mHJ4NZy71o1JcFMIe5C7EyIOotG8gK8uyHepoziWm+NM85J9dxPxXdNrSnDVyA
	UeK5tZlLbuyzWBaWH7BhilfR7DYfw2MhawAVF2A7Dohmlp6TbFlHgA2R7PdEgB/w2bBFe/
	nXSo88Ab1Xe8CGJnm7Cq6xVYEIJza73fhJziA1yRCYE9S/usuGPN9qvUpihgj3OVjdlXUD
	WkfeWdpgvcsgTyQQ/Kr8Po7kN2YuN6QQKTgtlaYiIYs+lCHJl48+WsskDaPI/oFHZ1Iqda
	WhURSlcH/HutzyFfyA76PG3y2r2W7YGTb0XO/ri1s5DhzKqPO5pmSBsdvkLzLQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1712757444;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+P1h6K8iE4a/JK1Qad/ycomagIWrt5AkDlmzvXSjKOU=;
	b=nbM713Pdkdh6qCTA1ARJTxTvUambndETBO6CKQdRTaWxMBZi07+quI7rT4qowvCwQirQDJ
	iI79PsdTbnBS+6BA==
To: Laura Nao <laura.nao@collabora.com>
Cc: kernel@collabora.com, laura.nao@collabora.com,
 linux-kernel@vger.kernel.org, regressions@leemhuis.info,
 regressions@lists.linux.dev, x86@kernel.org
Subject: Re: [REGRESSION] mainline boot regression on AMD Stoney Ridge
 Chromebooks
In-Reply-To: <20240410081529.126363-1-laura.nao@collabora.com>
References: <874jca7mf5.ffs@tglx>
 <20240410081529.126363-1-laura.nao@collabora.com>
Date: Wed, 10 Apr 2024 15:57:24 +0200
Message-ID: <878r1l48xn.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Laura!

On Wed, Apr 10 2024 at 10:15, Laura Nao wrote:
> On 4/9/24 14:25, Thomas Gleixner wrote:
>> Can you please replace that patch with the one below?
>
> So, with this patch applied on top of ace278e7eca6 the kernel doesn't
> boot anymore - reference test job: 
> https://lava.collabora.dev/scheduler/job/13324010
>
> I see the only change between the second and third patch you provided,
> besides the debug prints, is:
>
> -	if (!topo_is_converted(c))
> -		return;
> -

Right. So this limits the area to search significantly.

> Printing the debug information without this probably doesn't really help, 
> but just in case it's useful: I tried excluding the change above from the
> patch while leaving everything else unchanged - reference test job:
> https://lava.collabora.dev/scheduler/job/13324298 (also pasted the
> kernel log here for easier consultation:
> https://pastebin.com/raw/TQBDvCah)
>
> Hope this helps,

It does. Good idea!

I just moved the exit check a bit so we should see the scan info. That
should tell me what goes south.

Thanks,

        tglx
---
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -1616,6 +1616,13 @@ void __init early_cpu_init(void)
 #endif
 	}
 	early_identify_cpu(&boot_cpu_data);
+
+	pr_info("Max cores: %u\n", boot_cpu_data.x86_max_cores);
+	pr_info("pkg %u die %u core %u nid %u\n", boot_cpu_data.topo.pkg_id,
+		boot_cpu_data.topo.die_id, boot_cpu_data.topo.core_id,
+		boot_cpu_data.topo.amd_node_id);
+	pr_info("SNS %u\n", smp_num_siblings);
+	pr_info("NPP %u MDPP %u\n", __amd_nodes_per_pkg, __max_die_per_package);
 }
 
 static bool detect_null_seg_behavior(void)
--- a/arch/x86/kernel/cpu/topology_amd.c
+++ b/arch/x86/kernel/cpu/topology_amd.c
@@ -29,7 +29,17 @@ static bool parse_8000_0008(struct topo_
 	if (!sft)
 		sft = get_count_order(ecx.cpu_nthreads + 1);
 
-	topology_set_dom(tscan, TOPO_SMT_DOMAIN, sft, ecx.cpu_nthreads + 1);
+	/*
+	 * cpu_nthreads describes the number of threads in the package
+	 * sft is the number of APIC ID bits per package
+	 *
+	 * As the number of actual threads per core is not described in
+	 * this leaf, just set the CORE domain shift and let the later
+	 * parsers set SMT shift. Assume one thread per core by default
+	 * which is correct if there are no other CPUID leafs to parse.
+	 */
+	topology_update_dom(tscan, TOPO_SMT_DOMAIN, 0, 1);
+	topology_set_dom(tscan, TOPO_CORE_DOMAIN, sft, ecx.cpu_nthreads + 1);
 	return true;
 }
 
@@ -73,12 +83,14 @@ static bool parse_8000_001e(struct topo_
 	tscan->c->topo.initial_apicid = leaf.ext_apic_id;
 
 	/*
-	 * If leaf 0xb is available, then SMT shift is set already. If not
-	 * take it from ecx.threads_per_core and use topo_update_dom() -
-	 * topology_set_dom() would propagate and overwrite the already
-	 * propagated CORE level.
+	 * If leaf 0xb is available, then the domain shifts are set
+	 * already and nothing to do here.
 	 */
 	if (!has_0xb) {
+		/*
+		 * Leaf 0x80000008 set the CORE domain shift already.
+		 * Update the SMT domain, but do not propagate it.
+		 */
 		unsigned int nthreads = leaf.core_nthreads + 1;
 
 		topology_update_dom(tscan, TOPO_SMT_DOMAIN, get_count_order(nthreads), nthreads);
--- a/arch/x86/kernel/cpu/topology_common.c
+++ b/arch/x86/kernel/cpu/topology_common.c
@@ -133,6 +133,10 @@ static void parse_topology(struct topo_s
 	tscan->ebx1_nproc_shift = get_count_order(ebx.nproc);
 
 	switch (c->x86_vendor) {
+	case X86_VENDOR_AMD:
+		if (IS_ENABLED(CONFIG_CPU_SUP_AMD))
+			cpu_parse_topology_amd(tscan);
+		break;
 	case X86_VENDOR_CENTAUR:
 	case X86_VENDOR_ZHAOXIN:
 		parse_legacy(tscan);
@@ -162,6 +166,9 @@ static void topo_set_ids(struct topo_sca
 
 	if (c->x86_vendor == X86_VENDOR_AMD)
 		cpu_topology_fixup_amd(tscan);
+
+	pr_info("pkg %u die %u core %u nid %u\n", c->topo.pkg_id, c->topo.die_id,
+		c->topo.core_id, c->topo.amd_node_id);
 }
 
 static void topo_set_max_cores(struct topo_scan *tscan)
@@ -175,6 +182,7 @@ static void topo_set_max_cores(struct to
 	 */
 	tscan->c->x86_max_cores = tscan->dom_ncpus[TOPO_DIEGRP_DOMAIN] >>
 		x86_topo_system.dom_shifts[TOPO_SMT_DOMAIN];
+	pr_info("Max cores: %u\n", tscan->c->x86_max_cores);
 }
 
 void cpu_parse_topology(struct cpuinfo_x86 *c)
@@ -215,20 +223,26 @@ void __init cpu_init_topology(struct cpu
 
 	parse_topology(&tscan, true);
 
-	if (!topo_is_converted(c))
-		return;
-
 	/* Copy the shift values and calculate the unit sizes. */
 	memcpy(x86_topo_system.dom_shifts, tscan.dom_shifts, sizeof(x86_topo_system.dom_shifts));
 
 	dom = TOPO_SMT_DOMAIN;
 	x86_topo_system.dom_size[dom] = 1U << x86_topo_system.dom_shifts[dom];
+	pr_info("Dom %u Sft: %u Sz: %u\n", dom, x86_topo_system.dom_size[dom],
+		x86_topo_system.dom_shifts[dom]);
 
 	for (dom++; dom < TOPO_MAX_DOMAIN; dom++) {
 		sft = x86_topo_system.dom_shifts[dom] - x86_topo_system.dom_shifts[dom - 1];
 		x86_topo_system.dom_size[dom] = 1U << sft;
+		pr_info("Dom %u Sft: %u Sz: %u\n", dom, x86_topo_system.dom_size[dom],
+			x86_topo_system.dom_shifts[dom]);
 	}
 
+	pr_info("NPP %u\n", tscan.amd_nodes_per_pkg);
+
+	if (!topo_is_converted(c))
+		return;
+
 	topo_set_ids(&tscan);
 	topo_set_max_cores(&tscan);
 
@@ -238,6 +252,7 @@ void __init cpu_init_topology(struct cpu
 	 * changes further down the road to get it right during early boot.
 	 */
 	smp_num_siblings = tscan.dom_ncpus[TOPO_SMT_DOMAIN];
+	pr_info("SNS %u\n", smp_num_siblings);
 
 	/*
 	 * Neither it's clear whether there are as many dies as the APIC
@@ -252,4 +267,6 @@ void __init cpu_init_topology(struct cpu
 	 */
 	if (c->x86_vendor == X86_VENDOR_AMD || c->x86_vendor == X86_VENDOR_HYGON)
 		__amd_nodes_per_pkg = __max_die_per_package = tscan.amd_nodes_per_pkg;
+
+	pr_info("NPP %u MDPP %u\n", __amd_nodes_per_pkg, __max_die_per_package);
 }

