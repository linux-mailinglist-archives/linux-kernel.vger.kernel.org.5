Return-Path: <linux-kernel+bounces-136869-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EE7289D93B
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 14:29:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 28A5E283D99
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 12:28:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 817E312D210;
	Tue,  9 Apr 2024 12:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ErMHuHY5"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3F2C1272B2;
	Tue,  9 Apr 2024 12:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712665733; cv=none; b=UchXxoGNuCUW79ddnLwBYXfqMzI0op/0a4N7jaoMi/AupltjiCecTMIIx+j31bQVNDjUm+/QiGeFBT14U6SwvFt63+T2sVF7JkqfOusaUmwfIU7y2mv4mUnbtlVgtbz1n1cYmRKfYcNgN5UlOe6IUqpTcLVtTP4EHTzZIopj5Pk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712665733; c=relaxed/simple;
	bh=csEe0DfLDPV5CaaZIRbVodH4Vmp5Xy0oCrThn/A6c8k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JAU9UeliJ5OfP+ihzCUEJV6oQy6In+hbJSCg4rfcGrwXVB3rUSRUSqN34yuxkilgUi+PT8io0v+B+MYBTbvEhXaEut1wMfo/qX82MjHUeCoelNJ4fITqO0d1yMIedkPxBXtF95LL95FnG0lGk+Y4pvZfj2chitm6Wh7dM39uVcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ErMHuHY5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A0C8C433C7;
	Tue,  9 Apr 2024 12:28:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712665733;
	bh=csEe0DfLDPV5CaaZIRbVodH4Vmp5Xy0oCrThn/A6c8k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ErMHuHY5IA6fjFu8AS1z7PfJmaZbZUO1TTkgjqQA+ZUw7ZRB+Rj4jOz3LRSSxS/Yq
	 Cd/VtxRVGEaJJG2NmAYIe599HVWPbXw/+iNzh24JUp9L6Uc7C2X6CZdm7XcQBvVdN8
	 mmcWyP+TI3bB4xjFGqUd1pmuiEwBvHg4b/ZjEdWq4lrR2ccXvhXeG9CTafyT6Prxix
	 KDexim+1aK9ZYzK/sU2/J53d4Th5huRE5K8cVsSlJv/WOR6MNgMuOfHBaDMX1r/a98
	 i3N1a0mg2e6guLS2P32NdZ1Z6GvjvCof1ZxuLt1QkYnptR6QT1/zoyOu1j6rGtwTwr
	 ZeuIRrecRqwKA==
Date: Tue, 9 Apr 2024 13:28:42 +0100
From: Mark Brown <broonie@kernel.org>
To: Liao Chang <liaochang1@huawei.com>
Cc: catalin.marinas@arm.com, will@kernel.org, maz@kernel.org,
	oliver.upton@linux.dev, james.morse@arm.com, suzuki.poulose@arm.com,
	yuzenghui@huawei.com, tglx@linutronix.de, mark.rutland@arm.com,
	ardb@kernel.org, anshuman.khandual@arm.com, miguel.luis@oracle.com,
	joey.gouly@arm.com, ryan.roberts@arm.com, jeremy.linton@arm.com,
	liwei391@huawei.com, daniel.thompson@linaro.org,
	sumit.garg@linaro.org, kristina.martsenko@arm.com,
	jpoimboe@kernel.org, ericchancf@google.com, robh@kernel.org,
	scott@os.amperecomputing.com, songshuaishuai@tinylab.org,
	shijie@os.amperecomputing.com, bhe@redhat.com,
	akpm@linux-foundation.org, thunder.leizhen@huawei.com,
	horms@kernel.org, rmk+kernel@armlinux.org.uk,
	takakura@valinux.co.jp, dianders@chromium.org, swboyd@chromium.org,
	frederic@kernel.org, reijiw@google.com, akihiko.odaki@daynix.com,
	ruanjinjie@huawei.com, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, kvmarm@lists.linux.dev
Subject: Re: [PATCH 1/9] arm64/sysreg: Add definitions for immediate versions
 of MSR ALLINT
Message-ID: <5d06c9d8-a903-4cd9-be08-d7681e7928be@sirena.org.uk>
References: <20240409012344.3194724-1-liaochang1@huawei.com>
 <20240409012344.3194724-2-liaochang1@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="tp/u02Ht/rALrZN+"
Content-Disposition: inline
In-Reply-To: <20240409012344.3194724-2-liaochang1@huawei.com>
X-Cookie: Everything you know is wrong!


--tp/u02Ht/rALrZN+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 09, 2024 at 01:23:36AM +0000, Liao Chang wrote:
> From: Mark Brown <broonie@kernel.org>
>=20
> Encodings are provided for ALLINT which allow setting of ALLINT.ALLINT
> using an immediate rather than requiring that a register be loaded with
> the value to write. Since these don't currently fit within the scheme we
> have for sysreg generation add manual encodings like we currently do for
> other similar registers such as SVCR.
>=20
> Since it is required that these immediate versions be encoded with xzr
> as the source register provide asm wrapper which ensure this is the
> case.
>=20
> Signed-off-by: Mark Brown <broonie@kernel.org>
> ---
>  arch/arm64/include/asm/nmi.h    | 27 +++++++++++++++++++++++++++

You've not provided a Signed-off-by for this so people can't do anything
with it, please see Documentation/process/submitting-patches.rst for
details on what this is and why it's important.

--tp/u02Ht/rALrZN+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmYVNHkACgkQJNaLcl1U
h9AMewf7BGhHshYucChT7VqSKvlOMDQSdvP978X26I7soUUjqGhKazks5r+3KXG1
W6fSrfRGv//m7kHW9cALoJ0NI9L/fXxBM7blrjW0fM3KdLwzA+q/UW4wBxi9B1v7
tFLtRVlwJKvdoODsVctC+fZqYodrGZZlROq5l6JwbzEKBISH9ON9J9H/Hn7uygnU
33DuT0t5IdyQMRYDpksaLZgmDxY9IfUQpfYl9E9fPBgOugytXuUkaK0H/DX7grZV
/4VrhwkMaVfv4/nDAWpS4SnUqdpKTfZQFBB/LTcY7YSmOobctXNCf8fPRx56dnpD
9Ffj0HfMJOP2wdEeZIgF44nRzCYcUA==
=BFwd
-----END PGP SIGNATURE-----

--tp/u02Ht/rALrZN+--

