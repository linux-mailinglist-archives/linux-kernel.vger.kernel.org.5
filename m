Return-Path: <linux-kernel+bounces-47712-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7387B84519D
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 07:49:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F2B861F24623
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 06:49:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B01181586E2;
	Thu,  1 Feb 2024 06:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="eP3+M2N6"
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B1D9157E83
	for <linux-kernel@vger.kernel.org>; Thu,  1 Feb 2024 06:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706770138; cv=none; b=nVDCGS54bvtyjmzOYKzZqKENx/GPcEO3vrsnTvJYxO53H04NYUPJ/vtj9a9OUhie11K5t+31vtFQtuzo7d8giXpJMl8/gTrg/cktRqRxR+k4kT42ADfgYS4o7XkVg7hBfhxiGfUhN5sarrwohqg4nySyGhxtd4IN4l1/85+6oO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706770138; c=relaxed/simple;
	bh=c1UcapGx6tiQp5Wx8QD/POh5OXUOcki/rGuT3GqzT0g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=E1C0Caow99Bh38TB2GDP7oQX3iBu3bt47udSPn+sYSfO2kjZylSOQ1sJISG6D7a9tPKechxyKT22hIiy4YYdLByLbWgZWlUuVV2+LVpSuupgTzHRY8zUu87awXdtgNQfMmuc7fDmIaW7v0/cE5Cs+gCoSrA3CeIdAe+cZ46L73s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=eP3+M2N6; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-42ab7522bf6so2914661cf.2
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 22:48:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1706770135; x=1707374935; darn=vger.kernel.org;
        h=in-reply-to:from:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=L+YOGeyfMNugkUMo245Taqh7PYgw/ai2CUVlXuhD3Gg=;
        b=eP3+M2N6Oeou12dBrsTvY1Krbty5YoRqlVO3tTRXZ9bV1/OL+DPBTIObA+YBA8pYRw
         iy4/ZEJwDjDeLzg+6EdWAALj32ozW5FojweICnQ23AGvhC9Lxq/JyJCb+ikY24h/nRvu
         sCLd05dcrPaBmzOiGcHhgsI1+Z3wF7iXDTRDE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706770135; x=1707374935;
        h=in-reply-to:from:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L+YOGeyfMNugkUMo245Taqh7PYgw/ai2CUVlXuhD3Gg=;
        b=sfvu/bnBp0l5jDZumg9REgzvK1GPQH88gRp6RXLSBUlruXZge1++V0xAUqeMKVQIJp
         MNTI6JdGL5gnRo9ejZAMhK1exYF8ic3D9PNX/pxJ515AV37OS148gd/LZEEakn2U0kOw
         +lzx64s6RIhZAq7Bc0IoiIc9q4FN4a6sNeIrb3Uj8GpY6Wl/i5kttrUs+adMccU4K9QI
         NchxqTjkdfRB4uQOUu6Emok+2JRw3kzr0T0e404kx7J3r5MEtLs/sXWYJGuhDJjlRyje
         OKsCJmUiSgzoe8gTjNIJRrqpUOEQQv/J5w1gt7LxA1zTIHnm0evhg/TRFmX9SNYA701T
         BCNA==
X-Gm-Message-State: AOJu0YxTjivnvwVrkl3GDuHd5iK/Vsb3Z8oCTAUk10NstYWzpptBjUeU
	tGaNtIrJuhk0Dp1mkjaqFMluCA7QmpDy/0VCZiEkLRQqygnEO7ZsQYXdsqg/cA==
X-Google-Smtp-Source: AGHT+IFu3hpSEYcg5NjFumnW8pSOQjAuDiaik+mNKuXlASIZK7ixwBrqaitvekqcbMmlfTD42c14OQ==
X-Received: by 2002:a05:6214:268d:b0:685:73fe:aafe with SMTP id gm13-20020a056214268d00b0068573feaafemr5262448qvb.18.1706770135028;
        Wed, 31 Jan 2024 22:48:55 -0800 (PST)
Received: from [192.168.52.129] ([192.19.222.250])
        by smtp.gmail.com with ESMTPSA id qo11-20020a056214590b00b0068c655f3e4dsm2057425qvb.15.2024.01.31.22.48.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 31 Jan 2024 22:48:53 -0800 (PST)
Message-ID: <bcd9f8a5-7dab-42e6-b860-8a56ebb51cb6@broadcom.com>
Date: Wed, 31 Jan 2024 22:48:50 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 10/10] mtd: rawnand: brcmnand: allow for on-die ecc
To: Miquel Raynal <miquel.raynal@bootlin.com>,
 David Regan <dregan@broadcom.com>
