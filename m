Return-Path: <linux-kernel+bounces-81466-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CEC2986764F
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 14:19:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0BC761C259FD
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 13:19:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87ADC127B75;
	Mon, 26 Feb 2024 13:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FirmsD5y"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5B55604B7;
	Mon, 26 Feb 2024 13:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708953560; cv=none; b=BtaVj6yXPhvECPtLW1vFsiIwMHIfjhynVpBH2Gdmg9pJL+fZsZ4gd6HcACQkIrVTgMU+iWe1Ey/b1/JeArqPeUv3CCyXvj1tXuOxzRAYoYJ8gwMxRRIUFY46nu7ctOmuxJvr1YkHIIv3Gn1BLEjTC5k/is82ur8KMYGwc7SgxME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708953560; c=relaxed/simple;
	bh=nwvYToj4tK8h4aFkhpKL3qQBjVSFtITgUTaEQBe0SPk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PUDDiNstpBb6CkV7n+p5oRnpsjdqTfEGleew87jwO93qUi8YAWLK5q90M4gLdeKBWWaBmAOXJBBG8OP+6THNRKNuQYER2bf8mqZhjLhZIaPlQhaefZCtUnakhheTroaHydxaHAb11Bemy9hcmpnRcP9KfTPgNKLhkq+c/TGfExI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FirmsD5y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94169C433F1;
	Mon, 26 Feb 2024 13:19:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708953560;
	bh=nwvYToj4tK8h4aFkhpKL3qQBjVSFtITgUTaEQBe0SPk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FirmsD5yWi3a8dJmiXnybB/1+NvNUZyHiBXXAvr+TZJ5ybcoFj3pSaOef+2iQGBG7
	 olYe4LNM6okoBZMdKmQVmmEI/pNyEZPyeqP7H4E+gqr4UlHlFk5VrmEDuXoNif54Wb
	 04MPV2ygX4eydGN/3tLaTmpVjqUG3Co3uK29mFXnS+s8ot6iSdNGbr3YnHUf0kfcCc
	 SbfcJTTq+hxSDV8+5QbABi0Zd1beZnSbfOEALSz09NopuyJCy7r2zanSGp43KtTkrw
	 2SBgVB/YKxsdd3RZ4FkXa8bJNuu4opyRjG6Kw90IKbOUMHuTiwmTgSlr26Q9ANzMLq
	 oWmwG3G0IYxJw==
Date: Mon, 26 Feb 2024 13:19:12 +0000
From: Mark Brown <broonie@kernel.org>
To: James Clark <james.clark@arm.com>
Cc: coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
	kvmarm@lists.linux.dev, maz@kernel.org, suzuki.poulose@arm.com,
	acme@kernel.org, oliver.upton@linux.dev,
	James Morse <james.morse@arm.com>,
	Zenghui Yu <yuzenghui@huawei.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Mike Leach <mike.leach@linaro.org>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Anshuman Khandual <anshuman.khandual@arm.com>,
	Miguel Luis <miguel.luis@oracle.com>,
	Joey Gouly <joey.gouly@arm.com>, Ard Biesheuvel <ardb@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>, Helge Deller <deller@gmx.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Arnd Bergmann <arnd@arndb.de>, Ryan Roberts <ryan.roberts@arm.com>,
	Vincent Donnefort <vdonnefort@google.com>,
	Fuad Tabba <tabba@google.com>, Jing Zhang <jingzhangos@google.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 2/8] arm64/sysreg: Add a comment that the sysreg file
 should be sorted
Message-ID: <169b5402-296b-4abf-a16e-91c8136b07b3@sirena.org.uk>
References: <20240226113044.228403-1-james.clark@arm.com>
 <20240226113044.228403-3-james.clark@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="hQM5XUqnFPuKrugQ"
Content-Disposition: inline
In-Reply-To: <20240226113044.228403-3-james.clark@arm.com>
X-Cookie: Walk softly and carry a BFG-9000.


--hQM5XUqnFPuKrugQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 26, 2024 at 11:30:30AM +0000, James Clark wrote:
> There are a few entries particularly at the end of the file that aren't
> in order. To avoid confusion, add a comment that might help new entries
> to be added in the right place.
>=20
> Signed-off-by: James Clark <james.clark@arm.com>

Reviewed-by: Mark Brown <broonie@kernel.org>

--hQM5XUqnFPuKrugQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmXcj88ACgkQJNaLcl1U
h9BtPwf9H0CYN9WeUJLHshidBanivRlWXV+6pi5mcj5wglZ+m+DP3iUCuV+uGGPI
d/e/5rhuYnECx10QIsvxwKNPIUQ7KAhBK82h0CFn7QWFa6A7V5DeAJFcliw6Ndwb
whWAR58k22YJSNqTLmszKjNj3sfuVBDEEIC6xRdlrkL1lzfD6TR/47wcFwOMh/jf
k95T9U6DrzEIIREHpnxWViky7tj/ACReR+JJA2VOMARqsZnXKlN7S+OexIT4RBWy
nS/qhh6GHVuZI7tBtZLhHVkUxhFTQUHNJEaMGq8xmurBw12kXw9cDR7yDGlSl02I
s+c6xrkGb9+NrWCAyQ/h2vulVuTnYw==
=iZ3b
-----END PGP SIGNATURE-----

--hQM5XUqnFPuKrugQ--

