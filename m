Return-Path: <linux-kernel+bounces-37211-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 42AEF83ACA1
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 15:59:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE31A29E134
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 14:59:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DDF641745;
	Wed, 24 Jan 2024 14:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NuZ8QmMh"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFE35747A;
	Wed, 24 Jan 2024 14:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706108373; cv=none; b=jlD2vp8tY32hyJVf5sIQ8tJDMuLD9rDs7wH/JfNUJhZOaEi34Y2n1lFxjSOv5mCkTe0OFwp5LRaNNRo3DoaPdbSxgk0Ha+M+/R2tXmByFMDrzQlIfq/AONVvvfZ3yx0n37wCqB0lYMI3awsVoPmU3B45HN+abXjXm7YtCp1wnzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706108373; c=relaxed/simple;
	bh=mQX8DybNDvtTD7Nup5eK6kH6t/XOvTabhBOUYwFOo4U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SxvFdnx/zCBaJjE2BJ4K8LWZcgwHt1T+PNu+jp+MA7OjCHkhcQMrWzqQuvPV9OijFnIdN76o3I+b+/hKuB+IGpeKJFzixEnvhR82Acv2y2kZGBR4/y2OBi0ggzkJ5MqZWLMVHW5YSGcjnFMszrcBTzI4XWZByV2s56jxDqPDk40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NuZ8QmMh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BC43C433F1;
	Wed, 24 Jan 2024 14:59:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706108373;
	bh=mQX8DybNDvtTD7Nup5eK6kH6t/XOvTabhBOUYwFOo4U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NuZ8QmMhiN671TRNUiYJ3XpiFzKtt2BdruF7nkBLdgfBdkc/KCxqcm1eyNt0vk5nG
	 URwZrZvh0550YeVU5mqYPUDgDTgWn4ktYHF0U6nge3j86IG+PPIY40tYEppM5N9LSr
	 s1ZqtwRC6cjTYX+l6tsvF5monjIdQ6vstwX74cZ9GP5nMjFo+6hRxE7dKhe/d4VO/A
	 uuFMglQsv13pvR4vyUh+lYl3pZXA44rIb2dRVux6LUm3eTL+i51yvkXXIMHK3ZVf+3
	 4tlz33A8VSZmYpUYqW3ibET/8xl/hyuxrPDz3UXji2MDs/yJngg6hZKxwBlYMUkLzr
	 dXMPF5EuCCM7A==
Date: Wed, 24 Jan 2024 14:59:28 +0000
From: Mark Brown <broonie@kernel.org>
To: Jonas Gorski <jonas.gorski@gmail.com>
Cc: Guenter Roeck <linux@roeck-us.net>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Herve Codina <herve.codina@bootlin.com>,
	Amit Kumar Mahapatra <amit.kumar-mahapatra@amd.com>,
	"linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH] spi: Raise limit on number of chip selects
Message-ID: <38630519-733c-4598-97a7-19a5e6306513@sirena.org.uk>
References: <20240122-spi-multi-cs-max-v1-1-a7e98cd5f6c7@kernel.org>
 <20240123120430.75c7ace0@bootlin.com>
 <cefafa30-b78d-471b-83e0-b05060d806d4@sirena.org.uk>
 <93385fc2-7596-4f66-b0c1-07d7d5c9ed8d@csgroup.eu>
 <49b52941-6205-48bd-b2ae-e334018ac5cd@sirena.org.uk>
 <CAOiHx==FzSyyqP3NzLTeOSVxUQYy3ZhypZrDLsc-OjGCdSzvUA@mail.gmail.com>
 <801eecbe-4bf9-4bb8-9de0-1a7ca6673ddf@roeck-us.net>
 <CAOiHx=mM7kpzR-MOshsgXZM+CSB0nawfWxMhpt=tuhmJyMTCzQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="U3up3TFtYv/V8tb0"
Content-Disposition: inline
In-Reply-To: <CAOiHx=mM7kpzR-MOshsgXZM+CSB0nawfWxMhpt=tuhmJyMTCzQ@mail.gmail.com>
X-Cookie: To err is human, to moo bovine.


--U3up3TFtYv/V8tb0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jan 24, 2024 at 02:41:03PM +0100, Jonas Gorski wrote:

> For some reason we don't store neither the actual number of supported
> parallel chipselects in the controller, nor the amount of chipselects
> used by the spi device, so all loops always  need to iterate
> SPI_CS_CNT_MAX times and check for the chipselect numbers not being
> 0xff instead of limiting by the (possible to know) actual number of
> chip selects in use.

Yes, we really can do a lot better here if we keep a bit more data
around.

--U3up3TFtYv/V8tb0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmWxJc8ACgkQJNaLcl1U
h9D6LAf/dKoXrvJDfpSrT4W9m+K05QQbrpK+vBrXnoQfnSRPB6PhUHDrgZEHfOHC
2gewO4lWzvu974wpl2oilNc6y68hYT7Vhxw/PuYg7ML+SO3pnhoTvEYqwaaz11+o
TTf+2VlXzjHRHtB4vKZDV3DtNhZZ/keiVIXeNmSkr6e3zBnQoAOZIfBe/+i6cDoS
aF03gP7NzVqJgQ142eWIQfp5BdHqw31p0nKeNrY/mzHCif2F7Qdv4o2Vrfmary90
/mcrWWxf05lsckAp2A4JHZeSWgQxw0LXt96q4CQfq71CHcn4E9xtYbXbW17JJZUt
Kw+M0M793MlQUjjgskoPo+jXC+M4gw==
=M4HS
-----END PGP SIGNATURE-----

--U3up3TFtYv/V8tb0--

