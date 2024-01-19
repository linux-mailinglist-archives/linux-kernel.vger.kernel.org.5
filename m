Return-Path: <linux-kernel+bounces-30664-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B2D578322C2
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 01:49:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D84051C22EAC
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 00:49:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F32881376;
	Fri, 19 Jan 2024 00:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="DSD1zX89"
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A2D8818
	for <linux-kernel@vger.kernel.org>; Fri, 19 Jan 2024 00:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705625363; cv=none; b=YzQP6hr4eDMmL8ylry2Und8JdlzrBquY/ZDkm93/iSyz0QmaUbJWx9JX681UxfTc7P8CBw9/he5m+R2d5oWZCGHnuHksjm2mjm+Wbqwr17Z7Us4EG3AzNkd/SMGKrMY/anuSidZv89vKbbkgrbDIWKc2Z52LxoM84o9ACc8iYJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705625363; c=relaxed/simple;
	bh=rydYd/Y5i8IwNquaHNsrMqfkz0FVri47/DCexZ/mj2A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cxtj6XIOA2QJ4wgQQ+byTi1qi3B2yRVeGdlXbOTtnVomNiYZpFImBt7Gay/JGCLSha4W2aYpCHi+L5t/hHOspYd15Zuei2C02vLrGs/z9EJUxu02h/6BHELgl14BDmSxYoWQ7ZueGixm0ELNjiiug1zky5n5sTQv601ZiRYNSJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=DSD1zX89; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-50ea8fbf261so238735e87.2
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 16:49:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1705625358; x=1706230158; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yJn7PDCEsi1flK+Hr69h8xa87hWqbunI7cAobJSuTQg=;
        b=DSD1zX893SfFdeEyCLQhSD7rEMinJQshYyP0+5vpCLhQX2rbBnfsnZc7QmTtI7YYUy
         yvVLz2gUftloO2jbSa5wHWc9YfwLIhqwTCMlM2/zMCOv8wY0yDkKV1husrFSRc52N7b3
         b57qYkHs2lYR6bg7SKRsy1S0Dkvb5h1wsq3raIsQ/uOP9fpJltl0ssVu0GINw0UrGctV
         hUlEVHffGBrR/r6OxpClmUGD/7zdaF0bl65ax43a/ZaBTNVvgWjRlGVtZeYYZ9y1WH1B
         H1+ocFdgKMeLuY0ve51fZB4+UYgjKPRyCi4Pcv3qQaOPlj4fC+msqtPnb16IETeUQ995
         tsyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705625358; x=1706230158;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yJn7PDCEsi1flK+Hr69h8xa87hWqbunI7cAobJSuTQg=;
        b=HHs3Q1hQ9du82dXtvDIQ9agCh2vy4gQc8VNE64JBR9nIJdLCBEW9+UjqZX+kygFvcs
         A6KJqebk7BPGDzZlfRoVP5/8jQ+nso9FzI8d7o9iXVxmLzA1XjlbUFOozG2kMlwNGu6v
         jogQiGKDY4yCTs4nq65PGPhtFowwtWNkHvS5JQqsTTPgbFSO+q77zi1Fsnfe4R9lnckU
         d16T0lI9b+iPkpxg9lnSBI/1fB1nRgd1eJ3m3KD0McEA3aFm3/x0fhBFoarvf/F26q8Q
         XPFm/MZ+q1blqIiDNYlv4EHrNQDxpnbNi8GtTZbaWVpODvhukpDOiVpArzmaaaYXyk0n
         5twQ==
X-Gm-Message-State: AOJu0YyI+Ljhy/5aWA6TY+8c1QZLfUJ8ruCyOiuki4/OdFavl85+wsNU
	nuAb9MRI9iVn6XO6wxOHXnLAJngGX1xB8ykJ1hjv74Gs0FJ61Gp79nT76TmYzlM=
X-Google-Smtp-Source: AGHT+IE1RMykqY7ypSA9IAyOG2VLdYemmThfjgfyVA18SwO+Ea6UxOkjrJwKd7Juj/sIK9X49SBu3g==
X-Received: by 2002:ac2:44ba:0:b0:50e:74e1:144a with SMTP id c26-20020ac244ba000000b0050e74e1144amr193290lfm.15.1705625358236;
        Thu, 18 Jan 2024 16:49:18 -0800 (PST)
Received: from ?IPV6:2a10:bac0:b000:7589:26fc:cf3:a5b9:2475? ([2a10:bac0:b000:7589:26fc:cf3:a5b9:2475])
        by smtp.gmail.com with ESMTPSA id f16-20020ac24e50000000b0050f09876c12sm810285lfr.208.2024.01.18.16.49.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Jan 2024 16:49:18 -0800 (PST)
Message-ID: <fc731bd3-4232-4906-9f78-448a96e3eb5b@suse.com>
Date: Fri, 19 Jan 2024 02:49:16 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] x86/virt/tdx: Disable KEXEC in the presence of TDX
Content-Language: en-US
To: "Huang, Kai" <kai.huang@intel.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>
Cc: "linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>,
 "x86@kernel.org" <x86@kernel.org>,
 "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>
