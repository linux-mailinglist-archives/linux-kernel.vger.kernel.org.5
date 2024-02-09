Return-Path: <linux-kernel+bounces-59193-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16E4884F2F1
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 11:10:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7744AB223AD
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 10:10:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0ACA567E98;
	Fri,  9 Feb 2024 10:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bpXS4CvE"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 441A267E84;
	Fri,  9 Feb 2024 10:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707473392; cv=none; b=XuZjSo1i1HyOKZgx49aIT/4sSHrJgAN9eG01p3m8wbqFlaYHtx3IaTho9QbpwkdH+aq8o/OKXFEef24c49rp3szPr/ixsMCqCv7oBfhF0Ua6yzsrz/Sv8kZ1c5TUNpK1AIBjkQJJaE1HmCM32y0o1q5hmWZ0XA+5gXkC1cDgIPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707473392; c=relaxed/simple;
	bh=yRNoC0/A8esDUggePK0DVBtZR9HduL2lxp3Yk/zSuBQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=efpLjbPZJIRo+/U6/VJ73zBT8G+L3jfme20IJSYaBnY5Se+n4t6CmzfrQ4X6UglnZ3BV2QZYGYYMlS7wGI7JL52m+5p+0uaVF8M5d4emaY4fQtPlDtwqJN61JvJjtQSFgwQoFSnhAUpflm+k+tudRRqssUOy3U5aV3CV6as79HA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bpXS4CvE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4ACEBC433C7;
	Fri,  9 Feb 2024 10:09:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707473391;
	bh=yRNoC0/A8esDUggePK0DVBtZR9HduL2lxp3Yk/zSuBQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bpXS4CvERq0AdZglblnmTRHUmE7ZFupb2IMYMzqrdsF5G4bmypyFYcQnfURzWLdv8
	 Ropi/cUuUeV3dkMuhDIrWmjLDinQRR9/T/ii67CIqvjVHjaua1+dzZ2uIe8pUSEXqo
	 aD6SI9UDsudGcR50Jv+jASJex/9aaFKuOLOH0CsscbJjq0a9l2a3KL4f6V+y4O7cnq
	 JOJn9s1Ly2V9HH38aJTCSrgoRDbJRbdq6J6vygrYXBXlCsQj5CoAmaHCLpLeOvd07i
	 GdrG9IItxrQsNPQ/rrXWjwcUpLbw/IEk22bA1W3UeTObplIqqx78SfvoS4auKTApMG
	 DbXSHUwPTkybQ==
Date: Fri, 9 Feb 2024 10:09:48 +0000
From: Mark Brown <broonie@kernel.org>
To: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Cc: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
	Bard Liao <yung-chuan.liao@linux.intel.com>,
	Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
	Daniel Baluta <daniel.baluta@nxp.com>,
	Kai Vehmanen <kai.vehmanen@linux.intel.com>,
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
	Venkata Prasad Potturu <venkataprasad.potturu@amd.com>,
	sound-open-firmware@alsa-project.org, linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel@collabora.com
Subject: Re: [PATCH] ASoC: SOF: amd: Fix locking in ACP IRQ handler
Message-ID: <ZcX57PGUn5cABns1@finisterre.sirena.org.uk>
References: <20240208234315.2182048-1-cristian.ciocaltea@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="IuqgEAM0x+m4fEnK"
Content-Disposition: inline
In-Reply-To: <20240208234315.2182048-1-cristian.ciocaltea@collabora.com>
X-Cookie: You might have mail.


--IuqgEAM0x+m4fEnK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Feb 09, 2024 at 01:43:14AM +0200, Cristian Ciocaltea wrote:

> 1707255557.133976 kernel: BUG: sleeping function called from invalid context at include/linux/sched/mm.h:315
> 1707255557.134068 kernel: in_atomic(): 1, irqs_disabled(): 1, non_block: 0, pid: 502, name: irq/66-AudioDSP
> 1707255557.134089 kernel: preempt_count: 1, expected: 0

Please think hard before including complete backtraces in upstream
reports, they are very large and contain almost no useful information
relative to their size so often obscure the relevant content in your
message. If part of the backtrace is usefully illustrative (it often is
for search engines if nothing else) then it's usually better to pull out
the relevant sections.

--IuqgEAM0x+m4fEnK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmXF+esACgkQJNaLcl1U
h9DSxQf/d6GVw2tDhiA3reBn1nr1lpMNoJpqSmW9LI7+ZwfXBtwfK+1xI3DjoqFM
90ukE68PxF5SJ4L1xYBUD5lHeTrpV78UQbKjHIJKQgPi2n2Hxj6dLHJzLQYIt2JW
TT+OglBQD5JsaLl5glwxVlSDXit6EIe7TtFJvkXQvMla1fwsHqsTF4ciKKeX9iKP
bDfIsFeveHpMaqRFZ7rLvpIA/Q7TnqPAJtnDBFe2+IOQykH8kDrA67mh5iE65NaO
3vputeWoemUczl1iYaxTJZ6R2b057TQ9GdApVXhWuxv6OQoB5zRDmonETjwBx25e
giAumOOzNxhN76YmbPT5ltFLb62jRg==
=wgNY
-----END PGP SIGNATURE-----

--IuqgEAM0x+m4fEnK--

