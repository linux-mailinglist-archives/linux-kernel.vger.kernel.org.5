Return-Path: <linux-kernel+bounces-119909-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55E9088CEE3
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 21:33:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CB645B23CA4
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 20:33:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C872813DDBB;
	Tue, 26 Mar 2024 20:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="baW8rhi/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 187791272D1;
	Tue, 26 Mar 2024 20:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711484776; cv=none; b=V3GxRWgI355qszTJZtI106lXv45A67NfqQVweiDlDDssjegK4umeKifUF5F9mlH46BNuGuwHa7NIGV+mC2edDaeuLIxTGY829S04UiWHkq80IAL6uH4H+bgLfpj3nIFM5OpJ8HHgJ2MBMXeXSZPvaXBLXfIjcr9SHs5ZzkjKQgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711484776; c=relaxed/simple;
	bh=eDbzRqtFpSYGqJD+vCkzwx3pMaQshbduGP52CcHwYU0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oHXJHeUZ/ol5dijC58LUWQ4XwUueGXYJDqNp49YUzChhPRZB8szdrGBR+hXlPph+znIEEHc4aG5HpnvsIcybxy/mDSVJgaqh2kF72ALg89cto63T8Y2mNW3KMcFdEVUJFKZLlIenTQ4218ndCkVuelIrbr9rs3pOvcIR7wT59u8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=baW8rhi/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4254DC433F1;
	Tue, 26 Mar 2024 20:26:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711484775;
	bh=eDbzRqtFpSYGqJD+vCkzwx3pMaQshbduGP52CcHwYU0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=baW8rhi/eBoXXSYTjrElwZKagtIbix+ddEGxHoeszhVRoSCyUM0wOOYX6JrUuXH9n
	 J6dATj828lzSCPm80grtiY6gJvYKLtsLUndqIiFfcdAi76KHPsyw8h8/Sy56IKSciU
	 qLHmNKrET7BGTTUob07WNkOhwK0D7tpfRm1zg8q0CEO1dOP4zg7ogl3AHGK9WAU2J+
	 8OEaVjo+YlxRlzIqcZ0/9Hkp5aZg8wYHnuunfnN3X+wCmWbJA56kizsuWJ8LRN56pG
	 61S5hvlnoa6hNRRdPZ6vB85D1YpyNMymu7p/jbnhTd8ao8LXGkYQpsQ7dBStrSQY2o
	 PlDDv9dFdui4Q==
Date: Tue, 26 Mar 2024 20:26:11 +0000
From: Mark Brown <broonie@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Daniel Mack <daniel@zonque.org>,
	Haojian Zhuang <haojian.zhuang@gmail.com>,
	Robert Jarzmik <robert.jarzmik@free.fr>,
	Russell King <linux@armlinux.org.uk>
Subject: Re: [PATCH v1 07/10] spi: pxa2xx: Provide num-cs for Sharp PDAs via
 device properties
Message-ID: <6f6c96d3-051a-4437-9c95-6b8be7847705@sirena.org.uk>
References: <20240326181027.1418989-1-andriy.shevchenko@linux.intel.com>
 <20240326181027.1418989-8-andriy.shevchenko@linux.intel.com>
 <dcdf8c46-acdc-466d-afc6-caf0e0fa39e8@sirena.org.uk>
 <ZgMY3AeC1Jnh1Oru@smile.fi.intel.com>
 <c18186c0-63d8-4406-add0-980f723e3528@sirena.org.uk>
 <ZgMsHFJObZ48Erzt@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="0LNDcKcwbpLMu5zZ"
Content-Disposition: inline
In-Reply-To: <ZgMsHFJObZ48Erzt@smile.fi.intel.com>
X-Cookie: Equal bytes for women.


--0LNDcKcwbpLMu5zZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 26, 2024 at 10:12:12PM +0200, Andy Shevchenko wrote:
> On Tue, Mar 26, 2024 at 08:02:57PM +0000, Mark Brown wrote:

> > It is not clear to me that this makes the kernel side better, it just
> > seems to be rewriting the platform data for the sake of it.  If it was
> > converting to DT there'd be some stuff from it being DT but this keeps
> > everything as in kernel as board files, just in a more complex form.

> Not really. The benefits with swnode conversion are the following:

> - reducing custom APIs / data types between _shared_ (in a sense of
>   supporting zillion different platforms) driver and a certain board
>   file

> - as an effect of the above, reducing kernel code base, and as the result
>   make maintenance easier and bug-free for that parts

I'm more worried about the possibility of breaking things with swnode
support than I am for board files - with board files you've got a good
chance of failing to compile if things get messed up, with swnode you
can typo a property or whatever and silently fail. =20

> - preparing a driver to be ready for any old board file conversion to DT
>   as it reduces that churn (you won't need to touch the driver code)

The driver appears to already have DT support (there's a compatible for
MMP2 in there)?

--0LNDcKcwbpLMu5zZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmYDL2IACgkQJNaLcl1U
h9BJtwf9G8qdcmqRaRQccL0S0goWyGaaYxh5eP49M2As8eg64IuSOVa30FXfW+ke
vntCpKgujArlxntAYgt8XbhB3XRAdINFa2uLmWhW/qJiG9Icd5hVo0Vt4I0i/acn
9ji9rofezMx6Au+3hazpFcbg+Ak5C6lcTcHrgT4qYkqDoGrZGAmsOhGHUTR3StYu
Kpo91U+HSFx6lkTz2xnpw8qQI3HUkKVrf4B6xsX78i3bIH9c8h00ION5RDYHVlv0
fcT50pwd4G6CQxvlP3rvuFrTRh6Sr38IPyof4fiBVJ5kdL2s4x1TfITBi3cuQpC6
wb9/tmysiWFD7phe1VSVs8W4/RpmYA==
=32Ir
-----END PGP SIGNATURE-----

--0LNDcKcwbpLMu5zZ--

