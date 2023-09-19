Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 619877A56C9
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 03:00:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230334AbjISBA0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 21:00:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229708AbjISBAX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 21:00:23 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 336AE10E
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 17:59:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1695085173;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bw0RCNykMdY7RZsWbJdeZUErCRZgRpcPnJGa7EHVzz4=;
        b=Bue/mVDEQh5rS75zAHcFn62FGRisryxKB+eFsVOY5DHkB5Rn90Qrhg6T3qfHPQWrBJ+0/6
        nwMHdLyucp5Gf99kgIG7tmXbWhYaEsNkYhtY/cUc2IBB17g8PXM2BTVi0wrgNJLiFH6Ne5
        TFDnDSq4Dr/qnf6dvkvFyQUqePS9dYU=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-516-3WU25-1RMa6LVDCJ9oDVOA-1; Mon, 18 Sep 2023 20:59:32 -0400
X-MC-Unique: 3WU25-1RMa6LVDCJ9oDVOA-1
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-274b736cae3so1777497a91.1
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 17:59:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695085171; x=1695689971;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bw0RCNykMdY7RZsWbJdeZUErCRZgRpcPnJGa7EHVzz4=;
        b=jGTspPKD34vF9hQX0gY0waRu8FnZS9FzDr3/aPsXZ4T4CJy7ymi9mgs/KgZhba+AMN
         0TJrrE+YaalSUV/UexEyq9t8X0zVEvE3i7265ij92tohkPUUYfYJgR5RqWoZARMm8xOx
         hy6bvnujbB50Rbk+ga00cMJ9V+JHZRXcEc1fNSGiZN4HZV0BIu9PKw2oGwXr4xxDCqcd
         uHuYbc9TyrNaHRC0CL3eEH6ZTwwpk/HfbFkH5OqiYeut1uZh3UFpCNmF/GM3aNm3MIi+
         EK+jqRJl3UPCGOdgQE/OWzGny2nhExZklrU73c2LXvJVPMn/DnxT4IQ2dGfpMoPyrXQC
         mviA==
X-Gm-Message-State: AOJu0YyZLvmwza9sRpcyDYwgebx+SPF/TfBNUUFONr+USSS1uSmWt+Gc
        RGrBtkr74E0WwTultt2uYFgQM5aupvk/AI3NqCrbaiETw67XlDZlqKU/lsr8AtDCpza/c/KdRts
        /mE0TADRr0iqHnoKQ2R68daQ+
X-Received: by 2002:a17:903:187:b0:1c1:eb8b:79a6 with SMTP id z7-20020a170903018700b001c1eb8b79a6mr9666415plg.24.1695085170967;
        Mon, 18 Sep 2023 17:59:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE7eI2cxEHhh6ECmh24LHvZfT00fTv4NRQgrtlQ6ac1SnBZhOS9meGvuMTt0rEbyYbfdT98tw==
X-Received: by 2002:a17:903:187:b0:1c1:eb8b:79a6 with SMTP id z7-20020a170903018700b001c1eb8b79a6mr9666399plg.24.1695085170570;
        Mon, 18 Sep 2023 17:59:30 -0700 (PDT)
Received: from ?IPV6:2001:8003:e5b0:9f00:dbbc:1945:6e65:ec5? ([2001:8003:e5b0:9f00:dbbc:1945:6e65:ec5])
        by smtp.gmail.com with ESMTPSA id kg14-20020a170903060e00b001c41e1e9ca7sm8040575plb.215.2023.09.18.17.59.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Sep 2023 17:59:30 -0700 (PDT)
Message-ID: <8be3a9dc-8f59-9ef9-3662-95814e177125@redhat.com>
Date:   Tue, 19 Sep 2023 10:59:23 +1000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [RFC PATCH v2 24/35] drivers: base: Implement weak
 arch_unregister_cpu()
Content-Language: en-US
To:     James Morse <james.morse@arm.com>, linux-pm@vger.kernel.org,
        loongarch@lists.linux.dev, linux-acpi@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-riscv@lists.infradead.org, kvmarm@lists.linux.dev
Cc:     x86@kernel.org, Salil Mehta <salil.mehta@huawei.com>,
        Russell King <linux@armlinux.org.uk>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        jianyong.wu@arm.com, justin.he@arm.com
References: <20230913163823.7880-1-james.morse@arm.com>
 <20230913163823.7880-25-james.morse@arm.com>
