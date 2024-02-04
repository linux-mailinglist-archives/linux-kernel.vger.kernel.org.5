Return-Path: <linux-kernel+bounces-51739-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A761E848EBD
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 15:57:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD27B1C21C41
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 14:57:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 383C0224E8;
	Sun,  4 Feb 2024 14:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=natalenko.name header.i=@natalenko.name header.b="XKCS69bT"
Received: from prime.voidband.net (prime.voidband.net [199.247.17.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 717B6224E0;
	Sun,  4 Feb 2024 14:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.247.17.104
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707058654; cv=none; b=LG9P+kIyO3ThjWoNBj23mjpqk+B3Lrq9Ixb8x48PBvSi251KjhhC07TazK7ybt1ISroUFchAwIcrtKmGT4fsP1FD2EfcQOz7HhTIOyojTrvJo/1aKHTUysHoOAlFIK8joe/E45aUpL1+splTJorHNYM/rAbgBnhSJqnIGMqDN+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707058654; c=relaxed/simple;
	bh=qtx/zQljWlhQqFJyInObMs6jLW9K0bT0vh5OU+K7S4Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=i+IZevcjdvQigcZP8I3n4f6oDcPPtwdL7kEWt4uGo0bOvqCUF5dsml0BLsjB8Q03k0gezdhUEWYk/aIvsd4hcaGBpODndchbh+PkxcPZmhgHK+sySNVsNYcNftVBdPyaTmhbUEa8Ji5p0KDFOzExnJHzedQ3HeYXCEPXCi3PqP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=natalenko.name; spf=pass smtp.mailfrom=natalenko.name; dkim=pass (1024-bit key) header.d=natalenko.name header.i=@natalenko.name header.b=XKCS69bT; arc=none smtp.client-ip=199.247.17.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=natalenko.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=natalenko.name
Received: from spock.localnet (unknown [94.142.239.106])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by prime.voidband.net (Postfix) with ESMTPSA id 15BE86356CC0;
	Sun,  4 Feb 2024 15:57:28 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=natalenko.name;
	s=dkim-20170712; t=1707058648;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Brjx5gawkui+LJaaggx7nGzOEtMEOgZdpM2in1GRejw=;
	b=XKCS69bTM19pV7Y8tGu8Bf711bGsZpYrdVHeZwwUnuCsZVWV9pp3txdwc1llb6djGAWdyo
	e7wDldRGuMqyamgW9sjDIoJve+nT+LUf1IHd+vuVX9jyQY3FORLCZOeBk3TDtJPJJbC7R+
	hqJ5TZ7sY312c61mNfDsFnLAbkcMqMk=
From: Oleksandr Natalenko <oleksandr@natalenko.name>
To: rafael.j.wysocki@intel.com, Mario.Limonciello@amd.com,
 viresh.kumar@linaro.org, Ray.Huang@amd.com, gautham.shenoy@amd.com,
 Borislav.Petkov@amd.com, Perry Yuan <perry.yuan@amd.com>
Cc: Alexander.Deucher@amd.com, Xinmei.Huang@amd.com, Xiaojian.Du@amd.com,
 Li.Meng@amd.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject:
 Re: [PATCH v2 6/6] cpufreq: amd-pstate: remove legacy set_boost callback for
 passive mode
Date: Sun, 04 Feb 2024 15:57:17 +0100
Message-ID: <4896392.31r3eYUQgx@natalenko.name>
In-Reply-To:
 <e0746643c781f638c9e9cb8a6d2ceebeeb906f95.1707047943.git.perry.yuan@amd.com>
References:
 <cover.1707047943.git.perry.yuan@amd.com>
 <e0746643c781f638c9e9cb8a6d2ceebeeb906f95.1707047943.git.perry.yuan@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart4545156.LvFx2qVVIh";
 micalg="pgp-sha256"; protocol="application/pgp-signature"

--nextPart4545156.LvFx2qVVIh
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"; protected-headers="v1"
From: Oleksandr Natalenko <oleksandr@natalenko.name>
Date: Sun, 04 Feb 2024 15:57:17 +0100
Message-ID: <4896392.31r3eYUQgx@natalenko.name>
MIME-Version: 1.0

Hello.

On ned=C4=9Ble 4. =C3=BAnora 2024 13:12:57 CET Perry Yuan wrote:
> With new freqency boost interface supported, legacy boost control
> doesn't make sense any more which only support passive mode.
> so it can remove the legacy set_boost interface from amd-pstate driver
> in case of there is conflict with new boost control logic.
>=20
> Signed-off-by: Perry Yuan <perry.yuan@amd.com>
> ---
>  drivers/cpufreq/amd-pstate.c | 1 -
>  include/linux/amd-pstate.h   | 1 -
>  2 files changed, 2 deletions(-)
>=20
> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> index 02a76b8fb298..4e377efdd4ed 100644
> --- a/drivers/cpufreq/amd-pstate.c
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -1492,7 +1492,6 @@ static struct cpufreq_driver amd_pstate_driver =3D {
>  	.exit		=3D amd_pstate_cpu_exit,
>  	.suspend	=3D amd_pstate_cpu_suspend,
>  	.resume		=3D amd_pstate_cpu_resume,
> -	.set_boost	=3D amd_pstate_set_boost,
>  	.name		=3D "amd-pstate",
>  	.attr		=3D amd_pstate_attr,
>  };
> diff --git a/include/linux/amd-pstate.h b/include/linux/amd-pstate.h
> index 446394f84606..66d939a344b1 100644
> --- a/include/linux/amd-pstate.h
> +++ b/include/linux/amd-pstate.h
> @@ -80,7 +80,6 @@ struct amd_cpudata {
>  	struct amd_aperf_mperf prev;
> =20
>  	u64	freq;
> -	bool	boost_supported;

This leaves amd_pstate_ut_check_freq() in drivers/cpufreq/amd-pstate-ut.c b=
roken. Likely, the whole `if (cpudata->boost_supported) {` hunk should be r=
emoved there too.

Also, in the header file, there's kernel-doc before `struct amd_cpudata`, w=
here boost_supported is mentioned. It should be removed too then.

> =20
>  	/* EPP feature related attributes*/
>  	s16	epp_policy;
>=20


=2D-=20
Oleksandr Natalenko (post-factum)
--nextPart4545156.LvFx2qVVIh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEZUOOw5ESFLHZZtOKil/iNcg8M0sFAmW/pc0ACgkQil/iNcg8
M0urchAAvKYGEpxMWXdVRLbuUMR52vsR6OmsmlA21fkyGhmCg5Dckqxb1fdaXqQ2
Qz7M1GYLjEzXCxRzQi3IxPjNGp/0wtXycAO1DgvlgHexMydzVYLTsm7cdm29+/UV
N5SynY1bFiH6cvUEdYcg4Q2ZVorx20cNJ/Dfb8DsqzMBkHx+YWpllT6ZBdasX1Wr
5RRppw8VuunYXHugWexxXQMGRWC3IAjAj1EiJyswMZwGmiIqMuTUtv3y8ts+mK9w
7xLQ1lHUdY733C7NvzY0sRYKY1E1INhwX59zZrPUWgjgkGJEBBZIGBWbm6AeAKK0
SSL2pxyCYOYG/PuEfP20YcO5mL8Tb4Tjzd41sDMBADGAWmeBJnOC0hUrW9OGbu7N
KB04tSisT6uDgLTbIhaEPjGjhrpwwl0GqWXnHeEq8JGuqJtZwDCTpDd5waZpAD6O
nzRwZzwXjqR+8kf7vTl3kKRO5BguxnZcH1vS9krPc/2zh3FZeNY1Rau4s6IHTZh6
q62TkVr1iT3X8vG8Hy9OY+yUnLCylBQTPYVY7h7wgYKbEyhOt/YNRm5U000IeoRY
y1zxVPH+8N9O+zU9zpCIb5CqxOu9V5Rr/Dt6helF5j7Ebo5Nt7VUZ9E1mM5/56Uc
m04zzOYmqV2N4Z6haiao9dLRDHFmZS9EmheDARUS2ZXOOhzhkOk=
=3u7X
-----END PGP SIGNATURE-----

--nextPart4545156.LvFx2qVVIh--




