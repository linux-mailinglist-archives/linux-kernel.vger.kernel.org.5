Return-Path: <linux-kernel+bounces-129464-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 60B05896B2E
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 11:57:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 19E7B285FA5
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 09:57:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FB1B1350EA;
	Wed,  3 Apr 2024 09:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H52yBD/o"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AE30134CEF;
	Wed,  3 Apr 2024 09:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712138228; cv=none; b=jiC5RXRfF1jCP4PYk9Pw98s/0s54oVuyB4mXYn9LX2Dbaj8KRffZGkhOUFAA3/Cgm5kOwuJOZdyJ9bv8pgzX3XprqVd/68Aiek309mEaB1q60AcOHYc5iUrtjXyedys7OJjaude8C9Us8k/lXFvsrmCp/pNB4GddIgdBRcXoEpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712138228; c=relaxed/simple;
	bh=yZYytTinisqpzLNXxsyWEElac0TTqo3wIB7P02Fmsjs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IJe/Fy1gyveQ15hE4BU/InJjm+NwBdaQaYh7gcnB/cqWoBWxmYUUxlfDsbMbdESkFaQ0ezdCg5tTzvUdRjJkc7IT5gQhwxn+RKgTxr+Ak4OWIj67DJ9g+gdZ6PXmLu8ilgvFutbPtCzZZyFIj7p9laR2YxueWiqt1yLkZoV5sRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H52yBD/o; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AAE2BC433C7;
	Wed,  3 Apr 2024 09:57:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712138227;
	bh=yZYytTinisqpzLNXxsyWEElac0TTqo3wIB7P02Fmsjs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=H52yBD/o59I6Zxhl+3rrnoywYTWel7t/9YLYSciyj2ErL7IVQC1V5Is0Bbxo/OX+r
	 RUcLBn1uWiu0tNOVCpkvrFtSUwGoNZvBEkILPOC66VaXBj/pM8VA/LQEAVwmGuEqQk
	 TncUvP+kMrwGV1Ef2vM8FTC6QE9yKSVntpaWoMXDW6YDd+Im1mSe+Xy549sCuJOxRJ
	 uSLeyEAS72Z4LesyS+H9p+m59Xi7ui7Jzeup2LyItvxjIRh250MVBEWvRe5mhLrUqn
	 jh10tgLHEx8GNaJCZCY9WURAJ7HV1AmdTD/TDrtCYydX5LRteC+D82AQ+u+oeU428S
	 GXO9o5SFrVfnw==
Date: Wed, 3 Apr 2024 10:56:58 +0100
From: Mark Brown <broonie@kernel.org>
To: Arnd Bergmann <arnd@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Kevin Hilman <khilman@baylibre.com>,
	Heiko Stuebner <heiko@sntech.de>,
	Andi Shyti <andi.shyti@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Arnd Bergmann <arnd@arndb.de>, Jerome Brunet <jbrunet@baylibre.com>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	Li Zetao <lizetao1@huawei.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Rob Herring <robh@kernel.org>,
	Yang Yingliang <yangyingliang@huawei.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Luis de Arquer <luis.dearquer@inertim.com>,
	Tudor Ambarus <tudor.ambarus@linaro.org>,
	Sam Protsenko <semen.protsenko@linaro.org>,
	Peter Griffin <peter.griffin@linaro.org>,
	Jaewon Kim <jaewon02.kim@samsung.com>, linux-spi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-amlogic@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org
Subject: Re: [PATCH 31/34] spi: remove incorrect of_match_ptr annotations
Message-ID: <b4418ac1-10ba-4932-be6e-93282707024f@sirena.org.uk>
References: <20240403080702.3509288-1-arnd@kernel.org>
 <20240403080702.3509288-32-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="+6uAnWE1dyHfAv+S"
Content-Disposition: inline
In-Reply-To: <20240403080702.3509288-32-arnd@kernel.org>
X-Cookie: Knowledge is power.


--+6uAnWE1dyHfAv+S
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Apr 03, 2024 at 10:06:49AM +0200, Arnd Bergmann wrote:

> These appear to all be copied from the same original driver, so fix them at the
> same time by removing the unnecessary of_match_ptr() annotation. As far as I
> can tell, all these drivers are only actually used on configurations that
> have CONFIG_OF enabled.

Why are we not fixing of_match_ptr() here, or at least adding the ifdefs
in case someone does end up wanting to run without OF?

Just as a general thing for something like this where the patches aren't
expected to get merged together it makes life much easier to not send as
a series - pulling individual patches out of a series causes issues with
things like b4, especially if you have to apply them to multiple places,
and there's limited benefit.

--+6uAnWE1dyHfAv+S
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmYNJ+kACgkQJNaLcl1U
h9BrIgf+KtKoHOuMwPZ/0TAaTDSHlNChGQoUvbI8FkIcWUSbFcdmddBluNJsBwf9
vG9Z055MnGBd2N5UEcbqyUYg7FV/Gw5zAnpUf7Uw3hRVNoeKYIBo3YbxjiVdNSPB
QLev8bG5eM480xbTSKBU+/sD0GDux5FXgUVuSlScuOpm3lsfaP4yKmpM728DTVXq
8HW0wQRYPH8UY2HHR9FFNkWBW2kqr765cMEKV71YPNrbCNm3OZSBtRPOZR3TrB2W
AQYdrobav7Rzvkgi/ipXtP7qi0SqyO+EmYrpZ+gYnZeLWM88diZubUXpK706D/jZ
zZRjPxohDdn5nVmaw8mYraHIFXciuQ==
=qYyn
-----END PGP SIGNATURE-----

--+6uAnWE1dyHfAv+S--

