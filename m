Return-Path: <linux-kernel+bounces-87696-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D340886D7E6
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 00:35:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 31B34B22A5E
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 23:35:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2BE374BF9;
	Thu, 29 Feb 2024 23:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="fqzo5oeJ"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D133B200A6
	for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 23:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709249699; cv=none; b=V3HzGnRko648uFvqvTJiBgT9X3JCETo8hmwE0T3TKCheU5tqdxEpa4rRmTjQPkk34EkXr7V4ELTIG2Ey6Eqbqr9pSeZRPzvilP+eWYVbGcKjtIiEp3PQth8ouIJ+r2QineMG8++mQfbRDk9DBU0p7qBQXco6bwIn08s09/acaq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709249699; c=relaxed/simple;
	bh=PZll7LEkOAICrgySqukYJ3C1aLoi5g5cg8wRd8xLHq8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LnCUCa2U4T75nySuH3bU425FeTY5GAsAnMsZbY/xHxQynuYc6livx25veNwG7Cj58rbZWYzqS/mszSzq/Ipgysp6XNEoqPMa4Sy4EeTS5NTKKxD8vENGVHPaRh9uvtrqt5BAd7iXjJV4lhEX94WfZ7hRw9hmyQVOXqMMVArnzEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=fqzo5oeJ; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1d911c2103aso1694085ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 15:34:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1709249697; x=1709854497; darn=vger.kernel.org;
        h=in-reply-to:from:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=TIV/p1DYNcOJAYweG6r0eaZsIjCFRd+/DC6w11lzxeE=;
        b=fqzo5oeJkTOMPmBPKz0RYKXU00vTSy+hk8vZJEyRiP68RnAH2f5NvvVCQu5vnvIyCU
         uvZvF99D9ZomAH6XSzMu95e4t7Bs5AOBKzMxau9iEuRY0aS9pkFq55FAvf7/WLFwizM/
         JP9Hr34OXrsiSM+PFYHGaNrfNPUwcuN6k3sr4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709249697; x=1709854497;
        h=in-reply-to:from:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TIV/p1DYNcOJAYweG6r0eaZsIjCFRd+/DC6w11lzxeE=;
        b=LXIeRQdLoJKfC1a/B0XIvoyNZGReMnhIjxuGr+c0A8YLloJinTR8J+4uJIup7PpNgl
         G0f+Uxy81ejQniAc5odwqDWnVco2fT9w3dQCdUFIKL1WiEM/JhVpWZ0NqxbiDxelJIfv
         YhZzIvS48afXebY8agKWqJ+tbsmeFMuTVSDx/L4XJ0d6LvRNRj/6f6MAqcHA3d7vmm7z
         VDCTPb+DGF8MA5NMEGUTOx3qzF1ds+GV9Gsct5o3Ttbwu43Z6bEYq1/lUNG6NLSR286a
         HgkNr6fJl4Qst8qevB6t+PJiTnCnvs/r3rXwyl70qwk5HpOMOMY5tnDKe3F5mvxhmANw
         qT7Q==
X-Forwarded-Encrypted: i=1; AJvYcCVB6tZ/8B9tPX5pKjSjDJskVV2/8jrZ0ntnIL0RirupCUYHmsx76ajoLDyX/DW9B8eGW2jWwZBZc2vQDLuLvSnyPRuoC9u990QW8B4v
X-Gm-Message-State: AOJu0YxIfEUa3V4zzJQDcx59BxtcSO4V4hzeIyZq6bIfH7K6Czd2VNSs
	FkrcNcPAazl+xDC8+kMVM1hiFqGZajVZXGLlQP9/O9sZrXpO2BxFNt+URC1S1Q==
X-Google-Smtp-Source: AGHT+IGHUiUWHRdVyfFQbALGxzuEatMLb9UDKSBHeeH1RYePer03kdD+xeJ3HCW0IAvno7hNRslLrw==
X-Received: by 2002:a17:902:6b85:b0:1dc:b6ef:e233 with SMTP id p5-20020a1709026b8500b001dcb6efe233mr16042plk.50.1709249696995;
        Thu, 29 Feb 2024 15:34:56 -0800 (PST)
Received: from [192.168.52.129] ([192.19.222.250])
        by smtp.gmail.com with ESMTPSA id b1-20020a170902d50100b001dcc12a729dsm2075527plg.29.2024.02.29.15.34.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Feb 2024 15:34:55 -0800 (PST)
Message-ID: <0f6659ca-536b-4003-a6f3-ddaaa44a9cdf@broadcom.com>
Date: Thu, 29 Feb 2024 15:34:53 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 12/13] mtd: rawnand: brcmnand: Add support for getting
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
References: <20240223034758.13753-1-william.zhang@broadcom.com>
 <20240223034758.13753-13-william.zhang@broadcom.com>
 <20240223101852.005da3ad@xps-13>
 <db1c1e68-40e2-4c6c-afb2-2fb591883a46@broadcom.com>
 <20240226093632.089d594c@xps-13>
 <be75db7d-a698-43ab-b29e-dea3a0f60ba2@broadcom.com>
 <20240229113119.30f7cee6@xps-13>
From: William Zhang <william.zhang@broadcom.com>
In-Reply-To: <20240229113119.30f7cee6@xps-13>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="0000000000000bc16e06128db582"

--0000000000000bc16e06128db582
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Minquel,

