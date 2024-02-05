Return-Path: <linux-kernel+bounces-53198-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8160A84A200
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 19:20:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A659C1C223F0
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 18:20:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 185B845BFB;
	Mon,  5 Feb 2024 18:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="DStGpPX4"
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81C361B952
	for <linux-kernel@vger.kernel.org>; Mon,  5 Feb 2024 18:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707157227; cv=none; b=AcUULXbbWU8zcYDOH2NLGMQx96vxLk39dtL6wsltaXbq9bKOwARAsViInkhHBmWJkNx7Q5/51AS4NNsN30kPRZpwqUGnjWBItCcPTDZA5+j0qbPu5PfPFov+T9IsesUkBfEg6MSqFCm6O3SGfrCnBTPXpv3cRj2b2ynjT68OQDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707157227; c=relaxed/simple;
	bh=9j5bVFVXO1yGemtwrLRvufAQDB5qWEmcQN8JkGJEgLc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=a3xHk4vz+QNeMZ834ldVuIpEcFibnwhqgu5wmEtq53Ih42NKW3QWW0cL+Ves6zyK4VW5O5Bmqf5CHo8zzkgLTorPkcJYoGNRpcse0NLLSy+C8KjcG6YTdUuI2WQaa0RTt2IVAS/kgFEmBmPHgCOz7LX7kyixaixOZQV00mODI6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=DStGpPX4; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-78562c1ca4dso77219485a.0
        for <linux-kernel@vger.kernel.org>; Mon, 05 Feb 2024 10:20:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1707157223; x=1707762023; darn=vger.kernel.org;
        h=in-reply-to:from:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=RmyF1sJu7F0/rrHVXZmTII6pXGA6g5QBahhoUF0K4zk=;
        b=DStGpPX4jl8mntLbCC65yiBmZkwb0nZ7OLIinUMVheYq3w9sJDTZX6VwieUmOAYItT
         YiYvcT8mSS4NtcLsgXxQUdNfXhleMWiMPS6PZeyxPJ+pwBrCAP9mHpoGB/I0VweUg/MD
         HrpZk6iWYx9wjHO9xLLG24YyL90cjGNf2jwDQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707157223; x=1707762023;
        h=in-reply-to:from:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RmyF1sJu7F0/rrHVXZmTII6pXGA6g5QBahhoUF0K4zk=;
        b=kmeOKZxxKCijhCGmRO32RldONDwPn3HJdZsqh6AkglGdr3wxfb+SdGDyqY1/1HjkkV
         AhaRvkD01q3tDPlkKSCVLa3AW9sTxTsXan4jVwScqJy/0Jrmmm8b9YMePOMxdJXYrKMN
         wXLfP8B7+jdPttuwLXLEG3j3HC2wVGV5Gx4571/E0JTlk8m5GyWYdC7YTlCXOk5jBJxB
         Pb5RPHAipyLklFArQPaMoOaREwXtN1aryOv2nqvUjh80PPNuJdfsyahd+67+6qzKrCck
         bI26TvKUNbQu/Xpw+lIi0gisy2Bwy3NFf87RfX6VfSBfprgwbk78PMYVbBhwVCCHm9sX
         KgSQ==
X-Gm-Message-State: AOJu0YwW9b+G+SmhQUsS7vGLXZvbCWJ6D7yclcNbZWbH1LqZcdGlhLow
	hsh/S4AwBpLF2Xrmr7MNzFiJG1SDozzzksX0TX9UW76Y1/xw+XYnp1deJrCtQw==
X-Google-Smtp-Source: AGHT+IFiAyBISQABOUTXHzgAbqNJIzsZul9TFvA2cg6rohKZ2ECrktNlbK+NBzqzDiq1lwDp3Q8PpQ==
X-Received: by 2002:a05:620a:6189:b0:783:8d71:e4e6 with SMTP id or9-20020a05620a618900b007838d71e4e6mr214364qkn.76.1707157223219;
        Mon, 05 Feb 2024 10:20:23 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCX1krThgvCvjeHlU9YLFtQF2CqdhQ96Hp6oMQSBGVeIYUQoiQ77LkBYS1nSw094jy+XLugr2uCHGuvdwveHXHxuwSvXoESrSP+Lptmp7h6Ja3WrRQwSzUAYCsXmDVG/aoK7rP32uoR/QYg1FX+HA9wYdJMRnQx7uTeDjD7986N+ygeXk4jO5Jpi2ZMpT6NgOgjI6P54ugwdR+Fix50QtCHKcoSGHuVNCkM8Batln817emngE9xJhQNVvUis+hirMl+/gDl9a057iecFPa41zsMMGs7rtAF0FoJtoUhCHdm3lWVsg7teRrQEM5vAuvVkwoc5QEXhFrK3wSnn8agLlUuKcDHgYgrOpfOxFyr2SHB2UkT6A40WpQuGjGzQOBDki7f4ULhGhZFHUAOz9oarOkph28AI0gdkLH+3nzck7flA19zyTxoWpMIf4nptUmvV4Xr0+904AsI9I7ZkTkOJr6XVgh18khrqbBR0Oso83Tvnem6EzqUm6H+wSRFot57HvGNeYOWLWQtJFr9mrWUsssRtljeg6mFsD/CtLK0xdNQWUvkIxQofsj8bcggFSLJuWI5c
Received: from [192.168.52.129] ([192.19.222.250])
        by smtp.gmail.com with ESMTPSA id y5-20020ae9f405000000b00783dc450d84sm172363qkl.12.2024.02.05.10.20.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Feb 2024 10:20:22 -0800 (PST)
