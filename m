Return-Path: <linux-kernel+bounces-121362-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CFC288E6BE
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 15:43:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C4AA52CA0A4
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 14:43:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42B1313B78A;
	Wed, 27 Mar 2024 13:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="vjI3iv3S"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E2BC13B789;
	Wed, 27 Mar 2024 13:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711545910; cv=none; b=LPqWnLzv/5p1lPWagJ0z5Om9nvRg7Yupdu1cyyqTqEVlW/ipnKZxXyIrXhRPzlKTVsqdjldbQHIhgAmuZwXZAuSQUimS5o8gochk0bpzJQ3LI6h7xhCe0JkAUEHlV/11KdyID5MnCVw+cv+e/ohJdIcO6B4NHf8KDZh6OqhqhvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711545910; c=relaxed/simple;
	bh=Cz7QopLpKY1lJfT11gW+g8rJalblsCQCrjKTS6EERLQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O9wKtSlM1C/xu0AOoUFEUUCgPUTVGP2DFoza9ZCPiUFFQBII90GXUYtn4kxiWD7PlBtpvxFwPWq7WnXS2w0u0i4K9ymhPszLkSsAxqBb6pCZS1yiNRB9ULGw52GTFF+0kBp+uTdvDVc9s/Nn5lmk8dPSx4P8KwOZhXZGZmrYtOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=vjI3iv3S; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1711545906;
	bh=Cz7QopLpKY1lJfT11gW+g8rJalblsCQCrjKTS6EERLQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=vjI3iv3SkHQ+aK9ljmBZsrE9r3Yr7xxy8m9Mh+IFXtBIdJC8c7h3rga9qvmeh/kI1
	 so8XlfhrvQ+uM1sod+nVt/9WtIzVDR5uzqSoiAhC/8MHPCCCTBYd5Ym0gEbKLwUs/t
	 ovWGXE8fX87ze1UMhQDDVQpd55TpzB5QYGv7gUgTzEcBW/0zzWvh8ffWiZ7091njXR
	 0wMvw0xpVRcr8P7NDuqlyNpc9QARhBpC4DgeaHEHILAwGnREOW/W/N/tpb2cM0eW1d
	 QU92FbEJnuGSHoow9r2a6+avvwdnXsRaKEIJfb4L3cL8IVbyKYjdwGVDVIJdV73gR1
	 FvLPfQXjWXbpA==
Received: from mercury (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: sre)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id AA69637809CE;
	Wed, 27 Mar 2024 13:25:06 +0000 (UTC)
Received: by mercury (Postfix, from userid 1000)
	id 47EF810608D9; Wed, 27 Mar 2024 14:25:06 +0100 (CET)
Date: Wed, 27 Mar 2024 14:25:06 +0100
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Hans de Goede <hdegoede@redhat.com>
Cc: Konrad Dybcio <konradybcio@kernel.org>, 
	Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] power: supply: test-power: implement charge_behaviour
 property
Message-ID: <daactalkmzucga47cmncjkgnxyppouqnrj3vtsz34d5edrkmzu@p32ylpv3nqwx>
References: <20240306-power_supply-charge_behaviour_prop-v3-1-d04cf1f5f0af@weissschuh.net>
 <171148264419.185695.14027540198251584096.b4-ty@collabora.com>
 <6f0761a6-5f49-42e2-9b79-3e04c9d259a4@redhat.com>
 <9fe3d7a6-3b34-4c96-bd9f-510b41f9ab0d@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="giotfuwncs36wkgs"
Content-Disposition: inline
In-Reply-To: <9fe3d7a6-3b34-4c96-bd9f-510b41f9ab0d@redhat.com>


--giotfuwncs36wkgs
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Hans,

On Wed, Mar 27, 2024 at 11:44:41AM +0100, Hans de Goede wrote:
> On 3/27/24 11:36 AM, Hans de Goede wrote:
> > On 3/26/24 8:50 PM, Sebastian Reichel wrote:
> >> On Wed, 06 Mar 2024 20:37:04 +0100, Thomas Wei=DFschuh wrote:
> >>> To validate the special formatting of the "charge_behaviour" sysfs
> >>> property add it to the example driver.
> >>
> >> Applied, thanks!
> >>
> >> [1/1] power: supply: test-power: implement charge_behaviour property
> >>       commit: 070c1470ae24317e7b19bd3882b300b6d69922a4
> >=20
> > Does this mean that you've also applied patches 1-3 of:
> > "[PATCH v2 0/4] power: supply: core: align charge_behaviour format with=
 docs" ?
> >=20
> > Because this is a new version of 4/4 of that series and I think
> > that the new test may depend on the fixes from patches 1-3
> > of that series (which I'm reviewing now).
>=20
> Ok, I have some not entirely trivial comments on patch 3/4 of that series.
> I guess you (Sebastian) could address those while merging, or wait for
> a v3 of the series.

I can't. Patches 1-3 are already in 6.9-rc1. It looks you did not
get my replies, but they certainly have been captured by lore and
obviously Thomas got them since he send a v3 with just the last
patch:

https://lore.kernel.org/all/20240303-power_supply-charge_behaviour_prop-v2-=
0-8ebb0a7c2409@weissschuh.net/

Anyways, I think your suggestions for further simplifications in
patch 3 are sensible. They just require doing an extra patch now
instead of being squashed.

Greetings,

-- Sebastian

--giotfuwncs36wkgs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmYEHioACgkQ2O7X88g7
+pqQnw//To7k/fV34WTlIy3RJYrPP9jiW3FUJc9rqM+qICHvpglsyhiIh//Zcl9G
9CbZJ0xRXnS36ynoZhG5qsgAT3Uk4nTVN55xe/gUBMRRZoSPvoV+1L16fA+jEmpX
5OtcGotIn9Vk/J3EGrwmFn4OdnSNKV0ek8w/k8aE5W2rPeIrMddNOqxm35t4mgZ4
llaBFDrFGe8pg1MBo/h2mJkgo/62T/C5vOYe93uqtfkkwreTOBYzAkp9wJodXrmf
kq7NaSVCr92WKoYbczmSH2OV5n2YaHO1IMVWs1OJYz+EAitFP+LcttYhICBsKyhr
KMCD7jTQLggM/zIeW/gtUo6L+NsFc85ufmAo14fQYYRWnQQCv7pCLA7d7qyHLSO3
6oVKk2s3Af8UslRWPu3kQG+Kg5gR8F2IENI89s57lfwwt0qiV65EPAzJIiENplRt
fBn1rXhw5W/Jo7txIUGYvp4ggP0OYwA0hQbPhbS5qg0uNLsAHW/h/oAJleKi7qMv
HASgR7dfXZFxQ0RQRheKgfVe1qfJpUnYt/YpJPFXP9AGV9Pqc/prIMG2Lb5LdHEt
UTvr2nK2sK3tpZuRAzJ8lmVOVltOiUlZbfX8T7x0KqsK2q/JYeo0fjBkHCrp4R4q
JsmXFtYXbmXuTXD47SuBqCjO1MdTAC8A7sM1DJrmq7i17qSocrk=
=E25x
-----END PGP SIGNATURE-----

--giotfuwncs36wkgs--

