Return-Path: <linux-kernel+bounces-161801-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C8D4A8B516F
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 08:29:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CC638B20C9D
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 06:29:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAB341119B;
	Mon, 29 Apr 2024 06:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E6PQi0YE"
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85BA8DDB1;
	Mon, 29 Apr 2024 06:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714372186; cv=none; b=XJI9SjZ/1chZ/XbI2QWRk6ZJ1LLMhh6aYPO6NHN+2Smy6zxyAxprlj+uszezi6eghyRUEomZ/xdd6brhuRhYIeVHW4U1xVfggNPOIq7vIVjC+ajARzN82IVCO5bvMvBg3VuZTH+inKobxs3K6ciJkjx3aJePkkLq74W952OtYQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714372186; c=relaxed/simple;
	bh=WAtsg6riz3q48rqIwE1ZDk97CIJGt3cqu3KYT76J45c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FEVNZlaGnH5J7tjkbYRs1g56tX8fs/ywzSDHYtYELQHgZIRomC+qhmuuydlh0uqm5abG3x9T/EQruGcbXlhEuv15wMNU5ecPSdDIeNLfVwlXHCioM07Z9H5xd7twqZ+CDE0EKfJYXWVHapWuu/RfhSDoGQdKLPqwI443qGqWKok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E6PQi0YE; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2e09138a2b1so3759161fa.3;
        Sun, 28 Apr 2024 23:29:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714372183; x=1714976983; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OM8DP/40dDc9CpeuAebHNnI+MP/jkRlaYkjhPYB7kH8=;
        b=E6PQi0YEppfaaxmPPmyATcHpPrQOTmJm0S4PaQ5DsYy+sYPwQbLhSxHPVn0zGCdqQs
         Ka+i5xPkvwVCkVWhGOsJow52icax0c0Dam5y/wPRam2jIdeBIleZs8tvDwEczoX46zpl
         LjQ67vlBwRzLNlEj69zquIGBjUeq1nZwEXA6eaBkRQD4t6Eh69tU5eNskrgaU7gWZyBX
         YKhV87boGETsqQzuEkw2bgI9vev2EzeSnAbwOa/M6oFL5DN6USzrTMC+8QmKrOyw6Ekr
         kvrwb/cM1y+6LcCW5RYnRq3hFVySS+sTys9Id6zcR4Z3kV2B1nPEPKfh7upcSnXXIkUh
         9FOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714372183; x=1714976983;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OM8DP/40dDc9CpeuAebHNnI+MP/jkRlaYkjhPYB7kH8=;
        b=h0L/TV4P5QYXfP8m0QzJtOp3sMWaZjCbNAxeVBSdVBzhEuhtF1viK2NktKiZdIVVX7
         4cqr4ELyeRwkhTUwIHddxz1gS5Eb2f5ZO3tZ70qLATfs+tgchylWoDkymmD7cmXuShzB
         eFuJ3uYaBAwFTPep19k8zzZWKN++JTwxzTzOMnczoELGgA62Cb9D2NWcGSGIz7vK5KhQ
         eaGauGhf7NP2NjlUBjA3NIaXOfBwZsAwPyz6KoZUVN8XidNUsYrtAV2L6YGgMO/a6kxp
         pMWZZ6uuqc/1X6sBZUFgGuArrSieq34x5Knwd/ZT8rQktzz9TOvNOuR5iBdHtKNz3HAb
         +AyA==
X-Forwarded-Encrypted: i=1; AJvYcCUrAn0oKWEoro7pH/95PInnDAPKo4VpgQjYLuBQFF/MbwgmMNX0LFl3z0ePP1NhruP/LIULa+QJvjWruubAv1FyRgM2IIMS6X4w3iDZ+YO5htWM19QdX4hpIeKG4hVyyanA3C53iyD2
X-Gm-Message-State: AOJu0YxRIMKAwSSw2Itox1k6SOLbpymUAodzGxIjVPPK/pu9v5BE6Dp0
	bWja2YSI1qAxQ2vBvJ/YqnfGEy4K3IpGRn2WBqgzXwaMTjHc8nYI
X-Google-Smtp-Source: AGHT+IEl8KgNaSEUOyX9FDK7SvJ8iwg4IfFKgqTphVmzYsM9+dosFBK1MSubwCKCx9N8LM9Q7fcMxQ==
X-Received: by 2002:a2e:9fc5:0:b0:2df:6b06:b5dc with SMTP id u5-20020a2e9fc5000000b002df6b06b5dcmr7050501ljm.15.1714372182521;
        Sun, 28 Apr 2024 23:29:42 -0700 (PDT)
Received: from fedora ([2a10:a5c0:800d:dd00:8cfe:d6e7:6701:9dfd])
        by smtp.gmail.com with ESMTPSA id z7-20020a05651c11c700b002d80a2da6d2sm3575758ljo.129.2024.04.28.23.29.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Apr 2024 23:29:41 -0700 (PDT)
