Return-Path: <linux-kernel+bounces-108094-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 641978805DE
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 21:11:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8AE331C22764
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 20:11:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 369D955C34;
	Tue, 19 Mar 2024 20:11:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="CMpoug/y"
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0C751E494
	for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 20:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710879095; cv=none; b=vFsWK55QEpViP+gL2Sgcf6XZ3NbgWni1YwuZCxSRddrdyGgfC6hYdepNrOKd5sCbtMXy83TJRKKu2Av0o0yfa9EyN5ukYm7uCbfZQDjCpEyfWs5uOmaf8D3yyKYnC3gUBeC/2eP8LKa6A7uJAeBPCEZNpZ2NWYkCpbfvojUvE1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710879095; c=relaxed/simple;
	bh=h9Z8EWtUP8Z5bnoHDKO95iplbd2qJAayfdXUbjWnjoE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BVAY82JbHzb5G8HO9Yi6fwzMnJaINsiD2QpukvED1Nx0hxmrom/aN6ySA0migZjHEnKavPeOMxnzTOjzCLL6r1eh6sLKeldsvcURXzZPIPApNeu+WPjM9jgcSU07fSylFVXkbt5Q1yrpnXQMXm4H3I3urVkZUsi+fr/CbH31dvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=CMpoug/y; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-29c75e348afso4472821a91.2
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 13:11:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1710879093; x=1711483893; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qxciHIs/9sZQePYO7DWCP1aPLuU+bU/1C9S6KStzprA=;
        b=CMpoug/yxIqDqLK7dImvLRMXugAAZnFa/8d7hK4MQ6vKaWLaxDua9qERQLNykGr9Sx
         /Wptf+D+P82YqYqhi20O0LO6wogEaZp2vOgm/ZiFD0QFcvDl6wxhhJaAXDugi9fmTfsL
         0019OF0O/JKZtC9nCWcURxS1kbPN64qgszw7kCGmldKmOp+Ojeed0nK5l0QMOixruYvs
         fzYHj9AId8kBU6XxF7zkiU+u6yzeH8n0Z8TBT2KkWJvecDDqru2SLhT0Xdx1/DMv5JWI
         rovDSSCoxAq04Lx5Nq5vwWnQducGpmjXim1WxnhN20eh+OO4zZP16OFOhw4PmgV4m0K2
         8j/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710879093; x=1711483893;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qxciHIs/9sZQePYO7DWCP1aPLuU+bU/1C9S6KStzprA=;
        b=YeuDBOVOqbfK1LtEbYkIu1tQk3RdYrjFs56OXVBgjUdnNAz/gCkc4cUsV6+CjWg8RH
         x2/ZJuhig1EWk0Us172vaxuEeFFsVfTn5WbjWuK+Z00NXJnG69QiZCBnSqluVWPcEOVY
         2elzFu5mpBiW59O9ZJTlTb9JUoeMw1iTZLyKxwm/44fdLMPJ0XXAMvEpgZiLZeebs5zS
         QO183G+OhJion8P9+0KQNZ4hY5mCtdwdkWYfvxQ7bMofqRYssvrOSTpJESvB2dpgLYLL
         wBlje4sxo61XIlK3VeRQ5JQUEThQ6CAMp8Pmfxh6kdN+zJjrn/eXiHq7fzqlcs4zAyyw
         O49g==
X-Forwarded-Encrypted: i=1; AJvYcCXWlHKDnHKycRx06kgfaAUEFpHFjT//3s86wLzvJQPtWBxK65evluLjf3cthe3AygncROIh5hI9CBjBjq8KQSjLG/sThjsYIzfwJS7s
X-Gm-Message-State: AOJu0Yw88jE4/NPx6o7fdm5yZce/T5pZW26FSrxFOuAZivtKmi12zqhN
	V/knjLbsG8R5D8M1t2EORdb91MF8a0FwyyE6Cuoq+TNtlW+1X7Dz+e+AatAsEXc=
X-Google-Smtp-Source: AGHT+IG/SwXVCYVcyNCBXJ6NdanaXkVJumohnM+SJRldB3twx1Oobl3tnNyfK0D+fbGqcBUy6fb/3w==
X-Received: by 2002:a17:90a:bd91:b0:29f:ef34:3004 with SMTP id z17-20020a17090abd9100b0029fef343004mr215196pjr.43.1710879092982;
        Tue, 19 Mar 2024 13:11:32 -0700 (PDT)
