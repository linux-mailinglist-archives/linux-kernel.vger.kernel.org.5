Return-Path: <linux-kernel+bounces-61411-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7298D85120A
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 12:20:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B4A4CB234BB
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 11:20:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D45E938FA0;
	Mon, 12 Feb 2024 11:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="llpvAF1n"
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F52D2BAE7;
	Mon, 12 Feb 2024 11:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707736824; cv=none; b=LKcIpPo0jnHb+wW/e/Pz+a9x9BDJGpDpCq1LgaDRBezQEwN4AEJdUhEC/rqpuTw2dSzTfcxoIO5tonFCFqIiwvD6D4X0Uglfv9rP2rR9ykY+TZLZLRVq7YjMGfxS+tTEBH5Xo5QIj0TurE/17jXbgoLN3PUgEJsQ96taxhC5wLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707736824; c=relaxed/simple;
	bh=NIf3m0p41QvLOoLpJZww8fr5lUh/7naMs+DwQJ35TCQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=civdbu5gKpLbm5uxFKkt8wC7iVNvngyxBMp+ndGytLji98KLtzajk+I8AYMOmZExMCSZnoO+q6TaVWhcurMJ1tS6rH2USmGHpueOcRCfwVQ4GMnOXDwrCWaECXc6AsQaGYtrQnhbNNUAOSajijkSek5t9d78ZHMcfYDogIGg3TI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=llpvAF1n; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2cf3ed3b917so38614591fa.1;
        Mon, 12 Feb 2024 03:20:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707736820; x=1708341620; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=350dwjN8QQutWLlYzcXvkSs1h7jhGOVddH+hl5UJwAY=;
        b=llpvAF1ng31phyOQzD7fl+FdTAnXnU4Yyjr6b0NF6QRd80NZN50fBidbmG8dMA+0TG
         bSGpjL4AMTvnPg0fmYeb+u7r60a+AsgsBsIwPC7qGoGuKzk7T0kJQS7aQOLpFZEVEDj7
         aWOSfIzNGl4PHXnk7Ly+zgCKrLvs7GfJam//ZY6ATTlww88ZLm+bdIAeYpYIHElD/tuU
         xsvpSy5tst0JMrqhJVx7bOlzrztDdvXkPFs+wbu1seQ11JfTKd1wmm+8QNyNtUr9XzVA
         DLyrEjKOfC1dF025GUznm7svN2WLix/+SV+BDDM1SPnuBxTLljjiuwuQG7NB3dof+b0M
         JoMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707736820; x=1708341620;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=350dwjN8QQutWLlYzcXvkSs1h7jhGOVddH+hl5UJwAY=;
        b=YCO+6HhLyKlKJ98GYohvSI/20oS6jTbU1HJS4O25G4QOmCedt+F/0D5LcllC6TNBn3
         OJm5nhhPTvUAlHbxPuUpTlPApyzBgSnDU3esev0IEWX1dxmd2N9uG7PMS+ltSDOreVM8
         dTsHASR9eeO7iJd1IZ5y7yHnXYTZBanNXKQvDUvtrJK6jqmvHGu0UOhcKHLy/rVYY5i/
         lJc0O4rjd57TGh8AAwJ1+T4KGhsqosbT61EEbLjSGXqVdaLDvZp7s+RGrtszg/UwWgNu
         7HBz3By5MKkPtw+o9UgGSllTFC7wzcW2n2I+H1xEFMOVpN6/tOV+O+d1YJt0qlzkfntD
         yXFg==
X-Forwarded-Encrypted: i=1; AJvYcCUd65KSB7TI+kalHxFND8PAyDbCpHNpVHUo+7i0+uExG8dafllKmG6vXRQYZA4R4CS1XdDqGSL/M8z3/O117NET5M73+tAOATmApPlRyDZj9nJhY/XXzUtXfi+NKHPOuRNPJJBPP1n4
X-Gm-Message-State: AOJu0YzgJ7ogV6dZbLdBUMQ+S60jToLKZwZ3atGg31S1swT/01mTrUsK
	t8jgpmJa2sBYHrRlFFdozFSerSgWy4KfNm4mai1oWlWc7pZaETi8
X-Google-Smtp-Source: AGHT+IHIev8+kzV0uX0jUUXCyYCQrx7fd1e5XtbnSjmBEFkq2JGk2UPMDIAdfPJuYz+10r0ouZPU1Q==
X-Received: by 2002:a05:6512:138a:b0:511:8cb1:7c9d with SMTP id fc10-20020a056512138a00b005118cb17c9dmr2607187lfb.24.1707736820241;
        Mon, 12 Feb 2024 03:20:20 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUhu0kIEcrqnMooWZvnav8sYvNIRGqSw2J29k0CoLGP8C48lwyUELDMV/YA8XZhjckkhXC+zUpOnkPwvcGOdlYsrihJbwle4RA/j86jo7/gBOe20hW36i5OoZvu4htDoGF1hJnUGiof67pa/2d7PO81thT5gNY0dqt1/BacOBW7BtPH6siiVVxX+9jNzqiUk8NpOxfaB3x2H+mlEFnjWwsE2TeY5vL3qEybeu59pFPMtasR3YXLNZzHdprnOyHoTxNOH1YPSDgoMNG2
