Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D8B97E99B0
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Nov 2023 11:02:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233460AbjKMKCo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Nov 2023 05:02:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232587AbjKMKCl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 05:02:41 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA17AD5A
        for <linux-kernel@vger.kernel.org>; Mon, 13 Nov 2023 02:01:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1699869709;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BAMalQgNM0C7HuKoU35TO9KZ8bUeH1IJgfZxeS8F7ZM=;
        b=U69dgpQ7EZyItc6N9BCvkuVQGLcL1px63FpFVzG8w4dCckFeWJ4cdf5A1p7Ctd4fOLP5QV
        ic0yZy3gWiQz37sv7ZeLY5OwNejXGCti8c/sMbBI3DLbAfqdLbchJJ98wq0+GhaVO4Vc9g
        jiqnXeU3CPu8UX5LoyM+87ezV4GglLk=
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com
 [209.85.166.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-316-Awvp1DZ6N0WUvnHk6adODQ-1; Mon, 13 Nov 2023 05:01:47 -0500
X-MC-Unique: Awvp1DZ6N0WUvnHk6adODQ-1
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-7a944114406so372918539f.2
        for <linux-kernel@vger.kernel.org>; Mon, 13 Nov 2023 02:01:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699869707; x=1700474507;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BAMalQgNM0C7HuKoU35TO9KZ8bUeH1IJgfZxeS8F7ZM=;
        b=oeLGbz6nxGmO21y1+PY8hrW3H6gpJeRiCFR8PqPxyQH/r877tHUEtopMLDnUUc7ONp
         FJXG5pY5oQrc7w5Fa8lfJIe9ibtD4iZK6yCyNvP7Xe3gcczpwXTAo8U/nmm1der2iKCv
         ioBQ3DHUt2uZffIiFKeErzro0Tab4XUZR1g56XgHl3f4Galf89H95Kkna+8mpA2dD3/Y
         YFlgcuzUyWapSxqgD4ckhUWQJX5brLWZe18I5Kx1mKKf62OQp0PAw9sZHm1K0P0Y5CfG
         +zc/Hpn3w1k+rZ6o/xxasI28igoEAQAHTqwmEWu861cZRTE8t+S5xEI2UXtScudD9w+f
         Zp6Q==
X-Gm-Message-State: AOJu0Yz3nHvN0L5cIpWpq2Hvc2m5VjRZK9WpACwMYWn+JIrmmLxuxIZy
        NEd/0y/PHvAr+Jwe7P8uVVpjsg44iqUL9WJ4HeQD25lND624l0+xtiV0lgKx2A/qs7avNdBRwS9
        zYWcBEOJfLcsslRpGi1IKVcCp
X-Received: by 2002:a05:6e02:1bc7:b0:359:56d2:aa19 with SMTP id x7-20020a056e021bc700b0035956d2aa19mr7258864ilv.6.1699869706815;
        Mon, 13 Nov 2023 02:01:46 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH7tmXC6qf2sfNPHtOUIMeBRO/dIRdXhrQyw4Al19wk8aveBy1a/L2HugzHzm+0XUXK3jdUog==
X-Received: by 2002:a05:6e02:1bc7:b0:359:56d2:aa19 with SMTP id x7-20020a056e021bc700b0035956d2aa19mr7258823ilv.6.1699869706458;
        Mon, 13 Nov 2023 02:01:46 -0800 (PST)
Received: from ?IPV6:2001:8003:e5b0:9f00:b890:3e54:96bb:2a15? ([2001:8003:e5b0:9f00:b890:3e54:96bb:2a15])
        by smtp.gmail.com with ESMTPSA id c9-20020a62e809000000b006c306943730sm3652442pfi.91.2023.11.13.02.01.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Nov 2023 02:01:46 -0800 (PST)
Message-ID: <29090279-a682-43ff-9710-181cb91bbf91@redhat.com>
Date:   Mon, 13 Nov 2023 20:01:27 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 05/22] ACPI: Move ACPI_HOTPLUG_CPU to be disabled on
 arm64 and riscv
Content-Language: en-US
To:     "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc:     linux-pm@vger.kernel.org, loongarch@lists.linux.dev,
        linux-acpi@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-riscv@lists.infradead.org, kvmarm@lists.linux.dev,
        x86@kernel.org, linux-csky@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-ia64@vger.kernel.org,
        linux-parisc@vger.kernel.org, Salil Mehta <salil.mehta@huawei.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        jianyong.wu@arm.com, justin.he@arm.com,
        James Morse <james.morse@arm.com>,
        Huacai Chen <chenhuacai@kernel.org>,
        WANG Xuerui <kernel@xen0n.name>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>
References: <ZUoRY33AAHMc5ThW@shell.armlinux.org.uk>
 <E1r0JL6-00CTws-3z@rmk-PC.armlinux.org.uk>
 <8e288692-7460-4aa4-86f3-500327256bc3@redhat.com>
 <ZVHkykFMp+CMUqyf@shell.armlinux.org.uk>
