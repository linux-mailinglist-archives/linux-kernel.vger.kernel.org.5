Return-Path: <linux-kernel+bounces-35980-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57C6B839972
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 20:24:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 070A828B6C2
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 19:24:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4E7E823B0;
	Tue, 23 Jan 2024 19:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="SyTACI7t"
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 070D1612D4
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 19:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706037848; cv=none; b=m2C7KOJBY/A2abpUa3M0/SxLzEyKRg0G75TDpFqafveIl0hxwL5PO+Fw8pTfTmcM4zvFDNzuvddJtdGhHjIomuml1g68wXhAdoCsPW4XHnoZSTwI/uYy/hBVR9g1ToiVQ+pJG8vJyPYqOgizooN3siDpvmgUv8IsSpc9Crgd6Bs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706037848; c=relaxed/simple;
	bh=0ZX9j54KYRijAcoplZets1Kbc2e+DFw/oZSWq/2AvE4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QVvcpHBI452F9GGYJhsnOru0IKMBMchHZ7YzNA4geeTMoeCK+wcFXChluPe9Kvup9NHlb7FlN9q7qW+yxhGsc3eatGZm8EL338LCSHctXteIo/K/XoMMEdng91yq2QYnx9JUfDCI4NnPtlQvTY6o/GLg57KftHuA6/WC5pSdEVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=SyTACI7t; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-6869233d472so9375036d6.2
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 11:24:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1706037846; x=1706642646; darn=vger.kernel.org;
        h=in-reply-to:from:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=wkIUfEXwRu/+N4sOiOwy8ir++STVN+XYpVkosyYabeg=;
        b=SyTACI7tAG0qoW6FVlp/XCFVwFg9VgCl0Q/xHerYWhgwAi/yFtMGiGlrnkhHnqQGo4
         10SlRzFtErZdUN06Wn+gAlQMYSewSlvWVwqquwTjRy3kSFdCIPsiiYQIYNn5jKd8P20C
         1yac0YsTAZvaWfhGDzVcdEmEGEX5FrNEiUulU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706037846; x=1706642646;
        h=in-reply-to:from:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wkIUfEXwRu/+N4sOiOwy8ir++STVN+XYpVkosyYabeg=;
        b=j95/6HSeY4MlrcKb+LfdXAwOu51tve+vW0lkQxNhP1zVeiq8TYwSCSOA6wzqgeMiQM
         U8zQBO7YI1IURDU0ObwAzqHNIJy4kb3VxlkEIBobJVIKO7jHTp/N3pwuP0jzaSsE1wlt
         fyglAM8cfzUJEiVOKtC4MOBgoT4BhTqpCdOV3pS/aO5L8i+IVyeXf5lPp5b7XpYr0vyL
         OG8pP73pFNxTAYzgWmjNhAGhiyaAD6CQAAZ8OgrDumZiXY6HIf3ktatT6G6CM8Pg8Gpu
         epYG9VjHiU0yJGz+KmuqyMsBi/lSkb1UlQqu5En8P73Ub7rsZGVp6WySNTmnrE1Aaoc1
         pePg==
X-Gm-Message-State: AOJu0Yxm6gEMbE/hF7EXc4o3sEgIYksJbRnaNJa4cbfYrMhNBOYGl2q/
	SMYL1rQ5810WEM4HN1Dq/qrtmcsrRkh3bTDkfFAJ9ooRo8C28o2NZxYHNeHLjg==
X-Google-Smtp-Source: AGHT+IHQnC70I2pgI/rxPqRXpqXHYc91aMJtQ8yQGsumeUGBbLShjI7nlHntw/uDzYDG15pRNvZROg==
X-Received: by 2002:ad4:5bea:0:b0:686:949b:6c6d with SMTP id k10-20020ad45bea000000b00686949b6c6dmr1251105qvc.79.1706037845842;
        Tue, 23 Jan 2024 11:24:05 -0800 (PST)
Received: from [192.168.52.129] ([192.19.222.250])
        by smtp.gmail.com with ESMTPSA id qd24-20020ad44818000000b00680b1090832sm3658446qvb.146.2024.01.23.11.24.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Jan 2024 11:24:04 -0800 (PST)
Message-ID: <662e1c6e-7b79-4171-8d28-01023912fab5@broadcom.com>
Date: Tue, 23 Jan 2024 11:24:01 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 01/10] dt-bindings: mtd: brcmnand: Updates for bcmbca
 SoCs
