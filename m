Return-Path: <linux-kernel+bounces-35744-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D4058395D3
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 18:06:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DAFFE294B87
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 17:06:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44EFC7FBB0;
	Tue, 23 Jan 2024 17:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EkGZ+/og"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 802835733D;
	Tue, 23 Jan 2024 17:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706029280; cv=none; b=L4E56axpdT15SWmrqPEf6JowHZ/28znO4ql/ITgff1nlpOCIqZmqwLiMUIA4WgFVWrVs23QkoFf/pP6HBCOG4LY1/CGpgluWaLq5Mwfj/ud6gAz0ZIateriunyQ9uHR8XeWR1FdTs5MXZ6hWy53l31SAPb0G7N7rZ8c3aHLi3EM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706029280; c=relaxed/simple;
	bh=V+pi3c5KR+NexGtTEkvtMJ8NNNixuoR/P6ynDkGNHog=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TLmBCEdc1AIihlhGG2V1yKB27VAUih26GQwCnRVocBC3KFOOl3jkBQAZmA2Z8cwk3X7667fGPp/+LbeEe4yI7lcKBaW8WPg+N2pNEeFCNLB6KmHGoatpkHnPEFSMXDS3kwuYd1xEAtZ4LN8Esg1RpUKgyXbY8zDrP6/GM4Vid1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EkGZ+/og; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B2FBC433F1;
	Tue, 23 Jan 2024 17:01:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706029279;
	bh=V+pi3c5KR+NexGtTEkvtMJ8NNNixuoR/P6ynDkGNHog=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EkGZ+/ogS6+hCHS8WHjmlSxTgntXLY5/EvV7KM/I0UJQsFIvfYFISudTysjnMMAtm
	 XBN8NJ1rWx0kgM3kDM3ITGf+2vNTRV5P70FmMznXtyuaO/VZVvKJy/EIPztnP4fY8b
	 fMhzPv3e/J8qlgnYBt5k9wMH2ZqDGtqkCuEeOgOZf4E+zdf7KQeLHXyAoLVbHeyuy7
	 ypaKJbkV6koOWVdtRSWwXeybmQyzWHpyqUVXZQBJLlid3iUCUsGSaQgDjp2VLEpDjc
	 NTH3uZG2rSC8dWPP2DSbD5Jd3wsbUr2TeN6Lp/ysx/0OjMe71Z7r7VpGpddE9Hn3bJ
	 MI4xI7Pgdt9lw==
Date: Tue, 23 Jan 2024 17:01:13 +0000
From: Conor Dooley <conor@kernel.org>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: "Jason-JH.Lin" <jason-jh.lin@mediatek.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	Chun-Kuang Hu <chunkuang.hu@kernel.org>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, dri-devel@lists.freedesktop.org,
	linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org,
	Jason-ch Chen <jason-ch.chen@mediatek.com>,
	Johnson Wang <johnson.wang@mediatek.com>,
	Singo Chang <singo.chang@mediatek.com>,
	Nancy Lin <nancy.lin@mediatek.com>,
	Shawn Sung <shawn.sung@mediatek.com>,
	Project_Global_Chrome_Upstream_Group@mediatek.com
Subject: Re: [PATCH v3 1/3] dt-bindings: mailbox: Add mediatek,gce-props.yaml
Message-ID: <20240123-powwow-drainable-77dfd6158b05@spud>
References: <20240119063224.29671-1-jason-jh.lin@mediatek.com>
 <20240119063224.29671-2-jason-jh.lin@mediatek.com>
 <20240119-demote-fragment-624a35367a87@spud>
 <9c447297-2738-4b63-9da9-0d004660e65d@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="2CTCg0wQKdRlifcE"
Content-Disposition: inline
In-Reply-To: <9c447297-2738-4b63-9da9-0d004660e65d@collabora.com>


--2CTCg0wQKdRlifcE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 22, 2024 at 11:38:15AM +0100, AngeloGioacchino Del Regno wrote:
> Il 19/01/24 17:44, Conor Dooley ha scritto:
> > Rob,
> >=20
> > On Fri, Jan 19, 2024 at 02:32:22PM +0800, Jason-JH.Lin wrote:
> > > Add mediatek,gce-props.yaml for common GCE properties that is used for
> > > both mailbox providers and consumers. We place the common property
> > > "mediatek,gce-events" in this binding currently.
> > >=20
> > > The property "mediatek,gce-events" is used for GCE event ID correspon=
ding
> > > to a hardware event signal sent by the hardware or a sofware driver.
> > > If the mailbox providers or consumers want to manipulate the value of
> > > the event ID, they need to know the specific event ID.
> > >=20
> > > Signed-off-by: Jason-JH.Lin <jason-jh.lin@mediatek.com>
> > > ---
> > >   .../bindings/mailbox/mediatek,gce-props.yaml  | 52 ++++++++++++++++=
+++
> >=20
> > Is bindings/mailbox the correct directory to put this in?
> >=20
>=20
> Well, the GCE is a mailbox :-)
>=20
> ...but I get why you're asking... and I don't think that this should go to
> arm/mediatek/ as it's really just only referring to extra properties for =
kind of
> "special" mailbox client events...

gce is a mailbox, but this isn't a binding for the mailbox itself, hence
me wondering. I haven't been able to think of something better though,
so
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

Cheers,
Conor.

--2CTCg0wQKdRlifcE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZa/w2QAKCRB4tDGHoIJi
0mVkAQD1E1YROaciJvV15+DoVLqDPd5wy0CwA0/B+tXa1nnLGAEAx7CXc/CtIrWm
h/V9z3ZETpXmdBl0DoEl6myfpxb9pgc=
=/QkO
-----END PGP SIGNATURE-----

--2CTCg0wQKdRlifcE--