Cc: dregan@mail.com, Richard Weinberger <richard@nod.at>,
 Vignesh Raghavendra <vigneshr@ti.com>, robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 computersforpeace@gmail.com, kdasu.kdev@gmail.com,
 linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Joel Peshkin <joel.peshkin@broadcom.com>,
 Tomer Yacoby <tomer.yacoby@broadcom.com>,
 Dan Beygelman <dan.beygelman@broadcom.com>,
 Anand Gore <anand.gore@broadcom.com>, Kursad Oney
 <kursad.oney@broadcom.com>, Florian Fainelli
 <florian.fainelli@broadcom.com>, rafal@milecki.pl,
 bcm-kernel-feedback-list@broadcom.com, andre.przywara@arm.com,
 baruch@tkos.co.il, linux-arm-kernel@lists.infradead.org,
 Dan Carpenter <dan.carpenter@linaro.org>
References: <20240124030458.98408-1-dregan@broadcom.com>
 <20240124030458.98408-11-dregan@broadcom.com>
 <20240124184027.712b1e47@xps-13>
 <CAA_RMS42FaiN+Za1iY12o0YUANH9rJarBTBa=9jNn8x6_g-Fng@mail.gmail.com>
 <20240126071913.699c3795@xps-13>
 <CAA_RMS5gX88v_Qt1csgSL_ffMNsqo2G8B164EB_Hg=hXd620eg@mail.gmail.com>
 <20240129115228.06dc2292@xps-13>
 <2a3edcf5-7afc-410c-a402-3d8cd3feb1da@broadcom.com>
 <20240130120155.3cb6feed@xps-13>
 <CAA_RMS577vw=QWN9_NHfmWqt+_cDG22tA01aU019CPNjAgHqJQ@mail.gmail.com>
 <20240130195504.506fb446@xps-13>
From: William Zhang <william.zhang@broadcom.com>
In-Reply-To: <20240130195504.506fb446@xps-13>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000a2aed006104c6357"

--000000000000a2aed006104c6357
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Miquel,

