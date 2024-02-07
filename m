Return-Path: <linux-kernel+bounces-55848-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 51F6584C276
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 03:22:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 096E928279E
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 02:22:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE7CADF6B;
	Wed,  7 Feb 2024 02:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="ZkvJJBQs"
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3FF1EED9
	for <linux-kernel@vger.kernel.org>; Wed,  7 Feb 2024 02:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707272519; cv=none; b=MXcxMSEJcS3JCzFGZpbHwHGNc+06PHPnCmjtOdbp8pIfVyvRFZ9LvHW7blnULPYNPeM95CNscuBIWPs79dmokQCbalbsdfL9I1ImvUoIBt1BthVtOK6MihIabk36ydHK4T0ju6Rpjb0me3iT1zu0GHAb91ZKk4rX1uc4gAExl9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707272519; c=relaxed/simple;
	bh=DtIBd2cB02fYw536FPWLG849MlYHRMp4r9zRrNZL3OQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=B6lVqfizj7UR75hhmJfWTbyAtmiiOPmKqk5ejQPe/bHpGdF35OPxzzWWx1bkZDa2j9yGqC+9Gqd6ePDTbr/Bfv1QhXP/L8vIrfRta8pzf12+No8fUfaGleiuAwcsMx+ut5O+l4UQf8QlEtNMvizdhvTj51baDjKRRE2NJyzd6wA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=ZkvJJBQs; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-42c2998d3a3so785951cf.3
        for <linux-kernel@vger.kernel.org>; Tue, 06 Feb 2024 18:21:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1707272517; x=1707877317; darn=vger.kernel.org;
        h=in-reply-to:from:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=cbKpELNvvoagUqB7EOVyKHoxupgM2pozM3Mefy7HuSs=;
        b=ZkvJJBQsTVFS3uTBkLlt6iPDJmWF/0oZLGcR7lHG9wTcjpKi7IzIocfanfUrylrtE2
         7wchGlcxi+dN56MXsSsI0PQtFfpDT7C3G6Nd+gdQgjjboEXcA2faNnSD65PEZ3Dt/yZ0
         GNGyc1FBmjAxNBOqtM2eZbIKWsQ/r0XhaF5Po=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707272517; x=1707877317;
        h=in-reply-to:from:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cbKpELNvvoagUqB7EOVyKHoxupgM2pozM3Mefy7HuSs=;
        b=kmfCHSGRwDRU06JAhB/4aE6XjQ4fcx8IYO/TksuX8EHeYZbGMJZFm4ovwzt3RJchPD
         FpmrtW9hYNtmWIanDAjblmT+7gDiyZYFgp64ql7Dkz2bkJT+MU5QLVWGDZxlURS+gEHP
         kG9LE9DCtjiSr65pK3x+Q5fnQsvcMQYSMrn+oyC4s0WjyGZMRkQH7EkVE9b93pjJ/PMN
         w5RyhF4fq6QourGq7QiDNpvrlDwt2nSW9O6dagC31c3RfvWuPsYZ80shbahGfqnYAgHQ
         dTfT+PSMY3ECRF4JjuAGHs3YRjG2ado6erRCbVqLOv+zYft0YF5YC7U3G00sCk+oK72N
         1eEA==
X-Gm-Message-State: AOJu0YxHEMa+7TSPMGXyjMc97ylk22DKQL+fFWU8sL+uD7IJEudohkrp
	JhZoOuItm+wowgEIqWdILwuwt1IQju+9sGFqUNktMgVVkNR6muEtpwvunvBi0A==
