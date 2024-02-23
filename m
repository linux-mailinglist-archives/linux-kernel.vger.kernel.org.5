Return-Path: <linux-kernel+bounces-78646-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8527386166D
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 16:54:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 09C0DB22A84
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 15:54:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B32FE82D77;
	Fri, 23 Feb 2024 15:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.de header.i=@amazon.de header.b="k6p6YXJn"
Received: from smtp-fw-80007.amazon.com (smtp-fw-80007.amazon.com [99.78.197.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EB81823DF;
	Fri, 23 Feb 2024 15:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708703614; cv=none; b=YlP8STZUobrz2lsyCkPj1OsM3OWHOHB9h2H3pWHJMCwdz6w/UicMt6GHzVe9hfbXHFPjfbtiR7D1+AaKiOiMtah7Jv1QWJJ5wJLoxqltmV/b3r7m9PhjPwi4GwBHvZA+9dAfeHSBibaS25YU971trFBG8s4eEpniX+x1oZsCxDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708703614; c=relaxed/simple;
	bh=OGPpm0ljDEb18ajR9h+VaLFVBUhZyJO5/wG+iZhEHvc=;
	h=From:To:CC:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=nYQZTpANhR7SIF/gnuMzvg2t7SdaUE2ZSryC3+0Vh7/+KGo/CwZ2kcAXKJ1PZiJl3Fd4B7OgMRIJskyJVGAQp/AmYdu+VR8iNQHFhAhnaRm/hYLsATfigFPE7YBAkYYvB1uCCudRn9PL9pixvFULQCi+OZN5/vx/Yt64FgQ4qLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de; spf=pass smtp.mailfrom=amazon.de; dkim=pass (1024-bit key) header.d=amazon.de header.i=@amazon.de header.b=k6p6YXJn; arc=none smtp.client-ip=99.78.197.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazon201209;
  t=1708703613; x=1740239613;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=0WhTIN9W38rHyOc22G1vQ7ixEZgYslJzQI/6oPVT4RA=;
  b=k6p6YXJnn0co50OyF0lLYjB3IbRlq1iNWBjsMHvd44mIzHhAjPFV1E7c
   Yrs2vsxNA6nt8SOiV0b8E4ViFINIFbHqc3YDKfhAswA/K9g7MkdwM04Q9
   /efw4Mbhw6REvSMSElAT5FAkR4psJXdwcX9AFk0ro4cqwudtv1MkPyNPD
   c=;
X-IronPort-AV: E=Sophos;i="6.06,180,1705363200"; 
   d="scan'208";a="276297960"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-east-1.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-80007.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2024 15:53:29 +0000
Received: from EX19MTAUEB001.ant.amazon.com [10.0.0.204:49000]
 by smtpin.naws.us-east-1.prod.farcaster.email.amazon.dev [10.0.11.226:2525] with esmtp (Farcaster)
 id 8c10934d-ba88-400b-b524-af83d373a694; Fri, 23 Feb 2024 15:53:28 +0000 (UTC)
X-Farcaster-Flow-ID: 8c10934d-ba88-400b-b524-af83d373a694
Received: from EX19D008UEC003.ant.amazon.com (10.252.135.194) by
 EX19MTAUEB001.ant.amazon.com (10.252.135.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Fri, 23 Feb 2024 15:53:26 +0000
Received: from EX19MTAUEC001.ant.amazon.com (10.252.135.222) by
 EX19D008UEC003.ant.amazon.com (10.252.135.194) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Fri, 23 Feb 2024 15:53:26 +0000
Received: from dev-dsk-ptyadav-1c-37607b33.eu-west-1.amazon.com (10.15.11.255)
 by mail-relay.amazon.com (10.252.135.200) with Microsoft SMTP Server id
 15.2.1118.40 via Frontend Transport; Fri, 23 Feb 2024 15:53:26 +0000
Received: by dev-dsk-ptyadav-1c-37607b33.eu-west-1.amazon.com (Postfix, from userid 23027615)
	id BF2E820D24; Fri, 23 Feb 2024 16:53:25 +0100 (CET)
From: Pratyush Yadav <ptyadav@amazon.de>
To: Alexander Graf <graf@amazon.com>
CC: <linux-kernel@vger.kernel.org>, <linux-trace-kernel@vger.kernel.org>,
	<linux-mm@kvack.org>, <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <kexec@lists.infradead.org>,
	<linux-doc@vger.kernel.org>, <x86@kernel.org>, Eric Biederman
	<ebiederm@xmission.com>, "H . Peter Anvin" <hpa@zytor.com>, Andy Lutomirski
	<luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Steven Rostedt
	<rostedt@goodmis.org>, Andrew Morton <akpm@linux-foundation.org>, "Mark
 Rutland" <mark.rutland@arm.com>, Tom Lendacky <thomas.lendacky@amd.com>,
	Ashish Kalra <ashish.kalra@amd.com>, James Gowans <jgowans@amazon.com>,
	Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>, <arnd@arndb.de>,
	<pbonzini@redhat.com>, <madvenka@linux.microsoft.com>, Anthony Yznaga
	<anthony.yznaga@oracle.com>, Usama Arif <usama.arif@bytedance.com>, "David
 Woodhouse" <dwmw@amazon.co.uk>, Benjamin Herrenschmidt
	<benh@kernel.crashing.org>, Rob Herring <robh+dt@kernel.org>, "Krzysztof
 Kozlowski" <krzk@kernel.org>
Subject: Re: [PATCH v3 02/17] memblock: Declare scratch memory as CMA
In-Reply-To: <20240117144704.602-3-graf@amazon.com> (Alexander Graf's message
	of "Wed, 17 Jan 2024 14:46:49 +0000")
References: <20240117144704.602-1-graf@amazon.com>
	<20240117144704.602-3-graf@amazon.com>
Date: Fri, 23 Feb 2024 16:53:25 +0100
Message-ID: <mafs0r0h36utm.fsf@amazon.de>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Hi,

On Wed, Jan 17 2024, Alexander Graf wrote:

> When we finish populating our memory, we don't want to lose the scratch
> region as memory we can use for useful data. Do do that, we mark it as
> CMA memory. That means that any allocation within it only happens with
> movable memory which we can then happily discard for the next kexec.
>
> That way we don't lose the scratch region's memory anymore for
> allocations after boot.
>
> Signed-off-by: Alexander Graf <graf@amazon.com>
>
[...]
> @@ -2188,6 +2185,16 @@ static void __init __free_pages_memory(unsigned long start, unsigned long end)
>  	}
>  }
>  
> +static void mark_phys_as_cma(phys_addr_t start, phys_addr_t end)
> +{
> +	ulong start_pfn = pageblock_start_pfn(PFN_DOWN(start));
> +	ulong end_pfn = pageblock_align(PFN_UP(end));
> +	ulong pfn;
> +
> +	for (pfn = start_pfn; pfn < end_pfn; pfn += pageblock_nr_pages)
> +		set_pageblock_migratetype(pfn_to_page(pfn), MIGRATE_CMA);

This fails to compile if CONFIG_CMA is disabled. I think you should add
it as a dependency for CONFIG_MEMBLOCK_SCRATCH.

> +}
> +
>  static unsigned long __init __free_memory_core(phys_addr_t start,
>  				 phys_addr_t end)
>  {
> @@ -2249,6 +2256,17 @@ static unsigned long __init free_low_memory_core_early(void)
>  
>  	memmap_init_reserved_pages();
>  
> +	if (IS_ENABLED(CONFIG_MEMBLOCK_SCRATCH)) {
> +		/*
> +		 * Mark scratch mem as CMA before we return it. That way we
> +		 * ensure that no kernel allocations happen on it. That means
> +		 * we can reuse it as scratch memory again later.
> +		 */
> +		__for_each_mem_range(i, &memblock.memory, NULL, NUMA_NO_NODE,
> +				     MEMBLOCK_SCRATCH, &start, &end, NULL)
> +			mark_phys_as_cma(start, end);
> +	}
> +
>  	/*
>  	 * We need to use NUMA_NO_NODE instead of NODE_DATA(0)->node_id
>  	 *  because in some case like Node0 doesn't have RAM installed

-- 
Regards,
Pratyush Yadav



Amazon Development Center Germany GmbH
Krausenstr. 38
10117 Berlin
Geschaeftsfuehrung: Christian Schlaeger, Jonathan Weiss
Eingetragen am Amtsgericht Charlottenburg unter HRB 149173 B
Sitz: Berlin
Ust-ID: DE 289 237 879




