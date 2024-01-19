Return-Path: <linux-kernel+bounces-31494-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EDCA8832F00
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 19:36:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5463AB2482F
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 18:36:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56E194F20A;
	Fri, 19 Jan 2024 18:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Ya7Z7/nZ"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E0151D53A
	for <linux-kernel@vger.kernel.org>; Fri, 19 Jan 2024 18:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705689380; cv=none; b=Q06JgDxMxmKuEZewpvSulqqDzJq7+tdJBRR4h32Xz6pdIQ75L/IgzKmt2L3h7KE74ZEYpg1LdulBu6Cpk/U5kdimlvPU/my3+kfL09JW3uEIlJ/LyOagXuUQfurPfebjT+fRxLyKRO1ZqB5nGIYsRh5vHn0r26Zy/M+0K/eKOlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705689380; c=relaxed/simple;
	bh=9e8CUliaobnDhqtgloL1Jk86Vn6NoGD2buScWq1fCqU=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=uyv/m8sUJM16KEICpsFx/Tm01Hl36c70nPFPGrSdEgBB0BLwkDSyu2XDZ+PnRhip9AX4YxQj8dwW37ERJpkrRfvnIc6fyuIj/NgAI7rCgT54oh2di/gutLqRGvMs2HaNW2jhR4PjDfR9+rC0rxewrqZdsNAqnTDGLsorTRGWt38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=Ya7Z7/nZ; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1d70c150632so8839395ad.0
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jan 2024 10:36:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1705689377; x=1706294177; darn=vger.kernel.org;
        h=in-reply-to:mime-version:user-agent:date:message-id:from:references
         :cc:to:subject:from:to:cc:subject:date:message-id:reply-to;
        bh=ecQx2o594Z5TsCoaTrCclwbefwqIWEUPapMkX4Pl5ec=;
        b=Ya7Z7/nZgmi4/Y7LR1xuZD8DLmZvZXwtKXQeAqBXyfhuRfLsEX/sY/Ry6bRn2hTxkV
         A6VYcBOP1pczzz/9EnTbzy2DlbzxwAO8IfSc92NxJs1k8704PIAEfxQ7XXd8T0n1yN/y
         RxMdJWHppVIPhSYeGiEbs8Y2zBXjJQI6Xc6zU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705689377; x=1706294177;
        h=in-reply-to:mime-version:user-agent:date:message-id:from:references
         :cc:to:subject:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ecQx2o594Z5TsCoaTrCclwbefwqIWEUPapMkX4Pl5ec=;
        b=m2mU/Ja4FNZ/WlDO2N2xvU7Il3IyZQKY6Zvdo9J3tBhD1wv3HAxAXaD8kbdE/1u3ud
         uGby65pSCp4O+dZIzR/Qmr0WqXVYb6fSxGuKk0emQE0CI9V9Kxd9jsWWRAW/DA2q5iH7
         PxqLyRpOVA0oyAzAfGKnxjmB5uM3iLTiRdOvcRi5vG8oJVLtnQlQzwYoLSHFcZxPBt/Q
         1Nv15hBqE2ydPXLPwmfCZZqR2qzM+aem7YinKpbyKbPomK+BfcA5XHUhoisJDn9kUEXu
         WQujkDuYP+LLJPELXlCWPYFJv0hyjGvZXAxUFeqU5iyJeGlVZC6PUijAXDjfUbNaI82b
         yR8g==
X-Gm-Message-State: AOJu0YxPUwDJ2sDM43rLrID8wJiVWbQjSfIMDb0oNh7M4ZFbZxEUbEy2
	pIwfe5n2/h33o26Fx7rMKuwvsJHjtMhtcdQuJZ98nbh1Hx18c8WMwoIntQtVog==
X-Google-Smtp-Source: AGHT+IE79B9I4E/SuqKX9S6hwQg1UrI+OXY1PexGpwb2OdBAO2nnDGWsbALmSOje2zRoL0H8BtBucQ==
X-Received: by 2002:a17:902:740b:b0:1d4:32d8:ea78 with SMTP id g11-20020a170902740b00b001d432d8ea78mr311359pll.79.1705689376734;
        Fri, 19 Jan 2024 10:36:16 -0800 (PST)
Received: from bcacpedev-irv-3.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id l17-20020a170902d05100b001d5e34b3285sm3358877pll.16.2024.01.19.10.36.14
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 19 Jan 2024 10:36:15 -0800 (PST)
Subject: Re: [PATCH v2 01/10] dt-bindings: mtd: brcmnand: Updates for bcmbca
 SoCs
