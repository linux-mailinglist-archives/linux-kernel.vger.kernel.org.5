Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4ECE576579D
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 17:29:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231665AbjG0P27 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 11:28:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229555AbjG0P25 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 11:28:57 -0400
Received: from wp534.webpack.hosteurope.de (wp534.webpack.hosteurope.de [80.237.130.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C77991BE4;
        Thu, 27 Jul 2023 08:28:55 -0700 (PDT)
Received: from [2001:a61:6209:7f40:c80a:ff:fe00:4098] (helo=cs-office3.lan.local); authenticated
        by wp534.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        id 1qP2v5-0008UE-9I; Thu, 27 Jul 2023 17:28:51 +0200
Date:   Thu, 27 Jul 2023 17:28:42 +0200
From:   Carsten =?UTF-8?B?U3BpZcOf?= <mail@carsten-spiess.de>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Jean Delvare <jdelvare@suse.com>, Jonathan Corbet <corbet@lwn.net>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        linux-hwmon@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH 1/2] hwmon: (isl28022) new driver for ISL28022 power
 monitor
Message-ID: <20230727172842.3fe20026.mail@carsten-spiess.de>
In-Reply-To: <bbf1aba4-48ce-289d-aaa9-bc861effaffd@roeck-us.net>
References: <20230726152235.249569-1-mail@carsten-spiess.de>
 <20230726152235.249569-2-mail@carsten-spiess.de>
 <bbf1aba4-48ce-289d-aaa9-bc861effaffd@roeck-us.net>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/VKN5LQy7FMPezGOzlhGiZtM";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-bounce-key: webpack.hosteurope.de;mail@carsten-spiess.de;1690471736;7dc0dfdb;
X-HE-SMSGID: 1qP2v5-0008UE-9I
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/VKN5LQy7FMPezGOzlhGiZtM
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable


> On 7/26/23 18:19, Guenter Roeck wrote:
> I strongly suspect that the conversions will result in overflows and that=
 they are not always correct.
> I'll want to write unit test code before accepting the driver.
I changed the conversion for current to=20
				*val =3D ((long)regval * 1250L * (long)data->gain) /
					(long)data->shunt;

The term (1250 * gain) will be 10000 max, fits to 14 bit.
So no risk for 32bit overflow when multiply with 16bit value.

And changed the conversion for power to=20
				*val =3D ((51200000L * ((long)data->gain)) /
					(long)data->shunt) * (long)regval;

The first term (51200000 * gain / shunt) will be larger than 16bit when=20
(shunt/gain) is less than ~800. So min values for shunt are=20
- 6400 =C2=B5Ohm for 320 mV range
- 3200 =C2=B5Ohm for 160 mV range
- 1600 =C2=B5Ohm for 80 mV range
- 800 =C2=B5Ohm for 40 mV range
Can i set this conditionally in the .yaml file?

Regards Carsten

--Sig_/VKN5LQy7FMPezGOzlhGiZtM
Content-Type: application/pgp-signature
Content-Description: Digitale Signatur von OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEWM+MlUpz/bWsZllTM1JQzV9LKSwFAmTCjSoACgkQM1JQzV9L
KSxNEQ//Zl3WGNjRRHcZX/AnLzHLLmhKq3QZw9OreJLcnES+G85wGIqyXVg6gFYx
1dSzoUgMJWN/DL8PyjR8AnJayQ0cLbQPqQF0xG/Ki7y2/CmvaQxc1Yy/vc9fDj0N
sFnuqjBTATNIiKpbGNG8WBBmWRZMD1v9AezG4YqHXxRyiAV+394BrAj4K5ectyxI
ZpQgYzGwXntGpf9LU3MyEvNaVyWK7SchOOXvBf8b60D2bUnLZft304UTKBoe6isw
7bI7nY5ENeZJK41l1mYK6LDyqJiuCL7QuMaRuQkTBr4EbXrsvUA+xxXDnQ+CfGID
yb3jAjfHyWUy9gajeBJGpsQqEjCGHlOnzb8n/6EdfXmrtLD+XShX3pj/Hm1Udkzr
PUl++5gnu23nLppwB8XaNh/ssyx1tFxs7Fs1oOdBVe59PRSJvf4YKBaFb6J5ZH6r
eQQj2owJy/vKPl1ASigwUVIVYg6bm/TlVZWdbMn2LXDZCWIOZjqZw2dS0SO7/sbm
8J2BewTiX9M4vqBM716CIj/7Z++iA9bTHPlhG1LI0Q+nbPEgez68mz2kgMGNxIFB
LVE7OzFac95rI7REi7rJadDi8DufWama2M1UycM1uUii1feDPYoJ5eCTPBq1AeuQ
EShQ0pHmiph0Pn2Po3ALEMSJbay4jgGEQDNhZclWC/gjRhDPVnE=
=QSkV
-----END PGP SIGNATURE-----

--Sig_/VKN5LQy7FMPezGOzlhGiZtM--
