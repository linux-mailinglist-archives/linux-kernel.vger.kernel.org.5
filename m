Return-Path: <linux-kernel+bounces-85073-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BFF7286B007
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 14:11:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4589DB22125
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 13:11:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 210CC14AD2A;
	Wed, 28 Feb 2024 13:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Po7ZPwfv"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D32D73508;
	Wed, 28 Feb 2024 13:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709125885; cv=none; b=p+1/iSHlQH8ec+n40Vt6EoeP+lDotX4OS+yl9Uhqk1rHRYCupyolZfEFu43kA11zUPNgGn7ub7gBxAwK0oJQ/Lbhbv0Q30C/ALHBe/fL8pW3bIAZuYMUAVILPJe3oEo3jLUdtSt/NgBmBfrxOwWJb25FvYZfuEgR6B+Q3lx/KPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709125885; c=relaxed/simple;
	bh=Xj8EuxFWN9yWECWHne5mCLKQf6uk+6VYl9cSrXqZ2lE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rk4daoMdhSA4uEMhz6gLb8EY7lSLdHFK6gKlbw9MI3RtcpT6V8pcCbYXcxUWLW4NJ8jVhKcdCTkrRZAAV+pa0LpRg34KvEywCs81n6gSpb2OY4omc1MydyifTzPkzTBmIoEpGY1PZ+Odqbovu4qfAD0pYhWr5DPUC3GuUfJqjXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Po7ZPwfv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AF02C433C7;
	Wed, 28 Feb 2024 13:11:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709125884;
	bh=Xj8EuxFWN9yWECWHne5mCLKQf6uk+6VYl9cSrXqZ2lE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Po7ZPwfvySba+AeNsJuOm5+QMAB4zjaBoTyIvAbi5oz7V0ytPJrX+e5SPQy5YfKGq
	 zgjnUKd6/nDgtYFi0J7GS5gD8YH4gw4tjfBuHrdMU/PW5St15WlEFL1lwDp1EXIF9d
	 ty7leMM2OmP7PHD89zd2U1ex43psr6R+ng6py2DutdyNBprDDqo2zQtb6VrkJPVNz7
	 bwsVVyhwO2gfmxPai4q0CNjQ8VIQu7HBnMrrvBX/dbuTn5ceAt+/fhXgCT8y7NwS3+
	 Xha1j0XQxeHdAv4n6PtiwvmSjbRSjry/YEbBRcqBVHbQz/+7rsIvbpSa/Vf3Yka6vo
	 DOavp8673jFAw==
Date: Wed, 28 Feb 2024 13:11:19 +0000
From: Mark Brown <broonie@kernel.org>
To: Badhri Jagan Sridharan <badhri@google.com>
Cc: gregkh@linuxfoundation.org, linux@roeck-us.net,
	heikki.krogerus@linux.intel.com, kyletso@google.com,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	rdbabiera@google.com, amitsd@google.com, stable@vger.kernel.org,
	frank.wang@rock-chips.com
Subject: Re: [PATCH v2] usb: typec: tpcm: Fix PORT_RESET behavior for self
 powered devices
Message-ID: <e37a37aa-a3de-439e-9c20-5216c2f316f7@sirena.org.uk>
References: <20240228000512.746252-1-badhri@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="UfQke8IVrbpWjEqo"
Content-Disposition: inline
In-Reply-To: <20240228000512.746252-1-badhri@google.com>
X-Cookie: Function reject.


--UfQke8IVrbpWjEqo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Feb 28, 2024 at 12:05:12AM +0000, Badhri Jagan Sridharan wrote:
> While commit 69f89168b310 ("usb: typec: tpcm: Fix issues with power being
> removed during reset") fixes the boot issues for bus powered devices such
> as LibreTech Renegade Elite/Firefly, it trades off the CC pins NOT being
> Hi-Zed during errory recovery (i.e PORT_RESET) for devices which are NOT
> bus powered(a.k.a self powered). This change Hi-Zs the CC pins only for
> self powered devices, thus preventing brown out for bus powered devices

Tested-by: Mark Brown <broonie@kernel.org>

--UfQke8IVrbpWjEqo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmXfMPYACgkQJNaLcl1U
h9Clpgf7Bv0grlrW3jX1qnS+UbTteZ7elh4iJkdfAFc4Srw31/v5yp2Io/789e++
3ny0IgdFN1nKAxnq1a/NZXDAJOAvBxw62zzgtZid+pny3J5j5iDm6ONupYkBv0qb
wg8p5wk1eU7FVUz5fSI2w8Cxl7Vf9+WlyOiYZwIy3Ejd+De4ogsbJZcKNvgRXLwO
C65oNKRC8jWOS5lNdXw0yz3U0x7cXN/YqqSrexiBJiDnJYwtfUSqy0XBu6hQeaC3
MPKW2uz014IJ0cP1myP0fKzB60GqvB5U0qq9F5+O3vH12Bz8EDxMZ6hfAqdzOv+o
Qq4P7A296GUD21LD3N+7TUgJ5mcj1w==
=OGxf
-----END PGP SIGNATURE-----

--UfQke8IVrbpWjEqo--

