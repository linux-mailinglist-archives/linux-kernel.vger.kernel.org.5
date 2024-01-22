Return-Path: <linux-kernel+bounces-32446-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E340D835BD4
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 08:42:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D5462831A2
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 07:41:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A7691643D;
	Mon, 22 Jan 2024 07:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N1uaOB34"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B846B16410;
	Mon, 22 Jan 2024 07:41:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705909309; cv=none; b=oNauoG96/P4snj4Y30c1PnuFLCAkWY+4g3B+OtnwYaqX6KpKpiNFwbtCPqfzdPy/tc2oAhA5miX560rudAPwZ4MpREuc4IQrS+WH5fvnVWX6UfCw1dc4AoJnmArxmGlSjvtnU77pbULpze45FFdY1ex+JfoeemCmcTo8GKuzWS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705909309; c=relaxed/simple;
	bh=bNCnQp0ND/Bhd8jsEriViBmV+pDcacpd6HBwU8PIoQ0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qt7rX/FWFSJrkHbfWz0jJi58j7jzfblFd2CYsokAHOuw8+EVpLt1eB+NvS03SgwKdUiPb65OgGvmq+ml/lLB0aM8+Bg90ciGZLISInxtGxGfZ5kVv+kp/nEW4seJ0UPpYcK/ZFT7xVhPSiTTS+N6qzBp+3BLXHUVz+TThBDHRHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N1uaOB34; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D970C43390;
	Mon, 22 Jan 2024 07:41:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705909309;
	bh=bNCnQp0ND/Bhd8jsEriViBmV+pDcacpd6HBwU8PIoQ0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=N1uaOB34gDFPl5VgCSojvtB3kJLoAuXALTXH8M8PXB48+q0RzPXLgeiOZWpGlithi
	 qkFsXXxAmmVdkaObyI1c5dBA0XZvmGmQS5ZjOmsdELsxbqFHd/o1fgSu21/Qub1xzc
	 4QWHiAXJlV+pgMtIWN7G/5uSZUkb79z6lK7eWfIQ2XLpScPtr6nsBxmRU7CgsiM53k
	 7/JBW3HKmwzdTRZl5desoUu2GpDNwD1xNn8OXJWdeTOI5RU0VtPYgjRbAhIK/8fPR+
	 VZs5/t9m/cS8yIQPJlHnAK9sS/D2ASIRHn2Oa9MbSZScGYOJOxE26iu3WP369JHIxT
	 NEsU/yw3Jvv/w==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1rRowR-0000000071i-3V5n;
	Mon, 22 Jan 2024 08:41:59 +0100
Date: Mon, 22 Jan 2024 08:41:59 +0100
From: Johan Hovold <johan@kernel.org>
To: Mark Brown <broonie@kernel.org>
Cc: Johan Hovold <johan+linaro@kernel.org>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	Banajit Goswami <bgoswami@quicinc.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
	alsa-devel@alsa-project.org, linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v4 2/4] ASoC: qcom: sc8280xp: limit speaker volumes
Message-ID: <Za4cR90XoAaATq8X@hovoldconsulting.com>
References: <20240119112420.7446-1-johan+linaro@kernel.org>
 <20240119112420.7446-3-johan+linaro@kernel.org>
 <d54d3640-49bf-4a2f-903b-4beeb0ebd56c@sirena.org.uk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="6hBlhn91CWqsWzU0"
Content-Disposition: inline
In-Reply-To: <d54d3640-49bf-4a2f-903b-4beeb0ebd56c@sirena.org.uk>


--6hBlhn91CWqsWzU0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 22, 2024 at 12:03:55AM +0000, Mark Brown wrote:
> On Fri, Jan 19, 2024 at 12:24:18PM +0100, Johan Hovold wrote:
> > The UCM configuration for the Lenovo ThinkPad X13s has up until now
> > been setting the speaker PA volume to the minimum -3 dB when enabling
> > the speakers, but this does not prevent the user from increasing the
> > volume further.
>=20
> This doesn't apply against current code, please check and resend.

These patches are based on Linus's tree after merging the sound updates
and I just verified that they apply cleanly to 6.8-rc1.

I couldn't find anything related in either linux-next or your ASoC tree
that should interfere.

Could you please try again or let me know which branch to rebase on?

Johan

--6hBlhn91CWqsWzU0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQQHbPq+cpGvN/peuzMLxc3C7H1lCAUCZa4cQwAKCRALxc3C7H1l
CIxuAP40ZX5S3hcjEvbXjMLdYeKr/Nckfcn4BA2prKLZ4aqX+wD+Nete6gxhBX0l
Ms5y+h/uAsuqbIqbgFwhpapBjxXd+w0=
=Ejix
-----END PGP SIGNATURE-----

--6hBlhn91CWqsWzU0--

