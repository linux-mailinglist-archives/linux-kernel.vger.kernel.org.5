Return-Path: <linux-kernel+bounces-50768-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CE591847DB8
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 01:23:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 82D47288DA8
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 00:23:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3BA5A3D;
	Sat,  3 Feb 2024 00:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WwmKniui"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AE7B62B;
	Sat,  3 Feb 2024 00:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706919801; cv=none; b=qikwyx1iKS9tu3teiDdQC3cOqxni/FQzdEAHdTK4J9kvwTyrd95Nx7RLVkgNYRahq24qMLcRGhmB/52eesf+Sqa4jNRGavDTczOM7F93GmnjXeQbdD+gEyAkivSUkn0GfJ7nP8QkV1vSk/+AdWkhe1xpYt6mP4sWmzdV4e6AYhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706919801; c=relaxed/simple;
	bh=b8KssQNXLzHMBGmTyMPMXV3/qG8R2A/3skS26ZNZNWQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hR6TfYCzyGxMbm6SIIo0/rEZ6cQC//6QDgqD3xddrvbwM6vC9SUNMrDos3v5Ob/W4x/BdAL3+NhlicL4RXyKYFJbvVoz74zJnLycPnGOa/tmxiR/4zcklU66hSlux2T/hotdVUODX4pnxC67NStfgE7YDMrxy5NAbarG9HV9cr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WwmKniui; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CEA1C433C7;
	Sat,  3 Feb 2024 00:23:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706919800;
	bh=b8KssQNXLzHMBGmTyMPMXV3/qG8R2A/3skS26ZNZNWQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WwmKniuixk8bh08MN/NnNODNAQwttP0ItoRyQ8SPwep76zKTUptkaEblID5IEIpRq
	 1Qn+kWnHIok+q/udSQ1ds5sgSzV2pVR+UfpQZyuLLwmn2BSuOEaszG296DSNSogNHQ
	 69UYZalTd59d1C54G5jKBNlbdx5/4PqmW6iSz3dnVzyMJspFwrIS0U8quClqI/NTvq
	 7RnQQO9z0xp2P7NU4JlcUQfAPGdJjov5J2bfhcatHljhTiB1Xd1j0UXyw7meF0rL8r
	 4yy8rgKzTion2JvLm6xxNMjqgnqCHuWLgBgTJEWVQCkY3XvCsEuhAPzec9sT+5nFpv
	 aEBy62xT3VnNA==
Date: Sat, 3 Feb 2024 00:23:15 +0000
From: Mark Brown <broonie@kernel.org>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	devicetree@vger.kernel.org, linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] regulator: gpio: Correct default GPIO state to LOW
Message-ID: <d41b0858-df3f-4002-8a51-aaf91bf3a659@sirena.org.uk>
References: <cover.1706802756.git.geert+renesas@glider.be>
 <ffb1eb1d747dce00b2c09d7af9357cd43284d1c4.1706802756.git.geert+renesas@glider.be>
 <CACRpkdaBBFjtgoUhhK8-X28BK=2NCyRS2NiYvVEZFAsQiNZH9g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="2EgFFNCMuwbml2pZ"
Content-Disposition: inline
In-Reply-To: <CACRpkdaBBFjtgoUhhK8-X28BK=2NCyRS2NiYvVEZFAsQiNZH9g@mail.gmail.com>
X-Cookie: Do not write in this space.


--2EgFFNCMuwbml2pZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Feb 02, 2024 at 06:41:31PM +0100, Linus Walleij wrote:

> Actually, Linux can read back the value just fine in output mode,
> so what about just ignoring the property and update the document
> to stop saying that about Linux?

IIRC that was there because historically the gpiolib documentation
said that this was unsupported (though the code never actually prevented
you trying I think?) and will have made it's way through the DT
conversion and refactoring of the bindings.

--2EgFFNCMuwbml2pZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmW9h3IACgkQJNaLcl1U
h9DVSAf/XLpZpBYIwHBurSvut6oftYbp411UvUPiYVsMb1MMG6BadJLXhlGfPO1N
0rx2+TRF2IjA8uHgzw5CfXECPeZnjHPmFwj110WeK1I07ebrCTuNovqC0i/ky2js
AMfWy6XciHj1Vn5z0IqDI07pgcpagoxsilBRU4BAnwOvy4A7otwNBspGskZ2gRVa
ZZsaCtJspRnOtX6jAq9k1skq9NPSNeaP9z5CL836X7sWm5kU2e5yHemDXSUhXgqg
7fHC7W0z9qL3H8Z4vYvNF2JRrlvz6tcvH2bA7Z6avjgI2+jA+deidPyA7GQtrBOP
aLp7elwWSC151/175uT03pJOhx+Edw==
=LfY8
-----END PGP SIGNATURE-----

--2EgFFNCMuwbml2pZ--

