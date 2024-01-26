Return-Path: <linux-kernel+bounces-39519-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B21383D246
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 02:55:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AF1081C251BB
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 01:55:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD4F21C13;
	Fri, 26 Jan 2024 01:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="KU6hzaK4"
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96FBCEDE
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 01:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706234138; cv=none; b=PZMyN1/Oj4xlNIRPEV0A3gDh9DeVHyFrVl4Qh+Y74AfaaZAlklo7m28QQNefMb0rvNmH1DuY9p9nJKPF6kH4TvBm6zigepSbrJLYZIXVUo0LRoJhjJZLa5xopRB/H2alUSELpEZRaKQEjTuUt0vepeJCuyNLf/Qjgdcv1QMVL+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706234138; c=relaxed/simple;
	bh=1/3ctz1WPw5P3C1mU131N0aVMOCDRcVvV537bSg2Vzo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QPlzVzVWDizoTAgHhBreGVQAQsYKRFy1O3E/MbyIPF9OfHKtYs10hnX9GlP/H53Uwusp9xYmnEkwUqbtH5ROpg74UsH5GDTbOYdFtuUe+MU0Vfww+1NukN/qMzJkBTC1SzQeu1ebqycAtX/z6j44EDZwmYfTeL+9ixFvg2GhHkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=KU6hzaK4; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-5ff828b93f0so68427947b3.3
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 17:55:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1706234134; x=1706838934; darn=vger.kernel.org;
        h=in-reply-to:from:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=5g4KLoEB6ghN3Ql1NgA3h1/1SPLTY23O/VPxFXg9XdY=;
        b=KU6hzaK4NPfC7GXNP62LDaqxVKeQsVRibwEC0iyEbqEzpf4FokXUfN1X7FYEcN6E6K
         oSpt3wi9d8fOUQbtXfdYPu+WWeQVpJAd+yh7GDz1FoOFMIqNcuU5xdVhdzDH2cXxT4cj
         sGXzTROZEUT1JE+9nIF+nltB4QKQgpLS/1QeA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706234134; x=1706838934;
        h=in-reply-to:from:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5g4KLoEB6ghN3Ql1NgA3h1/1SPLTY23O/VPxFXg9XdY=;
        b=V1cM6ims/SM9/yEaWlAq+GEQNyHaL0dbul8gNww0oXI8PYQmMHU6M8APVLmh5MZt8g
         xV8CqJwe1AgbT0Q9MgRumCY3iTRYQSmUKZZIJtypRxAGHuGomwoyb40cZW06pct1e0jJ
         dCNLN4t4J3Dpp74b9trAzdtlTPkGwu6X0IaKSBoR4erKYqYuJCTngBEHqV77Hlc3gA+H
         gZ34n2fBHwM57CrD/3hDYjsaFBTlEkz1waGId+SyYyb0f1ivgvSrY9Jrs/+Ed33bQ8p8
         s11JOC+qCdxcZPpK/yghfSJZarjI1MeshOamnG+/JA4ezsT43Z7hP7EYe2rKoxhSgsFY
         CkbA==
X-Gm-Message-State: AOJu0YzPu8U6sZ54eOpnfI5Mk4l3+YJUs+dErFmxpamSg7dBXa5bZWRB
	6KBWN0Gu7utqP8Y2SFZ5F2fxyDOBzeEuTBT7gZyVtNLKroFrWfjLT/YFfVxiiA==
X-Google-Smtp-Source: AGHT+IFoWfI4FP/2W0X5pgQwyClxUdmPn+C/CEmZv9wkSZty1+HRab0tQmgTthb01ye+gAYXyTcUow==
X-Received: by 2002:a81:83c2:0:b0:5ff:7a0c:b610 with SMTP id t185-20020a8183c2000000b005ff7a0cb610mr734941ywf.31.1706234134365;
        Thu, 25 Jan 2024 17:55:34 -0800 (PST)
Received: from [192.168.52.129] ([192.19.222.250])
        by smtp.gmail.com with ESMTPSA id t25-20020ac85319000000b0042a64e81e5dsm64750qtn.57.2024.01.25.17.55.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Jan 2024 17:55:32 -0800 (PST)
Message-ID: <b2bc0948-7039-4dbd-8152-08a51e744c59@broadcom.com>
Date: Thu, 25 Jan 2024 17:55:29 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 01/10] dt-bindings: mtd: brcmnand: Updates for bcmbca
 SoCs
