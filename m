Return-Path: <linux-kernel+bounces-166452-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D25FF8B9AE5
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 14:32:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 719F31F21418
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 12:32:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C892458AC4;
	Thu,  2 May 2024 12:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="XMX/gU6l"
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B71C71E485
	for <linux-kernel@vger.kernel.org>; Thu,  2 May 2024 12:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714653140; cv=none; b=kY0QpkBiM0+XFTINdHCtdoSDWoyrIeNyBgwFtc0xOZyymWvgfy52Z43BlMn+kbggyUvFTJwq+7XUSOjCtslz9j3OgA8IIW/y9QtFnQidAswd97xTIkdxu0s5pZcwSRYlSxVDwreThTKQT4i7reZy9wsGkuWvQSBFNMRkoChah1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714653140; c=relaxed/simple;
	bh=Ago5BFvtiURr2YblQj2n6lxN+Cvl+9LBjN0R/tk+0PM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HDOinlXiV9TsXVE9Bo3lj4D8K512qW8ysh3p6CBgRG47kJbEoQBT9teVL8YcqVZjSTGZfDCFV3TSPutarEy65iCYoZ92BVO6FSBI+B7ar2sXreukhumIoGzZIO1OPEHl1aY9tnJwomNox5UDyW852lD9l3ZXcQgFMCsOdNAvXyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=XMX/gU6l; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-5176f217b7bso13751301e87.0
        for <linux-kernel@vger.kernel.org>; Thu, 02 May 2024 05:32:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1714653136; x=1715257936; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xzyJNWhfcauG4WuSdLGkLNNiyJ0sua1JqaDynaeyv1U=;
        b=XMX/gU6lzW9cethBKyoQr3jqY33jiFU78LbRA/7J217r2nG8PranWNEaRgzXWlX6WN
         eNLksLd8wQRmO3T5DDFr78fk+WegE91plRMoY7H/pHc6Vb5ucJIN8dTx6JuIJCbQ7Hi7
         y2HcgjbDa8aRCKJXKSssUjqsXogsjUmpt+iyJy3jx/JdcSBztiqHgFdUHgVjzU8INrVe
         5Qb9fA53f5N958nW9byTDElKCJ2Fmks19PI0gHo/12A5IIMV8/J5vAgFqKeBwRoeo6XC
         0GqCyOh8O6O9lrc1AbHTiBfMZXbtuHAiB3FcOuRQp2/UkTvDl2gDDqKt+TanuU4hk5w7
         BCug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714653136; x=1715257936;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xzyJNWhfcauG4WuSdLGkLNNiyJ0sua1JqaDynaeyv1U=;
        b=Lsj1+upQhykc+tBCFWKLgX2p//TDTUhAY/eqYhd1B3M8Qxsn/VYhhENu+MLXE2WFoQ
         kp02A/tPfx078JLAjFMJOISbRTRGB9S6tbjJ4OILM8LZh/Xb36XgVUGr7dKAECzHlLZu
         dy6kyXokR5R+JhjJnCTC++8Yq4j19i31w19ZHQxnqEX4UPxT4CoBwG38BrW9POBvqD0U
         5IVnlXGtAmDLwWzswLjHkIktIfZ9MCjOLb3N9dddpy8/ffRacEAzgL4Fzk0Ja1Vg2Src
         LJTc+UAx47XMTuX/pHkX0uyhPXmRUwaAagptIcFrjFcmlagFEXgCu7KiKcZcKYKhJZ6i
         A0lA==
X-Forwarded-Encrypted: i=1; AJvYcCUVzP5Fb2G6YOpwAcQdGnAff1mC+0GhsVRJsMbsEQE3GeueF/Zav+XaYmpZJJf2sRWhqpMaP7bfzhMvmKdXOZcMZooBz6FqP6Rns62m
X-Gm-Message-State: AOJu0Yy118T65FW1cC7tCT5JJwgkkTnrrMyZwJwWgSjKq7ML5nqxvi5+
	LvVe44vz/3nWO5OXqPe5MntLWaqrMFrtU5J15ZWJHAaYFIMfFYANMsYKC90Nwxs=
