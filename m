Return-Path: <linux-kernel+bounces-166576-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E2CE98B9C9B
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 16:42:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9F937280CFF
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 14:42:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4BD4153509;
	Thu,  2 May 2024 14:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="ZKeXpYvS"
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D350913C687
	for <linux-kernel@vger.kernel.org>; Thu,  2 May 2024 14:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714660927; cv=none; b=I56oqB+zSMm4Gx8CZb6pzr5SsBI9iDy0Gyrjs4ik5rcM3U2TnToZ2xaDyiWlhYs3pwXZlORGewJuUpliJ1AAXJGo4l/qqb2AExYZMQ46iNRBEY3faogXffgDolDqxjDLMWAd97vwMXUYw9eOhF3Kr5Vbtf4Crz3Z8L2R8gN2XkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714660927; c=relaxed/simple;
	bh=31r3Q7wEIk+tZYT2/alRNJj4qJTd5yscIn8kGo7vZPM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tQhQc7M4AdJBYna1CjguJmY1+84Fl7+07d1VfAHtYuHeCuTgnq8g+7ADxbwtahBcL4mc11PG9Rf7sZCslihX0BgRVitK1WoOsguaqLArcVJPG5M5BepB2kjul14+LwFJalyLqMUSFjmkbQJxb+MWafa4DbdUfe9qlOwIEKVBm+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=ZKeXpYvS; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a5544fd07easo1122212266b.0
        for <linux-kernel@vger.kernel.org>; Thu, 02 May 2024 07:42:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1714660923; x=1715265723; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qEMCswWL6Qvit5lVMRGJgC9X1ArZFQq7W3NBO8MPxTQ=;
        b=ZKeXpYvSqiMC291C0NvpQO6+Z73NO9L5uuPjGQshV7zBmTdbVmJ0DdPahCLXhRorsI
         PQRdn8SjMDlaFluuGdzHxQXbsiOjiNURYWHhPmDFXB6jFtUdPrjrNrgPzV4GgG3F/cln
         RJn6V3IbKfUdx9pso+j3XgfFE//K1P1UB5+bAg9DG/Fjr/9I3NUsYewiobeOiJXP4RGD
         hNh5eu514NO28UzEOrpW9sgvC3hbKCyuZAni3ycsqDcpI6FTPovR2lXagaE08Ktz6wv7
         0hzHWD/8yodmGdDB8iO2hZXmP3QDz0g4rvcdJLRMIL8NuPdce0/ayTsHoSc4je4EAPL8
         M7Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714660923; x=1715265723;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qEMCswWL6Qvit5lVMRGJgC9X1ArZFQq7W3NBO8MPxTQ=;
        b=Eb1BSe7NqtrK9eoCI0Hi1cPebJg9upfPDjh3WWKMNwpJ3jgG44TChOLBvUlngXXm8v
         1sXGTx8J9UYne4aCVOQmBVBPm/RE4GOFvnetveajSmI6xm0JYfw0xF4bpyiE99/Rs3ZS
         ssgbsRXLHT7dTfMLYfuRMVO73gTcBIHoS2VnHzbcchKxqZt+CjllQdIHIGVgRaxZqbfD
         HAQ+F7oSx7T1iUQogbZkcvlKKQ1XMPJycPhbh+6ZL4sP8U9d+x+6fms6ab7JYZq2qQvK
         6p1ng4y+yGp4WDxfPsw5kbiratL5HJcTHWD64iIIjeIWZn+I/iSL7HTDkPf9a970sOMC
         fh7A==
X-Forwarded-Encrypted: i=1; AJvYcCV3/NtDo740CT1Y14ESLMWpPW8c22/vIeCzR0jAYhggffATii5p06q5zLJU1C0qbFXEzMYSRmzElWjTq0Wiif+kKgGpdl1wbzF+aoQ2
X-Gm-Message-State: AOJu0YwNfa/7UKwML7tV1Y0y5QfxUlwufUzb0vFAHnlbbcZs2aLF6I0r
	urvhoVw6NAtI9KjcWArVS7oceFl9mFFx87AFNW8e4pYZtOh73vWvktzrnBqV9HY=
X-Google-Smtp-Source: AGHT+IEMCsNCdp9zWnFDCZiFl30qZoxTtlqbtNEJHtoRqZ7wqGm5hOGyYp5XwfHBrEzpM/5v5pZXGg==
X-Received: by 2002:a50:8d17:0:b0:572:5bc3:3871 with SMTP id s23-20020a508d17000000b005725bc33871mr4144277eds.10.1714660923070;
        Thu, 02 May 2024 07:42:03 -0700 (PDT)
Received: from ?IPV6:2003:e5:8738:9a00:3771:d6c0:aec6:f5ea? (p200300e587389a003771d6c0aec6f5ea.dip0.t-ipconnect.de. [2003:e5:8738:9a00:3771:d6c0:aec6:f5ea])
        by smtp.gmail.com with ESMTPSA id n16-20020a05640205d000b00572a9c7d58bsm607330edx.6.2024.05.02.07.42.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 May 2024 07:42:02 -0700 (PDT)
Message-ID: <a71350c7-4b88-4bda-b9be-cf66e97b283e@suse.com>
Date: Thu, 2 May 2024 16:42:02 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] x86/xen/smp_pv: Register the boot CPU APIC properly
To: Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
 x86@kernel.org
Cc: Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>,
 Andrew Cooper <andrew.cooper3@citrix.com>
References: <20240405123434.24822-1-jgross@suse.com>
 <20240405123434.24822-2-jgross@suse.com> <87ttjisu9l.ffs@tglx>
 <27de9ba0-cbe9-4256-b378-45ede5d29517@suse.com> <87a5l8s2fg.ffs@tglx>
Content-Language: en-US
From: =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>
In-Reply-To: <87a5l8s2fg.ffs@tglx>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 02.05.24 16:39, Thomas Gleixner wrote:
> The topology core expects the boot APIC to be registered from earhy APIC
> detection first and then again when the firmware tables are evaluated. This
> is used for detecting the real BSP CPU on a kexec kernel.
> 
> The recent conversion of XEN/PV to register fake APIC IDs failed to
> register the boot CPU APIC correctly as it only registers it once. This
> causes the BSP detection mechanism to trigger wrongly:
> 
>     CPU topo: Boot CPU APIC ID not the first enumerated APIC ID: 0 > 1
> 
> Additionally this results in one CPU being ignored.
> 
> Register the boot CPU APIC twice so that the XEN/PV fake enumeration
> behaves like real firmware.
> 
> Reported-by: Juergen Gross <jgross@suse.com>
> Fixes: e75307023466 ("x86/xen/smp_pv: Register fake APICs")
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Tested-by: Juergen Gross <jgross@suse.com>

Reviewed-by: Juergen Gross <jgross@suse.com>

Thanks for the patch, I'll take it via the Xen tree.


Juergen

> ---
>   arch/x86/xen/smp_pv.c |    4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> --- a/arch/x86/xen/smp_pv.c
> +++ b/arch/x86/xen/smp_pv.c
> @@ -154,9 +154,9 @@ static void __init xen_pv_smp_config(voi
>   	u32 apicid = 0;
>   	int i;
>   
> -	topology_register_boot_apic(apicid++);
> +	topology_register_boot_apic(apicid);
>   
> -	for (i = 1; i < nr_cpu_ids; i++)
> +	for (i = 0; i < nr_cpu_ids; i++)
>   		topology_register_apic(apicid++, CPU_ACPIID_INVALID, true);
>   
>   	/* Pretend to be a proper enumerated system */


