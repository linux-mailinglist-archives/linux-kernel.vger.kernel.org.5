Return-Path: <linux-kernel+bounces-37907-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BD7B83B77C
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 04:02:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AEC151F246D9
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 03:02:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 072E66ABA;
	Thu, 25 Jan 2024 03:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="gUh2Ma0w"
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0A221FB2
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 03:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706151731; cv=none; b=WGvQFzUGTFRcPq4jg/DL8kxbtzh9oNnEYk9OffFzvVA6dZbJ/vyKAN6popslqy88QZQowTrHubUboke1xsrC1kvjFjZBVMcgiqFk9LAcHQBq5FflEQKUWMt7ocgjliA+8uxVD94bLKj6cB2FMVOFd2PATGQLUB2rHnlsSseDbpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706151731; c=relaxed/simple;
	bh=LLvgLTa2AqMr0PhDmOnJLMQMSVL26JSHi+qJtEccwvw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=b7Pc0PSXsA6znr+KfPr1/jqwxclhrpcnZDEEXsKgNxBy85zmrWuQzl1dBGtTEDvubnjh8oatIjhDHRnqQyqcgfeQ09xP0h8DqbC/jDlKZg8hz8zk1XabymvZTehcmxpr7saoy7xU8VKlLLnWbkuY6jM3YkDPmxUdsogPOxPSewQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=gUh2Ma0w; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-6818d263cb3so44446916d6.2
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 19:02:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1706151728; x=1706756528; darn=vger.kernel.org;
        h=in-reply-to:from:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=X4IiaUyl6DVYZ9iB0MHdm4Cn0mOQ8Q7USb0qzHeOIDY=;
        b=gUh2Ma0wVtIzTAbYaFPAtxvpWPDbk1AAOWgwBlV+NfHgGxuygsVIVcf9SbimuAi26F
         BIl2siB7s3aqlsdRP8FNpVf15hE6QnHcvSbta9Bmzeba/71w5Fu0xz40ZsxehbSv6n2a
         wlqKpwRwtRjd5URer/H7fRVi2hwQLKYz3i6qg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706151728; x=1706756528;
        h=in-reply-to:from:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X4IiaUyl6DVYZ9iB0MHdm4Cn0mOQ8Q7USb0qzHeOIDY=;
        b=n8pPR2MIBejDEwQE4HXcOeCTiDrnHZP2ur5j6zBoB2E3rhjHNhwty4L2PqROCKOAtM
         9gdmoHwQmh59OYd8R+DXNC9S+s6uhZwBseeoe/bCQJfcp+++s3LtHJooakTdvnBrfxrd
         RVeot0mhk1HZryxKqgdV70q8lwVBxAtSAI2z7urhcQc4t/36qa8Juyx+0xdj+IMcM6vA
         L6rI2ZFYx9s/77TVvW02Nf4pGCSlFUwLO3y+mrC7Ka7VrjM90tgW8GNPYd0y4CBgXDR+
         w0LEwZO87vdOfyU0auV+68jmzi4D+fMAsS1nt6P1sdGke3cXXs4uW+WXbINxGU6JeOGU
         +4HA==
X-Gm-Message-State: AOJu0YwH+L9HQkHNyUTVYCP4CP4k2Bix0RNeiQ0fTqslzUEZ2cNtIAEZ
	Yv64lq3zLUWLun8MRHn6cASnpXNR1RPsMNu3Agzh7c2pputufLl86edS4moZgw==
X-Google-Smtp-Source: AGHT+IFM9/WUpi7NzYroD589gO2NuP9uFi2Gr3eQGo2NViG5q5M7NNGLZPwDs5vnfc6ywAGdzU9Sdw==
X-Received: by 2002:a05:6214:c2e:b0:686:ad81:2517 with SMTP id a14-20020a0562140c2e00b00686ad812517mr315827qvd.87.1706151728161;
        Wed, 24 Jan 2024 19:02:08 -0800 (PST)