From:   Gavin Shan <gshan@redhat.com>
In-Reply-To: <ZVHkykFMp+CMUqyf@shell.armlinux.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 11/13/23 18:56, Russell King (Oracle) wrote:
> On Mon, Nov 13, 2023 at 10:29:39AM +1000, Gavin Shan wrote:
>> On 11/7/23 20:29, Russell King (Oracle) wrote:
>>> From: James Morse <james.morse@arm.com>
>>>
>>> Neither arm64 nor riscv support physical hotadd of CPUs that were not
>>> present at boot. For arm64 much of the platform description is in static
>>> tables which do not have update methods. arm64 does support HOTPLUG_CPU,
>>> which is backed by a firmware interface to turn CPUs on and off.
>>>
>>> acpi_processor_hotadd_init() and acpi_processor_remove() are for adding
>>> and removing CPUs that were not present at boot. arm64 systems that do this
>>> are not supported as there is currently insufficient information in the
>>> platform description. (e.g. did the GICR get removed too?)
>>>
>>> arm64 currently relies on the MADT enabled flag check in map_gicc_mpidr()
>>> to prevent CPUs that were not described as present at boot from being
>>> added to the system. Similarly, riscv relies on the same check in
>>> map_rintc_hartid(). Both architectures also rely on the weak 'always fails'
>>> definitions of acpi_map_cpu() and arch_register_cpu().
>>>
>>> Subsequent changes will redefine ACPI_HOTPLUG_CPU as making possible
>>> CPUs present. Neither arm64 nor riscv support this.
>>>
>>> Disable ACPI_HOTPLUG_CPU for arm64 and riscv by removing 'default y' and
>>> selecting it on the other three ACPI architectures. This allows the weak
>>> definitions of some symbols to be removed.
>>>
>>> Signed-off-by: James Morse <james.morse@arm.com>
>>> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
>>> ---
>>> Changes since RFC:
>>>    * Expanded conditions to avoid ACPI_HOTPLUG_CPU being enabled when
>>>      HOTPLUG_CPU isn't.
>>> Changes since RFC v3:
>>>    * Dropped ia64 changes
>>> ---
>>>    arch/loongarch/Kconfig        |  1 +
>>>    arch/x86/Kconfig              |  1 +
>>>    drivers/acpi/Kconfig          |  1 -
>>>    drivers/acpi/acpi_processor.c | 18 ------------------
>>>    4 files changed, 2 insertions(+), 19 deletions(-)
>>>
>>
>> With the following nits addressed:
>>
>> Reviewed-by: Gavin Shan <gshan@redhat.com>
>>
>>> diff --git a/arch/loongarch/Kconfig b/arch/loongarch/Kconfig
>>> index d889a0b97bc1..64620e90c12c 100644
>>> --- a/arch/loongarch/Kconfig
>>> +++ b/arch/loongarch/Kconfig
>>> @@ -5,6 +5,7 @@ config LOONGARCH
>>>    	select ACPI
>>>    	select ACPI_GENERIC_GSI if ACPI
>>>    	select ACPI_MCFG if ACPI
>>> +	select ACPI_HOTPLUG_CPU if ACPI_PROCESSOR && HOTPLUG_CPU
>>>    	select ACPI_PPTT if ACPI
>>>    	select ACPI_SYSTEM_POWER_STATES_SUPPORT	if ACPI
>>>    	select ARCH_BINFMT_ELF_STATE
>>> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
>>> index 3762f41bb092..dbdcfc708369 100644
>>> --- a/arch/x86/Kconfig
>>> +++ b/arch/x86/Kconfig
>>> @@ -59,6 +59,7 @@ config X86
>>>    	#
>>>    	select ACPI_LEGACY_TABLES_LOOKUP	if ACPI
>>>    	select ACPI_SYSTEM_POWER_STATES_SUPPORT	if ACPI
>>> +	select ACPI_HOTPLUG_CPU			if ACPI_PROCESSOR && HOTPLUG_CPU
>>>    	select ARCH_32BIT_OFF_T			if X86_32
>>>    	select ARCH_CLOCKSOURCE_INIT
>>>    	select ARCH_CORRECT_STACKTRACE_ON_KRETPROBE
>>> diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
>>> index f819e760ff19..a3acfc750fce 100644
>>> --- a/drivers/acpi/Kconfig
>>> +++ b/drivers/acpi/Kconfig
>>> @@ -310,7 +310,6 @@ config ACPI_HOTPLUG_CPU
>>>    	bool
>>>    	depends on ACPI_PROCESSOR && HOTPLUG_CPU
>>>    	select ACPI_CONTAINER
>>> -	default y
>>>    config ACPI_PROCESSOR_AGGREGATOR
>>>    	tristate "Processor Aggregator"
>>> diff --git a/drivers/acpi/acpi_processor.c b/drivers/acpi/acpi_processor.c
>>> index 0f5218e361df..4fe2ef54088c 100644
>>> --- a/drivers/acpi/acpi_processor.c
>>> +++ b/drivers/acpi/acpi_processor.c
>>> @@ -184,24 +184,6 @@ static void __init acpi_pcc_cpufreq_init(void) {}
>>>    /* Initialization */
>>>    #ifdef CONFIG_ACPI_HOTPLUG_CPU
>>> -int __weak acpi_map_cpu(acpi_handle handle,
>>> -		phys_cpuid_t physid, u32 acpi_id, int *pcpu)
>>> -{
>>> -	return -ENODEV;
>>> -}
>>> -
>>> -int __weak acpi_unmap_cpu(int cpu)
>>> -{
>>> -	return -ENODEV;
>>> -}
>>> -
>>> -int __weak arch_register_cpu(int cpu)
>>> -{
>>> -	return -ENODEV;
>>> -}
>>> -
>>> -void __weak arch_unregister_cpu(int cpu) {}
>>> -
>>
>> Since we're here, EXPORT_SYMBOL() can be dropped for these functions on
>> x86 and loongarch because they're not called from a module?
> 
> I'm confused, and don't understand your comment. You've r-b the
> previous two patches that remove the EXPORT_SYMBOL()s for
> arch_register_cpu() and arch_unregister_cpu() from x86 and loongarch.
> So it seems your comment is already addressed, and thus makes no
> sense.
> 
> Please clarify.
> 

Exactly, I must be looking into wrong code when reviewing this patch.
Please ignore my comments and my r-b still valid. Sorry for the
unnecessary confusion.

Thanks,
Gavin

