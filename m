Return-Path: <linux-kernel+bounces-44623-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DFEB6842533
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 13:43:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1EDEB1C20F40
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 12:43:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AB9D6BB4E;
	Tue, 30 Jan 2024 12:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YuKu+O33"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5021A6BB3B
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 12:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706618539; cv=none; b=NbEYJQJz5dDtD9Uy3rQ9yu3zSngNdTsVi1qlvDUnQms1fSLk7M79xNgtoMGrlQqzqYEv7JXYd3gBXtWtoX1OxXVoBvM46NW/MTrw9SExtUi0CJd9LZM3q861nOX1wdsQF1zyKBur2MdaU8MZlc8a01jf887JUFFLejE3+QM7cPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706618539; c=relaxed/simple;
	bh=Eql80OFLBFbtt9dtLg6qGZK/NtoMpoPp+MJNrnweddM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=si1Uw0PPpoyLL0iIFhOLKNRyqXfRwYxCj0pAcT3aVHRRC3+yHxIWAPED19a1M6jvMNCX25i+bWNMN8H8GqraiIBZoMriEGw+tB1JSYQLV2RTeLgGOidV2IufvdqCDbtfHKDf8Kn70ap9HNkcdl3EjlgpYrdotFEnn8MpTjndNrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YuKu+O33; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14434C43394;
	Tue, 30 Jan 2024 12:42:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706618538;
	bh=Eql80OFLBFbtt9dtLg6qGZK/NtoMpoPp+MJNrnweddM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YuKu+O339o6awlBPWH5DcVtAHfNXbvuLDKOJa8IQlG9tw+MjLSZ7DtDoe1C02MlkR
	 VK7beEcRjpOmy0OfHI69zV8uw3XoprCvgKQJel0pBCyVlzJQxJai9nCwEj3YIp4xsW
	 ffy53pR9BfBpninfPJUuuE65Ca8uQI/giF8X846bzzj++L33tDh/MQwlgTrZbGM5NJ
	 gOPYJdhYYmM/bycf4ahfnywmIYOIn/cKW7ivFWH5+TEvuUKofjTJmy/AidmuMSaybl
	 PG2lJnxb9BRgzcvcyoHPXl6f0lEGVFUQXr5hdU6aUJw2gI4+hNN+NnH7nUd3hl64vl
	 tK9z2ly5ANUUA==
Date: Tue, 30 Jan 2024 12:42:13 +0000
From: Mark Brown <broonie@kernel.org>
To: Dave Martin <Dave.Martin@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Jackson Cooper-Driver <Jackson.Cooper-Driver@arm.com>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] arm64/sme: Restore SMCR on exit from suspend
Message-ID: <65973ce3-a316-40a4-bad4-fbc99bccff12@sirena.org.uk>
References: <20240130-arm64-sme-resume-v1-0-0e60ebba18df@kernel.org>
 <20240130-arm64-sme-resume-v1-1-0e60ebba18df@kernel.org>
 <ZbjVNggOxxoQXitV@e133380.arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="k0mhTPwGrUaa4/vP"
Content-Disposition: inline
In-Reply-To: <ZbjVNggOxxoQXitV@e133380.arm.com>
X-Cookie: 1 bulls, 3 cows.


--k0mhTPwGrUaa4/vP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jan 30, 2024 at 10:53:42AM +0000, Dave Martin wrote:
> On Tue, Jan 30, 2024 at 12:02:48AM +0000, Mark Brown wrote:

Sorry, didn't see these bits due to the large block of quoted text.

> > +	if (system_supports_fa64())
> > +		smcr |= SMCR_ELx_FA64;

> This seems to silently duplicate logic present in cpufeatures.c.
> Would it be cleaner to save/restore this register explicitly across
> suspend, once cpufeatures has initialised it?

I was unsure about that, I could go either way.  All the register save
and restore is currently done in assembler which felt like it was doing
things too early so I went with this instead.

> Or this could be factored somehow, but dumbly saving/restoring it is
> probably simpler (?)

Yes, I keep thinking about doing that but factoring out is annoying
since there's also the KVM case where we don't always want to base the
decision about the settings on the cpufeature detection.

> > +	write_sysreg_s(smcr, SYS_SMCR_EL1);

> Is there an ISB or equivalent somewhere on this path?

> Can we blow up when trying to restore SME state (e.g., ZT0) before we
> enter userspace for the first time, if the firmware left the SME regs
> inaccessible?

I concluded when I wrote this that there was but I confess I can't
remember where exactly now.

--k0mhTPwGrUaa4/vP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmW47qQACgkQJNaLcl1U
h9DwhAf9EzbjO8QDLngdgs/w1U8tbbLzYccixDancPw6pIBneMEiM2dV8XYztDob
QiRsSxX4UXsGBCJJH/RhI1jFcWVOVS3XilPcDaci7If2OGMHfhafi5DFUmFSE24z
XFgNxZvDs81+CyBvMI+AKb2sXIN5YnxbKRQFcII8sJA0HgmJI46XlLo+XTXOsliq
+R2QuphM+6bmkWynrD5lQfVloSz8VGk4jQBott06irR1Aan/Yh0Kat8XaGNZOuFx
75a7WKfDkx0OGJe7tOvNHGfq3okG71/oZGzOYdACF0GkpRkRb/8ZzGM9pvkvjN8b
X0bqQlvC/heUdIVctGsrjHf9a0vk5Q==
=Mb4u
-----END PGP SIGNATURE-----

--k0mhTPwGrUaa4/vP--