Received: from [192.168.52.129] ([192.19.222.250])
        by smtp.gmail.com with ESMTPSA id h7-20020ac846c7000000b00429f883c347sm4912457qto.96.2024.01.24.19.02.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Jan 2024 19:02:06 -0800 (PST)
Message-ID: <451151f3-33df-4de8-ab62-a683ad4b7cb1@broadcom.com>
Date: Wed, 24 Jan 2024 19:01:48 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 01/10] dt-bindings: mtd: brcmnand: Updates for bcmbca
 SoCs
To: Conor Dooley <conor@kernel.org>, David Regan <dregan@broadcom.com>
Cc: dregan@mail.com, miquel.raynal@bootlin.com, richard@nod.at,
 vigneshr@ti.com, robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
 conor+dt@kernel.org, computersforpeace@gmail.com, kdasu.kdev@gmail.com,
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
From: William Zhang <william.zhang@broadcom.com>
In-Reply-To: <20240124-direness-outpost-bbc22550a161@spud>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000b5ebd4060fbc6707"

--000000000000b5ebd4060fbc6707
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Conor,

On 1/24/24 09:24, Conor Dooley wrote:
> Hey,
> 
> On Tue, Jan 23, 2024 at 07:04:49PM -0800, David Regan wrote:
>> From: William Zhang <william.zhang@broadcom.com>
>>
>> Update the descriptions to reflect different families of broadband SoC and
>> use the general name bcmbca for ARM based SoC.
>>
>> Add brcm,nand-use-wp property to have an option for disabling this
>> feature on broadband board design that does not use write protection.
>>
>> Add brcm,nand-ecc-use-strap to get ecc setting from board boot strap for
>> broadband board designs because they do not specify ecc setting in dts
>> but rather using the strap setting.
>>
>> Remove the requirement of interrupts property to reflect the driver
>> code. Also add myself to the list of maintainers.
>>
>> Signed-off-by: William Zhang <william.zhang@broadcom.com>
>> Reviewed-by: David Regan <dregan@broadcom.com>
>> ---
>> Changes in v3:
>> - Update brcm,nand-use-wp description
>> - Revert the description change to BCM63168 SoC-specific NAND controller
>> ---
>> Changes in v2:
>> - Revert the new compatible string nand-bcmbca
>> - Drop the BCM63168 compatible fix to avoid any potential ABI
>> incompatibility issue
>> - Simplify the explanation for brcm,nand-use-wp
>> - Keep the interrupt name requirement when interrupt number is specified
>> ---
>>   .../bindings/mtd/brcm,brcmnand.yaml           | 37 ++++++++++++++++---
>>   1 file changed, 32 insertions(+), 5 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/mtd/brcm,brcmnand.yaml b/Documentation/devicetree/bindings/mtd/brcm,brcmnand.yaml
>> index f57e96374e67..752c6ee98a7d 100644
>> --- a/Documentation/devicetree/bindings/mtd/brcm,brcmnand.yaml
>> +++ b/Documentation/devicetree/bindings/mtd/brcm,brcmnand.yaml
>> @@ -9,6 +9,7 @@ title: Broadcom STB NAND Controller
>>   maintainers:
>>     - Brian Norris <computersforpeace@gmail.com>
>>     - Kamal Dasu <kdasu.kdev@gmail.com>
>> +  - William Zhang <william.zhang@broadcom.com>
>>   
>>   description: |
>>     The Broadcom Set-Top Box NAND controller supports low-level access to raw NAND
>> @@ -18,9 +19,10 @@ description: |
>>     supports basic PROGRAM and READ functions, among other features.
>>   
>>     This controller was originally designed for STB SoCs (BCM7xxx) but is now
>> -  available on a variety of Broadcom SoCs, including some BCM3xxx, BCM63xx, and
>> -  iProc/Cygnus. Its history includes several similar (but not fully register
>> -  compatible) versions.
>> +  available on a variety of Broadcom SoCs, including some BCM3xxx, MIPS based
>> +  Broadband SoC (BCM63xx), ARM based Broadband SoC (BCMBCA) and iProc/Cygnus.
>> +  Its history includes several similar (but not fully register compatible)
>> +  versions.
>>   
>>     -- Additional SoC-specific NAND controller properties --
>>   
>> @@ -53,7 +55,7 @@ properties:
>>                 - brcm,brcmnand-v7.2
>>                 - brcm,brcmnand-v7.3
>>             - const: brcm,brcmnand
>> -      - description: BCM63138 SoC-specific NAND controller
>> +      - description: BCMBCA SoC-specific NAND controller
>>           items:
>>             - const: brcm,nand-bcm63138
>>             - enum:
>> @@ -111,6 +113,20 @@ properties:
>>         earlier versions of this core that include WP
>>       type: boolean
>>   
>> +  brcm,nand-use-wp:
>> +    description:
>> +      Use this property to indicate if board design uses
>> +      controller's write protection feature and connects its
>> +      NAND_WPb pin to nand chip's WP_L pin.
> 
>> By default the driver
>> +      uses a module parameter with default value set to enable to
>> +      control this feature for all boards. Use this dts property to
>> +      override the default behavior and enable/disable this feature
>> +      through board dts on a per board basis.
> 
> None of this information about module parameters is relevant in the
> binding, as it should be independent of the implementation of one
> particular operating system.
> 
Agree this is OS related stuff. I was trying to make it more clean by 
explaining how it is implemented in linux. And if we were to implement 
the driver for another OS, there will be at least a default value for 
wp_on. I will remove any mention of module parameter from this doc.

