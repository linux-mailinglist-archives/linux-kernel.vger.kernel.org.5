Return-Path: <linux-kernel+bounces-48735-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 679BE846077
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 19:57:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C124EB2BFD1
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 18:53:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5154584037;
	Thu,  1 Feb 2024 18:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="bRLNCjgf"
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8039784FC0
	for <linux-kernel@vger.kernel.org>; Thu,  1 Feb 2024 18:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706813597; cv=none; b=RGkkMsZ7f1ZEFaXTi3Txiycex8PX0MTlq/mWwrRqOh70jUpwk9taYTd8u/ktN94fztEXMov8Vy8mrmyUbd4XlNIyqaiE9V0fkVC9iRemAGgvoQUfZzMNVd6eaM5OkJlFOMvZl2o4ATWhcitoYAZsttfiru2fJGqtdmr46fRlZDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706813597; c=relaxed/simple;
	bh=S5qB/ondB91v2o+vQ6Jyz2q3PUCHmwE+47uWI2DhcgU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Pj4I2vbOhA7ubEENl9tXUArwzRpHPAkg1YVnaju8UINtubKSmpRrXaldvbq5GnxmEbzYL9ZA9RNiCkOsSro9Cf0DWe7l7XoIQj9C1XnlFtI3D7/kW52fHDhG+hJtAAbYEWpN63KM3JTURKxJjDRG1rEBgXt/UCVWlLxMdcYKO0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=bRLNCjgf; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-5cedfc32250so1141818a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 01 Feb 2024 10:53:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1706813595; x=1707418395; darn=vger.kernel.org;
        h=in-reply-to:from:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=koDBENw1FOmWGs2vD8XWYENIpE5s9I9E4GtInq6I/Ic=;
        b=bRLNCjgfBnRZGv62gyFj4HpHcigiMRynegsOhWw8MwmSmDVQ+WFOYBBol3QStmieTr
         m6T3bjyMbDjVAk90/Jocid+72f3rbPaHqjAYiHsOZpbFOEJB4E7H/Hw/rIqldiEEWlJb
         ufX6UjHUUCDM0PV2unP8dSKJUDBMvAFOZUQCo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706813595; x=1707418395;
        h=in-reply-to:from:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=koDBENw1FOmWGs2vD8XWYENIpE5s9I9E4GtInq6I/Ic=;
        b=xGzqzGfW/nDnyxMagFrQU8CbmU2CTgQIK+KG0vFBpw/Kzn/jcBEasTsCtjmuwLxsjO
         QZnQxOo+DWqfGjCu9jSTez1AF04yDczRA1qoVq5PyvJAhqQlwJ2fu3SGgtYVPwhKqIud
         wl0q/RUrLzS8KgNm4TsHjkczPfPt9XDiOTEOwR/uDUd2s/L/3QyiSExMda7dJDdNtOtE
         LarM7kUYLOeFa5QRGldDcjcG90OLVBcE4QEcRFqmcrTOAXSVBcXlSTLlgc4dK20/BrK+
         27B9SxQdxCewdTCeL8g4n/iIc4X+xX/1x+1dmfluGYBBKUvTODJUfSVmus0wM/y0Vz2N
         uC+A==
X-Gm-Message-State: AOJu0YzaS/RBZv/HuaUn8mhhyX487mI29fdoRbo6vDa4niOJyEx0AFtH
	CGuJ0o8rnIxH9WINDqPT5I2dBm7gU1usNotdmjz7LO2nMN5veGJYf4H/O0hYjw==
