Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F334A803870
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 16:15:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234045AbjLDPPS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 10:15:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231594AbjLDPPR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 10:15:17 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3FCEB2
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 07:15:23 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08FE8C433C7;
        Mon,  4 Dec 2023 15:15:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701702923;
        bh=BOM1EV4bba9ClKDdr+6k5WZ62Teyd2Rgs3hahYp9izU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=LUQ/JInBnw5u1yUBx5xwlGXP3zGOWSnHAHgjcjOFSt2LaTNvH/Wv1HGtE/A1I5xvG
         IPZolxBQTkEFTyh2zuOtZC1SqLsPRS6dhNeW+DQ0OXzdAxSozQx7bEoNyPgZkBD68z
         hjki1mfO12qJWC5nqLDwwztW6ippl+hpJvIXSEBlt0GHp/FhmpB+VIe9N1O7mp9BEV
         pek0XoAOUGO9VlpSWNvLWrNnlHuY5F2fhTuvdFhtpbFbdVCE9QZxdkkS3zV93eUgD9
         no6gIb5Km2xfKFp39bJqSfpOJVO0rRwPY4Q5Esyq5Bbn2dej/uybaU2mblNjKer9w7
         XjuCRgMGdQMvg==
Date:   Mon, 4 Dec 2023 15:15:14 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Nuno =?UTF-8?B?U8Oh?= <noname.nuno@gmail.com>
Cc:     David Lechner <dlechner@baylibre.com>, nuno.sa@analog.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-iio@vger.kernel.org,
        Olivier MOYSAN <olivier.moysan@foss.st.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>
Subject: Re: [PATCH 04/12] iio: adc: ad9467: fix reset gpio handling
Message-ID: <20231204151514.4e2c8ada@jic23-huawei>
In-Reply-To: <3925cb4b6453644c889675c20329b3477a06fcd5.camel@gmail.com>
References: <20231121-dev-iio-backend-v1-0-6a3d542eba35@analog.com>
        <20231121-dev-iio-backend-v1-4-6a3d542eba35@analog.com>
        <CAMknhBGCqnzCp6vQ+59Z-SybScvbtU7aWdAD6KnP1e6=q60gVQ@mail.gmail.com>
        <d534c3323c32d4ed2aedae19a9f101be90ef0cc7.camel@gmail.com>
        <CAMknhBGjm2ja9HOenOWi9O5Ao8qUg=gT=_Vz8CyxQ=pfNX2EJQ@mail.gmail.com>
        <3925cb4b6453644c889675c20329b3477a06fcd5.camel@gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 02 Dec 2023 09:36:47 +0100
Nuno S=C3=A1 <noname.nuno@gmail.com> wrote:

> On Fri, 2023-12-01 at 11:01 -0600, David Lechner wrote:
> > On Fri, Dec 1, 2023 at 2:47=E2=80=AFAM Nuno S=C3=A1 <noname.nuno@gmail.=
com> wrote: =20
> > >=20
> > > On Thu, 2023-11-30 at 15:41 -0600, David Lechner wrote: =20
> > > > On Tue, Nov 21, 2023 at 4:17=E2=80=AFAM Nuno Sa via B4 Relay
> > > > <devnull+nuno.sa.analog.com@kernel.org> wrote: =20
> > > > >=20
> > > > > From: Nuno Sa <nuno.sa@analog.com>
> > > > >=20
> > > > > The reset gpio was being requested with GPIOD_OUT_LOW which means=
, not
> > > > > asserted. Then it was being asserted but never de-asserted which =
means
> > > > > the devices was left in reset. Fix it by de-asserting the gpio. =
=20
> > > >=20
> > > > It could be helpful to update the devicetree bindings to state the
> > > > expected active-high or active-low setting for this gpio so it is
> > > > clear which state means asserted.
> > > >  =20
> > >=20
> > > You could state that the chip is active low but I don't see that chan=
ge that
> > > important for now. Not sure if this is clear and maybe that's why you=
r comment.
> > > GPIOD_OUT_HIGH has nothing to do with active high or low. It just mea=
ns, "get me
> > > the
> > > pin in the asserted state".
> > >  =20
> >=20
> > I would assume that this bug happened in the first place because
> > someone forgot GPIOD_OUT_LOW in the devicetree when they were
> > developing the driver. So this is why I suggested that updating the
> > devicetree binding docs so that future users are less likely to make
> > the same mistake. Currently, the bindings don't even have reset-gpios
> > in the examples. =20
>=20
> Hmm, I think you're missing the point... The bug has nothing to do with d=
evicetree.
> This is what was happening:
>=20
> 1) We were calling devm_gpiod_get_optional() with GPIOD_OUT_LOW. What thi=
s means is
> that you get an output gpio deasserted. Hence the device is out of reset.=
 And here is
> the important part... what you have in dts does not matter. If you have a=
ctive low,
> it means the pin level will be 1. If you have high, the pin level is 0. A=
nd this is
> all handled by gpiolib for you.=20
>=20
> 2) Then, we called gpiod_direction_output(..., 1), which means set the di=
rection out
> (which is actually not needed since it was already done when getting the =
pin) and
> assert the pin. Hence, reset the device. And we were never de-asserting t=
he pin so
> the device would be left in reset.

Functionally I believe David is correct.   Flipping the DT would 'fix' this.
It's all down to a nreset vs reset pin description.

In this case I guess it's defined a a 'not reset' on the datasheet which is=
 what
is causing the confusion.  It's not uncommon for people to refer to a reset=
 when
they mean a "not reset" with assumptions on polarity to match.

Jonathan



>=20
> - Nuno S=C3=A1