To: Conor Dooley <conor@kernel.org>
Cc: David Regan <dregan@broadcom.com>, dregan@mail.com,
 miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
 robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 computersforpeace@gmail.com, kdasu.kdev@gmail.com,
 linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, joel.peshkin@broadcom.com,
 tomer.yacoby@broadcom.com, dan.beygelman@broadcom.com,
 anand.gore@broadcom.com, kursad.oney@broadcom.com,
 florian.fainelli@broadcom.com, rafal@milecki.pl,
 bcm-kernel-feedback-list@broadcom.com, andre.przywara@arm.com,
 baruch@tkos.co.il, linux-arm-kernel@lists.infradead.org,
 dan.carpenter@linaro.org
References: <20240124030458.98408-1-dregan@broadcom.com>
 <20240124030458.98408-2-dregan@broadcom.com>
 <20240124-direness-outpost-bbc22550a161@spud>
 <451151f3-33df-4de8-ab62-a683ad4b7cb1@broadcom.com>
 <20240125-drove-undiluted-5d822b7fd4fa@spud>
From: William Zhang <william.zhang@broadcom.com>
In-Reply-To: <20240125-drove-undiluted-5d822b7fd4fa@spud>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000825a22060fcf97b8"

--000000000000825a22060fcf97b8
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 1/25/24 11:51, Conor Dooley wrote:
> 
> On Wed, Jan 24, 2024 at 07:01:48PM -0800, William Zhang wrote:
>> On 1/24/24 09:24, Conor Dooley wrote:
>>> On Tue, Jan 23, 2024 at 07:04:49PM -0800, David Regan wrote:
>>>> From: William Zhang <william.zhang@broadcom.com>
>>>>
>>>> Update the descriptions to reflect different families of broadband SoC and
>>>> use the general name bcmbca for ARM based SoC.
>>>>
>>>> Add brcm,nand-use-wp property to have an option for disabling this
>>>> feature on broadband board design that does not use write protection.
>>>>
>>>> Add brcm,nand-ecc-use-strap to get ecc setting from board boot strap for
>>>> broadband board designs because they do not specify ecc setting in dts
>>>> but rather using the strap setting.
>>>>
>>>> Remove the requirement of interrupts property to reflect the driver
>>>> code. Also add myself to the list of maintainers.
>>>>
>>>> Signed-off-by: William Zhang <william.zhang@broadcom.com>
>>>> Reviewed-by: David Regan <dregan@broadcom.com>
>>>> ---
>>>> Changes in v3:
>>>> - Update brcm,nand-use-wp description
>>>> - Revert the description change to BCM63168 SoC-specific NAND controller
>>>> ---
>>>> Changes in v2:
>>>> - Revert the new compatible string nand-bcmbca
>>>> - Drop the BCM63168 compatible fix to avoid any potential ABI
>>>> incompatibility issue
>>>> - Simplify the explanation for brcm,nand-use-wp
>>>> - Keep the interrupt name requirement when interrupt number is specified
>>>> ---
>>>>    .../bindings/mtd/brcm,brcmnand.yaml           | 37 ++++++++++++++++---
>>>>    1 file changed, 32 insertions(+), 5 deletions(-)
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/mtd/brcm,brcmnand.yaml b/Documentation/devicetree/bindings/mtd/brcm,brcmnand.yaml
>>>> index f57e96374e67..752c6ee98a7d 100644
>>>> --- a/Documentation/devicetree/bindings/mtd/brcm,brcmnand.yaml
>>>> +++ b/Documentation/devicetree/bindings/mtd/brcm,brcmnand.yaml
>>>> @@ -9,6 +9,7 @@ title: Broadcom STB NAND Controller
>>>>    maintainers:
>>>>      - Brian Norris <computersforpeace@gmail.com>
>>>>      - Kamal Dasu <kdasu.kdev@gmail.com>
>>>> +  - William Zhang <william.zhang@broadcom.com>
>>>>    description: |
>>>>      The Broadcom Set-Top Box NAND controller supports low-level access to raw NAND
>>>> @@ -18,9 +19,10 @@ description: |
>>>>      supports basic PROGRAM and READ functions, among other features.
>>>>      This controller was originally designed for STB SoCs (BCM7xxx) but is now
>>>> -  available on a variety of Broadcom SoCs, including some BCM3xxx, BCM63xx, and
>>>> -  iProc/Cygnus. Its history includes several similar (but not fully register
>>>> -  compatible) versions.
>>>> +  available on a variety of Broadcom SoCs, including some BCM3xxx, MIPS based
>>>> +  Broadband SoC (BCM63xx), ARM based Broadband SoC (BCMBCA) and iProc/Cygnus.
>>>> +  Its history includes several similar (but not fully register compatible)
>>>> +  versions.
>>>>      -- Additional SoC-specific NAND controller properties --
>>>> @@ -53,7 +55,7 @@ properties:
>>>>                  - brcm,brcmnand-v7.2
>>>>                  - brcm,brcmnand-v7.3
>>>>              - const: brcm,brcmnand
>>>> -      - description: BCM63138 SoC-specific NAND controller
>>>> +      - description: BCMBCA SoC-specific NAND controller
>>>>            items:
>>>>              - const: brcm,nand-bcm63138
>>>>              - enum:
>>>> @@ -111,6 +113,20 @@ properties:
>>>>          earlier versions of this core that include WP
>>>>        type: boolean
>>>> +  brcm,nand-use-wp:
>>>> +    description:
>>>> +      Use this property to indicate if board design uses
>>>> +      controller's write protection feature and connects its
>>>> +      NAND_WPb pin to nand chip's WP_L pin.
>>>
>>>> By default the driver
>>>> +      uses a module parameter with default value set to enable to
>>>> +      control this feature for all boards. Use this dts property to
>>>> +      override the default behavior and enable/disable this feature
>>>> +      through board dts on a per board basis.
>>>
>>> None of this information about module parameters is relevant in the
>>> binding, as it should be independent of the implementation of one
>>> particular operating system.
>>>
>> Agree this is OS related stuff. I was trying to make it more clean by
>> explaining how it is implemented in linux. And if we were to implement the
>> driver for another OS, there will be at least a default value for wp_on. I
>> will remove any mention of module parameter from this doc.
>>
>>> If the module parameter is not provided, what does the driver do?
>>> If "wp_on" is the module parameter, then the default is to enable the
>>> write protection feature. If that's correct, it seems to me that the
>>> property should be called something like "brcm,no-wp". This property
>>> would be a boolean that indicates that the NAND_WPb and WP_L pins are
>>> not connected & nothing more. Clearly if the module param tries to
>>> enable WP and the DT property indicates that it is not supported you
>>> can decline to enable the feature, but that is up to the drivers in
>>> the OS to decide.
>>>
>> If I were to implement this from day one, I certainly will choose the same
>> approach as you suggested here.  But there is existing brcm,nand-has-wp
>> property for other purpose and now if we have brcm,no-wp, it will be more
>> confusing with that property IMHO. I prefer to keep use the "has" for
>> feature availability and "use" for feature being used or not.
> 
> "brcm,wp-not-connected" then, since I want it to become a boolean and it
> would better communicate what the problem is than "brcm,dont-use-wp"
> would.
> 
>> And the reason I keep it as int is because there could be a potential value
>> of 2 for another mode that the current driver could set the wp_on to.
> 
> Can you explain, in driver independent terms, what this other mode has
> to do with how the WP is connected?
> Either you've got the standard scenario where apparently "NAND_WPb" and
> "WP_L" are connected and another situation where they are not.
> Is there another pin configuration in addition to that, that this 3rd
> mode represents?
> 
The 3rd mode is WP pin connected but wp feature is disabled in the 
controller.