From:   Gavin Shan <gshan@redhat.com>
In-Reply-To: <20230913163823.7880-25-james.morse@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/14/23 02:38, James Morse wrote:
> Add arch_unregister_cpu() to allow the ACPI machinery to call
> unregister_cpu(). This is enough for arm64, riscv and loongarch, but
> needs to be overridden by x86 and ia64 who need to do more work.
> 
> CC: Jean-Philippe Brucker <jean-philippe@linaro.org>
> Signed-off-by: James Morse <james.morse@arm.com>
> ---
> Changes since v1:
>   * Added CONFIG_HOTPLUG_CPU ifdeffery around unregister_cpu
> ---
>   arch/ia64/include/asm/cpu.h      | 4 ----
>   arch/loongarch/include/asm/cpu.h | 6 ------
>   arch/x86/include/asm/cpu.h       | 1 -
>   drivers/base/cpu.c               | 9 ++++++++-
>   4 files changed, 8 insertions(+), 12 deletions(-)
> 

I agree with Jonathan this patch needs to come early. Maybe move this
before the following one:

[RFC PATCH v2 19/35] ACPI: Move acpi_bus_trim_one() before acpi_scan_hot_remove()

> diff --git a/arch/ia64/include/asm/cpu.h b/arch/ia64/include/asm/cpu.h
> index a3e690e685e5..642d71675ddb 100644
> --- a/arch/ia64/include/asm/cpu.h
> +++ b/arch/ia64/include/asm/cpu.h
> @@ -15,8 +15,4 @@ DECLARE_PER_CPU(struct ia64_cpu, cpu_devices);
>   
>   DECLARE_PER_CPU(int, cpu_state);
>   
> -#ifdef CONFIG_HOTPLUG_CPU
> -extern void arch_unregister_cpu(int);
> -#endif
> -
>   #endif /* _ASM_IA64_CPU_H_ */
> diff --git a/arch/loongarch/include/asm/cpu.h b/arch/loongarch/include/asm/cpu.h
> index b8568e637420..48b9f7168bcc 100644
> --- a/arch/loongarch/include/asm/cpu.h
> +++ b/arch/loongarch/include/asm/cpu.h
> @@ -128,10 +128,4 @@ enum cpu_type_enum {
>   #define LOONGARCH_CPU_HYPERVISOR	BIT_ULL(CPU_FEATURE_HYPERVISOR)
>   #define LOONGARCH_CPU_PTW		BIT_ULL(CPU_FEATURE_PTW)
>   
> -#if !defined(__ASSEMBLY__)
> -#ifdef CONFIG_HOTPLUG_CPU
> -void arch_unregister_cpu(int cpu);
> -#endif
> -#endif /* ! __ASSEMBLY__ */
> -
>   #endif /* _ASM_CPU_H */
> diff --git a/arch/x86/include/asm/cpu.h b/arch/x86/include/asm/cpu.h
> index f349c94510e8..91867a6a9f8e 100644
> --- a/arch/x86/include/asm/cpu.h
> +++ b/arch/x86/include/asm/cpu.h
> @@ -24,7 +24,6 @@ static inline void prefill_possible_map(void) {}
>   #endif /* CONFIG_SMP */
>   
>   #ifdef CONFIG_HOTPLUG_CPU
> -extern void arch_unregister_cpu(int);
>   extern void soft_restart_cpu(void);
>   #endif
>   
> diff --git a/drivers/base/cpu.c b/drivers/base/cpu.c
> index 677f963e02ce..c709747c4a18 100644
> --- a/drivers/base/cpu.c
> +++ b/drivers/base/cpu.c
> @@ -531,7 +531,14 @@ int __weak arch_register_cpu(int cpu)
>   {
>   	return register_cpu(&per_cpu(cpu_devices, cpu), cpu);
>   }
> -#endif
> +
> +#ifdef CONFIG_HOTPLUG_CPU
> +void __weak arch_unregister_cpu(int num)
> +{
> +	unregister_cpu(&per_cpu(cpu_devices, num));
> +}
> +#endif /* CONFIG_HOTPLUG_CPU */
> +#endif /* CONFIG_GENERIC_CPU_DEVICES */
>   

It seems conflicting with its declaration in include/linux/cpu.h. Besides,
the function is still needed by drivers/acpi/acpi_processor.c::acpi_processor_make_not_present()
even both CONFIG_HOTPLUG_CPU and CONFIG_GENERIC_CPU_DEVICES are disabled?

>   static void __init cpu_dev_register_generic(void)
>   {

Thanks,
Gavin

