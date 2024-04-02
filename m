Return-Path: <linux-kernel+bounces-127508-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB854894CB1
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 09:34:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A1430282D09
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 07:34:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDE663B299;
	Tue,  2 Apr 2024 07:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=natalenko.name header.i=@natalenko.name header.b="fxEklbVQ"
Received: from prime.voidband.net (prime.voidband.net [199.247.17.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75C493AC08
	for <linux-kernel@vger.kernel.org>; Tue,  2 Apr 2024 07:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.247.17.104
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712043261; cv=none; b=OnYUJohnCeAUCPosYPmLCrrfAUmGQ4rENWArqHSsum8LmMP//l+TuRuLVbClyPRY6O5LM1rOWnOBDGNqrMd+nevEZ93nKcOkDjdDEZhoZGNeee2/mJWwBZ4JHW/Pqw4r7pNymBw4wgFxtE9fWGGKKLjf5FoayQZRkfV7r7kbc3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712043261; c=relaxed/simple;
	bh=jSp8wWShlE2Mm6DBBA71MhGhBNRLWFmPrWpzbcc+LiQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LtPZaKa5TwGq5LK4Clihy0R8KWJEtImTp9ocUdfCKjWwagT/59s9+glaBHAOrb0k7X9nZ4bygAwXrXwwanb2TTn3e/gFVvn+womOt2QorWoI5gLYDNrgYhvUVFEsH1DBU8KTI7mt63aBliu3P2G5rEJmgMcO5YcN82AizGTpNTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=natalenko.name; spf=pass smtp.mailfrom=natalenko.name; dkim=pass (1024-bit key) header.d=natalenko.name header.i=@natalenko.name header.b=fxEklbVQ; arc=none smtp.client-ip=199.247.17.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=natalenko.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=natalenko.name
Received: from spock.localnet (unknown [94.142.239.106])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by prime.voidband.net (Postfix) with ESMTPSA id DE7EE6346550;
	Tue,  2 Apr 2024 09:34:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=natalenko.name;
	s=dkim-20170712; t=1712043255;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jSp8wWShlE2Mm6DBBA71MhGhBNRLWFmPrWpzbcc+LiQ=;
	b=fxEklbVQ2TRFIgjebUotwxx3d/i97UCQ/BE5MZFS5A65ODGls8rDM30USDfaEZuTOXWkRo
	TyRD0MhqnC5IbK7vYIDYfkvxb3EZDgNm7d3vW11wPx7Gog1+aSXxm7APc9MXpQJiryT5y8
	XHdN8n30j+X8GpktfAVUx/z3W1uQV18=
From: Oleksandr Natalenko <oleksandr@natalenko.name>
To: linux-kernel@vger.kernel.org
Cc: vincentdelor@free.fr, Andrew Morton <akpm@linux-foundation.org>,
 linux-mm@kvack.org
Subject:
 Re: Increase Default vm_max_map_count to Improve Compatibility with Modern
 Games
Date: Tue, 02 Apr 2024 09:34:03 +0200
Message-ID: <13499186.uLZWGnKmhe@natalenko.name>
In-Reply-To:
 <566168554.272637693.1710968734203.JavaMail.root@zimbra54-e10.priv.proxad.net>
References:
 <566168554.272637693.1710968734203.JavaMail.root@zimbra54-e10.priv.proxad.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2945100.e9J7NaK4W3";
 micalg="pgp-sha256"; protocol="application/pgp-signature"

--nextPart2945100.e9J7NaK4W3
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"; protected-headers="v1"
From: Oleksandr Natalenko <oleksandr@natalenko.name>
To: linux-kernel@vger.kernel.org
Date: Tue, 02 Apr 2024 09:34:03 +0200
Message-ID: <13499186.uLZWGnKmhe@natalenko.name>
MIME-Version: 1.0

Hello.

On st=C5=99eda 20. b=C5=99ezna 2024 22:05:34, CEST vincentdelor@free.fr wro=
te:
> Hello,
>=20
> I am writing to highlight an issue impacting many Linux users, especially=
 those who enjoy modern gaming. The current default setting of `vm_max_map_=
count` at 65530 has been linked to crashes or launch failures in several co=
ntemporary games.
>=20
> To address this, I have opened a detailed bug report (218616 =E2=80=93 In=
crease Default vm_max_map_count to Improve Gaming Experience on Linux) avai=
lable at: 218616 =E2=80=93 Increase Default vm_max_map_count to Improve Gam=
ing Experience on Linux (kernel.org) .
>=20
>=20
> We have identified that several modern games such as Hogwarts Legacy, Sta=
r Citizen, and others experience crashes or fail to start on Linux due to t=
he default `vm_max_map_count` being set to 65530. These issues can be mitig=
ated by increasing the `vm_max_map_count` value to over 1048576, which has =
been confirmed to resolve the crashes without introducing additional bugs r=
elated to map handling.
>=20
> This issue affects a wide range of users and has been noted in distributi=
ons like Fedora and Pop!_OS, which have already adjusted this value to acco=
mmodate modern gaming requirements.
>=20
> For reference, here is the change for Fedora:
> https://fedoraproject.org/wiki/Changes/IncreaseVmMaxMapCount
>=20
> Here is a list of games affected by this low value in vm_max_map_count as=
 reported to Valve:
>=20
> THE FINALS
> https://github.com/ValveSoftware/Proton/issues/7317#issuecomment-19748378=
50
>=20
> Hogwarts Legacy
> https://github.com/ValveSoftware/Proton/issues/6510#issuecomment-14227811=
00
>=20
> DayZ
> https://github.com/ValveSoftware/Proton/issues/3899#issuecomment-13043970=
69
>=20
> Counter-Strike 2
> https://github.com/ValveSoftware/Proton/issues/2704#issuecomment-17051997=
88
>=20
>=20
> **Steps to Reproduce:**
> 1. Install Ubuntu or other distribution with `vm_max_map_count` being set=
 to 65530 and attempt to run affected games such as Hogwarts Legacy or Star=
 Citizen.
> 2. Observe that the games crash or fail to start with the default `vm_max=
_map_count` setting.
> 3. Modify `/etc/sysctl.conf` to include `vm.max_map_count=3D1048576` (or =
another sufficiently high value).
> 4. Reboot the system and observe that the games now run without issue.
>=20
> **Expected Result:**
> Games should run without crashing or failing to start due to `vm_max_map_=
count` limitations.
>=20
> **Actual Result:**
> Games crash or fail to start unless `vm_max_map_count` is manually increa=
sed.
>=20
> **Suggested Fix:**
> Increase the default `vm_max_map_count` value in Linux to a value greater=
 than 1048576 to accommodate modern gaming software requirements.
>=20
> **Affected Games:**
> - Hogwarts Legacy
> - Star Citizen
> - THE FINALS
> - DayZ
> - Counter-Strike 2
> - Payday 2
> - (and potentially others)
>=20
> **References:**
> - Fedora's change documentation: https://fedoraproject.org/wiki/Changes/I=
ncreaseVmMaxMapCount
> - Various user reports and confirmations on gaming performance improvemen=
t with increased `vm_max_map_count`.
>=20
> I appreciate your time and consideration and welcome any feedback or sugg=
estions on this matter.
>=20
> Best regards,
>=20
> Vincent DELOR
>=20
>=20

Adding more lists and people to Cc. This email was sent to LKML only meanin=
g it is highly likely no one really saw it.

Andrew et al., what do you think?

Thank you.

=2D-=20
Oleksandr Natalenko (post-factum)
--nextPart2945100.e9J7NaK4W3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEZUOOw5ESFLHZZtOKil/iNcg8M0sFAmYLtOsACgkQil/iNcg8
M0t0pRAAi5v1wzmT90iiaZzodeBoiin6A9PF350AvsWMQWIutVw8yfCZwZaCD90U
25exHXJD90JGKTGNpAXtgBHS663BrLCOmfkTPxG5sKDUuFwLUhVpHggW8rxQzUHn
h3Xgk123Upd84CfVJQmp25igW+2MKsH11omFNSQyz0I7pbU9AfvSTRSe7AWqgghA
eVXI9FBugacfUUwFF53f5uAYnA1z/SgwJ/b40R/BG/ek5QBHbe97asgBbOmC/mYl
dIvJq/U3zkgQcQEvjPS60YssPu80AhB99Wx+kCibSQgoiI+jhpISSfzmi19c5/Va
AdcFDzPvQZ3knPln5gpDJ7NU/weXgShdEmQunuskdLSJhTjFnzbr+ySzrTamWw/t
A9DFEp4yS8p/mNa/ZLO14i4MEVaXYTCnsFt0wWCN1wQ6Eu808HMcevbHhly+dmUd
M5ASKFpGXnqRYTT/vy+LnEC9dk6W5iYKIaHtvdrLoCNmQlzeHYSPunm4Onowz3rW
FlPe8OxlOmiokvPiWClu/AECXRzjC5dgzPfr9IuvZ8HdB98qC4tW1bSD9Q29bfXt
bKWe3jWYa2XGrvwPMRD2ycvZ0pDvQDh0HIZ96xvGxUykCBQpDixGjt5jaZDdPqzU
yKhqHB911P5Cn79jZhiuzSsVKskIfG+zAUmzDCtHey8XiTTN9MY=
=3Qrh
-----END PGP SIGNATURE-----

--nextPart2945100.e9J7NaK4W3--