>> I
>> don't see it is being used in BCMBCA product but I am not sure about other
>> SoC family. So I don't want to completely close the door here just in case.
> 
> If you ever need it, you could have a "brcm,wp-in-wacky-configuration"
> property that indicates that the hardware is configured in that way
> (providing that this hardware configuration is not just "NAND_WPb" and
> "WP_L" pins connected. The property can very easily be made mutually
> exclusive with "brcm,wp-not-connected" iff it ever comes to be.
Yes we could have a new property but if we can have a single int 
property to cover all, IMHO it is better to just have one property as 
these three modes are related. I would really like to have it as an int 
property to keep things simple.

But if you think this is absolutely against the dts rule,  I will switch 
to the "brcm,wp-not-connected" boolean property as you suggested.

> 
>>>> +      Set to 0 if WP pins are not connected and feature is not
>>>> +      used. Set to 1 if WP pins are connected and feature is used.
>>>
>>> As it stands, this property is firmly in the "software policy" side
>>> of things, as it is being used as an override for a module parameter,
>>> particularly given you have properties for each direction. Whether or
>>> not the feature is to be used by the operating system is not relevant to
>>> the binding.
>>>
>> I don't understand why this is a software policy.  This is the board design
>> choice although it does override the driver default value. But it is still
>> board or device setting and describe the hardware. OS has to follow this
>> hardware configuration and set up accordingly.
> 
> The software policy side of things is that you are instructing the
> software what to do with "use" nature of it and the force enable &
> disable options for the property. A boolean property that tells software
> that the wp is not connected is all you need, as far as I can tell.
> That should be sufficient information for the operating system to know
> whether or not it can use the wp.
>

>>>> +    $ref: /schemas/types.yaml#/definitions/uint32
>>>> +    enum: [0, 1]
>>>> +
>>>>    patternProperties:
>>>>      "^nand@[a-f0-9]$":
>>>>        type: object
>>>> @@ -137,6 +153,16 @@ patternProperties:
>>>>              layout.
>>>>            $ref: /schemas/types.yaml#/definitions/uint32
>>>> +      brcm,nand-ecc-use-strap:
>>>> +        description:
>>>> +          This flag is used by the driver to get the ecc strength and
>>>> +          spare area size from the SoC NAND boot strap setting. This
>>>> +          is commonly used by the BCMBCA SoC board design.
>>>
>>> Quoting from v1, as I didn't get to it in time:
>>>
>>> | > This property I'm not all that sure about either. If the specific
>>> | > properties that you mention here are not set in the DT what happens at
>>> | > the moment?
>>> | >
>>> | In that case, the ecc strength and oob size come from ONFI or nand id
>>> | decoding.  But that is usually the minimum requirement and user can
>>> | choose to use stronger ecc as long as there is enough oob spare area in
>>> | the nand chip.
>>> |
>>> | > I suppose what I am getting at is why are the bootstrap settings not
>>> | > always used in the absence of specific values provided in the DT?
>>> | >
>>> | This is because the STB, iProc and other chip and their board design may
>>> | not have or use the strap setting. But for BCMBCA SoC and board
>>> | reference design, we always use the strap setting.
>>>
>>> My main question here I suppose is why would you need this property at
>>> all? If the specific properties are provided (nand-ecc-strength etc)
>>> then use them, and if they are not use the strap settings?If
>>> nand-ecc-strength does not exist, the current driver implementation
>> use the auto detected ecc strength from the NAND chip ONFI parameter which
>> is okay. But for BCABCM SoC and our reference board design, we don't use
>> nand-ecc-strength and don't want to use the auto detected value(as they are
>> typically minimum requirement) but rather use strap setting so I need a
>> third choice.
> 
> That seems reasonable. Please limit the property though to the SoCs
> where it is relevant if you had not done so already.
Yes it is only for BCMBCA SoC that I am updating in this patch series.