To: Jonas Gorski <jonas.gorski@gmail.com>
Cc: dregan@broadcom.com, dregan@mail.com, miquel.raynal@bootlin.com,
 richard@nod.at, vigneshr@ti.com, robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 computersforpeace@gmail.com, kdasu.kdev@gmail.com,
 linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, joel.peshkin@broadcom.com,
 tomer.yacoby@broadcom.com, dan.beygelman@broadcom.com,
 anand.gore@broadcom.com, kursad.oney@broadcom.com,
 florian.fainelli@broadcom.com, rafal@milecki.pl,
 bcm-kernel-feedback-list@broadcom.com, andre.przywara@arm.com,
 baruch@tkos.co.il, linux-arm-kernel@lists.infradead.org,
 dan.carpenter@linaro.org
References: <20240118195356.133391-1-dregan@broadcom.com>
 <20240118195356.133391-2-dregan@broadcom.com>
 <CAOiHx=k2Wn+UaVFbB-n2XKmFuBss4LKmLSW45YME07z=7zg0ww@mail.gmail.com>
 <c1fc163b-1f4f-42a5-91c3-b31ad33a9741@broadcom.com>
 <CAOiHx=n62Ap8bGbTu0xcKMHcqgpaLZ-GNjsW2DQ5XPrnsxmAJw@mail.gmail.com>
From: William Zhang <william.zhang@broadcom.com>
In-Reply-To: <CAOiHx=n62Ap8bGbTu0xcKMHcqgpaLZ-GNjsW2DQ5XPrnsxmAJw@mail.gmail.com>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000cb5a13060fa1e3f1"