To: Conor Dooley <conor@kernel.org>, dregan@broadcom.com
Cc: dregan@mail.com, miquel.raynal@bootlin.com, richard@nod.at,
 vigneshr@ti.com, robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
 conor+dt@kernel.org, computersforpeace@gmail.com, kdasu.kdev@gmail.com,
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
 <20240119-retiree-fanciness-0f7bb37c4633@spud>
From: William Zhang <william.zhang@broadcom.com>
Message-ID: <3a87d0ac-f124-7db9-2a69-626cdc7f11ad@broadcom.com>
Date: Fri, 19 Jan 2024 10:36:13 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240119-retiree-fanciness-0f7bb37c4633@spud>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="0000000000006bb67b060f50c17a"

--0000000000006bb67b060f50c17a
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit

Hi,

On 01/19/2024 09:12 AM, Conor Dooley wrote:
> On Thu, Jan 18, 2024 at 11:53:47AM -0800, dregan@broadcom.com wrote:
>> From: William Zhang <william.zhang@broadcom.com>
>>
>> Update the descriptions to reflect different families of broadband SoC and
>> use the general name bcmbca for ARM based SoC.
>>
>> Add brcm,nand-use-wp property to have an option for disabling this
>> feature on broadband board design that does not use write protection.
>>
>> Add brcm,nand-ecc-use-strap to get ecc setting from board boot strap for
>> broadband board designs because they do not specify ecc setting in dts
>> but rather using the strap setting.
>>
>> Remove the requirement of interrupts property to reflect the driver
>> code. Also add myself to the list of maintainers.
>>
>> Signed-off-by: William Zhang <william.zhang@broadcom.com>
>> Reviewed-by: David Regan <dregan@broadcom.com>
>> ---
>> Changes in v2:
>> - Revert the new compatible string nand-bcmbca
>> - Drop the BCM63168 compatible fix to avoid any potential ABI
>> incompatibility issue
>> - Simplify the explanation for brcm,nand-use-wp
>> - Keep the interrupt name requirement when interrupt number is specified
>> ---
>>   .../bindings/mtd/brcm,brcmnand.yaml           | 36 +++++++++++++++----
>>   1 file changed, 30 insertions(+), 6 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/mtd/brcm,brcmnand.yaml b/Documentation/devicetree/bindings/mtd/brcm,brcmnand.yaml
>> index f57e96374e67..56176ec1a992 100644
>> --- a/Documentation/devicetree/bindings/mtd/brcm,brcmnand.yaml
>> +++ b/Documentation/devicetree/bindings/mtd/brcm,brcmnand.yaml
>> @@ -9,6 +9,7 @@ title: Broadcom STB NAND Controller
>>   maintainers:
>>     - Brian Norris <computersforpeace@gmail.com>
>>     - Kamal Dasu <kdasu.kdev@gmail.com>
>> +  - William Zhang <william.zhang@broadcom.com>
>>   
>>   description: |
>>     The Broadcom Set-Top Box NAND controller supports low-level access to raw NAND
>> @@ -18,9 +19,10 @@ description: |
>>     supports basic PROGRAM and READ functions, among other features.
>>   
>>     This controller was originally designed for STB SoCs (BCM7xxx) but is now
>> -  available on a variety of Broadcom SoCs, including some BCM3xxx, BCM63xx, and
>> -  iProc/Cygnus. Its history includes several similar (but not fully register
>> -  compatible) versions.
>> +  available on a variety of Broadcom SoCs, including some BCM3xxx, MIPS based
>> +  Broadband SoC (BCM63xx), ARM based Broadband SoC (BCMBCA) and iProc/Cygnus.
>> +  Its history includes several similar (but not fully register compatible)
>> +  versions.
>>   
>>     -- Additional SoC-specific NAND controller properties --
>>   
>> @@ -53,7 +55,7 @@ properties:
>>                 - brcm,brcmnand-v7.2
>>                 - brcm,brcmnand-v7.3
>>             - const: brcm,brcmnand
>> -      - description: BCM63138 SoC-specific NAND controller
>> +      - description: BCMBCA SoC-specific NAND controller
>>           items:
>>             - const: brcm,nand-bcm63138
>>             - enum:
>> @@ -65,7 +67,7 @@ properties:
>>             - const: brcm,nand-iproc
>>             - const: brcm,brcmnand-v6.1
>>             - const: brcm,brcmnand
>> -      - description: BCM63168 SoC-specific NAND controller
>> +      - description: BCM63xx SoC-specific NAND controller
>>           items:
>>             - const: brcm,nand-bcm63168
>>             - const: brcm,nand-bcm6368
>> @@ -111,6 +113,17 @@ properties:
>>         earlier versions of this core that include WP
>>       type: boolean
>>   
>> +  brcm,nand-use-wp:
>> +    description:
>> +      Use this property to indicate if board design uses
>> +      controller's write protection feature and connects its
>> +      NAND_WPb pin to nand chip's WP_L pin. Driver defaults to
>> +      use this feature when this property does not exist.
>> +      Set to 0 if WP pins are not connected and feature is not
>> +      used. Set to 1 if WP pins are connected and feature is used.
>> +    $ref: /schemas/types.yaml#/definitions/uint32
>> +    enum: [0, 1]
> 
> This property does not make sense to me. "Driver defaults to use this
> feature when the property does not exist" - either the property name is
> backwards or the description is. Secondly, I don't get why the property
> is an enum in the first place - depending on which if the name or
> description is wrong, either 0 or 1 would overlap with the default.
> 
The write protection feature was controlled by the module parameter 
wp_on with default set to enabled. But not all the board use this 
feature especially in BCMBCA broadband board. And module parameter is 
not sufficient as different board can have different option.  Add a 
device tree property to override this default behavior and allow this 
feature to be configured through the board dts on per board basis.

