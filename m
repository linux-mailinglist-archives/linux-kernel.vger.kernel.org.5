Return-Path: <linux-kernel+bounces-53181-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9947784A1C8
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 19:06:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 502D7285681
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 18:06:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5438947F52;
	Mon,  5 Feb 2024 18:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="ZjGnRZgG"
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEA9247F47
	for <linux-kernel@vger.kernel.org>; Mon,  5 Feb 2024 18:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707156389; cv=none; b=cp0FUZ1VB6EfTt4LOv8Cu6h5XcJPIfuLnfRkOBzH4gBALxut6T6r6aDuJqZoIqh/z1SFgf9SDUCVU8nIyjnv6vWaX07l6kYwc5iSJqhjtsW29YgdhIc2sQ0dIcCIlhDF1ZiHmt5XcFSxr/uQThkNNkRRtae3hQ1KHzfhfw2lzsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707156389; c=relaxed/simple;
	bh=Qw3DJ3VWFEOjJV1OwAas5ndctgBu8AUulhPfcYXt58c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RMiaIufV8xhWmyoaeZVtkG/NYhBVocXKkFHQHGvdGsBgYJfQBBYe1YMm/u/ifOT/xZE3S4vGL9/2tObxNm6S/ZpNzTCFbsa3Ze/MkxjqXPHUIYg2zZsIzZnPZsqiPT5OvaupWiL9+Cwmdz5bA7NucYhL0A4rQuE3iaS/BdDep7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=ZjGnRZgG; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-7855f794d4eso186953085a.1
        for <linux-kernel@vger.kernel.org>; Mon, 05 Feb 2024 10:06:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1707156387; x=1707761187; darn=vger.kernel.org;
        h=in-reply-to:from:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=IqXTvOwHfUn4wrFba5p6mR2SFvRl1h4AvNB42gns4gg=;
        b=ZjGnRZgGjJzBoZ0/CQlDN2VcdxJCEKmccfvlCAZFkHzWYLbE+YSE3Ulf0OuajNzTfC
         gdvyYaDuj02KZwL+XMFcXG3vdPT7qZ2X9qb93cqqMJknoFYM4uJT957gB7bQnq7eMozl
         fgPG7cg/PgfwUpHEpiGI18iAebIw0gwIRbK4Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707156387; x=1707761187;
        h=in-reply-to:from:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IqXTvOwHfUn4wrFba5p6mR2SFvRl1h4AvNB42gns4gg=;
        b=tBkSbVNVhg6ZSMlmlSg+HypqUPkVaUmLNvlySBBSsszaeVuN7NFzmcoJ2G4TtD0eaN
         KM0Nw49dRYQCK/oEoMVnP+7KfoPB6vJQ5zLQenSHcdzf/wXYJHIQPUqXZa5lz+4KGdbW
         A7ITsWl4K5hGC3fM1V1oIVrvIC2R0JXKZ0Rks0qMPTZA+SUO+iBWXj0Cx6uidVD8/Fdt
         oheda0nu4sbRSvvqDQocapLvM5JMzxmI51HfQwPU3NCLhR7B/40mnd6CUKYNMzGrN/+f
         ROQ4ROWfg4QbmG+pCg3RY7snAoHA1pLI+il3GECiDOlKuO3zBmxFvJPJz12UoTNGzVJ6
         uHBw==
X-Gm-Message-State: AOJu0YxPADkAymCuqBcHFf53ZcKCm/zAztqSgqP5hIWoIZw5qCRYygIr
	a2coO5NB46RY1qJjo7MehiBbGPINZyFdCbHguGkNwuoqltmUuENpYnlExJBjFg==
X-Google-Smtp-Source: AGHT+IHSue1UuS9+DoYX5BhnMat3iD8XRM1wDdIBAzTAqnia76SENpvbzSvYijHIdhWeTkzPTgfUXQ==
X-Received: by 2002:ad4:4525:0:b0:68c:72e3:5612 with SMTP id l5-20020ad44525000000b0068c72e35612mr12390401qvu.25.1707156386694;
        Mon, 05 Feb 2024 10:06:26 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCUe7LzsZssn7/2zfudUWQnL/k2YMTa8VI8DPbmZMlGxx7dfznK4ss4v2eUa14/TlN8CJT257krj3o1GAT+L6xypEoVVOKPOodrGUhmFvNxevK7XpsEL+DoJHAOE+iNYmTwsfWNjmFv55dPViM2CqYouKOW48E84W82Sz+ee9FGxNkTB4SMc6SBr60rgO9tF8quptFj1umEGH5xXOLYOv5fb81uVu6CBU9d0mrLroHnz6wTQuJm4MJZ9fNsDAVudUzgV+RVhJTEY6muhGtKw0qUxnlI2o9f2NHCvUDZj711DZE9nKIbckc/pZsZjhReYpfayWP7r8HOdrl3bHO07no3e/N1daANfsFgi/C9LiltfBCFgXLIfCkLtGQlqfo/d7kOsdMIi6Ukb5N0qo6BWliDI7APHvEM6K5GHTynDjjXy0uKKk88pJUhT2bbEHTGDaZrHQpwsYJY3tqtdnEna/fQ1t+KcqN62s2q1YZZGRC6jvYzw+sU5jo/QbQaEf9QNpzGnc0mM0LlWH29sb90WmkSjX7e6lQL3NU2k9lKLQT75pwrQOPq8E/H6086fo++/WXKwEPUjDD5ybbORs/JO6GGWbFSiq7x8iomkaQWZF1K3+0uOQOa7A7ntF61P9/avHUEN7cLNJFRxssKpiJXmKKE+KnL1DRKAIhcqIUWySGoYqxnu/4Uq1mJpd7N+0AwPII+fViqFdQ+J3RVK
