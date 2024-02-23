Return-Path: <linux-kernel+bounces-77720-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B160860970
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 04:35:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F007F1F2584B
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 03:35:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72B45D51B;
	Fri, 23 Feb 2024 03:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="EzCB1Ltv"
Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com [209.85.161.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F74DB67F
	for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 03:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708659319; cv=none; b=EilH4fErgwUgsyKzII4P0i5m1Wae0/r882rfdENQyElPSYni4z3xHw9+LhoTlJrdb1G6naIkm7gklW5mvvGvkNBhYWdQq587yQ3hgGMWMeGa9uv7IFE6BLMo3KsdMVGKMJ8IWLPOKbQd6ssczqNfEHD23F6lzz9NVVrcJCxuX4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708659319; c=relaxed/simple;
	bh=xOvTPWzf2TA9P2Jc5FhlM7e5i+onmGPy+QbA9X5NyBo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=awjM0OH0hPgOAbWDr+bmibiVCaoVq9jLZPADhGgLhKHv1rcSXAxlPAtpCXOFcweOUdp+IQpNBbN/9Ta2y9eF05fCbSJFuZh8DaRBG5ZiYGj+vaDen3gVFecsMrmax84RRCvXrVt4v1ahoB7Pd5MxiF08gdPyOUeSaM7DnAxmQzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=EzCB1Ltv; arc=none smtp.client-ip=209.85.161.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-599f5e71d85so320989eaf.3
        for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 19:35:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1708659316; x=1709264116; darn=vger.kernel.org;
        h=in-reply-to:from:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=o6O98Mx27kMgNoQlVK6z4YAr8sQi3wup+myZf2tYKBM=;
        b=EzCB1LtvET6pIz+RUcRo1h79jJdrufj6lpKnMNdVVlq8u1+1wBx/GgK6UQKJ45rWNB
         qtJaFC+NuH+UGZUsjP96hVxmVtebMt3Xbwg7Sn4ntuyIvg41xMxJRGH3kIYtx6cCUAtM
         kJ1Ky8EbMmQBT2WurT2Sxr2e7LmKOpNWYMuzU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708659316; x=1709264116;
        h=in-reply-to:from:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o6O98Mx27kMgNoQlVK6z4YAr8sQi3wup+myZf2tYKBM=;
        b=Czaem7un26hRsJowLX1T4tfevGyGBVpJz/Z8oVYo9pzHd//Gcn7HGe4+QZpODf9SYN
         SmzC3fTZ41qO511ACcFPr6cSSPKAaA6nV2EbfwIFnuBA5/wGDWcSdlNVSrCkx4bQzgHq
         4zeOSKBrIQw7plcYdTQmBkGIvQwE66gjvFlcs/zVOZWGAHzUMNAJek+0YQEnEcXLrGsx
         jzwp94wyElZpzRBj2X6nDuaRgiX9ewwlEVnc02rLuczrvkxOsSn/JyiazG5rHzIxh2I7
         btRdwHqoayXYAEx7bP/laZDNrc1Lc631hgoZE8m1TLnJFZJj0LtMOX5uoP6VDVUVMWr3
         S2fQ==
X-Forwarded-Encrypted: i=1; AJvYcCX+WMNYbOQKddPy+JxB+bsc8VsYnqX/EwKZXacXR/bpEsunDobbDtTyYsfVK6ABuTnMGl3fklPNAUUSb0QK1f8tzdpKoTZW1w1CGJqr
X-Gm-Message-State: AOJu0Yyp9gbSfm1QQEoCHUKPQamznOM7DSQ4gDagWSuAdzk5pTL8qaOA
	E69aidXHg8x+FErYvsaAexo7r/QgG7ha2Jy/PwsgyJshKfSMkqmgWzkpYd6M3g==
X-Google-Smtp-Source: AGHT+IGcwaIrtV+u+dVjykxQHW2Ht6QYGFO/CPljMZIxhocwRy+qvZtb8CVwj6dJODIO/isXdWuDIA==
X-Received: by 2002:a05:6358:938c:b0:17b:602f:24e7 with SMTP id h12-20020a056358938c00b0017b602f24e7mr727705rwb.14.1708659315675;
        Thu, 22 Feb 2024 19:35:15 -0800 (PST)
Received: from [192.168.52.129] ([192.19.222.250])
        by smtp.gmail.com with ESMTPSA id u21-20020a62d455000000b006e4625a0f0dsm9240062pfl.169.2024.02.22.19.35.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Feb 2024 19:35:13 -0800 (PST)
Message-ID: <cc0e98e4-b92f-4da5-879d-7535e787b98f@broadcom.com>
Date: Thu, 22 Feb 2024 19:35:12 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 09/12] mtd: rawnand: brcmnand: Add support for getting
 ecc setting from strap
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
References: <20240207202257.271784-1-william.zhang@broadcom.com>
 <20240207202257.271784-10-william.zhang@broadcom.com>
 <20240220105313.5e3c600d@xps-13>
