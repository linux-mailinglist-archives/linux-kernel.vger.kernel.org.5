Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B56337E6778
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 11:10:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232716AbjKIKKb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 05:10:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230055AbjKIKK3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 05:10:29 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83FAC2D6A
        for <linux-kernel@vger.kernel.org>; Thu,  9 Nov 2023 02:09:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1699524580;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=f66C/Uco7Rn4beNRod/QtpM+fKeOVkNE1m9/M9ZsY14=;
        b=XY0jEFNIKPzoHUHhMSwhB8sXqU6m5Y49AnlMsK6EU6Xjrk6b75F5a11XVZE2gmxf6nMx9x
        Dm4FzxhvV1rFYpaU6N/0oE0bk9KIwK7XF5vgm9Lp43cVChuRaqrWeekC/QDJQx8zotC3RL
        0BIM2WE2wFeuOuM2C6gMvl7LJpK4ylg=
Received: from mail-oa1-f70.google.com (mail-oa1-f70.google.com
 [209.85.160.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-638-YNgrfNEbMli1Pi-U8B-ZGQ-1; Thu, 09 Nov 2023 05:09:39 -0500
X-MC-Unique: YNgrfNEbMli1Pi-U8B-ZGQ-1
Received: by mail-oa1-f70.google.com with SMTP id 586e51a60fabf-1efb58aa320so161380fac.1
        for <linux-kernel@vger.kernel.org>; Thu, 09 Nov 2023 02:09:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699524578; x=1700129378;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=f66C/Uco7Rn4beNRod/QtpM+fKeOVkNE1m9/M9ZsY14=;
        b=YeJpefzab6YUYS0QuFqZUjxYZ28H2Rt5bhUKnrxbvrRnNr0E/jgOLZEUKV/iXT210O
         rZgOwtMdRr5gzUAUe7YT7s75tj7AjzLqSkCQIKZ1/z5mk4VIAVrAvvYexH3c/0hIKp5p
         eE2ciN2buo0c/UadHuVmfiUpKEe10bHn/JBz9fGrxzTNp6ibvBbtrA4+VSEjBE1ty9pq
         SdZdVSjzIbsQb60XD3BcIYaMvXaSeNPEVuCfs1k2OCCJc/IPHEu8dRjl8mA+zFy3Xmnz
         jzlfTVjw3Es9AHAtWpW/7xzzb0oiZCTO6Cb8PeC0Ktbadc+eHRolOaFHo+YfGNJ1d5/h
         5+lQ==
X-Gm-Message-State: AOJu0Ywi7E9A5fhhdd3HhMm/1NyJFzRxKmza2X6h+UyrfRaMx4qQQ0O9
        1N/CScDUWMIPqlzgBoyvRdZKlnBEpc1F6rgH2XV3bF/ape8HKVq2c6jNMmSqcsQ/tIhjYJAHANX
        Lj3tMInHkf+XWuL7heYAHx6qg
X-Received: by 2002:a05:6871:a113:b0:1e9:e8fd:bb77 with SMTP id vs19-20020a056871a11300b001e9e8fdbb77mr5119492oab.0.1699524578738;
        Thu, 09 Nov 2023 02:09:38 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGuc2Fsk1aOG+26g+R1TKcXCB5LvcN3abO9ejRxfqdYaGILXhVW+FjXlWbJavq6vyZSTQA5Iw==
X-Received: by 2002:a05:6871:a113:b0:1e9:e8fd:bb77 with SMTP id vs19-20020a056871a11300b001e9e8fdbb77mr5119472oab.0.1699524578430;
        Thu, 09 Nov 2023 02:09:38 -0800 (PST)
Received: from [10.66.61.39] ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id q18-20020a62ae12000000b006bae6eea9d0sm10335148pff.49.2023.11.09.02.09.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Nov 2023 02:09:38 -0800 (PST)
Message-ID: <f00dd1cf-5b4c-38a8-a337-817d474d53d1@redhat.com>
Date:   Thu, 9 Nov 2023 18:09:32 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH RFC 06/22] drivers: base: Use present CPUs in
 GENERIC_CPU_DEVICES
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
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>, Guo Ren <guoren@kernel.org>
References: <ZUoRY33AAHMc5ThW@shell.armlinux.org.uk>
 <E1r0JLB-00CTwy-7y@rmk-PC.armlinux.org.uk>
From:   Shaoqin Huang <shahuang@redhat.com>
In-Reply-To: <E1r0JLB-00CTwy-7y@rmk-PC.armlinux.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Russell,

On 11/7/23 18:29, Russell King (Oracle) wrote:
> From: James Morse <james.morse@arm.com>
> 
> Three of the five ACPI architectures create sysfs entries using
> register_cpu() for present CPUs, whereas arm64, riscv and all
> GENERIC_CPU_DEVICES do this for possible CPUs.
> 
> Registering a CPU is what causes them to show up in sysfs.
> 
> It makes very little sense to register all possible CPUs. Registering
> a CPU is what triggers the udev notifications allowing user-space to
> react to newly added CPUs.
> 
> To allow all five ACPI architectures to use GENERIC_CPU_DEVICES, change
> it to use for_each_present_cpu(). Making the ACPI architectures use
> GENERIC_CPU_DEVICES is a pre-requisite step to centralise their
> cpu_register() logic, before moving it into the ACPI processor driver.
> When ACPI is disabled this work would be done by
> cpu_dev_register_generic().

What do you actually mean about when ACPI is disabled this work would be 
done by cpu_dev_register_generic()? Is the work means register the cpu?

I'm not quite understand that, and how about when ACPI is enabled, which 
function do this work?

> 
> Of the ACPI architectures that register possible CPUs, arm64 and riscv
> do not support making possible CPUs present as they use the weak 'always
> fails' version of arch_register_cpu().
> 
> Only two of the eight architectures that use GENERIC_CPU_DEVICES have a
> distinction between present and possible CPUs.
> 
> The following architectures use GENERIC_CPU_DEVICES but are not SMP,
> so possible == present:
>   * m68k
>   * microblaze
>   * nios2
> 
> The following architectures use GENERIC_CPU_DEVICES and consider
> possible == present:
>   * csky: setup_smp()
>   * processor_probe() sets possible for all CPUs and present for all CPUs
>     except the boot cpu, which will have been done by
>     init/main.c::start_kernel().
> 
> um appears to be a subarchitecture of x86.
> 
> The remaining architecture using GENERIC_CPU_DEVICES are:
>   * openrisc and hexagon:
>     where smp_init_cpus() makes all CPUs < NR_CPUS possible,
>     whereas smp_prepare_cpus() only makes CPUs < setup_max_cpus present.
> 
> After this change, openrisc and hexagon systems that use the max_cpus
> command line argument would not see the other CPUs present in sysfs.
> This should not be a problem as these CPUs can't bre brought online as
                                              ^ nit: can't be
> _cpu_up() checks cpu_present().
> 
> After this change, only CPUs which are present appear in sysfs.
> 
> Signed-off-by: James Morse <james.morse@arm.com>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Thanks,
Shaoqin

> ---
>   drivers/base/cpu.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/base/cpu.c b/drivers/base/cpu.c
> index 9ea22e165acd..34b48f660b6b 100644
> --- a/drivers/base/cpu.c
> +++ b/drivers/base/cpu.c
> @@ -533,7 +533,7 @@ static void __init cpu_dev_register_generic(void)
>   #ifdef CONFIG_GENERIC_CPU_DEVICES
>   	int i;
>   
> -	for_each_possible_cpu(i) {
> +	for_each_present_cpu(i) {
>   		if (register_cpu(&per_cpu(cpu_devices, i), i))
>   			panic("Failed to register CPU device");
>   	}

