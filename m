Return-Path: <linux-kernel+bounces-138153-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9900F89ED5F
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 10:15:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 23B821F21638
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 08:15:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A6AF13D626;
	Wed, 10 Apr 2024 08:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="liU4mHLV"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4FAD13D52C
	for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 08:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712736913; cv=none; b=LvjLimoskqeSOiFgqTHvbDPKQocdGNgzJQDUS+sRPYFGnGsAP7RGKD9nIxLgUKcYOehTZPIorJLqYnpIVZCQJaaAIJ4Zxo43XwGKEwLpq6KXoc6N9IUfk7YEGeemqMSU3eaQhsXFcyHbjmAG5I5CR+svlx+4qmmm7lpWB5to8W4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712736913; c=relaxed/simple;
	bh=sYX3c+PLA0Rz2+PCJ0OWKE0I/7oyJqQNSEwiKn5Mo0Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NgjEAryMrkimm0libd/pkfzbj36LS216jWDzRhImPmX2lL73sDOpf7Gd5yNkA77wLJJGFFAfrfFFiJrEQtfK1/qYkQGMzAsqjf4u+ScZYTqsiOT7CZWuSOeZf3/OzXKypYoEOGN4SXwmHPZhipuqGB0vXXRgcshyJ3KrJWI3rZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=liU4mHLV; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1712736909;
	bh=sYX3c+PLA0Rz2+PCJ0OWKE0I/7oyJqQNSEwiKn5Mo0Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=liU4mHLV59lW+2HRik1GhHfmJt6qonWXLj5unynGl+9FaUNgcYcI/sQmrXf3NpLto
	 1cLWEguMkm7m9ufruFh3hRV9Akh5tkBwlaskE48glWLg7Diy0RhyTvLuGAnDJwBQmG
	 LRz46Kxl5MTWFnOUsZlFj/QohMh8HPKJ1BNYZNYOBLe0fvcNOMaCMAtKEHFBOWdf7X
	 /8Iv7XZrmRp4+4WMizZFOiUYdn7tK3p/Tbesii0DCwd9Ki2xUpBUVqwSe9+DnaZOEs
	 l9G6jbuHbsXV8lU7ekBfPGf+nGExyRQurriY0EhzaKqIwSRd2fho+t1T+c6eJqCNZG
	 R+2l27+HOAQtA==
Received: from localhost.localdomain (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: laura.nao)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 8605D3780C13;
	Wed, 10 Apr 2024 08:15:08 +0000 (UTC)
From: Laura Nao <laura.nao@collabora.com>
To: tglx@linutronix.de
Cc: kernel@collabora.com,
	laura.nao@collabora.com,
	linux-kernel@vger.kernel.org,
	regressions@leemhuis.info,
	regressions@lists.linux.dev,
	x86@kernel.org
Subject: Re: [REGRESSION] mainline boot regression on AMD Stoney Ridge Chromebooks
Date: Wed, 10 Apr 2024 10:15:28 +0200
Message-Id: <20240410081529.126363-1-laura.nao@collabora.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <874jca7mf5.ffs@tglx>
References: <874jca7mf5.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Thomas,

On 4/9/24 14:25, Thomas Gleixner wrote:
> Laura!
> 
> On Tue, Apr 09 2024 at 12:07, Laura Nao wrote:
>> On 4/8/24 16:19, Thomas Gleixner wrote:
>>> That's the commit right before switching over and according to your
>>> bisect it works. Now apply the patch below, which just runs the new
>>> topology scan function but discards the result.
>>
>> The ace278e7eca6 revision with the patch you provided boots correctly.
> 
> Progress :)
> 

Indeed :)

> Can you please replace that patch with the one below?

So, with this patch applied on top of ace278e7eca6 the kernel doesn't
boot anymore - reference test job: 
https://lava.collabora.dev/scheduler/job/13324010

I see the only change between the second and third patch you provided,
besides the debug prints, is:

-	if (!topo_is_converted(c))
-		return;
-

Printing the debug information without this probably doesn't really help, 
but just in case it's useful: I tried excluding the change above from the
patch while leaving everything else unchanged - reference test job:
https://lava.collabora.dev/scheduler/job/13324298 (also pasted the
kernel log here for easier consultation: https://pastebin.com/raw/TQBDvCah)

Hope this helps,

Laura

> 
> Thanks,
> 
>          tglx
> ---
> --- a/arch/x86/kernel/cpu/common.c
> +++ b/arch/x86/kernel/cpu/common.c
> @@ -1616,6 +1616,13 @@ void __init early_cpu_init(void)
>   #endif
>   	}
>   	early_identify_cpu(&boot_cpu_data);
> +
> +	pr_info("Max cores: %u\n", boot_cpu_data.x86_max_cores);
> +	pr_info("pkg %u die %u core %u nid %u\n", boot_cpu_data.topo.pkg_id,
> +		boot_cpu_data.topo.die_id, boot_cpu_data.topo.core_id,
> +		boot_cpu_data.topo.amd_node_id);
> +	pr_info("SNS %u\n", smp_num_siblings);
> +	pr_info("NPP %u MDPP %u\n", __amd_nodes_per_pkg, __max_die_per_package);
>   }
>   
>   static bool detect_null_seg_behavior(void)
> --- a/arch/x86/kernel/cpu/topology_amd.c
> +++ b/arch/x86/kernel/cpu/topology_amd.c
> @@ -29,7 +29,17 @@ static bool parse_8000_0008(struct topo_
>   	if (!sft)
>   		sft = get_count_order(ecx.cpu_nthreads + 1);
>   
> -	topology_set_dom(tscan, TOPO_SMT_DOMAIN, sft, ecx.cpu_nthreads + 1);
> +	/*
> +	 * cpu_nthreads describes the number of threads in the package
> +	 * sft is the number of APIC ID bits per package
> +	 *
> +	 * As the number of actual threads per core is not described in
> +	 * this leaf, just set the CORE domain shift and let the later
> +	 * parsers set SMT shift. Assume one thread per core by default
> +	 * which is correct if there are no other CPUID leafs to parse.
> +	 */
> +	topology_update_dom(tscan, TOPO_SMT_DOMAIN, 0, 1);
> +	topology_set_dom(tscan, TOPO_CORE_DOMAIN, sft, ecx.cpu_nthreads + 1);
>   	return true;
>   }
>   
> @@ -73,12 +83,14 @@ static bool parse_8000_001e(struct topo_
>   	tscan->c->topo.initial_apicid = leaf.ext_apic_id;
>   
>   	/*
> -	 * If leaf 0xb is available, then SMT shift is set already. If not
> -	 * take it from ecx.threads_per_core and use topo_update_dom() -
> -	 * topology_set_dom() would propagate and overwrite the already
> -	 * propagated CORE level.
> +	 * If leaf 0xb is available, then the domain shifts are set
> +	 * already and nothing to do here.
>   	 */
>   	if (!has_0xb) {
> +		/*
> +		 * Leaf 0x80000008 set the CORE domain shift already.
> +		 * Update the SMT domain, but do not propagate it.
> +		 */
>   		unsigned int nthreads = leaf.core_nthreads + 1;
>   
>   		topology_update_dom(tscan, TOPO_SMT_DOMAIN, get_count_order(nthreads), nthreads);
> --- a/arch/x86/kernel/cpu/topology_common.c
> +++ b/arch/x86/kernel/cpu/topology_common.c
> @@ -133,6 +133,10 @@ static void parse_topology(struct topo_s
>   	tscan->ebx1_nproc_shift = get_count_order(ebx.nproc);
>   
>   	switch (c->x86_vendor) {
> +	case X86_VENDOR_AMD:
> +		if (IS_ENABLED(CONFIG_CPU_SUP_AMD))
> +			cpu_parse_topology_amd(tscan);
> +		break;
>   	case X86_VENDOR_CENTAUR:
>   	case X86_VENDOR_ZHAOXIN:
>   		parse_legacy(tscan);
> @@ -162,6 +166,9 @@ static void topo_set_ids(struct topo_sca
>   
>   	if (c->x86_vendor == X86_VENDOR_AMD)
>   		cpu_topology_fixup_amd(tscan);
> +
> +	pr_info("pkg %u die %u core %u nid %u\n", c->topo.pkg_id, c->topo.die_id,
> +		c->topo.core_id, c->topo.amd_node_id);
>   }
>   
>   static void topo_set_max_cores(struct topo_scan *tscan)
> @@ -175,6 +182,7 @@ static void topo_set_max_cores(struct to
>   	 */
>   	tscan->c->x86_max_cores = tscan->dom_ncpus[TOPO_DIEGRP_DOMAIN] >>
>   		x86_topo_system.dom_shifts[TOPO_SMT_DOMAIN];
> +	pr_info("Max cores: %u\n", tscan->c->x86_max_cores);
>   }
>   
>   void cpu_parse_topology(struct cpuinfo_x86 *c)
> @@ -215,18 +223,19 @@ void __init cpu_init_topology(struct cpu
>   
>   	parse_topology(&tscan, true);
>   
> -	if (!topo_is_converted(c))
> -		return;
> -
>   	/* Copy the shift values and calculate the unit sizes. */
>   	memcpy(x86_topo_system.dom_shifts, tscan.dom_shifts, sizeof(x86_topo_system.dom_shifts));
>   
>   	dom = TOPO_SMT_DOMAIN;
>   	x86_topo_system.dom_size[dom] = 1U << x86_topo_system.dom_shifts[dom];
> +	pr_info("Dom %u Sft: %u Sz: %u\n", dom, x86_topo_system.dom_size[dom],
> +		x86_topo_system.dom_shifts[dom]);
>   
>   	for (dom++; dom < TOPO_MAX_DOMAIN; dom++) {
>   		sft = x86_topo_system.dom_shifts[dom] - x86_topo_system.dom_shifts[dom - 1];
>   		x86_topo_system.dom_size[dom] = 1U << sft;
> +		pr_info("Dom %u Sft: %u Sz: %u\n", dom, x86_topo_system.dom_size[dom],
> +			x86_topo_system.dom_shifts[dom]);
>   	}
>   
>   	topo_set_ids(&tscan);
> @@ -238,6 +247,7 @@ void __init cpu_init_topology(struct cpu
>   	 * changes further down the road to get it right during early boot.
>   	 */
>   	smp_num_siblings = tscan.dom_ncpus[TOPO_SMT_DOMAIN];
> +	pr_info("SNS %u\n", smp_num_siblings);
>   
>   	/*
>   	 * Neither it's clear whether there are as many dies as the APIC
> @@ -252,4 +262,6 @@ void __init cpu_init_topology(struct cpu
>   	 */
>   	if (c->x86_vendor == X86_VENDOR_AMD || c->x86_vendor == X86_VENDOR_HYGON)
>   		__amd_nodes_per_pkg = __max_die_per_package = tscan.amd_nodes_per_pkg;
> +
> +	pr_info("NPP %u MDPP %u\n", __amd_nodes_per_pkg, __max_die_per_package);
>   }