X-Google-Smtp-Source: AGHT+IFHxpBKqU/LZONSi0Bp6d0fDUaqgDHs6WoTtI6vmkdRTjErWkjxirbzqpgRc48uAmFLQ823zw==
X-Received: by 2002:ac8:5b92:0:b0:42c:b61:ef3c with SMTP id a18-20020ac85b92000000b0042c0b61ef3cmr4498599qta.43.1707272516803;
        Tue, 06 Feb 2024 18:21:56 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVvzG0DHnHwJCvMf+xtuQOQyIyeZ28UWpvFZPskQgn6NAxMVHi5DQrBfV8NH0YjfWCzgM8ypCM41TVXMscnDBMVlbKTaHJ8F1tazBghGS9ZU2ow8tEbPZvjpfLBYuwCOVCH5CvQLL4zbOMjX73ez68Q4xCg/v8z/fPzNj06AOE5FLmzX7mBMO1+jfITFPjaWGP3qWoWGd5MpubKOH2qj69jq56PX6KqeqitTg1socWQTaL6aRvfYvVmpx4bLM4tsX0gZSX1uzpVLv34pb9Qczvxcm64qIvbvqm0FA8tw8BZYTCDVLFMDG5xIFphxEKzsfcnsEYaNS0FjozucagBGhbDZ4smAaTSxac0u0qXa877xb+6SChQK5ZSguMo4AJ2vJfLXlgJjAkx0imcAKxi6l9phFgs9m5Zcg+mlTUEfcafMA4N4zsELZzmZNtNxWrfsHJDiobdGWkELC0+H2n/T53vwcGsXm0svt67s8a3ABR5U2s4aQcpgbXti0+SWhUPubN1EV6/kUNbp/THTVTWoX2fYi/99jxIPw5hxNaVmg+yE7Lgwl38yOzoQ2CYwX11WkxIsGDe8U3Iikc7cOscTS78EgPhHfdCnVXdNm+6Mg5/SgD8+sqLNm0E23Q5x1SLD8yP8s4m9f1GHF1Vm9CanEjLOdP00CozWyv0hIF+bbqwiv6EyT1upbEYru7vYCG/qOh83YDvaLM6qKUJn0A4i6koXHGrCg==
Received: from [192.168.52.129] ([192.19.222.250])
        by smtp.gmail.com with ESMTPSA id z8-20020ac87ca8000000b0042992b06012sm108957qtv.2.2024.02.06.18.21.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Feb 2024 18:21:55 -0800 (PST)
Message-ID: <376d63f1-fd01-4fc2-a8fa-d59361910f3d@broadcom.com>
Date: Tue, 6 Feb 2024 18:21:52 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 03/12] dt-bindings: mtd: brcmnand: Add ecc strap
 property
To: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Conor Dooley <conor@kernel.org>,
 Linux MTD List <linux-mtd@lists.infradead.org>,
 Linux ARM List <linux-arm-kernel@lists.infradead.org>,
 Broadcom Kernel List <bcm-kernel-feedback-list@broadcom.com>,
 f.fainelli@gmail.com, kursad.oney@broadcom.com, joel.peshkin@broadcom.com,
 anand.gore@broadcom.com, dregan@mail.com, kamal.dasu@broadcom.com,
 tomer.yacoby@broadcom.com, dan.beygelman@broadcom.com,
 devicetree@vger.kernel.org, Brian Norris <computersforpeace@gmail.com>,
 linux-kernel@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Vignesh Raghavendra <vigneshr@ti.com>, Richard Weinberger <richard@nod.at>,
 Kamal Dasu <kdasu.kdev@gmail.com>, Rob Herring <robh+dt@kernel.org>
References: <20240203002834.171462-1-william.zhang@broadcom.com>
 <20240203002834.171462-4-william.zhang@broadcom.com>
 <20240203-expenses-tarmac-c564bc7ae34f@spud> <20240205142639.5d7c70f0@xps-13>
 <ce15922e-4292-41d6-8c5f-2b4fbfa83d5c@broadcom.com>
 <20240206103453.7ac23384@xps-13>
From: William Zhang <william.zhang@broadcom.com>
In-Reply-To: <20240206103453.7ac23384@xps-13>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000eb4f4f0610c15b6c"

