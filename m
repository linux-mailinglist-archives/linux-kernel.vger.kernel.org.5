Return-Path: <linux-kernel+bounces-81859-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C7A0C867B0D
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 17:02:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 703AB1F22CF0
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 16:02:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2CB912BF39;
	Mon, 26 Feb 2024 16:02:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZOE+VB5n"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3786C12BF00
	for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 16:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708963370; cv=none; b=SQC0R/3LA/xAVDUSCF78zr7elqldpJHoXsdzjo9aW+ktLwocqmQWYZRt5RJsyCLzvTC7sre3SjkWayAWUOA8IOTmPLG0jyGggs75U34ya6ipGwLEt6AMM8iBA3IK+2HpSxWJKHZHhxcL4tmcyYiMyLF+cWHCidcAJvMsGkW8JFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708963370; c=relaxed/simple;
	bh=CJxmj18L+u9NtRIEmmMRA0bmpUKvIcZuLUTtSw+eVhA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=unTTaRhdWObgtdlxqziw0wgBeHZ/TS/nFXbIzF+NCvI7oMrKIAYA5YYo2ElAIImZ7riB5A4QZ5pDZkXeJ9Zm+u58nSMN7YTqo1elPx6HhsWl7CJpDZATbjgqvhlY849iWybqCEEKwqhvj9WtN5OafNPllzjj2TgFGQ1pkRUf+/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZOE+VB5n; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42EC6C433C7;
	Mon, 26 Feb 2024 16:02:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708963369;
	bh=CJxmj18L+u9NtRIEmmMRA0bmpUKvIcZuLUTtSw+eVhA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZOE+VB5n2vFS70HFpzM8RFYpzuENj0G42xI2p0I0i083vDmCWs1nN4o+tdgESD+BD
	 Zke7NWQXlGtu5KalcwhCS5KSbk7+6QYhbi8uHVnTtBFsJL/BL5P2CzZmY/unE+QXJK
	 ssVdIyRHCR7+E2RLbBlagOdNYzFDpQWuU8uOuZcmDtchqUXJ38vigv3hESk4HigKMr
	 +rFnfgbT+thKe3IEHIRjGuv+6foURL3PMQu8VKAAJWSI8ttH5KsfuVRQ8PIVGpJO5z
	 CBXa19wdCYRlIDXD/1FdRNQuaxm2J9w9RBazb1cTjUTiiHJQg4PbRIDPRMy1M8MUWl
	 EmGeVwjfXTVYA==
Date: Mon, 26 Feb 2024 16:02:44 +0000
From: Conor Dooley <conor@kernel.org>
To: =?iso-8859-1?Q?Cl=E9ment_L=E9ger?= <cleger@rivosinc.com>
Cc: Samuel Holland <samuel.holland@sifive.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Conor Dooley <conor.dooley@microchip.com>,
	Andrew Jones <ajones@ventanamicro.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	=?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@rivosinc.com>,
	Atish Patra <atishp@rivosinc.com>
Subject: Re: [PATCH] riscv: deprecate CONFIG_MMU=n
Message-ID: <20240226-pajamas-okay-51e16426b0f5@spud>
References: <20240226140649.293254-1-cleger@rivosinc.com>
 <40dee2c1-ff24-40b2-a13c-6934139ba869@sifive.com>
 <ea356036-5a0b-47ea-aafb-f9813cc6ec9b@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="ubQpPdZaAd0QnS6C"
Content-Disposition: inline
In-Reply-To: <ea356036-5a0b-47ea-aafb-f9813cc6ec9b@rivosinc.com>


--ubQpPdZaAd0QnS6C
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 26, 2024 at 04:25:24PM +0100, Cl=E9ment L=E9ger wrote:
> I guess I could also mark XIP as deprecated.=20

I'm not so sure, people recently added XIP support to QEMU (and sent
kernel fixes in December). XIP is also not nearly as much of a problem
to support, there's far less that it does differently, the main barrier
was the inability to test it which is no longer the case.
That said, XIP is gonna kill itself off I feel as it does not support
runtime patching and therefore is extremely limited on extensions, given
we use alternatives for all of that (although I suppose if someone has a
usecase they could make nasty macros worse and implement a compiletime
switch in the alternatives too).

Cheers,
Conor.


--ubQpPdZaAd0QnS6C
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZdy2JAAKCRB4tDGHoIJi
0nVMAQDYR93JQOut9mfMM8BH9MJ1F4/P4n478Z+nECkRjgzk8wD+K0fPpyls98as
yyR2HfqkmqE6DQSWZpf9BlfbolsuVQ0=
=IP3Z
-----END PGP SIGNATURE-----

--ubQpPdZaAd0QnS6C--

