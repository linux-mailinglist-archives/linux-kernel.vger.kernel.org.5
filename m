Return-Path: <linux-kernel+bounces-53180-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AF15C84A1C6
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 19:05:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 45B0C2821F1
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 18:05:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B58F481C4;
	Mon,  5 Feb 2024 18:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="ADgUpBFj"
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 745F3481BD
	for <linux-kernel@vger.kernel.org>; Mon,  5 Feb 2024 18:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707156324; cv=none; b=Nn9fMTUjgGxOgnz6CIK6hheH2pkQ/AgHeciowg53mBzr2g9DAsVnA6AQNWGNmGxC1FQHetVAPakLhcdXFMau+RVoU4eJIZYi/xdkrVPdO4ZEDNmdS/d3V1Wwl+7jCfR1D5iDeiAvHbeUFHLmELQoD3OGggWKseb7PcLJQnfl8uA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707156324; c=relaxed/simple;
	bh=7VDgngpkCsDcAHb8brqhuIlFihOmupxQS5TErp83oHo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=K3HlIrZZTMK/D2rWyPv5BBgcSBX+9vF3S1LY9T/jO+pMpEnpSJimlX8wrffn3ofdWYE0xRzdRMdWidQz46b0GTOQ2PH6KXhJbdvRQQYDpY8IXuWkvZ3s4cn8GdBoAJlu4fwXrfGLb4A/bSDv/eDOjxDAkmjqCPfuOIEx6xuvwzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=ADgUpBFj; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-7856cce021dso76293985a.1
        for <linux-kernel@vger.kernel.org>; Mon, 05 Feb 2024 10:05:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1707156321; x=1707761121; darn=vger.kernel.org;
        h=in-reply-to:from:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=6YBbEBqJT87OvXz954g/uYD2rYDXCkt7LkJkFVO8USw=;
        b=ADgUpBFj5bjizNhVc428Rauop9ugfVWqxsFfbgCDBAxxm7/FG6lClNEqhx5Xt/APwg
         Lbgo2TA2bRR6mgVd0mcJETwX3j9i2V2Mbri7xGngaSLU4pMLE+PyZKzCNfzBJ1ehenmH
         tEx+5cd3Yson1hxRjny98FGtqZVaFreGYRwNk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707156321; x=1707761121;
        h=in-reply-to:from:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6YBbEBqJT87OvXz954g/uYD2rYDXCkt7LkJkFVO8USw=;
        b=drEnoVNlmTi7kKn9q1lkj1peDPJPMJnpWohZr6rHguooU6DNYW3o8AVIlQQgXdyPMl
         EsZ/f6virfC90L8BWUAOnAo/wGLYdQSCtqcgZmxIvLoQkYkTYPPVNevoy6ygnj3rVQY9
         HgoD1lpojhNkFXBpbEgl6QAIQ7KbII57VDVobA3xzS9bUR/UZGqJBE5oP77B3vVdmagC
         0tMDtoyUirUlhvX2D1QF/y4LOdGt9KWwisQxT05lMe6O9ZbELryS6ctcUNHd7HgHjAat
         /vnpJHFCb0e15U2vrpIWEZZTdGRS9KpuMGxHaaDwo6KH23bkNFHXk0zw7jHkChF82Q6B
         KsnA==
X-Gm-Message-State: AOJu0Yx1X8PRDjWJ3oUCGEibjoNQlQZHztuUcixhcgoTMSd6T+xGoAPu
	E4yAn1CDnKSQCd16VzKmJfpHMZ9bHmDcwceJf4CMKZDH1C9/aE0wNlXvZ5v7GA==
X-Google-Smtp-Source: AGHT+IHJOrG26UXg1GYrtgDsisBbqw4bUF1Iq+0bdiUtoBxha/UeZvQnBtl5u7pUiPolSadieaNBrw==
X-Received: by 2002:a05:6214:20a8:b0:685:98fd:f165 with SMTP id 8-20020a05621420a800b0068598fdf165mr130206qvd.49.1707156319110;
        Mon, 05 Feb 2024 10:05:19 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCXSnHQHIIeSV8QfzImLfo92wxRWfKadXEqGpluDeq1P1x2FB6Cv+m/nkbmMSMVLwuJyh3iHY+rg657QpRCpUgKwjwOAvVQUNWSk966I+RaPvJ1V8T/NDdtGpZHL5TGR6z2jDtx1jNyMHkLfCMjKejZQPL9NlxMnuTSXRApl2uophyf9+LmiMojvhp3j5w+MuU7jgtpExoq+hsDSHVzkCGfCYqLooYI1ewmKITQmAsfwqtT/uZTpe5q8Jc2WDqmpa79yrQjnDDhc6N4c37j0gSsO0qywmgFXo9xl+G5j9H7bTBmvdMGJw5DywWDsd0tftE94EYuluHD1LjE4/AssY80p8oLwo2BeN5pOQwemmgDwrew1taeiY0IGdouJK/sqCkJNI0/Qp/hlbkTQlJGkUQXexLkrtcA1z+4v+spxWFne5Tr/tEjFtJf0PEmzf3bhgDg0viCkpuKTxW3t8QTLpm9Ghd7F4fjBkNV+GDa0DGtfbpRYou+Ttl1XS2tnU9lf7UGtyGRmyZ8Za7KYvXQ56GXQNPwehOU+9VQ14kIzEj/TWPjLnWO3h+uxinctWlaz33uEK2AG+Pd0nCpSzjcpBEzZXr8bXPNUCfMmTMkoHIS/uQjefvHgHXDxfEMV9Dm33RiOqHLnT76kqAW/fS0MhSvsbgYhSmND+HpLUPgEHXKIWIPMF+UhtIRJdI86zzODFXSDkx2bZSH2OjEDj7vK9ot3w4+LbIoUOPF5LQ6i
