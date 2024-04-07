Return-Path: <linux-kernel+bounces-134225-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4179089AF3D
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 09:36:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6AF431C2279E
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 07:36:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B5E1DDBD;
	Sun,  7 Apr 2024 07:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="adiRfEwM"
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C477E7483
	for <linux-kernel@vger.kernel.org>; Sun,  7 Apr 2024 07:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712475364; cv=none; b=YOdTqoTtkZpdHie5pOZcaV+DYJJzIV3z4cqrcq4Llkmx/REApknH+jgam6KZeY8X7SPmBoPcu43LX9v+bVO0T85lWkH8fIiXxVFdIwPDxetXDy4wZqrqSO/F5eCgYLYzNDWYYLBsajBwBDE+BEXZiF8SEVRNNPUS3Em9gJpW/HM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712475364; c=relaxed/simple;
	bh=JJSvY+OjzPtwilwYiSSm+ioa/bYGAqQKiEtNPDWPEtk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Vz/4Ye6TlPy9jHaTc72AFUcnYD0GRu1ZDtIMLYyjxrKFc5IOE/DBNUFuz3ERdlCpUq2QI+f76KHIwgltIb7fgQBGaZqBsk6pW37aI07JGIKnu9eQENko8ShykzkkSShqYNL0E3wKB/2yRdoH57A/NLMbGcvET9oaRR1nLvKsoWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=adiRfEwM; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2d4a8bddc21so45869231fa.0
        for <linux-kernel@vger.kernel.org>; Sun, 07 Apr 2024 00:36:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712475361; x=1713080161; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ui4/Pb0ZDd4ruHbUINQJO/qwKevUZ2j5AT/8ZSqkIyE=;
        b=adiRfEwMZbu85sKerXkUpyLZhS83xiRKiGWkx+9Y1h6DJJGe8Nq+oVPuUUcCA/R9Zc
         5RL6SEQvEqgCJ0qlmv1sdpS5xu3WNz0rXxqOy2sBcZZts1t2vnEyjs/xehxW04obUEId
         9Zd/I4dE/dpVyKUIHoowLmeQqyy+11Vq7oa1U8jftfEtMQt2H4WWj1FL8YumEALar6Ez
         EDNpFUI0bua8Yo4JTE8/g70JvLySO6YZ1C1CYtEZmuItvbY6ydK5ABJo7KzfAG1tqg0o
         97A+t0FOv7fKjZcieTfD3DUhCAz7wVvQleaHwttCVqLD8PXya5n8TxiRE1hPuqZSceXb
         wxEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712475361; x=1713080161;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ui4/Pb0ZDd4ruHbUINQJO/qwKevUZ2j5AT/8ZSqkIyE=;
        b=Yr4p42L1Q44llPGmGt7feP8a26WSVEqpzl5w/5rHw6/3fE5KbM552tOd0UVvHxAyRx
         KvkiC6zb+KwvFrY4fp7NZUpCo6XpT1+GPeJol7Fb9oHyMz+8UKQ6dlA2RfKM7gHDN7YI
         TKcKrkZSHl/37jlIZJPyzjib48EcG1M/YwnsRS4eEdMmx+ukNi1BXefN7fG8z+Y3MM+p
         zaTpW76GK6vo2jdQmXBlcHhFe9PFkwHlDVuWONoBKa1Y+XB/PGPf1LP3MdA2Sz1qAdFV
         WwYaKafOPQrtGP/HrZG9CAwN16ff4PQpPosfYeoyU/JwzKRxWDqtubKF2k7/27IrO0lu
         dDpg==
X-Forwarded-Encrypted: i=1; AJvYcCWcXhzxZ/CgqhRvrzauRkcffY7Zt4kReR2N24dimormmzaKgVDNNV1gtKPALO1mDIJIuadmLPPQkrAhKO7B1zo6RL1dOiSN2uSnGcJE
X-Gm-Message-State: AOJu0YzVYek2JUSrgYHH9JmDdSx0bksgt8Zs8CnP07EtzYZE/cKou5gY
	4EavfOi1q5LaRhM4P9pMfRYH04+u6PtpqUabDoXkk6pJk9FWRAHd
