Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52A2F7C66C5
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 09:56:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377791AbjJLHgA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 03:36:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232199AbjJLHf7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 03:35:59 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73EB290;
        Thu, 12 Oct 2023 00:35:57 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09031C433C8;
        Thu, 12 Oct 2023 07:35:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697096157;
        bh=vtUjYzbh3ksyEdtvSfgyPNGccq8OhGyaDiH5w29dMb4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=JxRguLzShyfjqtscKFYcmXK4uKSohmdngtg0iVJbqrgODN+jrrlJJ8h16r9weMO4Y
         UIfefhoNYPiDLQv91cs6cFFgYbEXyduuTkmrQ/MM4tY3NKdoeXHe58Dd3IB4Dx90oG
         FNCnVVi24NKh9+3N2YIrNY52llaOSpiyqq1wSSu36lHKuDfzoMu+PJodjRi63B4buw
         8qUCzocG0yZ717WL2r+3BXyabetdTsEmr80ngL37VcgdpXSnS8mlSXRfZpmm2F4P3P
         b2d1IWozt94EdWGjhcMrE/ESHiAsMttxtLaxgY4xIgiFybuKrRVRvF9eNog3iuFQ8/
         6dI7V9fCi3pMQ==
Date:   Thu, 12 Oct 2023 08:36:10 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     <Marius.Cristea@microchip.com>
Cc:     <lgirdwood@gmail.com>, <broonie@kernel.org>, <lars@metafoo.de>,
        <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1] iio: adc: MCP3564: fix warn: unsigned '__x' is never
 less than zero.
Message-ID: <20231012083610.742cc74c@jic23-huawei>
In-Reply-To: <bcc76066305e1c191ca02566132527b4c7520588.camel@microchip.com>
References: <20231002161618.36373-1-marius.cristea@microchip.com>
        <20231010104444.12e61984@jic23-huawei>
        <bcc76066305e1c191ca02566132527b4c7520588.camel@microchip.com>
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

On Wed, 11 Oct 2023 16:41:38 +0000
<Marius.Cristea@microchip.com> wrote:

>   Hi Jonathan,
>=20
>  Sorry, I think I've made a "mistake" related to naming the patches and
> also not running the Smatch checker at a point in time.
>=20
>=20
>=20
> On Tue, 2023-10-10 at 10:44 +0100, Jonathan Cameron wrote:
> > EXTERNAL EMAIL: Do not click links or open attachments unless you
> > know the content is safe
> >=20
> > On Mon, 2 Oct 2023 19:16:18 +0300
> > <marius.cristea@microchip.com> wrote:
> >  =20
> > > From: Marius Cristea <marius.cristea@microchip.com>
> > >=20
> > > The patch efea15e3c65d: "iio: adc: MCP3564: fix the static checker
> > > warning"
> > > leads to the following Smatch static checker warning:
> > >=20
> > > =C2=A0=C2=A0 smatch warnings:
> > > =C2=A0=C2=A0 drivers/iio/adc/mcp3564.c:1105 mcp3564_fill_scale_tbls()=
 warn:
