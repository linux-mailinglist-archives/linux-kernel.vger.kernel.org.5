Return-Path: <linux-kernel+bounces-118300-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 120EC88B770
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 03:32:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8784E28F7AB
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 02:32:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33694128378;
	Tue, 26 Mar 2024 02:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="l5wKBdcD"
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5C5C128379
	for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 02:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711420365; cv=none; b=ZqJVGNnmQKsmZ3fCQZEFZTmFlQ9G2uEnq7R9RmzLsr56A/eZi0bLMWCIUOqHulgt0JvWmPk7AFMyQ6tIbSKLIydCZhHDSDf9PB1/MjSG8Of/J9pGAT/aVgPkxH+FLkyHIi2i8J0N7XQTyHNID7LYlzHCCN/EDuKN2jYq2CoO3IU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711420365; c=relaxed/simple;
	bh=5+0SRS3qXOlLrorhqDFUncDkN0EVo5ZK5AtxDtwWqp8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Y00KTPCCp/Wr/u78Wsf1E06VtEZ4aHXxL1Ovb2ds9GcUGaJCVmqtL+FmHNy6ceKgcIC8+ymKzR5lhyueFdZtkieo7dGu4vnjJOxGh64Xn7PRBEOF4dAKtkSbUpFfHOUMUzCepT83FpiyNkGEjsYbY2UjjlONgja4uJ8a8n1qz/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=l5wKBdcD; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-60a068e26d8so56566717b3.3
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 19:32:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1711420363; x=1712025163; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=D3TJqEDfvZDpiO+inDD3t7IOFIESs7RQEPRehNhXH0Y=;
        b=l5wKBdcDlQ8tBTbmsYRujBl16hnFFsejqsWUu4t5prwWTo5762Y/a/HJ+VUqTEtYyb
         v0I8/fpmuSkNwVJXk6D02d93xKo2Eln0YU24dAZCqICcPKbP8CJRBK5CIKgjZYEHstnZ
         E61y7RxhnboFGppfXGSTiToCf0XxTHqJXjmQDAa+vPxNhiMDim8RclroBALvLBR+Ycmk
         pt/YF1RCjUg5c/UrJsEDX/YlyIGdHNCkz8SkHf8adhj1gVsZwe7WpOifmbAtU2w/XHP5
         xprIzcbVsyArA8+hcYGSEUFSEoDA3c+nIVBEcTBUC/bFp4VhgoXVpaH9XND13G0DwLeK
         RDYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711420363; x=1712025163;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=D3TJqEDfvZDpiO+inDD3t7IOFIESs7RQEPRehNhXH0Y=;
        b=TLjv9JBl9nlJwgb1Iknj1W3ZIDJmY6kNMZUeHkmcM9Hcaz1APQRqPFMEDZJ4GOdJcH
         dQJYMZFgXDTkIhkNYURveSw+vJAcBmTNQRS1iWRXbWEypTjOW8NzmojhLiNkWJcN2C1T
         +/lVzrPtZJzB70k46x8JNWbgbwjAvLYbo9cyG0RnY0Th1TH49E3ZoPxuSQ1HdeZLkUQV
         BxbzM1+xeumB0hAd2pYTVqHY+p1Bt4ozDQBDQ60+A1du2mJq53THjElLXoaqwVQnnqkh
         r0YUG5kTCkxPq9lSraYeNzC7Qm6zVzSQxNC0lx1Ng7N8NHFH/rFsFnTQRcT3SxbrjDF7
         fbhA==
X-Forwarded-Encrypted: i=1; AJvYcCXHUN8Mm+EkZZ46FGatvxLeL1EuZfwUIorl1vvC45GERevsv6sAm8ait9Pm7ABrMMlO3fU+3GOpl11ooytBSQmVZbt8X0zej3m1oLNo
X-Gm-Message-State: AOJu0YytZkq3DGADMzrzeTgAMnexGfT/byDfxfQr133uq8uXmh1S+3ES
	7rN8hhKUBW5r5fNAdSTWjdr0YBft4/dER17gQHT1khVWwNK0LKrRaF21FKlACsA=
X-Google-Smtp-Source: AGHT+IFpMRArRaXwHydUZLSvKndg2HWnCWbXGNLRVPG13dZ5KSxLwFXxZjOAnDNM2h6lSP0p5FmQNA==
X-Received: by 2002:a81:7704:0:b0:609:f87b:aad3 with SMTP id s4-20020a817704000000b00609f87baad3mr7200636ywc.31.1711420362724;
        Mon, 25 Mar 2024 19:32:42 -0700 (PDT)