> If the module parameter is not provided, what does the driver do?
> If "wp_on" is the module parameter, then the default is to enable the
> write protection feature. If that's correct, it seems to me that the
> property should be called something like "brcm,no-wp". This property
> would be a boolean that indicates that the NAND_WPb and WP_L pins are
> not connected & nothing more. Clearly if the module param tries to
> enable WP and the DT property indicates that it is not supported you
> can decline to enable the feature, but that is up to the drivers in
> the OS to decide.
> 
If I were to implement this from day one, I certainly will choose the 
same approach as you suggested here.  But there is existing 
brcm,nand-has-wp property for other purpose and now if we have 
brcm,no-wp, it will be more confusing with that property IMHO. I prefer 
to keep use the "has" for feature availability and "use" for feature 
being used or not.

And the reason I keep it as int is because there could be a potential 
value of 2 for another mode that the current driver could set the wp_on 
to. I don't see it is being used in BCMBCA product but I am not sure 
about other SoC family. So I don't want to completely close the door 
here just in case.

> 
>> +      Set to 0 if WP pins are not connected and feature is not
>> +      used. Set to 1 if WP pins are connected and feature is used.
> 
> As it stands, this property is firmly in the "software policy" side
> of things, as it is being used as an override for a module parameter,
> particularly given you have properties for each direction. Whether or
> not the feature is to be used by the operating system is not relevant to
> the binding.
> 
I don't understand why this is a software policy.  This is the board 
design choice although it does override the driver default value. But it 
is still board or device setting and describe the hardware. OS has to 
follow this hardware configuration and set up accordingly.

