Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED0F678AF01
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 13:40:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231825AbjH1Ljn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 07:39:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232192AbjH1LjW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 07:39:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78309C3;
        Mon, 28 Aug 2023 04:39:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1590562DA7;
        Mon, 28 Aug 2023 11:39:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB1F2C433C8;
        Mon, 28 Aug 2023 11:39:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693222758;
        bh=REqfrFFcxLpLdE+IoQ6n40p0EupqDAdWBBmE94CHEn4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=TY8q2BhtILyHw+VBhgM+VxmKA0IujiYKmBOd00E3FhsAIHIl3G/hqJIkGSHhjDRI/
         +WV8hGMI7q4p/O/t2FDQ+jCziyAvlHzBlMuLGnaxYlq5jHPH181UVi/IDFlJxoR33K
         /zoKPkhyPNKjVB/Tj6a1AoQ0Ss7NuDDDlfAyDbHagz7YLT3L+mbQACVbKBoFT6xn+B
         vadLBG8xh7Bl0ulsKKg5O9CE3EVgSrLUP2wFeCOJvqXggb5YbymduUBFv4bHA1bi/c
         1RmJ1BRE6+MmHOMkNbnZVMvVHYpeNf30/JXI+v7Tg3OQM3AspykJmFLyHzmwsA7840
         5hMVmv2trksqA==
Date:   Mon, 28 Aug 2023 12:39:37 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Angel Iglesias <ang.iglesiasg@gmail.com>
Cc:     Biju Das <biju.das.jz@bp.renesas.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Uwe =?UTF-8?B?S2xlaW5l?= =?UTF-8?B?LUvDtm5pZw==?= 
        <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH v2 2/3] iio: pressure: bmp280: Use i2c_get_match_data
Message-ID: <20230828123937.2bff2d92@jic23-huawei>
In-Reply-To: <a83bde5079b769950220c0f1f3b8d374db39cfc7.camel@gmail.com>
References: <cover.1691952005.git.ang.iglesiasg@gmail.com>
        <55f8dc02de16a353f0449bc1c7cb487bd776dfaf.1691952005.git.ang.iglesiasg@gmail.com>
        <954c859835aed6c41a356fdd999a8be51469eb9e.camel@gmail.com>
        <OS0PR01MB5922EDF7759069CD4993FA468617A@OS0PR01MB5922.jpnprd01.prod.outlook.com>
        <a83bde5079b769950220c0f1f3b8d374db39cfc7.camel@gmail.com>
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

On Mon, 14 Aug 2023 18:43:49 +0200
Angel Iglesias <ang.iglesiasg@gmail.com> wrote:

> On Mon, 2023-08-14 at 06:57 +0000, Biju Das wrote:
> > Hi Angel Iglesias,
> >=20
> >  =20
> > > Subject: Re: [PATCH v2 2/3] iio: pressure: bmp280: Use i2c_get_match_=
data
> > >=20
> > > On Sun, 2023-08-13 at 21:03 +0200, Angel Iglesias wrote: =20
> > > > Replaces device_get_match_data() and fallback match_id logic by new
> > > > unified helper function i2c_get_match_data().
> > > >=20
> > > > Signed-off-by: Angel Iglesias <ang.iglesiasg@gmail.com>
> > > >=20
> > > > diff --git a/drivers/iio/pressure/bmp280-i2c.c
> > > > b/drivers/iio/pressure/bmp280- i2c.c index 693eb1975fdc..34e3bc7584=
93
> > > > 100644
> > > > --- a/drivers/iio/pressure/bmp280-i2c.c
> > > > +++ b/drivers/iio/pressure/bmp280-i2c.c
> > > > @@ -11,9 +11,7 @@ static int bmp280_i2c_probe(struct i2c_client
> > > > *client)
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0const struct bmp280=
_chip_info *chip_info;
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct regmap *regm=
ap;
> > > >=20
> > > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0chip_info =3D device_get=
_match_data(&client->dev);
> > > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (!chip_info)
> > > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0chip_info =3D (const struct bmp280_chip_info *)
> > > > id->driver_data;
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0chip_info =3D i2c_get_ma=
tch_data(client);
> > > >=20
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0regmap =3D devm_reg=
map_init_i2c(client,
> > > > chip_info->regmap_config);
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (IS_ERR(regmap))=
 { =20
> > >=20
> > > Hi,
> > >=20
> > > I noticed I submitted this change that was also submitted by Biju Das=
 on
> > > another
> > > patch: =20
> >  =20
> > > Should I drop this patch from the series? =20
> >=20
> > I think it is ok. Andy is suggesting to use unified table for SPI/I2C
> >=20
> > Is it something do able and testable in your environment? see [1],
> > If yes, please create another patch for using unified table for both i2=
c and
> > spi. =20
>=20
> I have around a BMP390 with the SPI pins available to test it out. In the=
 case
> of the bmp280 we could unify the of_match table as they're almost the sam=
e. In
> the case of the spi_device_id and i2c_device_id tables, as they're differ=
ent
> structs I'm not sure if they can be unified.
>=20
> Regarding Andy's comment, I think he's referring to the duplicated chip i=
nfos.
> In the case of the bmp280, the chip_infos are defined on the common drive=
r code
> and used for both SPI and I2C match tables.
Hi,

I'm loosing track of where we are with this driver as multiple people are
working on it.

Angel, as most of the work is yours, please could you manage the flow of pa=
tches
for this one so I get series with clear statement of what they are dependen=
t on.

Thanks,

Jonathan

>=20
> >=20
> > https://lore.kernel.org/linux-renesas-soc/CAHp75VeX+T=3DhAN+PgtHTdv4b6U=
tDVgveUUww1b1kuOngzDinFw@mail.gmail.com/T/#t
> >=20
> > Cheers,
> > Biju =20
>=20
> Kind regards,
> Angel
>=20

