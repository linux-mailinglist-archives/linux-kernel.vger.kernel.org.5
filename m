Return-Path: <linux-kernel+bounces-103944-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9839A87C6DB
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 01:57:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C4FBA1C2168E
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 00:57:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E43510F7;
	Fri, 15 Mar 2024 00:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BMFQBwdq"
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F1096FAF
	for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2024 00:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710464247; cv=none; b=UeyMJgV9pqef4NJ1w9G3UHyoZ91RPG8728OVrs6J6QQS402+KecWMY2HYEZjR8qC7DTyaHEXj+ZyHfKpyukHaBuiH7DgCPF02jwwqzYmihXR4o+OcWXmGSgG3vZwzU//RcKH0eHYnwvxYDVOKOvRjgMYzRS4gG89ml8J3zoIzH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710464247; c=relaxed/simple;
	bh=t7tpvjTyyVWqtKCRJwk851OtDCLJaW85M2oyBwk1ir4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MrG2PzWIUXQEZbNE14h/q9IgoSN+hmTDZBXBBMYMG9G7o0flujI3O91rd//8xdBUEHIH2ttNOkZ2Xym+xgw9rngXUF3ni9HmpBMgpF0mFZD2CYCeF6kI5yS0wE9pUzkOOnrEmy5ttsRAAO2XfpZw4fle8ux1P0lDbMG0w2cRbS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BMFQBwdq; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2d46e25d6b9so22893591fa.1
        for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 17:57:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710464244; x=1711069044; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3YQvHoU8cC4gCXgr2fwgid2Bxq5jF5wWHjxN8ZHHlVA=;
        b=BMFQBwdqWY3tTOl9P+2Klb6H5HVAg/sjuT37KCYaJGB7IuIs9CNJm2u5yfSesrNlRF
         YqapXXqaDqwbU0FzLq+TEOl2PTjjMhjmP+7Qc3AA07uUU5JkT64WbZhSuxq04opLOfn+
         LKsepSKCRfk6VeioNbhi1rIBpn1rTO6CG4Aiwf5yXc2rApWJuyrcu2oNzwazDXlClBce
         Bpr/1N8AcGONbBuMfO4dusWzx616oYEto333jEt1xaVgDqpJRwmPt90YRRB4RxG5LQLz
         vvkZKoDdMDq7EPtCCduFb11tPatg9zianndevsxAB07rlPF0E3jpQxMHXzi2e8Eo6M2S
         XpQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710464244; x=1711069044;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3YQvHoU8cC4gCXgr2fwgid2Bxq5jF5wWHjxN8ZHHlVA=;
        b=L9jLV2h0BnpQNJrBP027DoCn4Dce5D65U460PD/3VpEcjJI1ok8fBQZl++0DoKlasL
         0DchUNQp3n1O6gXDdrFtKWkeHK2zGPnqGRD6RpXkUUx2OvKRIig7Ss/s2suUTAmvqijt
         fHaWlK7q3ZTMWxzmc/yNOezSwAkxmsy31U53oRqeGHlwL29252HyyxSFFeKuuCcQMWLM
         fTSLon1plw9UqnP62RukkPOkrTRyDMi1tyDa+jmrVommu1Lx2XAVXQQTea1AsOqk3LXC
         8yWOZAndiWLvDMmZJTVbQNmcR1o/1XSuVYJWvlfAzA+fbC1Fu0uv6M8059EAF4k385Mb
         3Y3w==
X-Forwarded-Encrypted: i=1; AJvYcCVVLW+YMzuC0hsnaczdEutIkxm8u7q/Lcg6yxFdjYiZplhYeGPK+n/KCr0/oY97ujg9Rd/CxTqdEiLhyWPUN77MU3HPi3WABsZ4eTYY
X-Gm-Message-State: AOJu0YycEbvIeZpB9KlNbCkoqgdM2XUdoKQv5d+GwPx38iioJZKWnWMg
	RAaQcKY5gL1fO8Wq4qDd24SGXSKJsgdVI+gI1DaXHqjNOAoguJ13
X-Google-Smtp-Source: AGHT+IFG9YRjURGWHLbrJXEy9Jrdrm0nnYMpTQBt8klQpXf5qqfPpHSEZHGC40NxcJW7f5Jj4qqn/A==
X-Received: by 2002:a05:6512:3284:b0:513:c2e3:226e with SMTP id p4-20020a056512328400b00513c2e3226emr1486799lfe.8.1710464243594;
        Thu, 14 Mar 2024 17:57:23 -0700 (PDT)
Received: from [192.168.100.117] (89-76-44-138.dynamic.chello.pl. [89.76.44.138])
        by smtp.gmail.com with ESMTPSA id g12-20020a17090613cc00b00a45de7c83efsm1182229ejc.61.2024.03.14.17.57.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Mar 2024 17:57:23 -0700 (PDT)
Message-ID: <bb9f1f58-67f1-49cb-aede-046ec6258ff1@gmail.com>
Date: Fri, 15 Mar 2024 01:57:21 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] dts: arm64: sunxi: add initial support for t95 tv box
Content-Language: pl
To: =?UTF-8?Q?Jernej_=C5=A0krabec?= <jernej.skrabec@gmail.com>,
 Andre Przywara <andre.przywara@arm.com>