Maybe I can update the text here to
"By default the driver use a module parameter with default value set to 
enable to control this feature for all boards.  Use this dts property to 
override the default behavior and enable/disable this feature through 
board dts on per board basis"

>>   patternProperties:
>>     "^nand@[a-f0-9]$":
>>       type: object
>> @@ -137,6 +150,16 @@ patternProperties:
>>             layout.
>>           $ref: /schemas/types.yaml#/definitions/uint32
>>   
>> +      brcm,nand-ecc-use-strap:
>> +        description:
>> +          This flag is used by the driver to get the ecc strength and
>> +          spare area size from the SoC NAND boot strap setting. This
>> +          is commonly used by the BCMBCA SoC board design. If ecc
>> +          strength and spare area size are set by nand-ecc-strength
>> +          and brcm,nand-oob-sector-size in the dts, these settings
>> +          have precedence and override this flag.
>> +        $ref: /schemas/types.yaml#/definitions/flag
> 
> This property I'm not all that sure about either. If the specific
> properties that you mention here are not set in the DT what happens at
> the moment?
> 
In that case, the ecc strength and oob size come from ONFI or nand id 
decoding.  But that is usually the minimum requirement and user can 
choose to use stronger ecc as long as there is enough oob spare area in 
the nand chip.

> I suppose what I am getting at is why are the bootstrap settings not
> always used in the absence of specific values provided in the DT?
> 
This is because the STB, iProc and other chip and their board design may 
not have or use the strap setting. But for BCMBCA SoC and board 
reference design, we always use the strap setting.

> Thanks,
> Conor.
> 
>> +
>>       unevaluatedProperties: false
>>   
>>   allOf:
>> @@ -177,6 +200,8 @@ allOf:
>>               - const: iproc-idm
>>               - const: iproc-ext
>>     - if:
>> +      required:
>> +        - interrupts
>>         properties:
>>           interrupts:
>>             minItems: 2
>> @@ -189,7 +214,6 @@ unevaluatedProperties: false
>>   required:
>>     - reg
>>     - reg-names
>> -  - interrupts
>>   
>>   examples:
>>     - |
>> -- 
>> 2.37.3
>>

--0000000000006bb67b060f50c17a
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
JOEwDQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIB0+ze0nbAftgBf2B2DsQAgSTtYc
hAaPLQ8UOlaJQA/QMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI0
MDExOTE4MzYxN1owaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsG
CWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFl
AwQCATANBgkqhkiG9w0BAQEFAASCAQBL+JaxnylozMV1Efvj+ztCEcZuvIBMbT5Iz59pTn11mEmK
xZT/c84MzMNiQU1l32Wzzr6ap9vXC3AKF4izYJR/YHo05ff1it2FBX95NX3iZnLGPxzf5cvLIUsK
l0Kh5Nf9eWEQGr2FgUXfOOubA6Ti2HVa+KjN9cyzNHoYxuVHcDvMfAgV85OvfSCEAgbFnBXvVZUc
ZGQYtYZbHvDOLu5KU3SNeM9urBl1h3w0cBQBs/pZMfaMfzdus2YW1LSO9O9VYusey8Ofhm/fY4QG
6BO+qwMrZJCXFtJpORv13lk6UGc2KP5QvHdmxjZaVtux8kN6g5Pp4+Zyn4bOcG3vOt0a
--0000000000006bb67b060f50c17a--

