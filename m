Return-Path: <linux-kernel+bounces-74741-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 00AE985D87C
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 13:57:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 93A8D1F24057
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 12:57:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 220A969D28;
	Wed, 21 Feb 2024 12:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QyLXrVWu"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6765F6996E;
	Wed, 21 Feb 2024 12:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708520215; cv=none; b=jkkXQUYCzr+VRQNUzb3KK4pQBOPUH6+EQYF81PzOtL+oIcNLuhfqyQsiGLsuMouYaXIlx9o6jXPzptuQZGcL2tNclwmrA/Quix1YaTE4ZXaWHsF/s9KYWUGADs55ylGon6LYiawJAn4Rma/99OxhoQK/bJuELVXh2YZxuUue3Cg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708520215; c=relaxed/simple;
	bh=HAX5S+BTjvUlYTQx15Q4/Wc2BtqYGg56lJDNdzggQJQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zrt66dnuhlDaFsgZkkcvRGIMKnb0dCNwq/rieBk8NLe0VTJc8cqLEMati7gLcVis7SHSZOS3aS+w4bhIjp4nlyYPB7jRJFK89aI6zlkJd1iBAQiDS1/iqYx7uYM7JiRmxhhfd+Im5Y+YZZQF2hinY8NIge4fXMu1s8j+jNZwpKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QyLXrVWu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9AAFC433F1;
	Wed, 21 Feb 2024 12:56:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708520214;
	bh=HAX5S+BTjvUlYTQx15Q4/Wc2BtqYGg56lJDNdzggQJQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QyLXrVWuk5d7FDYobtFkn7Ym2aBumPiZGGwTV+4h8bi7812iaGMvRoXappbSRswAV
	 Av+NrT0ZPectHtDAk3qObtyDHCkg1Fu9AhFK24dMnnpBCiKejBMgE6Ft3IEXTpdzI2
	 xeaI9dh/RpJpKyUngscif87Xa6r3fqT7BIkyFo/GosimiScoTtOK7t3hwYjxiykgp8
	 /yW1ReLAbf2A/5BFcWguB1DHjDvzoa3KVooTb4TrTiKWuyFI4wHFunawvJko7RGlsp
	 bWMSQloivLA4PR+Bpu8+B+z3fzNwgzwBzZebdtQNUUY9MlzwFTAotm2PJAHPgi/S3F
	 bgkQbwExYFIPw==
Date: Wed, 21 Feb 2024 12:56:46 +0000
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
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Arnd Bergmann <arnd@arndb.de>, Mark Rutland <mark.rutland@arm.com>,
	Kalesh Singh <kaleshsingh@google.com>,
	Vincent Donnefort <vdonnefort@google.com>,
	Ryan Roberts <ryan.roberts@arm.com>, Fuad Tabba <tabba@google.com>,
	Jing Zhang <jingzhangos@google.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 3/7] arm64/sysreg/tools: Move TRFCR definitions to
 sysreg
Message-ID: <d50cabc9-25ef-4992-99be-a2cdb55bc98e@sirena.org.uk>
References: <20240220100924.2761706-1-james.clark@arm.com>
 <20240220100924.2761706-4-james.clark@arm.com>
 <18995343-e43e-4e92-a97d-3df74ec6ddb7@sirena.org.uk>
 <c1e159b7-c884-e498-6b01-64a897117036@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="IZ9CMNvB/XRkGgFW"
Content-Disposition: inline
In-Reply-To: <c1e159b7-c884-e498-6b01-64a897117036@arm.com>
X-Cookie: The second best policy is dishonesty.


--IZ9CMNvB/XRkGgFW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Feb 21, 2024 at 10:10:18AM +0000, James Clark wrote:
> On 20/02/2024 16:11, Mark Brown wrote:

> > These are generally sorted by encoding (simiarly to how sysreg.h was
> > sorted historically).

> Ah I didn't know that. Can I add a comment to the top of the file saying
> that it should be kept sorted?

Sure.

--IZ9CMNvB/XRkGgFW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmXV8w4ACgkQJNaLcl1U
h9CzxQf7BV+iitFKiE5Yfp41C2YaahJUkZWUWtIalxW3hnrKUnONhG98NPi83g9i
oR/RvAotkFwNS8MInImbAVL7Ni+LYlXTsdYzxYgBLSwZSp0FEd8ALzZpqV2S3sQb
T32XtAkshhi0/Q64XrwMXFY8pPGN3wn0pUgQRC25EX3V/cDfpB0wgX16UNMS4Zmz
bCaCQNWNH6Zhl7rjXeit6HT17AYMm31r6pJkmXvxZXGRZmLNFMp2jJ/+dlhWu7rB
keUdSyMXIFJY1cNGy7RIIDdG4KeFmNvy++iaFjYabKeG20P8hjIYa5d2PCkFHpoc
Q24j9vsMBhATBV450Z9saT8JwijmuQ==
=mGFC
-----END PGP SIGNATURE-----

--IZ9CMNvB/XRkGgFW--

