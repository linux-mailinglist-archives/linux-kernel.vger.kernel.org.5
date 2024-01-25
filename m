Return-Path: <linux-kernel+bounces-39078-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0260783CAA3
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 19:14:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5E3CCB22611
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 18:14:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12A781339B3;
	Thu, 25 Jan 2024 18:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="STr+JAzA"
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DA8C131E45
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 18:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706206476; cv=none; b=okQqmTEosyQJhXCt3t/IWCXy1zDibzGv5mN1mIKt7YuvwMy+NVj/PsaFYm7Ki1Kbaud+V33aMuvL8PBkK0+0PYWEMEIEpi7E/yOn1a3721mI+rAbvC4Xzaxj6SExDf1zlRPDmBTos6IZypeSxevmeutjG+FpSZtDzM6AgHTTl/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706206476; c=relaxed/simple;
	bh=bguEoM0mHJy3cyp+PZiL0TYl8Z1JxL07au5zl664Tvs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KR9sn4DvTZlzpD+BovgiJPQTCG3Ls/LVHH1aee+j4hgsbQx4IVUDviiCX4RINbvDHgfOn3+MzjTYEA0CTEMAU28Mwux2CI8TSLVwyQw+7ygJ8isFNhNR0WUOI2uHj2kB8ClS8askNls9SvCbR38Fb0prp5jhHpWjOFkXWrbD1eI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=STr+JAzA; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-78313f4d149so610297285a.1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 10:14:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1706206473; x=1706811273; darn=vger.kernel.org;
        h=in-reply-to:from:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=qh4m2KO5FE810PtD0dK9TmVGfyhJbmLr0hu/S6yJ6gc=;
        b=STr+JAzAJ/n0i6JhHBvIngqhI0EeISSH0773EGHJpS9DWJ5MRZhcVB5nE2ZSLFYQ+a
         SVyVwLH0mR8uz+R13KM35WDDfFIMFJvoJ231jS1VrIVzY8/ZZtAZ/BNw2WVA7JB2PPBY
         m5Ze/IU4Jgx0Sbs+dmVC2XlvnCTEg9RNHf10c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706206473; x=1706811273;
        h=in-reply-to:from:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qh4m2KO5FE810PtD0dK9TmVGfyhJbmLr0hu/S6yJ6gc=;
        b=v2H9LVz82vzmFzT9BDXozpB2yIQPp0e9gV9QE28/iFFGN2TAx/nvjXuzivFjN+ybhL
         bKJvZHqGUsLAKT6KWzIs1p+AR+kn+aQNu1MQJ/pRg/9j7aRYn3oeMnFeWMYPpWHKJ+jK
         QU82iiHyXva+dej7daQOTrlmLHuL89rJwdXZvjJ9wKBJJ/p2g+PCe2W6Gflhy/EHkoIT
         1gSGfi+lEqN7Jw4GyNr9vSAVeUaUypcKFaYbMMtt3JCuOWyr11VtMN+x/ccNrCwDDw3q
         pOFiLGsC64mlg9RUF5qh4qIlGyGLkd+UKLYr5wQRG/hQqrkm3RgHnHKbGYNoXs7NKKUu
         wPrw==
X-Gm-Message-State: AOJu0YyM3Y5gwlmYNlnjGJk1zAdpRSIdt+QK16KZTbYx/TFcOKIgNkUC
	LjsFgk4yeZyrLcPU2c+IkXslTkC7Gx1VK7giL3lTAgcJoxPmuOVbRSsXB6/rcg==
X-Google-Smtp-Source: AGHT+IFFnGugJakjWH6sSes6QtJ3nrnwoDtbxipIKJUUxsM0OmPvS2pUsZp2+XBoKLkn2CHN1T+7/g==
X-Received: by 2002:a05:6214:2404:b0:686:ad1b:1a60 with SMTP id fv4-20020a056214240400b00686ad1b1a60mr68060qvb.59.1706206473133;
        Thu, 25 Jan 2024 10:14:33 -0800 (PST)
