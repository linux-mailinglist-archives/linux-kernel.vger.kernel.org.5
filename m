Return-Path: <linux-kernel+bounces-165134-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8A328B887A
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 12:19:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7208C283295
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 10:19:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E72CD524DC;
	Wed,  1 May 2024 10:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TjQsWqm7"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA4A817BB4
	for <linux-kernel@vger.kernel.org>; Wed,  1 May 2024 10:19:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714558777; cv=none; b=eivegnh3zTdzaAzQClznsh7mHczq2nft0afh/Dm7vjC+Fu6TuV5OQch2XWN3BkvWX+vfzFLk2Un/SgZt+Iv7u+A/Krp6hl60j/It6wjTwLd3ADh95Ta+9Io8YXNPvG97F6FNCNlvMTnvNF/BkF+UFz6wQnOjZY2AiEFEg0OX2z0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714558777; c=relaxed/simple;
	bh=DXhxznU9JjmpSNzg1wHRqUCO05ryVh2E1hgdKVJ0r/0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iLBsaZtnUknS35gLAdfEq3JEIU7H4/B1oHiMkWvxzVTlIBD6sLJMueYIqPNgPA+Rkwb1NwiPTFAFCeCnGTT9S6o5cRn859uglqCLk05fTLFPR0MXiWiS898cr/FTaIrwQUaLxJPpz5QkLYjrDnsK7KFnKCphajNeBPHgaSO9a9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TjQsWqm7; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714558774;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mmEGz0tj7kIblBaqJ9h8gJzxXs1BObonWK5NXhTXy2g=;
	b=TjQsWqm7PNZyWJsg/b4LWCit2noY+wSUq7qJGstNobpVfXuwKyTBw0PuZndtPGM6/opIDf
	oZuiVybVcDxt8K4Q3O0widHYBpHkCIaauJM/SmCs5utPPJNcC5fjkpAZ0uBbM4x5n/hVGt
	k4FfTgx+CfEaRWvhuZg2bvfSfhlE1cI=
Received: from mail-oo1-f69.google.com (mail-oo1-f69.google.com
 [209.85.161.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-86-as6kBpPrMBGVVc_-l6ozWA-1; Wed, 01 May 2024 06:19:33 -0400
X-MC-Unique: as6kBpPrMBGVVc_-l6ozWA-1
Received: by mail-oo1-f69.google.com with SMTP id 006d021491bc7-5b1a8c36932so526828eaf.3
        for <linux-kernel@vger.kernel.org>; Wed, 01 May 2024 03:19:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714558773; x=1715163573;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mmEGz0tj7kIblBaqJ9h8gJzxXs1BObonWK5NXhTXy2g=;
        b=llWNPVateXLIbrmzjQKIt2vVSt1eIVs+lfHUlYYG3pBqNjYopjxxlmrQqtHYZNHrhJ
         LG12rcdbKJDc3dUiUir+dcbQjigVyBr15biMbBkTF89MKiANy1Kqxlm2TOcSkge1Mort
         uVrSfIMNPLYSu2F/g0QA3giobN6QKGviev33Gl5uJXL7ShmYFpg85oUtcuGoamEs8h9D
         6qMUZH0fdLDuJkxF26iqy63ZZjwdnqz3ri+kOHiqT6LZMhOEwgj5502Av+VkBUZBAy2f
         u6eFLb7MNHhD2tZ3A1g/3cYuu6NsftqGSuWhOe0CoC8E2zJLgtYRNJXEjK2U7ykoHwCR
         f16w==
X-Forwarded-Encrypted: i=1; AJvYcCXLjJPj+Upyuv6cABLD2nxw6vrhi4l6Z0FiuT3X3vnkhleYobOf014ikIwL411xWtsM3k4biKYmatCIfWwrGYvxRcu7JWN7NIbwiwck
X-Gm-Message-State: AOJu0YzccBoJyp3Vp+hVV4e6Z2EObB1K3K3IilcW15fSyWXWpJMVYjkz
	0ynNPXEoc6JXtiiQmZsbp3+ReOLt8eO7998bcRVjgCzrHGPFQGwScJveN+Eh8kD2+pGY5KlfAGo
	69LzNsasVzeMO/imyIuJcnD74IoRuVu+0U6OIWAqUZYFjXaM10zBf8Q+k4KYVtQ==
X-Received: by 2002:a05:6358:b3c2:b0:186:d3c9:fc0b with SMTP id pb2-20020a056358b3c200b00186d3c9fc0bmr2565152rwc.30.1714558772866;
        Wed, 01 May 2024 03:19:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH109ZEmrs8b6zIYcwGCPZVYbwoFohFQfuWKsDp3G4uwsHjXJPYYLUDItsMWRt9l+MVNm+LjQ==
X-Received: by 2002:a05:6358:b3c2:b0:186:d3c9:fc0b with SMTP id pb2-20020a056358b3c200b00186d3c9fc0bmr2565125rwc.30.1714558772433;
        Wed, 01 May 2024 03:19:32 -0700 (PDT)
Received: from [192.168.68.50] ([43.252.112.88])
        by smtp.gmail.com with ESMTPSA id x71-20020a63864a000000b00606dd49d3b8sm12183225pgd.57.2024.05.01.03.19.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 May 2024 03:19:31 -0700 (PDT)
Message-ID: <02922d47-6bb9-4865-b13f-b3a6972853a6@redhat.com>
Date: Wed, 1 May 2024 20:19:23 +1000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 05/19] ACPI: processor: Fix memory leaks in error paths
 of processor_add()
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
 <20240430142434.10471-6-Jonathan.Cameron@huawei.com>
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <20240430142434.10471-6-Jonathan.Cameron@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/1/24 00:24, Jonathan Cameron wrote:
> If acpi_processor_get_info() returned an error, pr and the associated
> pr->throttling.shared_cpu_map were leaked.
> 
> The unwind code was in the wrong order wrt to setup, relying on
> some unwind actions having no affect (clearing variables that were
> never set etc).  That makes it harder to reason about so reorder
> and add appropriate labels to only undo what was actually set up
> in the first place.
> 
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> ---
> v9: New patch in response to Gavin noticing a memory leak later in the
>      series.
> ---
>   drivers/acpi/acpi_processor.c | 15 ++++++++-------
>   1 file changed, 8 insertions(+), 7 deletions(-)
> 

Reviewed-by: Gavin Shan <gshan@redhat.com>


