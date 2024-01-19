Return-Path: <linux-kernel+bounces-31460-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FDDE832E9E
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 19:05:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F3E06288271
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 18:04:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B3C05644A;
	Fri, 19 Jan 2024 18:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="ZnjfcbAd"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E321355E52
	for <linux-kernel@vger.kernel.org>; Fri, 19 Jan 2024 18:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705687492; cv=none; b=Ip6Skq/cwuHg1gQcs6EpO5O8dmr6wX+ZgNdYICNHzgEMA5rkejGTzQw08hLWRwz1dehhDusNrk30Jn3pIjkpDNe0W3OlKkidpusm3w4ZKE6LvBtc6a9JtuSRSve+7kwy8xUb8rmCKGcI1DjkIuOnGGQvfrFoCFikjDKi8ftYD4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705687492; c=relaxed/simple;
	bh=0adsIV58OGL4ddQbduwldSXNHT1jOHFYD3bhqvk+3Fk=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=m862irWD/FHt8YL7c1ZhJU0vMCVoXiZ8EgYullWeYBzjNVVBVpAtxI6LEHY3mvTULTkyms2upvFDLmTonp1yW3dJhUkZkVyrUqOB6aEmoTdnvnz6M9L+pCE/DdFOyBUFfO8ngY/lzb3x0ecE4t6zRA2EhYVD11UI7S4DMfmgIPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=ZnjfcbAd; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1d5f56912daso8891195ad.2
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jan 2024 10:04:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1705687490; x=1706292290; darn=vger.kernel.org;
        h=in-reply-to:mime-version:user-agent:date:message-id:from:references
         :cc:to:subject:from:to:cc:subject:date:message-id:reply-to;
        bh=cncpCeu/bgvNp/m1Gq+fWTN/P/OBL8eTVb4COm3sYu0=;
        b=ZnjfcbAdeF4MOzBWzydL5/AK7JgDWADZsE3IdokWfDTVps2qEEuMCIduPhgDhKWuhC
         JTyznLYs32VgmeLKRuQow7yca+MuR9QqxE/YAdfmy44hBok1GyzvfLrT+NiAMui09AMq
         tTjIvKwmecxiBf1rpje19/BtWSB8AdRmOvQpA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705687490; x=1706292290;
        h=in-reply-to:mime-version:user-agent:date:message-id:from:references
         :cc:to:subject:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cncpCeu/bgvNp/m1Gq+fWTN/P/OBL8eTVb4COm3sYu0=;
        b=SG9mSqC7DN4IEy5EWCueMUvhhPxPXZw13HYZSOwXT4MJLqzrPcCBrZHJ37ovaGLhwx
         AINp6kai6uV8IpbdkaRJ1uRwfglCoA99FBmzGHcJTZX4M/wstxPd2ekXmHx3kwT0uCQE
         71Sb/FnFbn0/WoDIxt1QMzDFGQ/KWJ+ghORH1ZFAGJMEj6oZuf4BocyM9RgzVWskHoMW
         5qd7MRpfbGDblRG5miVy5IGqSHDwFI6gTwD83J1LxkVAP1rYnKlpvsjArP9KLGg4d8zw
         1/y/wrcIHdt1sAshfx6BilLoFQhZnCWq4qtc3lWHkgbJ2V0UgjSPK/bcO7NN7dK0l+jN
         nuEg==
X-Gm-Message-State: AOJu0YzG1XD/WgUEX1k55Ez1yAQ5XfaBbjtyKGaD8lVm92L5cWkH2Put
	G0uxbKypald936a6OARkSZMKaZtlTOxMaKZ32ubdFuX9UV22r6FPRWcohMeCNw==
X-Google-Smtp-Source: AGHT+IHXUxTE1TDvyZbks48OoPrImAzVoDuqMzay6upKNKHqc4tOpJRXE8j7pVhUiO8JAdt9xGwnCA==
X-Received: by 2002:a17:902:d4c3:b0:1d7:1ef5:d325 with SMTP id o3-20020a170902d4c300b001d71ef5d325mr376859plg.34.1705687490137;
        Fri, 19 Jan 2024 10:04:50 -0800 (PST)
Received: from bcacpedev-irv-3.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id lc11-20020a170902fa8b00b001d40cc2c9c3sm3322709plb.35.2024.01.19.10.04.47
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 19 Jan 2024 10:04:48 -0800 (PST)
Subject: Re: [PATCH v2 05/10] mtd: rawnand: brcmnand: Add BCMBCA read data bus
 interface