On 1/30/24 10:55, Miquel Raynal wrote:
> Hi David,
> 
> dregan@broadcom.com wrote on Tue, 30 Jan 2024 07:26:02 -0800:
> 
>> Hi Miquel,
>>
>> On Tue, Jan 30, 2024 at 3:01 AM Miquel Raynal <miquel.raynal@bootlin.com> wrote:
>>>
>>> Hi William,
>>>
>>> william.zhang@broadcom.com wrote on Tue, 30 Jan 2024 00:11:32 -0800:
>>>   
>>>> Hi Miquel,
>>>>
>>>> On 1/29/24 02:52, Miquel Raynal wrote:
>>>>> Hi David,
>>>>>
>>>>> dregan@broadcom.com wrote on Fri, 26 Jan 2024 11:57:39 -0800:
>>>>>   
>>>>>> Hi Miquèl,
>>>>>>
>>>>>> On Thu, Jan 25, 2024 at 10:19 PM Miquel Raynal
>>>>>> <miquel.raynal@bootlin.com> wrote:
>>>>>>>
>>>>>>> Hi David,
>>>>>>>
>>>>>>> dregan@broadcom.com wrote on Thu, 25 Jan 2024 11:47:46 -0800:
>>>>>>>    >>>> Hi Miquèl,
>>>>>>>>
>>>>>>>> On Wed, Jan 24, 2024 at 9:40 AM Miquel Raynal <miquel.raynal@bootlin.com> wrote:
>>>>>>>>>
>>>>>>>>> Hi David,
>>>>>>>>>
>>>>>>>>> dregan@broadcom.com wrote on Tue, 23 Jan 2024 19:04:58 -0800:
>>>>>>>>>    >>>>>> Allow settings for on-die ecc such that if on-die ECC is selected
>>>>>>>>>> don't error out but require ECC strap setting of zero
>>>>>>>>>>
>>>>>>>>>> Signed-off-by: David Regan <dregan@broadcom.com>
>>>>>>>>>> Reviewed-by: William Zhang <william.zhang@broadcom.com>
>>>>>>>>>> ---
>>>>>>>>>> Changes in v3: None
>>>>>>>>>> ---
>>>>>>>>>> Changes in v2:
>>>>>>>>>> - Added to patch series
>>>>>>>>>> ---
>>>>>>>>>>    drivers/mtd/nand/raw/brcmnand/brcmnand.c | 14 ++++++++++----
>>>>>>>>>>    1 file changed, 10 insertions(+), 4 deletions(-)
>>>>>>>>>>
>>>>>>>>>> diff --git a/drivers/mtd/nand/raw/brcmnand/brcmnand.c b/drivers/mtd/nand/raw/brcmnand/brcmnand.c
>>>>>>>>>> index a4e311b6798c..42526f3250c9 100644
>>>>>>>>>> --- a/drivers/mtd/nand/raw/brcmnand/brcmnand.c
>>>>>>>>>> +++ b/drivers/mtd/nand/raw/brcmnand/brcmnand.c
>>>>>>>>>> @@ -2727,9 +2727,11 @@ static int brcmnand_setup_dev(struct brcmnand_host *host)
>>>>>>>>>>         cfg->blk_adr_bytes = get_blk_adr_bytes(mtd->size, mtd->writesize);
>>>>>>>>>>
>>>>>>>>>>         if (chip->ecc.engine_type != NAND_ECC_ENGINE_TYPE_ON_HOST) {
>>>>>>>>>> -             dev_err(ctrl->dev, "only HW ECC supported; selected: %d\n",
>>>>>>>>>> -                     chip->ecc.engine_type);
>>>>>>>>>> -             return -EINVAL;
>>>>>>>>>> +             if (chip->ecc.strength) {
>>>>>>>>>> +                     dev_err(ctrl->dev, "ERROR!!! HW ECC must be set to zero for non-hardware ECC; selected: %d\n",
>>>>>>>>>> +                             chip->ecc.strength);
>>>>>>>>>
>>>>>>>>> Can you use a more formal string? Also clarify it because I don't
>>>>>>>>> really understand what it leads to.
>>>>>>>>
>>>>>>>> How about:
>>>>>>>>
>>>>>>>> dev_err(ctrl->dev, "HW ECC set to %d, must be zero for on-die ECC\n",
>>>>>>>
>>>>>>> Actually I am wondering how legitimate this is. Just don't enable the
>>>>>>> on host ECC engine if it's not in use. No need to check the core's
>>>>>>> choice.
>>>>>>
>>>>>> Our chip ECC engine will either be on if it's needed or off if it's not.
>>>>>> Either I can do that in one place or put checks in before each
>>>>>> read/write to turn on/off the ECC engine, which seems a lot more
>>>>>> work and changes and possible issues/problems.
>>>>>> Turning it on/off as needed has not been explicitly tested and
>>>>>> could cause unforeseen consequences. This
>>>>>> is a minimal change which should have minimal impact.
>>>>>>   
>>>>>>>    >>>>   >>>>>   >>>>>> +                     return -EINVAL;
>>>>>>>>>> +             }
>>>>>>>>>>         }
>>>>>>>>>>
>>>>>>>>>>         if (chip->ecc.algo == NAND_ECC_ALGO_UNKNOWN) {
>>>>>>>>>> @@ -2797,7 +2799,11 @@ static int brcmnand_setup_dev(struct brcmnand_host *host)
>>>>>>>>>>         if (ret)
>>>>>>>>>>                 return ret;
>>>>>>>>>>
>>>>>>>>>> -     brcmnand_set_ecc_enabled(host, 1);
>>>>>>>>>> +     if (chip->ecc.engine_type == NAND_ECC_ENGINE_TYPE_ON_DIE) {
>>>>>>>>>> +             dev_dbg(ctrl->dev, "Disable HW ECC for on-die ECC\n");
>>>>>>>>>
>>>>>>>>> Not needed.
>>>>>>>>
>>>>>>>> Will remove.
>>>>>>>>    >>>>>   >>>>>> +             brcmnand_set_ecc_enabled(host, 0);
>>>>>>>>>> +     } else
>>>>>>>>>> +             brcmnand_set_ecc_enabled(host, 1);
>>>>>>>>>
>>>>>>>>> Style is wrong, but otherwise I think ECC should be kept disabled while
>>>>>>>>> not in active use, so I am a bit surprised by this line.
>>>>>>>>
>>>>>>>> This is a double check to turn on/off our hardware ECC.
>>>>>>>
>>>>>>> I expect the engine to be always disabled. Enable it only when you
>>>>>>> need (may require an additional patch before this one).
>>>>>>
>>>>>> We are already turning on the ECC enable at this point,
>>>>>> this is just adding the option to turn it off if the NAND chip
>>>>>> itself will be doing the ECC instead of our controller.
>>>>>
>>>>> Sorry if I have not been clear.
>>>>>
>>>>> This sequence:
>>>>> - init
>>>>> - enable hw ECC engine
>>>>> Is broken.
>>>>>   
>>>> ECC engine is not enabled for all the cases. Here we only intended to enable it for the nand chip that is set to use NAND_ECC_ENGINE_TYPE_ON_HOST. The logic here should better change to:
>>>> if (chip->ecc.engine_type == NAND_ECC_ENGINE_TYPE_ON_HOST)
>>>>       brcmnand_set_ecc_enabled(host, 1);
>>>> else
>>>>       brcmnand_set_ecc_enabled(host, 0);
>>>>   
>>>>> It *cannot* work as any operation going through exec_op now may
>>>>> perform page reads which should be unmodified by the ECC engine. You > driver *must* follow the following sequence:
>>>>> - init and disable (or keep disabled) the hw ECC engine
>>>>> - when you perform a page operation with correction you need to
>>>>>      - enable the engine
>>>>>      - perform the operation
>>>>>      - disable the engine
>>>>> Maybe I am missing something here but are you saying the exec_op can have different ecc type for page read/write at run time on the same nand chip? I don't see the op instr structure has the ecc type field and thought it is only bind to the nand chip and won't change at run time. So looks to me the init time setting to the engine based on ecc.engine_type should be sufficient.
>>>>
>>>> What you described here can work for the hw.ecc read path (ecc.read_page = brcmnand_read_page) which always assumes ecc is enabled. Although it is probably not too bad with these two extra operation, it would be better if we don't have to add anything as our current code does. For the brcmnand_read_page_raw,  we currently disable the engine and then re-enable it(but we need to fix it to only enable it with hw ecc engine type).  So it is just opposite of you logic but works the same with no impact on the most performance critical path.
>>>
>>> This is not "my" logic, this is the "core's" logic. I am saying: your
>>> approach is broken because that is not how the API is supposed to work,
>>> but it mostly works in the standard case.
>>
>> In the interest of minimizing register writes, would it be acceptable to
>> enable/disable ECC at the beginning of a standard
>> path transfer but not, after the transfer, turn off the ECC? This should not
>> affect other standard path operations nor affect the exec_op path as those
>> are low level transfers which our ECC engine would not touch and the NAND
>> device driver should be responsible for turning on/off its own ECC.
> 
> Do you have legitimate concerns about this register write taking way
> more time than I could expect? Because compared to the transfer of a
> NAND page + tR/tPROG it should not be noticeable. I don't see how you
> could even measure such impact actually, unless the register write does
> way more than usual. I'm fine with the above idea if you show me it has
> an interest.
> 
Dave did the mtd_speed test and we can see we get consistently ~35KB/s 
slower with the extra enable and disable ecc engine calls in ecc read 
page path.

With the change:
[   28.148355] mtd_speedtest:   page read speed is 9857 KiB/s
[   31.754258] mtd_speedtest: 2 page read speed is 9865 KiB/s
Without the change
[   56.444735] mtd_speedtest:   page read speed is 9892 KiB/s
[   60.042262] mtd_speedtest: 2 page read speed is 9897 KiB/s

Although it is only less than 1% drop, it is still something. I 
understand the procedure you laid out above is the preferred way but 
with our driver fully control the chip ecc read/write page, ecc 
read_raw/write_raw page function and exec_op path, I don't see where it 
may not work. What are the non-standard cases that can break it?

If the driver started with preferred procedure,  we will never have this 
conversation:) But unfortunately it is not the case and now if we want 
to revert this but lose performance, I just don't feel like to swallow 
this if there is no real world case that breaks this code.

> Thanks,
> Miquèl

--000000000000a2aed006104c6357
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
JOEwDQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIF6qJIru8AzQ3YLQtXCSb+XBo+xs
Y/sd915KMwlIS8JUMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI0
MDIwMTA2NDg1NVowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsG
CWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFl
AwQCATANBgkqhkiG9w0BAQEFAASCAQAfERPa3kCDxDsoMA9r7wR4ks1xE85SqUGhUjQrPQUTmSex
RtQXP0uMseGL7nX4plhavrSUqXAJMCxgdgOGFSRxQNh0UltLsMmOeE+jTfFUmQ05GDt9+9jSkw83
42C/p7UgyGSOxhAMaKgBjqY8ZU1eTWhDrfVzmtdsELGEv8g/cX9z1xKQMhqMqcIUEj/OtRidNaRe
BqHuJUEs7X31rg056QluNAiLZbYaOhdu7OK2zAT0P9Tw0+xKxFJW57VKM/ixK/UwTIGgfAe7vd82
bZMrhDGEcxtpa6pyN7rAIsvBtgkRCp69AeSpzmESnY9j+FSEL99N9Fu296r+8WHqbbyI
--000000000000a2aed006104c6357--