X-Google-Smtp-Source: AGHT+IGwtgi6gKn72gTw2Z7Dj4OWEwk1tNx9snF6G9NJD2qkEdfX2uNPupqPLautSakLAowYUmfklA==
X-Received: by 2002:a17:90a:ea89:b0:296:2307:573d with SMTP id h9-20020a17090aea8900b002962307573dmr1736088pjz.40.1706813594676;
        Thu, 01 Feb 2024 10:53:14 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCUVVWEcDZV3jzkF4oxjgvP/y8w1qfkkNKdIXYgztZHCyjyPTmPo7mGnz4C2r/RWWFM5SDXt5iVdpF6mRpcmiVfNrWRUOhTOSihgD4bkZwnIvPEB7DebbRR3zy5Q43rPa2NFoGZq/9gmMg/5Xx5bkJ791eMeGVb6NNerfuuyflM05KiQSztRUgGGJkzCTpDEqN5Ay76LW0/j0msUDIIbWMzbnmqUYneAkIuiiY+IBcdWmFjNrgkUsn1p2toQIgao1dq3HkCzxV7r4kLRwF5V5fO52w1WNp7HsmsI7RopR4/221q8uIAGt98/exYpWoDW12AqCxCf9kKdP4nnujJ4q3FmI5Z/bgi1TpvV2AlzVuP6vZ3RhitSDJFTi3sV8wcsoK8nEA2XX50fgNcnymNd4k563Jug1Zhvry8GhQuIGSo3dUhiEJuBFw8QlGfoYgO3tgvbYxFM4hL+VgCwdbTYvLIU7XHENVsbDNEHi49IcKM4IEbz5l0YcMmqGvbI0Wse53zIWbD17B74tghpLc99lAGLKBJBnzjO8CLbRKvvg9N0ExftkAaDR78DJeuUurHWLcYbX20R7mimSinAWVOMCHSMJjHO3stNj8PAQXtRFrQbkRYpyrpJ6tmbFZ7jZ4JJG1Wlb6k5FXEOOnQhKWaE7BiKAqJ/5FYlTrIa8RUmToUQydRaL+Y0aCdsD38tLaRBoNVMD/aP0uJItquEa8blkwFMSyABnc8OMSowoPpwSuLjIurDqNtUpq4eFpXctJFyJV5TrAtaGiCD49j9EdiV+U6xsqfOCQNZquUcuGEIQ3WxnOZp4t9DwEfe9wH8+v6gf7RfYmAJnAaKMM+MdN2CrcdP
Received: from [192.168.52.129] ([192.19.222.250])
        by smtp.gmail.com with ESMTPSA id h21-20020a17090adb9500b0029102d936casm3931936pjv.47.2024.02.01.10.53.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Feb 2024 10:53:13 -0800 (PST)
Message-ID: <9d54dead-7015-42fb-95b3-730ee8b2e553@broadcom.com>
Date: Thu, 1 Feb 2024 10:53:11 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 10/10] mtd: rawnand: brcmnand: allow for on-die ecc
To: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: David Regan <dregan@broadcom.com>, dregan@mail.com,
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>,
 robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
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
 <bcd9f8a5-7dab-42e6-b860-8a56ebb51cb6@broadcom.com>
 <20240201092558.5499ee6a@xps-13>
From: William Zhang <william.zhang@broadcom.com>
In-Reply-To: <20240201092558.5499ee6a@xps-13>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="00000000000009087a06105682da"

