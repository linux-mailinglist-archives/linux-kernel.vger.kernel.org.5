Return-Path: <linux-kernel+bounces-108092-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F23378805DA
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 21:08:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 20FF6B214FC
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 20:08:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F190548F3;
	Tue, 19 Mar 2024 20:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="KE5BTj9I"
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A45FE5F86E
	for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 20:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710878893; cv=none; b=u3lrVj4rfc7NSVcDl/5YcCcnEo+Y1JxlE7o+68dgp7Xu8LK7r/nfZnXk9jzKzoEMs/UT/0/LFmPHCAxMTiLPjyDa01pybh7+16hKbw9Zx0NoZ1+AEikDhoFWnpRGxASjuCUgzB0SLLKg8s8shQW4AEvGeT9y+9kmQNuhT9Hy8+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710878893; c=relaxed/simple;
	bh=9djrQ+2UMe3tZMcx42M/B/6OCuBlXdk9od1kXWGXzAk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qGAN5QBAN4ooLdmPa/8gDJDU6LqIhurYhu24dYbwCSCrhx7cBvTyGSuOolctdCk9tQ+54O6+7IuwUTcyEeaeQHkb4wfH6ixXBlBduFjd800kOpwSBFczhSobA1suuEghzTu0u/K83xyUHD9/VWzcpcDPuqaMYhmtaQM2/oTLAew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=KE5BTj9I; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-6e6afb754fcso5694236b3a.3
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 13:08:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1710878889; x=1711483689; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rkJNwgrN4VGR1zn3PD/9c77pYyUa8kTmpK0GxF8tfOI=;
        b=KE5BTj9I/VjsLJgP0orzHxLfEY9Z+d7WWsSgYK32x8lZjNciVo3ADe+7TQSscXPYJv
         1drdYszDQRjwP7BNIczbr0/8juTjPL9HKApVAOKDMc6q/cuEaPSbZHNJYs/VSq/qD3wW
         pulx7Pdmd1/z2MQKFXxDgZJTaUann26f80J7xkm6PkoTyv8KWt+DJNmYB9lk8xYw5md3
         kAdlwLCx6V7jS+8iFTpHF8OuYJFReIA7cv1YjZpT9R9KgUlKKpyAaeKlR9Ide0deu9wt
         nTnYXWyxT8SThxka4QRLXpClIaUTvuUP1oBvlYGjnV2oLZKl7lGhmtL3zHUAKiLPz8D6
         ko4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710878889; x=1711483689;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rkJNwgrN4VGR1zn3PD/9c77pYyUa8kTmpK0GxF8tfOI=;
        b=M8ISi7kgR8A3aaFqbOWlfsOroSvSfXZUUG3sUcQNtvqip8anMDcPsyj0f8Jc3qP2MK
         2N2UL99KDIC//ixxDqx4Quo8Dv0XCSgveAGMWpwOEuy9s7afn38MjPkDbI1buHbDlu7O
         ho2XMeL7tuQIfGMWj5wDNQApmZtBHrTeGbkgHzl4ZbOtwPIhOaHBjOtjETv4C2Wtx0N2
         E4WJ4WYKr6xWKTJDocHBOktygfl08CCUoOc7R4d0xM/iLRMGKeZLawn0Z4UZQGIKAu8F
         lAkOlZKf9mo147oIyCAcIy0A4GbyxFwSiOe5SLlPFXITL34xKveIj1ArYFcn2OM3XFeu
         wqtg==
X-Forwarded-Encrypted: i=1; AJvYcCU8DHzQaVTonCLP/Zma2NT7ECuqCGq9+uAGRDcsouKI8nmk/E+LqtlXForGkbdoupfhUQ9z56HkBJLA9zUacKQyeOcPZ1wWcEXQAcmT
X-Gm-Message-State: AOJu0Yzpr0Gfcwp9T9LP0k/JetjorRkrXCr/A7YoI3HfDdsaqgLNDOk1
	l0qenKecNhy2G2fRIb0eB/T9OiQs/wF3V4KaVVsp7Em0uV4O1QpTLs118uv9qUA=
X-Google-Smtp-Source: AGHT+IFLDgkgB2Z+3MM5ozahctRfYEQK4iTv6Z1gFhsYoXzCN7xONabavfEBjWDcNHY5t6EsiIzgfw==
X-Received: by 2002:a05:6a20:179e:b0:1a1:8c80:4336 with SMTP id bl30-20020a056a20179e00b001a18c804336mr108506pzb.21.1710878889358;
        Tue, 19 Mar 2024 13:08:09 -0700 (PDT)