Date: Mon, 29 Apr 2024 09:29:37 +0300
From: Matti Vaittinen <mazziesaccount@gmail.com>
To: Matti Vaittinen <mazziesaccount@gmail.com>,
	Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc: Matti Vaittinen <mazziesaccount@gmail.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, Chenyuan Yang <chenyuan0y@gmail.com>
Subject: [PATCH 2/2] iio: test: gts: test available times and gains sorting
Message-ID: <ae0256e9bf07e2eda64e944e8823b9fe0e5844b4.1714371936.git.mazziesaccount@gmail.com>
References: <cover.1714371936.git.mazziesaccount@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="D9LjSD8JOjiofNMz"
Content-Disposition: inline
In-Reply-To: <cover.1714371936.git.mazziesaccount@gmail.com>


--D9LjSD8JOjiofNMz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The iio_gts helpers build available times and scales tables based on the
times and gains arrays given from the driver. The driver should be able
to list all valid register values so that conversion from register valu
to correct gain/time works for all supported register values.

It might be more convenient for drivers to list these times and gains in
the order where they're listed in the data-sheet than ascending order.

However, for user who requests the supported scales / times it is more
convenient to get the results in asscending order. Also, listing
duplicated values is not meaning for the user.

Hence the GTS heler should do sorting and deduplication of the scales
and times when it builds the tables listing the available times/scales.
Note, currently duplicated gain values aren't handled by GTS-helpers.

Unsort the gain and time arrays in the test code, and add duplicates to
time array in order to test the sorting and deduplicating works.

Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
---
 drivers/iio/test/iio-test-gts.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/test/iio-test-gts.c b/drivers/iio/test/iio-test-gt=
s.c
index cf7ab773ea0b..5f16a7b5e6d4 100644
--- a/drivers/iio/test/iio-test-gts.c
+++ b/drivers/iio/test/iio-test-gts.c
@@ -70,6 +70,7 @@
  */
 static struct iio_gts gts;
=20
+/* Keep the gain and time tables unsorted to test the sorting */
 static const struct iio_gain_sel_pair gts_test_gains[] =3D {
 	GAIN_SCALE_GAIN(1, TEST_GSEL_1),
 	GAIN_SCALE_GAIN(4, TEST_GSEL_4),
@@ -79,16 +80,17 @@ static const struct iio_gain_sel_pair gts_test_gains[] =
=3D {
 	GAIN_SCALE_GAIN(256, TEST_GSEL_256),
 	GAIN_SCALE_GAIN(512, TEST_GSEL_512),
 	GAIN_SCALE_GAIN(1024, TEST_GSEL_1024),
-	GAIN_SCALE_GAIN(2048, TEST_GSEL_2048),
 	GAIN_SCALE_GAIN(4096, TEST_GSEL_4096),
+	GAIN_SCALE_GAIN(2048, TEST_GSEL_2048),
 #define HWGAIN_MAX 4096
 };
=20
 static const struct iio_itime_sel_mul gts_test_itimes[] =3D {
-	GAIN_SCALE_ITIME_US(400 * 1000, TEST_TSEL_400, 8),
-	GAIN_SCALE_ITIME_US(200 * 1000, TEST_TSEL_200, 4),
 	GAIN_SCALE_ITIME_US(100 * 1000, TEST_TSEL_100, 2),
+	GAIN_SCALE_ITIME_US(400 * 1000, TEST_TSEL_400, 8),
+	GAIN_SCALE_ITIME_US(400 * 1000, TEST_TSEL_400, 8),
 	GAIN_SCALE_ITIME_US(50 * 1000, TEST_TSEL_50, 1),
+	GAIN_SCALE_ITIME_US(200 * 1000, TEST_TSEL_200, 4),
 #define TIMEGAIN_MAX 8
 };
 #define TOTAL_GAIN_MAX	(HWGAIN_MAX * TIMEGAIN_MAX)
--=20
2.44.0


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

--D9LjSD8JOjiofNMz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmYvPlEACgkQeFA3/03a
ocUo/wf/Sagx8nd34ynPtdtubv+HsZ0Epvfw0j6jEPuKZoU35IGJxhJKO/eC+SwK
JArByTSK5fO3Ig5H2kR+EoQVSOocNAplXndrx12iMWZ6McOVzlyfM97XPv1ajcD/
VpINaow3f9Y1G0IB0z+H2ro8W5jQy0+LkrI8cG9YnmHwt4FoU8uRjIVpqgkwLTt2
dELo3QmRjQZgRzOk2oTkd+vP+p/GFhDVtAL06jP6yuSJKuH8GJ98jaiIqSUxXDqx
VV27lm3yCoDfaas41Xw+W97TxjsFmGjA02ihMWn305e3HtG9obMmlwXuwYoYKPx0
fCzEcfZYJAhGa/MoxPkspbPL7ax92A==
=zjX3
-----END PGP SIGNATURE-----

--D9LjSD8JOjiofNMz--

