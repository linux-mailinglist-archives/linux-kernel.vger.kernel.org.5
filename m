Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F9FD78B586
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 18:44:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232203AbjH1Qnn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 12:43:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232559AbjH1QnS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 12:43:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 854DE132;
        Mon, 28 Aug 2023 09:43:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F021B64BCA;
        Mon, 28 Aug 2023 16:43:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEFAAC433C8;
        Mon, 28 Aug 2023 16:43:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693240994;
        bh=KPrMH9Cz6xf9vHhCampnQF2DPCzBGUacD0Nc5EfhZYA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=iwGWWMrZw+A8p7XBo1vaOChaNZcg1HgVcvGZt+EHDY9URgP149jYFq/+NTo323PBW
         BZOnxfG78A8zyBdTVlBy7bmE+Xcn4zGb1dnVd4//+1bKhxoFaqHTAKRLeycD4lBoQw
         SdN4fZdPsD+NEoebIntx9EBbOqYx+iuw62Gii7DOVfFEBzhSp2D76rP8dJFRbDy2tO
         7lrE6U3HKq86/RkO1UQQ9j9BT4SuFMiFn+kBr1A9h9NsBsMr1FZQIHcIjmpzMCMXv+
         K1x1oOEA/+MXTnzZkt23vYfY3IdhWn+B4xXdsAthrDVQ2umaMjlsn3pbb4ia5ltJ8b
         Vi/Rl6KDSOcHw==
Date:   Mon, 28 Aug 2023 17:43:32 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Lorenzo Bianconi <lorenzo@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Mario Tesi <mario.tesi@st.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] iio: lsm6dsx: Support temperature channel
Message-ID: <20230828174332.101ecbcf@jic23-huawei>
In-Reply-To: <CACRpkdYUnpb4oo+4pBxhQqbnquDP_+w3ecGoFX18TTC9BSZFwg@mail.gmail.com>
References: <20230811-iio-spacex-lsm6ds0-v1-0-e953a440170d@linaro.org>
        <20230811-iio-spacex-lsm6ds0-v1-1-e953a440170d@linaro.org>
        <ZNYIaagdt7HuRet5@lore-rh-laptop>
        <CACRpkdYHMyfvAGxgvtB8jgTsOp36Lm4gXzVYcBfXdY7RQK36cQ@mail.gmail.com>
        <ZNdOOuXy7vON/Shb@lore-rh-laptop>
        <CACRpkdYUnpb4oo+4pBxhQqbnquDP_+w3ecGoFX18TTC9BSZFwg@mail.gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 12 Aug 2023 22:40:19 +0200
Linus Walleij <linus.walleij@linaro.org> wrote:

> On Sat, Aug 12, 2023 at 11:17=E2=80=AFAM Lorenzo Bianconi <lorenzo@kernel=
.org> wrote:
>=20
> > > > looking at the ISM330DHCX datasheet, the temperature sensor ODR is =
just 52Hz,
> > > > while values in 0x0A register are used only for FIFO decimation, th=
ey are not
> > > > values you can configure the sensor e.g. for read_one_shot(). =20
>=20
> BTW looked at this and the read_one_shot() call uses
> register 0x20/0x21 as appropriate.
>=20
> > > > =20
> > > > > +                             .odr_avl[0] =3D {  26000, 0x02 },
> > > > > +                             .odr_avl[1] =3D {  52000, 0x03 },
> > > > > +                             .odr_len =3D 2, =20
> > >
> > > I look at page 44, paragraph 9.6 about bits 4-5:
> > >
> > > ODR_T_BATCH_[1:0]
> > > Selects batch data rate (write frequency in FIFO) for temperature data
> > > (00: Temperature not batched in FIFO (default);
> > > 01: 1.6 Hz;
> > > 10: 12.5 Hz;
> > > 11: 52 Hz) =20
> >
> > AFAIR the batch register is used to sub-sample sensor data before queue=
ing them
> > into the FIFO (please check st_lsm6dsx_set_fifo_odr()), but it does not=
 refer
> > to the configured sensor ODR.
> > Looking at the device application-note [0], the temperature sensor ODR =
depends
> > on the accel/gyro one:
> >
> > - temperature sensor ODR =3D=3D accel sensor ODR if accel ODR is < 52Hz=
 and the
> >   gyro is in power-down
> > - temperature sensor ODR =3D 52Hz if accel ODR > 52Hz or if the gyro is=
 not in
> >   power-down =20
>=20
> We handle the TEMP along with the EXT channels in
> st_lsm6dsx_set_odr() which actually makes sure to match
> the data rate of the accelerometer.
>=20
> It looks as nobody cared to look into the issue with the
> gyroscope though :/ It feels like a whole separate issue,
> I expect more channels to be affected by that...
>=20
> Yours,
> Linus Walleij
FWIW this seems crazy.  Ah well, Lorenzo is the expert on these beasts.

Jonathna