Received: from [192.168.52.129] ([192.19.222.250])
        by smtp.gmail.com with ESMTPSA id lg6-20020a056214548600b0068caaba0e6dsm202211qvb.22.2024.02.05.10.06.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Feb 2024 10:06:25 -0800 (PST)
Message-ID: <ee201484-78b4-4c7a-97ad-e5dea0748b04@broadcom.com>
Date: Mon, 5 Feb 2024 10:06:23 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 02/12] dt-bindings: mtd: brcmnand: Add WP pin
 connection property
To: Miquel Raynal <miquel.raynal@bootlin.com>
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
 <20240203002834.171462-3-william.zhang@broadcom.com>
 <20240205143246.52ee97ec@xps-13>
From: William Zhang <william.zhang@broadcom.com>
In-Reply-To: <20240205143246.52ee97ec@xps-13>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000063a430610a652e3"

--000000000000063a430610a652e3
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2/5/24 05:32, Miquel Raynal wrote:
> Hi William,
> 
> william.zhang@broadcom.com wrote on Fri,  2 Feb 2024 16:28:23 -0800:
> 
>> Add brcm,wp-not-connected property to have an option for disabling this
>> feature on broadband board design that does not connect WP pin.
>>
>> Signed-off-by: William Zhang <william.zhang@broadcom.com>
>>
>> ---
>>
>> Changes in v4:
>> - Move the WP pin property to this separate patch and change it to
>> boolean type.
>>
>> Changes in v3: None
>> Changes in v2: None
>>
>>   Documentation/devicetree/bindings/mtd/brcm,brcmnand.yaml | 8 ++++++++
>>   1 file changed, 8 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/mtd/brcm,brcmnand.yaml b/Documentation/devicetree/bindings/mtd/brcm,brcmnand.yaml
>> index e54ca08a798a..d0168d55c73e 100644
>> --- a/Documentation/devicetree/bindings/mtd/brcm,brcmnand.yaml
>> +++ b/Documentation/devicetree/bindings/mtd/brcm,brcmnand.yaml
>> @@ -113,6 +113,14 @@ properties:
>>         earlier versions of this core that include WP
>>       type: boolean
>>   
>> +  brcm,wp-not-connected:
>> +    description:
>> +      Use this property when board design does not connect controller's
>> +      NAND_WPb pin to NAND chip's WP_L pin and disable the write
>> +      protection feature. By default, controller assumes the pin is
>> +      connected and feature is used.
> 
> I would rephrase slightly. What about:
> 
> 	 WP pin is not physically wired to the NAND chip. Write
> 	 protection feature cannot be used.
>   
That's fine with me.  Will update.

>> +    $ref: /schemas/types.yaml#/definitions/flag
>> +
>>   patternProperties:
>>     "^nand@[a-f0-9]$":
>>       type: object
> 
> 
> Thanks,
> Miquèl

--000000000000063a430610a652e3
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
JOEwDQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIG4zdFiLAxU3fVRYBT83S0IF//UK
ZvA+hJCa9kJvDQgfMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI0
MDIwNTE4MDYyN1owaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsG
CWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFl
AwQCATANBgkqhkiG9w0BAQEFAASCAQAHu2oVhwwRxt/CKoNXxYQ/XN+CCYZmZeb3BzuuE4I5iZKF
fLRqSm4yqk7j8WcH0yTcLrd23FchQ7K5yIUAwiXCZ5n2gTO5ZW4D4vjtAGUlZsgEK1ltK4A2OVbX
Mbjy030WoKRrVfM2DVgSHPayvC+ZuUbU13s72sqRHGdyte9hcBdAmpVsjWbRQwWW1c8h5cQT+4JJ
5jEQLpaBhPJW2rARkDgaisyg9wIf0DxwpcYV2VTS297Z9qlJTchpAnvXqVPDnO8l9tAA9JpY59VN
7fdQ8QYJ7iFylVkRtPXtKRmFKD1tzKjCflM2E0Lmu0//YjcE1FuwbnAgiGmrqfGmN1rm
--000000000000063a430610a652e3--

