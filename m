Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 021FE79AEC9
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 01:45:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242528AbjIKU6E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 16:58:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243529AbjIKRR2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 13:17:28 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9692F1AD;
        Mon, 11 Sep 2023 10:17:23 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id 2adb3069b0e04-502153ae36cso7506619e87.3;
        Mon, 11 Sep 2023 10:17:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694452642; x=1695057442; darn=vger.kernel.org;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=SI5vlgRKYRNHM1C+DkX5FIATlpw7hyOP/MciW4qezs4=;
        b=CEG/GNZEFcoigcN1/Kzcm/xxVTvQTJ6YQIALk5DtwB/w/ZC7GjMaHXHBQb3jvYgdAJ
         19LsGJaWP38DQYGHjRgcOdm1Biwcvkdm4PgRfHwzZQNEDCXI7T6vFK3OTdpGlhwx7qHw
         MaNlrzZxHGBEZ/0FX1Wz5JpIXkHaAzwELbdOKgASxwfTlNwqI2h3p83QnOQi2fHVvs8d
         1l/EvaFum7f74bcC2zJy8BECdumI4LfJ7xPhI6X9XqaiKlSP5R/davcWPbWTNhlfyVKF
         GEgeJXFQZf9DJ28L8ozEYoCLGrpeJ/pzT2NdT0BaUIVv2SlNuoHtkeZ9JhZvO2r0gOSr
         /oag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694452642; x=1695057442;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SI5vlgRKYRNHM1C+DkX5FIATlpw7hyOP/MciW4qezs4=;
        b=k9+wLAlyboTMEMFzMVC1Fhw+TMdGmjAmgvlfJwvbDH+m1mFCDeBuZ74ZCFLh0C3ou3
         GBZ6mOeeEqijviTQ/UNpSdy/hE5F1RbtQrGju2iiMZDh0XYmh8ikp97e94fOXjx6Wuny
         /3JB8MqabhZCYETuaxUYcrPwRdWcuZQNBAt7hVmNYNuR9zQvg/UqHRivZIs8a+D1xmt3
         7788tsZiSrpueMeuWpbqlZAHtSBC+0p3i9MwZ+TuiQeiIjZmq2ayG2eqt09LyaRWSkVV
         MJLKew/nFRPXubFlS5RGhb0sdt5OqmpSvHUbnNtVp1T77EkVq56fiYt4uVtMeeOVSDLR
         ThEw==
X-Gm-Message-State: AOJu0Yz4Lxy8HsQqqxO99KU/mboIShSoxlL17mbV0agY6L4o23VzmKDO
        XBIiYplsdp0uFzXV15nwKjc=
X-Google-Smtp-Source: AGHT+IGQJHojqhRwH0OQBhk3JhUu00YPa6S2W1S/m1cP6oA0/UCR4y1XMC4AB9LxZ3CXkImsKxpW4Q==
X-Received: by 2002:a05:6512:108d:b0:500:97e4:587e with SMTP id j13-20020a056512108d00b0050097e4587emr9273543lfg.44.1694452641413;
        Mon, 11 Sep 2023 10:17:21 -0700 (PDT)
Received: from dell.localnet (77-255-201-154.dynamic.inetia.pl. [77.255.201.154])
        by smtp.gmail.com with ESMTPSA id kj13-20020a170907764d00b009a1b857e3a5sm5622150ejc.54.2023.09.11.10.17.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Sep 2023 10:17:20 -0700 (PDT)
From:   Janusz Krzysztofik <jmkrzyszt@gmail.com>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Aaro Koskinen <aaro.koskinen@iki.fi>,
        Tony Lindgren <tony@atomide.com>,
        Russell King <linux@armlinux.org.uk>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Dipen Patel <dipenp@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-acpi@vger.kernel.org, timestamp@lists.linux.dev,
        linux-tegra@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [RFT PATCH 15/21] arm: omap1: ams-delta: stop using gpiochip_find()
Date:   Mon, 11 Sep 2023 19:17:18 +0200
Message-ID: <4001581.3daJWjYHZt@dell>
In-Reply-To: <CAMRc=Mfrk9q6fJyEAuxDXYPpbjVHeLJaTjHEcKiYHzrE3r+_7A@mail.gmail.com>
References: <20230905185309.131295-1-brgl@bgdev.pl> <6555932.G0QQBjFxQf@dell>
 <CAMRc=Mfrk9q6fJyEAuxDXYPpbjVHeLJaTjHEcKiYHzrE3r+_7A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart6408794.j6PcuT4dK6";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart6408794.j6PcuT4dK6
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"; protected-headers="v1"
From: Janusz Krzysztofik <jmkrzyszt@gmail.com>
To: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Mon, 11 Sep 2023 19:17:18 +0200
Message-ID: <4001581.3daJWjYHZt@dell>
MIME-Version: 1.0

Hi Bartosz,

Dnia poniedzia=C5=82ek, 11 wrze=C5=9Bnia 2023 13:09:56 CEST Bartosz Golasze=
wski pisze:
> On Fri, Sep 8, 2023 at 8:07=E2=80=AFPM Janusz Krzysztofik <jmkrzyszt@gmai=
l.com> wrote:
> >
> > Dnia czwartek, 7 wrze=C5=9Bnia 2023 09:31:01 CEST Linus Walleij pisze:
> > > On Tue, Sep 5, 2023 at 8:53=E2=80=AFPM Bartosz Golaszewski <brgl@bgde=
v.pl> wrote:
> > >
> > > > From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> > > >
> > > > gpiochip_find() is going away as it's not hot-unplug safe. This pla=
tform
> > > > is not affected by any of the related problems as this GPIO control=
ler
> > > > cannot really go away but in order to finally remove this function,=
 we
> > > > need to convert it to using gpio_device_find() as well.
> > > >
> > > > Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> > >
> > > I was cleaning this one just some merge cycle ago, now it
> > > looks even better!
> > > Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> >
> > Acked-by: Janusz Krzysztofik <jmkrzyszt@gmail.com>
> >
>=20
> Janusz,
>=20
> Is it fine if I take it through the GPIO tree?

Yes, should be fine, I believe.  Tony, Aaro, any doubts?

Thanks,
Janusz

>=20
> Bartosz
>=20
> > Thanks,
> > Janusz
> >
> > >
> > > Yours,
> > > Linus Walleij
> > >
> >
> >
> >
> >
>=20


--nextPart6408794.j6PcuT4dK6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEnyr6IsGnTYAeAkHJ2WqSnltsjBoFAmT/S54ACgkQ2WqSnlts
jBqfwggAkqeTBmvDijSA5oujmDfSsAwfI3pBy3VlWvEHNLW4jys50C18KyynuMPa
QyvA9s4AZQjeusGTcGaGzSJ7KtMFCmTba/RuaP1mHrH/D9aXB0QlAhdaSoKEWpFl
2ClWbPt6nnGyMQ17eFTpip9HD4ylxRY/wT748JaWqWBQPsOaSDsq1ghsuQy/6Dy2
aos/iIizgrK5rhgxxBYmxHi7mm0Pa0sMkr6h8nqash55cMpCEMQeZmSV+GpDZ+vz
BevtWk7pY+j5WGhOYJNulyih6cdVOVU8J6LqpUCkvKDwK2DzjKFsPSxJ2g1qA7/C
B/sE4gkeNsH/dCnyiX/Rv1Kd3ak3YA==
=/Mjl
-----END PGP SIGNATURE-----

--nextPart6408794.j6PcuT4dK6--



