Return-Path: <linux-kernel+bounces-51920-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 047588490EA
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 22:57:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 283541C21639
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 21:57:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B14E2C695;
	Sun,  4 Feb 2024 21:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="MtPAzyzK"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD2BE2C68E
	for <linux-kernel@vger.kernel.org>; Sun,  4 Feb 2024 21:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707083826; cv=none; b=YGCAj2zoWtME6Jd6tb9oGXaFky0m/cVaZbmux2I5Kh9q1FjbJDz8dd+QlgnYYimhAhKpPUXyg2CIlSC2UbNg92cf8bHQ2oz6RQbJboZdwxWVW4kcSk6zLFh8+2zzKw73+GCwGrqJPLP79OIkGprRQ8R3PHh6LGR7hsM09wIjfPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707083826; c=relaxed/simple;
	bh=HdjEyzl0fjY4es/+hWBbzS0Gv/aDWk+JqkQe86wNEbU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XQ7FxPT3d0CmEzH9D001etCBmFTGeeLDyNY1Lq949YfU32/fIrxoa0OalO+syGWjWKrCRhEShKjIOnMAsmJl1tmUyyX6MNo4wocTAhdFWfTUun5RwYCJienw2sGXq4u8c9DJdDwJVEB+moBsuJQlKNxy15CMzZpk3QTF4A+Hmv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=MtPAzyzK; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1d76671e5a4so30565435ad.0
        for <linux-kernel@vger.kernel.org>; Sun, 04 Feb 2024 13:57:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1707083824; x=1707688624; darn=vger.kernel.org;
        h=in-reply-to:from:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=t+QwJVQUPTI1CXyYsv8ik/ucvVZVzWjGphV803t2o5c=;
        b=MtPAzyzKEBu7Ag78co3REFJLYoMjcJOYwiKav3S8ELpDPdVSnuRJjr3OsIjNL7ICRp
         xlbLD2yj9eCWQpu8sP/RQiPPO7Bxck8sIeWVsJZPs/XpJafI2B8Eh6pP9uPiFkh66LsK
         TcCEfubdyYiriJDz+atVNVoxukwrCw7AC/E5U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707083824; x=1707688624;
        h=in-reply-to:from:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t+QwJVQUPTI1CXyYsv8ik/ucvVZVzWjGphV803t2o5c=;
        b=lcIdl1eV6o2tR6t6e76BGPeGeQBUXokv/TM1uLKxtZ/J0T5nwOoPWwlK4eZinkZHXs
         ne/p1OQ+yyhnOBOKx21JWepPBRGN7XWtCtPzNCxfb9HiZqmw148K5RIoC2FYYmtg7ldT
         AeRX/1WyV0FoQE3bwA71tzPF7zF5r4XDcG1R8SsDAC38tZo0U9XwHfTryTSY/6g2uMZz
         XTeDoC/Yvuvt8ag6qQqRpMdY1C5n7K6DI2+kyQ5y2ryTevrg4VUVRIbhjHo580lbwj91
         Ihc0JxPQbQYh9e8Z5m0FVsBsvdxBs5tkRXdMihfoQF/mRXoYBnWJVtA4i29SmAmc4mwy
         QXvA==
X-Gm-Message-State: AOJu0YzV5ZG13On8cDuSxG7Qd9lBE51KNERrTfK9hikYEYZ5E88KYqLl
	BUb/Ox97aVwSD3F7CnggLztBaYeNAto4syaLM0SzJKA4wC6lgS9EBR0kBO0rOg==
X-Google-Smtp-Source: AGHT+IGmYNvLYDvB9R/WCfRbKAsxhwjde8q33PE4VGtg5hGW0VzqzbBr1jwiFKiygzw49yj+h7aoEw==
X-Received: by 2002:a17:902:f547:b0:1d9:ae31:83ff with SMTP id h7-20020a170902f54700b001d9ae3183ffmr2571649plf.8.1707083823990;
        Sun, 04 Feb 2024 13:57:03 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCXLdxzlLBurIT/4wgNTMVNw8kr9MaZiSIchkpuT+9STNyxJnqMfX9B6qR/RrWGU1It1ecZQtiShrD4q1OwepTpQ5FNO/yo/lwjr1A2/de2YOGnER6o6nw1sSd43EDoFfvN3UsIBPZFt+iUswFF+NnElidfVCxJw560TEiTHGHMyAAs//QsDz4FRSTHHFzMl7SNDptbJId+IIRaLKBXu802XeDxgs+bgR0rqVifReCXMV7H+QbCThJOY343dD0bykLkAsN6fqg28DaE+5OMCzCbbShDkoyS+GCsW8bX5k92c4d9OSSgqn0iuOT7+YmWiPi0ssEUVpxr44EWALggnThRxnEhFj2DrILAfRm7TdoMX7QVUilRNWJgvnqd4crGtMujAEkwfO1cFnEhKXaujlTOcF13qUbcztiM95BjNyTtOFawrMu0Sh86J3uW1RD9T9b0isfG5fiiMIrJHDCcgIYe8fUc0ssBP278MAfmHdfZb2XIaa0yhWh4BmQajvKMrTWyPsddWnOnU8EyIqS0HbssvhJCl8SIMc6upLMnKvRLvZc5PDoK5geHNkUKGh//8zTBJ/Kb9daL6o8qaux3m4gLfBFiEKpM2gxaD9nqM0zu/HV7Bc0hoFmMOB0pzfKaT6uD5GKUcEDtvOldJrbZbA0QOlQ9hDL6EOSkE4owivlWcHpgJBHOkUm4tFtcpEkV0su7GmBVFROyd3LPym0j1crUF