References: <20240118160118.1899299-1-nik.borisov@suse.com>
 <e75addd3a8af6ef0243999f933df528e975d5ca3.camel@intel.com>
From: Nikolay Borisov <nik.borisov@suse.com>
In-Reply-To: <e75addd3a8af6ef0243999f933df528e975d5ca3.camel@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

[Adding Kirill as he has a series in flight about KEXEC]

On 18.01.24 г. 23:31 ч., Huang, Kai wrote:
> On Thu, 2024-01-18 at 18:01 +0200, Nikolay Borisov wrote:
>> TDX doesn't currently support kexec so disable the latter when TDX
>> is detected at boot time. If kexec must absolutely be supported then
>> TDX can be disabled from the bios.
>>
>> Making this decision at run time rather than as a compile time option
>> allows distribution kernels to have both enabled and delegate to the
>> user whether they want to use TDX/Kexec.
>>
>> Signed-off-by: Nikolay Borisov <nik.borisov@suse.com>
> 
> Hi Nikolay,
> 
> Thanks for the patch.
> 
> I am working in progress on patches to make kexec() work with TDX.  I plan to
> send them out soon (e.g., next week), but I think perhaps your patch is
> reasonable before that is merged.

I thought Kirill's series rectifies this ?


> 
> Acked-by: Kai Huang <kai.huang@intel.com>
> 
>> ---
>>
>> Sending as RFC as I don't know the reason why initially it was decided to
>> enforce the incompaibility between kexec/tdx at build time rather than runtime.
>>
>>   arch/x86/Kconfig            | 1 -
>>   arch/x86/virt/vmx/tdx/tdx.c | 6 ++++++
>>   include/linux/kexec.h       | 1 +
>>   kernel/kexec_core.c         | 5 +++++
>>   4 files changed, 12 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
>> index 92c03cb99b3e..6c2b620b40d8 100644
>> --- a/arch/x86/Kconfig
>> +++ b/arch/x86/Kconfig
>> @@ -1973,7 +1973,6 @@ config INTEL_TDX_HOST
>>   	depends on X86_X2APIC
>>   	select ARCH_KEEP_MEMBLOCK
>>   	depends on CONTIG_ALLOC
>> -	depends on !KEXEC_CORE
>>   	depends on X86_MCE
>>   	help
>>   	  Intel Trust Domain Extensions (TDX) protects guest VMs from malicious
>> diff --git a/arch/x86/virt/vmx/tdx/tdx.c b/arch/x86/virt/vmx/tdx/tdx.c
>> index 4d6826a76f78..270090bd7b5e 100644
>> --- a/arch/x86/virt/vmx/tdx/tdx.c
>> +++ b/arch/x86/virt/vmx/tdx/tdx.c
>> @@ -20,6 +20,7 @@
>>   #include <linux/memblock.h>
>>   #include <linux/memory.h>
>>   #include <linux/minmax.h>
>> +#include <linux/kexec.h>
>>   #include <linux/sizes.h>
>>   #include <linux/pfn.h>
>>   #include <linux/align.h>
>> @@ -1473,6 +1474,11 @@ void __init tdx_init(void)
>>   		return;
>>   	}
>>
>> +#ifdef CONFIG_KEXEC_CORE
>> +	kexec_disable();
>> +	pr_info("Disable Kexec. Turn off TDX in the BIOS to use KEXEC.\n");
>> +#endif
>> +
>>   #if defined(CONFIG_ACPI) && defined(CONFIG_SUSPEND)
>>   	pr_info("Disable ACPI S3. Turn off TDX in the BIOS to use ACPI S3.\n");
>>   	acpi_suspend_lowlevel = NULL;
>> diff --git a/include/linux/kexec.h b/include/linux/kexec.h
>> index 8227455192b7..c434c8569242 100644
>> --- a/include/linux/kexec.h
>> +++ b/include/linux/kexec.h
>> @@ -500,6 +500,7 @@ static inline int crash_hotplug_memory_support(void) { return 0; }
>>   static inline unsigned int crash_get_elfcorehdr_size(void) { return 0; }
>>   #endif
>>
>> +extern void kexec_disable(void);
>>   #else /* !CONFIG_KEXEC_CORE */
>>   struct pt_regs;
>>   struct task_struct;
>> diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
>> index be5642a4ec49..8d3a2a04ff4d 100644
>> --- a/kernel/kexec_core.c
>> +++ b/kernel/kexec_core.c
>> @@ -927,6 +927,11 @@ struct kimage *kexec_image;
>>   struct kimage *kexec_crash_image;
>>   static int kexec_load_disabled;
>>
>> +void kexec_disable(void)
>> +{
>> +	kexec_load_disabled = 1;
>> +}
>> +
>>   #ifdef CONFIG_SYSCTL
>>   static int kexec_limit_handler(struct ctl_table *table, int write,
>>   			       void *buffer, size_t *lenp, loff_t *ppos)
>> --
>> 2.34.1
>>
>>
> 