Received: from ?IPV6:2601:647:4180:9630::546? ([2601:647:4180:9630::546])
        by smtp.gmail.com with ESMTPSA id y1-20020aa793c1000000b006e6795932a4sm10276999pff.80.2024.03.19.13.08.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Mar 2024 13:08:08 -0700 (PDT)
Message-ID: <f7a44b1a-a53e-4a43-aa94-d6fddbed4b81@rivosinc.com>
Date: Tue, 19 Mar 2024 13:08:07 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] perf: RISC-V: fix IRQ detection on T-Head C908
Content-Language: en-US
To: Conor Dooley <conor@kernel.org>, Guo Ren <guoren@kernel.org>
Cc: Andrew Jones <ajones@ventanamicro.com>,
 Inochi Amaoto <inochiama@outlook.com>, Qingfang Deng <dqfext@gmail.com>,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Atish Patra <atishp@atishpatra.org>, Anup Patel <anup@brainfault.org>,
 Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Conor Dooley <conor.dooley@microchip.com>, Heiko Stuebner <heiko@sntech.de>,
 Guo Ren <guoren@kernel.org>, linux-riscv@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20240311063018.1886757-1-dqfext@gmail.com>
 <IA1PR20MB4953ECC3E32E95303872CD14BB242@IA1PR20MB4953.namprd20.prod.outlook.com>
 <CALW65jZ+q8sDiRKgsRL9n+939HNUCnkKuO=YJjHB5Js=WYQeOg@mail.gmail.com>
 <20240312-evil-resource-66370b68b9b4@spud>
 <IA1PR20MB4953CE8999960BA71B46DE6CBB2A2@IA1PR20MB4953.namprd20.prod.outlook.com>
 <20240315-73aa13079ef83a4559869084@orel>
 <2de56d8b-bc78-428b-9c09-4729b269fa41@rivosinc.com>
 <20240318-such-animal-bf33de12dc3a@spud>
 <4bdaaff1-13ec-48c2-b165-6a8255784aef@rivosinc.com>
 <20240319-worry-video-66589b3ed8ae@spud>
From: Atish Patra <atishp@rivosinc.com>
In-Reply-To: <20240319-worry-video-66589b3ed8ae@spud>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/19/24 02:06, Conor Dooley wrote:
> On Mon, Mar 18, 2024 at 05:48:13PM -0700, Atish Patra wrote:
>> On 3/18/24 16:48, Conor Dooley wrote:
>>> On Mon, Mar 18, 2024 at 03:46:54PM -0700, Atish Patra wrote:
> 
>>>> For 2.b, either we can start defining pseudo extensions or adding
>>>> vendor/arch/impid checks.
>>>>
>>>> @Conor: You seems to prefer the earlier approach instead of adding the
>>>> checks. Care to elaborate why do you think that's a better method compared
>>>> to a simple check ?
>>>
>>> Because I don't think that describing these as "errata" in the first
>>> place is even accurate. This is not a case of a vendor claiming they
>>> have Sscofpmf support but the implementation is flawed. As far as I
>>> understand, this is a vendor creating a useful feature prior to the
>>> creation of a standard extension.
>>> A bit of a test for this could be "If the standard extension never
>>> existed, would this be considered a new feature or an implementation
>>> issue". I think this is pretty clearly in the former camp.
>>>
>>
>> So we have 3 cases.
>>
>> 1. Pseudo extension: An vendor extension designed and/or implemented before
>> the standard RVI extension was ratified but do not violate any standard
>> encoding space.
>>
>> 2. Erratas: An genuine bug/design issue in the expected behavior from a
>> standard RVI extension (including violating standard encoding space)
>>
>> 3. Vendor extension: A new or a variant of standard RVI extension which is
>> different enough from standard extension.
>>
>> IMO, the line between #2 and #1 may get blurry as we going forward because
>> of the sheer number of small extensions RVI is comping up with (which is a
>> problem as well).
> 
> Aye, I think some of that is verging on ridiculous.
> 
>> Just to clarify: I am not too worried about this particular case as we know
>> that T-head's implementation predates the Sscofpmf extension.
>> But once we define a standard mechanism for this kind of situation, vendor
>> may start to abuse it.
> 
> How do you envisage it being abused by a vendor?
> Pre-dating the standard extension does make this one fairly clear-cut,
> but are you worried about people coming along and claiming to implement
> XConorSscofpmf instead of Sscofpmf rather than suffer the "shame" of a
> broken implementation?

