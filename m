Return-Path: <linux-kernel+bounces-71839-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1DE885AB5C
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 19:45:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D785D1C21CEB
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 18:45:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF60C45C04;
	Mon, 19 Feb 2024 18:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="jnsqGY4g"
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55FD6F9E0
	for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 18:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708368351; cv=none; b=CJNwQnoyrjigPO2pkjoM4/BuTvy5sxWmeP5YJ0scPHGZpC2sidd4VU1JbhGideoOzF0f92PpUnxfwSAVWMHtb9/SIYjg4mkBIZ51bnpoda4Imfd3awIuhCnf/JS2VaOdfPC5EQcW/YO0Z09ET/0n+hhZHj9MpbozYDew0vM/1r0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708368351; c=relaxed/simple;
	bh=kdcE/6CCzhJJnH+KggFm8+C+EXYKnGBXBKohJ8u9N+k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=chziLB8n+FBrKDzHGbr5N0av11uGO4sYEvmEVY0t2NgyZrPI679+9zQ/H16jfcSrDr3pGwIwXgsiNuST0QAV6YvTrbPGsdG+vusK0Le0uikXDCsjpjLGZTRjKsh6DyqdFx7mQ0ckiEQZhnMmScDkQIjIdSkkdTn9hKkCb+AGb4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=jnsqGY4g; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-33d4c0b198aso693316f8f.2
        for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 10:45:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1708368347; x=1708973147; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KWwwxgG2OB0SooVYwQHE8K610yUTtlrZSvRyhvzFtc4=;
        b=jnsqGY4gI01OhlA5g/ucgxbuhuPyVtfjhjXMNRhIDIy1oquw8omrB1ZCTdCiWSNzcV
         v/k52Aa7PjMqm6s1L67tTeiMbvhlcRxLs1PHWUU4RRBk2nV13AsXxhS1Wz4K/Ra97tvL
         YogymnxsZTrI2xAx+6Etp2iMVLsN99FVpYd9g0+h/Rf3DG5cV2+i4Pa5ThiDYpxPP/7L
         P6XA4Ym0pqar6F9RwWPTHOwuT2CUZUZAMvllSBOf+U+tVyFT+yb/Dg/KlYrTiV0nTBRV
         nAxXPw17NWK88cIFOWXOVGOoS+fR5+TeaAdS31QNH962BKRO7rNlMpzRibyXy5IPrVSb
         QP7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708368347; x=1708973147;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KWwwxgG2OB0SooVYwQHE8K610yUTtlrZSvRyhvzFtc4=;
        b=I8AbH25EzjbDnCOUk6VUfs8ZJbaykro3gjLOdeZ5LV4z0chnVzy3ydI9qom7ar3tdU
         V4kLhDaMsslUv5rQmMQ/NF2ExrfE17wKhPaGHMAoULmWuyjkGdjpix6aRqNbS0I2dDto
         CCqGBDqTfTDllL90zlbUq/zzSNicZogo30OOuQ2SrrBVAvtCVJUuAKq9UHTkrP7ZRlbm
         Grqff03q4wVFBvn1CXy1TllMACrfaCEdU09rAYuH43cyn5tDNwT8WGpw2ng2hgGQnJTk
         kKR+FmOyWKpHHdhWLt9t9J1ldVgrz20M0KPoKzJ4Hi3kkv0KxYIgWF6uYaMR+4GE43vK
         bFHQ==
X-Forwarded-Encrypted: i=1; AJvYcCXTG1vUYd+kTuEmaHXSbF39Pt9Weg7PknEtGBo/jQM6HQ95fArYR9RvX58p8z6m6ubcNcZk66tX4mWRxlOdH+gfBvvhqbUR/JXViqhl
X-Gm-Message-State: AOJu0YyMdD9yw2yKL9UIU+GgG/eX3Nz7KOCP6J7nXPF1vTu5RRV+jK23
	ocproCvCMdWfJdRaOPt3T6RFloL71iLYzXZTnutbhL8bBZbYoq76z9N8Zl0Ct9s=
X-Google-Smtp-Source: AGHT+IEzJnyqvoY0JTUvduENa+etFLCkIQypaWXWPboZkbdJX7MkthlOevIHC/FsEXpsfEuDyJDxBQ==
X-Received: by 2002:a5d:47a9:0:b0:33d:3a06:acbc with SMTP id 9-20020a5d47a9000000b0033d3a06acbcmr4406975wrb.70.1708368347556;
        Mon, 19 Feb 2024 10:45:47 -0800 (PST)
