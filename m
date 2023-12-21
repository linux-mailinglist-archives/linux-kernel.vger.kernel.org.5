Return-Path: <linux-kernel+bounces-8718-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F2D3081BB68
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 16:58:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ADD5E281D3C
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 15:58:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71D0E55E4D;
	Thu, 21 Dec 2023 15:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aHCs1OiF"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83FBA55E41;
	Thu, 21 Dec 2023 15:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-55359dc0290so1715128a12.1;
        Thu, 21 Dec 2023 07:58:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703174295; x=1703779095; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2ge32C67y6VL/tOuymk4ghO3Zqyctvc0EUYmoNeC+rk=;
        b=aHCs1OiFPLNLSAOkspRFOdr903JQa+a2GQDuFWjxMFFjuhguulavIeqXjTZaNwMWwd
         XJcE6PArQvbo/4L2oJhGeJe8d9o1bcExmBYEoNWFRqgUDPrqbPaRh2AXn3BKWASbw07f
         +Y9eqwmkqc67Xgch31+aH+felDj9r0INAjkzXcj25+Kk8OKHfQwh/oegfaH/bftv1nBd
         SPC8sEyjE95SLV9was+j0LSIS3S0QLd2NQcqqBVGF9Ook7cHruKxy1du5EAVcTdNdaHW
         FytqQ0mg9EZAvG4ncUbssIDwVR9fEvxqA69rHnfVCjhlFvMENhPm0vpX+1HzCq37LhSE
         1Oqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703174295; x=1703779095;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2ge32C67y6VL/tOuymk4ghO3Zqyctvc0EUYmoNeC+rk=;
        b=cifNwpEV2b4VW09W80mpJ0okvm2FGyOwcoTJE3ahEa+/4dlcwfrmKmOq6qdQBEPWGd
         +Uk/9AdhS8cNkjETun0uozYWD+n/MHLiftf+W3e5Www3awd7AHjyN3NQel615Nx8SvlA
         wKqA2N7l1vKFMgS87QjqX5ICDNV8wqE8CKmzPwwYkEpVW0UAKlNsyDR83aWGawa4BIcO
         x27V2WQb30xa/dao+lNaOJ13WHvA7+rh1IGpnZpUo/uaSFK1Rj3X+HyUP1nuEb8sGnJD
         K3w65X3xfsadeRNIAnFr35wG08jZh6E/is05ivQNOfyCx8+71qx313ekR+3c8a9xLmA0
         YGkw==
X-Gm-Message-State: AOJu0YwsO2ROyhz7yC6yKYPuea94XQvS8ovqTorAlWmvMtOP1OsXvK/0
	JvIYNu2JONdXje4Eyr9jrg==
X-Google-Smtp-Source: AGHT+IFQKXVMkj4zyFWzLvwTphebmbg25nOOyfIZuy7V6OS9xs9j1VkjX2huLDnGvHVVWCzK9/wYCQ==
X-Received: by 2002:a50:8d1b:0:b0:554:1100:99e9 with SMTP id s27-20020a508d1b000000b00554110099e9mr1032558eds.9.1703174294607;
        Thu, 21 Dec 2023 07:58:14 -0800 (PST)
Received: from ?IPV6:2a02:810b:f40:4300:b601:5984:d94a:3021? ([2a02:810b:f40:4300:b601:5984:d94a:3021])
        by smtp.gmail.com with ESMTPSA id g14-20020aa7d1ce000000b0055122551f98sm1334250edp.6.2023.12.21.07.58.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Dec 2023 07:58:14 -0800 (PST)
Message-ID: <a82481ca-b578-49a4-b0d0-974b6ee65c98@gmail.com>
Date: Thu, 21 Dec 2023 16:58:13 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] ARM: dts: rockchip: Add psci for rk3036
To: Andy Yan <andy.yan@rock-chips.com>, Andy Yan <andyshrk@163.com>,
 heiko@sntech.de
Cc: krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org,
 zhengxing@rock-chips.com
References: <20231218105523.2478315-1-andyshrk@163.com>
 <20231218105523.2478315-2-andyshrk@163.com>
 <da10e2fc-3179-4bd5-88ed-b4d5f64a7191@gmail.com>
 <28216be5-810f-40d6-850b-a0fc590ffa3c@rock-chips.com>
Content-Language: en-US, de-DE
From: Alex Bee <knaerzche@gmail.com>
In-Reply-To: <28216be5-810f-40d6-850b-a0fc590ffa3c@rock-chips.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Andy,

Am 21.12.23 um 02:07 schrieb Andy Yan:
> Hi Alex:
>
> On 12/20/23 19:16, Alex Bee wrote:
>> Hi Andy,
>> Am 18.12.23 um 11:55 schrieb Andy Yan:
>>> From: Andy Yan <andy.yan@rock-chips.com>
>>>
>>> The system will hang at bringup secondary CPUs
>>> without psci node.
>>>
>>> Signed-off-by: Andy Yan <andy.yan@rock-chips.com>
>>>
>>> ---
>>>
>>> (no changes since v1)
>>>
>>>   arch/arm/boot/dts/rockchip/rk3036.dtsi | 5 +++++
>>>   1 file changed, 5 insertions(+)
>>>
>>> diff --git a/arch/arm/boot/dts/rockchip/rk3036.dtsi 
>>> b/arch/arm/boot/dts/rockchip/rk3036.dtsi
>>> index 78686fc72ce6..5344803442a1 100644
>>> --- a/arch/arm/boot/dts/rockchip/rk3036.dtsi
>>> +++ b/arch/arm/boot/dts/rockchip/rk3036.dtsi
>>> @@ -67,6 +67,11 @@ display-subsystem {
>>>           ports = <&vop_out>;
>>>       };
>>> +    psci {
>>> +        compatible = "arm,psci-1.0";
>>> +        method = "smc";
>>> +    };
>>> +
>> I don't think that's an good idea. 
>
> Why?
It's only what I've been told before: We shoudn't add properties which
depend on non-upstream software (if an upstream alternative exists). Also
I'm not sure what happens if somebody doesn't use downstream bootloader
and PSCI can't be found: Would the board still be able to boot?
>
>> You most likely need that because you have downstream bootloader 
>> installed on this board. PSCI implementation takes place in TEE-OS 
>> for Rockchips ARM SoCs. There is no support for RK3036 in upstream 
>> op-tee OS. It's pretty much the same for RK3128 and RK3288.
>> If you use upstream u-boot it should be good as-is.
>
> Unfortunately, upstream u-boot also cannot boot up on this board.
> At present, I haven't had time to debug what is going on.
>
> Another reason I want to use downstream u-boot it is: I try run
> this board with mainline just because i want to test some community
> patches about inno-hdmi driver, as you said "the inno-hdmi driver 
> currently gets a lot of attention"[0]
>
Thanks for helping testing this.

Alex

> With a downstream u-boot I can easy switch between upstream kernel and 
> downstream kernel(no need to replace other components)
> if I found some function is not work as expected.
>
>
> [0]https://patchwork.kernel.org/project/linux-rockchip/cover/20231219170100.188800-1-knaerzche@gmail.com/ 
>
>>
>> Alex
>>>       timer {
>>>           compatible = "arm,armv7-timer";
>>>           arm,cpu-registers-not-fw-configured;
>>
>>
>> _______________________________________________
>> Linux-rockchip mailing list
>> Linux-rockchip@lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-rockchip

