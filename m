Return-Path: <linux-kernel+bounces-131147-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6297D8983B4
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 11:05:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 832811C22049
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 09:05:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF72A73527;
	Thu,  4 Apr 2024 09:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="F6H/DVBx"
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 481D63399A
	for <linux-kernel@vger.kernel.org>; Thu,  4 Apr 2024 09:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712221494; cv=none; b=hKa0YdmtpNzL/jre/qRc5QyYaDsntx8kpI0IwDRSn8BWLaf2TITSbWO1ILKchH+Y0ZVn2Pi06PfIezMWyH7t1/kpIOhWk1sy0vNiokssxl6yCEs/cgmcK6vj1gOBrGYR94u2VCrCVjMAEEP+x+kcoQXbP9xAw8VePBJF2tozsqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712221494; c=relaxed/simple;
	bh=hVXDwNz/6PPPKypdU8YiI752Mkyv/CnDNrWKUccLASY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=o8cGt9YALCOprBxtkPAdKPANIIHg+6clswis2UwyfpStExFqAaMpjnKosp9bimTcRsyE2NmzcT2TmWbrZjGQd/Yfm7y0haXim6GGnCy4U6Y6HAs/aDPohee4p6+8GFSFOInszrHuXkU8gbkjeO7b3V/dBhmjM6RvOiECO1haf1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=F6H/DVBx; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a4e39f5030dso102161966b.0
        for <linux-kernel@vger.kernel.org>; Thu, 04 Apr 2024 02:04:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1712221491; x=1712826291; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1a33R+DF1OItqmjsZhNPe7k8vu04hE0//v/TqbxOAok=;
        b=F6H/DVBxGlLPCafirSDFu4kXVdpr1915vdnfaajirsTvKzPdjI8Jf4xIyVPVA5iW+n
         E3KWUoCQ9R3DJdcJ6VCGjASxtJ0Y8HlJDXv/c3TEWAEA2L9LPgcSGTiqKJb2XJLmOnXC
         HiE7N3uHGmZKZz8VgP1TrBKBImzHrDhl7shahp3VjBV8QsTvQvyzux+ybnPmNvUkVB2S
         hedQ1Pgo+oCJUx6Ec/ji//b6XZ/XnlzkcAxu9v3oEQoAl9P+ZUqs3McyvxbbvIkIT18E
         qLHa0El5pNln73lFt/A7aaCgImap113u07t8fuuGB9FwwY9cD6QvPNb+edfYulo3UeNs
         OR6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712221491; x=1712826291;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1a33R+DF1OItqmjsZhNPe7k8vu04hE0//v/TqbxOAok=;
        b=fhPj3orl7Kb/986LFI21eC1EcKhPa9HTqFdVKIcgahGO0eZgOWoosQhqntExXAuppq
         qZDwN/WsWUqq/YWfAsswBsKuCj/XtNekHaiAMO6VovaQxw1Ne4kkOW50mUvxdoruE1ue
         WR8iLFSvFBEh8Cr0eV30LXtEHNIoTGCNj9/duA67XhnOyituT7uiBYP3o42DrlMXidKd
         +OhgMCbP3NxgmkCwNZuTjV8JdFhJbpg2pom6PVEDkQL9ZkTxOuexyKwc70X6JyY4RNct
         FkarZES39VINyqgKBT2Qa+urFCOm7qlcnG8r3kzF+r6TVp9H2MxZxYmbZDeR+yUCRSGz
         hq9w==
X-Forwarded-Encrypted: i=1; AJvYcCVgZieA9MoM6xpjKPrkhJTZfVgTvL5IAHU/sS1/K+ianNpuvuBOvj9lvr2buWcoI5p4vBZoPgmslmv1uT4rYsB9N0QoDae5FkTjne6d
X-Gm-Message-State: AOJu0YxghaLFMWctVN+mqLG67U7JNHEeVcK7MmmpbgsDffpCHwCk8C9p
	1WW81+c3z6CH5B37DhqSoJtsGiiowChM37Q9ftRbUlP3Jx2fSGIkBqHBKx/UNeZBl+cbGHs3re1
	o60I=
X-Google-Smtp-Source: AGHT+IHLgRd6mQLeq4ssnLovqxgii8VyH5j04zsSr+TC1UYajq0EI9SqcFwzmbepC0hpjFTy8bxGeQ==
X-Received: by 2002:a17:906:2611:b0:a4e:9c7b:c568 with SMTP id h17-20020a170906261100b00a4e9c7bc568mr1408730ejc.0.1712221490551;
        Thu, 04 Apr 2024 02:04:50 -0700 (PDT)
