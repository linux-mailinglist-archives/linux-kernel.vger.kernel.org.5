Return-Path: <linux-kernel+bounces-76331-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 055CE85F5B4
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 11:28:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B3DB92892C6
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 10:28:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EE6E3BB46;
	Thu, 22 Feb 2024 10:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qWwbxASk"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93F2B1B59E;
	Thu, 22 Feb 2024 10:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708597685; cv=none; b=MJZOAnFA+zYhTaxjFowqPqjvkrV/D0I4ZCi4VNWAl6/B11sk2BvtB2MMqvq6RXkZ3EtmYLCBSLmhgxpdthT8EiICsWwapZnNCf0EGWmpThZkY4kc5kKa21STBnLrb5p1hDyZJDNcpvMVDR36ckYmcEXaLYSd7foJWxktk0xG8Ds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708597685; c=relaxed/simple;
	bh=b4FUqCJ0EFJCW1Eb2H2P7CKrb72vkMjtY68vabwTKH4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Eai2Xyqr4l/VEO1wmWslUCUuZkWaU+/fBQ4llQyBQwnR9BRCMNCsi/Rj908Vvbsmicq99jTNPJlw0XS/cMT9E7O5tsJSxvFaWRZPiowpXzzlFsfr3xzLnKMqzz9uzLRBUxIJ3SA/uVQ+zGHTyA9VmRYwvZPpdSepPP+2V6VJmXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qWwbxASk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80B22C433F1;
	Thu, 22 Feb 2024 10:28:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708597685;
	bh=b4FUqCJ0EFJCW1Eb2H2P7CKrb72vkMjtY68vabwTKH4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qWwbxASk1MbAVTuyZfGCOFBhHJn0KpL0yeXX4HC+Fz2c/rwa0T+PGhF4Vk2pE4SHP
	 QHEy3WJOaieXRi4kEplUJuaoAPVrmU6E4KBZO8i+8KreL1vrFDmA1Uh3yO/8Ie0Gdq
	 Nurfasgeew1ljzYRCNxFqcf/WAFG11U67kfbrXeIRpkzcYuDcpbMl0fmm7jqnvOlYU
	 SNrLZbjUC8hz4FSfzG8C97126If854WAjMA86c/UC6RI/Ij2A8AohL6BiD1TtGLf58
	 JTJJ/bKq+xoo7ZtM78azfGmPVRuabtrnSlGjCRD3UBaIh6UztK6Hz8mwNY02e7Mfax
	 f9Ws2/duLb0KA==
Date: Thu, 22 Feb 2024 11:28:02 +0100
From: Maxime Ripard <mripard@kernel.org>
To: Frank Oltmanns <frank@oltmanns.dev>
Cc: Jernej Skrabec <jernej.skrabec@gmail.com>, 
	Diego Roversi <diegor@tiscali.it>, Michael Turquette <mturquette@baylibre.com>, 
	Stephen Boyd <sboyd@kernel.org>, Chen-Yu Tsai <wens@csie.org>, 
	Samuel Holland <samuel@sholland.org>, Guido =?utf-8?Q?G=C3=BCnther?= <agx@sigxcpu.org>, 
	Purism Kernel Team <kernel@puri.sm>, Ondrej Jirman <megi@xff.cz>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Jessica Zhang <quic_jesszhan@quicinc.com>, 
	Sam Ravnborg <sam@ravnborg.org>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
	Daniel Vetter <daniel@ffwll.ch>, Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, linux-clk@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v2 3/6] clk: sunxi-ng: nkm: Support minimum and maximum
 rate
Message-ID: <ng2xdo7icjshbwlwy4sgaofibkg3e7qaotd2dnaq5zfizgub7s@b7egn5kd3ejf>
References: <20240205-pinephone-pll-fixes-v2-0-96a46a2d8c9b@oltmanns.dev>
 <20240205-pinephone-pll-fixes-v2-3-96a46a2d8c9b@oltmanns.dev>
 <8734tmhzkg.fsf@oltmanns.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="q4pk3zqf4xnyu77u"
Content-Disposition: inline
In-Reply-To: <8734tmhzkg.fsf@oltmanns.dev>


--q4pk3zqf4xnyu77u
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 21, 2024 at 11:38:39AM +0100, Frank Oltmanns wrote:
> Hi Jernej,
> hi Maxime,
>=20
> On 2024-02-05 at 16:22:26 +0100, Frank Oltmanns <frank@oltmanns.dev> wrot=
e:
> > According to the Allwinner User Manual, the Allwinner A64 requires
> > PLL-MIPI to run at 500MHz-1.4GHz. Add support for that to ccu_nkm.
>=20
> I should point out that limiting PLL-MIPI also fixes a regression
> that was introduced in 6.5, specifically
> ca1170b69968233b34d26432245eddf7d265186b "clk: sunxi-ng: a64: force
> select PLL_MIPI in TCON0 mux". This has been bisected and reported by
> Diego [1].
>=20
> I don't know the procedure (yet), but probably the fix (if and when
> accepted) should be backported at least to 6.6 (first broken LTS), 6.7
> (stable), and 6.8 (next stable).

https://www.kernel.org/doc/html/next/process/stable-kernel-rules.html#proce=
dure-for-submitting-patches-to-the-stable-tree

> My suggestion:
>  - In V3 of this series, I will reorder the patches, so that what is now
>    PATCH 3 and 4 becomes 1 and 2 respectively, so that they can be
>    applied to 6.6 more easily.
>  - Maxime, IIUC you requested some refactoring for handling the rate
>    limits [2]. I propose, we use my current proposal as-is, and I will
>    do a follow-up series for the refactoring.

I'd really like to not introduce a new ad-hoc implementation of range
handling. It's fine for older users to not be converted yet, but we
shouldn't introduce more users.

Maxime

--q4pk3zqf4xnyu77u
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCZdchsQAKCRDj7w1vZxhR
xazKAQCsOgi9EGPB1NvcUX+zJHujzzu0Eni6yLd7IVdDRMkbQwD9FgYrQZze53po
fwfG9jJrp7PSo+5yd2QAWoj53xExtQw=
=1YY2
-----END PGP SIGNATURE-----

--q4pk3zqf4xnyu77u--

