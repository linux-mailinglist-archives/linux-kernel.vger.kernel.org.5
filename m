Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F5267A3367
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Sep 2023 01:54:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232626AbjIPXyA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Sep 2023 19:54:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbjIPXxn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Sep 2023 19:53:43 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D72BCCB;
        Sat, 16 Sep 2023 16:53:38 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63C56C433C7;
        Sat, 16 Sep 2023 23:53:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694908417;
        bh=RTInmr2VDsrtyWUxWPbJVqYnWovBm1DvGkVnIXVR5q0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hoIJUTDKJ4LkWCYO2BPWD25CtXN+avIUT6M5wCT14v6r+Aysf7MQyVMH+1FIHJw9E
         LbY5zWL7498yCY0exeXYi0te8W8ixWEq4kKGggWaVGYKVySSXxxFEYujSqCJAoj7x6
         15CUKB8B4dtfKaB0iScqfPAHyV8T7soNW8n0UAenirfV26heojp/5rQvqq3o9xjPqw
         V1326XgrpFietglIhkHAOPhep5YYip9uqpHuWyfc/q0UuBVXAyKTPYiYP219jKWIC2
         5GnEYz0Qen5qAon0sVLbJDRMshsia1MOwQZFvHDoRcw48EWptPfFQAj7imunlVwEHl
         iY5NOu0kHjMHg==
Received: by mercury (Postfix, from userid 1000)
        id 5AB3110604B2; Sun, 17 Sep 2023 01:53:34 +0200 (CEST)
Date:   Sun, 17 Sep 2023 01:53:34 +0200
From:   Sebastian Reichel <sre@kernel.org>
To:     Stefan Moring <stefan.moring@technolution.nl>
Cc:     broonie@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, linux-spi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] spi: Increase imx51 ecspi burst length based on transfer
 length
Message-ID: <20230916235334.fqqpowhvacg3xzqy@mercury.elektranox.org>
References: <20230628125406.237949-1-stefan.moring@technolution.nl>
 <20230914224749.kmg4xqsg3wmfwwhj@mercury.elektranox.org>
 <CAB3BuKAEFewb6W5K=Z2ZX9Xx0gA+RW+XKY-Mkn-PfBOfq3eb+A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="cvhbzmwpf7ya2bo6"
Content-Disposition: inline
In-Reply-To: <CAB3BuKAEFewb6W5K=Z2ZX9Xx0gA+RW+XKY-Mkn-PfBOfq3eb+A@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--cvhbzmwpf7ya2bo6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

On Fri, Sep 15, 2023 at 07:55:23AM +0200, Stefan Moring wrote:
> Op vr 15 sep 2023 om 00:47 schreef Sebastian Reichel <sre@kernel.org>:
> > On Wed, Jun 28, 2023 at 02:54:06PM +0200, Stefan Moring wrote:
> > > IMX51 supports 4096 bit burst lengths. Using the spi transfer length
> > > instead of bits_per_word increases performance significantly.
> > >
> > > Signed-off-by: Stefan Moring <stefan.moring@technolution.nl>
> > > ---
> >
> > I have an i.MX6ULL system with "inanbo,t28cp45tn89-v17" panel, which
> > breaks due to this change. Reverting this patch results in working
> > panel. Note, that the panel driver [0] does 'spi->bits_per_word = 9;'.
> >
> > [0] drivers/gpu/drm/panel/panel-sitronix-st7789v.c
>
> Would changing line 665 to ctrl |= (spi_imx->count * spi_imx->bits_per_word
> - 1) fix the issue?

--- a/drivers/spi/spi-imx.c
+++ b/drivers/spi/spi-imx.c
@@ -662,7 +662,7 @@ static int mx51_ecspi_prepare_transfer(struct spi_imx_data *spi_imx,
                if (spi_imx->count >= 512)
                        ctrl |= 0xFFF << MX51_ECSPI_CTRL_BL_OFFSET;
                else
-                       ctrl |= (spi_imx->count*8 - 1)
+                       ctrl |= (spi_imx->count*spi_imx->bits_per_word - 1)
                                << MX51_ECSPI_CTRL_BL_OFFSET;
        }

on top of 6.6-rc1 fixes the problem. Will you send a proper patch with

Reported-by: Sebastian Reichel <sre@kernel.org>
Fixes: 15a6af94a277 ("spi: Increase imx51 ecspi burst length based on transfer length")

or should I do it?

Greetings,

-- Sebastian

--cvhbzmwpf7ya2bo6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmUGP/oACgkQ2O7X88g7
+poUKw//bjUN7DAL2U1d2TrCZ6bEJWiI/SCh1KIO/U+qitP7CaKWA2wzZ5vV+Ygk
uVZx25+tE8jg2ajlDw9hB1jLOhQ0jp/r3ah+F3FjpedhQwbWPIJEuHbG5o4+h75V
5QN2dIiGdb0D2Oq94710SND4bjCuFozc/pnYqAQYy4rjdswGnfLeFd8dBmFeXhmM
x+D/NwDfm65USd8VtEykpvKelaiETF+LEwzCuR2oKjgz3TefabKH351t2KEetwJL
nYgYT2eoF2AcRtDn+ngUAlXIRmY41cmd6KqH8DPa4MIwIsVP0JvawkGHv+R7KNxJ
/u589F8dYsT8w1aPMKJATFsKY4mr2Oct/pwfs88ARvWQu78mgddyOUyety6TeGP3
/GOE92xsN1MQ25wn52p+DfwWScYqnyg6Knj16fnH3cSIN+HEk42U3llU6f3o1WDq
iLhwMKUeCQSErRSs+M2cxvxRexFbv7kcU52oiEqJBTDavGelZrkq01Z0cO29r0/L
bn+Dd79+7Xx+bTJ83pXC57J+Pp53q76nIAVkoV0V5Fj0e1GzZw61Xl5Kg4Zeoe2q
ALs4Y8v29/BSh9ScJsjpZGJdmhIPoqnJYZ7uFajyPPjrY5XMpiqd/j3zhjmYJGX7
SsXs607gYqBVTXB9MMV6GLwzWQywZHpBc4cGi6iolfNkmps+RWs=
=s2Bq
-----END PGP SIGNATURE-----

--cvhbzmwpf7ya2bo6--