To: Dan Carpenter <dan.carpenter@linaro.org>, dregan@broadcom.com
Cc: dregan@mail.com, miquel.raynal@bootlin.com, richard@nod.at,
 vigneshr@ti.com, robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
 conor+dt@kernel.org, computersforpeace@gmail.com, kdasu.kdev@gmail.com,
 linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, joel.peshkin@broadcom.com,
 tomer.yacoby@broadcom.com, dan.beygelman@broadcom.com,
 anand.gore@broadcom.com, kursad.oney@broadcom.com,
 florian.fainelli@broadcom.com, rafal@milecki.pl,
 bcm-kernel-feedback-list@broadcom.com, andre.przywara@arm.com,
 baruch@tkos.co.il, linux-arm-kernel@lists.infradead.org
References: <20240118195356.133391-1-dregan@broadcom.com>
 <20240118195356.133391-6-dregan@broadcom.com>
 <4b3f4316-0da4-4fde-a806-7b579948db50@moroto.mountain>
From: William Zhang <william.zhang@broadcom.com>
Message-ID: <61f3cc1e-66f4-86d7-659b-9ff1219b4274@broadcom.com>
Date: Fri, 19 Jan 2024 10:04:46 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <4b3f4316-0da4-4fde-a806-7b579948db50@moroto.mountain>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000f874ac060f505058"

--000000000000f874ac060f505058
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit

Hi,

On 01/18/2024 09:36 PM, Dan Carpenter wrote:
> On Thu, Jan 18, 2024 at 11:53:51AM -0800, dregan@broadcom.com wrote:
>> diff --git a/drivers/mtd/nand/raw/brcmnand/bcmbca_nand.c b/drivers/mtd/nand/raw/brcmnand/bcmbca_nand.c
>> index 3e2f3b79788d..e97e13ae246c 100644
>> --- a/drivers/mtd/nand/raw/brcmnand/bcmbca_nand.c
>> +++ b/drivers/mtd/nand/raw/brcmnand/bcmbca_nand.c
>> @@ -26,6 +26,18 @@ enum {
>>   	BCMBCA_CTLRDY		= BIT(4),
>>   };
>>   
>> +#if defined(CONFIG_ARM64)
>> +#define ALIGN_REQ		8
>> +#else
>> +#define ALIGN_REQ		4
>> +#endif
>> +
>> +static inline bool bcmbca_nand_is_buf_aligned(void *flash_cache,  void *buffer)
>> +{
>> +	return IS_ALIGNED((uintptr_t)buffer, ALIGN_REQ) &&
>> +				IS_ALIGNED((uintptr_t)flash_cache, ALIGN_REQ);
>> +}
>> +
>>   static bool bcmbca_nand_intc_ack(struct brcmnand_soc *soc)
>>   {
>>   	struct bcmbca_nand_soc *priv =
>> @@ -56,6 +68,20 @@ static void bcmbca_nand_intc_set(struct brcmnand_soc *soc, bool en)
>>   	brcmnand_writel(val, mmio);
>>   }
>>   
>> +static void bcmbca_read_data_bus(struct brcmnand_soc *soc,
>> +				 void __iomem *flash_cache,  u32 *buffer, int fc_words)
>> +{
>> +	/*
>> +	 * memcpy can do unaligned aligned access depending on source
>> +	 * and dest address, which is incompatible with nand cache. Fallback
>> +	 * to the memcpy for io version
>> +	 */
>> +	if (bcmbca_nand_is_buf_aligned((void *)flash_cache, buffer))
>> +		memcpy((void *)buffer, (void *)flash_cache, fc_words * 4);
>> +	else
>> +		memcpy_fromio((void *)buffer, flash_cache, fc_words * 4);
>> +}
> 
> This comment is confusing or maybe the if statement is reversed...
> We're falling back to memcpy_fromio() for the unaligned accesses but the
> comment says we're falling back to memcpy().
> 
Yes that's a typo. Fallback to memcpy_fromio when unalgined.  Will 
update the comments in v3. Thanks!

> regards,
> dan carpenter
> 

--000000000000f874ac060f505058
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
JOEwDQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIHG99h/evlbXjkEiueEHtlGjPoyC
Y5F4U8avZ/jNl85GMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI0
MDExOTE4MDQ1MFowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsG
CWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFl
AwQCATANBgkqhkiG9w0BAQEFAASCAQCtDfAtQjyUkzgplV+Yv01ykYQ71ciHLUddlKZojRXpNqcS
oVItDODTro/zUThq2dyqp2tzm8ieZXHMHgNI/kAZdZxGDRLeTOm9v/9g0Fo1qmpILG4EQmlv5uEy
L8H42hHNhdhXZGWY3dIJUs9EnECzrAWfB2LCO0US8b879LkcUFJnlj00Ozk4KJrsrlvkLcSde9+8
ghVd1JO0E1y8LIQ1ka7gG6UrDdZsHguOHUVPKINuBf5ATeuXgGClnDaslsC1jl53dri2K7YPBKq7
IMa4xJnufHtfoOf/01wHSp9KPPxv6LnYmlNm6o096DjTEs+ta0i4iwnddqF0Xcl1FnPP
--000000000000f874ac060f505058--

