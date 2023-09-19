Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C44777A56B0
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 02:47:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229585AbjISAqu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 20:46:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbjISAqo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 20:46:44 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C503D10D
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 17:45:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1695084350;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LM15K8pzy7YjRbxMXPWyKscBPIcWYYmbRagei3+odA0=;
        b=O0q0H9DdO8u/Uss9z210rVZOi94Cq51I9fG4FwXSvwTxT4TIIYHBnKONKcf4DD/fzXGuo0
        WFTwdomtInS86oINylx60fNtxjzpCULwsGsK6geXE5b+AnwBCBKZyHTkm8inWnn+T0oXZ9
        rrpcu7B855Rp2I4lKJdCIn5aALBla1A=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-120-mrb1mdYVOySiKm6teRuPlA-1; Mon, 18 Sep 2023 20:45:48 -0400
X-MC-Unique: mrb1mdYVOySiKm6teRuPlA-1
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-574155a12d9so3048286a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 17:45:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695084347; x=1695689147;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LM15K8pzy7YjRbxMXPWyKscBPIcWYYmbRagei3+odA0=;
        b=IsamON4hSBdtTtQWJ2FE0waGsbp0gWywzlYwlUhQfStJHA3lmrsPQUUabarhot7VxR
         UfT4+Uqpx8shq2eT1RBw8YuAtQ3NbtXo6A6rJ5k2Y9zOdSaUJBTjTWQ9BXHqUJKgCgni
         hiM1w2l6e8S1QSeBo8cr10at3mrhDjmYKRsQ94n+8Yfj9rs/AxTV0X3L23gkH3vRHwod
         6vl/2+k2P0dJDmoufO8tjyrOVFSPX/KryZxa3Xrp4FWP+M7SdM5pcKNP/Xtod7dijou3
         3TFz04xkyjHXyIGf2Sbb27q3JfC+RsLnLibhpK++3wzm884LCSXiyQTZfbNWBFBjLHip
         PRug==
X-Gm-Message-State: AOJu0YyBnPnqqgUg3h3qoBHOg86kWvSsQxPqIEvHhr8dB7ULDqbMJAiO
        WU5OtZIQLwa4u5DM4f0jqv3mpd5losnYhAa5JSfzNaJeEOVF2TV4jhnOBMRcUqDNYcrM2bW/jSX
        Wb8cFibC6QmCrmmObLNoCXOjR
X-Received: by 2002:a05:6a20:e126:b0:12e:98a3:77b7 with SMTP id kr38-20020a056a20e12600b0012e98a377b7mr11802952pzb.59.1695084346999;
        Mon, 18 Sep 2023 17:45:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEbRMohfrQfu8U6nIU99dVCswPBycZA0RmEkJtJ+RPQwK7z3RIdFfhgC8+/M21E5Fme0WVGHQ==
X-Received: by 2002:a05:6a20:e126:b0:12e:98a3:77b7 with SMTP id kr38-20020a056a20e12600b0012e98a377b7mr11802939pzb.59.1695084346690;
        Mon, 18 Sep 2023 17:45:46 -0700 (PDT)
Received: from ?IPV6:2001:8003:e5b0:9f00:dbbc:1945:6e65:ec5? ([2001:8003:e5b0:9f00:dbbc:1945:6e65:ec5])
        by smtp.gmail.com with ESMTPSA id i7-20020a17090332c700b001b06c106844sm8833025plr.151.2023.09.18.17.45.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Sep 2023 17:45:45 -0700 (PDT)
Message-ID: <518859b1-64a9-d723-963c-56c7f6fc2da1@redhat.com>
Date:   Tue, 19 Sep 2023 10:45:39 +1000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [RFC PATCH v2 22/35] ACPI: Check _STA present bit before making
 CPUs not present
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
 <20230913163823.7880-23-james.morse@arm.com>