Yes or just use this excuse continue their old implementation in a newer 
chip which was designed after the standard extension is ratified.


> All this stuff is going to be pretty case-by-case (to begin with at
> least) so I'm not too worried about that sort of abuse.
> 
>>> I do not think we should be using m*id detection implementations of a
>>> feature prior to creation of a standard extension for the same purpose.
>>> To me the main difference between a case like this and VentanaCondOps/Zicond
>>> is that we are the ones calling this an extension (hence my use of pseudo)
>>> and not the vendor of the IP. If T-Head were to publish a document tomorrow
>>> on the T-Head github repo for official vendor extensions, that difference
>>> would not even exist any longer.
>>>
>>
>> Exactly! If vendor publishes these as an extension or an errata, that's a
>> binding agreement to call it in a specific way.
> 
> I don't agree that we are bound to call it the way that the vendor does.
> We should just review these sorts of things on a case-by-case basis,
> committing to doing what the vendor says is abusable.
> 
>>> I also do not believe that it is a "simple" check. The number of
>>> implementations that could end up using this PMU could just balloon
>>> if T-Head has no intention of switching to Sscofpmf. If they don't
>>> balloon in this case, there's nothing stopping them ballooning in a
>>
>> Ideally, they shouldn't as it a simple case of CSR number & IRQ number.
>> If they care to implement AIA, then they must change it to standard sscofpmf
>> as the current IRQ violates the AIA spec. But who knows if they care to
>> implement AIA or not.
> 
> What kinda "worried" me here is that the c908 implements /both/ Zicbom
> and the T-Head CMO instructions and /both/ Svpbmt and their original
> misuse of the reserved bits but they do not support Sscofpmf. Maybe it
> just was not feasible to migrate entirely (but they did for vector) or
> to support both interrupt numbers and to alias the CSR, but it seemed
> like the opportunity to standardise a bunch of other stuff was taken,
> but this particular extension was not. That's why I was worried that
> we'd see some ballooning in these specific checks.
> 


This is the exact abuse I was talking about. A vendor can keep churning 
new chips with incompatible extensions because Linux just allowed them 
get away with it by calling it a Vendor Extension.

+Guo: In case he has any insight behind this decision from Thead.

>>> similar case in the future. We should let the platform firmware tell
>>> explicitly, be that via DT or ACPI, what features are supported rather
>>> than try to reverse engineer it ourselves via m*id.
>>>
>> Fair enough.
>>
>>
>>> That leads into another general issue I have with using m*id detection,
>>> which I think I have mentioned several times on the list - it prevents the
>>> platform (hypervisor, emulator or firmware) from disabling that feature.
>>>
>>
>> If that is the only concern, platform can just disable the actual
>> extension(i.e. sscofpmf in this case) to disable that feature for that
>> particular vendor.
> 
> Right. Maybe I wasn't clear that this is a problem with using m*id for
> /detection/ of extensions and not with using m*id to work around
> implementation issues with the extension. In the latter case, you're
> applying a fixup only when the actual extension is communicated to be
> present, which leaves that control in the hands of the platform.
> 

Hmm. I guess there is no way predict how vendors will include standard 
extensions. Let's give them a benefit of doubt hoping they realize 
abusing the system won't help anybody. They will try to adopt the 
standard extensions if it is possible and creates erratas for genuine 
problems.

>>> If I had a time machine back to when the T-Head perf or cmo stuff was
>>> submitted, I was try to avoid any of it being merged with the m*id
>>> detection method.
>>>
>>>> I agree that don't have the crystal ball and may be proven wrong in the
>>>> future (I will be definitely happy about that!). But given the diversity of
>>>> RISC-V ecosystem, I feel that may be our sad reality.
>>>
>>> I don't understand what this comment is referring to, it lacks context
>>> as to what the sad reality actually is.
>>>
>>> I hope that all made sense and explained why I am against this method
>>> for detecting what I believe to be features rather than errata,
>>> Conor.
>>>
>>
>> Yes.Thanks again for the clarification. Again, I am not opposed to the idea.
>> I just wanted to understand if this is the best option we have right now.
>>
>> _______________________________________________
>> linux-riscv mailing list
>> linux-riscv@lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-riscv


