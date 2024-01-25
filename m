Return-Path: <linux-kernel+bounces-37824-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59FBC83B619
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 01:34:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F6E01C22363
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 00:34:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A8FBEA9;
	Thu, 25 Jan 2024 00:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="C+9SZWnS"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D9AE62B;
	Thu, 25 Jan 2024 00:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706142835; cv=none; b=uJY7UphlUhUhAfk5oaFpVsD/gjSNhI5VvlG6dHrVmTmnsM+z6FYs+4TB8oJ3ZqsMkZqfeflDCnfEBkowUeV/Umx7GvavB9e5xfI6JearkbIEgGM9LaaK4uMbtDjBNtqZZaX6XdO6S44lsVuGldwoDsuk7qiwaU+HE8KpvHK4zMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706142835; c=relaxed/simple;
	bh=VlUFiFKANzH5XTYPF9DZ3GcQtYy4aKlKIL71NaTZ3HE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oVgIjMhy86V+76bjijZKa4uzjt9KD0LF6DNe0d9Td1lEsF+YwBNkbR5m9oZosyN1QoewmCYKMwbpfCrMYRQwZfMVCfRPp830+KUc4YgAQuy0Q7yV6n/5bUc4K0NECWdZtvkFCnAoRe4Wndlc/lA5Z6xLeviebAvkgLVGrMBZg+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=C+9SZWnS; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1706142828;
	bh=E648+W+X9N7+DnPy6fA/Cr+MHbMYJCW4iZrz/S0GTeU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=C+9SZWnSl4uElwrb/T1oXus3N8LdUB2m+FH3TKf/NHQ4+Z4m31eJT6bF3kV+KR4tQ
	 Wfj31nKqWhlm6apDJec2B9ta/4HoewFksAdNENAmmNRmkP3r04IEjgdx7jk07CQxGs
	 L7IkN+UB4qW77+wGRTc8U5g1MWlAVcezwO4b9OSrSDP0NCTCg2o4RQ0S6EwmHfWOFI
	 MeZhVexY3hv/8w8Ib5JKYxMrjzhAZ3CVGOLo2Lb3jXk9ZRaK9q8dcuPEV4pIW2hNCH
	 +RneezX+MTFHFHjfLTYkWXylRJ/uMuL6+4/xvri8fpnts+F8qF2aakFmpPN4K/ufsr
	 Ej5JR0tjVo/Pg==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4TL1yy5xv1z4wbh;
	Thu, 25 Jan 2024 11:33:46 +1100 (AEDT)
Date: Thu, 25 Jan 2024 11:33:45 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Dave Airlie <airlied@redhat.com>
Cc: DRI <dri-devel@lists.freedesktop.org>, Badal Nilawar
 <badal.nilawar@intel.com>, Rodrigo Vivi <rodrigo.vivi@intel.com>, Linux
 Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>
Subject: Re: linux-next: build warning after merge of the drm tree
Message-ID: <20240125113345.291118ff@canb.auug.org.au>
In-Reply-To: <20240105174745.78b94cb5@canb.auug.org.au>
References: <20240105174745.78b94cb5@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/CfWWVmfh9DcKFJxP2bE3FfP";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/CfWWVmfh9DcKFJxP2bE3FfP
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Fri, 5 Jan 2024 17:47:45 +1100 Stephen Rothwell <sfr@canb.auug.org.au> w=
rote:
>=20
> After merging the drm tree, today's linux-next build (htmldocs) produced
> this warning:
>=20
> Warning: /sys/devices/.../hwmon/hwmon<i>/curr1_crit is defined 2 times:  =
Documentation/ABI/testing/sysfs-driver-intel-xe-hwmon:35  Documentation/ABI=
/testing/sysfs-driver-intel-i915-hwmon:52
> Warning: /sys/devices/.../hwmon/hwmon<i>/energy1_input is defined 2 times=
:  Documentation/ABI/testing/sysfs-driver-intel-xe-hwmon:54  Documentation/=
ABI/testing/sysfs-driver-intel-i915-hwmon:65
> Warning: /sys/devices/.../hwmon/hwmon<i>/in0_input is defined 2 times:  D=
ocumentation/ABI/testing/sysfs-driver-intel-xe-hwmon:46  Documentation/ABI/=
testing/sysfs-driver-intel-i915-hwmon:0
> Warning: /sys/devices/.../hwmon/hwmon<i>/power1_crit is defined 2 times: =
 Documentation/ABI/testing/sysfs-driver-intel-xe-hwmon:22  Documentation/AB=
I/testing/sysfs-driver-intel-i915-hwmon:39
> Warning: /sys/devices/.../hwmon/hwmon<i>/power1_max is defined 2 times:  =
Documentation/ABI/testing/sysfs-driver-intel-xe-hwmon:0  Documentation/ABI/=
testing/sysfs-driver-intel-i915-hwmon:8
> Warning: /sys/devices/.../hwmon/hwmon<i>/power1_max_interval is defined 2=
 times:  Documentation/ABI/testing/sysfs-driver-intel-xe-hwmon:62  Document=
ation/ABI/testing/sysfs-driver-intel-i915-hwmon:30
> Warning: /sys/devices/.../hwmon/hwmon<i>/power1_rated_max is defined 2 ti=
mes:  Documentation/ABI/testing/sysfs-driver-intel-xe-hwmon:14  Documentati=
on/ABI/testing/sysfs-driver-intel-i915-hwmon:22
>=20
> Introduced by commits
>=20
>   fb1b70607f73 ("drm/xe/hwmon: Expose power attributes")
>   92d44a422d0d ("drm/xe/hwmon: Expose card reactive critical power")
>   fbcdc9d3bf58 ("drm/xe/hwmon: Expose input voltage attribute")
>   71d0a32524f9 ("drm/xe/hwmon: Expose hwmon energy attribute")
>   4446fcf220ce ("drm/xe/hwmon: Expose power1_max_interval")

I am still getting these warnings.

--=20
Cheers,
Stephen Rothwell

--Sig_/CfWWVmfh9DcKFJxP2bE3FfP
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmWxrGkACgkQAVBC80lX
0GwQKQgAnYX/KC3T2ez2yjBvF6mdwNZVXqMijYMGfqrFSKVlZYqtgks6bEbB+hod
RLl2fur8BmN4ZVuKs5PgwCxvXiOo62kuMlXh+2ZepBlW/fGqa5MVMClgAqH8Zi7U
DuQlPnaFHexBKvXH91EPHIPD+MYcTlMARH/OlOYeQOEK7U2BUzGaCY7coFzBpzml
U2RCzNKn6U9wnLskiYJYj5E39mbuWEQR+7yhtgFMmVAV94fPed3XbtimWX21rb+M
n0UoHwoIrOmj0cN8i8Ks2oHhJsHPluAaGo6tEEC4p84/38P+IQzTa91UquWnkXJD
cIe/jhgLjuuLMbZyZGFAt4FG0qhkug==
=iqyx
-----END PGP SIGNATURE-----

--Sig_/CfWWVmfh9DcKFJxP2bE3FfP--