Received: from [192.168.52.129] ([192.19.222.250])
        by smtp.gmail.com with ESMTPSA id lg6-20020a056214548600b0068caaba0e6dsm202211qvb.22.2024.02.05.10.05.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Feb 2024 10:05:17 -0800 (PST)
Message-ID: <ce15922e-4292-41d6-8c5f-2b4fbfa83d5c@broadcom.com>
Date: Mon, 5 Feb 2024 10:05:14 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 03/12] dt-bindings: mtd: brcmnand: Add ecc strap
 property
To: Miquel Raynal <miquel.raynal@bootlin.com>, Conor Dooley <conor@kernel.org>
Cc: Linux MTD List <linux-mtd@lists.infradead.org>,
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
From: William Zhang <william.zhang@broadcom.com>
In-Reply-To: <20240205142639.5d7c70f0@xps-13>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="0000000000001ade2c0610a64eab"

--0000000000001ade2c0610a64eab
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Miquel,

On 2/5/24 05:26, Miquel Raynal wrote:
> Hi,
> 
> conor@kernel.org wrote on Sat, 3 Feb 2024 14:49:50 +0000:
> 
>> On Fri, Feb 02, 2024 at 04:28:24PM -0800, William Zhang wrote:
>>> Add brcm,nand-ecc-use-strap to get ecc and spare area size settings from
>>> board boot strap for broadband board designs because they do not specify
>>> ecc setting in dts but rather using the strap setting.
>>>
>>> Signed-off-by: William Zhang <william.zhang@broadcom.com>
>>>
>>> ---
>>>
>>> Changes in v4:
>>> - Move ecc strap property to this separate patch and remove some
>>> non-binding related text from the description
>>>
>>> Changes in v3: None
>>> Changes in v2: None
>>>
>>>   Documentation/devicetree/bindings/mtd/brcm,brcmnand.yaml | 8 ++++++++
>>>   1 file changed, 8 insertions(+)
>>>
>>> diff --git a/Documentation/devicetree/bindings/mtd/brcm,brcmnand.yaml b/Documentation/devicetree/bindings/mtd/brcm,brcmnand.yaml
>>> index d0168d55c73e..2599d902ec3a 100644
>>> --- a/Documentation/devicetree/bindings/mtd/brcm,brcmnand.yaml
>>> +++ b/Documentation/devicetree/bindings/mtd/brcm,brcmnand.yaml
>>> @@ -147,6 +147,14 @@ patternProperties:
>>>             layout.
>>>           $ref: /schemas/types.yaml#/definitions/uint32
>>>   
>>> +      brcm,nand-ecc-use-strap:
>>> +        description:
>>> +          This flag indicates the ecc strength and spare area size should
>>> +          be retrieved from the SoC NAND boot strap setting instead of
>>> +          nand-ecc-strength and brcm,nand-oob-sector-size or auto detection.
>>
>> I'm still on the fence about this being overly prescriptive about the
>> operating systems behaviour. I think it would be good to say why the
>> strap values are better than those explicitly provided in DT rather than
>> just saying "these strap values should be used".
> 
> I don't know if there is a point is saying why they would be better, as
> they are not. It is a -questionable- design choice. However I would
> just get rid of any mention to other properties. Just say one should
> expect the strap value to be read and applied by the system when this
> property is present.
> 
Agree we don't need to say which is better as it is just a design 
choice. And it is used by all BCMBCA internal ref boards and customer 
designs. But if we just say strap value is read and applied, it is vague 
and nobody would know what is applied.  I replied this email yesterday 
and suggest the followings:

This property provides a choice for retrieving ecc strength and spare 
area size from the SoC NAND boot strap setting. It is commonly used by 
the BCMBCA SoC board design.

Hope this make everyone happy and we can move forward.


>>> +          This is commonly used by the BCMBCA SoC board design.
>>> +        $ref: /schemas/types.yaml#/definitions/flag
>>> +
>>>       unevaluatedProperties: false
>>>   
>>>   allOf:
>>> -- 
>>> 2.37.3
>>>    
> 
> 
> Thanks,
> Miquèl

--0000000000001ade2c0610a64eab
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
JOEwDQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIHovBHqM1raO73r4nriO30FZPHL0
FuDLyNt5OBJadNpKMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI0
MDIwNTE4MDUyMVowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsG
CWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFl
AwQCATANBgkqhkiG9w0BAQEFAASCAQBvBtnB6V3ghKjztyH2hKRlrJpbRu0U1UAs2mTATElzMKeH
4TmKc3Shekh2jM7mSYg25B+d6qw/HG2a/+NTmahWF1p0nAj3XB7g+4dlmP6qN4GWgY1OnxRlGLu9
duXFxtLTZvWDcYG39//+3RUidw+JFhNM3IzQNCm0b2WpWnx/bzDz8Ugj9JtQOhamJT+HeadA539O
Y8+Ianzl0PWF7jKDXUHJUcOK6I8jREDF0M4It2iAqYwqdL+/jJxmFZEUs4dWSap6BI5c8vMBJLs+
xMPesKKMwYdzYEUsiFEgIxVuifm6SAqMaKEXPUVgQnOSyeyeJ2VF9jbRE1WDkclhiMwt
--0000000000001ade2c0610a64eab--