Received: from [192.168.52.129] ([192.19.222.250])
        by smtp.gmail.com with ESMTPSA id h12-20020a170902f7cc00b001d8ffe741basm4982482plw.36.2024.02.04.13.57.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 04 Feb 2024 13:57:01 -0800 (PST)
Message-ID: <dd043b05-6fc0-4a17-bf39-05368d430426@broadcom.com>
Date: Sun, 4 Feb 2024 13:56:59 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 03/12] dt-bindings: mtd: brcmnand: Add ecc strap
 property
To: Conor Dooley <conor@kernel.org>
Cc: Linux MTD List <linux-mtd@lists.infradead.org>,
 Linux ARM List <linux-arm-kernel@lists.infradead.org>,
 Broadcom Kernel List <bcm-kernel-feedback-list@broadcom.com>,
 f.fainelli@gmail.com, kursad.oney@broadcom.com, joel.peshkin@broadcom.com,
 anand.gore@broadcom.com, dregan@mail.com, kamal.dasu@broadcom.com,
 tomer.yacoby@broadcom.com, dan.beygelman@broadcom.com,
 devicetree@vger.kernel.org, Brian Norris <computersforpeace@gmail.com>,
 linux-kernel@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Vignesh Raghavendra <vigneshr@ti.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Richard Weinberger <richard@nod.at>, Kamal Dasu <kdasu.kdev@gmail.com>,
 Rob Herring <robh+dt@kernel.org>
References: <20240203002834.171462-1-william.zhang@broadcom.com>
 <20240203002834.171462-4-william.zhang@broadcom.com>
 <20240203-expenses-tarmac-c564bc7ae34f@spud>
From: William Zhang <william.zhang@broadcom.com>
In-Reply-To: <20240203-expenses-tarmac-c564bc7ae34f@spud>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000f362580610956c17"

--000000000000f362580610956c17
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2/3/24 06:49, Conor Dooley wrote:
> On Fri, Feb 02, 2024 at 04:28:24PM -0800, William Zhang wrote:
>> Add brcm,nand-ecc-use-strap to get ecc and spare area size settings from
>> board boot strap for broadband board designs because they do not specify
>> ecc setting in dts but rather using the strap setting.
>>
>> Signed-off-by: William Zhang <william.zhang@broadcom.com>
>>
>> ---
>>
>> Changes in v4:
>> - Move ecc strap property to this separate patch and remove some
>> non-binding related text from the description
>>
>> Changes in v3: None
>> Changes in v2: None
>>
>>   Documentation/devicetree/bindings/mtd/brcm,brcmnand.yaml | 8 ++++++++
>>   1 file changed, 8 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/mtd/brcm,brcmnand.yaml b/Documentation/devicetree/bindings/mtd/brcm,brcmnand.yaml
>> index d0168d55c73e..2599d902ec3a 100644
>> --- a/Documentation/devicetree/bindings/mtd/brcm,brcmnand.yaml
>> +++ b/Documentation/devicetree/bindings/mtd/brcm,brcmnand.yaml
>> @@ -147,6 +147,14 @@ patternProperties:
>>             layout.
>>           $ref: /schemas/types.yaml#/definitions/uint32
>>   
>> +      brcm,nand-ecc-use-strap:
>> +        description:
>> +          This flag indicates the ecc strength and spare area size should
>> +          be retrieved from the SoC NAND boot strap setting instead of
>> +          nand-ecc-strength and brcm,nand-oob-sector-size or auto detection.
> 
> I'm still on the fence about this being overly prescriptive about the
> operating systems behaviour. I think it would be good to say why the
> strap values are better than those explicitly provided in DT rather than
> just saying "these strap values should be used".
> 
This is a board/SoC design choice.  I wouldn't advise it as better 
choice as other board/SoC may not have that option. But definitively for 
BCMBCA SoC board design, it is better and much easier and convenient 
option than explicit dt setting. How about: This property provides a 
choice for retrieving ecc strength and spare area size from the SoC NAND 
boot strap setting. It is commonly used by the BCMBCA SoC board design.

>> +          This is commonly used by the BCMBCA SoC board design.
>> +        $ref: /schemas/types.yaml#/definitions/flag
>> +
>>       unevaluatedProperties: false
>>   
>>   allOf:
>> -- 
>> 2.37.3
>>

--000000000000f362580610956c17
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
JOEwDQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIAnNO7pTepM/uq4FcWwCV3db6CHS
r/5FQZoVjbrEIVkdMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI0
MDIwNDIxNTcwNFowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsG
CWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFl
AwQCATANBgkqhkiG9w0BAQEFAASCAQAwS5dzYmna/wpcSsNTM17dDWJBP+beyVxRIJzIFAXlIA94
cmP94btnt9+b0bJ6RBXFHzCpjMdhnNhzZYZJkJLs0N43XHUZeniCojYPvtRqg8AckSiAIzYTPBFb
QqhP6QxaQK7yAwadEjjvSSfEAg+IUoH9eAdstyZgdx8X9pQ9sqDjuBO2sE2uF+w83gSDXlrliW6O
f0dNT/m+EccP0lWrRfosUfydxFHhS/FGZoCMu2CCz1FLfILQr6893rUzSGtzCXVTRtzSBAlCwrU2
/HZRXqTHTKbPcm/5s22YYbI1KR0ap/gZfso0jZmae7MhLaFz+nxWTqGOu4vHfTGqoxhZ
--000000000000f362580610956c17--