> > > unsigned '__x' is never less than zero.
> > >=20
> > > vim +/__x +1105 drivers/iio/adc/mcp3564.c
> > >=20
> > > =C2=A0=C2=A0 1094
> > > =C2=A0=C2=A0 1095=C2=A0 static void mcp3564_fill_scale_tbls(struct mc=
p3564_state
> > > *adc)
> > > =C2=A0=C2=A0 1096=C2=A0 {
> > > =C2=A0=C2=A0 .....
> > > =C2=A0=C2=A0 1103=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 for (i =3D 0; i < MCP3564_MAX_PGA; i++) {
> > > =C2=A0=C2=A0 1104=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ref =3D adc->vref_mv; =
=20
> > > =C2=A0> 1105=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tmp1 =3D shift_right((u64)ref=
 * NANO, pow); =20
> > > =C2=A0=C2=A0 1106=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 div_u64_rem(tmp1, NANO,=
 &tmp0);
> > > =C2=A0=C2=A0 1107
> > > =C2=A0=C2=A0 .....
> > > =C2=A0=C2=A0 1113=C2=A0 }
> > >=20
> > > Reported-by: kernel test robot <lkp@intel.com>
> > > Closes:
> > > https://lore.kernel.org/oe-kbuild-all/202309280738.NWjVfVt4-lkp@intel=
.com/
> > > Fixes: efea15e3c65d (iio: adc: MCP3564: fix the static checker
> > > warning) =20
> >=20
> > This fix is fine but can you talk me through how the static checker
> > warning fix
> > in question has anything to do with this one?
> >=20
> > Was it just a case of fixing that issue allowing the static checker
> > to
> > get further before giving up?=C2=A0 In which case the description needs
> > modifying.
> >=20
> > Or am I missing something in the following fix?
> >=20
> > diff --git a/drivers/iio/adc/mcp3564.c b/drivers/iio/adc/mcp3564.c
> > index 64145f4ae55c..9ede1a5d5d7b 100644
> > --- a/drivers/iio/adc/mcp3564.c
> > +++ b/drivers/iio/adc/mcp3564.c
> > @@ -1422,11 +1422,8 @@ static int mcp3564_probe(struct spi_device
> > *spi)
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct mcp3564_state *adc;
> >=20
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 indio_dev =3D devm_iio_devic=
e_alloc(&spi->dev, sizeof(*adc));
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!indio_dev) {
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 dev_err_probe(&indio_dev->dev, PTR_ERR(indio_dev),
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 "Can't allocate iio device\n");
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!indio_dev)
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 return -ENOMEM;
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> >=20
> >  =20
>=20
>   I've got two bugs reported:
>=20
> - The first one was reported by Dan Carpenter "Re: [bug report] iio:
> adc: adding support for MCP3564 ADC". This bug was found using the
> "Smatch static checker warning" and it was related to:
> > --> 1426                 dev_err_probe(&indio_dev->dev, =20
> PTR_ERR(indio_dev),
>=20
> This bug was fixed by the above "[PATCH v1] iio: adc: MCP3564: fix the
> static checker warning" and it was applied on "Applied to the togreg
> branch of iio.git as that's where this driver is at the moment."
>=20
> Also my mistake at this point was that I didn't setup and run the
> "Smatch static checker warning"
>=20
>=20
> > as that's all I'm seeing in that commit.
> >  =20
> Yes, that commit only handled part of the fix.
>=20
>=20
>=20
> > > Signed-off-by: Marius Cristea <marius.cristea@microchip.com>
> > > ---
> > > =C2=A0drivers/iio/adc/mcp3564.c | 2 +-
> > > =C2=A01 file changed, 1 insertion(+), 1 deletion(-)
> > >=20
> > > diff --git a/drivers/iio/adc/mcp3564.c b/drivers/iio/adc/mcp3564.c
> > > index 9ede1a5d5d7b..e3f1de5fcc5a 100644
> > > --- a/drivers/iio/adc/mcp3564.c
> > > +++ b/drivers/iio/adc/mcp3564.c
> > > @@ -1102,7 +1102,7 @@ static void mcp3564_fill_scale_tbls(struct
> > > mcp3564_state *adc)
> > >=20
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 for (i =3D 0; i < MCP3564_MAX_PGA; i++=
) {
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 ref =3D adc->vref_mv;
> > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 tmp1 =3D shift_right((u64)ref * NANO, pow);
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 tmp1 =3D ((u64)ref * NANO) >> pow;
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 div_u64_rem(tmp1, NANO, &tmp0);
> > >=20
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 tmp1 =3D tmp1 * mcp3564_hwgain_frac[(2 * i) + 1];
> > >=20
> > > base-commit: 5e99f692d4e32e3250ab18d511894ca797407aec =20
> >  =20
>=20
> - The second bug was reported by "kernel test robot <lkp@intel.com>"
> also by running Smatch and it was run on the initial driver (without
> having the first patch applied)
>=20
> smatch warnings:
> drivers/iio/adc/mcp3564.c:1105 mcp3564_fill_scale_tbls() warn: unsigned
> '__x' is never less than zero.
> drivers/iio/adc/mcp3564.c:1426 mcp3564_probe() warn: passing zero to
> 'PTR_ERR'
> drivers/iio/adc/mcp3564.c:1426 mcp3564_probe() warn: address of NULL
> pointer 'indio_dev'
>=20
>=20
> The:"drivers/iio/adc/mcp3564.c:1426 mcp3564_probe() warn: passing zero
> to 'PTR_ERR'" and "drivers/iio/adc/mcp3564.c:1426 mcp3564_probe() warn:
> address of NULL pointer 'indio_dev'" were fixed by the first patch.
>=20
> The "drivers/iio/adc/mcp3564.c:1105 mcp3564_fill_scale_tbls() warn:
> unsigned '__x' is never less than zero." is fixed by the last patch
> "[PATCH v1] iio: adc: MCP3564: fix warn: unsigned '__x' is never less
> than zero."
>  by changeing:
>=20
> -		tmp1 =3D shift_right((u64)ref * NANO, pow);
> +		tmp1 =3D ((u64)ref * NANO) >> pow;
>=20
> shift_right function is "Required to safely shift negative values" but
> my value is always unsigned so it doesn't make sense to used it. This
> error was reported when I have run the Smatch over the driver + first
> patch (what was the latest from togreg).
>=20
> I have applied the patch on top of what was the "latest" from togreg
> branch and not on the initial driver.
>=20
>=20
> I could change the description or I could provide a patch to handle
> both warning reporting at once.
If there are multiple issues then should be multiple patches. So starting
point is definitely a version of this one with the correct description.

Thanks,

Jonathan

>=20
> Thanks,
> Marius

