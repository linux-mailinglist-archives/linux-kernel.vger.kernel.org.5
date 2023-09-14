Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6FBD7A0FE3
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 23:31:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229691AbjINVbS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 17:31:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbjINVbR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 17:31:17 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1064F1FD5
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 14:31:13 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id 4fb4d7f45d1cf-529fb04a234so1671214a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 14:31:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1694727071; x=1695331871; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=b/XO11xKJ7TzLaMECg8g4ikZHDL97iec/3fGlgg/yAU=;
        b=gcMEWAvXLo59NCxTdC8LuTTRu7kTYT8KzvkucpQ7sdz4rLzFctLvXiwiiVqF2Szc7f
         g01D4v/xPRL6MUDM/zqynndlqHRejpsz9e+/5vfH2UOZKv56Yd29nYFF2wNyJDfWYMva
         xbNedFffK1shy3majx4akxfJ/HE28OR4NYZnk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694727071; x=1695331871;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=b/XO11xKJ7TzLaMECg8g4ikZHDL97iec/3fGlgg/yAU=;
        b=BEJE3WupeAdH82xvOA76KBDIFCnCfldRYMvz7vYN9todtR4ypK4rtgvW0oSgr21jIM
         hm2s9n8uH6Tfxl2vDkznbafdoRkWg6zq8A24nqoX0N1+WWc8PAN+TxADqHLZQZo9ZARf
         SOTZbEjmGIgguwOP3v5pRshu6gw7HKGcd6iz9qwi5t9y+MqRbEPg9V+iQSVOscOlmPHC
         v7m4TZt34e/gCwF4F5YgQZzmdnPQdur9Z9mkeYF8UATf/CJfepw7AmIt584G+IcxC+zd
         q8DdamsNq6gmOKyNRDStoPwVmPRyI9DwmPrRVu/zCfCKT25qhylL+yipPIdJ8KE25mX+
         BaZw==
X-Gm-Message-State: AOJu0YyGFzSm2n4f/2RQUHVF2/4byfUsvp35vF1uK+dI2xxfrtarLuxR
        AV8dX2oH1hFxjxUuRhY812KW11WTLSj8vRerbQGkFBWFjMy9V3HquPU=
X-Google-Smtp-Source: AGHT+IFndJkV88+TyavACFrq20EMNgk//KS1D/S2/Vl17YlKu37OzOOtOBB7wrOmCWdjlL2c69s9NlWZX/ARwDq6Hb4=
X-Received: by 2002:aa7:c71a:0:b0:522:1bdd:d41a with SMTP id
 i26-20020aa7c71a000000b005221bddd41amr6198995edq.4.1694727071495; Thu, 14 Sep
 2023 14:31:11 -0700 (PDT)
MIME-Version: 1.0
References: <20230914064922.3986-1-zajec5@gmail.com> <28fad55f-1253-deb2-9615-b32746129664@gmail.com>
In-Reply-To: <28fad55f-1253-deb2-9615-b32746129664@gmail.com>
From:   Scott Branden <scott.branden@broadcom.com>
Date:   Thu, 14 Sep 2023 14:30:58 -0700
Message-ID: <CA+Jzhd+HLoUDifQQ5vF7m66X3rsk1Bk2yx_0h6eSzaUwXVa72w@mail.gmail.com>
Subject: Re: [PATCH] nvmem: brcm_nvram: store a copy of NVRAM content
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        linux-mtd@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>,
        =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>,
        Florian Fainelli <florian.fainelli@broadcom.com>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="0000000000001ac79b06055865bc"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--0000000000001ac79b06055865bc
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 14, 2023 at 2:26=E2=80=AFPM Florian Fainelli <f.fainelli@gmail.=
com> wrote:
>
> On 9/13/23 23:49, Rafa=C5=82 Mi=C5=82ecki wrote:
> > From: Rafa=C5=82 Mi=C5=82ecki <rafal@milecki.pl>
> >
> > This driver uses MMIO access for reading NVRAM from a flash device.
> > Underneath there is a flash controller that reads data and provides
> > mapping window.
> >
> > Using MMIO interface affects controller configuration and may break rea=
l
> > controller driver. It was reported by multiple users of devices with
> > NVRAM stored on NAND.
> >
> > Modify driver to read & cache all NVRAM content during init and use tha=
t
> > copy to provide NVMEM data when requested.
> >
> > Link: https://lore.kernel.org/linux-mtd/CACna6rwf3_9QVjYcM+847biTX=3DK0=
EoWXuXcSMkJO1Vy_5vmVqA@mail.gmail.com/
> > Cc: Ar=C4=B1n=C3=A7 =C3=9CNAL <arinc.unal@arinc9.com>
> > Cc: Florian Fainelli <florian.fainelli@broadcom.com>
> > Cc: Scott Branden <scott.branden@broadcom.com>
> > Signed-off-by: Rafa=C5=82 Mi=C5=82ecki <rafal@milecki.pl>
> > ---
> [snip]
> > -     priv->base =3D devm_platform_get_and_ioremap_resource(pdev, 0, &r=
es);
> > -     if (IS_ERR(priv->base))
> > -             return PTR_ERR(priv->base);
> > +     base =3D devm_platform_get_and_ioremap_resource(pdev, 0, &res);
> > +     if (IS_ERR(base))
> > +             return PTR_ERR(base);
> > +
> > +     priv->size =3D resource_size(res);
> > +
> > +     priv->data =3D devm_kzalloc(dev, priv->size, GFP_KERNEL);
>
> These can conceivably quite big data structures, how about using kvmalloc=
()?
Why do we even need to expose MMIO interface to NAND though?  Why not
always go through the controller driver.  I don't see how the MMIO
access would be used given bad blocks aren't handled?
> --
> Florian
>

