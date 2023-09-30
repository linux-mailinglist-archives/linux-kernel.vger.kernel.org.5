Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7F4A7B420F
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Sep 2023 18:18:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234502AbjI3QSC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Sep 2023 12:18:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232221AbjI3QSB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Sep 2023 12:18:01 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 865DDC6;
        Sat, 30 Sep 2023 09:17:59 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE0D3C433C9;
        Sat, 30 Sep 2023 16:17:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696090679;
        bh=Dzx0SZ8RA3eipu/LBIHEROksssiobsemvjwf/Cv4maY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Nf6Y0KE2FMbWYzx415ksQJJ0Hp5B5JNV39YRLplF0CCkteNNWZx1EaSHApH1TX0Pb
         AIiRQlKI4Vks0Va2FVZ2U3xfOtcSASCBRSvlZ0cKQ59nNXpKHgivtIfV3j8Xh/TZJZ
         LScpXhtzgt+0wkU2Pad2RBrBfbiZI3ThAQ0z2akUSNUzEF+VdzOu9S5LbXgkKk2vKs
         1/AyvBkHYZYXjhKE608mX36MEar0LU75qfWzi6k2BSY5Dv0cZzJUmstra395UGCeGJ
         2JlNiLADV1yY6mlUM9Jv8FBf2m52T/bMRT7Zy9FzTHXFVtMc9b811Ezjw85eZ3e+e7
         zyyo88ZYe0i0Q==
Date:   Sat, 30 Sep 2023 17:17:58 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Jagath Jog J <jagathjog1996@gmail.com>
Cc:     Denis Benato <benato.denis96@gmail.com>,
        andriy.shevchenko@linux.intel.com, lars@metafoo.de,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC 2/2] iio: imu: Add driver for BMI323 IMU
Message-ID: <20230930171758.34689af6@jic23-huawei>
In-Reply-To: <CAM+2EuJUGu4QUCdZ7d28RaLNipJRVuASP9wSzF14k=oBoC4e_Q@mail.gmail.com>
References: <20230918080314.11959-1-jagathjog1996@gmail.com>
        <20230918080314.11959-3-jagathjog1996@gmail.com>
        <20230924153055.0b3486f9@jic23-huawei>
        <CAM+2EuJBxj7P-ymu84u308g8LCemSEsYi_TSHYtaK9PyrhqrfA@mail.gmail.com>
        <5eb148b4-25eb-460d-9ec8-0a40bec1dc6f@gmail.com>
        <CAM+2EuJUGu4QUCdZ7d28RaLNipJRVuASP9wSzF14k=oBoC4e_Q@mail.gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 29 Sep 2023 13:29:13 +0530
Jagath Jog J <jagathjog1996@gmail.com> wrote:

> Hi Denis,
>=20
> On Thu, Sep 28, 2023 at 2:55=E2=80=AFAM Denis Benato <benato.denis96@gmai=
l.com> wrote:
> >
> > Hello,
> >
> > Some devices (as my asus rog ally) have an ACPI node describing a BOSC0=
200 sensor. The IC being used in those devices is a  bmi323 but as a result=
 of how the ACPI table reports that device, it is detected by the existing =
kernel module and we have no way of differentiating until after the chip ID=
 probe.
> >
> > The module loaded is bmc150-accel-i2c.c which currently doesn't support=
 the bmi323 and the loading of the module just fails at chip check. =20
>=20
> bmc150 driver supports multiple accelerometer sensors such as
> bma222, bma280, bmi055 and all of them are having similar
> register map, but the bmi323 register map is completely different
> from bmc150.

Horrible bios hacks that depend on a particular driver stack
are always a pain.

Hmm. Andy (handy ACPI expert), any suggestion?

We could maybe do a wrapper driver that does appropriate checks and wraps
the probe + remove from the two drivers?  Whilst we can obviously have a
single driver that deals with radically different devices I'm not
particularly keen on that as it tends to make things less maintainable.

Jonathan

>=20
>=20
> >
> > I have solved the problem by expanding the current bmc150-accel-i2c.c a=
nd bmc150-accel-core.c files to handle that IC in almost every part: gyrosc=
ope, accelerometer and temperature sensor.
> >
> > What is the best way of organizing code to have this module mainlined? =
Is it correct leaving files called bmc150-accel-* even if it is managing an=
other IC and and not just the accelerometer part anymore?
> >
> > TIA for your time.
> >
> > Best regards,
> > Denis Benato =20
>=20
> Regards
>=20
> Jagath

