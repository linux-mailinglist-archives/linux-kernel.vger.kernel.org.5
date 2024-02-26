Return-Path: <linux-kernel+bounces-82383-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 990A6868389
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 23:20:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7D5D21C233C8
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 22:20:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A2A0131E44;
	Mon, 26 Feb 2024 22:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="VNHhMEKD"
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9224312D75E
	for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 22:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708986008; cv=none; b=Go97Y44X6pwL4uueGAqybId1iFGmx/ykvngEFQSNj0dxxSqwbKYf8CuMi8qfu73/AiIrbkchrxCxLeDgSE1ZfJam6KluVONjRYvRETxBGRoxrBnGa+agMeU/PwteoYJ2TSzUlJpc7le5MU1dgOuDNoh5mp96f3q7tBNV4o0wOXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708986008; c=relaxed/simple;
	bh=skxVL5kaknU87N+S3YBA4vPUrAkeCI9uwX20e0OJgVA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OAD9Pqq5PoClXgkpK3EkRv7VBhOw4ouPN+RjaWqC+88I4P/jJZyUeebfPQbsdClyma9pLDkfQ6g2YLkq7V0Xo8gdTfekLCO+EXn+zm9xpGvaGhthQyYaF4PqYtt5IVb1xjopQFT9jBXQ4b90imsIRClivdgjAZU5as1sJdUEr7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=VNHhMEKD; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5655c7dd3b1so5735667a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 14:20:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1708986005; x=1709590805; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5Jm9mKeVX8NPdtK0hYoioIjcJhAV/zjNJl8t3JIfdWU=;
        b=VNHhMEKDhqLHz3w+pRbq0CHfmkpFmaPTbZeD170ijpvqgfaTJHrmMVb/BtoHBjD9Y/
         MUEaetSsbHzZ8St77OoX2gp3Mw5MMg6r8DeKbyl0rVZx7MdL3kbvB9F/HJlnfBQDUCuC
         RoN/Y2qMsBB1fbeAnDz1Q8469g2MsmDJCOffdihtr0kc0tp5SGdFbQjlLrf4tYdxbNiY
         DhJ0bd8r0CYZZbuRveVDj8TtC1ptMOlf5LDsWgqHthCFa6hE9kdVv8PqpO4WQo7Sfzq+
         uf7+zXl3s8sIq+bGhO4/z1mueCVLoA4T7v2LsA1AfSJSkD6EMcnKj64fvAU5iYpQDBtA
         iJLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708986005; x=1709590805;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5Jm9mKeVX8NPdtK0hYoioIjcJhAV/zjNJl8t3JIfdWU=;
        b=mf194Yb8+T/ZvDRJ0TGjGjsnVaLQmyHoVEuFj5X/8rdfAXHaKfK4yCEjBu8t1ddqrc
         uXe6mjyUhCsyi50NKvpCPrfv5tkYW56E0sl2xCse55a1Fe8tFmDqkGledq5cNSXq8IO9
         CNgcB8dXlP3VMOOgbzokNGr8R/Sxdaiv/RliikWK0VYkPCZpzJQpDPNHDcJH3S0zgEsG
         /zQUY4TDTmsxfW6VeVw4NfUUDIIfL2RPMd6gR0agyGuRhvD9OsOyoMldcSE68UsS5qfb
         JAGzE4v1y7wpvNys18RQ1AyFec6+/sODIeAGSe6lyRqYO8CcPM9ekoiXKaysd9HG1hLp
         FeXw==
X-Gm-Message-State: AOJu0YwsvnCCnJ+A+LwsJhGW033q3zO24f1kpBW5agU/GYVvEG6+UUub
	Mx/aDeQ1ZjZItFCAwcTzjKYcN81WPCfdh1wzAAulo737olUU9D6w6fY0qC4mcb0=