From:   Gavin Shan <gshan@redhat.com>
In-Reply-To: <20230913163823.7880-23-james.morse@arm.com>
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
> When called acpi_processor_post_eject() unconditionally make a CPU
> not-present and unregisters it.
> 
> To add support for AML events where the CPU has become disabled, but
> remains present, the _STA method should be checked before calling
> acpi_processor_remove().
> 
> Rename acpi_processor_post_eject() acpi_processor_remove_possible(), and
> check the _STA before calling.
> 
> Adding the function prototype for arch_unregister_cpu() allows the
> preprocessor guards to be removed.
> 
> After this change CPUs will remain registered and visible to
> user-space as offline if buggy firmware triggers an eject-request,
> but doesn't clear the corresponding _STA bits after _EJ0 has been
> called.
> 
> Signed-off-by: James Morse <james.morse@arm.com>
> ---
>   drivers/acpi/acpi_processor.c | 31 +++++++++++++++++++++++++------
>   include/linux/cpu.h           |  1 +
>   2 files changed, 26 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/acpi/acpi_processor.c b/drivers/acpi/acpi_processor.c
> index 00dcc23d49a8..2cafea1edc24 100644
> --- a/drivers/acpi/acpi_processor.c
> +++ b/drivers/acpi/acpi_processor.c
> @@ -457,13 +457,12 @@ static int acpi_processor_add(struct acpi_device *device,
>   	return result;
>   }
>   
> -#ifdef CONFIG_ACPI_HOTPLUG_PRESENT_CPU
>   /* Removal */
> -static void acpi_processor_post_eject(struct acpi_device *device)
> +static void acpi_processor_make_not_present(struct acpi_device *device)
>   {
>   	struct acpi_processor *pr;
>   
> -	if (!device || !acpi_driver_data(device))
> +	if (!IS_ENABLED(CONFIG_ACPI_HOTPLUG_PRESENT_CPU))
>   		return;
>   

In order to use IS_ENABLED(),

>   	pr = acpi_driver_data(device);
> @@ -501,7 +500,29 @@ static void acpi_processor_post_eject(struct acpi_device *device)
>   	free_cpumask_var(pr->throttling.shared_cpu_map);
>   	kfree(pr);
>   }
> -#endif /* CONFIG_ACPI_HOTPLUG_PRESENT_CPU */
> +
> +static void acpi_processor_post_eject(struct acpi_device *device)
> +{
> +	struct acpi_processor *pr;
> +	unsigned long long sta;
> +	acpi_status status;
> +
> +	if (!device)
> +		return;
> +
> +	pr = acpi_driver_data(device);
> +	if (!pr || pr->id >= nr_cpu_ids || invalid_phys_cpuid(pr->phys_id))
> +		return;
> +

Do we really need to validate the logic and hardware CPU IDs here? I think
the ACPI processor device can't be added successfully if one of them is
invalid.

> +	status = acpi_evaluate_integer(pr->handle, "_STA", NULL, &sta);
> +	if (ACPI_FAILURE(status))
> +		return;
> +
> +	if (cpu_present(pr->id) && !(sta & ACPI_STA_DEVICE_PRESENT)) {
> +		acpi_processor_make_not_present(device);
> +		return;
> +	}
> +}
>   
>   #ifdef CONFIG_ARCH_MIGHT_HAVE_ACPI_PDC
>   bool __init processor_physically_present(acpi_handle handle)
> @@ -626,9 +647,7 @@ static const struct acpi_device_id processor_device_ids[] = {
>   static struct acpi_scan_handler processor_handler = {
>   	.ids = processor_device_ids,
>   	.attach = acpi_processor_add,
> -#ifdef CONFIG_ACPI_HOTPLUG_PRESENT_CPU
>   	.post_eject = acpi_processor_post_eject,
> -#endif
>   	.hotplug = {
>   		.enabled = true,
>   	},
> diff --git a/include/linux/cpu.h b/include/linux/cpu.h
> index a71691d7c2ca..e117c06e0c6b 100644
> --- a/include/linux/cpu.h
> +++ b/include/linux/cpu.h
> @@ -81,6 +81,7 @@ struct device *cpu_device_create(struct device *parent, void *drvdata,
>   				 const struct attribute_group **groups,
>   				 const char *fmt, ...);
>   extern int arch_register_cpu(int cpu);
> +extern void arch_unregister_cpu(int cpu);

arch_unregister_cpu() is protected by CONFIG_HOTPLUG_CPU in the individual architectures,
for example arch/ia64/kernel/topology.c

>   #ifdef CONFIG_HOTPLUG_CPU
>   extern void unregister_cpu(struct cpu *cpu);
>   extern ssize_t arch_cpu_probe(const char *, size_t);

Thanks,
Gavin

