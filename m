Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A3907FD1CD
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 10:11:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232731AbjK2JKh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 04:10:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232114AbjK2JKe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 04:10:34 -0500
Received: from mail-ua1-x92c.google.com (mail-ua1-x92c.google.com [IPv6:2607:f8b0:4864:20::92c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE23185
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 01:10:40 -0800 (PST)
Received: by mail-ua1-x92c.google.com with SMTP id a1e0cc1a2514c-7c46d224b45so1604138241.3
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 01:10:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1701249040; x=1701853840; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7DXF9O1RgHRA6Q4+fsCadrVtEFEpBPHwaju2dJOOLyU=;
        b=j/gPBD0xqdZ/fuvsfhXb/jVD55/2QIOtjPiRvZvpQWoiIDNmlzgdxT76A+X+mUy/n0
         ZWcZZpkiokA02A3g4PoFz4d6JeQ2hcbwUBt+UbcTVwpCISATLXL1TjMxU5w77wNOnFur
         LN+T2lq9DND9p9zRtughCQFh0meyG2ZiUsIZPn0pSEGRgqh1P6cDIVIeTYDqo008HRmy
         j4DkC3BLEztSDzXqC8GMWUfJlrxEB0SLclUenWqdk5zJMIhNirKeHKm9sE3V6f1lzSdk
         2hi1uvER5qyHbcS/duscddG9cjTTS4mgdpNFp4OWhAgYIBl91NUQH8qmJUKm4gDCW8Km
         L+WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701249040; x=1701853840;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7DXF9O1RgHRA6Q4+fsCadrVtEFEpBPHwaju2dJOOLyU=;
        b=boMfWaHCmSsO5XF+RBSAQCyBhJfPnJ41yw1is9WWInPAHT22iE3D47YXltJMuuNYY8
         uKcBn2JsqvGGEpavpoD5m8hJN5ERGZKUgFgdWtU0AkcEUKr5jK7BD7Pd8rzo05sESohy
         BBQBITpAe+EQSwgcNGzHgaXekV6s6XN1u3d+re118Ccp06RFGfFbcAwN/FXcENCGaFNQ
         qnyhbrHCZZT+xFH2EYfJnerQSkveEQagJpAc4kgpnoS9lh9Mm9vrZCvL4+9N+bLRy3nJ
         2x5G90DbSa1bzJfuIbBaclgqCNJj1F8yf9PBvNdoSDIcqKriWH72CnVU/SJ9O7zNE7JO
         6BAw==
X-Gm-Message-State: AOJu0YzzRPnpEZqlKAu2y++ZYOC3ZZRfT88xloQFvl1z9ShDZoBMMBXE
        SL8mr+FDxIwSS0LwJFoJocxjyg+frsrg5Rw4yOihgQ==
X-Google-Smtp-Source: AGHT+IF2abYTUSSPdqJxK8T5iWMOWvfZzKBy02SfSs6APR/05/WMDIgddE4+dHi4tbmO6pUDo8nkRwKOy9RHzF4FKCA=
X-Received: by 2002:a05:6102:3746:b0:462:866e:2f2f with SMTP id
 u6-20020a056102374600b00462866e2f2fmr14921238vst.9.1701249039789; Wed, 29 Nov
 2023 01:10:39 -0800 (PST)
MIME-Version: 1.0
References: <20231127164623.1008176-1-m.felsch@pengutronix.de>
In-Reply-To: <20231127164623.1008176-1-m.felsch@pengutronix.de>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Wed, 29 Nov 2023 10:10:28 +0100
Message-ID: <CAMRc=MdsEWxJLHL__zYXGEMYvvLSH99GsTRv_NTaVXt2fGtNvg@mail.gmail.com>
Subject: Re: [RFC PATCH] mtd: devices: add AT24 eeprom support
To:     Marco Felsch <m.felsch@pengutronix.de>
Cc:     miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
        arnd@arndb.de, gregkh@linuxfoundation.org,
        linux-i2c@vger.kernel.org, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org, kernel@pengutronix.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 27, 2023 at 5:46=E2=80=AFPM Marco Felsch <m.felsch@pengutronix.=
de> wrote:
>

[snip]

>
> I dropped the backward compatibility since this is a new driver not
> having to deal with it. The old and the new driver can not be used by
> the same kernel config. So it is either using the MTD eeprom driver
> supporting partitioning and NVMEM or the older one which does not
> support partitioning but keeps the backward compatibility.
>
> Comments and suggestions are very welcome :)

I skimmed through the code. Nothing obviously wrong. What I would
suggest - if we're going to have two at24 drivers - is a lot more code
reuse. I dislike the idea of having basically the same code in two
places in the kernel and having to fix bugs in both.

Though if I'm being honest - I would prefer a single driver with
backwards compatibility. Have you estimated the effort it would take
to abstract both nvmem and mtd?

[snip]

> +
> +static const struct of_device_id at24_of_match[] =3D {
> +       { .compatible =3D "atmel,24c00",          .data =3D &at24_data_24=
c00 },
> +       { .compatible =3D "atmel,24c01",          .data =3D &at24_data_24=
c01 },
> +       { .compatible =3D "atmel,24cs01",         .data =3D &at24_data_24=
cs01 },
> +       { .compatible =3D "atmel,24c02",          .data =3D &at24_data_24=
c02 },
> +       { .compatible =3D "atmel,24cs02",         .data =3D &at24_data_24=
cs02 },
> +       { .compatible =3D "atmel,24mac402",       .data =3D &at24_data_24=
mac402 },
> +       { .compatible =3D "atmel,24mac602",       .data =3D &at24_data_24=
mac602 },
> +       { .compatible =3D "atmel,spd",            .data =3D &at24_data_sp=
d },
> +       { .compatible =3D "atmel,24c04",          .data =3D &at24_data_24=
c04 },
> +       { .compatible =3D "atmel,24cs04",         .data =3D &at24_data_24=
cs04 },
> +       { .compatible =3D "atmel,24c08",          .data =3D &at24_data_24=
c08 },
> +       { .compatible =3D "atmel,24cs08",         .data =3D &at24_data_24=
cs08 },
> +       { .compatible =3D "atmel,24c16",          .data =3D &at24_data_24=
c16 },
> +       { .compatible =3D "atmel,24cs16",         .data =3D &at24_data_24=
cs16 },
> +       { .compatible =3D "atmel,24c32",          .data =3D &at24_data_24=
c32 },
> +       { .compatible =3D "atmel,24cs32",         .data =3D &at24_data_24=
cs32 },
> +       { .compatible =3D "atmel,24c64",          .data =3D &at24_data_24=
c64 },
> +       { .compatible =3D "atmel,24cs64",         .data =3D &at24_data_24=
cs64 },
> +       { .compatible =3D "atmel,24c128",         .data =3D &at24_data_24=
c128 },
> +       { .compatible =3D "atmel,24c256",         .data =3D &at24_data_24=
c256 },
> +       { .compatible =3D "atmel,24c512",         .data =3D &at24_data_24=
c512 },
> +       { .compatible =3D "atmel,24c1024",        .data =3D &at24_data_24=
c1024 },
> +       { .compatible =3D "atmel,24c1025",        .data =3D &at24_data_24=
c1025 },
> +       { .compatible =3D "atmel,24c2048",        .data =3D &at24_data_24=
c2048 },
> +       { /* END OF LIST */ },
> +};
> +MODULE_DEVICE_TABLE(of, at24_of_match);

This is one of examples: I have a patch queued for the nvmem version
where we use of_match_ptr() and add __maybe_unused to this struct.
There's no reason really to have that struct duplicated.

[snip]

> diff --git a/drivers/mtd/mtdcore.c b/drivers/mtd/mtdcore.c
> index 6d83e72a24d2..1a850b19515d 100644
> --- a/drivers/mtd/mtdcore.c
> +++ b/drivers/mtd/mtdcore.c
> @@ -148,6 +148,9 @@ static ssize_t mtd_type_show(struct device *dev,
>         case MTD_ROM:
>                 type =3D "rom";
>                 break;
> +       case MTD_EEPROM:
> +               type =3D "eeprom";
> +               break;
>         case MTD_NORFLASH:
>                 type =3D "nor";
>                 break;
> diff --git a/include/uapi/mtd/mtd-abi.h b/include/uapi/mtd/mtd-abi.h
> index 714d55b49d2a..59bf43d58ddb 100644
> --- a/include/uapi/mtd/mtd-abi.h
> +++ b/include/uapi/mtd/mtd-abi.h
> @@ -146,6 +146,7 @@ struct mtd_read_req {
>  #define MTD_DATAFLASH          6
>  #define MTD_UBIVOLUME          7
>  #define MTD_MLCNANDFLASH       8       /* MLC NAND (including TLC) */
> +#define MTD_EEPROM             9
>
>  #define MTD_WRITEABLE          0x400   /* Device is writeable */
>  #define MTD_BIT_WRITEABLE      0x800   /* Single bits can be flipped */
> @@ -159,6 +160,7 @@ struct mtd_read_req {
>  #define MTD_CAP_NORFLASH       (MTD_WRITEABLE | MTD_BIT_WRITEABLE)
>  #define MTD_CAP_NANDFLASH      (MTD_WRITEABLE)
>  #define MTD_CAP_NVRAM          (MTD_WRITEABLE | MTD_BIT_WRITEABLE | MTD_=
NO_ERASE)
> +#define MTD_CAP_EEPROM         (MTD_WRITEABLE | MTD_BIT_WRITEABLE | MTD_=
NO_ERASE)
>
>  /* Obsolete ECC byte placement modes (used with obsolete MEMGETOOBSEL) *=
/
>  #define MTD_NANDECC_OFF                0       /* Switch off ECC (Not re=
commended) */
> --
> 2.39.2
>

The infrastructure for supporting EEPROM should be sent as a separate patch=
 IMO.

Bart
