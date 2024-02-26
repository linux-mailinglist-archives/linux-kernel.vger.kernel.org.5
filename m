Return-Path: <linux-kernel+bounces-82278-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B409C8681B1
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 21:05:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 257151F24F5D
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 20:05:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA56A130E2F;
	Mon, 26 Feb 2024 20:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="TNFQvYC+"
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C26A5130AFD
	for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 20:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708977926; cv=none; b=oTGD8PhMZ8RRpP9aMd4UQMemhDQHeDxb9MA3HIa8CFZ6Gv5HFIszR2bMDp8Ci5kjFYm/UXmSR4G92DVyoFqEsQUFMIUumQknxhGCi9SKDrXu38ngKTwfTV5kGJHFSFxSrexgm3MT2GPU9fxS8ofzLtUSTM6bO6O105Hkvzw6N/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708977926; c=relaxed/simple;
	bh=v3Ngmdt8dn9DY+Vo5iVrjxryvB6RVwUwKicsQJyVZI8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=be4pqEAOFITgbHvcwtAtn+k2xRu8wdaDChFrMTlGm0ZvptQhW9EnfirSi1UDGtK2CsOJXP1WKEaGu2mL56XzWpMS3mJ5//IXgr0GBOoAspOSAL7lsd6amVH1Paeub37of8Z4eHrfnBt1jrJFd3Ygyqus2yjZhhcgFKBKfxgs0/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=TNFQvYC+; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-787b4d1393aso222667085a.0
        for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 12:05:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1708977922; x=1709582722; darn=vger.kernel.org;
        h=in-reply-to:from:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=4ca+MHeBvGrM2KCf0J/2h8DgIhwnCE+YdgudPqwgtgk=;
        b=TNFQvYC+Uxj2Z13q15VMXDuBzJSElZ04QKJquVh0cEq1KqneTBXLb1+a9MtcaRreSw
         VyRKOOFI6GdGYWt8rYwip2A2bw4ME2O/ExzsuZPdtdt9B6VB3xuwNfZf3nFnHU4Cw64W
         s/u5jYd6qE0bMfhagX2/H/zSM1UCRFf17GF7Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708977922; x=1709582722;
        h=in-reply-to:from:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4ca+MHeBvGrM2KCf0J/2h8DgIhwnCE+YdgudPqwgtgk=;
        b=AHJILgUlWVkBRfW1dL3Fauz1Q+mDmrXXh1xJ6tSMr06y5VB6VTYWqmwBN58/qfvs2X
         fNSqEF2IS5kKtPwr+0Xz+JS1bQXE8dMqog4MVyzSzzFgz6WYWTK+p62dBGlBZcfXZ2R+
         +CtGaJPvPMYoZ8ptsY95pvG7+cFN9fpFZoHNPL4PlVj57zX1Tj/F4Zp1zNffJaqondO2
         qZzy1b5uJgZyQgKiWUWu7C6iC9iSVYLzByvlAbEEEZUh56Qltieqe3NO7bsPlVyNazcu
         hoI1pvbwUQMEB/L+vWayv93BFbnXckndE3z+yfiIGNILwHMccjydBxl/MytjBlvANWsT
         TT2A==
X-Forwarded-Encrypted: i=1; AJvYcCUhLlJOY8jS3JlHuQ3eOXmz9e2mD05rk8xtxMiImXdQygnualYKU2pLvYFfqIeNwtmFY0421pdRGdYxnhULfORuBMM0LaJsaTi7JBZU
X-Gm-Message-State: AOJu0Yxws0FKqUI5cGrh9vIxXOgNVnhbVAxNdd8mXYIIVk6/DubvwMhe
	NWFwQvkEtdWLz51ZvRth9NZvv3R6kN2kAB0KjCmen85PIuGwtUPIJNENOTGwvA==
X-Google-Smtp-Source: AGHT+IGAxcvLGasiPJKFBa07iPPouv6Ff4sPLXY3BaxfXdaesesCWfYYHkWNtpMPDMwc6iFWRBHhOA==
X-Received: by 2002:a05:620a:1a03:b0:787:b595:8af2 with SMTP id bk3-20020a05620a1a0300b00787b5958af2mr140791qkb.73.1708977922334;
        Mon, 26 Feb 2024 12:05:22 -0800 (PST)
Received: from [192.168.52.129] ([192.19.222.250])
        by smtp.gmail.com with ESMTPSA id p18-20020a05620a057200b007872d50caf5sm2808329qkp.19.2024.02.26.12.05.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Feb 2024 12:05:20 -0800 (PST)