X-Google-Smtp-Source: AGHT+IEVHSiiQZdxVfkxybZhohN0T85E4XD38V1WXOP1kXdsnTNftNptYRnt3+mfXLfSAtUBbHR0eA==
X-Received: by 2002:a2e:854c:0:b0:2d8:5af9:9097 with SMTP id u12-20020a2e854c000000b002d85af99097mr3474071ljj.42.1712475360606;
        Sun, 07 Apr 2024 00:36:00 -0700 (PDT)
Received: from drtxq0yyyyyyyyyyyyydy-3.rev.dnainternet.fi (drtxq0yyyyyyyyyyyyydy-3.rev.dnainternet.fi. [2001:14ba:7426:df00::6])
        by smtp.gmail.com with ESMTPSA id f4-20020a05651c03c400b002d860a40f9dsm661070ljp.136.2024.04.07.00.35.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Apr 2024 00:35:59 -0700 (PDT)
Date: Sun, 7 Apr 2024 10:35:21 +0300
From: Matti Vaittinen <mazziesaccount@gmail.com>
To: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
	Matti Vaittinen <mazziesaccount@gmail.com>
Cc: Matti Vaittinen <mazziesaccount@gmail.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH] regulator: irq_helpers: duplicate IRQ name
Message-ID: <ZhJMuUYwaZbBXFGP@drtxq0yyyyyyyyyyyyydy-3.rev.dnainternet.fi>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="oJylSAUUxXPDKJ0i"
Content-Disposition: inline


--oJylSAUUxXPDKJ0i
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The regulator IRQ helper requires caller to provide pointer to IRQ name
which is kept in memory by caller. All other data passed to the helper
in the regulator_irq_desc structure is copied. This can cause some
confusion and unnecessary complexity.

Make the regulator_irq_helper() to copy also the provided IRQ name
information so caller can discard the name after the call to
regulator_irq_helper() completes.

Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
---
 drivers/regulator/irq_helpers.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/regulator/irq_helpers.c b/drivers/regulator/irq_helper=
s.c
index fe7ae0f3f46a..5ab1a0befe12 100644
--- a/drivers/regulator/irq_helpers.c
+++ b/drivers/regulator/irq_helpers.c
@@ -352,6 +352,9 @@ void *regulator_irq_helper(struct device *dev,
=20
 	h->irq =3D irq;
 	h->desc =3D *d;
+	h->desc.name =3D devm_kstrdup(dev, d->name, GFP_KERNEL);
+	if (!h->desc.name)
+		return ERR_PTR(-ENOMEM);
=20
 	ret =3D init_rdev_state(dev, h, rdev, common_errs, per_rdev_errs,
 			      rdev_amount);

base-commit: 4cece764965020c22cff7665b18a012006359095
--=20
2.43.2


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

--oJylSAUUxXPDKJ0i
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmYSTLMACgkQeFA3/03a
ocXgbQf/erNMcArbV1lK+KEl03lvK0UiZMesY3WPYt150EjHF/RHUTKDeSx98wH5
7HPw1RbV2fQ/Kgx3VbVr2khfYlY8XLTCv89pCAeiSxrPgUd5MadQlYGJf2FLX227
WWk+6d93/sndShwYGyY0OSvalgxcNSUk6Umuk4DF8LCGc3Gw0e+TszWe4TiB8nn0
CMPoZMHiaGoqB3fpha9/XmFdKKTS6hbdu6K6Dk+3QPS2NrGoByq+FWB3xBrUlWZe
dVRUMbUDLVJCWm98W6zNqxehxP7o/jXnlt9dbU0ZnePUKbnvvRYMH8HRjVvP4OFP
27atepDUrBy/G6ozY2Dn26oX558BZA==
=sA4R
-----END PGP SIGNATURE-----

--oJylSAUUxXPDKJ0i--

