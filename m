Return-Path: <linux-kernel+bounces-143155-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27E428A351F
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 19:48:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6BD36B222BB
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 17:48:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C95114D71E;
	Fri, 12 Apr 2024 17:47:54 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ED6E14D457
	for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 17:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712944073; cv=none; b=Uyyq1T43AizdIJWfhk3yYYKlDfU5o/3vUpfa1RO2T280T4fYhLiLKh1T7uZC6f95sqDhKfUm5LlKBEDJO3iPZG4rpEWHOM70ECditCLc3+VQHs34DyT4peFXNfG3YCQcFhu76dvUuSkCutZ7Zd2UlijpkImVcXdbdKt9XpKZt2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712944073; c=relaxed/simple;
	bh=u7p7QBhAFqRmVebBU1A0EatPOywe3DXSvpCZCThiQp4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rA0D8TQAISGOxu/Dg9DHK/S4hLMmpceS6E6fw0tWb+fSJLnMQlZzeV+B0oEv3yunP0X9atcR1FFFwP9PSDts8wo10lxyRzEFFst7mxdDaF353VuxtqMdmvr7Xo4lSH/ESeo5ngfAfVz7I6tJSf05b1qp4gpVugWlPaF5xyvNRKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rvL04-0002tY-Ns; Fri, 12 Apr 2024 19:47:44 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rvL03-00BuyP-GY; Fri, 12 Apr 2024 19:47:43 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rvL03-000JKn-1O;
	Fri, 12 Apr 2024 19:47:43 +0200
Date: Fri, 12 Apr 2024 19:47:43 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Raag Jadav <raag.jadav@intel.com>, linux-kernel@vger.kernel.org, kernel@pengutronix.de, 
	"Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH] driver core: Make dev_err_probe() silent for -ENOMEM
Message-ID: <zjk3vnydp2yip343khmkq7v5vqbib6d6eyee6tx6h5nph4blzn@c26yrw2cqrt7>
References: <20240412164405.335657-2-u.kleine-koenig@pengutronix.de>
 <ZhlmpPNbEMRye2wZ@smile.fi.intel.com>
 <cl5fmton3n5ayzr7ondnw7lzjaxoppyqhnoervj2fn4et75ish@cyko4abxbslg>
 <ZhlqUdywIur4dzgE@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="4upext5dqz6toh4x"
Content-Disposition: inline
In-Reply-To: <ZhlqUdywIur4dzgE@smile.fi.intel.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org


--4upext5dqz6toh4x
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Fri, Apr 12, 2024 at 08:07:29PM +0300, Andy Shevchenko wrote:
> On Fri, Apr 12, 2024 at 07:03:01PM +0200, Uwe Kleine-K=F6nig wrote:
> > On Fri, Apr 12, 2024 at 07:51:48PM +0300, Andy Shevchenko wrote:
> > > On Fri, Apr 12, 2024 at 06:44:05PM +0200, Uwe Kleine-K=F6nig wrote:
> > > > For an out-of-memory error there should be no additional output. Ad=
apt
> > > > dev_err_probe() to not emit the error message when err is -ENOMEM.
> > > > This simplifies handling errors that might among others be -ENOMEM.
>=20
> > > ...
> > >=20
> > > 	BUILD_BUG_ON(err =3D=3D -ENOMEM);
> > >=20
> > > Done!
> >=20
> > Well no, that doesn't do the trick. Consider for example device_add().
> > That function can return (at least) -EINVAL and -ENOMEM. To properly
> > ensure that the error handling is silent with the current
> > dev_err_probe(), we'd need to do:
> >=20
> > 	ret =3D device_add(...);
> > 	if (ret) {
> > 		if (ret !=3D -ENOMEM)
> > 			return dev_err_probe(...);
> > 		else
> > 			return ret;
> > 	}
> >=20
> > With my suggested patch this can be reduced to:
> >=20
> > 	ret =3D device_add(...);
> > 	if (ret)
> > 		return dev_err_probe(...);
>=20
> Fair enough, but these two should be combined.
> Mine is for the rejecting a dead code on the phase of the submission.

So something like the following on top of my change (only compile
tested):

diff --git a/drivers/base/core.c b/drivers/base/core.c
index 0bc04dcf31d5..02b6ec9a26c1 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -5033,7 +5033,7 @@ define_dev_printk_level(_dev_info, KERN_INFO);
  *
  * Returns @err.
  */
-int dev_err_probe(const struct device *dev, int err, const char *fmt, ...)
+int __dev_err_probe(const struct device *dev, int err, const char *fmt, ..=
=2E)
 {
 	struct va_format vaf;
 	va_list args;
@@ -5064,7 +5064,7 @@ int dev_err_probe(const struct device *dev, int err, =
const char *fmt, ...)
=20
 	return err;
 }
-EXPORT_SYMBOL_GPL(dev_err_probe);
+EXPORT_SYMBOL_GPL(__dev_err_probe);
=20
 static inline bool fwnode_is_primary(struct fwnode_handle *fwnode)
 {
diff --git a/include/linux/dev_printk.h b/include/linux/dev_printk.h
index 6bfe70decc9f..a7573355ff90 100644
--- a/include/linux/dev_printk.h
+++ b/include/linux/dev_printk.h
@@ -14,6 +14,7 @@
 #include <linux/compiler.h>
 #include <linux/types.h>
 #include <linux/ratelimit.h>
+#include <linux/build_bug.h>
=20
 #ifndef dev_fmt
 #define dev_fmt(fmt) fmt
@@ -274,6 +275,7 @@ do {									\
 	WARN_ONCE(condition, "%s %s: " format, \
 			dev_driver_string(dev), dev_name(dev), ## arg)
=20
-__printf(3, 4) int dev_err_probe(const struct device *dev, int err, const =
char *fmt, ...);
+__printf(3, 4) int __dev_err_probe(const struct device *dev, int err, cons=
t char *fmt, ...);
+#define dev_err_probe(dev, err, ...) ( { BUILD_BUG_ON(__builtin_constant_p=
(err) && err =3D=3D -ENOMEM); __dev_err_probe((dev), (err), __VA_ARGS__); })
=20
 #endif /* _DEVICE_PRINTK_H_ */


I don't know if the kernel doc for dev_err_probe() should move to
include/linux/dev_printk.h then?!

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--4upext5dqz6toh4x
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmYZc74ACgkQj4D7WH0S
/k4jFAf8DuxSDT/KI0qb/f2BNnc5OF4AxuYsgZCC6TV73LhgGNdSetubkHjt+Mw8
JmDmriGamkJgWboncr3uO2xP1ECa8/ECeJheUPYxCYvmoNbjOuCv/fdXngP5GmRO
rB5p+jE8Ydbzx8ZnL+KO9qw+kzpD5NET+4KT14UGTdjexqMTPCqsElP3OG4pSmkl
mCVKaRlAT1VUwZ7kkgNZIcapubC6xpUBcvqyHLOQFulCQDbgehQ5kH4hF0x+MeNH
TPYVIqL66I9UJWpu5m8CFnqxCXpgy//cec6Jaym/RbqMtn2ShbnGgiWwPFIioaq9
yKPlZKjOJ0sKoupOON8COchrko+4AA==
=1xIK
-----END PGP SIGNATURE-----

--4upext5dqz6toh4x--