Message-ID: <be75db7d-a698-43ab-b29e-dea3a0f60ba2@broadcom.com>
Date: Mon, 26 Feb 2024 12:05:18 -0800
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
From: William Zhang <william.zhang@broadcom.com>
In-Reply-To: <20240226093632.089d594c@xps-13>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="0000000000000346b806124e6e77"

--0000000000000346b806124e6e77
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2/26/24 00:36, Miquel Raynal wrote:
> Hi William,
> 
> william.zhang@broadcom.com wrote on Fri, 23 Feb 2024 09:25:09 -0800:
> 
>> Hi Miquel,
>>
>> On 2/23/24 01:18, Miquel Raynal wrote:
>>> Hi William,
>>>
>>> william.zhang@broadcom.com wrote on Thu, 22 Feb 2024 19:47:57 -0800:
>>>    
>>>> BCMBCA broadband SoC based board design does not specify ecc setting in
>>>> dts but rather use the SoC NAND strap info to obtain the ecc strength
>>>> and spare area size setting. Add brcm,nand-ecc-use-strap dts propety for
>>>> this purpose and update driver to support this option. However these two
>>>> options can not be used at the same time.
>>>>
>>>> Signed-off-by: William Zhang <william.zhang@broadcom.com>
>>>> Reviewed-by: David Regan <dregan@broadcom.com>
>>>>   
>>>
>>> FYI I did not receive patches 7, 8, 9, which makes the series numbering
>>> very odd.
>>>    
>> I was using the get maintainer script mainly and it sends to the linux MTD list.  I will add your email directly next time.
> 
> Yes, I prefer to be in Cc of the whole series, please.
> 
Sure.  And thanks for applying other patches.  Do you want me to just 
send a new single patch for the update?

