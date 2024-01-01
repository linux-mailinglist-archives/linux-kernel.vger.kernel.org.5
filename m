Return-Path: <linux-kernel+bounces-13957-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 43DB38215E7
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 00:09:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CCD4C281A5F
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jan 2024 23:09:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4563EAD6;
	Mon,  1 Jan 2024 23:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="UZlhKkmt"
X-Original-To: linux-kernel@vger.kernel.org
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15F0CE560;
	Mon,  1 Jan 2024 23:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1704150560;
	bh=WrdV0DO+otQoGTvpb0fiYqj7oilBjqJ5gqC8CkzQJ8U=;
	h=Date:From:To:Cc:Subject:From;
	b=UZlhKkmtRZ7zpboc2IHCS2nKksXh9ku1cX/cAPgF0UNEEVxmyEpiGd9wPiAEHnQXo
	 zwTjc0Ek8tMJtJdp3NYhDM9hSUoAEyFYvSRX3WOdKxGs5ufT5IpSK9XyVn9LFpplV6
	 CMV/f6BxWSIN4qRb7a1YfwD1vJ9ATqAMlr15J8n4ZQ5DuYPtkCmoNMV7gIkbwjK/qd
	 YIQnhNZL+qyfFrKogKhpy4sU14J7n6ApQUBOM4F3h5VUozl0gUZ16OG9y30HyKg9pz
	 4O5R/Of4hKR4WgJ3T6gBbUJmbHn4blzFO3ahGoRsl0ZxCuIUwffJyC5ZZB81yaLq/0
	 Pb6u+pAvRTVIA==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4T3sB66nQ6z4wwG;
	Tue,  2 Jan 2024 10:09:18 +1100 (AEDT)
Date: Tue, 2 Jan 2024 10:09:17 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui
 <rui.zhang@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Fabio Estevam <festevam@denx.de>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>, Lukasz Luba <lukasz.luba@arm.com>, "Rafael J.
 Wysocki" <rafael.j.wysocki@intel.com>
Subject: linux-next: manual merge of the thermal tree with the pm tree
Message-ID: <20240102100917.223cd3b7@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/qWlOHJx/LvaBKrIXrEu0bD5";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/qWlOHJx/LvaBKrIXrEu0bD5
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the thermal tree got conflicts in:

  drivers/thermal/thermal_core.c
  drivers/thermal/thermal_core.h

between commit:

  a8c959402d4d ("thermal: core: Add governor callback for thermal zone chan=
ge")

from the pm tree and commits:

  726edaad90f6 ("thermal/core: Prepare for introduction of thermal reboot")
  f21b0d185f75 ("reboot: Introduce thermal_zone_device_critical_reboot()")

from the thermal tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc drivers/thermal/thermal_core.c
index 58958288b559,9d47347d4242..000000000000
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@@ -309,16 -314,7 +309,16 @@@ static void handle_non_critical_trips(s
  		       def_governor->throttle(tz, trip);
  }
 =20
 +void thermal_governor_update_tz(struct thermal_zone_device *tz,
 +				enum thermal_notify_event reason)
 +{
 +	if (!tz->governor || !tz->governor->update_tz)
 +		return;
 +
 +	tz->governor->update_tz(tz, reason);
 +}
 +
- void thermal_zone_device_critical(struct thermal_zone_device *tz)
+ static void thermal_zone_device_halt(struct thermal_zone_device *tz, bool=
 shutdown)
  {
  	/*
  	 * poweroff_delay_ms must be a carefully profiled positive value.
diff --cc drivers/thermal/thermal_core.h
index 479c3b6917e4,36364688b4a2..000000000000
--- a/drivers/thermal/thermal_core.h
+++ b/drivers/thermal/thermal_core.h
@@@ -114,8 -114,7 +114,9 @@@ int thermal_zone_device_set_policy(stru
  int thermal_build_list_of_policies(char *buf);
  void __thermal_zone_device_update(struct thermal_zone_device *tz,
  				  enum thermal_notify_event event);
 +void thermal_governor_update_tz(struct thermal_zone_device *tz,
 +				enum thermal_notify_event reason);
+ void thermal_zone_device_critical_reboot(struct thermal_zone_device *tz);
 =20
  /* Helpers */
  #define for_each_trip(__tz, __trip)	\

--Sig_/qWlOHJx/LvaBKrIXrEu0bD5
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmWTRh0ACgkQAVBC80lX
0Gx2NQgAg98fLdnuaiHDbndtNbLsBCqi4Ta0d/d+sqsLFKhEaoUf7qicHqpHOmEa
tuO0mzUT7sbGliABjhRo2ny3RU89mWk9/yjNP4MQzZzm3aH7R8lGPJTIBOPJ4WuS
k+WQT+GTJBZY168pCvqD7L5GbZdROe9miU/PfXLtIZzpA+SxUJFPXdE1prT2tC1c
J5ezBaauwjKU0OwtRkvSQsYcgfPBQxR/CrTTjvPoX3MLlN0iY7ZimBkXQ4ZOO/4W
2x188uwbgzaHtZwXXGiJUdsFJoS/Skmfw/Mye2HC87OVjFIaPSWnKEYWEfKro5zU
+2uHg+xT+niapXjvZuJBqsYAE+vD7w==
=8cWV
-----END PGP SIGNATURE-----

--Sig_/qWlOHJx/LvaBKrIXrEu0bD5--