Cc: wens@csie.org, samuel@sholland.org, linux-arm-kernel@lists.infradead.org,
 linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20240311174750.6428-1-ressetkk@gmail.com>
 <8344274.T7Z3S40VBb@jernej-laptop>
 <55eda2c6-1bca-463d-a908-1887543a47a5@gmail.com>
 <4331305.ejJDZkT8p0@jernej-laptop>
From: Kamil Kasperski <ressetkk@gmail.com>
In-Reply-To: <4331305.ejJDZkT8p0@jernej-laptop>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

W dniu 14.03.2024 o 17:50, Jernej Škrabec pisze:
> Dne četrtek, 14. marec 2024 ob 01:19:28 CET je Kamil Kasperski napisal(a):
>> Hi Jernej, Andre!
> Please no top posting as per rules.

Sure. I'm not used to this kind of work, so please bear the mistakes I make.

>
>> Thanks for the reply. My board has a name "H616-T95MAX-AXP313A-v3.0".
> Ok, we for sure need to integrate this somehow to compatible string, since
> there are at least two incompatible versions.

It's good idea to introduce dtsi with common configuration for both boxes and add 2 new dts files with compatible string
"t95,t95max-axp313" and "t95,t95max-axp305" with separate PMIC configuration. Similarly as OrangePI Zero got handled.

Not to mention, that it looks like arch/arm64/boot/dts/allwinner/sun50i-h618-transpeed-8k618-t.dts also has very similar configuration to my T95 box. Question is should we mix up the compatible strings for SoC?
I know that H616 and H618 are almost identical SoCs, but if it's not only a matter of documentation it's still better idea to push new dts.

Best Regards,
Kamil

>> I believe these boards are two different revisions and the one with 
>> AXP313A is a newer one, besides incorrectly label as v3.0. Sharing 
>> common configuration between boxes is also a good idea but for this 
>> specific configuration I would be cautious. From my experience with this 
>> board the default configuration for X96 Mate is not working at all. I 
>> suspect because of the PMIC and DRAM differences.
>>
>> Memory installed in X96 Mate is DDR3L and in mine T95 it's DDR3, hynix 
>> H5TQ2G43BFR, that requires 1.5V to operate.
> PMIC is important difference, yes, but not DRAM. DDR3L is completely compatible
> with DDR3. It just additionally supports lower voltages. Additionally, Linux
> doesn't care about DRAM type and all. It's firmware responsibility to properly
> initialize it.
>
> Best regards,
> Jernej
>
>> The rest of configuration for both boards, like HDMI, MMC, EPHY and 
>> audio codec seems to be the same across almost all H616-based boxes that 
>> I've researched.
>>
>>
>> Moreover please let me update the patches and send v2 that aligns with 
>> mainline branch. I've incorrectly assumed to use sunxi fork instead of 
>> master. Sorry!
>>
>> W dniu 13.03.2024 o 19:00, Jernej Škrabec pisze:
>>> Dne sreda, 13. marec 2024 ob 18:38:08 CET je Andre Przywara napisal(a):
>>>> On Wed, 13 Mar 2024 18:25:14 +0100
>>>> Jernej Škrabec <jernej.skrabec@gmail.com> wrote:
>>>>
>>>>> Hi Kamil!
>>>>>
>>>>> Dne ponedeljek, 11. marec 2024 ob 18:47:47 CET je Kamil Kasperski napisal(a):
>>>>>> T95 is a most commonly known for being a box with a pre-installed malware.
>>>>>> It uses Allwinner H616 and comes with eMMC and DDR3 memory.
>>>>>> This device comes with two versions - one with AXP305 PMIC and another with AXP313 PMIC.
>>>>> I have this board and it always felt like a clone of X96 Mate, which is
>>>>> already supported in kernel, except for broken sd card detection. Would it
>>>>> make sense to unify those two boards and just overwrite or update parts here
>>>>> that are not the same?
>>>> I think the box you have is an older one, with the AXP305? IIUC, this is
>>>> about a newer revision with the AXP313. There are quite some differences
>>>> between the two PMICs, though it might still make sense to share the DTs,
>>>> see the OrangePi Zero[23].
>>> Right, mine is with AXP305. It has "T95MAX v4.0" printed on PCB.
>>>
>>> Kamil, does your board also have "MAX" mentioned somewhere?
>>>
>>> Best regards,
>>> Jernej
>>>
>>>> Cheers,
>>>> Andre
>>>>
>>>>>> Kamil Kasperski (3):
>>>>>>    dt-bindings: vendor-prefixes: sunxi: add T95 to vendor-prefixes
>>>>>>    dt-bindings: arm: sunxi: add t95 compatible string to list of known
>>>>>>      boards
>>>>>>    dts: arm64: sunxi: add initial support for T95 AXP313 tv box
>>>>>>
>>>>>>   .../devicetree/bindings/arm/sunxi.yaml        |   5 +
>>>>>>   .../devicetree/bindings/vendor-prefixes.yaml  |   2 +
>>>>>>   arch/arm64/boot/dts/allwinner/Makefile        |   1 +
>>>>>>   .../dts/allwinner/sun50i-h616-t95-axp313.dts  | 138 ++++++++++++++++++
>>>>>>   4 files changed, 146 insertions(+)
>>>>>>   create mode 100644 arch/arm64/boot/dts/allwinner/sun50i-h616-t95-axp313.dts
>>>>>>
>>>>>>    
>>>>>
>>>>>
>>>>>
>>>
>>>
>
>
>


