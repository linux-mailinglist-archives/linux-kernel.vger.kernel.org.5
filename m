Return-Path: <linux-kernel+bounces-159766-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34F7A8B33B2
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 11:15:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6D545B21C35
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 09:15:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4429B13E3F5;
	Fri, 26 Apr 2024 09:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Zt3Jbq04"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 098A913DB90
	for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 09:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714122933; cv=none; b=SIZwu2wKrm+Ym8wJ8JnL528AMh8V+1x2A+T3IS11269t2AtFj0mnho7xAuybOyJfrre2ciO/lqrYU6BSjEN3I5VRXQx2lvZ/3qC2RjPjDAZ5Gw/ZiAX12g3ol0w6WcmKwHwaBfMMbeY2E+1eG25UsWcRoT+6QkV3JPD0l98L1b0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714122933; c=relaxed/simple;
	bh=+FjPzM84B6BX9czEfRXFDbCKq4ptfl8l7j3daLkKm1k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AbXfjDj9DSUO126BzMPdfvcmoWztde9ZDp8UfkVZK2fx9+lImcAbDO63+Qh7LYiUazG9NUv8lvYCLk7eqDCN+fiFl3Himw3OrC+1C2fsjXYaGe5S2t4uwB4bsFt4L7msZnZD8guNWif9l7mF3pxt1+EFLi3IHEnrqlZCohK3Obw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Zt3Jbq04; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714122930;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1jkzt/L+mhv/WzsExsbPIs4x3qKy+eN4N2XWavPkUaM=;
	b=Zt3Jbq04CN6cjSq6IiIQpokjtDtREgT0DkTtXp+KWopoKX3HtoN17dDtONJPnYMmA/RCL+
	mUKgRHqNHAE6REKmtq8vy2ZS2FD/HwtZYgSsBkjWL2B3RO78/HxvUnOndielRi5Hvu77HL
	ZOQIFar/OOMi2WeoP8VlDDKadh7N2K8=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-637-UkpT2mAMPW6ixhv1BOgt4g-1; Fri, 26 Apr 2024 05:15:28 -0400
X-MC-Unique: UkpT2mAMPW6ixhv1BOgt4g-1
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-5f80a77b95cso2172644a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 02:15:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714122927; x=1714727727;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1jkzt/L+mhv/WzsExsbPIs4x3qKy+eN4N2XWavPkUaM=;
        b=qfFonaZY8p+08bqpOtIV8UxDHU2TtsTOXfs9LPg2aQs/cgic37Z0WZ6tQcUhK6VTH2
         eoEFvY+oz03K+1unQo06iBWcuGXOQhagXXVE1DAlt9SwyPidfnLk+KMK0QHsmlQeff2S
         Et4TFymO5Hix/Hq0WATLRO23mXxKNK8afGbM0uL4Ll29/iP9I1T3gOo4EQBZ2H0pzTBS
         JYsXedi7akyObjgRtIAqF0ODh9/BcP8Yrp3iXJGO1Mw5dwfn7u4AGjTb7Sc72h/5lQRQ
         tQ9sA9rI7JbRrnhsUpb3D9WIVObbd8FWw9fg6iBmBf7hKfe/tmoeWyRgKM6enfwScQ/+
         1Yiw==
X-Forwarded-Encrypted: i=1; AJvYcCVU54Rsc7uWReSjZLDGq6NvCIQOkWMcP4riIXsdmCEUV3tg1eZ6JtQll15XtFS2/H7QDc62iZOhmfjyniYNWAw6yefVg53WY02Uul10
X-Gm-Message-State: AOJu0YwBbuAOAnMyx9rSIAi4wWh+f2R7FaKY0pvxdMcc7od4QFqg5+JN
	sbXlZENcaoZeUJuhItEMmVjgDbJEeAq0D0Dtwy2pj2g/SFDbqVEaoqlnQDdpznFqe8AzzmXb+hJ
	6570SnvoNhGzszz6hLA8RrkRlthxBqrpovgwP10lIs7rw7LK1vqLn/hvn3wl9TA==
X-Received: by 2002:a05:6a20:2713:b0:1a7:5425:3044 with SMTP id u19-20020a056a20271300b001a754253044mr2110978pze.62.1714122927165;
        Fri, 26 Apr 2024 02:15:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGR4IonyI1PkhIL/Wl3B+SXVRCjKsdBxoyZhUJEblO74o+J0ratyZ96kbZ9Bo6ePHW9Uj0s2w==