Received: from [192.168.52.129] ([192.19.222.250])
        by smtp.gmail.com with ESMTPSA id ee7-20020a0562140a4700b006816843f6dcsm5673088qvb.137.2024.01.25.10.14.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Jan 2024 10:14:29 -0800 (PST)
Message-ID: <6cca1b89-0dd5-4276-b03d-d356b2ede136@broadcom.com>
Date: Thu, 25 Jan 2024 10:14:26 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 02/10] ARM: dts: broadcom: bcmbca: Add NAND controller
 node
To: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Florian Fainelli <florian.fainelli@broadcom.com>,
 David Regan <dregan@broadcom.com>, dregan@mail.com, richard@nod.at,
 vigneshr@ti.com, robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
 conor+dt@kernel.org, computersforpeace@gmail.com, kdasu.kdev@gmail.com,
 linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, joel.peshkin@broadcom.com,
 tomer.yacoby@broadcom.com, dan.beygelman@broadcom.com,
 anand.gore@broadcom.com, kursad.oney@broadcom.com, rafal@milecki.pl,
 bcm-kernel-feedback-list@broadcom.com, andre.przywara@arm.com,
 baruch@tkos.co.il, linux-arm-kernel@lists.infradead.org,
 dan.carpenter@linaro.org
References: <20240124030458.98408-1-dregan@broadcom.com>
 <20240124030458.98408-3-dregan@broadcom.com> <20240124183008.04a1bcb0@xps-13>
 <2c10a764-f74f-45b2-8bba-77c40468f4b5@broadcom.com>
 <85c97d00-a973-46c6-974c-3dfa587ae873@broadcom.com>
 <722d6bdf-9a43-436d-a9e2-4c21e1deb8c3@broadcom.com>
 <20240125102058.5ae46d8a@xps-13>
From: William Zhang <william.zhang@broadcom.com>
In-Reply-To: <20240125102058.5ae46d8a@xps-13>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000c3b50d060fc92688"

--000000000000c3b50d060fc92688
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Miquel,

