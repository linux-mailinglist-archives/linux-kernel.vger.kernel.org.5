Return-Path: <linux-kernel+bounces-133021-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 50346899D90
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 14:53:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 05172283646
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 12:53:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E9DB16C874;
	Fri,  5 Apr 2024 12:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dc9+d77y"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E230C1DFE4;
	Fri,  5 Apr 2024 12:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712321584; cv=none; b=oo8NhAD79HWn+kjtwLdoaXoviEI1J3VUKQ8/3usTgWJ7X61QfhyFdlSHlOfNRP6W+/vKdOxMlyqATe8j2PuhY1Jrf3l1pqQgktwjx87AENKzHw9ZQE0HQsFBgpj6liIjIK+ZFUQi+Lt7ndI5ckRliGba883gKDW7JzTnUO/inQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712321584; c=relaxed/simple;
	bh=saolaFFWXND2Ol+BXVFKPBr/Ocy3m33kUDb3m5TPsSQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Uz3unRY+Us9Y4tzUaVWvSZO6TJmAe2vAJkPL1S2cpVD6DKw5uOYb4fxsbcaMWKzivRAmAXIDmJB/JA0qoMGxNt/OCtO1wVZ/p9Kw510uVl248l/LbobF+hGEo4revURCcdGoIJACc1ua8L2IoPzZEz67nE7r6Ph6D/yT5J4nfyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Dc9+d77y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F280DC43394;
	Fri,  5 Apr 2024 12:53:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712321583;
	bh=saolaFFWXND2Ol+BXVFKPBr/Ocy3m33kUDb3m5TPsSQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Dc9+d77yPp5CxBiiNnQyva/9jxGcgwGUYe8BIm35tplh2o9IafS1hijAbyor0oLZY
	 IDOuQtS8ccTrp/BaNGWxZe2ex4K4Tydd29WfvD7eqHldFvvvcNuYoPwuU0i5zdd0mp
	 bafJNgkVCUOYZRjXnYbwxqCmdTkUMFbajgD776z64D2gJN8bRslRnMWQRSX2pvzuLY
	 E+q8uCTjaRTuaWUQ0ZGdiJmJ8zPxZXhQgAnWGpZe8HnoRtn3guNPQSsn3fpaB2se1u
	 OhSass1j4qKRyz3ItFUQhS0ISF+CwheCVHOrYdpLKaWhEn7d5AxlHQs3WfAer8Rcjz
	 J2mwWAyWAe2qA==
Date: Fri, 5 Apr 2024 13:52:57 +0100
From: Mark Brown <broonie@kernel.org>
To: Anshuman Khandual <anshuman.khandual@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, Jonathan Corbet <corbet@lwn.net>,
	Marc Zyngier <maz@kernel.org>,
	Oliver Upton <oliver.upton@linux.dev>,
	James Morse <james.morse@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
	kvmarm@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [RFC 1/8] arm64/sysreg: Add register fields for MDSELR_EL1
Message-ID: <7ad67b1e-6a0e-4df5-8746-72fbec1c1b91@sirena.org.uk>
References: <20240405080008.1225223-1-anshuman.khandual@arm.com>
 <20240405080008.1225223-2-anshuman.khandual@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="dRGaosfXeB4pGvH3"
Content-Disposition: inline
In-Reply-To: <20240405080008.1225223-2-anshuman.khandual@arm.com>
X-Cookie: Honk if you love peace and quiet.


--dRGaosfXeB4pGvH3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Apr 05, 2024 at 01:30:01PM +0530, Anshuman Khandual wrote:
> This adds register fields for MDSELR_EL1 as per the definitions based
> on DDI0601 2023-12.

Reviewed-by: Mark Brown <broonie@kernel.org>

against DDI0601 2024-03.

> +Sysreg	MDSELR_EL1	2	0	0	4	2
> +Res0	63:6
> +Enum	5:4	BANK
> +	0b00	BANK_0
> +	0b01	BANK_1
> +	0b10	BANK_2
> +	0b11	BANK_3
> +EndEnum

I think this is a reasonable translation of the values for BANK.

--dRGaosfXeB4pGvH3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmYP9CkACgkQJNaLcl1U
h9Aj+wf9E6EkiKV1dUvAVCjABHg8ZRiLYRqct6pZzyyiXx5C0Rg0bS1/t5KQ9Ojf
VgNA/RuA1Nq9eoEpGj+nQBuOCSteFW3Ko7BkdJMJMQgVkZ24iHTkZGSp1f+bvE6c
wdpMbxbP55WkowgBVE0P5WdSyjpU8asEGboUOQk89dC330JrknLavlsaJRaX02kz
0E6AMYUULGhSK2aCEzB7nOTglFyTxRJ3x3Bzo1b3v3OUUnbfnjb7J2prKunhRIKi
wT2EuvYVlOTzG6w0AGHWGCddKXEnibJ7tFhZLqWR/O1rjnGrMZM5DlmmZG4L09Rz
RDi4EoZAb2cGdGTAxc5fpBwe6UOSMg==
=+Cjz
-----END PGP SIGNATURE-----

--dRGaosfXeB4pGvH3--

