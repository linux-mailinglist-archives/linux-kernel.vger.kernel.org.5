Return-Path: <linux-kernel+bounces-73312-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BB7285C0D1
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 17:11:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C52161F23AD8
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 16:11:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05D2976414;
	Tue, 20 Feb 2024 16:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SFtjRf56"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C40C7640A;
	Tue, 20 Feb 2024 16:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708445499; cv=none; b=fax1z+TGTbW9qc1/LBzhoLe5ohWOzHZvr9ktzVBtWQI7Q/QVrqc0BkvfdTroQRMjEPHzzcYonredt2UH7GNf7eVsLq4Odww5+anGRRc8EnBCbDsWxrt7BDo7QUv9k/gFcOY5VhnXke52X/ikgbBPVytAK1rnIPlcsUxvT/liP8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708445499; c=relaxed/simple;
	bh=fCJbgzdtJxxNPFzcJXDz7ixxdXTlq2P+306W5u4RkKA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q7irVYk1H/C/MG2eR+jrbh82zUFiz/IRzNlzv3zfAwernGpprEKSYUWaKqaU4xHQaSHd76hESKeeMDsXyfvAzR12AVUASwCnB0Glzh9xQgrEsp0588CzbXLcvu3oRHkVXHvy3XXMjvakoq+f8wtuj2yt8hqCqBkKN2Wd/JOhrA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SFtjRf56; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCDCEC433C7;
	Tue, 20 Feb 2024 16:11:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708445498;
	bh=fCJbgzdtJxxNPFzcJXDz7ixxdXTlq2P+306W5u4RkKA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SFtjRf56hxgtIcgTRK1NNfoAD+0lHtjNeN/mSRfhFCAFQMKnPkqnU4nW1WJ4gcUTZ
	 aD0v0juZzak7d+U2X1esZ60fnje8edQNVle/Bt/ZSY9ZUM0ER8HB7kJ8BGtEhhKWgD
	 NrVoCnd0MzhjDUGvVtNTsnnXR2O/ffkgIvKJMIa0SxOtvdhFT0A10Sbs+NsFCIdvIZ
	 1a+wRGg84NDpg5CyAEz9Twsa1jH8XhsKDzDLW8Ldqk/Sw0AikaeMuQyrPRU2nGrwmB
	 3JU23L0QsUMOav5pyiLTnAiSXTGQmvmiQlNcrUJmjUcHI03G2I39Mj8hbSIVwoKBTC
	 yJxUG70YF1cDw==
Date: Tue, 20 Feb 2024 16:11:30 +0000
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
Message-ID: <18995343-e43e-4e92-a97d-3df74ec6ddb7@sirena.org.uk>
References: <20240220100924.2761706-1-james.clark@arm.com>
 <20240220100924.2761706-4-james.clark@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="wa66B86kvsE+u+/E"
Content-Disposition: inline
In-Reply-To: <20240220100924.2761706-4-james.clark@arm.com>
X-Cookie: E = MC ** 2 +- 3db


--wa66B86kvsE+u+/E
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Feb 20, 2024 at 10:09:13AM +0000, James Clark wrote:
> Add separate definitions for ELx and EL2 as TRFCR_EL1 doesn't have CX.
> This also mirrors the previous definition so no code change is required.

This is also converting to automatic generation in the process.

> +SysregFields TRFCR_EL2
> +Res0	63:7
> +UnsignedEnum	6:5	TS
> +	0b0000	USE_TRFCR_EL1_TS
> +	0b0001	VIRTUAL
> +	0b0010	GUEST_PHYSICAL
> +	0b0011	PHYSICAL
> +EndEnum
> +Res0	4
> +Field	3	CX
> +Res0	2
> +Field	1	E2TRE
> +Field	0	E0HTRE
> +EndSysregFields

This has exactly one user and I'd not expect more so why have a separate
SysregFields?

> +# TRFCR_EL1 doesn't have the CX bit so redefine it without CX instead of
> +# using a shared definition between TRFCR_EL2 and TRFCR_EL1

This comment is reflecting the default state?

> +Sysreg	TRFCR_EL1	3	0	1	2	1
> +Fields	TRFCR_ELx
> +EndSysreg
> +
> +Sysreg	TRFCR_EL2	3	4	1	2	1
> +Fields	TRFCR_EL2
> +EndSysreg
> +
> +Sysreg	TRFCR_EL12	3	5	1	2	1
> +Fields	TRFCR_ELx
> +EndSysreg

These are generally sorted by encoding (simiarly to how sysreg.h was
sorted historically).

--wa66B86kvsE+u+/E
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmXUzzEACgkQJNaLcl1U
h9CQWAf/aD2427fNk360iRhg6pTosQgT0c+SaeDdLiO2QPiJqOQRiI4OQTlMpHOg
KiSUIyzOV4tvIlc9v79q8DBHGkPqTWnwjdKAb/sicVgy2z0lsaHAF6NeqKbXYO7k
Mt+VhXBJ+UeT0+VW9u6IbHQrrSU8s38uLBmE8ug8NTAVtytIsOI93FO8gpwtgqPk
KBfruF9VtUoBXd/AAowPQYf4oa6AUhv+9mWgENaydDV7LrtgTOCpKZ4C8l16R5/6
fCExQ3f3MKaaWy9W29qY/fNnDttFZtrTDT2FN4NNou0aAredkBxoUbzNAQhOCJD9
w159Rk9+frryVxXJ4NYgdgKPiOc2FQ==
=Slmu
-----END PGP SIGNATURE-----

--wa66B86kvsE+u+/E--