Received: from ?IPV6:2601:647:4180:9630::546? ([2601:647:4180:9630::546])
        by smtp.gmail.com with ESMTPSA id u5-20020a17090ac88500b0029df554300csm8554426pjt.24.2024.03.19.13.11.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Mar 2024 13:11:32 -0700 (PDT)
Message-ID: <2b002585-eec9-40d3-95bc-e010b7def7a9@rivosinc.com>
Date: Tue, 19 Mar 2024 13:11:30 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] perf: RISC-V: fix IRQ detection on T-Head C908
Content-Language: en-US
To: Conor Dooley <conor@kernel.org>, Andrew Jones <ajones@ventanamicro.com>
Cc: Inochi Amaoto <inochiama@outlook.com>, Qingfang Deng <dqfext@gmail.com>,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Atish Patra <atishp@atishpatra.org>, Anup Patel <anup@brainfault.org>,
 Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Conor Dooley <conor.dooley@microchip.com>, Heiko Stuebner <heiko@sntech.de>,
 Guo Ren <guoren@kernel.org>, linux-riscv@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <IA1PR20MB4953ECC3E32E95303872CD14BB242@IA1PR20MB4953.namprd20.prod.outlook.com>
 <CALW65jZ+q8sDiRKgsRL9n+939HNUCnkKuO=YJjHB5Js=WYQeOg@mail.gmail.com>
 <20240312-evil-resource-66370b68b9b4@spud>
 <IA1PR20MB4953CE8999960BA71B46DE6CBB2A2@IA1PR20MB4953.namprd20.prod.outlook.com>
 <20240315-73aa13079ef83a4559869084@orel>
 <2de56d8b-bc78-428b-9c09-4729b269fa41@rivosinc.com>
 <20240318-such-animal-bf33de12dc3a@spud>
 <4bdaaff1-13ec-48c2-b165-6a8255784aef@rivosinc.com>
 <20240319-worry-video-66589b3ed8ae@spud>
 <20240319-3e72d732cbf2fcf1cb81f968@orel>
 <20240319-underfoot-dispense-dc30ea860e7c@spud>
From: Atish Patra <atishp@rivosinc.com>
In-Reply-To: <20240319-underfoot-dispense-dc30ea860e7c@spud>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/19/24 08:36, Conor Dooley wrote:
> On Tue, Mar 19, 2024 at 02:39:21PM +0100, Andrew Jones wrote:
>> On Tue, Mar 19, 2024 at 09:06:34AM +0000, Conor Dooley wrote:
>>> On Mon, Mar 18, 2024 at 05:48:13PM -0700, Atish Patra wrote:
>>>> On 3/18/24 16:48, Conor Dooley wrote:
>>>>> On Mon, Mar 18, 2024 at 03:46:54PM -0700, Atish Patra wrote:
>>>
>>>>>> For 2.b, either we can start defining pseudo extensions or adding
>>>>>> vendor/arch/impid checks.
>>>>>>
>>>>>> @Conor: You seems to prefer the earlier approach instead of adding the
>>>>>> checks. Care to elaborate why do you think that's a better method compared
>>>>>> to a simple check ?
>>>>>
>>>>> Because I don't think that describing these as "errata" in the first
>>>>> place is even accurate. This is not a case of a vendor claiming they
>>>>> have Sscofpmf support but the implementation is flawed. As far as I
>>>>> understand, this is a vendor creating a useful feature prior to the
>>>>> creation of a standard extension.
>>>>> A bit of a test for this could be "If the standard extension never
>>>>> existed, would this be considered a new feature or an implementation
>>>>> issue". I think this is pretty clearly in the former camp.
>>>>>
>>>>
>>>> So we have 3 cases.
>>>>
>>>> 1. Pseudo extension: An vendor extension designed and/or implemented before
>>>> the standard RVI extension was ratified but do not violate any standard
>>>> encoding space.
>>
>> The vendor should name these extensions themselves.
>>
>>>>
>>>> 2. Erratas: An genuine bug/design issue in the expected behavior from a
>>>> standard RVI extension (including violating standard encoding space)
>>
>> More on this below, but I think vendors should name these too.
> 
> Yah, both of these the vendor /should/ name it themselves but I don't
> want some set in stone /must/ that locks someone who is not the vendor
> from upstreaming.
> 
>>>> 3. Vendor extension: A new or a variant of standard RVI extension which is
>>>> different enough from standard extension.
>>>>
>>>> IMO, the line between #2 and #1 may get blurry as we going forward because
>>>> of the sheer number of small extensions RVI is comping up with (which is a
>>>> problem as well).
>>
>> The line between #1 and #2 is blurry because the only difference is the
>> original intentions. The end result is that a vendor has implemented
>> something that resembles a standard extension, but is not the same as the
>> standard extension.
> 
> Aye, a large part of this is definitely based on intent. Or maybe
> marketing rather than intent, but the two aren't all that different
> as the public may not be privy to which it actually is.
> 
> I think you're missing a factor though - when the difference is
> discovered. Equating #1 and #2 is fine when that difference is known
> when the platform is originally supported, but if the divergence between
> what's implemented and the spec is only discovered down the line...
> 
>>> All this stuff is going to be pretty case-by-case (to begin with at
>>> least) so I'm not too worried about that sort of abuse.
>>
>> Case-by-case is reasonable, since it's probably too strict to always
>> require new names. We can consider each proposed workaround as they
>> come, but it's a slippery slope once workarounds are accepted.
> 

