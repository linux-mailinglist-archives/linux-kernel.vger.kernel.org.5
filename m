Return-Path: <linux-kernel+bounces-159559-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 753368B3047
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 08:23:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 735D82856CE
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 06:23:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FAED13A865;
	Fri, 26 Apr 2024 06:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z5N+I5U8"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A88C413A3F6
	for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 06:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714112592; cv=none; b=miXAKLSefD6ox/Hoofm32oXYrEE73DISdeS7S87nlHd4TVln/0ZnfjSU8RV2gbtLlKTlDSUXIZyHIRvaZXKIzJXeyzvetI4beSypQ3JthojDlyyYvC7RCPur43InQljTtDsZaFIud1tWgpIRxwWlbfPSXqUtzWF0JPoscDBV+Tc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714112592; c=relaxed/simple;
	bh=Nfb+0TFJqYbN3lblUgp8OR/OnwjY43BbHiskkc20XKA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CSD810ws3/Hg7cUef0UJFb7ghXTc/R0hIx7Pt7KF5QsZZigam2PCIx5lBrjPlTFNCaJGWhVpUgM+sjWELqlrf3iHZp9j4Iuk+C70CyyImNF2cXN9JLVCy8Ee8Lz9x+AWxsgr86dHEx9XUIv1qYX+03NXpzJ/z0UyauM8UMMhR8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z5N+I5U8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24992C113CE;
	Fri, 26 Apr 2024 06:23:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714112592;
	bh=Nfb+0TFJqYbN3lblUgp8OR/OnwjY43BbHiskkc20XKA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Z5N+I5U8LvRKBICc8IVwHVEKZ9uhgtL1KyjLcG4G5dLxUSFeZ6FI4SVkd8+945Dqw
	 iZjmEMKwP+I3BGg9NpbvZzPGK8bafNtVRdFURirdw/HhKGHh8MJwpu/+GypLP15Pea
	 7FB6I+AWZe6zryD34I/tToNOSL9IZ87XnFsabqhfzmgD2dmnDhtSeOhk2PR46SQNOw
	 6TVh8VPfwu0bahqvN0KHOSp6M8Nu+2dSOxa6dgS+2b7deV4MYjH2HeE01OhRJ18SrW
	 TSnAm9wlC/BEPzM5k3YyTSohkuNRIxEpWcKsS+rK8oi2I3vqx09OIfjhvHTd+l9JKZ
	 LdZYfpQubMZGQ==
Date: Fri, 26 Apr 2024 08:23:02 +0200
From: Maxime Ripard <mripard@kernel.org>
To: Sui Jingfeng <sui.jingfeng@linux.dev>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Randy Dunlap <rdunlap@infradead.org>, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	Jessica Zhang <quic_jesszhan@quicinc.com>, Sam Ravnborg <sam@ravnborg.org>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>
Subject: Re: [v1,1/3] drm/panel: ili9341: Correct use of device property APIs
Message-ID: <20240426-married-augmented-mantis-ff7edd@penduick>
References: <20240425142706.2440113-2-andriy.shevchenko@linux.intel.com>
 <c2d41916-0b6c-43b5-98eb-514eb0511f84@linux.dev>
 <ZiqqiAztCaiAgI8e@smile.fi.intel.com>
 <2599705c-0a64-4742-b1d7-330e9fde6e7a@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
	protocol="application/pgp-signature"; boundary="o5swtcdrnu6wvo4w"
Content-Disposition: inline
In-Reply-To: <2599705c-0a64-4742-b1d7-330e9fde6e7a@linux.dev>


--o5swtcdrnu6wvo4w
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Apr 26, 2024 at 04:43:18AM +0800, Sui Jingfeng wrote:
> On 2024/4/26 03:10, Andy Shevchenko wrote:
> > On Fri, Apr 26, 2024 at 02:08:16AM +0800, Sui Jingfeng wrote:
> > > On 2024/4/25 22:26, Andy Shevchenko wrote:
> > > > It seems driver missed the point of proper use of device property A=
PIs.
> > > > Correct this by updating headers and calls respectively.
> > > You are using the 'seems' here exactly saying that you are not 100% s=
ure.
> > >=20
> > > Please allow me to tell you the truth: This patch again has ZERO effe=
ct.
> > > It fix nothing. And this patch is has the risks to be wrong.
> > Huh?! Really, stop commenting the stuff you do not understand.
>=20
> I'm actually a professional display drivers developer at the downstream
> in the past, despite my contribution to upstream is less. But I believe
> that all panel driver developers know what I'm talking about. So please
> have take a look at my replies.

Most of the interactions you had in this series has been uncalled for.
You might be against a patch, but there's no need to go to such length.

As far as I'm concerned, this patch is fine to me in itself, and I don't
see anything that would prevent us from merging it.

Maxime

--o5swtcdrnu6wvo4w
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCZitIOwAKCRAnX84Zoj2+
dr1eAX4kt8+oP9QDw8OZ8+bOs5hSPHT1YEkFlVR2do4H+X5sKSBcmsIVc9BIk8Lo
EZj+dEkBewWPb+S0DuTK2+irs3efvEm8uRMkhJ/XSFB+Wk1eivIEh2L7b3yDHUKM
UmIpp971tQ==
=k4n4
-----END PGP SIGNATURE-----

--o5swtcdrnu6wvo4w--

