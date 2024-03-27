Return-Path: <linux-kernel+bounces-121471-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC15B88E860
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 16:19:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 21A2F2C5C24
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 15:19:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9F3412DD9A;
	Wed, 27 Mar 2024 14:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pPwuCjRl"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37954E546;
	Wed, 27 Mar 2024 14:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711551536; cv=none; b=nGRAz9HiVm7r0ZcCZ8uuYizEp7VgQ8JQoSHwW2/i5MwCc/U+P3g3kedAntjj01x6yexQkQyplTJKpEp4CwL+0o4HUXmbP8yEZ91YOK1e29DML2aAM8h0+8TnQi53qkWD4CrdYl6jMMgkTG97qHEhRqEHkqIUwz4NHBxygKUJ9v8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711551536; c=relaxed/simple;
	bh=/qS4x09dYgY6sXrlC/UAO2mdxYkbcHDpH5G5a5KiSBE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ttZ6kxrbdvnYG+XvuMabr+PA4fJZqRJDxTsD5+ldB04dUBTM2onxRXUf99+/kiiS9x77/VA81IJTcg2CPOvGpynI1laSM8ZZqdbcSKmKyI6tWZ2cyxK1yehO+uh+w6TWlMnW6LyzljuZIErx5fcS8JHwW3KKz04ka2fW93EKlt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pPwuCjRl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24936C433F1;
	Wed, 27 Mar 2024 14:58:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711551535;
	bh=/qS4x09dYgY6sXrlC/UAO2mdxYkbcHDpH5G5a5KiSBE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pPwuCjRlr2pf6LvffM7s/dfNggx+aqFSMFLisJ1jTW/SuAe+ldFFxLBE0YxDXQQBp
	 rAi/m9dBaeqalOhAkjEM1aaW1pjMabgz/cgxhJ17AavvRlVqcoqoac4PSds8htaok1
	 K31oIFDom5coSJuhQ7soLqmzmvrsLxw1jkQidAl1lLduL+ie7q/MbllbhlZ452mTm7
	 HFzKaPfd68ysqzGwO8dkt3pTLJppzHr8XpUQa+QqZ3i+PsctWCPTNfJNd6d+PQiMUt
	 HlZumMd6hU3V+G8vjBKytgsBSgy89g46+0F88J3oPA3kHrKT8SKGiPhvJnFFn7jrR7
	 ec5Jj/hBDkckw==
Date: Wed, 27 Mar 2024 14:58:50 +0000
From: Mark Brown <broonie@kernel.org>
To: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
Cc: alsa-devel@alsa-project.org, venkataprasad.potturu@amd.com,
	Basavaraj.Hiregoudar@amd.com, Sunil-kumar.Dommati@amd.com,
	Liam Girdwood <lgirdwood@gmail.com>,
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
	Syed Saba Kareem <Syed.SabaKareem@amd.com>,
	Jarkko Nikula <jarkko.nikula@bitmer.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	"open list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." <linux-sound@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] ASoC: amd: acp: fix for acp_init function error
 handling
Message-ID: <e4ba58bc-fa5b-4ece-8906-f7cc7cb5b0f4@sirena.org.uk>
References: <20240327104657.3537664-1-Vijendar.Mukunda@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="HHnNWzSd/b2J4Dry"
Content-Disposition: inline
In-Reply-To: <20240327104657.3537664-1-Vijendar.Mukunda@amd.com>
X-Cookie: A rolling disk gathers no MOS.


--HHnNWzSd/b2J4Dry
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 27, 2024 at 04:16:52PM +0530, Vijendar Mukunda wrote:

> @@ -115,7 +115,10 @@ static int acp_pci_probe(struct pci_dev *pci, const =
struct pci_device_id *pci_id
>  		goto unregister_dmic_dev;
>  	}
> =20
> -	acp_init(chip);
> +	ret =3D acp_init(chip);
> +	if (ret)
> +		return ret;
> +

The return check is good but shouldn't this be a 'goto
unregister_dmic_dev' like the above case so we do cleanup?

--HHnNWzSd/b2J4Dry
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmYENCkACgkQJNaLcl1U
h9CYOwf7BZiqXeDfs5qRdUvEV6cGZnFIAaeLR8VhXpILbSHzmNxBzmFxPAC3BGQI
xKGZ7bBdvf4funwt/P/PKxFh7p0o78PjkO9pzru4987ZlqH19RmzJvcc5+DU7lY0
Phf3ttUIpmZNDdXQi08pvBOLpJFsynY4v+EuUIpTdGLOHNB9k/Y5EKV3ZMV2pWn9
LFqxzfV00O03xEu+q7Dm20GthUd9c+pVRehCB7ZgFABe+39fZAclAnumiDS5WhMO
i/uBEQTku/TMKuedQPP5AwG4kB4ZLIkYihT5X968UG270soc7b8dP9tKcAsbuz9p
WEEvxqDuH8qQZ2/8VT0ipDeTOAbmAQ==
=HydH
-----END PGP SIGNATURE-----

--HHnNWzSd/b2J4Dry--