--00000000000009087a06105682da
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2/1/24 00:25, Miquel Raynal wrote:
> Hi William,
> 
>>>>>>>>>> This is a double check to turn on/off our hardware ECC.
>>>>>>>>>
>>>>>>>>> I expect the engine to be always disabled. Enable it only when you
>>>>>>>>> need (may require an additional patch before this one).
>>>>>>>>
>>>>>>>> We are already turning on the ECC enable at this point,
>>>>>>>> this is just adding the option to turn it off if the NAND chip
>>>>>>>> itself will be doing the ECC instead of our controller.
>>>>>>>
>>>>>>> Sorry if I have not been clear.
>>>>>>>
>>>>>>> This sequence:
>>>>>>> - init
>>>>>>> - enable hw ECC engine
>>>>>>> Is broken.
>>>>>>>    >>>> ECC engine is not enabled for all the cases. Here we only intended to enable it for the nand chip that is set to use NAND_ECC_ENGINE_TYPE_ON_HOST. The logic here should better change to:
>>>>>> if (chip->ecc.engine_type == NAND_ECC_ENGINE_TYPE_ON_HOST)
>>>>>>        brcmnand_set_ecc_enabled(host, 1);
>>>>>> else
>>>>>>        brcmnand_set_ecc_enabled(host, 0);
>>>>>>    >>>>> It *cannot* work as any operation going through exec_op now may
>>>>>>> perform page reads which should be unmodified by the ECC engine. You > driver *must* follow the following sequence:
>>>>>>> - init and disable (or keep disabled) the hw ECC engine
>>>>>>> - when you perform a page operation with correction you need to
>>>>>>>       - enable the engine
>>>>>>>       - perform the operation
>>>>>>>       - disable the engine
>>>>>>> Maybe I am missing something here but are you saying the exec_op can have different ecc type for page read/write at run time on the same nand chip? I don't see the op instr structure has the ecc type field and thought it is only bind to the nand chip and won't change at run time. So looks to me the init time setting to the engine based on ecc.engine_type should be sufficient.
>>>>>>
>>>>>> What you described here can work for the hw.ecc read path (ecc.read_page = brcmnand_read_page) which always assumes ecc is enabled. Although it is probably not too bad with these two extra operation, it would be better if we don't have to add anything as our current code does. For the brcmnand_read_page_raw,  we currently disable the engine and then re-enable it(but we need to fix it to only enable it with hw ecc engine type).  So it is just opposite of you logic but works the same with no impact on the most performance critical path.
>>>>>
>>>>> This is not "my" logic, this is the "core's" logic. I am saying: your
>>>>> approach is broken because that is not how the API is supposed to work,
>>>>> but it mostly works in the standard case.
>>>>
>>>> In the interest of minimizing register writes, would it be acceptable to
>>>> enable/disable ECC at the beginning of a standard
>>>> path transfer but not, after the transfer, turn off the ECC? This should not
>>>> affect other standard path operations nor affect the exec_op path as those
>>>> are low level transfers which our ECC engine would not touch and the NAND
>>>> device driver should be responsible for turning on/off its own ECC.
>>>
>>> Do you have legitimate concerns about this register write taking way
>>> more time than I could expect? Because compared to the transfer of a
>>> NAND page + tR/tPROG it should not be noticeable. I don't see how you
>>> could even measure such impact actually, unless the register write does
>>> way more than usual. I'm fine with the above idea if you show me it has
>>> an interest.
>>>    
>> Dave did the mtd_speed test and we can see we get consistently ~35KB/s slower with the extra enable and disable ecc engine calls in ecc read page path.
>>
>> With the change:
>> [   28.148355] mtd_speedtest:   page read speed is 9857 KiB/s
>> [   31.754258] mtd_speedtest: 2 page read speed is 9865 KiB/s
>> Without the change
>> [   56.444735] mtd_speedtest:   page read speed is 9892 KiB/s
>> [   60.042262] mtd_speedtest: 2 page read speed is 9897 KiB/s
> 
> I believe if you repeat this 10 times you'll get totally different
> results. I don't think this test on a non RT machine is precise enough
> so that a unique 35kiB difference can be interpreted as being
> significant.
> 
No, it is very consistent. It is not RT system but a bare minimum setup 
with just linux kernel, mtd/nand drivers and a shell. We don't run any 
apps and extra drivers. So the system is pretty idle while we run mtd 
speed test.

>> Although it is only less than 1% drop, it is still something. I understand the procedure you laid out above is the preferred way but with our driver fully control the chip ecc read/write page, ecc read_raw/write_raw page function and exec_op path, I don't see where it may not work.
> 
> I just told you, the exec_op path runs with ECC enabled. I don't know
> how this controller works. Now if you don't care and are 100% sure this
> is working and future proof, just keep it like this.
> 
This is something I don't get.  The patch basically only enable the ecc 
when NAND_ECC_ENGINE_TYPE_ON_HOST is set. But in this case exec_op does 
not do page read/write. Even page read/write go through exec_op, we do 
want the engine to do the ecc checking. So need to have it enabled. 
Other op like parameter read does not go through controller's ecc engine 
so it does not matter if ecc is on or not.

If NAND_ECC_ENGINE_TYPE_ON_DIE is set, this patch disable the controller 
engine and let NAND chip do the work as it requires.  So exec_op path 
run with ecc disabled when page read/write also go through exec_op path. 
  I don't see any issue with this either.

I am not trying to make your job hard but I want to understand if there 
is really any issue here.

> Cheers,
> Miquèl

--00000000000009087a06105682da
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
JOEwDQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEII6fcoPOR9bU24mzIuRMuGv+FEXo
vylOvYxMD0Wgh+tfMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI0
MDIwMTE4NTMxNVowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsG
CWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFl
AwQCATANBgkqhkiG9w0BAQEFAASCAQBy/LYY6fqACN4xItQAbtvOyrWZiadKaTsDLLBzjk+UDrMW
JW/OmKBwkpg692q9UvPek/FueL+m4PYjhWShGw6toaS9geGlfnCkiXpyVMN6ztV0Y5qY7aC3TW0y
DUzvaa2u8uygOaXn7Iy80S0JgMI30lIDnRP8IBkcz68F1OAbIBdaGWwpDpeek0jzEVBRlB0Yps2A
M9nCUskwYyqik2/AgU8p7HJldd0lxs9GoLTwaW/g+N7bVsPehJ3097QxaqHP1agVC3Pv9TSteaTs
7FG4hBVP5Z30b/zx/tVn2bD+qCMHyuUiucGxCnH3aUKOPMHaq3bkEeO/7S4QWNHz1dcn
--00000000000009087a06105682da--