On 1/25/24 01:20, Miquel Raynal wrote:
> Hi William,
> 
>>>>>> +        nand_controller: nand-controller@1800 {
>>>>>> +            #address-cells = <1>;
>>>>>> +            #size-cells = <0>;
>>>>>> +            compatible = "brcm,nand-bcm63138", >>>> "brcm,brcmnand-v7.1", "brcm,brcmnand";
>>>>>> +            reg = <0x1800 0x600>, <0x2000 0x10>;
>>>>>> +            reg-names = "nand", "nand-int-base";
>>>>>> +            brcm,nand-use-wp = <0>;
>>>>>> +            status = "disabled";
>>>>>> +
>>>>>> +            nandcs: nand@0 {
>>>>>> +                compatible = "brcm,nandcs";
>>>>>> +                reg = <0>;
>>>>>> +                nand-on-flash-bbt;
>>>>>> +                brcm,nand-ecc-use-strap;
>>>>>
>>>>> Describing the NAND chip in a SoC DTSI does not look relevant to me.
>>>>> Even more if you add something like this nand-ecc-use-strap setting
>>>>> which is very board dependent.
>>>>>   
>>>> I am not sure if I understand you comments correctly but are you >> suggesting to put this whole nand controller node into each board dts? >> We have other ip block nodes like SPI, uart in this same soc dtsi file >> too.  For all the bcmbca soc dtsi I am updating here(and its board >> design), we always use the strap to for ecc setting.  So I thought it >> should be okay to put brcm,nand-ecc-use-strap in the default dtsi >> file. For any board that uses the raw nand nand-ecc property, the >> board dts can do so and override the brcm,nand-ecc-use-strap setting.
>>>
>>> I read Miquel's comment as meaning that the nandcs aka the NAND > chip/flash part description should be in the board .dts file, while the > controller itself can remain in the .dtsi file with its status = > "disabled" property.
>>>
>>> Are there customer boards, that is non reference boards that might chose > a different chip select number and/or not use the strap settings?
>> In BCMBCA SoC, there is only one cs and customer design also have to use strap for the bootrom to boot up properly.  They can override it with dts in linux but I don't think any customer would do that.
>>
>> Maybe the nand-on-flash-bbt could be possible item that customer may have to set it differently if they don't follow our reference software design.
>>
>> I will move the nand-on-flash-bbt to the board dts but I would like to keep the other default nandcs settings in SoC.dsti if that is not too out of the conventional rule and Miquel is okay with it.
> 
> I think there is a global misunderstanding regarding the use of the
> nand-ecc-* properties. These are not the default. The default is the OS
> choice and depends on the NAND capabilities. The OS will always try to
> match the closest ECC settings offered by the engine, based on the NAND
> chip requirements which are discoverable. If you want to maximize your
> strength, it is also possible to tell the OS with a dedicated (generic)
This is the nand-ecc-* property, right?

> property. And only if you want something different, you may use these
> properties, but they should be the exception rather than the rule.
> 
> Overriding this with a strap is a bad hardware design on commercial
> products IMO. I am totally fine with the idea of a strap to choose
> the ECC configuration for development boards/evaluation kits, but once
> you've decided which setting you want you cannot change it for the
> lifetime of your project (or with a lot of difficulties) so I don't see
> the point of such a strap. So really, I don't like the idea of defining
> by default a variable which asks for an override of the defaults, even
> though many of your customers might want to use that.
Correct, no change to strap is possible on real product because they are 
always through soldered down resister and no dip switch/jumper for ecc 
strap. But as the SoC requires, it is part of bootstrap each product has 
to set and that's how bootloader get the ecc setting as it does not have 
the access to the dts and the capability to auto select the ecc setting.

Most of the time, customer will set strap to match the OS auto selected 
ecc setting but there are times customer want more strength so yes they 
can use nand-ecc-* to override but it has to match the strap setting. 
Then I think it make sense and much easier for customer to just use 
strap to override and reduce the any manual setting error in dts. It 
will cause many trouble down the road if the edit does not match strap 
setting.  Not saying this is for everyone but definitively a good 
feature for our product and it reduces ecc setting error in case of 
overriding OS default selection.

> 
> So, anything that is design dependent (the chip CS, ECC
> configuration, etc) should go into the board DTS, and what is SoC
> related hardware (like the definition of the NAND controller) should
> stay in the DTSI, as properly clarified by Florian.
> 
Okay I will move nand-on-flash-bbt and brcm,nand-ecc-use-strap from soc 
dtsi to board dts but leave the default nandcs node with compatible and 
reg = 0 in the dtsi as they are not design dependent and board dts can 
conveniently reference the nandcs node.

> Thanks,
> Miquèl

--000000000000c3b50d060fc92688
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
JOEwDQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIPxYEAjitgnSuAiKOiGTXCYSavh8
21zG/jkf3y5ybGAbMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI0
MDEyNTE4MTQzM1owaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsG
CWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFl
AwQCATANBgkqhkiG9w0BAQEFAASCAQCETq3m8RkuWDpI6a55kAVEy3h/kLQdRmOmzEw/HDC4rVb0
SjaGsoNxn1Sj+rJ2fUnmGiSZSiGc2MLxG50TWlbBph5arwJe/1pUbI3eRoHhnX9NrZjN+iwWu7sZ
lMQTcjFtoKnIY51NgooLbnbELo0HeAaf41GIQN4ZCo8JEe3SPCoIbcMcidcpSAJe1DlRpzX+SKAq
H047d7swCpMW3tceuMQ5BTdsW/gYoGVh1iCzubv0+Xo1B3GvC7sc8kTxlt0eNNYz2xWw9JniS+C3
QM1Rk5UAarjelgXtPDciN4JRo//ofn4MMPKbtoA+EOP6r+cusvPl+cmD/ZnNuvuSepF7
--000000000000c3b50d060fc92688--

