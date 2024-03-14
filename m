Return-Path: <linux-kernel+bounces-103511-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6967187C06E
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 16:37:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 338F7281575
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 15:37:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7B6673163;
	Thu, 14 Mar 2024 15:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wgWdlUBX"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBE9671B3C
	for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 15:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710430642; cv=none; b=Wlyj9frTWjJ7jDlWqoPzH73WAx/RaCGhPtreAVYUOW7hRYS5sDuSmQRFR2YzWAJQeFjVPtemiH08YYt5Av1zqnckIVxc/LsnAtXm72WfQ0jmFbLxMYDmvP8K7YdvcT5HMp8jvmxuhJ85WNgIq7LZdh1WlRKKp80Qj7rq/+TjSeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710430642; c=relaxed/simple;
	bh=SPVqWWkb2K1BrqMKLNhmlLdj/AUNuhYVfe1ThELFrb0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MBy1ZB0eRfdfVE/6yHHsroMwync79srMNMMirfOFVvMW3SNlwyuLcZiZe1St1b4hSk5UuU4xgqykykdWd7rs636Km7EF9/Jhj14aPy8A0b32Il7gwviaBMW/tRK7pyiXFOB/1iNOaAqo0Shu1vhOFB1LxbikpuUwYMZWhz6nfUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=wgWdlUBX; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-41312232c7aso13826685e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 08:37:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1710430639; x=1711035439; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hrkk0iamSD3B9fHRkTsQ+4hlgt0dhGX0M+8WUe7tnlA=;
        b=wgWdlUBXsccxOtxVCFkXBvwqfyrUkpYrBFV8/NRn9c4Sx/ViV1ESkKi7cPZKloRLQv
         ZldV1CrT9jd83XXWG6NTinSdH9uSk5waqvs2YJRwgRP42q2lcRQ62SDg2GODppGUgKma
         bxehDlOepfsWFFcKHyA5aC1l1K510vhy3DDLnaaOpab/5WEWCPiYbiiRibBJfwy2iVuF
         OrASWTo1mNzGsfDcw/DwmQ8uNBQdg6VL7Uy/w4HqHQZC1/6+Z0sMcvQzijbLk8tqdQSy
         NqxCmSNOTYGQ5vOpGSyrQsIr32cHZMfx49gxOvBUpOCE5ictLE8ljXst7W8BtuQKQo3T
         D6iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710430639; x=1711035439;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hrkk0iamSD3B9fHRkTsQ+4hlgt0dhGX0M+8WUe7tnlA=;
        b=KrSsSWH+AftvXDzR0eZYUFxpvf971UIAGG87C3Qdl8tkuKdyTiG1Ca+dVwu0NVOoeU
         F9gg0syrdPjycO1wk2kmcMRQu83gdnVP6vXnDl1yWTBpmjreOlCDOXUaJbOpJQjxq1Xh
         aMfUgildRYMeM/GYIoH7xHSK1N9rkGNuRD/oOj8uzfUxEl6sWy6LjZMNrITN8RQ7SZM6
         6p37Nr9idwvrh+JGdTU5Zn5u05MagOTFmcb5/mio8L1UCRKAIdRLWbAikR23Rb9StqY4
         1wtQcrXStZfPDKsTJNe3/td8j/DmIiFjm2mTgiJroWoAXbLztZ5DcHRgzdt0gWntyM+3
         iTlw==
X-Forwarded-Encrypted: i=1; AJvYcCUHvXTiQ7ww3Rc17xUf28ZJYXqcly2nHs9wV1nNIc4QK7xEQS3Kvvy/vwQIoi6COx3HrviXrMGOV1tY1Fxz6fJlH6erB38hKBwDrtfl
X-Gm-Message-State: AOJu0YxtpQOD23+EMD4iIszTMeY+FuUokqriL3nUS7o5tSk8NHLcUH2V
	UGSlIPmtrwx/NpQ5f3YZkGqt2MuCBo2eYEQfeHWAzGa8Z3qkzq5k9mseZkjQsG4=
X-Google-Smtp-Source: AGHT+IFBgOSw9MnbY+rRKz5fxCP4xUmA4m909MnaxVuf1SVf2slvt1nzfZzf7+4/YmkGyAL28r0LeA==
X-Received: by 2002:adf:a4c1:0:b0:33d:7ec9:f5d0 with SMTP id h1-20020adfa4c1000000b0033d7ec9f5d0mr1905835wrb.2.1710430639085;
        Thu, 14 Mar 2024 08:37:19 -0700 (PDT)
Received: from [192.168.1.78] (host-92-17-96-232.as13285.net. [92.17.96.232])
        by smtp.gmail.com with ESMTPSA id h15-20020a05600016cf00b0033dc931eb06sm1112659wrf.0.2024.03.14.08.37.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Mar 2024 08:37:18 -0700 (PDT)
