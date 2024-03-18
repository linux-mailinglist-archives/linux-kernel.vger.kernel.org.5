Return-Path: <linux-kernel+bounces-106765-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 676DD87F33F
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 23:47:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D3BA61F21563
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 22:47:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBF545A799;
	Mon, 18 Mar 2024 22:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="lZL97Ian"
Received: from mail-oo1-f50.google.com (mail-oo1-f50.google.com [209.85.161.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FA645A7B1
	for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 22:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710802020; cv=none; b=XCbbrbnhyenoDZqUoZ3uKf4rO0YKOXb2TC7m0AsTCX1u+yBv3oyL+AI8us2h46VFjU3IEAXddvU0t0fyMX4JWk8cviu3N4w3JXriOe1jXZyjc8g4VIEHkX0qEbvWlGd7UlMDUE8fSmfQ7EzP7v8m/0au5oKaZICol1d2MdY6REw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710802020; c=relaxed/simple;
	bh=gC5JZY2Pkww+xLInQHuOdSzKcBznebXtLZEluABsc/g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=g7d2+5FYBpr5wltdWp2q5yY9P4FQJCT5HhJy8Ng54bXvQpQ2bI1tsGbqJ4lkv77zkC8Cnek844sJj3rPQTzXKVd95/714A3JsFLSVsNMcGnPHgdkUBxmSy2yC9i7j8Q33ED+zjCCEMZ2FT1N7/a0NDyg0nFQdG0Wkqg2jSUVRtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=lZL97Ian; arc=none smtp.client-ip=209.85.161.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-5a467dae51dso1587327eaf.1
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 15:46:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1710802017; x=1711406817; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5Hl7mzFXoKsnD5jNzAKhdfpCR878Iekflp3ULzor2TY=;
        b=lZL97IanPWa1M+JCWZGzhhG+7POAKuc3dcbFi6xOZ9CquIEduVReO1YyO2RSC6cRbZ
         86ZDokidCA2fox1MwDfQUgpMts2gIig09VTNa0x0KHSUso6BT+kY7LVdwMOfpha0j6Ah
         9vA3coibDn7/kcGx3xOeiInMXJ29d0tkYsvh24N+1vOEIMd7ew+p+6QgwzT7gF3R8ss8
         hLBqJ6qUd2pKW+Qfd3PS6WxV26T4QTw+0ym6PnkwnbSZmhFf9lu9xrLHWrGovMIF/pP8
         h/Ms08RHoGjiXJHYdkhTaSIx42rfzfmbMTxDQ5jhBbxtYCcKoZWvuC5k6MxgSPIGTC8n
         4o6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710802017; x=1711406817;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5Hl7mzFXoKsnD5jNzAKhdfpCR878Iekflp3ULzor2TY=;
        b=c78N8moReRtQ9fNz6nJpRfpuvkJ2aW0beYJxwZuEAytscS1fbTcT9Pbc8EYjtuisIz
         rwVdSP+DArZ76qzU95NGEf+YKqtrBzOW0rPR5NqqKyVdf/d5BZEMC65bIPVQh2458dNW
         tVoQPk7U8oE8iRO46dLjrvY9I9InT54Y7oJsoEvlxRnmby/Tgn63gt2Xrc2Tr4FdZGJT
         dJptEaSCVk2VM4QqLQv1clOXPJrgGKYVxwCEhMi6qMiUx+pfsdz+9mBeLq7f6UX/l52T
         5p6K2StbKdz/aOW9M/+LCiyRfATtkVyjm88oRLUCll3kBKD1SmV0h3QfXF6K61qGZYQm
         AcoQ==
X-Forwarded-Encrypted: i=1; AJvYcCXC0dAusxzhFTWVYL8nmW+BWiO1qxux20KCLpShI/JL0Y6IBiio8SXyOE6wPpO5Kg6hM3I+p1b1/C0nS2otjwcum9Are3OAOmI6/r/w
X-Gm-Message-State: AOJu0YwKT8wjzCVddFGYlbMX+SLR+s45gWrZg59pQis5oqffZUQZc8+a
	SEatCAFi4/5pYrdrN3Rt6uL2R4AFV0Phd+YYyXYt7X0V884RXRGQp5IjnPtMedw=
X-Google-Smtp-Source: AGHT+IHnE/sjSgzIeAoLFARhPO6yyilH56PIXsstvtejzJrYAKM5eet1GCCHHu8wfL5/gLzL4gZWhw==
X-Received: by 2002:a05:6358:726:b0:17e:b7a0:2ecd with SMTP id e38-20020a056358072600b0017eb7a02ecdmr1071084rwj.0.1710802017033;
        Mon, 18 Mar 2024 15:46:57 -0700 (PDT)
Received: from ?IPV6:2601:647:4180:9630::546? ([2601:647:4180:9630::546])
        by smtp.gmail.com with ESMTPSA id z13-20020aa785cd000000b006e5597994c8sm8485049pfn.5.2024.03.18.15.46.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Mar 2024 15:46:56 -0700 (PDT)
Message-ID: <2de56d8b-bc78-428b-9c09-4729b269fa41@rivosinc.com>
Date: Mon, 18 Mar 2024 15:46:54 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] perf: RISC-V: fix IRQ detection on T-Head C908
Content-Language: en-US
To: Andrew Jones <ajones@ventanamicro.com>,
 Inochi Amaoto <inochiama@outlook.com>
Cc: Conor Dooley <conor@kernel.org>, Qingfang Deng <dqfext@gmail.com>,
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
From: Atish Patra <atishp@rivosinc.com>
In-Reply-To: <20240315-73aa13079ef83a4559869084@orel>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/15/24 01:11, Andrew Jones wrote:
> On Wed, Mar 13, 2024 at 09:31:26AM +0800, Inochi Amaoto wrote:
> ...
>> IMHO, it may be better to use a new DT property like "riscv,cpu-errata" or
>> "<vendor>,cpu-errata". It can achieve almost everything like using pseudo
>> isa. And the only cost I think is a small amount code to parse this.
>>
> 
> What's the ACPI equivalent for this new DT property? If there isn't one,
> then the cost is also to introduce something to the ACPI spec and add the
> ACPI parsing code.
> 
> I'd much rather we call specified behaviors "extensions", whether they
> are vendor-specific or RVI standard, and then treat all extensions the
> same way in hardware descriptions and Linux. It'd also be best if errata
> in extension implementations were handled by replacing the extension in
> the hardware description with a new name which is specifically for the
> behavior Linux should expect. (Just because two extensions are almost the
> same doesn't mean we should say we have one and then have some second
> mechanism to say, "well, not really, instead of that, it's this". It's
> cleaner to just remove the extension it doesn't properly implement from
> its hardware description and create a name for the behavior it does have.)
> 
> Errata in behaviors which don't have extension names (are hopefully few)
> and are where mvendorid and friends would need to be checked, but then why
> not create a pseudo extension name, as Conor suggests, so the rest of
> Linux code can manage errata the same way it manages every other behavior?
> 
> The growth rate of the ISA bitmap is worth thinking about, though, since
> we have several copies of it (at least one "all harts" bitmap, one bitmap
> for each hart, another one for each vcpu, and then there's nested virt...)
> We don't have enough extensions to worry about it now, but we can
> eventually try partitioning, using common maps for common bits, not
> storing bits which can be inferred from other bits, etc.

This is my biggest worry going forward. We already have a ever growing 
standard RVI extension list. On top of that we have genuine vendor 
extensions. IMHO, errata are bit different than extensions as there will 
be few vendor extensions in the future but many hardware erratas :)
If we start calling every hardware errata as an pseudo ISA extensions, 
we will much bigger problem maintaining it in the future.

We discussed this earlier during the Andes PMU extension series[1] as 
well. We have three types of extensions in discussions now.

1. standard RVI extensions
2. Vendor extensions
	a. Genuine vendor extension
	b. Vendor erratas which can be described as pseudo-extensions now

Keeping all these within a single ISA bitmap space seems very odd to me.
I think the feasible approach would be to partition the standard and 
vendor ISA extension space as you suggested.


For 2.b, either we can start defining pseudo extensions or adding 
vendor/arch/impid checks.

@Conor: You seems to prefer the earlier approach instead of adding the 
checks. Care to elaborate why do you think that's a better method 
compared to a simple check ?


I agree that don't have the crystal ball and may be proven wrong in the 
future (I will be definitely happy about that!). But given the diversity 
of RISC-V ecosystem, I feel that may be our sad reality.


[1] 
https://lore.kernel.org/linux-riscv/20240110073917.2398826-8-peterlin@andestech.com/

> 
> Thanks,
> drew
> 
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv


