Return-Path: <linux-kernel+bounces-163321-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 262A88B696F
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 06:26:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D157E283CE8
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 04:26:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 239EE14A9D;
	Tue, 30 Apr 2024 04:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JosyabYK"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2EBD12E47
	for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 04:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714451185; cv=none; b=NJ3d9gY7FBpcamOHihEGPQZNDd5aG1+WhGryjoybDwhbGfMjGlj2oqcdl8m+vXbqMZNrjI94ytQkWEOrt04LTcLC/Nx336/2kKRABY6v1i9sgA+kMwllrJFO2+9mMTwv81AxWQNxY6vIl8ZOEvDJdoJ3sUgLKCJPJMFyjjhM30o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714451185; c=relaxed/simple;
	bh=7/LvDV66mDIzCX8Ki3ehENh2BWy+/8sMXmXZYQ9n3Gw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=otdMrf+o1aszHMBOSPB2uIaFWjoEmCIXmBcXBU3WYYt4Alm1vEyI1+V5/DEfOD0ySmgbwBBha8iscxgAIWV4M2rq1ED3jPAjiv3GGhbDLW9J3jeIiBoOfugBMm+cH+BktwWPEWmZnUoq/mg2JTswedPmOBPec47Aa2yqIS0B9Ao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JosyabYK; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714451183;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/j3/XOns0oFgwfO5bxhGBltITHmRiIbor4kORGQYrjA=;
	b=JosyabYKWBB7JgkSX2dxfOPiRlu4cT/CIIwIhFb1RWyLRccf9DM1RFBRVlkgmQblQuE5Fa
	CM919Py2nIDzKstn9H/E8Ga1EZLsuiNjtk5U2r7MmGdLgkp8sy4mTHLbeyKKgvTxbXS4T3
	oWwSfuqS1mQgOptV6vfBoQ7LRUmvFJk=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-224-htm8gXbRP6qRgx9hAcnbAQ-1; Tue, 30 Apr 2024 00:26:19 -0400
X-MC-Unique: htm8gXbRP6qRgx9hAcnbAQ-1
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-604bad9b2e8so5691264a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 21:26:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714451178; x=1715055978;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/j3/XOns0oFgwfO5bxhGBltITHmRiIbor4kORGQYrjA=;
        b=sEI9D1x+6SBT5WNoq7vx/Kv32QTr/Vw3AEg4E0a1cmZLJ3hST8SYZDTJxjpduMJZBX
         qUhHa83LTF+FX4EdKgaFjyCD4XRToM+DfwJ3t+zP9EnN2M3Xs+Vy/9g+nQYnejOc5/YL
         EueSN+CQ8HDlKGhGPpcV3e+2X97DdvsGi+pGe7mEmFLpjOJZSPVSjYpaPTljgjoKh6fg
         sqFBcE3SIB4eSjP01aZBEbZfFxnOETfKOl9ChM3bBtbNDB85ojlWyOTLwxg3aOJO+FAM
         nMu9sQ54DZAUHD/ypIq4HsN81u7SrYhQ2X5+H4A8XBz1zLPhZz0Ah83PCNGrKHsF2HAi
         PjsA==
X-Forwarded-Encrypted: i=1; AJvYcCXv1KyPIBV8iwZzMTSF860wup4h5L7c9yxa3o3JwAZ5GcCUKG4O8R0oqvLAuqexxeDBlC1qkTLs10rieA3ZhWCk2EMTMRtPhOPMpmKp
X-Gm-Message-State: AOJu0YwUYJG7hQwzV59dAtfNRKt5I98D17e9J4gcWKld1JZP8+ju6Ug6
	QjyQUFdkgorVYGau8ckDDTUzJm1HZlc9Ew5nJwW7uYI3Cvone+ub8QjomXnAWoCIbkihGofhSdB
	4OPZz1G4l4OIugGhdFS6gk+yiwh9w+1Z2E/38FdIFG+n+hPa0HGe0WeSv5vuhlA==
X-Received: by 2002:a05:6a20:43ab:b0:1af:597f:ffa4 with SMTP id i43-20020a056a2043ab00b001af597fffa4mr1773941pzl.14.1714451178654;
        Mon, 29 Apr 2024 21:26:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH07U3E59OEv3uasYAdnnN9/WYRlSaTmrz5sCzeoOlurs0CWJYXB3V+LTa+nYaZB59wKOeCng==
X-Received: by 2002:a05:6a20:43ab:b0:1af:597f:ffa4 with SMTP id i43-20020a056a2043ab00b001af597fffa4mr1773917pzl.14.1714451178308;
        Mon, 29 Apr 2024 21:26:18 -0700 (PDT)
Received: from [192.168.68.50] ([43.252.112.88])
        by smtp.gmail.com with ESMTPSA id p2-20020a170902e74200b001e223b9eb25sm21272994plf.153.2024.04.29.21.26.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Apr 2024 21:26:17 -0700 (PDT)
Message-ID: <63f7c71a-fa01-4604-8fc6-9f52b5b31d6b@redhat.com>
Date: Tue, 30 Apr 2024 14:26:06 +1000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 05/16] ACPI: processor: Add acpi_get_processor_handle()
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
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Marc Zyngier <maz@kernel.org>, Hanjun Guo <guohanjun@huawei.com>
Cc: Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>, linuxarm@huawei.com,
 justin.he@arm.com, jianyong.wu@arm.com,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 Sudeep Holla <sudeep.holla@arm.com>
References: <20240426135126.12802-1-Jonathan.Cameron@huawei.com>
 <20240426135126.12802-6-Jonathan.Cameron@huawei.com>
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <20240426135126.12802-6-Jonathan.Cameron@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/26/24 23:51, Jonathan Cameron wrote:
> If CONFIG_ACPI_PROCESSOR provide a helper to retrieve the
> acpi_handle for a given CPU allowing access to methods
> in DSDT.
> 
> Tested-by: Miguel Luis <miguel.luis@oracle.com>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> ---
> v8: Code simplification suggested by Rafael.
>      Fixup ;; spotted by Gavin
> ---
>   drivers/acpi/acpi_processor.c | 11 +++++++++++
>   include/linux/acpi.h          |  7 +++++++
>   2 files changed, 18 insertions(+)
> 

Reviewed-by: Gavin Shan <gshan@redhat.com>

> diff --git a/drivers/acpi/acpi_processor.c b/drivers/acpi/acpi_processor.c
> index 3b180e21f325..ecc2721fecae 100644
> --- a/drivers/acpi/acpi_processor.c
> +++ b/drivers/acpi/acpi_processor.c
> @@ -35,6 +35,17 @@ EXPORT_PER_CPU_SYMBOL(processors);
>   struct acpi_processor_errata errata __read_mostly;
>   EXPORT_SYMBOL_GPL(errata);
>   
> +acpi_handle acpi_get_processor_handle(int cpu)
> +{
> +	struct acpi_processor *pr;
> +
> +	pr = per_cpu(processors, cpu);
> +	if (pr)
> +		return pr->handle;
> +
> +	return NULL;
> +}
> +

Maybe it's worthy to have more check here, something like below.
However, it's also fine without the extra check.

	if (cpu >= nr_cpu_ids || !cpu_possible(cpu))
		return NULL;

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