Message-ID: <9b614c61-276d-45bf-8320-44b7358a3e19@linaro.org>
Date: Thu, 14 Mar 2024 15:37:17 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] arm64: dts: qcom: apq8016: Add Schneider HMIBSC
 board DTS
Content-Language: en-US
To: Konrad Dybcio <konrad.dybcio@linaro.org>,
 Sumit Garg <sumit.garg@linaro.org>, Stephan Gerhold <stephan@gerhold.net>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 andersson@kernel.org, robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
 conor+dt@kernel.org, neil.armstrong@linaro.org, laetitia.mariottini@se.com,
 pascal.eberhard@se.com, abdou.saker@se.com, jimmy.lalande@se.com,
 benjamin.missey@non.se.com, daniel.thompson@linaro.org,
 linux-kernel@vger.kernel.org, Jagdish Gediya <jagdish.gediya@linaro.org>
References: <20240313123017.362570-1-sumit.garg@linaro.org>
 <20240313123017.362570-4-sumit.garg@linaro.org>
 <c0e10cbf-c6f3-4b0c-8616-983da2a40236@linaro.org>
 <CAFA6WYNMjCaa0FKjNv6a8VFkco3=GBfgWNDuckGZdiZ9dGmHgg@mail.gmail.com>
 <d82ab1f8-e677-485f-9a6b-4115acfd7239@linaro.org>
 <CAFA6WYNSumyScax=GkN42GJOG56T3odF5Ed9A2i1nk_exCyGtA@mail.gmail.com>
 <ZfLUu6_Vq7MvG2G3@gerhold.net>
 <CAFA6WYPN2Bt7zvDyd+02jrsZJz0sFhkD_o4W+PvU=-VC4W5k=A@mail.gmail.com>
 <ZfL6hi0kfp9MXQ0H@gerhold.net>
 <CAFA6WYMa_0OMkjUdvhYtWZ9SvQx5bB8+YrBZN08BaDXXOtPPNQ@mail.gmail.com>
 <fb20d921-dabd-41dc-9f91-bde90e3b87be@linaro.org>