Received: from ?IPV6:2003:e5:873a:400:704b:6dbb:e7c0:786e? (p200300e5873a0400704b6dbbe7c0786e.dip0.t-ipconnect.de. [2003:e5:873a:400:704b:6dbb:e7c0:786e])
        by smtp.gmail.com with ESMTPSA id dq4-20020a170907734400b00a4e2a09efcasm8237928ejc.217.2024.04.04.02.04.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Apr 2024 02:04:50 -0700 (PDT)
Message-ID: <bab18bb7-ef6d-477a-845a-de9b52dd9591@suse.com>
Date: Thu, 4 Apr 2024 11:04:49 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] x86/cpu: Add and use new CPUID region helper
Content-Language: en-US
To: Dave Hansen <dave.hansen@linux.intel.com>, linux-kernel@vger.kernel.org
Cc: tglx@linutronix.de, x86@kernel.org, bp@alien8.de, kai.huang@intel.com
References: <20240403153508.7328E749@davehans-spike.ostc.intel.com>
 <20240403153510.F327603D@davehans-spike.ostc.intel.com>
From: =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>
In-Reply-To: <20240403153510.F327603D@davehans-spike.ostc.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 03.04.24 17:35, Dave Hansen wrote:
> From: Dave Hansen <dave.hansen@linux.intel.com>
> 
> There are some (before now) unwritten rules about CPUID "regions".
> Basically, there is a 32-bit address space of CPUID leaves.  The
> top 16 bits address a "region" and the first leaf in a region
> is special.
> 
> The kernel only has a few spots that care about this, but it's
> rather hard to make sense of the code as is.
> 
> Add a helper that explains regions.  Use it where applicable.
> 
> Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
> Reviewed-by: Kai Huang <kai.huang@intel.com>
> Cc: Juergen Gross <jgross@suse.com>
> 
> --
> 
> changes from v1:
>   * Fix typo comment and whitespace gunk noted by Ingo
> 
> ---
> 
>   b/arch/x86/include/asm/cpuid.h    |   59 ++++++++++++++++++++++++++++++++++++++
>   b/arch/x86/kernel/cpu/common.c    |   13 +++-----
>   b/arch/x86/kernel/cpu/transmeta.c |    9 +----
>   b/arch/x86/xen/enlighten_pv.c     |    9 +----
>   4 files changed, 69 insertions(+), 21 deletions(-)
> 
> diff -puN arch/x86/include/asm/cpuid.h~cpuid-regions arch/x86/include/asm/cpuid.h
> --- a/arch/x86/include/asm/cpuid.h~cpuid-regions	2024-04-02 15:22:58.838912075 -0700
> +++ b/arch/x86/include/asm/cpuid.h	2024-04-02 15:22:58.846912085 -0700
> @@ -168,4 +168,63 @@ static inline uint32_t hypervisor_cpuid_
>   	return 0;
>   }
>   
> +/*
> + * By convention, CPUID is broken up into regions which each
> + * have 2^16 leaves.  EAX in the first leaf of each valid
> + * region returns the maximum valid leaf in that region.
> + *
> + * The regions can be thought of as being vendor-specific
> + * areas of CPUID, but that's imprecise because everybody
> + * implements the "Intel" region and Intel implements the
> + * AMD region.  There are a few well-known regions:
> + *  - Intel	(0x0000)
> + *  - AMD	(0x8000)
> + *  - Transmeta	(0x8086)
> + *  - Centaur	(0xC000)
> + *
> + * Consider a CPU where the maximum leaf in the Transmeta
> + * region is 2.  On such a CPU, leaf 0x80860000 would contain:
> + * EAX==0x80860002.
> + * region-^^^^
> + *   max leaf-^^^^
> + */
> +static inline u32 cpuid_region_max_leaf(u16 region)
> +{
> +	u32 eax = cpuid_eax(region << 16);
> +
> +	/*
> +	 * An unsupported region may return data from the last
> +	 * "basic" leaf, which is essentially garbage.  Avoid
> +	 * mistaking basic leaf data for region data.
> +	 *
> +	 * Note: this is not perfect.  It is theoretically
> +	 * possible for the last basic leaf to _resemble_ a
> +	 * valid first leaf from a region that doesn't exist.
> +	 * But Intel at least seems to pad out the basic region
> +	 * with 0's, possibly to avoid this.
> +	 */
> +	if ((eax >> 16) != region)
> +		return 0;
> +
> +	return eax;
> +}
> +
> +/* Returns true if the leaf exists and @value was populated */
> +static inline bool get_cpuid_region_leaf(u32 leaf, enum cpuid_regs_idx reg,
> +					 u32 *value)
> +{
> +	u16 region = leaf >> 16;
> +	u32 regs[4];
> +
> +	if (cpuid_region_max_leaf(region) < leaf)
> +		return false;
> +
> +	cpuid(leaf, &regs[CPUID_EAX], &regs[CPUID_EBX],
> +	            &regs[CPUID_ECX], &regs[CPUID_EDX]);
> +
> +	*value = regs[reg];
> +
> +	return true;
> +}
> +
>   #endif /* _ASM_X86_CPUID_H */
> diff -puN arch/x86/kernel/cpu/common.c~cpuid-regions arch/x86/kernel/cpu/common.c
> --- a/arch/x86/kernel/cpu/common.c~cpuid-regions	2024-04-02 15:22:58.842912079 -0700
> +++ b/arch/x86/kernel/cpu/common.c	2024-04-02 15:22:58.846912085 -0700
> @@ -1049,16 +1049,13 @@ void get_cpu_cap(struct cpuinfo_x86 *c)
>   	}
>   
>   	/* AMD-defined flags: level 0x80000001 */
> -	eax = cpuid_eax(0x80000000);
> -	c->extended_cpuid_level = eax;
> +	c->extended_cpuid_level = cpuid_region_max_leaf(0x8000);
>   
> -	if ((eax & 0xffff0000) == 0x80000000) {
> -		if (eax >= 0x80000001) {
> -			cpuid(0x80000001, &eax, &ebx, &ecx, &edx);
> +	if (c->extended_cpuid_level >= 0x80000001) {
> +		cpuid(0x80000001, &eax, &ebx, &ecx, &edx);
>   
> -			c->x86_capability[CPUID_8000_0001_ECX] = ecx;
> -			c->x86_capability[CPUID_8000_0001_EDX] = edx;
> -		}
> +		c->x86_capability[CPUID_8000_0001_ECX] = ecx;
> +		c->x86_capability[CPUID_8000_0001_EDX] = edx;
>   	}
>   
>   	if (c->extended_cpuid_level >= 0x80000007) {
> diff -puN arch/x86/kernel/cpu/transmeta.c~cpuid-regions arch/x86/kernel/cpu/transmeta.c
> --- a/arch/x86/kernel/cpu/transmeta.c~cpuid-regions	2024-04-02 15:22:58.842912079 -0700
> +++ b/arch/x86/kernel/cpu/transmeta.c	2024-04-02 15:22:58.846912085 -0700
> @@ -9,14 +9,9 @@
>   
>   static void early_init_transmeta(struct cpuinfo_x86 *c)
>   {
> -	u32 xlvl;
> -
>   	/* Transmeta-defined flags: level 0x80860001 */
> -	xlvl = cpuid_eax(0x80860000);
> -	if ((xlvl & 0xffff0000) == 0x80860000) {
> -		if (xlvl >= 0x80860001)
> -			c->x86_capability[CPUID_8086_0001_EDX] = cpuid_edx(0x80860001);
> -	}
> +	get_cpuid_region_leaf(0x80860001, CPUID_EDX,
> +			  &c->x86_capability[CPUID_8086_0001_EDX]);
>   }
>   
>   static void init_transmeta(struct cpuinfo_x86 *c)
> diff -puN arch/x86/xen/enlighten_pv.c~cpuid-regions arch/x86/xen/enlighten_pv.c
> --- a/arch/x86/xen/enlighten_pv.c~cpuid-regions	2024-04-02 15:22:58.842912079 -0700
> +++ b/arch/x86/xen/enlighten_pv.c	2024-04-03 08:34:28.221534043 -0700
> @@ -141,16 +141,13 @@ static void __init xen_set_mtrr_data(voi
>   	};
>   	unsigned int reg;
>   	unsigned long mask;
> -	uint32_t eax, width;
> +	uint32_t width;
>   	static struct mtrr_var_range var[MTRR_MAX_VAR_RANGES] __initdata;
>   
>   	/* Get physical address width (only 64-bit cpus supported). */
>   	width = 36;
> -	eax = cpuid_eax(0x80000000);
> -	if ((eax >> 16) == 0x8000 && eax >= 0x80000008) {
> -		eax = cpuid_eax(0x80000008);
> -		width = eax & 0xff;
> -	}
> +	/* Will overwrite 'width' if available in CPUID: */
> +	get_cpuid_region_leaf(0x80000008, CPUID_EAX, &width);

Aren't you missing "width &= 0xff;" here? get_cpuid_region_leaf() doesn't
truncate the returned value, which has the linear address width at bits 8-15.


Juergen