--000000000000eb4f4f0610c15b6c
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2/6/24 01:34, Miquel Raynal wrote:
> Hi William,
> 
> william.zhang@broadcom.com wrote on Mon, 5 Feb 2024 10:05:14 -0800:
> 
>> Hi Miquel,
>>
>> On 2/5/24 05:26, Miquel Raynal wrote:
>>> Hi,
>>>
>>> conor@kernel.org wrote on Sat, 3 Feb 2024 14:49:50 +0000:
>>>    
>>>> On Fri, Feb 02, 2024 at 04:28:24PM -0800, William Zhang wrote:
>>>>> Add brcm,nand-ecc-use-strap to get ecc and spare area size settings from
>>>>> board boot strap for broadband board designs because they do not specify
>>>>> ecc setting in dts but rather using the strap setting.
>>>>>
>>>>> Signed-off-by: William Zhang <william.zhang@broadcom.com>
>>>>>
>>>>> ---
>>>>>
>>>>> Changes in v4:
>>>>> - Move ecc strap property to this separate patch and remove some
>>>>> non-binding related text from the description
>>>>>
>>>>> Changes in v3: None
>>>>> Changes in v2: None
>>>>>
>>>>>    Documentation/devicetree/bindings/mtd/brcm,brcmnand.yaml | 8 ++++++++
>>>>>    1 file changed, 8 insertions(+)
>>>>>
>>>>> diff --git a/Documentation/devicetree/bindings/mtd/brcm,brcmnand.yaml b/Documentation/devicetree/bindings/mtd/brcm,brcmnand.yaml
>>>>> index d0168d55c73e..2599d902ec3a 100644
>>>>> --- a/Documentation/devicetree/bindings/mtd/brcm,brcmnand.yaml
>>>>> +++ b/Documentation/devicetree/bindings/mtd/brcm,brcmnand.yaml
>>>>> @@ -147,6 +147,14 @@ patternProperties:
>>>>>              layout.
>>>>>            $ref: /schemas/types.yaml#/definitions/uint32
>>>>>    >>> +      brcm,nand-ecc-use-strap:
>>>>> +        description:
>>>>> +          This flag indicates the ecc strength and spare area size should
>>>>> +          be retrieved from the SoC NAND boot strap setting instead of
>>>>> +          nand-ecc-strength and brcm,nand-oob-sector-size or auto detection.
>>>>
>>>> I'm still on the fence about this being overly prescriptive about the
>>>> operating systems behaviour. I think it would be good to say why the
>>>> strap values are better than those explicitly provided in DT rather than
>>>> just saying "these strap values should be used".
>>>
>>> I don't know if there is a point is saying why they would be better, as
>>> they are not. It is a -questionable- design choice. However I would
>>> just get rid of any mention to other properties. Just say one should
>>> expect the strap value to be read and applied by the system when this
>>> property is present.
>>>    
>> Agree we don't need to say which is better as it is just a design choice. And it is used by all BCMBCA internal ref boards and customer designs. But if we just say strap value is read and applied, it is vague and nobody would know what is applied.  I replied this email yesterday and suggest the followings:
>>
>> This property provides a choice for retrieving ecc strength and spare area size from
>   the SoC NAND boot strap setting. It is commonly used by the BCMBCA SoC board design.
> 
> What about:
> 
> This property requires the host system to get the ECC strength and step
> size from the SoC NAND boot strap setting. This is a common hardware
> design on BCMBCA based boards.
> 
Sounds good.  Will update.

> I would also like to constrain this more by adding an exclusive use wrt
> the nand-ecc-* properties. So either you put this property, or you put
> the generic nand-ecc-* properties, or you put nothing (which, again, is
> by far the best solution), but in no case you can have a mix.
> 
Right, nobody should have a mix but in case it happens, the driver code 
handles that well by taking nand-ecc-* property. So not sure if the 
exclusion check is really important. Anyway I will add a condition check 
in the yaml on them as you requested.

>>
>> Hope this make everyone happy and we can move forward.
> 
> I was advising to avoid mentioning too specific DT properties, but
> mentioning the kind of impact it has (on the choice for the ECC
> strength and size) is fine.
> 
>>
>>
>>>>> +          This is commonly used by the BCMBCA SoC board design.
>>>>> +        $ref: /schemas/types.yaml#/definitions/flag
>>>>> +
>>>>>        unevaluatedProperties: false
>>>>>    >>>   allOf:
>>>>> -- >>> 2.37.3
>>>>>     > >
>>> Thanks,
>>> Miquèl
> 
> 
> Thanks,
> Miquèl

--000000000000eb4f4f0610c15b6c
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
JOEwDQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEILZWPguz3TLCnaSDd99SoDyrkGJs
k5WSYQpFh3P17nFKMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI0
MDIwNzAyMjE1N1owaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsG
CWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFl
AwQCATANBgkqhkiG9w0BAQEFAASCAQBm44g544lSIWbsIKESPmD2HL0JTW0OypmXEBnDUWEitR5H
19ULIQnx+wd8NU3Px9PuyF5ULLu8w2O4fYUWmoj5P30I9w/waOVaEP545Xu2Ppm1aYRpQkBJUMp7
5kfj9jxQhqHJ92akOwpFdKf6O/Z843buWhtK64Olx4PGG8EyxSqr7vF52KyIQhpzqc9xVUNyj138
Uz6n4yHUXaasBMrmzXgDji1ZAFYYJ8VP5nb4aTCqcZ3UwakK5j+BmPeVpif4nEq7Si0kw/Ui0oqd
Zdk3s4IwMXvcAI8yOnUqYNDHBxS+MJ6TABKa25ia88m4Hq17nbWQ/AG7xFzO1RkknX+M
--000000000000eb4f4f0610c15b6c--

