Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11B04765720
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 17:13:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233075AbjG0PNv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 11:13:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233398AbjG0PNu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 11:13:50 -0400
Received: from wp534.webpack.hosteurope.de (wp534.webpack.hosteurope.de [80.237.130.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 826D41BC1;
        Thu, 27 Jul 2023 08:13:47 -0700 (PDT)
Received: from [2001:a61:6209:7f40:c80a:ff:fe00:4098] (helo=cs-office3.lan.local); authenticated
        by wp534.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        id 1qP2gQ-0004bK-Mm; Thu, 27 Jul 2023 17:13:42 +0200
Date:   Thu, 27 Jul 2023 17:13:35 +0200
From:   Carsten =?UTF-8?B?U3BpZcOf?= <mail@carsten-spiess.de>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Jean Delvare <jdelvare@suse.com>, Jonathan Corbet <corbet@lwn.net>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        linux-hwmon@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH 1/2] hwmon: (isl28022) new driver for ISL28022 power
 monitor
Message-ID: <20230727171142.1bc6d405.mail@carsten-spiess.de>
In-Reply-To: <71c9d96f-d815-7cf4-927b-76af44fdd3e0@roeck-us.net>
References: <20230726152235.249569-1-mail@carsten-spiess.de>
        <20230726152235.249569-2-mail@carsten-spiess.de>
        <206ad774-bf6f-aed3-81a7-3d9c8f80a69e@roeck-us.net>
        <20230727093536.4cd2f84f.mail@carsten-spiess.de>
        <71c9d96f-d815-7cf4-927b-76af44fdd3e0@roeck-us.net>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/I=Dv+p=GE8C9tqfWtQjORl_";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-bounce-key: webpack.hosteurope.de;mail@carsten-spiess.de;1690470827;0a1c032e;
X-HE-SMSGID: 1qP2gQ-0004bK-Mm
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/I=Dv+p=GE8C9tqfWtQjORl_
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable


On 7/27/23 16:30, Gueter Roeck wrote: =20
> >> On 7/26/23 08:22, Carsten Spie=C3=9F wrote: =20
> >> At _compile-time_ ? =20
> > How to explain better that it isn't set at runtime?
> I would suggest "can be set with device properties".
Yeah, i like that.

> >> I'd argue that shunt voltage is all but useless, but if you want to ha=
ve it supported
> >> it _has_ to be in mV. =20
> > That's a problem.
> >=20
> > In my case the ER-6P has a 8 milli Ohm (or 8000 micro Ohm) shunt and a =
powersupply with
> > max. 2.5 A. This gives a max shunt voltage of 20 mV at 2.5 A.
> > The device normaly consumes between 200 and 500 mA. (typ ~250 mA).
> > This results in shunt voltage of 1.6 to 4.0 mV (typ ~2mV).
> > Having no fractions will make it useless.
> >=20
> > Unfortunately there is no possibility to give a scaling factor.
> > Or returning float values (i know, this can't and shouldn't be changed)
> >  =20
>=20
> Just like the ABI must not be changed. The sensors command would display =
your
> 4mV shunt voltage as 4V, which is just as useless.
>=20
> In practice, the shunt voltage _is_ useless for hardware monitoring purpo=
se
> because it can be calculated from current and shunt resistor value.
> I'd say if you really want it, provide it as debugfs attribute. As hwmon
> attribute it has to be in mV.
O.k. will move to debugfs.

> >> I don't think the sign extensions are correct based on the datasheet.
> >> This will have to use sign_extend. =20
> >  From my understading (see table 11 on page 16 of the ISL28022 datashee=
t)
> > shunt value is already sign extended, (D15-D12 is sign)
> > bus value (table 12 on page 16) is unsigned.
> >  =20
>=20
> Not really. For the shunt voltage, 0xf000 has different meanings dependin=
g on scale
> and range settings.=20
Sorry, i don't agree, 0xf000 is -40.96 mV on all scale settings.

> LSB for bus voltage is 4 mV and starts at bit 2 or 3 depending
> on BRNG. The above just happens to be correct if BRNG =3D 10 OR 11 per da=
tasheet.
> If that is intentional, it needs to get a comment.
Yes, will add comment.

> >> Getting an error message each time the "sensors" command is executed ?
> >> Unacceptable. =20
> > o.k., will change to set *val =3D 0;
> >  =20
> Still unacceptable.
O.k. i will limit shunt-resistor-milli-ohms to a minimal value > 0 and drop=
 check here.

> >>> +	if (!dev || !data)
> >>> +		return -EINVAL; =20
> >>
> >> How would this ever happen ? =20
> > Shouldn't, but i'm carefully (i had it once during development due to a=
n error
> > (using dev instead of hwmon_dev) on calling this function
> >    =20
>=20
> Parameter checks are only acceptable on API functions. This is not an API=
 function.
> Local functions are expected to be consistent. If this function is called=
 with
> a bad argument, that needs to be fixed during development.
O.k., removed.

> >>> +static struct i2c_driver isl28022_driver =3D {
> >>> +	.class		=3D I2C_CLASS_HWMON,
> >>> +	.driver =3D {
> >>> +		.name	=3D "isl28022",
> >>> +		.of_match_table =3D of_match_ptr(isl28022_of_match), =20
> >>
> >> Drop of_match_ptr() =20
> > Most drivers have this, why drop?
> >  =20
>=20
> It is needed for device_property_read_u32() to work.=20
O.k. dropped, i wasn't familiar with device_property_read functions.

Regards Carsten


--Sig_/I=Dv+p=GE8C9tqfWtQjORl_
Content-Type: application/pgp-signature
Content-Description: Digitale Signatur von OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEWM+MlUpz/bWsZllTM1JQzV9LKSwFAmTCiZ8ACgkQM1JQzV9L
KSyuqA//R41dVcZLcRdU8mRrw4Eu5pCtHfFMQg699xnkDMDXCnce6lRQdmNl1PiA
aauLeSiocC290CoTFKuHbFscAnmgKNI0lFqWp10gMp4bodpgwvLvpQ7g0JNXvUzb
1voZ1vdHz+9+vqo90BbFyWEGMOA+VKli9zajvbP7/1BtdaKu+rujMXUEXVIAQ798
Qx29bEhfUc8bS+D6XA7XY5gocm0Z0rgzTH6TWqBEmv+ioKWjAc7AXsnuymTGr7ka
yV8//MGBuZut8STTLfkekGMDO2RKaSkIa/H8ifzjqnnuO2ZPIVP9SPzze6TwotEK
vO7jN3Krl8yQetLoGHivZ4SHOFk91lLgqDHZuSsIic1c2o+CeXT0SpEc9fQweTdc
iVNb8ukuYLhPEE4JcQ3bUwphHseymMllmPuofwWFk2ZQZcs0Xz1rcNFmlNMeY2Xg
jTA+0lrE4f7FcjdSJJYG6AwtrYcG+WJcEONrqQrFizLj3r5Amrba6rMphqVmY4bX
7WmcWk436EZfzN3NyGwePYvPcU2W/hwI662Ries+jAvXu1qXNtsn3KonyohnDjFW
f3qzuLdexqXhLOD9E8HHJ2SVF9I48B+bkT5dNRAxFrgcGuRtU+VEUTwt2u3lk9Aq
0kpZXxXxXhPRy+cKpt3BR1cwf7Oa2FOND1oC/pl7usVeIdqIBQc=
=7d8W
-----END PGP SIGNATURE-----

--Sig_/I=Dv+p=GE8C9tqfWtQjORl_--