> Thanks for the explanation.
> 
>>> If there's no properties and no strap settings, the this property does
>>> not help. If there's properties and strap settings, but properties are
>>> wrong, then you just have some devicetrees that incorrectly describe the
>>> hardware and need to be fixed.
>>>
>> True but manually setting nand-ecc-strength can be error prone like
>> copy/paste error. The hardware strap setting does not involve such edit in
>> the dts file so no error can happen.
> 
> Copy paste errors are not really an argument here, you could use that as
> an excuse for anything DT property in the world.. You could copy paste
> the wrong thing into the strap, and idk about you, but on the systems I
> have it is far easier to change the DT passed to the kernel than what I
> assume is an early bootloader stage? (I tried googling for "broadcom
> strap" but there was nothing relevant)
> 
Agree, the strap could be set incorrectly in the hardware but then the 
board likely won't be able to boot to linux for linux developer to work 
on. Changing dts is easy but obtaining the ecc setting from hardware 
strap automatically is no-brainer as it require no change in dts or any 
manual setting, assuming hardware is correct.

>>>> If ecc
>>>> +          strength and spare area size are set by nand-ecc-strength
>>>> +          and brcm,nand-oob-sector-size in the dts, these settings
>>>> +          have precedence and override this flag.
>>>
>>> Again, IMO, this is not for the binding to decide. That is a decision
>>> for the operating system to make.
>>>
>> Again this is just for historic reason and BCMBCA as late player does not
>> want to break any existing dts setting.  So I thought it is useful to
>> explain here.  I can remove this text if you don't think it should be in the
>> binding document.
> 
> I don't, at least not in that form. I think it is reasonable to explain
> why these values are better though.
I understand the decision is for OS/driver to make. If we were to write 
another driver for other OS, the same precedence will apply too so the 
binding works the same way across all the OS. So I am not sure what 
better explanation or form I can put up here. I am open to any 
suggestion or I just delete it.

> 
> Thanks,
> Conor.

--000000000000825a22060fcf97b8
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
YDZuuBJwnyCzevMoPtVYPharioL5H3BRnQi8YoTXH7/uRo33dewYFm474yFjwwnt82TFtveVZkVq
6h4WIQ4wTcwFfET8zMkELnGzS5SHCl8sPD+lNxxJ1JDZYwIDAQABo4IB2zCCAdcwDgYDVR0PAQH/
BAQDAgWgMIGjBggrBgEFBQcBAQSBljCBkzBOBggrBgEFBQcwAoZCaHR0cDovL3NlY3VyZS5nbG9i
YWxzaWduLmNvbS9jYWNlcnQvZ3NnY2NyM3BlcnNvbmFsc2lnbjJjYTIwMjAuY3J0MEEGCCsGAQUF
BzABhjVodHRwOi8vb2NzcC5nbG9iYWxzaWduLmNvbS9nc2djY3IzcGVyc29uYWxzaWduMmNhMjAy
MDBNBgNVHSAERjBEMEIGCisGAQQBoDIBKAowNDAyBggrBgEFBQcCARYmaHR0cHM6Ly93d3cuZ2xv
YmFsc2lnbi5jb20vcmVwb3NpdG9yeS8wCQYDVR0TBAIwADBJBgNVHR8EQjBAMD6gPKA6hjhodHRw
Oi8vY3JsLmdsb2JhbHNpZ24uY29tL2dzZ2NjcjNwZXJzb25hbHNpZ24yY2EyMDIwLmNybDAlBgNV
HREEHjAcgRp3aWxsaWFtLnpoYW5nQGJyb2FkY29tLmNvbTATBgNVHSUEDDAKBggrBgEFBQcDBDAf
BgNVHSMEGDAWgBSWM9HmWBdbNHWKgVZk1b5I3qGPzzAdBgNVHQ4EFgQUq65GzwZxydFHjjYEU/9h
xHhPWlwwDQYJKoZIhvcNAQELBQADggEBAA2hGG3JPAdGPH0ZdohGUCIVjKz+U+EFuIDbS6A/5jqX
VhYAxZlzj7tSjUIM7G7IhyfqPC46GKJ/4x+Amz1Z6YxNGy71L68kYD6hIbBcA5AM42QBUufly6Oa
/ppSz3WoflVyFFQ5YXniZ+eU+2/cdnYZg4aVUnFjimOF5o3NfMLzOkhQNxbaDjFUfUYD8hKmU6v4
0vUBj8KZ9Gi1LIagLKUREn8jku0lcLsRbnJ5Ey5ScajC/FESPyYWasOW8j8/1EoJksmhbYGKNS6C
urb/KlmDGfVrIRYDbL0ckhGQIP5c6L+kSQZ2sHnQK0e0WgIaZYxaPYeY5u0GLCOze+3vyRMxggJt
MIICaQIBATBrMFsxCzAJBgNVBAYTAkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMTEwLwYD
VQQDEyhHbG9iYWxTaWduIEdDQyBSMyBQZXJzb25hbFNpZ24gMiBDQSAyMDIwAgwxuh2XG3FXRL1W
JOEwDQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIBVmkTM4/pceQUBLohs7hSC8PDSl
uBO64PGs8q8302CNMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI0
MDEyNjAxNTUzNFowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsG
CWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFl
AwQCATANBgkqhkiG9w0BAQEFAASCAQBih7A1fdzdkSmq6o2gVx+mFCtFat+8p7UPno3S9glFCwTw
aNn2s62/DmtQepxfe4b8uvi5EGz/p9gSeX3SDWaw4ZaqyK9SdBeNkUuYZWrec2G/AXDwdhOl6Lyd
ZSaimeLWA31muMTZnhXwZFl0g0C/ozNfFeJwpC6jnBQqlqB1lnx6BXTNYDMrr/7UzcalRH9AsyOE
bHPQKzt/nxTMSajr07XKr2GcZOfnzQNQZO5yq4Z+lnaPyCaBixOULAgM7eq6Xg5y1kDv4UL/HqZ3
tF7jBTI8m/mrP9xgcwbVjnm5hhn/q/lb2ZqJQ7dN6OwhlFq68qKURbEkpKsDUkchdLPO
--000000000000825a22060fcf97b8--

