Return-Path: <linux-kernel+bounces-165173-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 411668B890B
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 13:11:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C9E1728471F
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 11:11:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED9B860B96;
	Wed,  1 May 2024 11:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="H0WpWxtn"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C378748CE0
	for <linux-kernel@vger.kernel.org>; Wed,  1 May 2024 11:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714561885; cv=none; b=bPL8L7SfByRYrVTHGrjWO9SB/cO13mgoJFHH8MBVLrRRlIWToLe0D08KVqTVomBOnGYFASsKebriA8rnC3DCOJdZIP7ShZ8Q3ORBNBr4oaX4iQFx90EhmwljmKMCNO5hZxEKT7F5MZ6xeeauzfg86rXeujuLizMJTSREVwveN5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714561885; c=relaxed/simple;
	bh=HjmQN/vLfXCeKes7nGzRxBen9HgLMO+9+ng5Ze3Bavk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VIGV62CRdJyH2i0WAana1xE9IWqIaahQffyOpf+SQD+SIZI1aueU/CWSCa5/0ZSPwLnTBfSvSOj2l5TT+wsKHdHXQ331eZWybKJQUFzNBMyUI6c+Cmd6E0s4Awb8HYl9ExOCPInppq/K33w4/bCzQ9vq1xs47tm+Ops855jw1as=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=H0WpWxtn; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714561882;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/9EhiTpZ039qYHHJ6iv2nIzs+2XcBDCLGyTfEI94qWw=;
	b=H0WpWxtnat1Z9b6zzPoVhtz7huxz5QUERylQRVteNeAWYAnkviVJKNNQkJSB5f0xQYHRq0
	TpFmVMrPV+8ae+JtszKNdm29LHV6o2e75eQF+cdhXXHkkDIj5e6dpy2EzFf8wsYT3UwtL5
	pRt0jISXL7i6hRS3qPdYvCWcrH4oWrE=
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-180-i4buSK1vM_ql7BdNxMA3Dw-1; Wed, 01 May 2024 07:11:06 -0400
X-MC-Unique: i4buSK1vM_ql7BdNxMA3Dw-1
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-6f3eb28c129so2556107b3a.1
        for <linux-kernel@vger.kernel.org>; Wed, 01 May 2024 04:11:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714561865; x=1715166665;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/9EhiTpZ039qYHHJ6iv2nIzs+2XcBDCLGyTfEI94qWw=;
        b=tu4g6u68c4l24KH1+m/PkeGQbD9neOHQHbLuBFANrxWBIwIe1QT+eR7piwhNCaDusY
         3xtlCRjOsMblZA8oJFF+9rK7m+MbLAFBFJcz/eOOtmq+IXx3tmHxXNf8s4Ul78uHJ0dx
         E7zImM1mubwQx1MN67zHSN06IT39hkJUq93p3vXlhMsZp+91D14euxTvHGNmuNK0y5J6
         VWn2K3DCYBq9qmI6hhD/PwdHxXJVgOgL0YH08i/8XxigjOHsnIsyNPlc1VhQWHP2f7iX
         QOeyAtRJKQs/AlRU2mHDXRU9kw8DfTrAs5wqXmgAyyc1W9PlsU0kwYc1kYUWBsa6RG9e
         QGjw==
X-Forwarded-Encrypted: i=1; AJvYcCWlfz+d4LuE25gaElBo17dHGlwFvs1K8lp+J99CxwjT+CfX5s8vSCOKNzfQulHoyMMSfh4GMO8RhawxfFg/KJ9+wYv8C96juLz5yKWw
X-Gm-Message-State: AOJu0YzSyLWTK+MEmGGOVp7emHEykftLwVeVey4jFLm9cgPmFOs/xufk
	edcT+uC08U89nUfqOiEz/x8u9ZHXec9M4YrULPtPcdf90ffNn6Hui8Z8r7JPN1TOtt0iZAz/JdA
	aGsLeESGgOw1NNQG8NJDqul2vWPxoHgYArolkKiJYSZqSTqUR0ByCD7+KPWRUOw==
X-Received: by 2002:a05:6a20:f38a:b0:1af:59b9:e3ed with SMTP id qr10-20020a056a20f38a00b001af59b9e3edmr2412156pzb.5.1714561865246;
        Wed, 01 May 2024 04:11:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGjAPRGKaaujq7rTK1yaA7Ot9xIJqN3jHlI3pLra3C5HiqJNFkOQs4ByCYnk6CyZCfgy9Hx2w==
X-Received: by 2002:a05:6a20:f38a:b0:1af:59b9:e3ed with SMTP id qr10-20020a056a20f38a00b001af59b9e3edmr2412126pzb.5.1714561864872;
        Wed, 01 May 2024 04:11:04 -0700 (PDT)
Received: from [192.168.68.50] ([43.252.112.88])
        by smtp.gmail.com with ESMTPSA id r10-20020a6560ca000000b005fd74e632f0sm15597042pgv.38.2024.05.01.04.10.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 May 2024 04:11:04 -0700 (PDT)
Message-ID: <47e1b241-9085-44e6-a3d0-4ded94a183ce@redhat.com>
Date: Wed, 1 May 2024 21:10:53 +1000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 12/19] arm64: acpi: Harden get_cpu_for_acpi_id()
 against missing CPU entry
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
 justin.he@arm.com, jianyong.wu@arm.com
References: <20240430142434.10471-1-Jonathan.Cameron@huawei.com>
 <20240430142434.10471-13-Jonathan.Cameron@huawei.com>
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <20240430142434.10471-13-Jonathan.Cameron@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/1/24 00:24, Jonathan Cameron wrote:
> In a review discussion of the changes to support vCPU hotplug where
> a check was added on the GICC being enabled if was was online, it was
                                                  ^^^^^^^

                                                  typo

> noted that there is need to map back to the cpu and use that to index
> into a cpumask. As such, a valid ID is needed.
> 
> If an MPIDR check fails in acpi_map_gic_cpu_interface() it is possible
> for the entry in cpu_madt_gicc[cpu] == NULL.  This function would
> then cause a NULL pointer dereference.   Whilst a path to trigger
> this has not been established, harden this caller against the
> possibility.
> 
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
> v9: New patch in response to a question from Marc Zyngier.
>      Taking the easy way out - harden against a possible condition rather
>      than establishing it never happens!
> ---
>   arch/arm64/include/asm/acpi.h | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 

With the typo corrected:

Reviewed-by: Gavin Shan <gshan@redhat.com>

> diff --git a/arch/arm64/include/asm/acpi.h b/arch/arm64/include/asm/acpi.h
> index bc9a6656fc0c..a407f9cd549e 100644
> --- a/arch/arm64/include/asm/acpi.h
> +++ b/arch/arm64/include/asm/acpi.h
> @@ -124,7 +124,8 @@ static inline int get_cpu_for_acpi_id(u32 uid)
>   	int cpu;
>   
>   	for (cpu = 0; cpu < nr_cpu_ids; cpu++)
> -		if (uid == get_acpi_id_for_cpu(cpu))
> +		if (acpi_cpu_get_madt_gicc(cpu) &&
> +		    uid == get_acpi_id_for_cpu(cpu))
>   			return cpu;
>   
>   	return -EINVAL;