--000000000000cb5a13060fa1e3f1
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 1/23/24 02:34, Jonas Gorski wrote:
> On Mon, 22 Jan 2024 at 18:34, William Zhang <william.zhang@broadcom.com> wrote:
>>
>> Hi,
>>
>> On 1/22/24 03:48, Jonas Gorski wrote:
>>> Hi,
>>>
>>> On Thu, 18 Jan 2024 at 20:56, <dregan@broadcom.com> wrote:
>>>>
>>>> From: William Zhang <william.zhang@broadcom.com>
>>>>
>>>> Update the descriptions to reflect different families of broadband SoC and
>>>> use the general name bcmbca for ARM based SoC.
>>>>
>>>> Add brcm,nand-use-wp property to have an option for disabling this
>>>> feature on broadband board design that does not use write protection.
>>>>
>>>> Add brcm,nand-ecc-use-strap to get ecc setting from board boot strap for
>>>> broadband board designs because they do not specify ecc setting in dts
>>>> but rather using the strap setting.
>>>>
>>>> Remove the requirement of interrupts property to reflect the driver
>>>> code. Also add myself to the list of maintainers.
>>>>
>>>> Signed-off-by: William Zhang <william.zhang@broadcom.com>
>>>> Reviewed-by: David Regan <dregan@broadcom.com>
>>>> ---
>>>> Changes in v2:
>>>> - Revert the new compatible string nand-bcmbca
>>>> - Drop the BCM63168 compatible fix to avoid any potential ABI
>>>> incompatibility issue
>>>> - Simplify the explanation for brcm,nand-use-wp
>>>> - Keep the interrupt name requirement when interrupt number is specified
>>>> ---
>>>>    .../bindings/mtd/brcm,brcmnand.yaml           | 36 +++++++++++++++----
>>>>    1 file changed, 30 insertions(+), 6 deletions(-)
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/mtd/brcm,brcmnand.yaml b/Documentation/devicetree/bindings/mtd/brcm,brcmnand.yaml
>>>> index f57e96374e67..56176ec1a992 100644
>>>> --- a/Documentation/devicetree/bindings/mtd/brcm,brcmnand.yaml
>>>> +++ b/Documentation/devicetree/bindings/mtd/brcm,brcmnand.yaml
>>>> @@ -9,6 +9,7 @@ title: Broadcom STB NAND Controller
>>>>    maintainers:
>>>>      - Brian Norris <computersforpeace@gmail.com>
>>>>      - Kamal Dasu <kdasu.kdev@gmail.com>
>>>> +  - William Zhang <william.zhang@broadcom.com>
>>>>
>>>>    description: |
>>>>      The Broadcom Set-Top Box NAND controller supports low-level access to raw NAND
>>>> @@ -18,9 +19,10 @@ description: |
>>>>      supports basic PROGRAM and READ functions, among other features.
>>>>
>>>>      This controller was originally designed for STB SoCs (BCM7xxx) but is now
>>>> -  available on a variety of Broadcom SoCs, including some BCM3xxx, BCM63xx, and
>>>> -  iProc/Cygnus. Its history includes several similar (but not fully register
>>>> -  compatible) versions.
>>>> +  available on a variety of Broadcom SoCs, including some BCM3xxx, MIPS based
>>>> +  Broadband SoC (BCM63xx), ARM based Broadband SoC (BCMBCA) and iProc/Cygnus.
>>>> +  Its history includes several similar (but not fully register compatible)
>>>> +  versions.
>>>>
>>>>      -- Additional SoC-specific NAND controller properties --
>>>>
>>>> @@ -53,7 +55,7 @@ properties:
>>>>                  - brcm,brcmnand-v7.2
>>>>                  - brcm,brcmnand-v7.3
>>>>              - const: brcm,brcmnand
>>>> -      - description: BCM63138 SoC-specific NAND controller
>>>> +      - description: BCMBCA SoC-specific NAND controller
>>>>            items:
>>>>              - const: brcm,nand-bcm63138
>>>>              - enum:
>>>> @@ -65,7 +67,7 @@ properties:
>>>>              - const: brcm,nand-iproc
>>>>              - const: brcm,brcmnand-v6.1
>>>>              - const: brcm,brcmnand
>>>> -      - description: BCM63168 SoC-specific NAND controller
>>>> +      - description: BCM63xx SoC-specific NAND controller
>>>
>>> Only the BCM63268 family has a v4.0 NAND controller with support for
>>> ONFI and raw access; BCM6368 has a v2.1, and BCM6328 and BCM6362 have
>>> a v2.2.
>>>
>>> So claiming this is a generic binding is wrong; you would need to add
>>> the appropriate variants first. Or add another one for the BCM6368
>>> NAND v2.x controllers, which is missing. You can find them used in
>>> arch/mips/boot/dts/brcm/bcm63{28,62,68}.dtsi.
>>>
>> I am not changing binding here but jsut update the description to
>> identify these MIPS based chip as bcm63xx family. This convention is
>> used in other IP blocks too.  And yes this binding is not correct and I
>> noticed the same v2.x usage in the dtsi files you pointed out. So I
>> actually updated this binding in my v1 here
>> https://lore.kernel.org/lkml/20230606231252.94838-6-william.zhang@broadcom.com/
>> but there was some concern as it could possibly break the ABI in that
>> thread's discussion.
> 
> That change did change the ABI that would have (AFAICT) broken it for BCM63168.
> 
> My point is: This binding in its current state is valid *only* for the
> BCM63168 NAND controller, and not for any other BCM63xx NAND
> controllers.
> 
I didn't know that 6368 does not work. I will revert this change then.

> So changing the description to BCM63xx is wrong, unless you extend it
> to also match the BCM6328/6362/6368 NAND controller bindings as used.
> 
> I can send a patch adding the missing binding parts, I actually have a
> WIP one lying around as I started trying to address dts issues in the
> MIPS bcm63xx dts(i) files a while ago.
> 
Yeah and if you can update it to bcm63xx, that will be great!

> Best Regards,
> Jonas

