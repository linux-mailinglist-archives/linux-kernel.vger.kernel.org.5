Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57CD47D9DA3
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 17:57:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346324AbjJ0P5e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 11:57:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346224AbjJ0P5c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 11:57:32 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCB9BC2;
        Fri, 27 Oct 2023 08:57:30 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0832C433CC;
        Fri, 27 Oct 2023 15:52:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698422250;
        bh=2VEXUfZq28YwhfCf5i2RKnmGeFMDvO3FRd+c1Xc3/KY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CSljUt7KvLJVMpVWCMMJNdEH/6ExmMvBO0nPYvyIADRfSkoJ/dr0Wxit9uzkFNvSN
         cU/S+cnxnnXItIpS0COk+7cLRZc7uhEkXt0coKb1akiS6oomdc8U/OPbeJ3TNBNoBw
         mt4yVbVFvyJsXBAI8quEqmToH85+y+tCJk/F/lo8jSArlQ9/6Gp+vKJTuUTG74IRNt
         584Jh4RC8W9v81WwrUIpjZbSLjHQyNHf5kg+BVPXyM0EAwPWZrHSYoFc8Fa8INVW+i
         2xnZ4wmEgCMspLF+CoIUMxnYmBcdQGYuOJkFzB4JZW6uC2Oj68qCHcCLGHKbBLarTK
         40uMACI63G6Mg==
Date:   Fri, 27 Oct 2023 16:52:47 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Eberhard Stoll <estl@gmx.net>
Cc:     linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        Eberhard Stoll <eberhard.stoll@kontron.de>,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        Amit Kumar Mahapatra <amit.kumar-mahapatra@amd.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Krishna Yarlagadda <kyarlagadda@nvidia.com>,
        Leonard =?iso-8859-1?Q?G=F6hrs?= <l.goehrs@pengutronix.de>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Yang Yingliang <yangyingliang@huawei.com>
Subject: Re: [PATCH 1/4] spi: Add parameter for clock to rx delay
Message-ID: <ZTvczyPdxKPd+lUG@finisterre.sirena.org.uk>
References: <20231026152316.2729575-1-estl@gmx.net>
 <20231026152316.2729575-2-estl@gmx.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ljgY697SsovoKivq"
Content-Disposition: inline
In-Reply-To: <20231026152316.2729575-2-estl@gmx.net>
X-Cookie: Save energy:  Drive a smaller shell.
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ljgY697SsovoKivq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 26, 2023 at 05:23:02PM +0200, Eberhard Stoll wrote:
> From: Eberhard Stoll <eberhard.stoll@kontron.de>
>=20
> For spi devices the master clock output defines the sampling point
> for receive data input stream (rising or falling edge). The receive
> data stream from the device is delayed in relation to the master
> clock output.
>=20
> For some devices this delay is larger than one half clock period,
> which is normally the sampling point for receive data. In this case
> receive data is sampled too early and the device fails to operate.
> In consequence the spi clock has to be reduced to match the delay
> characteristics and this reduces performance and is therefore not
> recommended.
>=20
> Some spi controllers implement a 'clock to receive data delay'
> compensation which shifts the receive sampling point. So we need
> a property to set this value for each spi device.
>=20
> Add a parameter 'rx_sample_delay_ns' to enable setting the clock
> to rx data delay for each spi device separately.
>=20
> The 'clock to receive data delay' value is often referenced as tCLQV
> in spi device data sheets.

This makes sense to me.  We should probably also have core support which
will constrain the clock rate such that we satisfy the timing constraint
if the controller can't control this, that'd need a flag to let the core
know that the controller has that ability.  Could you send an
incremental patch doing that please?

--ljgY697SsovoKivq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmU73MkACgkQJNaLcl1U
h9CQEQf/dgKaDEUMM1iRZLI8cCxOmlgUFhrVvjIUcQ5uMUs5rA3snQMzh5J9YhJn
VvSDSuBc5psnf9b734ehNsOhWg4UJqANJkIyS4V1FYXddnxSY6H5nx93SRNtjhVX
NpBfctnh7As4A9+CNefiK5hs/rrVoLep4vcRaSHYJnDk0Oah2a+AhVYUcTCD29YJ
t0P8Q1BaQCi+LPhNzuvE+LHoxs4ofivz/CrAlMu0UD0OlLfFgTvVDatY1C8qS6o/
hlaSRodA3MC7aaQyg67cZS5gSOK5pVsVqc99BCr7cupmUd9/GOyFNURq114IkCPb
/u8MOeOSG+LBI/upsd64Dtk7IN7CzA==
=bAL4
-----END PGP SIGNATURE-----

--ljgY697SsovoKivq--
