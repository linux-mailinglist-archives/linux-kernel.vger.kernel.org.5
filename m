Return-Path: <linux-kernel+bounces-134320-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B474589B049
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 12:05:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6F633282632
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 10:05:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85A7F1799B;
	Sun,  7 Apr 2024 10:05:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=natalenko.name header.i=@natalenko.name header.b="nAaYYL/v"
Received: from prime.voidband.net (prime.voidband.net [199.247.17.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 379FC1CAA4;
	Sun,  7 Apr 2024 10:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.247.17.104
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712484301; cv=none; b=Lcpsztq65HNcpJKM8OSkjr9tBw9+78QkKDrN9ckMaM+nh9q/q4zZJWn7ONRxav838wRlSRf9BWoArCzybI7JBuSytfnvpU8uKoNEiUKzlkEoro55YxYiv+u+LqZgNgWmws6YP/efuNnVP0hWSIBmuMPzIx2OcIO7l1Ibpv21y54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712484301; c=relaxed/simple;
	bh=0/fsqKxh1+aNH1t77VnNzkt/bNMfuWtuasepnvlsS9c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bDQMtimjE1Apt8prh7DhhngmTKxb6qc4kbKJGJhDqyy/pL65ZW5fabiDqHXjizGTXmYotbc+WJN4+eg8lI9thHnOf6L+ZG0N5nrNKDKKg1mCOULbg+Xlwk+88m2D0yYsPa7sSDkAdccaY6TUKHx1b7+mJ77z/iZ0NoVBEXsoPv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=natalenko.name; spf=pass smtp.mailfrom=natalenko.name; dkim=pass (1024-bit key) header.d=natalenko.name header.i=@natalenko.name header.b=nAaYYL/v; arc=none smtp.client-ip=199.247.17.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=natalenko.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=natalenko.name
Received: from spock.localnet (unknown [94.142.239.106])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by prime.voidband.net (Postfix) with ESMTPSA id 6AC60635B065;
	Sun,  7 Apr 2024 12:04:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=natalenko.name;
	s=dkim-20170712; t=1712484295;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0/fsqKxh1+aNH1t77VnNzkt/bNMfuWtuasepnvlsS9c=;
	b=nAaYYL/va6lpBS/v+xG/GnL2ZQ4lRDmPOZDX9vtkYE4Ny1tIx2d4t8bHvSODT3pSXl2eEu
	BAVrBdNrcDw5mhxUtJ8lX9ZjeydirwpGnRNgh9oxDnZjb56lhFzOd8wK7CsUzuWTC9tL/x
	mljgB3sT0SO2sz3pp7mG9+dtHm5jejo=
From: Oleksandr Natalenko <oleksandr@natalenko.name>
To: Pasi =?ISO-8859-1?Q?K=E4rkk=E4inen?= <pasik@iki.fi>
Cc: linux-kernel@vger.kernel.org, Norbert Preining <norbert@preining.info>,
 stable@vger.kernel.org, regressions@leemhuis.info
Subject: Re: Regression in kernel 6.8.2 fails in various ways (USB, BT, ...)
Date: Sun, 07 Apr 2024 12:04:44 +0200
Message-ID: <4908864.31r3eYUQgx@natalenko.name>
In-Reply-To: <20240407094458.GB28090@reaktio.net>
References:
 <ZgvkIZFN23rkYhtS@burischnitzel> <20240407093931.GA28090@reaktio.net>
 <20240407094458.GB28090@reaktio.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart4556512.LvFx2qVVIh";
 micalg="pgp-sha256"; protocol="application/pgp-signature"

--nextPart4556512.LvFx2qVVIh
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"; protected-headers="v1"
From: Oleksandr Natalenko <oleksandr@natalenko.name>
To: Pasi =?ISO-8859-1?Q?K=E4rkk=E4inen?= <pasik@iki.fi>
Date: Sun, 07 Apr 2024 12:04:44 +0200
Message-ID: <4908864.31r3eYUQgx@natalenko.name>
In-Reply-To: <20240407094458.GB28090@reaktio.net>
MIME-Version: 1.0

On ned=C4=9Ble 7. dubna 2024 11:44:58, CEST Pasi K=C3=A4rkk=C3=A4inen wrote:
> On Sun, Apr 07, 2024 at 12:39:31PM +0300, Pasi K=C3=A4rkk=C3=A4inen wrote:
> > > >=20
> > > > I noticed possible related USB problem/regression also with Linux 6=
=2E7.11, eg. my USB headset is not detected at all anymore when running Lin=
ux 6.7.11. USB headset works OK with Linux 6.7.9, so the regression is incl=
uded/backported to also either in 6.7.10 or in 6.7.11.
> > >=20
> > > It wound be nice to narrow this range down even further with bisectio=
n because there are too many changes between v6.7.9 and v6.7.11 that could =
cause this.
> > >=20
> >=20
> > I just tested more Fedora kernel rpms, and it seems Linux 6.7.10 still =
works OK,
> > but 6.7.11 has the regression (eg. USB devices not detected, laptop doe=
s not reboot=20
> > as it gets stuck before resetting the machine).
> >=20
> > So the regression was backported to Linux 6.7.11.
> >=20
>=20
> And with more testing interestingly it seems Linux 6.7.12 already fixes t=
he problem.
>=20
> I tried multiple times: 6.7.10 works, 6.7.11 doesn't, and 6.7.12 again wo=
rks.

Again, hard to tell given the amount of backported patches.

Maybe you were affected by [1] as the offending commit got into v6.7.11, an=
d the fix was picked in v6.7.12. If so, v6.8.4 should work for you as well.

[1] https://lore.kernel.org/lkml/84da1f26-0457-451c-b4fd-128cb9bd860d@leemh=
uis.info/

>=20
>=20
> -- Pasi
>=20
>=20


=2D-=20
Oleksandr Natalenko (post-factum)
--nextPart4556512.LvFx2qVVIh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEZUOOw5ESFLHZZtOKil/iNcg8M0sFAmYSb7wACgkQil/iNcg8
M0tj8RAArdVhR8UJFoGC9v8bKyiYBuLEhiUB35S7Gu3d5PRM5seriS4+pJaGJmY4
VOc8+uEpPE5NUwRbDeEbKd+Gs6vepgHFa5MevH3d8bxohdRuWslOJqn7xF5DG6Ss
to/tktEUX+kPX1t72FjtBZhGZ0ytOZsPLvlI8fbEa+U/4UH3dLDRDNF24KZqkvXS
EVs4CCocobUmJUoYxz2Y4F3E5yoULXfwz4SlkaElGxQ3ViWoZBunRYcf7h0/3V1Y
+POHPUWt3icyqti//7jA/GhHUsfqq70V6ZbGCvrRYr9jTkT3e04gE9RrUh6s/len
3eRU6VUh/kXpBucQQcChyqKRN08QhAHKK1y/RSAhfINSWPipeF1sX5n9Lj9c1yKq
FXIMNkJB8lwZWJts7cPMoj85JMjyW15vKx85+UfTxTC+AcNkcNgEZs5pJg93jyEj
v8AayNA/DFcqTQ/ers1dAsCeOQLfa8XeRnFacjeir6SOSqREyUqScLl9+lX5AMQx
kTPXCNmObdSCes2Z4RMO+VdyiDMeca+5P1Gr8QR/YQeteFa6LWi5EJ87dFIs3UIu
31xA+G3Rl4hKMDu0tWZWjeSiERok5/iaGxFnWZGsCLOMEut4RHVWV93qZiZpOwb5
aDtW86RIvFIQ1dhREg13TuOKVh1Qu+q7Y9Yq6SssMHeYpirPJ24=
=ftVy
-----END PGP SIGNATURE-----

--nextPart4556512.LvFx2qVVIh--