>>>> ---
>>>>
>>>> Changes in v6:
>>>> - Combine the ecc step size and ecc strength into one get function
>>>> - Treat it as error condition if both brcm,nand-ecc-use-strap and nand
>>>> ecc dts properties are set
>>>> - Add intermediate steps to get the sector size bitfield
>>>>
>>>> Changes in v5: None
>>>> Changes in v4:
>>>> - Update the comments for ecc setting selection
>>>>
>>>> Changes in v3: None
>>>> Changes in v2:
>>>> - Minor cosmetic fixes
>>>>
>>>>    drivers/mtd/nand/raw/brcmnand/brcmnand.c | 83 ++++++++++++++++++++++--
>>>>    1 file changed, 77 insertions(+), 6 deletions(-)
>>>>
>>>> diff --git a/drivers/mtd/nand/raw/brcmnand/brcmnand.c b/drivers/mtd/nand/raw/brcmnand/brcmnand.c
>>>> index ef7d340475be..e8ffc283b365 100644
>>>> --- a/drivers/mtd/nand/raw/brcmnand/brcmnand.c
>>>> +++ b/drivers/mtd/nand/raw/brcmnand/brcmnand.c
>>>> @@ -1038,6 +1038,22 @@ static inline int brcmnand_sector_1k_shift(struct brcmnand_controller *ctrl)
>>>>    		return -1;
>>>>    }
>>>>    >> +static int brcmnand_get_sector_size_1k(struct brcmnand_host *host)
>>>> +{
>>>> +	struct brcmnand_controller *ctrl = host->ctrl;
>>>> +	int sector_size_bit = brcmnand_sector_1k_shift(ctrl);
>>>> +	u16 acc_control_offs = brcmnand_cs_offset(ctrl, host->cs,
>>>> +						  BRCMNAND_CS_ACC_CONTROL);
>>>> +	u32 acc_control;
>>>> +
>>>> +	if (sector_size_bit < 0)
>>>> +		return 0;
>>>> +
>>>> +	acc_control = nand_readreg(ctrl, acc_control_offs);
>>>> +
>>>> +	return (acc_control & BIT(sector_size_bit)) >> sector_size_bit;
>>>
>>> FIELD_PREP, FIELD_GET, *please*.
>> You probably missed my reply to your comments on the same patch in v5. Here is the link for the post in case it lost in your email:
>> https://lore.kernel.org/lkml/c145b90c-e9f0-4d82-94cc-baf7bfda5954@gmail.com/T/#m1d911d2f119f3bd345c575a81b60bc2bd8c461eb
> 
> I didn't miss it, but the reason does not sound legitimate to me.
> Please work on it, it will be so much cleaner.
> 
I understand FIELD_PREP/GET is the preferred way of linux accessing the 
register fields but it requires a constant MASK value and does not apply 
to our case as we have different versions of the register and have 
different mask.  There is way to workaround it. i.e defining the 
multiple constants directly and using these macros with if/else based on 
reg version. But it is not clean and since we already have helper 
functions that handle and return different shift/mask value, I see this 
is a perfect way for our situation and can adapt to future reg version 
change easily and cleanly.

>> The mask is not constant here and cause build errors.
>>>    
>>>> +}
>>>> +
>>>>    static void brcmnand_set_sector_size_1k(struct brcmnand_host *host, int val)
>>>>    {
>>>>    	struct brcmnand_controller *ctrl = host->ctrl;
>>>> @@ -1055,6 +1071,43 @@ static void brcmnand_set_sector_size_1k(struct brcmnand_host *host, int val)
>>>>    	nand_writereg(ctrl, acc_control_offs, tmp);
>>>>    }
>>>>    >> +static int brcmnand_get_spare_size(struct brcmnand_host *host)
>>>> +{
>>>> +	struct brcmnand_controller *ctrl = host->ctrl;
>>>> +	u16 acc_control_offs = brcmnand_cs_offset(ctrl, host->cs,
>>>> +						  BRCMNAND_CS_ACC_CONTROL);
>>>> +	u32 acc = nand_readreg(ctrl, acc_control_offs);
>>>> +
>>>> +	return (acc & brcmnand_spare_area_mask(ctrl));
>>>> +}
>>>> +
>>>> +static void brcmnand_get_ecc_settings(struct brcmnand_host *host, struct nand_chip *chip)
>>>> +{
>>>> +	struct brcmnand_controller *ctrl = host->ctrl;
>>>> +	u16 acc_control_offs = brcmnand_cs_offset(ctrl, host->cs,
>>>> +						  BRCMNAND_CS_ACC_CONTROL);
>>>> +	int sector_size_1k = brcmnand_get_sector_size_1k(host);
>>>> +	int spare_area_size, ecc_level;
>>>> +	u32 acc;
>>>> +
>>>> +	spare_area_size = brcmnand_get_spare_size(host);
>>>> +	acc = nand_readreg(ctrl, acc_control_offs);
>>>> +	ecc_level = (acc & brcmnand_ecc_level_mask(ctrl)) >> ctrl->ecc_level_shift;
>>>
>>> ditto
>>>    
>>>> +	if (sector_size_1k)
>>>> +		chip->ecc.strength = ecc_level * 2;
>>>> +	else if (spare_area_size == 16 && ecc_level == 15)
>>>> +		chip->ecc.strength = 1; /* hamming */
>>>> +	else
>>>> +		chip->ecc.strength = ecc_level;
>>>> +
>>>> +	if (chip->ecc.size == 0) {
>>>> +		if (sector_size_1k < 0)
>>>
>>> Should be <= 0 I guess
>>>    
>>>> +			chip->ecc.size = 512;
>>>> +		else
>>>> +			chip->ecc.size = 512 << sector_size_1k;
>>>
>>> What is this? Are you expecting sector_size_1k to be 0 or 1
>>> and thus multiply 512 by two?
>>>    
>> Explained in the same post above. Sector_size_1k can be negative number for error condition where we default to 512 step size. Otherwise 0 for 512 and 1 for 1K which the above shift takes care of.
> 
> The logic is unclear, unnatural. Please simplify. You have the
> possibility to change all the driver, so please simplify and clarify
> the logic.
> 
Will update.

>>> Please just use:
>>> 			chip->ecc.size = SZ_1K;
>>> 			
> 
> Thanks,
> Miquèl

--0000000000000346b806124e6e77
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
JOEwDQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIPM/doRj8aGzk4+MSDwBqDr2GFu0
7jfyDUJuPeKhKY6hMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI0
MDIyNjIwMDUyMlowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsG
CWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFl
AwQCATANBgkqhkiG9w0BAQEFAASCAQANxzPIL3rysGHf16SYFofAM1Fn6XoacYJaRFjjr0uB9ZWn
Li5Vh+3K/R9ko+xo+7o9iBeT9KPfnRpXIZd2WNtKtEisOsd9yrcO11GGsHILdPvxL+WRWxKs7pBe
wY0JCSHshEw/2d/vFz4pD9GWvjEYBrIdT8OwU1sgq7/FmQ636npRhHEqzzi2PZGDc84UIFmLKcpv
4SnhEO2egBYqyYQoZG/Pu20HIA+KZhOgQ86VF94u7pAijz/miDovws+tKS97GJYL8kInaG8w3Hsv
jb8GnSxIKrq0FbGnuTlcwGmGB2zQKachK/W7X4dfBerw7knpPeIe4AB84gshxLlLm22g
--0000000000000346b806124e6e77--

