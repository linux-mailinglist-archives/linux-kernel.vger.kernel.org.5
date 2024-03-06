Return-Path: <linux-kernel+bounces-93941-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AC88F87373F
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 14:04:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 717E5281C1B
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 13:04:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A707130AF2;
	Wed,  6 Mar 2024 13:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GKjXhq/t"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDA4712FF9F;
	Wed,  6 Mar 2024 13:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709730241; cv=none; b=hkGXPnu7K8qDuPOSlkmO4GAdY8VFdU9OkHg1VA4cnMZrkGdkj1NIiMZLnqK+F684pOtSMdX3Izi6fpL2A2bo53R15FO/iSFmJoSv54r2dcpfkwFIT9srtqR3C5ay55Khy647c7wLg4NBUltPb/2BGj3SWi9M7C60nWrYH1yO5ZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709730241; c=relaxed/simple;
	bh=tPKM3fbs+N1jnkgIdgrhQAzhyAXdLqv6da+7MERgVTE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uXxx7WVz+VuV8NDx+SqDVoMYc+iMGGy94i0ra9q1PIkUCRdQB1C0jd/mp3SmAcWjm8y2sAZkcdQMtPiejPLrWqa8e7z9PBIWG5kc/bNQv+mnUHVVEfcGYiJ6I7OGVOLl42wYkIq0PpG++6/VkEpk0up6ou8GM8arcTwsi5iKvoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GKjXhq/t; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66E6AC433F1;
	Wed,  6 Mar 2024 13:03:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709730241;
	bh=tPKM3fbs+N1jnkgIdgrhQAzhyAXdLqv6da+7MERgVTE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GKjXhq/tE2qihb2Xd55900MGCJsOgaStfVo1TBt6kSoLZyEMtASEzK/j+IRRnIcA/
	 pd5e0nVj7F6/qFxTKgzw97tJ241G/DJ/GKPJnyc6SCqF2Ee9hKFonrqXjZj45ZIOQR
	 Y/8gTQ+AVn1AV+YYber7m5sKyD8zMfuyg3BNhvexYyLHJN7x+fRvjmIQ/9umBsghM6
	 CdkkxebIsOk7/b2HdUt2dGBphKHaHGnhQmkHqzTHDriqvcgejzbKC43NBGJ7rAv1AS
	 S6ZBEOxqTJgkEIRCIJnM3usfP8H14XBzv6FFVnDcBIcGmW9U0cAQR53uudWfx9Hyza
	 ihhRsjtCprb3g==
Date: Wed, 6 Mar 2024 13:03:56 +0000
From: Mark Brown <broonie@kernel.org>
To: Shalini Manjunatha <quic_c_shalma@quicinc.com>
Cc: Vinod Koul <vkoul@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
	Raghu Bankapur <quic_rbankapu@quicinc.com>,
	alsa-devel@alsa-project.org, linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Krishna Jha <quic_kkishorj@quicinc.com>
Subject: Re: [PATCH V0 0/1] ASoC: soc-compress: Fix and add missing DPCM
 locking
Message-ID: <fae7335b-bb58-400a-9b72-936b0dcc2fc2@sirena.org.uk>
References: <cover.1709720380.git.quic_c_shalma@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="1AkDkuUU23ZBtHTV"
Content-Disposition: inline
In-Reply-To: <cover.1709720380.git.quic_c_shalma@quicinc.com>
X-Cookie: Have at you!


--1AkDkuUU23ZBtHTV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 06, 2024 at 04:23:19PM +0530, Shalini Manjunatha wrote:
> We find mising DPCM locking inside soc_compr_set_params_fe()
> before calling dpcm_be_dai_hw_params() and dpcm_be_dai_prepare()
> which cause lockdep assert for DPCM lock not held in
> __soc_pcm_hw_params() and __soc_pcm_prepare() in above flow
> when ever we play compress offload audio playback use case.
>=20
> To fix this issue added DPCM lock and unlock in both places of
> above code flow mentioned.

Please don't send cover letters for single patches, if there is anything
that needs saying put it in the changelog of the patch or after the ---
if it's administrative stuff.  This reduces mail volume and ensures that=20
any important information is recorded in the changelog rather than being
lost.=20

--1AkDkuUU23ZBtHTV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmXoabsACgkQJNaLcl1U
h9DCbQf+J6u1XRg5N8iHTV4CowIy+CabymZa6H2WDtsc0EK4gge5qVbNtxPiTmkP
5qDrXNXWtYDGDHZlBGGWn/YZJYjZkILCPdqsGGCi5PXsRns8EDarm0P1/fMh/qgt
dLe+eSA760Fhewm3n5ugW7aK2Y7/Jk1dVV2x8tJahVvMMslDNYqk7+xQJ6kLmE3e
VB9Eigc2AIw2gu46jg+iOKHh0eMylSjuKi61TDgWP5LN5fFY/y5TirX32tZR4w1N
NRnWQca7G2bB0zTP9JVLNSIYbELd7oKkui+nQtTFqovCPFUNv8wd5SjF/te9hCEo
KsnfC/NSgySY7g9XIKyAfwnB7mdkaA==
=6SHa
-----END PGP SIGNATURE-----

--1AkDkuUU23ZBtHTV--

