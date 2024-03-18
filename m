Return-Path: <linux-kernel+bounces-106463-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CCA0187EEED
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 18:35:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 091911C220BF
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 17:35:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77A5E5A11B;
	Mon, 18 Mar 2024 17:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AIq0amxb"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB6485A113;
	Mon, 18 Mar 2024 17:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710783201; cv=none; b=hbMLMMibo6e/RfZG4fAp7rIpNEjPfg1zrH/7yK2xUzl7So/mErgV5z3PbFLhyDZTAs5mBWeoHr21KdfVny9HpChuApb4Bg05bfaB4MgpmF39iYNqzVVDqVHwza3J6YTjkx1TcHZXIbgZDZCq5xJPHVMVyAhzFopg+hmRPdA149U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710783201; c=relaxed/simple;
	bh=iVPc2rWGJo1VZzkACemtyOrNMiczPeweEtn/WAY7rh4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qjXzCFd0hr+F6fnpziV2ZIRGv58xCbfLV+qq1I6V96DvCE6d62Yw3Q6h+KOrFDTxwgKSVeWBAbZ07ijks1PzJL3Rw5Cio6o+k8FWkZ7wi32Apd3Tg9ITPxDWqO4TE267yfLShdQ4jYV8+Cp43kFLn/cPQkSqyYFCGO9f/KcX0yk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AIq0amxb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56FFDC433C7;
	Mon, 18 Mar 2024 17:33:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710783201;
	bh=iVPc2rWGJo1VZzkACemtyOrNMiczPeweEtn/WAY7rh4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AIq0amxbpun2fG6L3swkc7LZelqRqkwUnEZ2lI/3ETAMcMHdltgoLnZMBbwau9uCq
	 VeZ7oApwDmgD9unfXuJsKohK/iCCCmzJwLYJpvBWT6wXy/XTzD9IJWo+Zi5yQmipKS
	 Vwlz+OVMGite8ESLx1nkAdBMVl5+ryvaB8XXL1NcYl1thdYZhgCwGwc62c5Iwm/0Nf
	 dmbVk2vGsQIYK6T6umIgsqRNC6Af3FjUAVWfHqDLBPvsyu7h3dacTPi4H8vTHoSPPq
	 UyZ5l06xgnqiq2ICuCOd9xlfp81YcEvE41wcro45enHxUToO0Ao96xErt4OQCjyT8i
	 mxcczin1rbsdA==
Date: Mon, 18 Mar 2024 17:33:16 +0000
From: Mark Brown <broonie@kernel.org>
To: Adam Butcher <adam@jessamine.co.uk>
Cc: benjamin@bigler.one, carlos.song@nxp.com, kernel@pengutronix.de,
	linux-imx@nxp.com, linux-kernel@vger.kernel.org,
	linux-spi@vger.kernel.org, s.hauer@pengutronix.de,
	shawnguo@kernel.org, stefanmoring@gmail.com
Subject: Re: [PATCH v2] spi: spi-imx: fix off-by-one in mx51 CPU mode burst
 length
Message-ID: <a9882abe-d137-4c3c-bad0-212e9d0e5ea5@sirena.org.uk>
References: <98914a36-e5dc-4f44-bf3e-c237d803a7e8@sirena.org.uk>
 <20240318172415.1588-1-adam@jessamine.co.uk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="AQblbqaHfFSPYaMe"
Content-Disposition: inline
In-Reply-To: <20240318172415.1588-1-adam@jessamine.co.uk>
X-Cookie: Alaska:


--AQblbqaHfFSPYaMe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Mar 18, 2024 at 05:21:48PM +0000, Adam Butcher wrote:

> Shall I send a v3 correcting the hash mentioned in the commit message?

Yes, please.

--AQblbqaHfFSPYaMe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmX4etsACgkQJNaLcl1U
h9DPcgf/YJ822vnVEC0fRIYXMf45uoqUYzs/KH7cJcEqzwHBElKuJHLL0b3P/SGd
hX1QRt12HdyOhUayUq2G4Y6Ol0MvRyKYPLBBUgVe3Rglt7xpiwEqttEqaW0Z/1JF
L8K9R/Lq2MQztsjB7BmcZdMucfBtfFAYXr+Smo4uygRkK0fY53GPb+CaervMp0Ct
19ozLzrfJ7qWnN/ui0wG8vJAswjFjp+jh+bQBSwi9bmed21gx5OODjsk/P6NqftK
04CxqnxMNJReUzea3xKxoYUsg0e4/u1yVdmX4RfWaDuoY3Ynq0aEdkJBIR6sj5fI
FhcNDd7csZVI7VU3bqeL+ITDlXBlFw==
=pTov
-----END PGP SIGNATURE-----

--AQblbqaHfFSPYaMe--