X-Received: by 2002:a05:6a20:2713:b0:1a7:5425:3044 with SMTP id u19-20020a056a20271300b001a754253044mr2110962pze.62.1714122926856;
        Fri, 26 Apr 2024 02:15:26 -0700 (PDT)
Received: from [192.168.68.50] ([43.252.112.88])
        by smtp.gmail.com with ESMTPSA id bm5-20020a056a00320500b006ecf3e302ffsm14955063pfb.174.2024.04.26.02.15.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Apr 2024 02:15:26 -0700 (PDT)
Message-ID: <4d4f1a85-7aad-4ea1-aaed-1bb744d3ef99@redhat.com>
Date: Fri, 26 Apr 2024 19:15:16 +1000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 05/16] ACPI: processor: Add acpi_get_processor_handle()
 helper
Content-Language: en-US
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Thomas Gleixner <tglx@linutronix.de>, Peter Zijlstra <peterz@infradead.org>,
 linux-pm@vger.kernel.org, loongarch@lists.linux.dev,
 linux-acpi@vger.kernel.org, linux-arch@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 kvmarm@lists.linux.dev, x86@kernel.org, Russell King
 <linux@armlinux.org.uk>, "Rafael J . Wysocki" <rafael@kernel.org>,
 Miguel Luis <miguel.luis@oracle.com>, James Morse <james.morse@arm.com>,
 Salil Mehta <salil.mehta@huawei.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>
Cc: Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>, linuxarm@huawei.com,
 justin.he@arm.com, jianyong.wu@arm.com
References: <20240418135412.14730-1-Jonathan.Cameron@huawei.com>
 <20240418135412.14730-6-Jonathan.Cameron@huawei.com>
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <20240418135412.14730-6-Jonathan.Cameron@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/18/24 23:54, Jonathan Cameron wrote:
> If CONFIG_ACPI_PROCESSOR provide a helper to retrieve the
> acpi_handle for a given CPU allowing access to methods
> in DSDT.
> 
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
> v7: No change
> v6: New patch
> ---
>   drivers/acpi/acpi_processor.c | 10 ++++++++++
>   include/linux/acpi.h          |  7 +++++++
>   2 files changed, 17 insertions(+)
> 
> diff --git a/drivers/acpi/acpi_processor.c b/drivers/acpi/acpi_processor.c
> index ac7ddb30f10e..127ae8dcb787 100644
> --- a/drivers/acpi/acpi_processor.c
> +++ b/drivers/acpi/acpi_processor.c
> @@ -35,6 +35,16 @@ EXPORT_PER_CPU_SYMBOL(processors);
>   struct acpi_processor_errata errata __read_mostly;
>   EXPORT_SYMBOL_GPL(errata);
>   
> +acpi_handle acpi_get_processor_handle(int cpu)
> +{
> +	acpi_handle handle = NULL;
> +	struct acpi_processor *pr = per_cpu(processors, cpu);;
                                                             ^^

                                                             s/;;/;

> +
> +	if (pr)
> +		handle = pr->handle;
> +
> +	return handle;
> +}
>   static int acpi_processor_errata_piix4(struct pci_dev *dev)
>   {
>   	u8 value1 = 0;
> diff --git a/include/linux/acpi.h b/include/linux/acpi.h
> index 34829f2c517a..9844a3f9c4e5 100644
> --- a/include/linux/acpi.h
> +++ b/include/linux/acpi.h
> @@ -309,6 +309,8 @@ int acpi_map_cpu(acpi_handle handle, phys_cpuid_t physid, u32 acpi_id,
>   int acpi_unmap_cpu(int cpu);
>   #endif /* CONFIG_ACPI_HOTPLUG_CPU */
>   
> +acpi_handle acpi_get_processor_handle(int cpu);
> +
>   #ifdef CONFIG_ACPI_HOTPLUG_IOAPIC
>   int acpi_get_ioapic_id(acpi_handle handle, u32 gsi_base, u64 *phys_addr);
>   #endif
> @@ -1077,6 +1079,11 @@ static inline bool acpi_sleep_state_supported(u8 sleep_state)
>   	return false;
>   }
>   
> +static inline acpi_handle acpi_get_processor_handle(int cpu)
> +{
> +	return NULL;
> +}
> +
>   #endif	/* !CONFIG_ACPI */
>   
>   extern void arch_post_acpi_subsys_init(void);

Thanks,
Gavin