Received: from [100.64.0.1] ([136.226.86.189])
        by smtp.gmail.com with ESMTPSA id x8-20020a026f08000000b0047921fd1201sm2540917jab.150.2024.03.25.19.32.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Mar 2024 19:32:42 -0700 (PDT)
Message-ID: <ea79a27b-43b6-4b6e-9ec5-621e96b97f87@sifive.com>
Date: Mon, 25 Mar 2024 21:32:41 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] riscv: nommu: remove PAGE_OFFSET hardcoding
To: Jisheng Zhang <jszhang@kernel.org>, Bo Gan <ganboing@gmail.com>
Cc: Paul Walmsley <paul.walmsley@sifive.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Thomas Gleixner <tglx@linutronix.de>, linux-riscv@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20240325164021.3229-1-jszhang@kernel.org>
 <20240325164021.3229-2-jszhang@kernel.org>
 <37d456c1-f0bd-1a78-2d0c-350ca25c6b8d@gmail.com> <ZgIk2hmprnyGr_ce@xhacker>
Content-Language: en-US
From: Samuel Holland <samuel.holland@sifive.com>
In-Reply-To: <ZgIk2hmprnyGr_ce@xhacker>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2024-03-25 8:28 PM, Jisheng Zhang wrote:
> On Mon, Mar 25, 2024 at 03:46:01PM -0700, Bo Gan wrote:
>> On 3/25/24 9:40 AM, Jisheng Zhang wrote:
>>> Currently, PAGE_OFFSET is hardcoded as 0x8000_0000, it works fine since
>>> there's only one nommu platform in the mainline. However, there are
>>> many cases where the (S)DRAM base address isn't 0x8000_0000, so remove
>>> the hardcoding value, and introduce DRAM_BASE which will be set by
>>> users during configuring. DRAM_BASE is 0x8000_0000 by default.
>>>
>>> Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
>>> ---
>>>   arch/riscv/Kconfig | 8 +++++++-
>>>   1 file changed, 7 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
>>> index 7895c77545f1..afd51dbdc253 100644
>>> --- a/arch/riscv/Kconfig
>>> +++ b/arch/riscv/Kconfig
>>> @@ -247,10 +247,16 @@ config MMU
>>>   	  Select if you want MMU-based virtualised addressing space
>>>   	  support by paged memory management. If unsure, say 'Y'.
>>> +if !MMU
>>> +config DRAM_BASE
>>> +	hex '(S)DRAM Base Address'
>>> +	default 0x80000000
>>> +endif
>>> +
>>>   config PAGE_OFFSET
>>>   	hex

Another option would be to change this to:

  hex "DRAM Base Address" if !MMU

so the prompt is only visible for NOMMU, but we don't need a new symbol.

>>>   	default 0xC0000000 if 32BIT && MMU
>>> -	default 0x80000000 if !MMU
>>> +	default DRAM_BASE if !MMU
>>>   	default 0xff60000000000000 if 64BIT
>>>   config KASAN_SHADOW_OFFSET
>>>
>>
>> Thanks for this patch. I did something similar in my local nommu
>> linux-6.8 tree in order to run it on the S7 hart of JH7110. I have
>> another suggestion for you. Perhaps we should also make TASK_SIZE
>> configurable, and let it default to `0xffffffff if 32BIT && !MMU`
>> and `DRAM_BASE + DRAM_SIZE if 64BIT && !MMU`. Currently TASK_SIZE
>> is effectively `0xffffffff if !MMU`, which doesn't work if I run
>> rv64 linux-nommu with DDR that spans across 4G boundary.
> 
> I must admit that there's such nommu linux with 4GB DDR case in
> theory, but it doesn't exist in real world: who will make such
> strange platform ;) But anyway this improvement can be made when
> the patchset talking about TASK_SIZE_MAX is settled down.

This case is quite easy to hit with QEMU :) In fact I sent a patch making this
exact change:

https://lore.kernel.org/linux-riscv/20240227003630.3634533-2-samuel.holland@sifive.com/

It's not really related to TASK_SIZE_MAX. access_ok() is a no-op on NOMMU,
because you can't prevent userspace from poking the kernel anyway.

Regards,
Samuel


