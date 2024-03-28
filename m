Return-Path: <linux-kernel+bounces-120254-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 314D288D4F3
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 04:19:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8FDAE1F30268
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 03:19:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3BDC224DC;
	Wed, 27 Mar 2024 03:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VSCJE6fe"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B05A17545
	for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 03:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711509591; cv=none; b=GlCWYT4wgD+SdafAQBGl+SlglQEw3gqC3/Af/nH0heT16iTh8btqmzreP/jguUQ4bwfS8/qzc9YRqe1/xElxdT7bVE/fqO6H+P9VadzonjZIwLNNorYgQlTdpKXWRuaOtuz/9HSf6dujgJP5IXvZc8E15iKnjZb39o+NrkzihoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711509591; c=relaxed/simple;
	bh=Bj8TUR9PJebcUXoy+3j+AS4/ttOInjLbzbYpPBhWLUw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=J6leNnShEYQIj26CR2Tu32mhGGUYA6j2Y3+owa7r744mb5QHRk6UXn7aNWElmDfYOUwCse7hGJhXhTx+ZP8pdFvOisaxLMsXrD8vOZ2w91wxza0j6IytdtM9wSKXdlaKLnqdDsFYacYvZoL65BusjWvIiUBK9wEm2xP7ePa22L0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VSCJE6fe; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711509588;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nMOYysNTZbJkbW3L4ydCiT3DWRHiCFwQmnecgf0S0aA=;
	b=VSCJE6fetyxwIC7xhQtpOOA/eUraB4jKkW7XXIcZ+YSQLMauT8O4MDZLrLnTVKIAedQf9a
	iZmdGf+XdwHQ7rzIn30XC1WGtnF6Tekv2ivsPJ6m/hSsKHIjanSJixoPvCegAzkmv81Gnx
	hQ+t1c+YnDgSiK1IilJ90amklwpCSAI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-58-AdQZjFVjMt2m7tWA031Ptg-1; Tue, 26 Mar 2024 23:19:44 -0400
X-MC-Unique: AdQZjFVjMt2m7tWA031Ptg-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0373985A58C;
	Wed, 27 Mar 2024 03:19:44 +0000 (UTC)
Received: from [10.22.18.245] (unknown [10.22.18.245])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 0B1DF492BC8;
	Wed, 27 Mar 2024 03:19:42 +0000 (UTC)
Message-ID: <80425222-4441-417e-a53e-1aa692b931d7@redhat.com>
Date: Tue, 26 Mar 2024 23:19:38 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] x86/tsc: Use topology_max_packages() to get package
 number
Content-Language: en-US
To: Feng Tang <feng.tang@intel.com>, Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@intel.com>, "H . Peter Anvin" <hpa@zytor.com>,
 Peter Zijlstra <peterz@infradead.org>, x86@kernel.org, paulmck@kernel.org,
 rui.zhang@intel.com, linux-kernel@vger.kernel.org
Cc: Dave Hansen <dave.hansen@linux.intel.com>
References: <20240327025105.2861341-1-feng.tang@intel.com>
From: Waiman Long <longman@redhat.com>
In-Reply-To: <20240327025105.2861341-1-feng.tang@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9