From: William Zhang <william.zhang@broadcom.com>
In-Reply-To: <20240220105313.5e3c600d@xps-13>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="0000000000009e07c90612043fd1"

--0000000000009e07c90612043fd1
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Miquel,

On 2/20/24 01:53, Miquel Raynal wrote:
> Hi William,
> 
> william.zhang@broadcom.com wrote on Wed,  7 Feb 2024 12:22:54 -0800:
> 
>> BCMBCA broadband SoC based board design does not specify ecc setting in
>> dts but rather use the SoC NAND strap info to obtain the ecc strength
>> and spare area size setting. Add brcm,nand-ecc-use-strap dts propety for
>> this purpose and update driver to support this option.
>>
>> The generic nand ecc settings still take precedence over this flag. For
>> example, if nand-ecc-strength is set in the dts, the driver ignores the
>> strap setting and falls back to original behavior. This makes sure that
>> the existing BCMBCA board dts still works the old way even the strap
>> flag is set in the BCMBCA chip dtsi.
>>
>> Signed-off-by: William Zhang <william.zhang@broadcom.com>
>> Reviewed-by: David Regan <dregan@broadcom.com>
>>
>> ---
>>
>> Changes in v5: None
>> Changes in v4:
>> - Update the comments for ecc setting selection
>>
>> Changes in v3: None
>> Changes in v2:
>> - Minor cosmetic fixes
>>
>>   drivers/mtd/nand/raw/brcmnand/brcmnand.c | 83 ++++++++++++++++++++++--
>>   1 file changed, 76 insertions(+), 7 deletions(-)
>>
>> diff --git a/drivers/mtd/nand/raw/brcmnand/brcmnand.c b/drivers/mtd/nand/raw/brcmnand/brcmnand.c
>> index 73fdf7ce21aa..efeee9e80213 100644
>> --- a/drivers/mtd/nand/raw/brcmnand/brcmnand.c
>> +++ b/drivers/mtd/nand/raw/brcmnand/brcmnand.c
>> @@ -1038,6 +1038,19 @@ static inline int brcmnand_sector_1k_shift(struct brcmnand_controller *ctrl)
>>   		return -1;
>>   }
>>   
>> +static int brcmnand_get_sector_size_1k(struct brcmnand_host *host)
>> +{
>> +	struct brcmnand_controller *ctrl = host->ctrl;
>> +	int shift = brcmnand_sector_1k_shift(ctrl);
>> +	u16 acc_control_offs = brcmnand_cs_offset(ctrl, host->cs,
>> +						  BRCMNAND_CS_ACC_CONTROL);
>> +
>> +	if (shift < 0)
>> +		return 0;
>> +
>> +	return (nand_readreg(ctrl, acc_control_offs) >> shift) & 0x1;
> 
> What is this & 0x1 ? If you return a yes/no value, please make this
> function return a bool. Also, please use intermediate steps to clarify
> what you do.
> 
> sector_1k_bit = ...;
> acc = nand_readreg();
> return acc & BIT(sector_1k_bit);
> 
> Or something like that.
> 
This sector 1k bit is just single bit field. But we do want to return 
negative for error condition and 0 for 512 sector and 1 for 1K sector 
size. Will add intermediate steps.

>> +}
>> +
>>   static void brcmnand_set_sector_size_1k(struct brcmnand_host *host, int val)
>>   {
>>   	struct brcmnand_controller *ctrl = host->ctrl;
>> @@ -1055,6 +1068,38 @@ static void brcmnand_set_sector_size_1k(struct brcmnand_host *host, int val)
>>   	nand_writereg(ctrl, acc_control_offs, tmp);
>>   }
>>   
>> +static int brcmnand_get_spare_size(struct brcmnand_host *host)
>> +{
>> +	struct brcmnand_controller *ctrl = host->ctrl;
>> +	u16 acc_control_offs = brcmnand_cs_offset(ctrl, host->cs,
>> +						  BRCMNAND_CS_ACC_CONTROL);
>> +	u32 acc = nand_readreg(ctrl, acc_control_offs);
>> +
>> +	return (acc & brcmnand_spare_area_mask(ctrl));
>> +}
>> +
>> +static int brcmnand_get_ecc_strength(struct brcmnand_host *host)
> 
> 					_from_strap
> 
>> +{
>> +	struct brcmnand_controller *ctrl = host->ctrl;
>> +	u16 acc_control_offs = brcmnand_cs_offset(ctrl, host->cs,
>> +						  BRCMNAND_CS_ACC_CONTROL);
>> +	int sector_size_1k = brcmnand_get_sector_size_1k(host);
>> +	int spare_area_size, ecc_level, ecc_strength;
>> +	u32 acc;
>> +
>> +	spare_area_size = brcmnand_get_spare_size(host);
>> +	acc = nand_readreg(ctrl, acc_control_offs);
>> +	ecc_level = (acc & brcmnand_ecc_level_mask(ctrl)) >> ctrl->ecc_level_shift;
> 
> Please use FIELD_PREP/FIELD_GET.
> 
These macros do not work here as the mask is not constant.

>> +	if (sector_size_1k)
>> +		ecc_strength = ecc_level * 2;
>> +	else if (spare_area_size == 16 && ecc_level == 15)
>> +		ecc_strength = 1; /* hamming */
>> +	else
>> +		ecc_strength = ecc_level;
>> +
>> +	return ecc_strength;
>> +}
>> +
>>   /***********************************************************************
>>    * CS_NAND_SELECT
>>    ***********************************************************************/
>> @@ -2622,19 +2667,43 @@ static int brcmnand_setup_dev(struct brcmnand_host *host)
>>   		nanddev_get_memorg(&chip->base);
>>   	struct brcmnand_controller *ctrl = host->ctrl;
>>   	struct brcmnand_cfg *cfg = &host->hwcfg;
>> -	char msg[128];
>> +	struct device_node *np = nand_get_flash_node(chip);
>>   	u32 offs, tmp, oob_sector;
>> -	int ret;
>> +	int ret, sector_size_1k = 0;
>> +	bool use_strap = false;
>> +	char msg[128];
>>   
>>   	memset(cfg, 0, sizeof(*cfg));
>> +	use_strap = of_property_read_bool(np, "brcm,nand-ecc-use-strap");
>>   
>> -	ret = of_property_read_u32(nand_get_flash_node(chip),
>> -				   "brcm,nand-oob-sector-size",
>> +	/*
>> +	 * Set ECC size and strength based on hw configuration from strap
>> +	 * if brcm,nand-ecc-use-strap is set. However if nand-ecc-strength
>> +	 * is set, its value will be used and ignore the strap setting.
> 
> Please error out in this case. It's one or the other, not both.
> 
Will update.

>> +	 */
>> +	if (chip->ecc.strength)
>> +		use_strap = 0;
>> +
>> +	if (use_strap) {
>> +		chip->ecc.strength = brcmnand_get_ecc_strength(host);
>> +		sector_size_1k = brcmnand_get_sector_size_1k(host);
>> +		if (chip->ecc.size == 0) {
>> +			if (sector_size_1k < 0)
>> +				chip->ecc.size = 512;
>> +			else
>> +				chip->ecc.size = 512 << sector_size_1k;
>> +		}
> 
> I'd instead make a function named brcmnand_get_ecc_settings() with the
> chip->ecc parameter, so you can directly fill the entries without
> getting another time the sector_size_1k thing.
> 
> Strength and step size are tightly linked, it does make sense to derive
> them both at the same time.
> 
Will update.

>> +	}
>> +
>> +	ret = of_property_read_u32(np, "brcm,nand-oob-sector-size",
>>   				   &oob_sector);
>>   	if (ret) {
>> -		/* Use detected size */
>> -		cfg->spare_area_size = mtd->oobsize /
>> -					(mtd->writesize >> FC_SHIFT);
>> +		if (use_strap)
>> +			cfg->spare_area_size = brcmnand_get_spare_size(host);
>> +		else
>> +			/* Use detected size */
>> +			cfg->spare_area_size = mtd->oobsize /
>> +						(mtd->writesize >> FC_SHIFT);
>>   	} else {
>>   		cfg->spare_area_size = oob_sector;
>>   	}
> 
> 
> Thanks,
> Miquèl

--0000000000009e07c90612043fd1
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
JOEwDQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIO/wu27rmaIsSf8uhWQq95lnl1HB
pHt8btQgLLcqlRxBMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI0
MDIyMzAzMzUxNlowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsG
CWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFl
AwQCATANBgkqhkiG9w0BAQEFAASCAQDHlXF6zSDHkiTiRsY3AaTkpQH83/25Q48SZZipEJ13OOD6
YJSpWnz3aNkga3MXsIgQkGPwjPOB/hclQBs/UmmkvtvTk7pXs8W38aUIXJtuS3jBtaA5gH1YQ9Kc
K1WYgc4qHDu8oK/nESMDoE2xeZHhLwVlrrVsd2uy1fuyo/Yaj5QR3bCzkKscquqoo86y/4etCmR3
22Z4ry24/XfpXGrSSJFBFulEb3OjlDxtCj2QXU2+o94ZjmoI/MceS50Z3FENsqQ+8rVHAswp0tz1
QnH9s7nYlCy09RXjRahohHD/Tk+ql/N6qNzF+De0G+3RPz0euuWhC8E7ZFfXawGVB8As
--0000000000009e07c90612043fd1--

