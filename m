Return-Path: <linux-kernel+bounces-65813-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 51C06855228
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 19:32:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0F3CE291C8F
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 18:32:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3A17133288;
	Wed, 14 Feb 2024 18:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O3AHXwqS"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C10B133281;
	Wed, 14 Feb 2024 18:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707935468; cv=none; b=uTVt7dxiUGoxJWfBwKEqAynDQniObMb5gJPjh3kUalcJ66a3/q1odSdN9w/jbEjR4fAw9WKztbwOYNlAXYq+u03PCNRhyc4vR2QtRNcRi/1zQtfCUD6IvfmUMhONAaCfMJysH6MFT0IEJw2M6OlKgemG9xLOgxTtwS2n782LlBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707935468; c=relaxed/simple;
	bh=DqQ+n4sMmsCgeic4jR8u6aoCgKS/praQFMsaqy5xqsc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TSYvQjRuOMumzAlO8mEskTCCcIHSLhBvrTLlcge/3wIvBc+RsOtNupJlD4rmDJ0k1He3fwlLRR7IG+tXYpKWeATpeaZLOIKQSwUIxaZhWnM/vIt3OjSLyX8Yc4v51zXBP3Qb/t5PTNPhoOnRdmofO++6SMynNJzKotpnJbhDQ04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O3AHXwqS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FE62C43390;
	Wed, 14 Feb 2024 18:31:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707935467;
	bh=DqQ+n4sMmsCgeic4jR8u6aoCgKS/praQFMsaqy5xqsc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=O3AHXwqSkO5POA0F9lBb4ChwP/ZSNILgVv96DwvQU+n4Vdq084zSQI/LKhzzz/3HE
	 qj7UkFxJxqMPgXNxwiY3O+IL1e7TxuXkVEtWjS4oeo3E3gL2yiqzfok+5jVUr3H+nT
	 V0QQPtPfDLjDdP0W0oyAPz45O2kftqMz6OQSiX4Aw3vxspviPc7OOo6GwN7DclWYqh
	 audeqpj4t38pplAZIyGSaGoWTgthXRngGCWOBsaGEBzT0SdS10fwSfaio0Upkinn7n
	 TsWx267Grb4nlbKbjw0jLxhGP+ofuhinSSmbxxf5gk9Sl3enCdypaoryVWRw08oiuC
	 p4LjRvMwCfr0g==
Date: Wed, 14 Feb 2024 18:31:01 +0000
From: Conor Dooley <conor@kernel.org>
To: ChiaWei Wang <chiawei_wang@aspeedtech.com>
Cc: Manojkiran Eda <manojkiran.eda@gmail.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	"jk@codeconstruct.com.au" <jk@codeconstruct.com.au>,
	Patrick Rudolph <patrick.rudolph@9elements.com>,
	Ryan Chen <ryan_chen@aspeedtech.com>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
	"openbmc@lists.ozlabs.org" <openbmc@lists.ozlabs.org>,
	"zev@bewilderbeest.net" <zev@bewilderbeest.net>
Subject: Re: =?utf-8?B?5Zue6KaG?= =?utf-8?Q?=3A?= [PATCH] Add eSPI device
 driver (flash channel)
Message-ID: <20240214-yoyo-platinum-dcd0e7e16a22@spud>
References: <20240213-espi_driver-v1-1-92741c812843@gmail.com>
 <KL1PR06MB665234A65DB334B3BDF6AFA6914E2@KL1PR06MB6652.apcprd06.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="DN7xbo+G2YJV9a8X"
Content-Disposition: inline
In-Reply-To: <KL1PR06MB665234A65DB334B3BDF6AFA6914E2@KL1PR06MB6652.apcprd06.prod.outlook.com>


--DN7xbo+G2YJV9a8X
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 14, 2024 at 11:34:31AM +0000, ChiaWei Wang wrote:
> We appreciate that you are willing to help on the open source contributio=
n.=20
> However, please co-work with Aspeed before submitting drivers of Aspeed H=
W.
> Otherwise, a misleading driver on the community are going to bring tons o=
f customer issues to Aspeed.

It may not apply in this particular case as Aspeed did write the
original driver and it is polite to work with previous authors
when respinning a patchset, but in general there is no need to work
with a hardware vendor before writing drivers for their hardware.

Blocking a driver because that company might receive more support
requests is not the kernel's problem.

Cheers,
Conor.


--DN7xbo+G2YJV9a8X
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZc0G5QAKCRB4tDGHoIJi
0jh4AQDULTHpmdpjBuvc/RMvcJk7Fsv+M5FEZdXcxYYbDBlSKAEA7XX/zOdWdqxP
wKZsM8bYsV8j1gJqXlEScsdOOOgxJQU=
=GWXb
-----END PGP SIGNATURE-----

--DN7xbo+G2YJV9a8X--

