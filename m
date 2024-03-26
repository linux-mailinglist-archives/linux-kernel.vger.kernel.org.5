Return-Path: <linux-kernel+bounces-119495-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 346C088C9A8
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 17:46:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C411C1F821FF
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 16:46:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2A6E1BC39;
	Tue, 26 Mar 2024 16:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zmm6/IXs"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D4BE1798A;
	Tue, 26 Mar 2024 16:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711471578; cv=none; b=l4PQ5Br96An+kTbKrdz3TzMne6dnL0PBMSxmoOetthaD3XKDPZb44n4gtQbSyTRJlptrd1DYFl8wtLcECC3VmKD56T+NrJUy3jpSkJKLfRUd3uzDgCXmzOKOkaeUqdVDcsotURYwNQonseCps1SSyDDhO4qCi6oIEh8Zlk00Djo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711471578; c=relaxed/simple;
	bh=ZxM4G3wey3BGq0FKQ5QmpygX01UO4gnXT52HSKPAB3Y=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OCSetxYyvjyCE89xo0zlzXjF+zczMcB/S8I3I2IUPQ1upXm4TQ3oJi9iw0Aus4Zq+4L+sPfGIwtDlsYLMxWxVxcw2cLL5sOnTYXM9O0DAx4HAt8o+41chZH5QmZ8kp4jKxAvGTdQP88r3g9p+J6vBweI834Z8G/sqqFQly9XdKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zmm6/IXs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41D17C43390;
	Tue, 26 Mar 2024 16:46:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711471577;
	bh=ZxM4G3wey3BGq0FKQ5QmpygX01UO4gnXT52HSKPAB3Y=;
	h=Date:From:To:Subject:References:In-Reply-To:From;
	b=Zmm6/IXsWQ4h43X/u4GRrPt8zqbOP+AlRxUwu2Q/g0mb48tjXQ9QCHfwul2V7P0rS
	 7/wFGPQ8yOJAIXxcttUca0zzqwvAryCqx0XKVt3eURvam6lcHvdV9xZS1roYJBwBAc
	 Ra8Ovwlo+AAejvmTiRjx5HZVUnNziLDnjfuOSzIdpWZezrSpH//hlcXODGgz7u1AGh
	 18YejGbvAWhAE+rI/iXdFyTCageriym9/Sh8skIi+73n7Y6RJfbR75iFsNTh3kZCYI
	 NphiuT0mDizHveRxk2jvTGPi4125hTIOFLtqNCEI8iIa+H1TdTiR5MPJ6qjZ4jk2Vl
	 Jpix1+xrB53rw==
Date: Tue, 26 Mar 2024 16:46:10 +0000
From: Mark Brown <broonie@kernel.org>
To: =?utf-8?Q?Ond=C5=99ej?= Jirman <megi@xff.cz>,
	linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>,
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
	Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Arnaud Ferraris <arnaud.ferraris@collabora.com>,
	linux-sound@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev
Subject: Re: [PATCH v3 0/4] Add support for jack detection to codec present
 in A64 SoC
Message-ID: <ebcae0f3-b5ac-4c1e-9a37-c7d58a564195@sirena.org.uk>
References: <20240302140042.1990256-1-megi@xff.cz>
 <171146686191.132239.8280140430376443574.b4-ty@kernel.org>
 <2vhd45kylttgonosdcfn7ugwyy2vx56gijwf3ealz4tel65iqr@cs3kxrl6d2hh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="0y5Ly+iol10WH03x"
Content-Disposition: inline
In-Reply-To: <2vhd45kylttgonosdcfn7ugwyy2vx56gijwf3ealz4tel65iqr@cs3kxrl6d2hh>
X-Cookie: Equal bytes for women.


--0y5Ly+iol10WH03x
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 26, 2024 at 05:33:14PM +0100, Ond=C5=99ej Jirman wrote:

> Coincidentally, Intel kernel test bot found an issue today that this fail=
s to
> build with CONFIG_SND_JACK_INPUT_DEV disabled. Should I send a followup f=
ix or
> should I send v5 with the fix integrated into the patch that breaks?

Please send a followup.

--0y5Ly+iol10WH03x
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmYC+9EACgkQJNaLcl1U
h9CNawf/UmpDYDZvQrYV8oU7dWL/FIeOKYSzjpAsrpf4DW68Za0ZdVc0PVK6zRM9
eiNrQRM5q13TpYKBQXJMIlZxIhk+c4VfjT0cpYv8zX5MYYCg+mlGUkCGcuN2C75v
+4vCAQEEEw6zHX+30YNU27jLK9sEc35GSyBXWY1UVJFpbjm4gV3aHC+l93zsrl3Z
MIVAnNzuZZ7ils7JRYmdKMF0+s/R4XE3Jtkviy3/wdV8P0sobh4kK4ihIWDdHsvg
7Ri3nyWP7eM7mwapZA/QzKU5xjfNQyuDcLQWRgoYiyPLlwXuK0HqzIo3Gmog+cPI
YkEf4sliSd5tDKvr1kXkrna7nAmGaA==
=Mpn6
-----END PGP SIGNATURE-----

--0y5Ly+iol10WH03x--