Received: from drtxq0yyyyyyyyyyyyyby-3.rev.dnainternet.fi (drtxq0yyyyyyyyyyyyyby-3.rev.dnainternet.fi. [2001:14ba:7426:df00::2])
        by smtp.gmail.com with ESMTPSA id bi31-20020a0565120e9f00b005117fc3d553sm824462lfb.70.2024.02.12.03.20.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Feb 2024 03:20:19 -0800 (PST)
Date: Mon, 12 Feb 2024 13:20:09 +0200
From: Matti Vaittinen <mazziesaccount@gmail.com>
To: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
	Matti Vaittinen <mazziesaccount@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	linux-kernel@vger.kernel.org,
	David Laight <David.Laight@aculab.com>,
	Subhajit Ghosh <subhajit.ghosh@tweaklogic.com>,
	linux-iio@vger.kernel.org
Subject: [RESEND PATCH v2] iio: gts-helper: Fix division loop
Message-ID: <Zcn-6e-0-nh2WcfU@drtxq0yyyyyyyyyyyyyby-3.rev.dnainternet.fi>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="r7jqDadsvKX59wc/"
Content-Disposition: inline


--r7jqDadsvKX59wc/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The loop based 64bit division may run for a long time when dividend is a
lot bigger than the divider. Replace the division loop by the
div64_u64() which implementation may be significantly faster.

Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
Fixes: 38416c28e168 ("iio: light: Add gain-time-scale helpers")

---
This is a resend. Only change is the base which is now the v6.8-rc4 and
not the v6.8-rc1

This change was earlier applied and reverted as it confusingly lacked of
the removal of the overflow check (which is only needed when we do
looping "while (full > scale * (u64)tmp)". As this loop got removed, the
check got also obsolete and leaving it to the code caused some
confusion.

So, I marked this as a v2, where v1 is the reverted change discussed
here:
https://lore.kernel.org/linux-iio/ZZZ7pJBGkTdFFqiY@dc78bmyyyyyyyyyyyyydt-3.=
rev.dnainternet.fi/

Revision history:
v1 =3D> v2:
 - Drop the obsolete overflow check
 - Rebased on top of the v6.8-rc4

iio: gts: loop fix fix
---
 drivers/iio/industrialio-gts-helper.c | 15 +--------------
 1 file changed, 1 insertion(+), 14 deletions(-)

diff --git a/drivers/iio/industrialio-gts-helper.c b/drivers/iio/industrial=
io-gts-helper.c
index 7653261d2dc2..b51eb6cb766f 100644
--- a/drivers/iio/industrialio-gts-helper.c
+++ b/drivers/iio/industrialio-gts-helper.c
@@ -34,24 +34,11 @@
 static int iio_gts_get_gain(const u64 max, const u64 scale)
 {
 	u64 full =3D max;
-	int tmp =3D 1;
=20
 	if (scale > full || !scale)
 		return -EINVAL;
=20
-	if (U64_MAX - full < scale) {
-		/* Risk of overflow */
-		if (full - scale < scale)
-			return 1;
-
-		full -=3D scale;
-		tmp++;
-	}
-
-	while (full > scale * (u64)tmp)
-		tmp++;
-
-	return tmp;
+	return div64_u64(full, scale);
 }
=20
 /**

base-commit: 841c35169323cd833294798e58b9bf63fa4fa1de
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

--r7jqDadsvKX59wc/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmXJ/uUACgkQeFA3/03a
ocXMgggAw8+wylWjHi1iUXo2RCilsgP8kakiQ9FcMGaJauAoM2zU7m0Ci1Qynb2Z
0s+2qxVTuOKGiWj983f0SSPxS3UEDK/7U7+W/wXmjUVVPWOcc/xZE60foFFSTFEF
PgOdxVFRjLFp6fZtmhw8QsAsdGMcdhyAIeDChz755bqTWdj5IDISWC1aalVcL08W
pzTJZujcILWO3wVHICnIpgdyJ8P/JwfsRMGgLcZqE7lqzKF81YIqjmAXOk1G2r8N
jvjUD6G3H6xtogh0zfN/Rm0Pr+JTsOpDLragt9RkIs7/3DFVYPpfh19NaQ5Ghw1F
4eGtkWCugDC7KpaL2HFET/It6VFEMw==
=oX2V
-----END PGP SIGNATURE-----

--r7jqDadsvKX59wc/--