>> +    $ref: /schemas/types.yaml#/definitions/uint32
>> +    enum: [0, 1]
>> +
>>   patternProperties:
>>     "^nand@[a-f0-9]$":
>>       type: object
>> @@ -137,6 +153,16 @@ patternProperties:
>>             layout.
>>           $ref: /schemas/types.yaml#/definitions/uint32
>>   
>> +      brcm,nand-ecc-use-strap:
>> +        description:
>> +          This flag is used by the driver to get the ecc strength and
>> +          spare area size from the SoC NAND boot strap setting. This
>> +          is commonly used by the BCMBCA SoC board design.
> 
> Quoting from v1, as I didn't get to it in time:
> 
> | > This property I'm not all that sure about either. If the specific
> | > properties that you mention here are not set in the DT what happens at
> | > the moment?
> | >
> | In that case, the ecc strength and oob size come from ONFI or nand id
> | decoding.  But that is usually the minimum requirement and user can
> | choose to use stronger ecc as long as there is enough oob spare area in
> | the nand chip.
> |
> | > I suppose what I am getting at is why are the bootstrap settings not
> | > always used in the absence of specific values provided in the DT?
> | >
> | This is because the STB, iProc and other chip and their board design may
> | not have or use the strap setting. But for BCMBCA SoC and board
> | reference design, we always use the strap setting.
> 
> My main question here I suppose is why would you need this property at
> all? If the specific properties are provided (nand-ecc-strength etc)
> then use them, and if they are not use the strap settings?If nand-ecc-strength does not exist, the current driver implementation 
use the auto detected ecc strength from the NAND chip ONFI parameter 
which is okay. But for BCABCM SoC and our reference board design, we 
don't use nand-ecc-strength and don't want to use the auto detected 
value(as they are typically minimum requirement) but rather use strap 
setting so I need a third choice.

> If there's no properties and no strap settings, the this property does
> not help. If there's properties and strap settings, but properties are
> wrong, then you just have some devicetrees that incorrectly describe the
> hardware and need to be fixed.
> 
True but manually setting nand-ecc-strength can be error prone like 
copy/paste error. The hardware strap setting does not involve such edit 
in the dts file so no error can happen.

>> If ecc
>> +          strength and spare area size are set by nand-ecc-strength
>> +          and brcm,nand-oob-sector-size in the dts, these settings
>> +          have precedence and override this flag.
> 
> Again, IMO, this is not for the binding to decide. That is a decision
> for the operating system to make.
> 
Again this is just for historic reason and BCMBCA as late player does 
not want to break any existing dts setting.  So I thought it is useful 
to explain here.  I can remove this text if you don't think it should be 
in the binding document.


> I am confused!
> 
> 
>> +        $ref: /schemas/types.yaml#/definitions/flag
>> +
>>       unevaluatedProperties: false
>>   
>>   allOf:
>> @@ -177,6 +203,8 @@ allOf:
>>               - const: iproc-idm
>>               - const: iproc-ext
>>     - if:
>> +      required:
>> +        - interrupts
>>         properties:
>>           interrupts:
>>             minItems: 2
>> @@ -189,7 +217,6 @@ unevaluatedProperties: false
>>   required:
>>     - reg
>>     - reg-names
>> -  - interrupts
>>   
>>   examples:
>>     - |
>> -- 
>> 2.37.3
>>

--000000000000b5ebd4060fbc6707
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
JOEwDQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEINFAH0aQHqKTmIzfNoI5grYxxlw5
ZqH4DAQoxbPS3PDpMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI0
MDEyNTAzMDIwOFowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsG
CWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFl
AwQCATANBgkqhkiG9w0BAQEFAASCAQCVrvEgIm7pDeYxXUqrAleJ6QnsQEZhiCAcKzWs4S0BGV/w
1mSU2xxAGoGNdXl8eP0L6cPUg5ebsGy90QWkzXd/54eWDIoEgxlXj0hcT8nhuEBH0s+9RV54VT57
SFXO957LP4P2AUzhOmtqM74naATXbfiNn9VgGedcJZg5fiQSCDXIYQtRuHUPOsm3Vjh9A880iOxf
cbaAOuv/8YXEz+ttmgmIDkPxLUx49xwAuUede3J80Iam+CuLb8ep/tPy7wRxuUHStclYZRpjE6wI
67rr4xm2vLkl/S0aCAcXLv9pBFBqT7Rl8x/OJea7jasZq2yguHvh5LI6ZqVrIAfD+PES
--000000000000b5ebd4060fbc6707--

