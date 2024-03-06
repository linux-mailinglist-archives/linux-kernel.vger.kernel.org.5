Return-Path: <linux-kernel+bounces-94246-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 446F7873BEB
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 17:18:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AAF091F25A5B
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 16:18:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3B9D137918;
	Wed,  6 Mar 2024 16:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kw4WzDRz"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AE71136676;
	Wed,  6 Mar 2024 16:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709741868; cv=none; b=rv8ent5SK1Qrw0Q9Lhqm0eFCT5OIzpavALPBkZNMJMiSsMCGYKXtp/1hxC477lnrTBZpB7yF84Ux7/SKeyzyYmhscBvR57GO69IZenSSaEL3s7SY4uPmBkCfEFfuFU1H/jDVcVzm3jtok+jXU6XlcQQCzhJZ9FCYXZOYKR7rv1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709741868; c=relaxed/simple;
	bh=RVMlEsB2pN6OihFSXCIfVDCN4Q/0ngtVNwKfhyIQRas=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=no2NP0zst+JvyLIQOS93iDd2PDywjP71mb4adXsmhVP4LzsP6zhiRj2sLCOhO8CUhxPp19UtkOuA1bywMjIZtgOZQqrpuVh5Aj4r7uMABQ350rYHSVB5U/a5loEZf4KrL7JbgJwJFqZa9+0bPCrok/lL+f0ugKJl8B8Kk106riw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kw4WzDRz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78A38C433F1;
	Wed,  6 Mar 2024 16:17:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709741867;
	bh=RVMlEsB2pN6OihFSXCIfVDCN4Q/0ngtVNwKfhyIQRas=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kw4WzDRzJgOTgaWFiMqFOR7PMSi9EDNdg7X4h+56sL4CI8WOzjGrR3TGYYabudwEO
	 hJw3FgoUTwlwmpm4K895rAktQDlRceWuhwxJaXljCJlo+3FSF2G1cy2pmeqduAMDHu
	 d2p/s7ZBxVWFkppkhj2O1Tuwcpsy110sGLtiSLNnE+CjOnRIHfpZacw2aEBZTNIu5l
	 anC3ux8TNyEEawLB6Z9sbwic2mEvbsARDVqMC2qFCggocPTVJVVOONoyMGji3eh2gn
	 2bhR3GDNicRCyCmNDaE6kS6pZGZtQnLwaLIvxndYmgjqL9vbIbSf89fUhJ8kYvb7ID
	 0DUmWuSP7pdRQ==
Date: Wed, 6 Mar 2024 16:17:42 +0000
From: Mark Brown <broonie@kernel.org>
To: Vinod Koul <vkoul@kernel.org>
Cc: Shalini Manjunatha <quic_c_shalma@quicinc.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
	Raghu Bankapur <quic_rbankapu@quicinc.com>,
	alsa-devel@alsa-project.org, linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Krishna Jha <quic_kkishorj@quicinc.com>
Subject: Re: [PATCH V0 0/1] ASoC: soc-compress: Fix and add missing DPCM
 locking
Message-ID: <d9d858fd-a4ae-4623-9627-4ccbb049966b@sirena.org.uk>
References: <cover.1709720380.git.quic_c_shalma@quicinc.com>
 <Zeh9HMcWxfgPJS1T@matsya>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="BU4G5YQs4z51lECv"
Content-Disposition: inline
In-Reply-To: <Zeh9HMcWxfgPJS1T@matsya>
X-Cookie: Have at you!


--BU4G5YQs4z51lECv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 06, 2024 at 07:56:36PM +0530, Vinod Koul wrote:
> On 06-03-24, 16:23, Shalini Manjunatha wrote:
> > We find mising DPCM locking inside soc_compr_set_params_fe()
> > before calling dpcm_be_dai_hw_params() and dpcm_be_dai_prepare()
> > which cause lockdep assert for DPCM lock not held in
> > __soc_pcm_hw_params() and __soc_pcm_prepare() in above flow
> > when ever we play compress offload audio playback use case.
>=20
> where is the patch ?

In reply to the cover letter:

   https://lore.kernel.org/lkml/d985beeafdd32316eb45f20811eb7926da7a796e.17=
09720380.git.quic_c_shalma@quicinc.com/

You do seem to be on CC.

--BU4G5YQs4z51lECv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmXolyUACgkQJNaLcl1U
h9Cqzgf/bPmF9PKuBaGGpT5GM8QMANRh7UVzVUYTKzyoe5b7KOX6ZaW21olPQBFx
+e/IMQ17j0wlCVbGUmQrUBaunMN0tYrwa7sgbQbv8Zzs4rUK4CGF+X2hCt6aTXmN
X/MJEcwqBwQyCet5TWhqN8tmQOvKyIZhhbQxIqjQr5XVBV2jaDk33V1zgxT+To77
RTej4cW3QErcHuKndVVkdHaJEH7IXSlQpVh+gF1zdjEji8CRiLXbnIp2GvyUzKW/
6YGM0gesJcw6ZaFgqOCsNyEfGwsy3ixj4BIHuns+CaSQvTegI9uoV74jjBCcW23C
60/fvEjWk2CwwL9Kf0B9R3D+IQ/W1g==
=M7r+
-----END PGP SIGNATURE-----

--BU4G5YQs4z51lECv--

