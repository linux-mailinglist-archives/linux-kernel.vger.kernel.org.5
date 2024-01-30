Return-Path: <linux-kernel+bounces-44600-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C5788424DF
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 13:26:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D0A07B2780C
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 12:25:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB9FF6A00F;
	Tue, 30 Jan 2024 12:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eGqED7ZW"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F233867E96
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 12:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706617509; cv=none; b=dC1LcLG6PUhwXNkERUcwPNAF2sf3nEiCg+UXLxjP8fAEYIF9iNVbNjSW11bg2p1SDsQ7dHCkwoHz8+BnjbIv4bRtLBEUPLDgO5kxWp8yQm/a7/C/TipZ1CUHEmR+i/8fEctXuc1sZhgTfS1hHjnb94bhXXL4UaaCFI3SWjAPqi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706617509; c=relaxed/simple;
	bh=18t4wYKdk4YqLYKxrilFw52phQEU1oy+X5t3g7YW3rM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NySyKSdJl9aqnipVvQWZ897W0qhOkMta6hcHVFzFLA+7bHEJaCwacyn93cvOcvIV3tF5LfGt4jZQT7CfQnsMW/8yYpedNUp2u3yUDAjdSK5QgnRKMoX5z2SArfbTRfqxDm0QNXjSv/gY5pWUkvS/+m1AU8+Awf7Wq16VUx5oMaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eGqED7ZW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13933C433C7;
	Tue, 30 Jan 2024 12:25:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706617508;
	bh=18t4wYKdk4YqLYKxrilFw52phQEU1oy+X5t3g7YW3rM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eGqED7ZWnEaddXaKbW0MMMfBuL6uunY06Y9h7pwR8Tbs7CHt/UXT2xe9UintyczuK
	 EtvbVFxmLnMtWNmjEyY24k49sPbYbOdnwrvDPEPbXqq9jjjnkZnD/e6biKUwpdHUqb
	 DAs3IpWoqsSz8KgC/86T3Xprt2/6ewyWjczURvwfMDrjPAbSt7HJCHD3LTnehf6sx7
	 0fycka7Z7g0H3m01YUp1EZAzG8ingyGyclVDGkXJEaQe7NybyUUdmNmqjgbfnHegsd
	 IZGTMl69khcwTs638BCNaF5DePsZD5W+n4YGYWRmVta2hmTAjxpuYdCJWLm8UFieIR
	 jd5diXYJOLMJw==
Date: Tue, 30 Jan 2024 12:25:04 +0000
From: Mark Brown <broonie@kernel.org>
To: Dave Martin <Dave.Martin@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Jackson Cooper-Driver <Jackson.Cooper-Driver@arm.com>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] arm64/sme: Restore SMCR on exit from suspend
Message-ID: <e48c714e-8ea5-49f1-82d3-8d55dc89ce37@sirena.org.uk>
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
	protocol="application/pgp-signature"; boundary="p2+gdtYAXO19PTGN"
Content-Disposition: inline
In-Reply-To: <ZbjVNggOxxoQXitV@e133380.arm.com>
X-Cookie: 1 bulls, 3 cows.


--p2+gdtYAXO19PTGN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 30, 2024 at 10:53:42AM +0000, Dave Martin wrote:
> On Tue, Jan 30, 2024 at 12:02:48AM +0000, Mark Brown wrote:
> > The fields in SMCR_EL1 reset to an architecturally UNKNOWN value. Since=
 we
> > do not otherwise manage the traps configured in this register at runtim=
e we
> > need to reconfigure them after a suspend in case nothing else was kind
> > enough to preserve them for us.

> Are any other regs affected? =20

> What about SMPRI_EL1?  That seems to be initialised once and for all in
> cpufeatures, so I'd guess it might be affected.

Ah, yes - we should do that too, thanks.  At present we map SMPRI_EL1
out using EL2 controls and just set it to 0 on init so I keep forgetting
about it, I wrote a few lines of code years ago.

> Also, what about the _EL2 regs if the kernel is resuming at EL2
> (without VHE -- or if SME && !VHE not a thing?)

Yeah, I was somewhat confused about where the EL2 handling was in the
resume path and was hoping that if we weren't just rerunning the initial
setup someone would tell me what I'm missing (which appeared to be what
was happening).

The hardware will always have VHE but we could be running nVHE (eg, for
pKVM) so not using it.

--p2+gdtYAXO19PTGN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmW46p8ACgkQJNaLcl1U
h9CPZAf/SjeSn+2E+55OUBsJw88y3XY3aDeZ72sklbI+xbiEcUI2PyOHWpSdD6zn
W/f8sGWhy4uypX0tfuHo2ZtjyfHT9csAIXTavEUCN9kCBXrAG4zRpX7suUGKK3+U
H15dWNgSe2wLxdpKoUc783cnUHEM1pecU2kSEAuDPRwHkonlIBlw/VZG9o3D5dhN
rWI1DaGGYK7yFg+Q1Auj4k0jBGl2HoAoNLCCKnika3VFM8/6yEukgGYmNTdP5MRJ
jYsdVqKRZ3gyA8S+pU+L9p6zFd9B9Ongo6BRH81cY8Odt3eUOOhXUfyX+wNFcqy9
2RA3WmgIHfErZcfcD12m1d4mMn0KRw==
=D39O
-----END PGP SIGNATURE-----

--p2+gdtYAXO19PTGN--

