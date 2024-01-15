Return-Path: <linux-kernel+bounces-26086-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B822582DB46
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 15:27:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E0898282832
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 14:27:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DA3317753;
	Mon, 15 Jan 2024 14:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UMFj96r2"
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06AE4175AC;
	Mon, 15 Jan 2024 14:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2cceb5f0918so91975511fa.2;
        Mon, 15 Jan 2024 06:26:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705328798; x=1705933598; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5/Zs+aBmtESFoeZ7SNF5LX5i1bmnX6SQxNhbicALPwo=;
        b=UMFj96r2+oAnNbPqZF83zDwMuFLI0AzsKItQ6ZTaE2ytJZAWnY2uBKIJD7DlB30RFK
         7/tP0hPVE9kVK0SfKbfsziE7UKjr8aSFCZbXssbU03abx3k4Im/T+VH+MWVSvTj7YU7+
         7QiVmGfV9LBjYTHtwCjLYcQ6tfp7KYLiyaMLxzglWfRH5C46Na/ACluURnRsY6zPG9+N
         GU5+RfFKuEIY2a0p2F0OLvGlT4VyZKjEpJ1nLgnkW/o32YnShRJTgJ58kZGvucnQK2al
         9hQK4Id7mJ+X/GNQlVVa5aZ/x4TpL0EVxAErlWf/ErdUj2SrgE9OllSkDZqrEX3c2bhx
         qO5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705328798; x=1705933598;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5/Zs+aBmtESFoeZ7SNF5LX5i1bmnX6SQxNhbicALPwo=;
        b=NFcl9ID/rbgIQGG44Ql91UXXYj/jo1Gx++0x4cu/6j0FNNG18PC33uXNyDdIP7+x7C
         4zlWQ/6yrNVvKEL0mCX7pLESJyTj7RKJE/EALDrvMe9939f4lCTBp4gyxBs79UenwYqk
         USpM6p8nbQhLeOFuHLHPwC46bqqRPfMFz1YVUZjUlWBWKMdP2f/zg5Yex2kw72/DYbGe
         j5JQ0KIwIr3Q0wda84Xy99aA4kXHOY2mOd3dZVIVsXbPU4N5ZJfSCZkov36ORIadZ2ep
         /KoCLuL2xG4yVBfkHicIvA/pPSGBPkJAGReUX2Bxo4mbV/QTlglWaGcD7DyzUS+0hS+T
         waHw==
X-Gm-Message-State: AOJu0YzEbo4Dd8bbXHIb/7+9x77QuUqEb5CeRp0yqqAFhqVOpwOq7Sld
	o8Bn7yPz5gPu4k4w37dMrxU=
X-Google-Smtp-Source: AGHT+IEJwfh6lTX3JivmH+xIsnM5lMBSMyfQsWPJdNLtbYZpk9TagfGzkfw7AchuaFuvTqlKYKBYnw==
X-Received: by 2002:a2e:b050:0:b0:2cd:70e9:3327 with SMTP id d16-20020a2eb050000000b002cd70e93327mr1559461ljl.76.1705328797684;
        Mon, 15 Jan 2024 06:26:37 -0800 (PST)
Received: from fedora (mobile-access-567347-211.dhcp.inet.fi. [86.115.71.211])
        by smtp.gmail.com with ESMTPSA id c3-20020a2ea1c3000000b002ccdb771df0sm1344398ljm.108.2024.01.15.06.26.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jan 2024 06:26:37 -0800 (PST)
Date: Mon, 15 Jan 2024 16:26:33 +0200
From: Matti Vaittinen <mazziesaccount@gmail.com>
To: Matti Vaittinen <mazziesaccount@gmail.com>,
	Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
Subject: [PATCH v2 2/2] MAINTAINERS: add IIO GTS tests
Message-ID: <52c66fe2798192529738ac2ab98a27230a6ad8cd.1705328293.git.mazziesaccount@gmail.com>
References: <cover.1705328293.git.mazziesaccount@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="bYf1yi2hjMfPcMgh"
Content-Disposition: inline
In-Reply-To: <cover.1705328293.git.mazziesaccount@gmail.com>


--bYf1yi2hjMfPcMgh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Add undersigned as a maintainer for IIO GTS helper's KUnit tests.

Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>

---
This may or may not conflict with the filename fix here:
https://lore.kernel.org/all/CAO=3DgReFVhp7QK_XZRBO5vbv6fmFb4BdsZeQPSzWvuiz9=
UeQekA@mail.gmail.com/

Conflict should be very trivial so I didn't wait for the above fix to
get in IIO tree. I can rebase and resend if this appears to be a problem
though.
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 40c754b4c39c..05c13e0f8c4d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -10310,6 +10310,7 @@ L:	linux-iio@vger.kernel.org
 S:	Maintained
 F:	drivers/iio/light/gain-time-scale-helper.c
 F:	drivers/iio/light/gain-time-scale-helper.h
+F:	drivers/iio/test/iio-test-gts.c
=20
 IIO MULTIPLEXER
 M:	Peter Rosin <peda@axentia.se>
--=20
2.43.0


--=20
Matti Vaittinen, Linux device drivers
ROHM Semiconductors, Finland SWDC
Kiviharjunlenkki 1E
90220 OULU
FINLAND

~~~ "I don't think so," said Rene Descartes. Just then he vanished ~~~
Simon says - in Latin please.
~~~ "non cogito me" dixit Rene Descarte, deinde evanescavit ~~~
Thanks to Simon Glass for the translation =3D]=20

--bYf1yi2hjMfPcMgh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmWlQJgACgkQeFA3/03a
ocX6owgAmUij6A/JFJbaFtDoNP7pmvZQfzBS0fo1QuA9+h975SfxE3ma7gwWZGbs
A/nKC1YVW9lGSYEhjt6p7TeswBaho8tDostxvEr9vCWRtCqb4R+H/UJu8/qmfD/t
8qKWlCRSqJGySzQqn4JLMRTv35tEi1ETtRTzwwGaczYwx1ttE7LBe8VwIKwOjVvp
8Tg75DNImP8u2CkL+Vd4XRkUpbAk2RK/ahXGWAaxn+0vgfq/fylSqQMMhKWs5iph
Ew3CT5IL5o1Q6ZMMBpHRSmoNVusN02OO/BzJUUYNh6Qcfgxz2fcDIvi5XDbJXFt1
sqRl145WRVyesmb5OvaoBjHi5b2F8Q==
=dtqq
-----END PGP SIGNATURE-----

--bYf1yi2hjMfPcMgh--