From: Caleb Connolly <caleb.connolly@linaro.org>
In-Reply-To: <fb20d921-dabd-41dc-9f91-bde90e3b87be@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 14/03/2024 15:20, Konrad Dybcio wrote:
> 
> 
> On 3/14/24 14:50, Sumit Garg wrote:
>> On Thu, 14 Mar 2024 at 18:54, Stephan Gerhold <stephan@gerhold.net>
>> wrote:
>>>
>>> On Thu, Mar 14, 2024 at 05:26:27PM +0530, Sumit Garg wrote:
>>>> On Thu, 14 Mar 2024 at 16:13, Stephan Gerhold <stephan@gerhold.net>
>>>> wrote:
>>>>> On Thu, Mar 14, 2024 at 03:02:31PM +0530, Sumit Garg wrote:
>>>>>> On Thu, 14 Mar 2024 at 14:48, Konrad Dybcio
>>>>>> <konrad.dybcio@linaro.org> wrote:
>>>>>>> On 3/14/24 10:04, Sumit Garg wrote:
>>>>>>>> On Wed, 13 Mar 2024 at 18:34, Konrad Dybcio
>>>>>>>> <konrad.dybcio@linaro.org> wrote:
>>>>>>>>> On 3/13/24 13:30, Sumit Garg wrote:
>>>>>>>>>> Add Schneider Electric HMIBSC board DTS. The HMIBSC board is
>>>>>>>>>> an IIoT Edge
>>>>>>>>>> Box Core board based on the Qualcomm APQ8016E SoC.
>>>>>>>>>>
>>>>>>>>>> Support for Schneider Electric HMIBSC. Features:
>>>>>>>>>> - Qualcomm Snapdragon 410C SoC - APQ8016 (4xCortex A53, Adreno
>>>>>>>>>> 306)
>>>>>>>>>> - 1GiB RAM
>>>>>>>>>> - 8GiB eMMC, SD slot
>>>>>>>>>> - WiFi and Bluetooth
>>>>>>>>>> - 2x Host, 1x Device USB port
>>>>>>>>>> - HDMI
>>>>>>>>>> - Discrete TPM2 chip over SPI
>>>>>>>>>> - USB ethernet adaptors (soldered)
>>>>>>>>>>
>>>>>>>>>> Co-developed-by: Jagdish Gediya <jagdish.gediya@linaro.org>
>>>>>>>>>> Signed-off-by: Jagdish Gediya <jagdish.gediya@linaro.org>
>>>>>>>>>> Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
>>>>>>>>>> ---
>>>>>>>>>
>>>>>>>>> [...]
>>>>>>>>>
>>>>>>>>>> +     memory@80000000 {
>>>>>>>>>> +             reg = <0 0x80000000 0 0x40000000>;
>>>>>>>>>> +     };
>>>>>>>>>
>>>>>>>>> I'm not sure the entirety of DRAM is accessible..
>>>>>>>>>
>>>>>>>>> This override should be unnecessary, as bootloaders generally
>>>>>>>>> update
>>>>>>>>> the size field anyway.
>>>>>>>>
>>>>>>>> On this board, U-Boot is used as the first stage bootloader
>>>>>>>> (replacing
>>>>>>>> Little Kernel (LK), thanks to Stephan's work). And U-Boot consumes
>>>>>>>> memory range from DT as Linux does but doesn't require any
>>>>>>>> memory to
>>>>>>>> be reserved for U-Boot itself. So apart from reserved memory nodes
>>>>>>>> explicitly described in DT all the other DRAM regions are
>>>>>>>> accessible.
>>>>>>>
>>>>>>> Still, u-boot has code to fetch the size dynamically, no?
>>>>>>>
>>>>>>
>>>>>> No U-Boot being the first stage bootloader fetches size from DT which
>>>>>> is bundled into U-Boot binary.
>>>>>>
>>>>>
>>>>> Back when I added support for using U-Boot as first stage
>>>>> bootloader on
>>>>> DB410c the way it worked is that U-Boot used a fixed amount of DRAM
>>>>> (originally 968 MiB, later 1 GiB since I fixed this in commit
>>>>> 1d667227ea51 ("board: dragonboard410c: Fix PHYS_SDRAM_1_SIZE") [1]).
>>>>> When booting Linux, the Linux DT was dynamically patched with the
>>>>> right
>>>>> amount of DRAM (obtained from SMEM). So if you had e.g. a Geniatech
>>>>> DB4
>>>>> board with 2 GiB DRAM, U-Boot was only using 1 GiB of DRAM, but Linux
>>>>> later got the full 2 GiB patched into its DTB.
>>>>>
>>>>> I didn't have much time for testing U-Boot myself lately but a quick
>>>>> look at the recent changes suggest that Caleb accidentally removed
>>>>> that
>>>>> functionality in the recent cleanup. Specifically, the SMEM-based DRAM
>>>>> size detection was removed in commit 14868845db54 ("board:
>>>>> dragonboard410c: import board code from mach-snapdragon" [2]), the
>>>>> msm_fixup_memory() function does not seem to exist anymore now. :')
>>>>
>>>> Ah now I see the reasoning for that particular piece of code. Is SMEM
>>>> based approach the standardized way used by early stage boot-loaders
>>>> on other Qcom SoCs too?
>>>>
>>>
>>> It is definitely used on all the SoCs that were deployed with LK. I am
>>> not entirely sure about the newer ABL/UEFI-based ones. A quick look at
>>> the ABL source code suggests it is abstracted through an EFI protocol
>>> there (so we cannot see where the information comes from with just the
>>> open-source code). However, in my experience SMEM data structures are
>>> usually kept quite stable (or properly versioned), so it is quite likely
>>> that we could use this approach for all Qualcomm SoCs.
>>>
>>
>> If the SoCs which support this standardized way to dynamic discover
>> DRAM size via SMEM then why do we need to rely on DT at all for those
>> SoCs? Can't U-Boot and Linux have the same driver to fetch DRAM size
>> via SMEM? I am not sure if it's an appropriate way for U-Boot to fixup
>> DT when that information can be discovered dynamically.

"standardized" I'm not so sure... But yes, smem does offer this. The
definition in DT here is for U-Boot, ABL will always clobber it, and so
does U-Boot before handing over to the kernel. Linux should never see
this without a bootloader having looked at it.

The reason I decided to hardcode this in DT for U-Boot is because SMEM
currently relies on the driver model and isn't available early enough.

Also admittedly I just wasn't that familiar with the U-Boot codebase. I
just wanted to avoid hardcoding this in C code, and given that this was
already supported for the "chainloading from ABL" usecase, just
hardcoding the values was the obvious solution.

I would definitely be open to revisiting this in U-Boot, having an SMEM
framework that we could use without the driver model which would just
take a base address and then let us interact with SMEM and populate the
dram bank data would be a good improvement, and would let us avoid
hardcoding the memory layout in DT. We'd just need to manually find the
SMEM base address in the FDT as part of "dram_init_banksize()" and
retrieve the data there.

That all being said, I don't see any reason not to define the memory
layout in DT, it's a hardware feature, DT describes the hardware. The
whole "bootloader will fill this in" implies that the bootloader isn't
also using DT as the source of truth, but now with U-Boot it actually
is, so it's all the more important that DT be accurate ;P
> 
> You're mixing two things. Linux expects a devicetree where
> /memory/reg[size]
> is valid. Such driver should indeed be (re)implemented in u-boot to provide
> this information.
> 
> As for linux, I am working on making Linux aware of the DDR capabilities
> on Snapdragons, for other reasons, but it's on the back burner, as it
> still needs some broad thinking about integrating it with the interested
> consumers.. Bottom line is, Linux should be fed a devicetree with DRAM size
> filled.
> 
> Konrad

-- 
// Caleb (they/them)

