Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8384F7E9395
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Nov 2023 01:31:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232476AbjKMAaq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Nov 2023 19:30:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230394AbjKMAao (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Nov 2023 19:30:44 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 931C01FF7
        for <linux-kernel@vger.kernel.org>; Sun, 12 Nov 2023 16:29:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1699835393;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=N8MbV+ldUGJXtFXnad6b8yZArDRg/WTGKo84KPGxrMw=;
        b=OnUnWxgNzvhAbmReTtDLNiqz5O263sgsHcUy+Zt4sBkbr3DlR5TUsP/dt1SBhIb6sBdS4P
        qDcSKrGqfrJPiH9mcwhfBtqFo4IDLv0qp1JJQEObBltLbVxxv0JwyJxU69BQdc5MFnug2H
        HQ8/hiWGPwE5evo0/4MveNKe8W5TJmk=
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-256-IuDGtvdUNnyVBmhi6jjw7Q-1; Sun, 12 Nov 2023 19:29:52 -0500
X-MC-Unique: IuDGtvdUNnyVBmhi6jjw7Q-1
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-692c0c3bcc5so3632408b3a.3
        for <linux-kernel@vger.kernel.org>; Sun, 12 Nov 2023 16:29:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699835391; x=1700440191;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=N8MbV+ldUGJXtFXnad6b8yZArDRg/WTGKo84KPGxrMw=;
        b=jr3nKDzh4PGs4djACoHwY0+oRICBSdPF6o5QZSsaMu19XfkubDBzx2DSUqKq9qeI3C
         SizuxgbbQn5sWUhpmKwpOqoIAODGFqsbCzbkfMWlrs9Hd33rrfircONIVPLYlfj5CMft
         XmfzG4EH+oVyB3kvSoqlUCtNYedQRV/ZAlpAIAeOBpIRnqk4SbkGh+nNvCjI+NtMmQtf
         nfnmJoAgpwHjW8LelAwWa3/zNITJktcnXovN4R5xj0F7624dsVc7FUoowvl0eyevO+PN
         6DV6mLCpKY7p9ZnXBywekU/Z9I+GN6Cq+yqpdyn+L5Cyz8e2dMEYWgcXKu+szq5d7/+1
         jRuA==
X-Gm-Message-State: AOJu0YyyWysu0SHNXU4JA8q+RXPXS5JWfpJR+McZkTatUTM+rZYhTPuF
        5N1XkGW4Vrj5Ms/42vkqHYEyphsWhUEaLg1o+iGtbZZSM0JtB3AbkcRVvPdGY3A7ABfYmw8Ai7b
        VQHLkOHEkLvxUVK1z3mqwXz5r
X-Received: by 2002:a05:6a20:430b:b0:186:bb41:180 with SMTP id h11-20020a056a20430b00b00186bb410180mr63925pzk.33.1699835390959;
        Sun, 12 Nov 2023 16:29:50 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFfd4yfzq0YXl5QdnKYzie2VCc6U5S9RTqxoEsGgDflqzH9st3ur7RFmEwEZUtvxIYzQtb9pw==
X-Received: by 2002:a05:6a20:430b:b0:186:bb41:180 with SMTP id h11-20020a056a20430b00b00186bb410180mr63892pzk.33.1699835390683;
        Sun, 12 Nov 2023 16:29:50 -0800 (PST)
Received: from ?IPV6:2001:8003:e5b0:9f00:b890:3e54:96bb:2a15? ([2001:8003:e5b0:9f00:b890:3e54:96bb:2a15])
        by smtp.gmail.com with ESMTPSA id u18-20020a170902e5d200b001c62d63b817sm3035620plf.179.2023.11.12.16.29.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 12 Nov 2023 16:29:50 -0800 (PST)
Message-ID: <8e288692-7460-4aa4-86f3-500327256bc3@redhat.com>
Date:   Mon, 13 Nov 2023 10:29:39 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 05/22] ACPI: Move ACPI_HOTPLUG_CPU to be disabled on
 arm64 and riscv
Content-Language: en-US
To:     "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
        linux-pm@vger.kernel.org, loongarch@lists.linux.dev,
        linux-acpi@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-riscv@lists.infradead.org, kvmarm@lists.linux.dev,
        x86@kernel.org, linux-csky@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-ia64@vger.kernel.org,
        linux-parisc@vger.kernel.org
