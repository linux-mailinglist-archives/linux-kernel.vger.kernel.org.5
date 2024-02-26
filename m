Return-Path: <linux-kernel+bounces-81470-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1129E867657
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 14:21:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BB8561F28968
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 13:21:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C372B127B4F;
	Mon, 26 Feb 2024 13:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MzLbuc7n"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 115211C6B0;
	Mon, 26 Feb 2024 13:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708953677; cv=none; b=BbVEiBx9ZQE0IbqyAAMS3OVxR91tqmhNXs3lJ7Gw6wMgX0WIh58a3/ik4SZjL5NBvKb2bdwA2VSk1iv/cgyXTdgbAA3TcKc8pe9Rnuf422L88mnKldal8tOkLxqA4GEIei1DjMHewSXXy+OTIPuPLURY0E0x5Tc2/Syt4g7nj8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708953677; c=relaxed/simple;
	bh=0kdWl6dftO+Q1XgdVuIjP9pXQ9epntB1f/OJpTejlxs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PJeLVrV+sHl6Wp5+jub7JImcgMWEQ5noGEyYuDC5VJ4rcBRYFbF9Fx1wCySZe+pNF0AyLmVyab3a/s839CDPFfAaQQb+/DnGyfqZ94j3vucVTGSBJW4C4duH2Izbai3mgY9vjZ1x7q+jNe0GaVfiwR6pgOrI7pQD8ao5NUHozKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MzLbuc7n; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C58C5C433F1;
	Mon, 26 Feb 2024 13:21:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708953676;
	bh=0kdWl6dftO+Q1XgdVuIjP9pXQ9epntB1f/OJpTejlxs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MzLbuc7n8H2WbOLLlWxmx8E0BbbXniWLaGaBHQ8StBz6zINSubM/0Zql43Pw7jtVT
	 Zp2vLPdUE90SQdI1WRIcEva1z/qen981Lt4uKyA3A85TIGcWa6C3333jKFAwguPAcD
	 kIUvsYKInlXW31s+6TnEfShrIVWllFHJeEO5g9RCXeePHplWavb84s5Vt+Y50vWC3j
	 17PGOHh+ShI84DBqxWgdWPh06T1riYco37czmEZO8P3SVqW/VaBFtZFG5sqCUQZU++
	 7y359rLi0j283i7JykO61u4S/1PIFx0XeHTyBfnqRMVoPYt7N688vS5iFa1aOlVL8A
	 LkTpBJKrC5x7A==
Date: Mon, 26 Feb 2024 13:21:06 +0000
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
	Mark Rutland <mark.rutland@arm.com>,
	Quentin Perret <qperret@google.com>, Helge Deller <deller@gmx.de>,
	Arnd Bergmann <arnd@arndb.de>,
	Vincent Donnefort <vdonnefort@google.com>,
	Ryan Roberts <ryan.roberts@arm.com>, Fuad Tabba <tabba@google.com>,
	Jing Zhang <jingzhangos@google.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 4/8] arm64/sysreg/tools: Move TRFCR definitions to
 sysreg
Message-ID: <170e6979-9e85-4f7f-9aa2-1e5ecde358a4@sirena.org.uk>
References: <20240226113044.228403-1-james.clark@arm.com>
 <20240226113044.228403-5-james.clark@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="14RV3i7MBhO7iesB"
Content-Disposition: inline
In-Reply-To: <20240226113044.228403-5-james.clark@arm.com>
X-Cookie: Walk softly and carry a BFG-9000.


--14RV3i7MBhO7iesB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 26, 2024 at 11:30:32AM +0000, James Clark wrote:
> Convert TRFCR to automatic generation. Add separate definitions for ELx
> and EL2 as TRFCR_EL1 doesn't have CX. This also mirrors the previous
> definition so no code change is required.
>=20
> Also add TRFCR_EL12 which will start to be used in a later commit.

Reviewed-by: Mark Brown <broonie@kernel.org>

--14RV3i7MBhO7iesB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmXckEEACgkQJNaLcl1U
h9DKBAf+MXq5lLhnJzOTpPxb4bugGmpvHHbBC36bQoPSRq9ShB+IthDQL79Wr3Ej
AW9oKW0LNYh2n2YiZxOcOiwZpcsSRU8NT22pjUsOpWq5+St3/Uv2soj+2l/YRaNy
TcOZU9c/xy7NwCQesTh5iSGMBI6sOPZjeT0JucldoNwSjomKufD5TdLUs6fmID8r
1iH7vEW5cmlTybysr3CfjcL3narHoNDp/jhv4GzybHerET0Mcc7WPohhb/NQulQe
yciChrQO7ljmiye57NlRWWt6C6AKznAjbf62ck9An2WePK+wttHUml6Q2KMJC5zG
h1Undohg7BvB0S2mmbMuGVQTNbOkvg==
=bdFN
-----END PGP SIGNATURE-----

--14RV3i7MBhO7iesB--