X-Google-Smtp-Source: AGHT+IGJoMlGQjxMV0274ssXuK7qe90Rnxhocb1uOBvuv/GcuTRersNyKAVPCiT6hPoqilM6zkzOog==
X-Received: by 2002:ac2:490b:0:b0:51f:4d57:6812 with SMTP id n11-20020ac2490b000000b0051f4d576812mr674279lfi.19.1714653135768;
        Thu, 02 May 2024 05:32:15 -0700 (PDT)
Received: from ?IPV6:2003:e5:8738:9a00:3771:d6c0:aec6:f5ea? (p200300e587389a003771d6c0aec6f5ea.dip0.t-ipconnect.de. [2003:e5:8738:9a00:3771:d6c0:aec6:f5ea])
        by smtp.gmail.com with ESMTPSA id kt1-20020a170906aac100b00a52295e014bsm512893ejb.92.2024.05.02.05.32.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 May 2024 05:32:15 -0700 (PDT)
Message-ID: <27de9ba0-cbe9-4256-b378-45ede5d29517@suse.com>
Date: Thu, 2 May 2024 14:32:14 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] x86/cpu: fix BSP detection when running as Xen PV
 guest
To: Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
 x86@kernel.org
Cc: Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>
References: <20240405123434.24822-1-jgross@suse.com>
 <20240405123434.24822-2-jgross@suse.com> <87ttjisu9l.ffs@tglx>
Content-Language: en-US
From: =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>
In-Reply-To: <87ttjisu9l.ffs@tglx>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 30.04.24 18:13, Thomas Gleixner wrote:
> On Fri, Apr 05 2024 at 14:34, Juergen Gross wrote:
>> When booting as a Xen PV guest the boot processor isn't detected
>> correctly and the following message is shown:
>>
>>    CPU topo: Boot CPU APIC ID not the first enumerated APIC ID: 0 > 1
>>
>> Additionally this results in one CPU being ignored.
>>
>> Fix that by calling the BSP detection logic when registering the boot
>> CPU's APIC, too.
>>
>> Fixes: 5c5682b9f87a ("x86/cpu: Detect real BSP on crash kernels")
>> Signed-off-by: Juergen Gross <jgross@suse.com>
>> ---
>>   arch/x86/kernel/cpu/topology.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/arch/x86/kernel/cpu/topology.c b/arch/x86/kernel/cpu/topology.c
>> index aaca8d235dc2..23c3db5e6396 100644
>> --- a/arch/x86/kernel/cpu/topology.c
>> +++ b/arch/x86/kernel/cpu/topology.c
>> @@ -255,7 +255,7 @@ void __init topology_register_boot_apic(u32 apic_id)
>>   	WARN_ON_ONCE(topo_info.boot_cpu_apic_id != BAD_APICID);
>>   
>>   	topo_info.boot_cpu_apic_id = apic_id;
>> -	topo_register_apic(apic_id, CPU_ACPIID_INVALID, true);
>> +	topology_register_apic(apic_id, CPU_ACPIID_INVALID, true);
> 
> No. This does not fix anything at all. It just papers over the
> underlying problem.
> 
> Thanks,
> 
>          tglx
> ---
> diff --git a/arch/x86/xen/smp_pv.c b/arch/x86/xen/smp_pv.c
> index 27d1a5b7f571..ac41d83b38d3 100644
> --- a/arch/x86/xen/smp_pv.c
> +++ b/arch/x86/xen/smp_pv.c
> @@ -154,9 +154,9 @@ static void __init xen_pv_smp_config(void)
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
> 
>          
> 

Thanks, works great.

Do you want it to send as your patch, or should I add your Signed-off-by or
your Suggested-by?


Juergen

