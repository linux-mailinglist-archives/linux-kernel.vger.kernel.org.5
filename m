Return-Path: <linux-kernel+bounces-69951-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7BE78590B3
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 16:56:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 03DEB1C20BC3
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 15:56:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 946F67CF00;
	Sat, 17 Feb 2024 15:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ac74+6eX"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4B7A7CF08;
	Sat, 17 Feb 2024 15:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708185387; cv=none; b=W9BYdanY7QeEZnC3mFEk91kVlm1zOlq//sds/yImYSZp+TXpt+WgNG2CipX9mYdpA3GE/BFWjaxfq8JiZDw7yTeXwaUdo4QX8T15HefUi+K6pmMJ+PWx362jLcBvRqPWF9QKz04/xCjmemzcppewQ5mzX2orkMTSY512teFHpL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708185387; c=relaxed/simple;
	bh=J/W77O68aesAwbF/+MNHZ67Vbe47hRGcJRILMJWoA5s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FK6bsscjbeldJO6e+MZ3govYqBS0XrGNrB7V4R4m8sWgIdChLvm3krb0XicxRq9UBlYcg/ol0DyPczcQvQXfj2GE/PQi74VhuO8Jh158IJER2SlMzLptcYebSCcpuPGkyq2gunjyWDuWYaN4Omlsr8+PFGL1zc8or9zcJ0JsOFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ac74+6eX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A079DC433F1;
	Sat, 17 Feb 2024 15:56:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708185387;
	bh=J/W77O68aesAwbF/+MNHZ67Vbe47hRGcJRILMJWoA5s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ac74+6eX8BYX+Dhc5pD9bHerYX+LucQy55Ok8Yv9288W36kEIIFwo7rOdcZ9wYXrc
	 uGyB0npROCKeS4y8eEM8xPsOIQ/kv5ICHN5cYn7082kYOnOsD+cCcCKcOcLymiDGpC
	 kAa9Uy9b9kqUJnWMafnWiHgWsL2NRxDGGGHXSrR4cZqW4F7hrwLBeIhIFRXbH+hzxF
	 DL0JPR73Dt3/zkkZ41KyLcgUEJm+3/7qo1CwwOqJL+qPOLCR6lKc9Fu3D15cQCz5jZ
	 2uGGzMihoqljFxBOdoB7Van/EqW7D+FHhSQjlV+lOhnmJDB2aiSer0QfJe1/8SwQyM
	 TcC9iKmCmLiag==
Date: Sat, 17 Feb 2024 15:56:23 +0000
From: Mark Brown <broonie@kernel.org>
To: Takashi Iwai <tiwai@suse.de>
Cc: Venkata Prasad Potturu <venkataprasad.potturu@amd.com>,
	stable@vger.kernel.org, Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>, linux-sound@vger.kernel.org,
	alsa-devel@alsa-project.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [REGRESSION] Acp5x probing regression introduced between kernel
 6.7.2 -> 6.7.4
Message-ID: <ZdDXJyXiZ++KiNqW@finisterre.sirena.org.uk>
References: <CAD_nV8BG0t7US=+C28kQOR==712MPfZ9m-fuKksgoZCgrEByCw@mail.gmail.com>
 <7a0cd63f-8a83-4dc5-8763-63dcdae8d68a@leemhuis.info>
 <878r3qxcyr.wl-tiwai@suse.de>
 <871q9hwz2w.wl-tiwai@suse.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="EkTQCU0JljxhlDH4"
Content-Disposition: inline
In-Reply-To: <871q9hwz2w.wl-tiwai@suse.de>
X-Cookie: You might have mail.


--EkTQCU0JljxhlDH4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Feb 12, 2024 at 03:12:55PM +0100, Takashi Iwai wrote:
> Takashi Iwai wrote:

> > Interestingly, the system seems working with 6.8-rc3, so some piece
> > might be missing.  Or simply reverting this patch should fix.

> In the bugzilla entry, the reporter confirmed that the revert of the
> commit 4b6986b170f2f2 fixed the problem.

Any news on a patch for this?  Venkata?

--EkTQCU0JljxhlDH4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmXQ1yQACgkQJNaLcl1U
h9BUtQf/ZTV0mTlTBMNEuSC6v8A3J/2uVLXmPGUfRoOBtLanWtBDSdmXXZEDT3Uw
RGgirO7JuUNcj0tEqF2SODNkXiqEsyNBA/elDDAOxsmuQV9BeziXaVHlBcfFbGDf
yvx7CEWLCdQKucDV/nuxnD5oYsZ48MAN9B4S2L8ePY38UbTHkawnCae+6ObKoQk6
DLYcTzd96CxjCnkHJGSDZGW5xxRUk4/rBnnttKdW4isOoNbEykwyVbcr5ZWTDuao
UEUgX4WdPGWc1XqoLHCRUU+nEA7mgCoAz0QMd8FSpZ8lA8lAG8ziizYS3PY4Btsx
Y+ngUaN9Ph2VYj+hiGLzhKX3MWlbjg==
=CGP9
-----END PGP SIGNATURE-----

--EkTQCU0JljxhlDH4--