On 3/26/24 22:51, Feng Tang wrote:
> Commit b50db7095fe0 ("x86/tsc: Disable clocksource watchdog for TSC
> on qualified platorms") was introduced to solve problem that
> sometimes TSC clocksource is wrongly judged as unstable by watchdog
> like 'jiffies', HPET, etc.
>
> In it, the hardware package number is a key factor for judging whether
> to disable the watchdog for TSC, and 'nr_online_nodes' was chosen due
> to it is available in early boot phase before registering 'tsc-early'
> clocksource, where all non-boot CPUs are not brought up yet.
>
> Dave and Rui pointed out there are many cases in which 'nr_online_nodes'
> is cheated and not accurate, like:
>
> * numa emulation (numa=fake=8 etc.)
> * numa=off
> * platforms with CPU-less HBM nodes, CPU-less Optane memory nodes.
> * SNC (sub-numa cluster) mode enabled
> * 'maxcpus=' cmdline setup, where chopped CPUs could be onlined later
> * 'nr_cpus=', 'possible_cpus=' cmdline setup, where chopped CPUs can
>    not be onlined after boot
>
> Thomas' recent patchset of refactoring x86 topology code improves
> topology_max_packages(), by making it more accurate and available in
> early boot phase, which works well in most of the above cases.
>
> The only exceptions are 'nr_cpus=' and 'possible_cpus=' setup.  And
> the reason is, during topology setup, the boot CPU iterates through
> all enumerated APIC ids and either accepts or rejects the APIC id.
> For accepted ids, it figures out which bits of the id map to the
> package number.  It tracks which package numbers have been seen in a
> bitmap.  topology_max_packages() just returns the number of bits set
> in that bitmap.
>
> 'nr_cpus=' and 'possible_cpus=' can cause more APIC ids to be rejected
> and can artificially lower the number of bits in the package bitmap
> and thus topology_max_packages().  This means that, for example, a
> system with 8 physical packages might reject all the CPUs on 6 of those
> packages and be left with only 2 packages and 2 bits set in the package
> bitmap. It needs the TSC watchdog, but would disable it anyway.  This
> isn't ideal, but this only happens for debug-oriented options. This is
> fixable by tracking the package numbers for rejected CPUs.  But it's
> not worth the trouble for debugging.
>
> So use topology_max_packages() to replace nr_online_nodes().
>
> Reported-by: Dave Hansen <dave.hansen@linux.intel.com>
> Closes: https://lore.kernel.org/lkml/a4860054-0f16-6513-f121-501048431086@intel.com/
> Signed-off-by: Feng Tang <feng.tang@intel.com>
> ---
>
> Hi all,
>
> For warning about possible compromise due to 'nr_cpus=' and 'possible_cpus=',
> one alternative is to check whether these has been setup in cmdline inside
> tsc.c and warn there.
>
> Changelog:
>
>    Since v2:
>    * Use 'pr_info' to replace 'pr_warn' which could panic system
>      if 'panic_on_warn=1' kcmdline parameter is on (Waiman)
>
>    Since v1:
>    * Use Dave's detailed elaboration about 'nr_cpus=', 'possible_cpus='
>      possibly compromising '__max_logical_packages' in commit log
>    * Fix typos and inaccuracy (Rui and Longman)
>
>
>   arch/x86/kernel/cpu/topology.c | 5 ++++-
>   arch/x86/kernel/tsc.c          | 7 ++-----
>   2 files changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/arch/x86/kernel/cpu/topology.c b/arch/x86/kernel/cpu/topology.c
> index 3259b1d4fefe..9db66597388e 100644
> --- a/arch/x86/kernel/cpu/topology.c
> +++ b/arch/x86/kernel/cpu/topology.c
> @@ -460,8 +460,11 @@ void __init topology_init_possible_cpus(void)
>   	pr_info("Num. threads per package: %3u\n", __num_threads_per_package);
>   
>   	pr_info("Allowing %u present CPUs plus %u hotplug CPUs\n", assigned, disabled);
> -	if (topo_info.nr_rejected_cpus)
> +	if (topo_info.nr_rejected_cpus) {
>   		pr_info("Rejected CPUs %u\n", topo_info.nr_rejected_cpus);
> +		if (__max_logical_packages <= 4)
> +			pr_info("TSC might be buggered due to the rejected CPUs\n");
> +	}
>   
>   	init_cpu_present(cpumask_of(0));
>   	init_cpu_possible(cpumask_of(0));
> diff --git a/arch/x86/kernel/tsc.c b/arch/x86/kernel/tsc.c
> index 5a69a49acc96..d00f88f16eb1 100644
> --- a/arch/x86/kernel/tsc.c
> +++ b/arch/x86/kernel/tsc.c
> @@ -1252,15 +1252,12 @@ static void __init check_system_tsc_reliable(void)
>   	 *  - TSC which does not stop in C-States
>   	 *  - the TSC_ADJUST register which allows to detect even minimal
>   	 *    modifications
> -	 *  - not more than two sockets. As the number of sockets cannot be
> -	 *    evaluated at the early boot stage where this has to be
> -	 *    invoked, check the number of online memory nodes as a
> -	 *    fallback solution which is an reasonable estimate.
> +	 *  - not more than four packages
>   	 */
>   	if (boot_cpu_has(X86_FEATURE_CONSTANT_TSC) &&
>   	    boot_cpu_has(X86_FEATURE_NONSTOP_TSC) &&
>   	    boot_cpu_has(X86_FEATURE_TSC_ADJUST) &&
> -	    nr_online_nodes <= 4)
> +	    topology_max_packages() <= 4)
>   		tsc_disable_clocksource_watchdog();
>   }
>   
Reviewed-by: Waiman Long <longman@redhat.com>


