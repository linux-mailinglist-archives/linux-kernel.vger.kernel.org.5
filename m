Return-Path: <linux-kernel+bounces-86609-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E46086C7C5
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 12:11:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 96516B260B6
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 11:11:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE1B17AE70;
	Thu, 29 Feb 2024 11:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hvfhJMDP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B0DC7AE5E
	for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 11:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709205093; cv=none; b=Weil3cjL3t8uyUr45jdzJXokiH2SNRMZ2gOMnrgESaIHxjU1vkTEYBOh0ClBRkSDG8e3Q9zwu7FeMQ5Yx3ur5cVPlxbHPWrciRe6QqqNeWHty9eJ0+Tv+kW6DO5rSKLVL1JMJZg1gCetNJwaVO3NpL5bW/GEPfE0moWqX6Y+DDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709205093; c=relaxed/simple;
	bh=d5tKBM4lQdnJg5jVjnRbrSiT4YEOoJ6/xA5T8pInY5Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pp7AQxSPHCEsmQKoH3tPwGLfECPAvI2uqRZzwYg4zWEfQRygOwvI9FnYVnV66Is3Mz3wXaFSO10hxFLYJ5VxbOxt5alo9WnuIngucmVHOIo18UlQaobUV903eYp7XHrfqBgChuQ/2lt9M8dqCvb/Z3FRRBIcIVk+9W1UyQMX3bA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hvfhJMDP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9A05C43394;
	Thu, 29 Feb 2024 11:11:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709205092;
	bh=d5tKBM4lQdnJg5jVjnRbrSiT4YEOoJ6/xA5T8pInY5Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hvfhJMDPIVoh6ljM0vIXrwsTQAv3j+TvdbrpdRC/MXe3xra9jB8fYfqRNDSeoJXA6
	 koO1MUWoGAuygHIg26eGel8ij+sPcGuktYDx3ubby3eJeJw7z5m/uL2V7US7rMC8IN
	 bl4QCQRtDl4sQrQqgWtWyErCIZz7ltNVt+POR5db2xeR3x0mMS2xGBaivPp4Y98Hn0
	 +tlZpfEN6LWz+hken7tJNlhDYDq/lF5cj4ZOh8jBNMjoUFR2FG2FENMJKNF4yaWenb
	 x+UmOk6mPgYiDPJqgc/1p/JOYiuuZkuUkkkPG9N9PK7UGlOmaVXO42/MNnSJcipt3L
	 d2Mqm4kFXeFRw==
Date: Thu, 29 Feb 2024 11:11:27 +0000
From: Mark Brown <broonie@kernel.org>
To: Anshuman Khandual <anshuman.khandual@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, catalin.marinas@arm.com,
	Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2] arm64/hw_breakpoint: Directly use ESR_ELx_WNR for an
 watchpoint exception
Message-ID: <17d23998-555a-4349-a31c-edbd994ee013@sirena.org.uk>
References: <20240229083431.356578-1-anshuman.khandual@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="0F5ctlZHJbD6I4Fx"
Content-Disposition: inline
In-Reply-To: <20240229083431.356578-1-anshuman.khandual@arm.com>
X-Cookie: Marriage is the sole cause of divorce.


--0F5ctlZHJbD6I4Fx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Feb 29, 2024 at 02:04:31PM +0530, Anshuman Khandual wrote:
> Let's use existing ISS encoding for an watchpoint exception i.e ESR_ELx_WNR
> This represents an instruction's either writing to or reading from a memory
> location during an watchpoint exception. While here this drops non-standard
> macro AARCH64_ESR_ACCESS_MASK.

Reviewed-by: Mark Brown <broonie@kernel.org>

--0F5ctlZHJbD6I4Fx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmXgZl4ACgkQJNaLcl1U
h9DsMQf/bLFLnKVwqtg2eFtp72ISD62Oi6TcLj3Fti0uikrHVuGdHVas5vobz74T
BFT07oEMZbdPu7lkpPp4PpQT2/qeqgc7jUlWgNhBLHJhi0dbcbT7XvesuW6TaFHM
PN6ILweesku5j9SZBAoTIESYxdAhWWLW2HtZy2ncLktSBOIwNazNaPjvb6EmMcr9
0ZEHFtUmIXSfF2UU2Q416XeJamowHL+McUv+viE9SQFM/nEl9FTS4WYlcbDynv0l
Chs0cgWYKgGaHoNiHNwYRGDvcc/OggAk28k48YtR8+M0/xbqe55MMujjcP/jtPrA
DYC+3msB5wQ1YENaujpyz8EIM96/kA==
=J7SQ
-----END PGP SIGNATURE-----

--0F5ctlZHJbD6I4Fx--