Cc:     Salil Mehta <salil.mehta@huawei.com>,
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
From:   Gavin Shan <gshan@redhat.com>
In-Reply-To: <E1r0JL6-00CTws-3z@rmk-PC.armlinux.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/7/23 20:29, Russell King (Oracle) wrote:
> From: James Morse <james.morse@arm.com>
> 
> Neither arm64 nor riscv support physical hotadd of CPUs that were not
> present at boot. For arm64 much of the platform description is in static
> tables which do not have update methods. arm64 does support HOTPLUG_CPU,
> which is backed by a firmware interface to turn CPUs on and off.
> 
> acpi_processor_hotadd_init() and acpi_processor_remove() are for adding
> and removing CPUs that were not present at boot. arm64 systems that do this
> are not supported as there is currently insufficient information in the
> platform description. (e.g. did the GICR get removed too?)
> 
> arm64 currently relies on the MADT enabled flag check in map_gicc_mpidr()
> to prevent CPUs that were not described as present at boot from being
> added to the system. Similarly, riscv relies on the same check in
> map_rintc_hartid(). Both architectures also rely on the weak 'always fails'
> definitions of acpi_map_cpu() and arch_register_cpu().
> 
> Subsequent changes will redefine ACPI_HOTPLUG_CPU as making possible
> CPUs present. Neither arm64 nor riscv support this.
> 
> Disable ACPI_HOTPLUG_CPU for arm64 and riscv by removing 'default y' and
> selecting it on the other three ACPI architectures. This allows the weak
> definitions of some symbols to be removed.
> 
> Signed-off-by: James Morse <james.morse@arm.com>
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> ---
> Changes since RFC:
>   * Expanded conditions to avoid ACPI_HOTPLUG_CPU being enabled when
>     HOTPLUG_CPU isn't.
> Changes since RFC v3:
>   * Dropped ia64 changes
> ---
>   arch/loongarch/Kconfig        |  1 +
>   arch/x86/Kconfig              |  1 +
>   drivers/acpi/Kconfig          |  1 -
>   drivers/acpi/acpi_processor.c | 18 ------------------
>   4 files changed, 2 insertions(+), 19 deletions(-)
> 

With the following nits addressed:

Reviewed-by: Gavin Shan <gshan@redhat.com>

> diff --git a/arch/loongarch/Kconfig b/arch/loongarch/Kconfig
> index d889a0b97bc1..64620e90c12c 100644
> --- a/arch/loongarch/Kconfig
> +++ b/arch/loongarch/Kconfig
> @@ -5,6 +5,7 @@ config LOONGARCH
>   	select ACPI
>   	select ACPI_GENERIC_GSI if ACPI
>   	select ACPI_MCFG if ACPI
> +	select ACPI_HOTPLUG_CPU if ACPI_PROCESSOR && HOTPLUG_CPU
>   	select ACPI_PPTT if ACPI
>   	select ACPI_SYSTEM_POWER_STATES_SUPPORT	if ACPI
>   	select ARCH_BINFMT_ELF_STATE
> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> index 3762f41bb092..dbdcfc708369 100644
> --- a/arch/x86/Kconfig
> +++ b/arch/x86/Kconfig
> @@ -59,6 +59,7 @@ config X86
>   	#
>   	select ACPI_LEGACY_TABLES_LOOKUP	if ACPI
>   	select ACPI_SYSTEM_POWER_STATES_SUPPORT	if ACPI
> +	select ACPI_HOTPLUG_CPU			if ACPI_PROCESSOR && HOTPLUG_CPU
>   	select ARCH_32BIT_OFF_T			if X86_32
>   	select ARCH_CLOCKSOURCE_INIT
>   	select ARCH_CORRECT_STACKTRACE_ON_KRETPROBE
> diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
> index f819e760ff19..a3acfc750fce 100644
> --- a/drivers/acpi/Kconfig
> +++ b/drivers/acpi/Kconfig
> @@ -310,7 +310,6 @@ config ACPI_HOTPLUG_CPU
>   	bool
>   	depends on ACPI_PROCESSOR && HOTPLUG_CPU
>   	select ACPI_CONTAINER
> -	default y
>   
>   config ACPI_PROCESSOR_AGGREGATOR
>   	tristate "Processor Aggregator"
> diff --git a/drivers/acpi/acpi_processor.c b/drivers/acpi/acpi_processor.c
> index 0f5218e361df..4fe2ef54088c 100644
> --- a/drivers/acpi/acpi_processor.c
> +++ b/drivers/acpi/acpi_processor.c
> @@ -184,24 +184,6 @@ static void __init acpi_pcc_cpufreq_init(void) {}
>   
>   /* Initialization */
>   #ifdef CONFIG_ACPI_HOTPLUG_CPU
> -int __weak acpi_map_cpu(acpi_handle handle,
> -		phys_cpuid_t physid, u32 acpi_id, int *pcpu)
> -{
> -	return -ENODEV;
> -}
> -
> -int __weak acpi_unmap_cpu(int cpu)
> -{
> -	return -ENODEV;
> -}
> -
> -int __weak arch_register_cpu(int cpu)
> -{
> -	return -ENODEV;
> -}
> -
> -void __weak arch_unregister_cpu(int cpu) {}
> -

Since we're here, EXPORT_SYMBOL() can be dropped for these functions on
x86 and loongarch because they're not called from a module?

>   static int acpi_processor_hotadd_init(struct acpi_processor *pr)
>   {
>   	unsigned long long sta;

Thanks,
Gavin