Message-ID: <2b299550-4cd8-4f32-93e4-71e529d7c266@broadcom.com>
Date: Mon, 5 Feb 2024 10:20:20 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 12/12] mtd: rawnand: brcmnand: update log level
 messages
To: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Linux MTD List <linux-mtd@lists.infradead.org>,
 Linux ARM List <linux-arm-kernel@lists.infradead.org>,
 Broadcom Kernel List <bcm-kernel-feedback-list@broadcom.com>,
 f.fainelli@gmail.com, kursad.oney@broadcom.com, joel.peshkin@broadcom.com,
 anand.gore@broadcom.com, dregan@mail.com, kamal.dasu@broadcom.com,
 tomer.yacoby@broadcom.com, dan.beygelman@broadcom.com,
 David Regan <dregan@broadcom.com>, linux-kernel@vger.kernel.org,
 Vignesh Raghavendra <vigneshr@ti.com>,
 Brian Norris <computersforpeace@gmail.com>,
 Richard Weinberger <richard@nod.at>
References: <20240203002834.171462-1-william.zhang@broadcom.com>
 <20240203002834.171462-13-william.zhang@broadcom.com>
 <20240205143745.5a1036c6@xps-13>
From: William Zhang <william.zhang@broadcom.com>
In-Reply-To: <20240205143745.5a1036c6@xps-13>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000e334920610a683c2"

--000000000000e334920610a683c2
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2/5/24 05:37, Miquel Raynal wrote:
> Hi William,
> 
> william.zhang@broadcom.com wrote on Fri,  2 Feb 2024 16:28:33 -0800:
> 
>> From: David Regan <dregan@broadcom.com>
>>
>> Update log level messages so that more critical messages
>> can be seen.
> 
> This commit log does not convince me. Warning messages are visible,
> they are in dmesg. If you want them on your console, lower your default
> console level by 1 and they will appear. I'm fine increasing the log
> level on error messages, but the justification cannot be specific to
> your own setup.
> 
It is mainly for troubleshooting our customer devices. Understand we can 
get the log through dmesg but when we deal with system hang issue, 
console log is very important. And also sometimes customer has rebooted 
the device due to error condition and we lost the dmesg.

How about we update the commit message to:
Update log level messages so that more critical messages
can be logged to console and help the troubleshooting with customer 
devices.

>>
>> Signed-off-by: David Regan <dregan@broadcom.com>
>> Signed-off-by: William Zhang <william.zhang@broadcom.com>
>> Reviewed-by: William Zhang <william.zhang@broadcom.com>
>>
>> ---
>>
>> Changes in v4:
>> - Revert the log level change for correctable ecc error
>>
>> Changes in v3: None
>> Changes in v2:
>> - Added to patch series
>>
>>   drivers/mtd/nand/raw/brcmnand/brcmnand.c | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/mtd/nand/raw/brcmnand/brcmnand.c b/drivers/mtd/nand/raw/brcmnand/brcmnand.c
>> index 7ce2b267676f..e50582b45182 100644
>> --- a/drivers/mtd/nand/raw/brcmnand/brcmnand.c
>> +++ b/drivers/mtd/nand/raw/brcmnand/brcmnand.c
>> @@ -1143,7 +1143,7 @@ static int bcmnand_ctrl_poll_status(struct brcmnand_host *host,
>>   	if ((val & mask) == expected_val)
>>   		return 0;
>>   
>> -	dev_warn(ctrl->dev, "timeout on status poll (expected %x got %x)\n",
>> +	dev_err(ctrl->dev, "timeout on status poll (expected %x got %x)\n",
>>   		 expected_val, val & mask);
>>   
>>   	return -ETIMEDOUT;
>> @@ -2196,7 +2196,7 @@ static int brcmnand_read(struct mtd_info *mtd, struct nand_chip *chip,
>>   				return err;
>>   		}
>>   
>> -		dev_dbg(ctrl->dev, "uncorrectable error at 0x%llx\n",
>> +		dev_err(ctrl->dev, "uncorrectable error at 0x%llx\n",
>>   			(unsigned long long)err_addr);
>>   		mtd->ecc_stats.failed++;
>>   		/* NAND layer expects zero on ECC errors */
> 
> 
> Thanks,
> Miquèl

--000000000000e334920610a683c2
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
JOEwDQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIAQc5n33l2jZiU6UoUHmcckwvJq6
Xc1DVwZy+P5iyFOXMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI0
MDIwNTE4MjAyM1owaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsG
CWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFl
AwQCATANBgkqhkiG9w0BAQEFAASCAQBMM/yWwCujtJQJRXjnBNuc/FRNeMDeqLqXWDIEqMok4XEz
IR3z7O52wkIxCCpU68XAM6DQeX2s56NAjwJ9VuKUlJAVDjeN+gBKMrHU1gp6XPF2EiTNkEV4fIdB
A/CG6hLPghoe4mG8gWCx7ocgRlkPeFhVHh3jUwMNZBUpQ8A34JExUFL6jUM7/htawp4NOg6FqchK
BCv3KCZBD4lfTKCqz148TB/toCvF55ceL07o5TIl535n1Eeslx2bDJVMRv1DdugOywnOX7G9C8se
GtqLP4g4yBiJkdltk2yBy51flykkGy81Q5VnIqkbSTjMxOF6++nOHxvjuTTi7SeUxJA5
--000000000000e334920610a683c2--

