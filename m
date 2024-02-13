Return-Path: <linux-kernel+bounces-64164-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D4698853AEC
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 20:28:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 869821F27F86
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 19:28:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E0ED605D9;
	Tue, 13 Feb 2024 19:28:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LoIAR+JM"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9840D2E3E4;
	Tue, 13 Feb 2024 19:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707852525; cv=none; b=qVZ2guBQMKdzxPfxuRFAOUxIAM4wvrbY7ylHRcJBMONFgvRhwpCYqthO9EFvuQt4vggvBx+V7bA+fc2oYZHmCIxQv/Fpnnz+cCTmpIOnLV5LFOMHTMBf5wTkKUEF+RwHs8EATuGnZ/nAB6VwyhWW1g7m0o4iXWQ7tCHbNC+RpRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707852525; c=relaxed/simple;
	bh=5NZfHEpoK2pgvpQmn+zBq28sPSpp5q49Kr7YjoVCrtM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aR9WEsYxAHbVqaz+SDvcDNQDgdQN7QM0To9JnBiT6btSNVRTwsKM0Dj3auB7qfxO4mDB3O5P11sekJpkjT4Ff7rz7KVrBVRx8lwcb8/VJlAMEGQa6W2ImIRyc9SawpipBwifuuFK4F4g3LXhAxGHXwb8snA0ug+/MnCHdkxhJdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LoIAR+JM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4268C433C7;
	Tue, 13 Feb 2024 19:28:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707852525;
	bh=5NZfHEpoK2pgvpQmn+zBq28sPSpp5q49Kr7YjoVCrtM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LoIAR+JMQSh6rKubrC77HEUuM9i9+9xusFm3mBbMPEZB1zFVC8WAi+P79P7vP2pV0
	 HYIegRCXj+SAa+EHRdiaAKW5gyoYrkZ+zAMfjDw0wmww4tkaAQnVpqjjKSjFIQZuoL
	 nifq2fKz2moHoxjc+3SMXRtWSbUO5vCnGZUtJF0jsJnZffXO/479UNLFEtBMHZlS0F
	 3dOWR+l8eciIKzvkpTrQQDtgGwNQpRFztz/zUa53hiXsBb1uzCtkIB57/3LdNYvU2s
	 X42U/t63AKQNyYVRpYA3ZlFTSIICRmKwO8cOHujz84MWgffPZUxColMHkE1uscdVpL
	 SXmpn8n6AGonQ==
Date: Tue, 13 Feb 2024 19:28:39 +0000
From: Mark Brown <broonie@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Martin Sperl <kernel@martin.sperl.org>,
	David Jander <david@protonic.nl>,
	Jonathan Cameron <jic23@kernel.org>,
	Michael Hennerich <michael.hennerich@analog.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Alain Volmat <alain.volmat@foss.st.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-iio@vger.kernel.org
Subject: Re: [PATCH 1/5] spi: add spi_optimize_message() APIs
Message-ID: <6900e726-dac7-45c0-a88f-7830c1c7e43f@sirena.org.uk>
References: <20240212-mainline-spi-precook-message-v1-0-a2373cd72d36@baylibre.com>
 <20240212-mainline-spi-precook-message-v1-1-a2373cd72d36@baylibre.com>
 <54623b74-872a-41dc-992f-71a586d145ec@sirena.org.uk>
 <CAMknhBGt0EyA_FcpXbmT-PStZqmZ_PUENHbVfgDFOwWcv5gTAw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Vu/aZ+4oRClrdlxp"
Content-Disposition: inline
In-Reply-To: <CAMknhBGt0EyA_FcpXbmT-PStZqmZ_PUENHbVfgDFOwWcv5gTAw@mail.gmail.com>
X-Cookie: Does not include installation.


--Vu/aZ+4oRClrdlxp
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 13, 2024 at 01:26:02PM -0600, David Lechner wrote:
> On Tue, Feb 13, 2024 at 12:55=E2=80=AFPM Mark Brown <broonie@kernel.org> =
wrote:

> > It would probably be clearer to name the parameter pre_optimising rather
> > than pre_optimized, as it is the logic is a bit confusing.  Either that
> > or some comments.  A similar issue applies on the cleanup path.

> Per Jonathan's suggestion, I plan to remove the parameter from this
> function and handle this flag at the call site instead.

That works too.

--Vu/aZ+4oRClrdlxp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmXLwuYACgkQJNaLcl1U
h9B13Af/Sg7oS1FfB9/Qrl4jfMCRKLNMs8JEHKGOd1M5Nu8SfTT/K0LA3Vb2rrJu
SkpFl8U+gGFaJAOFpTbKbAAC8wd6iKfOxQH34JpDm+SIXmFMTYYDkt1NcSgkU5j+
h0kIbOy/GVPz7k7+t529BYiXucPTAio/6ege1DTlYhfVRtFuteRJ6xBPzqHXkycV
7Dr81PGaY0NMa2cqjGwVQo/8oCf971g3IuixqBuXQZ0LSPbJgNWjXUz+1fd+D00v
qq2DK5pcYd5FUps3k60zKGz4bch/rq7hQ9WqlMdhOSC6YYGNLMiBmfGFP5NwuhvG
dRLiDxfQR2dRKO0HuKvTFw833Fn/RA==
=1RwK
-----END PGP SIGNATURE-----

--Vu/aZ+4oRClrdlxp--