--0000000000001ac79b06055865bc
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
aon9PduLGVgSMfiFb2nQ2w0PzDSefbrZKRQAGcSvcQlWb8XU7YKGbLhjR9c/r3KF4iUW8w2T2pd+
bO6aQXt8b1C9YG/V+B65TuJXxgX0veIJEyP+Cl0Im5vNwwIDAQABo4IB2zCCAdcwDgYDVR0PAQH/
BAQDAgWgMIGjBggrBgEFBQcBAQSBljCBkzBOBggrBgEFBQcwAoZCaHR0cDovL3NlY3VyZS5nbG9i
YWxzaWduLmNvbS9jYWNlcnQvZ3NnY2NyM3BlcnNvbmFsc2lnbjJjYTIwMjAuY3J0MEEGCCsGAQUF
BzABhjVodHRwOi8vb2NzcC5nbG9iYWxzaWduLmNvbS9nc2djY3IzcGVyc29uYWxzaWduMmNhMjAy
MDBNBgNVHSAERjBEMEIGCisGAQQBoDIBKAowNDAyBggrBgEFBQcCARYmaHR0cHM6Ly93d3cuZ2xv
YmFsc2lnbi5jb20vcmVwb3NpdG9yeS8wCQYDVR0TBAIwADBJBgNVHR8EQjBAMD6gPKA6hjhodHRw
Oi8vY3JsLmdsb2JhbHNpZ24uY29tL2dzZ2NjcjNwZXJzb25hbHNpZ24yY2EyMDIwLmNybDAlBgNV
HREEHjAcgRpzY290dC5icmFuZGVuQGJyb2FkY29tLmNvbTATBgNVHSUEDDAKBggrBgEFBQcDBDAf
BgNVHSMEGDAWgBSWM9HmWBdbNHWKgVZk1b5I3qGPzzAdBgNVHQ4EFgQU8+MSO/sprODwb9D5cjaq
JNiLqgkwDQYJKoZIhvcNAQELBQADggEBAA25uPHwC95BhvFXuEOAk+J5FZV4v82uly/X7LATDzrf
tsww461GRAidKV8lvziiIw6OQQgO9Ei/yC8bVdzDLQJF2PhxcWhc+4II6AkUyRC+Tmfk7xmPEYSv
MHgQfpwPU6C1o4FI/8XjfJgk1dE4j4v16iLKC2qfBqfdzdT/cJaCg/fZfL0w5RLtGOOVIMBWwObx
UKmtYSCgcvRKmLailjlxgiUaYgxdZSpwR0RvFJapt0KzMR5OIP96iyXYVWbl9qy8uY9gqEeNaaQm
Bt8T4oEXHxRvse+Ij162RjEysEsDgkiE/koCb3YFlkVu5lL1N0M7EIo+XiuWWUEjuhztPasxggJt
MIICaQIBATBrMFsxCzAJBgNVBAYTAkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMTEwLwYD
VQQDEyhHbG9iYWxTaWduIEdDQyBSMyBQZXJzb25hbFNpZ24gMiBDQSAyMDIwAgxPA+M+AQMMGpZn
bCswDQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIA+9800koustB3KivdctLWewJ0qc
g5eALXKyquqXHu2+MBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTIz
MDkxNDIxMzExMVowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsG
CWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFl
AwQCATANBgkqhkiG9w0BAQEFAASCAQA09hGQ80F8pX+z7eJJmLReKutI6rM3/Lj2a0DRMt65JhbM
LR8Rv8XKCS1vDzg6bQRvhVtkMAKRrvk7CxBKbZAr7Umqmy74JuDkrj+el5HUgXfOtdhU3IaI6WOA
tK4PDszMY3sv5xN5KD46WSnwUdxshpzYbrlcfS4q4I8SQZsVm905VUHB5dkZZhz7eb0rn319CWAH
hBsUw399HWWrk4HkcRl1J3OcpK9/8wnMicmspcT7OzqKgdbsYm6QsC50CufYjx/3QA+TIf+lCHu2
aBCd5Myb2wC+lIa9sdflhnDKGQ80hhEmpeeU87W/jza/bgz03h43umzMg2XqUaNMTiqb
--0000000000001ac79b06055865bc--
