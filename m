Return-Path: <linux-kernel+bounces-136865-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C1C089D92B
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 14:25:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5A25C1C21E82
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 12:25:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77F5712D20E;
	Tue,  9 Apr 2024 12:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="BMz7Vtzq";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="BNBi7We/"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D410112C7E8
	for <linux-kernel@vger.kernel.org>; Tue,  9 Apr 2024 12:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712665538; cv=none; b=VVg77l6Cf/SbVeEDImam+sCJ+8pHoto1FR/lM5HqkH5mZfL/wTFJEceqnBKX+opCm3DCRJ6Ny40bYzXGqz9PPF1iBL4ws34pC9F0JL+4DAhktlpa1uD1nV5z0vKgoBpW1GkT9pV+cF9UXhIxEGtZOQyRj/f7lmPdEQEXfMjqOwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712665538; c=relaxed/simple;
	bh=TgYVwxUaN7W/0/J228omEQaBSEXn7kj3mU8IA4nEz/w=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=FsLgx4c2A9hrbTBBEvolWV34k4uJeyBNrtKnzR+UX+sVRV4YlzyIyS+a0F8cnHkdscE87saSIbjvs2fIuTWDFbe6sSNti4wN6v4DYTubeTcWEwckGSp+EypjmPTPs9aNQxElzg6ZgAZ5/QWk31qjVXjrxrkQTVQCg5NWV6oXxXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=BMz7Vtzq; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=BNBi7We/; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1712665535;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=e4cb/lg7L2LLjelwouGfPsEX0svE8jil8IXco8Gx6oM=;
	b=BMz7Vtzq0s1E25+mY1AS9phnPNZfwCmgFuQBAzFvz3mtY7phMMsPoK32ZKEDI0hDaN1Abj
	FA9fKj/Qq/s/kih8cVq2mUCaMUtEAmN4yHlyNkavTgZe62SFrKsBGIN272tzipxoMVXOo8
	SAQFgFqcxORMstGxaU9Y8eNrjUH6kwAJvBF1VKaYYcB3S03/s81E8C2KnCzooZLrKMVAm6
	HPNG/4yXiwtvru1LC86zRs2CPV/IWRg1EFjYvXQL1cnvEqgYIEoEz0ySBOuBVIkmI5AMDn
	OwsmfSY+qCwu/BAkcETYdniQfF64wb4ezdsyfelrHm5ubHO67YdPWSnrm6ewlQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1712665535;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=e4cb/lg7L2LLjelwouGfPsEX0svE8jil8IXco8Gx6oM=;
	b=BNBi7We/WCdEtlPe2M+AZeJILRlT2ug3N4TO6p6L3fbYwSH6GB6HSy0fO5Esa/0W7lkzyT
	/iXC93bnHSarFLDw==
To: Laura Nao <laura.nao@collabora.com>
Cc: kernel@collabora.com, laura.nao@collabora.com,
 linux-kernel@vger.kernel.org, regressions@leemhuis.info,
 regressions@lists.linux.dev, x86@kernel.org
Subject: Re: [REGRESSION] mainline boot regression on AMD Stoney Ridge
 Chromebooks
In-Reply-To: <20240409100736.139489-1-laura.nao@collabora.com>
References: <87r0fg6ioe.ffs@tglx>
 <20240409100736.139489-1-laura.nao@collabora.com>
Date: Tue, 09 Apr 2024 14:25:34 +0200
Message-ID: <874jca7mf5.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Laura!

On Tue, Apr 09 2024 at 12:07, Laura Nao wrote:
> On 4/8/24 16:19, Thomas Gleixner wrote:
>> That's the commit right before switching over and according to your
>> bisect it works. Now apply the patch below, which just runs the new
>> topology scan function but discards the result.
>
> The ace278e7eca6 revision with the patch you provided boots correctly.

Progress :)

Can you please replace that patch with the one below?

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
@@ -215,18 +223,19 @@ void __init cpu_init_topology(struct cpu
 
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
 
 	topo_set_ids(&tscan);
@@ -238,6 +247,7 @@ void __init cpu_init_topology(struct cpu
 	 * changes further down the road to get it right during early boot.
 	 */
 	smp_num_siblings = tscan.dom_ncpus[TOPO_SMT_DOMAIN];
+	pr_info("SNS %u\n", smp_num_siblings);
 
 	/*
 	 * Neither it's clear whether there are as many dies as the APIC
@@ -252,4 +262,6 @@ void __init cpu_init_topology(struct cpu
 	 */
 	if (c->x86_vendor == X86_VENDOR_AMD || c->x86_vendor == X86_VENDOR_HYGON)
 		__amd_nodes_per_pkg = __max_die_per_package = tscan.amd_nodes_per_pkg;
+
+	pr_info("NPP %u MDPP %u\n", __amd_nodes_per_pkg, __max_die_per_package);
 }