--000000000000cb5a13060fa1e3f1
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIIQcAYJKoZIhvcNAQcCoIIQYTCCEF0CAQExDzANBglghkgBZQMEAgEFADALBgkqhkiG9w0BBwGg
gg3HMIIFDTCCA/WgAwIBAgIQeEqpED+lv77edQixNJMdADANBgkqhkiG9w0BAQsFADBMMSAwHgYD
VQQLExdHbG9iYWxTaWduIFJvb3QgQ0EgLSBSMzETMBEGA1UEChMKR2xvYmFsU2lnbjETMBEGA1UE
AxMKR2xvYmFsU2lnbjAeFw0yMDA5MTYwMDAwMDBaFw0yODA5MTYwMDAwMDBaMFsxCzAJBgNVBAYT
AkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMTEwLwYDVQQDEyhHbG9iYWxTaWduIEdDQyBS
MyBQZXJzb25hbFNpZ24gMiBDQSAyMDIwMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEA
vbCmXCcsbZ/a0fRIQMBxp4gJnnyeneFYpEtNydrZZ+GeKSMdHiDgXD1UnRSIudKo+moQ6YlCOu4t
rVWO/EiXfYnK7zeop26ry1RpKtogB7/O115zultAz64ydQYLe+a1e/czkALg3sgTcOOcFZTXk38e
aqsXsipoX1vsNurqPtnC27TWsA7pk4uKXscFjkeUE8JZu9BDKaswZygxBOPBQBwrA5+20Wxlk6k1
e6EKaaNaNZUy30q3ArEf30ZDpXyfCtiXnupjSK8WU2cK4qsEtj09JS4+mhi0CTCrCnXAzum3tgcH
cHRg0prcSzzEUDQWoFxyuqwiwhHu3sPQNmFOMwIDAQABo4IB2jCCAdYwDgYDVR0PAQH/BAQDAgGG
MGAGA1UdJQRZMFcGCCsGAQUFBwMCBggrBgEFBQcDBAYKKwYBBAGCNxQCAgYKKwYBBAGCNwoDBAYJ
KwYBBAGCNxUGBgorBgEEAYI3CgMMBggrBgEFBQcDBwYIKwYBBQUHAxEwEgYDVR0TAQH/BAgwBgEB
/wIBADAdBgNVHQ4EFgQUljPR5lgXWzR1ioFWZNW+SN6hj88wHwYDVR0jBBgwFoAUj/BLf6guRSSu
TVD6Y5qL3uLdG7wwegYIKwYBBQUHAQEEbjBsMC0GCCsGAQUFBzABhiFodHRwOi8vb2NzcC5nbG9i
YWxzaWduLmNvbS9yb290cjMwOwYIKwYBBQUHMAKGL2h0dHA6Ly9zZWN1cmUuZ2xvYmFsc2lnbi5j
b20vY2FjZXJ0L3Jvb3QtcjMuY3J0MDYGA1UdHwQvMC0wK6ApoCeGJWh0dHA6Ly9jcmwuZ2xvYmFs
c2lnbi5jb20vcm9vdC1yMy5jcmwwWgYDVR0gBFMwUTALBgkrBgEEAaAyASgwQgYKKwYBBAGgMgEo
CjA0MDIGCCsGAQUFBwIBFiZodHRwczovL3d3dy5nbG9iYWxzaWduLmNvbS9yZXBvc2l0b3J5LzAN
BgkqhkiG9w0BAQsFAAOCAQEAdAXk/XCnDeAOd9nNEUvWPxblOQ/5o/q6OIeTYvoEvUUi2qHUOtbf
jBGdTptFsXXe4RgjVF9b6DuizgYfy+cILmvi5hfk3Iq8MAZsgtW+A/otQsJvK2wRatLE61RbzkX8
9/OXEZ1zT7t/q2RiJqzpvV8NChxIj+P7WTtepPm9AIj0Keue+gS2qvzAZAY34ZZeRHgA7g5O4TPJ
/oTd+4rgiU++wLDlcZYd/slFkaT3xg4qWDepEMjT4T1qFOQIL+ijUArYS4owpPg9NISTKa1qqKWJ
jFoyms0d0GwOniIIbBvhI2MJ7BSY9MYtWVT5jJO3tsVHwj4cp92CSFuGwunFMzCCA18wggJHoAMC
AQICCwQAAAAAASFYUwiiMA0GCSqGSIb3DQEBCwUAMEwxIDAeBgNVBAsTF0dsb2JhbFNpZ24gUm9v
dCBDQSAtIFIzMRMwEQYDVQQKEwpHbG9iYWxTaWduMRMwEQYDVQQDEwpHbG9iYWxTaWduMB4XDTA5
MDMxODEwMDAwMFoXDTI5MDMxODEwMDAwMFowTDEgMB4GA1UECxMXR2xvYmFsU2lnbiBSb290IENB
IC0gUjMxEzARBgNVBAoTCkdsb2JhbFNpZ24xEzARBgNVBAMTCkdsb2JhbFNpZ24wggEiMA0GCSqG
SIb3DQEBAQUAA4IBDwAwggEKAoIBAQDMJXaQeQZ4Ihb1wIO2hMoonv0FdhHFrYhy/EYCQ8eyip0E
XyTLLkvhYIJG4VKrDIFHcGzdZNHr9SyjD4I9DCuul9e2FIYQebs7E4B3jAjhSdJqYi8fXvqWaN+J
J5U4nwbXPsnLJlkNc96wyOkmDoMVxu9bi9IEYMpJpij2aTv2y8gokeWdimFXN6x0FNx04Druci8u
nPvQu7/1PQDhBjPogiuuU6Y6FnOM3UEOIDrAtKeh6bJPkC4yYOlXy7kEkmho5TgmYHWyn3f/kRTv
riBJ/K1AFUjRAjFhGV64l++td7dkmnq/X8ET75ti+w1s4FRpFqkD2m7pg5NxdsZphYIXAgMBAAGj
QjBAMA4GA1UdDwEB/wQEAwIBBjAPBgNVHRMBAf8EBTADAQH/MB0GA1UdDgQWBBSP8Et/qC5FJK5N
UPpjmove4t0bvDANBgkqhkiG9w0BAQsFAAOCAQEAS0DbwFCq/sgM7/eWVEVJu5YACUGssxOGhigH
M8pr5nS5ugAtrqQK0/Xx8Q+Kv3NnSoPHRHt44K9ubG8DKY4zOUXDjuS5V2yq/BKW7FPGLeQkbLmU
Y/vcU2hnVj6DuM81IcPJaP7O2sJTqsyQiunwXUaMld16WCgaLx3ezQA3QY/tRG3XUyiXfvNnBB4V
14qWtNPeTCekTBtzc3b0F5nCH3oO4y0IrQocLP88q1UOD5F+NuvDV0m+4S4tfGCLw0FREyOdzvcy
a5QBqJnnLDMfOjsl0oZAzjsshnjJYS8Uuu7bVW/fhO4FCU29KNhyztNiUGUe65KXgzHZs7XKR1g/
XzCCBU8wggQ3oAMCAQICDDG6HZcbcVdEvVYk4TANBgkqhkiG9w0BAQsFADBbMQswCQYDVQQGEwJC
RTEZMBcGA1UEChMQR2xvYmFsU2lnbiBudi1zYTExMC8GA1UEAxMoR2xvYmFsU2lnbiBHQ0MgUjMg
UGVyc29uYWxTaWduIDIgQ0EgMjAyMDAeFw0yMjA5MTAxMTMxNDVaFw0yNTA5MTAxMTMxNDVaMIGQ
MQswCQYDVQQGEwJJTjESMBAGA1UECBMJS2FybmF0YWthMRIwEAYDVQQHEwlCYW5nYWxvcmUxFjAU
BgNVBAoTDUJyb2FkY29tIEluYy4xFjAUBgNVBAMTDVdpbGxpYW0gWmhhbmcxKTAnBgkqhkiG9w0B
CQEWGndpbGxpYW0uemhhbmdAYnJvYWRjb20uY29tMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIB
CgKCAQEAyKF+RmY29Wvfmfe3L8J4rZNmBIvRmrWKI5td5L0vlpPMCEzUkVhBdL2N9cDP0rPScvWL
CX/9cI1a2BUy/6/ZT5j9PhcUn6A3kwKFGukLY2itfKaDrP3ANVJGhBXPVJ6sx55GF41PkiL2EMnY
7LJGNpl9WHYrw8VqtRediPyXq8M6ZWGPZWxygsE6y1pOkEk9qLpvXTb2Epxk2JWcQFZQCDWVULue
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
JOEwDQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIDbweeD7HgIdc0CiLlbHUhs+UVJY
Xg5TRJBMopyesQ/eMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI0
MDEyMzE5MjQwNlowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsG
CWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFl
AwQCATANBgkqhkiG9w0BAQEFAASCAQCm+iqaiO5de0yM8lqhNyp9fJe8koPHlnyBTNcjl/etD2Pv
rgAxUz5FxH4NjfFIOtg/+0ukRfHdPA/pKmrYqujict8nMnX+llKu11csmmJn6K2mdZ+xUyTpP4ip
g6NCNO5Cjwb0S/1i9OYAB0GJejCqwTyab0LaupySDbHPuwUVGMCkib49EzHjc3O/urVAqqetxJwK
ailVLJR8xI96EQ1V1OoC7un9lOArbpqsVMj8jUL9cgi8nCW50pt46reOwgiJSHyDIqhgFgyczcz9
t8ZYQ2b3O9fLtMeBRZIEIbNZ4NkX/y8NrY6zOVLl508C9o3VQZvw1HZBpd9EUy7M3Zro
--000000000000cb5a13060fa1e3f1--

