Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF45C7D7AC3
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 04:15:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233277AbjJZCO5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 22:14:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233234AbjJZCOz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 22:14:55 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D894E182;
        Wed, 25 Oct 2023 19:14:52 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 507DCC433C7;
        Thu, 26 Oct 2023 02:14:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698286492;
        bh=VGgZNNS7fHtbqz8CRTWPgTTKJeFUiRdmqcuKa6hTt5U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=miU8iqfkGi5g7YPrXEckQoud5odDSNajd62xrb9iaZzAQOeud/gSGJtoxwxtAWfo9
         hD7ukyX4dTZ3SxCR8uusCETYxypQujLM1IR7AHMcEcrcRjZV/HBWSvgVq+MzCK9UCW
         80gwIo6JPTtsYxvanuy/owck6TpQ5L08CJQGWNkpxXydeYqctL2U3lkWyC8MccnjmW
         X0r/zo+QE/3KCcwC0KFrp6D85wdhob6fAiibnYCqoEwcOkniJOIuCtfLF0DZIbkvTY
         XjGWKITAX7iunBMKRtPDvbggB8wXrkix3JYqNKLAU/lKiUi4cx7jbF5xkaw0O/HOTV
         vtgxew55mpN1w==
Received: by mercury (Postfix, from userid 1000)
        id 450F4106057B; Thu, 26 Oct 2023 04:14:49 +0200 (CEST)
Date:   Thu, 26 Oct 2023 04:14:49 +0200
From:   Sebastian Reichel <sre@kernel.org>
To:     Jacopo Mondi <jacopo.mondi@ideasonboard.com>
Cc:     Sakari Ailus <sakari.ailus@linux.intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/4] media: i2c: gc0308: new driver
Message-ID: <20231026021449.xrslmujpmp3upbhv@mercury.elektranox.org>
References: <20231024010355.1877523-1-sre@kernel.org>
 <20231024010355.1877523-5-sre@kernel.org>
 <o4t2ys2n7p7seunbd4v6nlpbeejewtutuytt4aastyild6otor@l56xftgefgiv>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="jinfwhzlrj5poqdh"
Content-Disposition: inline
In-Reply-To: <o4t2ys2n7p7seunbd4v6nlpbeejewtutuytt4aastyild6otor@l56xftgefgiv>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--jinfwhzlrj5poqdh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Jacopo,

Thanks for the quick review, much appreciated!

On Tue, Oct 24, 2023 at 10:38:45AM +0200, Jacopo Mondi wrote:
> On Tue, Oct 24, 2023 at 02:59:53AM +0200, Sebastian Reichel wrote:
> > Introduce new driver for GalaxyCore GC0308, which is a cheap
> > 640x480 with an on-chip ISP sensor sold since 2010. Data is
> > provided via parallel bus.
> >
> > Signed-off-by: Sebastian Reichel <sre@kernel.org>
> > ---

=2E..

> Annoying questions, is this driver compatible with the newly
> introduced CCI helpers? Not that pressing as you're on regmap
> so you haven't your own read/write routines.

I cannot use devm_cci_regmap_init_i2c(), because I use regmap's
pagination feature. So instead of doing something like this:

{REG_PAGE_SELECT, 0x00},
{CCI_REG8(0x00), 0x23},
{CCI_REG8(0x01), 0x42},
{REG_PAGE_SELECT, 0x01},
{CCI_REG8(0x00), 0x13},
{CCI_REG8(0x01), 0x37},

I can do

{CCI_REG8(0x000), 0x23},
{CCI_REG8(0x001), 0x42},
{CCI_REG8(0x100), 0x13},
{CCI_REG8(0x101), 0x37},

That said, I updated the driver to use the CCI helpers instead of
directly using regmap with the exception of the initialization.

[...]

> > +	gpiod_set_value_cansleep(gc0308->reset_gpio, 1);
> > +	msleep(100);
> > +	gpiod_set_value_cansleep(gc0308->reset_gpio, 0);
> > +	msleep(100);
>=20
> Wow! that's long :)

I shortened them a bit. These were just the initial values I put
there. Unfortunately the timings are not described in the datasheet.
I now use values I found in some downstream drivers (10-20ms and
30ms).

[...]