Received: from [192.168.50.4] ([82.78.167.20])
        by smtp.gmail.com with ESMTPSA id q4-20020a5d5744000000b0033b47ee01f1sm11071728wrw.49.2024.02.19.10.45.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Feb 2024 10:45:46 -0800 (PST)
Message-ID: <0798f21e-1ab6-4fd2-b7e3-18f35163fad1@tuxon.dev>
Date: Mon, 19 Feb 2024 20:45:45 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/3] ARM: dts: microchip: sama7g5: Add flexcom 10 node
Content-Language: en-US
To: Conor Dooley <conor.dooley@microchip.com>
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Mihai.Sain@microchip.com, conor@kernel.org, robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 Nicolas.Ferre@microchip.com, andre.przywara@arm.com,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, Cristian.Birsan@microchip.com
References: <20240215091524.14732-1-mihai.sain@microchip.com>
 <20240215091524.14732-3-mihai.sain@microchip.com>
 <20240215-lustily-flick-69cb48b123c3@spud>
 <PH8PR11MB6804E9353A8EEBD2B829D8B3824C2@PH8PR11MB6804.namprd11.prod.outlook.com>
 <20240216075609e58aeee4@mail.local>
 <cfafd563-1387-4775-bcb0-434ce3774827@tuxon.dev>
 <20240216-eleven-exposure-dde558e63aaf@wendy>
From: claudiu beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <20240216-eleven-exposure-dde558e63aaf@wendy>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 16.02.2024 11:35, Conor Dooley wrote:
> On Fri, Feb 16, 2024 at 10:24:13AM +0200, claudiu beznea wrote:
>> On 16.02.2024 09:56, Alexandre Belloni wrote:
>>> On 16/02/2024 06:58:10+0000, Mihai.Sain@microchip.com wrote:
>>>>> diff --git a/arch/arm/boot/dts/microchip/sama7g5.dtsi b/arch/arm/boot/dts/microchip/sama7g5.dtsi
>>>>> index 269e0a3ca269..c030b318985a 100644
>>>>> --- a/arch/arm/boot/dts/microchip/sama7g5.dtsi
>>>>> +++ b/arch/arm/boot/dts/microchip/sama7g5.dtsi
>>>>> @@ -958,6 +958,30 @@ i2c9: i2c@600 {
>>>>>  			};
>>>>>  		};
>>>>>  
>>>>> +		flx10: flexcom@e2820000 {
>>>>> +			compatible = "atmel,sama5d2-flexcom";
>>>>
>>>> My comment here was ignored:
>>>> https://lore.kernel.org/all/20240214-robe-pregnancy-a1b056c9fe14@spud/
>>>>
>>>> The SAMA7G5 has the same flexcom controller as SAMA5D2 MPU.
>>>>
>>>
>>> Still, it needs its own compatible plus a fallback to
>>> atmel,sama5d2-flexcom
>>
>> I agree with this. Though, flexcom documentation is subject to YAML
>> conversion (a patch has been re-posted these days [1] and *maybe* it will
>> be integrated this time). And there are multiple SoC DTs that need to be
>> updated with their own flexcom compatible (lan966x, sam9x60, sama7g5).
>>
>> To avoid conflicting with the work at [1] and postponing this series we may
>> do the update after the [1] is done.
>>
>> Let me know your thoughts. Either way is fine by me.
> 
> I'd be inclined to say that if we are gonna take a shortcut here, then
> this patch should add a specific compatible so that when the yaml
> conversion goes through you'll get a warning about this being
> undocumented rather than silence.

All the flexcom nodes from all flexcom capable SoCs (including SAMA7G5)
have the same compatible introduced by Mihai.

I don't like the idea of updating only the DTSes, either update all DTSes
and documentation or do it as it is already done (with sama5d2 compatible).

> 
> A resend on the flexcom patch is required though, the rebase was not
> done correctly, so maybe Balakrishnan could "atmel,sama7g5-flexcom"
> add with a fallback to "atmel,sama5d2-flexcom" while they're fixing
> it up?

I agree, and DTSes should also be updated along with documentation.

With this we can go forward with this patch and avoid conflicting with work
that is currently in progress for flexcom.

Thank you,
Claudiu Beznea

> 
> Cheers,
> Conor.