May be we treat #1 and #3 are same. In this case, we just call it 
XTheadSscofpmf or something similar. The patches would look similar to 
what was proposed in Andes PMU v7 series in that case.

> ... I think that means that having some workarounds are inescapable
> really. Some sort of workaround could then be only way fix the problem
> without a firmware update. That workaround might be triggered by the
> m*id CSRs or it could be based on the firmware's SBI implemenation
> or version IDs.
> When it's something that never worked at all or was discovered early,
> then ye equate the two.
> 
>>>> Just to clarify: I am not too worried about this particular case as we know
>>>> that T-head's implementation predates the Sscofpmf extension.
>>>> But once we define a standard mechanism for this kind of situation, vendor
>>>> may start to abuse it.
>>>
>>> How do you envisage it being abused by a vendor?
>>> Pre-dating the standard extension does make this one fairly clear-cut,
>>> but are you worried about people coming along and claiming to implement
>>> XConorSscofpmf instead of Sscofpmf rather than suffer the "shame" of a
>>> broken implementation?
>>
>> Other than the concern of the ballooning bitmap, I'd prefer this approach.
>> If a vendor has implemented some extension which happens to be "almost
>> Sscofpmf", then whether it was implemented before the Sscofpmf spec
>> existed, or after, isn't really important. What's important is that it's
>> only "almost Sscofpmf" and not _exactly_ Sscofpmf, which means it should
>> not use the Sscofpmf extension name.
> 
> One of the reasons I keep bringing up when things were created prior to
> the creation of Sscofpmf (and I guess the fact that the vendor never
> claims to support Sscofpmf) is to highlight that we are not looking at
> at one of these edge cases where we're only discovering that there's an
> implementation issue on these CPUs that we need to work around silently.
> 
>> Since vendors are allowed to create
>> their own XVendor names, then that shouldn't be a problem. Indeed, the
>> abuse concern seems to be in the opposite direction, that vendors will
>> try to pass off almost-standard extensions as standard extensions by
>> trying to get workarounds into Linux. Maybe Linux policy should be to
>> simply reject workarounds to extensions, requiring vendors to create new
>> names instead.
> 
> I'd be inclined to agree (although there's gonna be some exceptions as I
> mention above) - but it's easy for me to say that given I want people to
> use riscv,isa-extensions on the DT side which cites specific versions of
> extensions that a device is compliant with.
> If people have issues with riscv,isa in DT, I'm can take a bit of a "oh
> it doesn't work with riscv,isa? Tough shit, that's why we made the new
> properties." approach and push people into new names.
> 
> With ACPI, I have absolutely no idea how you police any of that. The way
> the code works rn is that both DT properties and ACPI share the exact
> same extension "names". Obviously it doesn't need to be that way, but it
> is handy. I'm kinda derailing here, but how would we map names to exact
> features in ACPI land? When I last read the ACPI stuff it was very
> non-specific and the kernel documentation
> (Documentation/riscv/acpi.rst) cites a specific version of the ISA
> manual that provides no information (and I guess never will?) about
> vendor extensions.
> 
> 
> 
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv


