Return-Path: <linux-kernel+bounces-144441-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E43C88A4678
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 03:13:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 218DD1C21696
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 01:13:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09071EEBB;
	Mon, 15 Apr 2024 01:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bwhSXh2g"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4844C33CA;
	Mon, 15 Apr 2024 01:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713143601; cv=none; b=UsCeqBVowNJ+WFg539dEFnh2ZRUbpkzcp5bLLCYWiCdkJWc98zrrMVkUjCoP750aWithT0gbldpFZxi0vYNwR0cG3fvxdcTaQ275k/CZfsbNyh76ilDcbeEadqWUsZVJF6nmNgqwKri2/Np8Lt21u+p5ZXcObcdfP+lHUdr0F7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713143601; c=relaxed/simple;
	bh=QRBzG3k475rXC32yv9vHf4vG7lInQufvLEzE9qpSQEw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nbK/R8bwe5H90dVbMk4BglF6i3mrr0Y3vx7gNaMb94qDuAv35pD5NsMTeYRqxQiVnnAVDfs16wo1iw/NioKvnUIAJOyyz1jba7RhQEW04eOYNTInSwDHBG6azFaRpcoJEUOpzvUBvFtYGPKVQzsZCKbPOcP5WMyV40cWKjBQqM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bwhSXh2g; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63A01C072AA;
	Mon, 15 Apr 2024 01:13:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713143600;
	bh=QRBzG3k475rXC32yv9vHf4vG7lInQufvLEzE9qpSQEw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bwhSXh2gUy3hh3ei04ol69noq6VmNnbQbXrJzf74rTDD4RtAJb+ofkL0Urlfc67RC
	 L2fBgjBnYp1ON7YywmkrVeonITTxym/imgSZzUq9IsMYc9/F5gwW+aeaWJf5d37IcQ
	 amZLCWirB+EfrbBJkECe/UH3zMF6uhEx5gWEDH+SjJiLzqOGngC6c2Js4jDAFKH3+J
	 tAqZGXPRPAlrwBnT9OdiTXSwtDg4ZibbHUt/Hv1X4aWwATZ6v3Kq/pryHXmes1zYva
	 l2mDoWIMnBmVncJwDuDrdqZ2cJtxmzzsubJmWj2j1VzuUHrY9svUyuhXfW60jNwhu1
	 kimOPViQgUruQ==
Date: Mon, 15 Apr 2024 10:13:18 +0900
From: Mark Brown <broonie@kernel.org>
To: Liao Chang <liaochang1@huawei.com>
Cc: catalin.marinas@arm.com, will@kernel.org, maz@kernel.org,
	oliver.upton@linux.dev, james.morse@arm.com, suzuki.poulose@arm.com,
	yuzenghui@huawei.com, tglx@linutronix.de, mark.rutland@arm.com,
	ardb@kernel.org, anshuman.khandual@arm.com, miguel.luis@oracle.com,
	joey.gouly@arm.com, ryan.roberts@arm.com, jeremy.linton@arm.com,
	daniel.thompson@linaro.org, sumit.garg@linaro.org,
	liwei391@huawei.com, peterz@infradead.org, jpoimboe@kernel.org,
	ericchancf@google.com, kristina.martsenko@arm.com, robh@kernel.org,
	scott@os.amperecomputing.com, songshuaishuai@tinylab.org,
	shijie@os.amperecomputing.com, bhe@redhat.com,
	akpm@linux-foundation.org, horms@kernel.org,
	rmk+kernel@armlinux.org.uk, Jonathan.Cameron@huawei.com,
	takakura@valinux.co.jp, dianders@chromium.org, swboyd@chromium.org,
	frederic@kernel.org, reijiw@google.com, ruanjinjie@huawei.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	kvmarm@lists.linux.dev
Subject: Re: [PATCH v2 5/9] arm64/cpufeature: Use alternatives to check
 enabled ARM64_HAS_NMI feature
Message-ID: <Zhx/Ltwvue04nW7g@finisterre.sirena.org.uk>
References: <20240411064858.3232574-1-liaochang1@huawei.com>
 <20240411064858.3232574-6-liaochang1@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="9q7t9ccwc0LV/xs5"
Content-Disposition: inline
In-Reply-To: <20240411064858.3232574-6-liaochang1@huawei.com>
X-Cookie: You might have mail.


--9q7t9ccwc0LV/xs5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Apr 11, 2024 at 06:48:54AM +0000, Liao Chang wrote:
> Due to the historical reasons, cpus_have_const_cap() is more complicated
> than it needs to be. When CONFIG_ARM64_NMI=y the ARM64_HAS_NMI cpucap is
> a strict boot cpu feature which is detected and patched early on the
> boot cpu, which means no code depends on ARM64_HAS_NMI cpucap run in the
> window between the ARM64_HAS_NMI cpucap is detected and alternative is
> patched. So it would be nice to migrate caller over to
> alternative_has_cap_likey().

Just squash this one in as well.

--9q7t9ccwc0LV/xs5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmYcfy0ACgkQJNaLcl1U
h9B2fAf9FLOSU6IhdUrWK/jKkcubngbRQsfAVjBlRciZ9QqfohnuVIPnytzHSJCA
FH/zUfJdMJoJjHH7+v055lX6TtFdDGZYWMzTKkg+CpOpCZs65yAWsIM6aRJoWhwP
I2NRfsaxPSOGN2bz+OUggreon4SCxL7LlaGataZmzW94d6c/wc6mxdjb+N5UJnKB
S7CdKWHTWRuNmHzaRWx78D5uIcbeoGQep++o2BXUYTONl/jBojVlPduzc69QKcK8
SOJm8Shk6orS2Blfpf3po/NGkIHByWiNW2DoYPKhaTSa8KGQvDllDF9dUYFnJXR2
77f1kMmKOmOqRF2NX6mqtJ/swneqXw==
=2WWQ
-----END PGP SIGNATURE-----

--9q7t9ccwc0LV/xs5--

