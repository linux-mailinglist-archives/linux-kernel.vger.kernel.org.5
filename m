Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69CFD7CA023
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 09:12:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231904AbjJPHMC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 03:12:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231679AbjJPHLz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 03:11:55 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEF24D9
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 00:11:51 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qsHlV-0000n2-Mj; Mon, 16 Oct 2023 09:11:49 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qsHlV-0021r9-0P; Mon, 16 Oct 2023 09:11:49 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qsHlU-00GxgF-Nc; Mon, 16 Oct 2023 09:11:48 +0200
Date:   Mon, 16 Oct 2023 09:11:44 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the rtc tree
Message-ID: <20231016071144.7nklsco5tszvgotw@pengutronix.de>
References: <20231016151522.06839671@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="rvsjrlvlvktkge5m"
Content-Disposition: inline
In-Reply-To: <20231016151522.06839671@canb.auug.org.au>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--rvsjrlvlvktkge5m
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Mon, Oct 16, 2023 at 03:15:22PM +1100, Stephen Rothwell wrote:
> After merging the rtc tree, today's linux-next build (powerpc
> allyesconfig) failed like this:
>=20
> drivers/rtc/rtc-at91rm9200.c:561:13: error: 'at91_rtc_remove' defined but=
 not used [-Werror=3Dunused-function]
>   561 | static void at91_rtc_remove(struct platform_device *pdev)
>       |             ^~~~~~~~~~~~~~~
> cc1: all warnings being treated as errors
>=20
> Caused by commit
>=20
>   48bc8830fbed ("rtc: at91rm9200: Convert to platform remove callback ret=
urning void")

Ah, yes, sorry I missed that. That's what my coccinelle patch does (for
reasons unknown to me). For some other patches I noticed that, but this
one slipped through.

> This function lost its __exit attribute (which includes a "used"
> attribute) and exit_p(x) is NULL when not being built with
> CONFIG_MODULE set.  This build has CONFIG_RTC_DRV_AT91RM9200=3Dy

The better fix is to add the __exit again and I see that's what
Alexandre did in his rtc-next already.

Thanks for cleaning up after me,
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--rvsjrlvlvktkge5m
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmUs4i8ACgkQj4D7WH0S
/k7hXwgArrKoKYfLJLvcl5mj5813lgHjY9Fy00tjhBTZ2Hj2bHx/8rAcECwg0cj1
R1FkqOgRC5NEfP6ubCt1a+1WmPYzJ20NiP2M2wWkpuXrR/6gHCb6Djs3xzQbC+Sb
n6s0Ij1iqylbCmoAtyNLNPbHs2igbXpmPItvdUTq0K22AF4oAnAifojTCC4bu/tr
3jsUORj4zWb4cZ1/Nr85yUgHZlzQ1BOWbrQ1bJATuHGG4LrtMQt5u/BIH0I8Ue5i
hv/FCPNxRLVbcTXwMIhZ35I7Qs2vzRo5qRZAm8SvRWCaIj0AnogAecOS0pl1zOZq
E8LKa/Zzbt0aWoMugAn2kZ7ygtgBrA==
=e5GS
-----END PGP SIGNATURE-----

--rvsjrlvlvktkge5m--