On 2/29/24 02:31, Miquel Raynal wrote:
> Hi William,
> 
> william.zhang@broadcom.com wrote on Mon, 26 Feb 2024 12:05:18 -0800:
> 
>> On 2/26/24 00:36, Miquel Raynal wrote:
>>> Hi William,
>>>
>>> william.zhang@broadcom.com wrote on Fri, 23 Feb 2024 09:25:09 -0800:
>>>    
>>>> Hi Miquel,
>>>>
>>>> On 2/23/24 01:18, Miquel Raynal wrote:
>>>>> Hi William,
>>>>>
>>>>> william.zhang@broadcom.com wrote on Thu, 22 Feb 2024 19:47:57 -0800:
>>>>>     >>>> BCMBCA broadband SoC based board design does not specify ecc setting in
>>>>>> dts but rather use the SoC NAND strap info to obtain the ecc strength
>>>>>> and spare area size setting. Add brcm,nand-ecc-use-strap dts propety for
>>>>>> this purpose and update driver to support this option. However these two
>>>>>> options can not be used at the same time.
>>>>>>
>>>>>> Signed-off-by: William Zhang <william.zhang@broadcom.com>
>>>>>> Reviewed-by: David Regan <dregan@broadcom.com>
>>>>>>    >>>
>>>>> FYI I did not receive patches 7, 8, 9, which makes the series numbering
>>>>> very odd.
>>>>>     >> I was using the get maintainer script mainly and it sends to the linux MTD list.  I will add your email directly next time.
>>>
>>> Yes, I prefer to be in Cc of the whole series, please.
>>>    
>> Sure.  And thanks for applying other patches.  Do you want me to just send a new single patch for the update?
> 
> Yes just the missing patch.
> 
v7 of this patch was sent early

>>>>>>     >> +static int brcmnand_get_sector_size_1k(struct brcmnand_host *host)
>>>>>> +{
>>>>>> +	struct brcmnand_controller *ctrl = host->ctrl;
>>>>>> +	int sector_size_bit = brcmnand_sector_1k_shift(ctrl);
>>>>>> +	u16 acc_control_offs = brcmnand_cs_offset(ctrl, host->cs,
>>>>>> +						  BRCMNAND_CS_ACC_CONTROL);
>>>>>> +	u32 acc_control;
>>>>>> +
>>>>>> +	if (sector_size_bit < 0)
>>>>>> +		return 0;
>>>>>> +
>>>>>> +	acc_control = nand_readreg(ctrl, acc_control_offs);
>>>>>> +
>>>>>> +	return (acc_control & BIT(sector_size_bit)) >> sector_size_bit;
>>>>>
>>>>> FIELD_PREP, FIELD_GET, *please*.
>>>> You probably missed my reply to your comments on the same patch in v5. Here is the link for the post in case it lost in your email:
>>>> https://lore.kernel.org/lkml/c145b90c-e9f0-4d82-94cc-baf7bfda5954@gmail.com/T/#m1d911d2f119f3bd345c575a81b60bc2bd8c461eb
>>>
>>> I didn't miss it, but the reason does not sound legitimate to me.
>>> Please work on it, it will be so much cleaner.
>>>    
>> I understand FIELD_PREP/GET is the preferred way of linux accessing the register fields but it requires a constant MASK value and does not apply to our case as we have different versions of the register and have different mask.  There is way to workaround it. i.e defining the multiple constants directly and using these macros with if/else based on reg version. But it is not clean and since we already have helper functions that handle and return different shift/mask value, I see this is a perfect way for our situation and can adapt to future reg version change easily and cleanly.
>>
>>>> The mask is not constant here and cause build errors.
> 
> Which errors?
> 
If I use the code below In function brcmnand_get_sector_size_1k, inlined 
from brcmnand_get_ecc_settings at 
drivers/mtd/nand/raw/brcmnand/brcmnand.c:1089:24,
     inlined from brcmnand_setup_dev at 
drivers/mtd/nand/raw/brcmnand/brcmnand.c:2701:3:
/./include/linux/compiler_types.h:442:38: error: call to 
compiletime_assert_254 declared with attribute error: FIELD_GET: mask is 
not  constant

> +       acc_control = nand_readreg(ctrl, acc_control_offs);
> +       return FIELD_GET(BIT(sector_size_bit), acc_control);
> 
> Does not return any error here.
> 
Right, this function does not return error. brcmnand_sector_1k_shift 
does. I didn't make that clear enough. This function is updated and 
logic that calls this function is simplified in v7 based on your feedbacks.


> Thanks,
> Miquèl

--0000000000000bc16e06128db582
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
JOEwDQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEINhKdfVBTcnbLdos+FBz54esvuh3
zmy1mXqrE88HB/17MBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI0
MDIyOTIzMzQ1N1owaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsG
CWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFl
AwQCATANBgkqhkiG9w0BAQEFAASCAQBdfLsG1MdHdvS2IiU3r2cqJXE5Tu0hk/r277LCr+yqe7E9
29uvDDlfHXmfdgLT7mmx633x+L3TAPwbiBdAGhFEL8U+hsLacP6vvz6IirUJE5LdhjnqClUDaqo/
Bx/4d/+j0Wdi3EnoLU9ry1KtYAkeTsVC2CHcLIbkG4F6yHFcPnb3ovaRWiUqYWynV18kcLxg/X+I
TugPgEGYD19PJE2/N8ezVSNqhU4ZrTwO+RnGlwYIqf2vrCI4lxyTEkfYspy+7hjBdbKSwkjImMfD
dc2VgaN29+vpmYhB+mOCuv+pfPwBmePszemKrBrsV50FvWrbgGIK+IjgWX++ThMIydsX
--0000000000000bc16e06128db582--