X-Google-Smtp-Source: AGHT+IFi7VtDe28YphgX/47GL8ixG0NcFoRu4OvHYMZS64J0qajiDvsZoKEclvilhnw5h4oZvgrwUg==
X-Received: by 2002:a17:907:9486:b0:a42:e819:e663 with SMTP id dm6-20020a170907948600b00a42e819e663mr7503450ejc.27.1708986004884;
        Mon, 26 Feb 2024 14:20:04 -0800 (PST)
Received: from [192.168.0.20] (nborisov.ddns.nbis.net. [85.187.216.229])
        by smtp.gmail.com with ESMTPSA id h5-20020a1709063c0500b00a432f3bc3a5sm152057ejg.76.2024.02.26.14.20.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Feb 2024 14:20:04 -0800 (PST)
Message-ID: <20558f89-299b-472e-9a96-171403a83bd6@suse.com>
Date: Tue, 27 Feb 2024 00:20:03 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [tip: x86/urgent] x86/bugs: Add asm helpers for executing VERW
Content-Language: en-US
To: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, linux-tip-commits@vger.kernel.org,
 Alyssa Milburn <alyssa.milburn@intel.com>,
 Andrew Cooper <andrew.cooper3@citrix.com>,
 Peter Zijlstra <peterz@infradead.org>,
 Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org
References: <170839092792.398.3678407222202963581.tip-bot2@tip-bot2>
 <6380ba8d-4e99-46e6-8d92-911d10963ba7@suse.com>
 <20240226221059.mnuurhn6g3irys37@desk>
From: Nikolay Borisov <nik.borisov@suse.com>
In-Reply-To: <20240226221059.mnuurhn6g3irys37@desk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 27.02.24 г. 0:10 ч., Pawan Gupta wrote:
> On Mon, Feb 26, 2024 at 09:17:30AM +0200, Nikolay Borisov wrote:
>>> diff --git a/arch/x86/include/asm/nospec-branch.h b/arch/x86/include/asm/nospec-branch.h
>>> index 262e655..077083e 100644
>>> --- a/arch/x86/include/asm/nospec-branch.h
>>> +++ b/arch/x86/include/asm/nospec-branch.h
>>> @@ -315,6 +315,17 @@
>>>    #endif
>>>    .endm
>>> +/*
>>> + * Macro to execute VERW instruction that mitigate transient data sampling
>>> + * attacks such as MDS. On affected systems a microcode update overloaded VERW
>>> + * instruction to also clear the CPU buffers. VERW clobbers CFLAGS.ZF.
>>> + *
>>> + * Note: Only the memory operand variant of VERW clears the CPU buffers.
>>> + */
>>> +.macro CLEAR_CPU_BUFFERS
>>> +	ALTERNATIVE "", __stringify(verw _ASM_RIP(mds_verw_sel)), X86_FEATURE_CLEAR_CPU_BUF
>>
>> Any particular reason why this uses RIP-relative vs an absolute address
>> mode?
> 
> Early versions of the series had the VERW arg pointing to the macro
> itself, that is why relative addressing was used. That got changed in a
> later version with all VERW sites pointing to a single memory location.
> 
>> I know in our private exchange you said there is no significance but
>> for example older kernels have a missing relocation support in alternatives.
>> This of course can be worked around by slightly changing the logic of the
>> macro which means different kernels will have slightly different macros.
> 
> Do you anticipate a problem with that? If yes, I can send a patch to use
> fixed addressing in upstream as well.

I experienced crashes on older kernels before realizing that the 
relocation wasn't resolved correctly by the alternative framework. 
Instead i simply changed the macro to jmp 1f, where the next instruction 
is the verw ( I did send a backport for 5.4) and it works. Recently 
there's been a push to make as much of the kernel assembly as possible 
PIC so having a rip-relative addressing helps. Whether that makes any 
material difference - I cannot say.

Here's my backport version for reference:

https://lore.kernel.org/stable/20240226122237.198921-3-nik.borisov@suse.com/

