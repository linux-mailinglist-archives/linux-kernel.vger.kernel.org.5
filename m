Return-Path: <linux-kernel+bounces-38714-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D66283C492
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 15:21:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C1DCB1F21F07
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 14:21:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40A8763417;
	Thu, 25 Jan 2024 14:21:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EPBMy9P1"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8569D633F4;
	Thu, 25 Jan 2024 14:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706192465; cv=none; b=MrCorPo8S8zEYP2dkUpNqvKMBvrFRuKc+L2j5UbT6keYZvxFlJHL62vDHmxJIbPxiI2OclGDVJ47McSp4ABOA27k7CgZFrakbXkET12D9bW7zk3GZj73vXCVc5JBlZPxtOaf50bmtnlNKAy2B2rdpZv4SvPBBJUz9/IBWVzSbcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706192465; c=relaxed/simple;
	bh=MNIgi+b3t8zEWYR3iuNyPFdo/g4cOlipsxaAEiU4R/c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tw39Gch1UZIr/8LdaOb0BofomonOVczgQDXSeWEKtoQ3FJbOqW2oqHJxSA/pJf9oozrxN7DwK8vpmV35eQCaDAEitye4RRXe5nkK6XZbygLRhADoqMBVShnqqvr6hKxVXNAFaT3OSzuBU8FCfTW/ZUpw8L9gpgz3FzNh3AyAPuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EPBMy9P1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB3A7C433C7;
	Thu, 25 Jan 2024 14:21:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706192465;
	bh=MNIgi+b3t8zEWYR3iuNyPFdo/g4cOlipsxaAEiU4R/c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EPBMy9P14kelBFAkx5aDrWkGpOtB0+cYKu1CE7M/TdEROHq88tUk7EjHvIHPo0Twc
	 1mO7tDsZHHyRsU9OrtlMs2wcXBt/CzZMVzxcKEY13IENKVj+PuLFFsDZwQz977qPeU
	 jGtnhst02LWR/Ozsybmy/43puOIKDIkjWGidIY5KihtuV4G7Z21CT3sMJy/WFsNW0R
	 yYngWuqHRp6K31iKdyibEYmnM8wZwPSATjljwJRYcOGJVgqgkVtEDukRjrCNdj3141
	 A6wwybdSM+1aQhrftQBcmwfP6TDDWBKnW7llB+NlZpxBmubBECceXBrZhu+SVri6T/
	 MCukgKqw4Z3Ng==
Date: Thu, 25 Jan 2024 14:20:58 +0000
From: Mark Brown <broonie@kernel.org>
To: Anshuman Khandual <anshuman.khandual@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	will@kernel.org, catalin.marinas@arm.com, mark.rutland@arm.com,
	James Clark <james.clark@arm.com>, Rob Herring <robh@kernel.org>,
	Marc Zyngier <maz@kernel.org>,
	Suzuki Poulose <suzuki.poulose@arm.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH V16 1/8] arm64/sysreg: Add BRBE registers and fields
Message-ID: <bfef9ef2-e1e8-4097-a683-8aff625f7091@sirena.org.uk>
References: <20240125094119.2542332-1-anshuman.khandual@arm.com>
 <20240125094119.2542332-2-anshuman.khandual@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="MiSmjfR9RuqrtYah"
Content-Disposition: inline
In-Reply-To: <20240125094119.2542332-2-anshuman.khandual@arm.com>
X-Cookie: Entropy isn't what it used to be.


--MiSmjfR9RuqrtYah
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jan 25, 2024 at 03:11:12PM +0530, Anshuman Khandual wrote:
> This adds BRBE related register definitions and various other related field
> macros there in. These will be used subsequently in a BRBE driver, which is
> being added later on.

Checked against DDI0601 2023-12.

Reviewed-by: Mark Brown <broonie@kernel.org>

--MiSmjfR9RuqrtYah
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmWybkoACgkQJNaLcl1U
h9Dwzgf9FNtXB8s0Ee+Ieyg34xIqlufx1AHq7PXMwIcKshRsPL5yLd/nzWL0zwi1
mHfyX02YU5K2nWCo0oFusfPr2fkHih0DVCIpz6h4iBWPxkbeiEq4qrvpE/oppe0R
p6fDnvG7F+w/NvdJ0IYGofL6CyzT7f7sEX2ddydwoW35Rd+c/n5/6D3mq6N7Z9eH
4TjO8JOA0vcoy3AO7N6lj6Hkk5AW4ziw26f4IlAHtYbzI94tRSqYJq8eOOhrgSq7
zFC8CmC33IZ43UUibpVknH0iFeelr7y1nvi1iyYl+nM+9haI+DCwqu7CbBQVLyuk
wR6P/Ku/wfRzFH2H93WsdMWDXF2KWQ==
=xysw
-----END PGP SIGNATURE-----

--MiSmjfR9RuqrtYah--