> > +static int gc0308_set_exposure(struct gc0308 *gc0308, enum gc0308_exp_=
val exp)
> > +{
> > +	const struct gc0308_exposure *regs =3D &gc0308_exposure_values[exp];
> > +	struct reg_sequence exposure_reg_seq[] =3D {
> > +		REG_SEQ0(GC0308_LUMA_OFFSET, regs->luma_offset),
> > +		REG_SEQ0(GC0308_AEC_TARGET_Y, regs->aec_target_y),
> > +	};
> > +
> > +	dev_err(gc0308->dev, "exposure: %i\n", exp);
>=20
> maybe dev_dbg ?

oops. That should just go away. I had some issues when switching
=66rom V4L2_CID_EXPOSURE to V4L2_CID_AUTO_EXPOSURE_BIAS after the
feedback from Sakari and forgot to remove this "debug" print.

[...]

> > +static int gc0308_s_ctrl(struct v4l2_ctrl *ctrl)
> > +{
> > +	struct gc0308 *gc0308 =3D container_of(ctrl->handler, struct gc0308, =
hdl);
> > +	int ret;
> > +
> > +	ret =3D pm_runtime_resume_and_get(gc0308->dev);
>=20
> Sensor drivers are usually not resumed in the s_ctrl call path, but
> usually the current power state is checked and the function returns
> early if the device is not powered
>=20
>         if (!pm_runtime_get_if_in_use(&client->dev))
>                 return 0;
>=20
> Then in the the s_stream() call path, after the sensor has been
> resumed, the controls are applied by calling
>=20
>         __v4l2_ctrl_handler_setup()
>=20
> as you aready do!

Right and the value is trashed by the following poweroff anyways.

[...]

> > +	if (gc0308->clk) {
> > +		clkrate =3D clk_get_rate(gc0308->clk);
> > +		if (clkrate !=3D 24000000)
> > +			dev_warn(dev, "unexpected clock rate: %lu\n", clkrate);
>=20
> Should the driver continue to operate if the frequency is not
> supported ?

That's what Sakari suggested. I guess a clock rate of 23.9 MHz
would be fine, but different from 24MHz. Unfortunately the
datasheet does not describe the allowed clock rates. It just says,
that the max framerate is 30FPS at 24MHz. So I think a non-fatal
warning is the right thing to do.

[...]

I fixed the other things and plan to send a new series soon. Just
need to do some more testing.

Greetings,

-- Sebastian

--jinfwhzlrj5poqdh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmU5y44ACgkQ2O7X88g7
+ppfcg/+OFA6zujXF1FT+Uvk0tNfOCMRlQ8m8iEMueTb0FzHAUsX4NpH6iilny0y
co8Nfk0PjhkTvytn5W2B9S/q/6UoTobIA0f5sBz2HPdlYlpUX/5Ir+PZXCHB4Abt
9dBNfhiGGs8sR/EBMPVDFIN3Sc13/EV8uAhe4UZfe+FOQqNCeyd1zCe1G7vdU4eX
YTDVpOo2zsrgddQN/cXPbnDFx4vHfxsnZLHU6i4Uuiw8GmbfO30nS/cgjORJq2Ht
NxlIdJ7QydKFnrdBRI4rQgmTWEk48O3L1GKMMbE19weivev/FCHOVnSOkEr3CfMC
kfl7ydZAGrxmyIjbrKucRH30vlHOjEktFHPku9mEn2K9uQWEiBmZQqkGnudkHF3r
nCoVh9i1ZM3bp+vjB0R/MUs9PWMAgHDPMcLdrHNTN8rYxWkzw7lq9CQW6OCyQm++
5FZjPjpcoJogYZgXe4+VcXbKFT9r0zR4px0izf9p42SG/H9FUEN7sdor3Pxx1cyJ
TL2mDiLCUWLtK/CKR22NXbSgHK/WzISIaSNQVKuenyidz8F1+uG7FoQ1H0lH40oA
au3DJb+hSRRHW6HnvCDflrWzumMvwoXieHPcAPKKSUbj9gU9qZN2Bow3xqMxBbzg
YDdr7gMVsYHQwb4Yg2T6XpTOUT53tttv7HFgRvHp3zuOKYOmVus=
=Pv6L
-----END PGP SIGNATURE-----

--jinfwhzlrj5poqdh--
