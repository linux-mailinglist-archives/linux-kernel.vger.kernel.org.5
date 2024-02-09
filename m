Return-Path: <linux-kernel+bounces-60050-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5142084FF18
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 22:46:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 11D6D1F23D51
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 21:46:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1600524B57;
	Fri,  9 Feb 2024 21:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D/aXXV42"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C68021362
	for <linux-kernel@vger.kernel.org>; Fri,  9 Feb 2024 21:46:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707515167; cv=none; b=d4hC3VprWBxAeKkTzQ1CD3ikqqKSxw1tvaF2jcJ/K/jJh7Ho02upqE+0amqvjgb9ennzRjRGx08OcHgU8LtkjgV+8uYsIhUzJtOaBaovtywcpxsTGW3Tacscp4k9UnZK5d9Og3/PK0ElN9kdDpWXlKbUDCvpBaL8f0lOC8C7LKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707515167; c=relaxed/simple;
	bh=HqJDcrqqF3iT8cX5nfFkNgUMR/WerJBQVvwSEWP9Th4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rZQxgsJVj4t6JSZbMSsaBKcvItZWeaNAzXOCZ8+XChsr+Pzf+EvNZe4/GV+UVKLBXanve0LM9jGsR2ZEpSfgIC9Gnb5tFgAybDKdkrqTHzoXQb7o5m4+EZiHJJ8eXkFJmtcytYl19ElgND17ZunmU2FW48XKrhGsp8niuSCB3ps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D/aXXV42; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB7D7C433C7;
	Fri,  9 Feb 2024 21:46:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707515167;
	bh=HqJDcrqqF3iT8cX5nfFkNgUMR/WerJBQVvwSEWP9Th4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=D/aXXV42qbETevUQmfOP/in5yi2lDRYzDVk3XoH+OOHRVQdStryxpUwTzQ9OnjXYj
	 g9acDDGhMa1nlr7Mgm6KyFALQ2Fw9WvO8qsw9D7zHhbHHUhUIfJsty0oOamnmnHWgi
	 Qcn2JmyjsnMgyueKrvT4G7tg/384zHmJ1Hu3MHpZpaItIZyNp+w71XU2AkOhDsE5kX
	 MV0cZXnXEVtjv+YlNkgR/cpIz9wxVyuO4NGKw4AbNnk2gSAMR3wSkwfIHKjXE2V3au
	 FnzbFgdQ9rVWXmBn6Tx8jnzAJAYiA+QQTaxdhsWuHUOyU8YJ0z5BVhW3TCtBfFLU8n
	 G0TyvveeLng0w==
Date: Fri, 9 Feb 2024 21:46:04 +0000
From: Mark Brown <broonie@kernel.org>
To: Guenter Roeck <linux@roeck-us.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] regmap: kunit: Ensure that changed bytes are actually
 different
Message-ID: <ZcadHAEN1N0DwR5w@finisterre.sirena.org.uk>
References: <20240209-regmap-kunit-random-change-v1-1-ad2d76757583@kernel.org>
 <ZcaFmYGClhpj82Xo@finisterre.sirena.org.uk>
 <2c8c5fa4-b0f7-4ca5-b003-4b37cc036664@roeck-us.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="dRuoBPtY5NJGjJJ8"
Content-Disposition: inline
In-Reply-To: <2c8c5fa4-b0f7-4ca5-b003-4b37cc036664@roeck-us.net>
X-Cookie: You might have mail.


--dRuoBPtY5NJGjJJ8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Feb 09, 2024 at 01:25:36PM -0800, Guenter Roeck wrote:

> +       get_changed_bytes(&hw_buf[4], &val[0], sizeof(val));
> +       // Let's cheat.
> +       // Remember, the above code doesn't look into hw_buf[2..3],
> +       // so anything might be in there, including the values from
> +       // the val[] array.
> +       hw_buf[2] = val[0];
> +       hw_buf[3] = val[1];

Ugh, yeah - I'm paying attention to too many things at once today I
fear.

--dRuoBPtY5NJGjJJ8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmXGnRUACgkQJNaLcl1U
h9AtnAf/faluBZ71OYnT4NepQ4I3ruAB22rhDnDwZTz/WZVWmhyICUJ2Iev37AXA
CExhxNncREfqPVxc4hncqquqgJjCr3Q3Qd9qtGWwnw1th72YhLTKzjz0qCC6k0cq
ZVhCU02U2gEeDdEP7MJy85HLXbGwHYCKroA6G4P6tWLMZsKRkiP8pzuKjTQKcjz/
Yrc/uj8QnVFJX+dZmd+itfMGorxiSwwpsY8ezv+LxIQd6rsGKrn4l4YJYOtUlAvJ
MUhtwHi5r0SuWqzSc/14mEfZRp2W38bCP5OhWpXClt4HwZujG0KQygHh8guZsH+Z
PKn8/2AUNs7HszsxoPb54r8+2ieBOg==
=oG8N
-----END PGP SIGNATURE-----

--dRuoBPtY5NJGjJJ8--

