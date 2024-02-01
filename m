Return-Path: <linux-kernel+bounces-48715-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EB33846022
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 19:41:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7D56D1C2494D
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 18:41:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBE2182C96;
	Thu,  1 Feb 2024 18:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Grc3BH8n"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C73112FB08;
	Thu,  1 Feb 2024 18:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706812855; cv=none; b=Zeij1yoLYYkbHrLpX/dttccAMStfkTaZSNTF/k480sqLXqswDdQxHmXgAu7vuzfnyofKxQWIoe9ogpQ8RpD9M3Jnl6z/oIHrwHX+E1kSRlhMDd2v9mxM95y/fc53He2dR6eOVxwCi8D7G3+2clGrwLbpVqFu0yP+vtznrtdMBMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706812855; c=relaxed/simple;
	bh=irXIYBIlkLI23IErRP19IjcdedDm9j+GXtl3atTGeKQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NqbUkxnNgFBFV2xhqI2NVZG+vgmEJFk+OV7wlU7fOGFHkay1oKTpIEY1C+Pk1YFX2ZyGbaN09MFtNDgf3+0JWr9UL6oCFCQwAhY3//fmftYFrIzU+w6jN8yHSr1m9afl3TbWmWWmMy5Ox95+MYIVz5uobklEnK7CcNI639OUxnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Grc3BH8n; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72D5AC433F1;
	Thu,  1 Feb 2024 18:40:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706812854;
	bh=irXIYBIlkLI23IErRP19IjcdedDm9j+GXtl3atTGeKQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Grc3BH8nkeiQywvhYoPspwhUAK2bf1HceO+KaFQ0+FDGuAsW8kG09akfB9IT1/dpR
	 WtxgrCCunFAAN49RmnCi5p1ZdUOc+/tU7O5Uw50tUPDZCUchIq0gP8xlobsIMfT5Pg
	 RYcCGzcpLZxqgwbLRvjMlsdTKNIt0d67xM9fbUBNGI4VB/Qa3NIHXPiqNtMPTIIOFe
	 F3SNTpljn7ciUQXKxlkEzOMbaOdvz6q0g5+IkB2Qyw4uU5j6qjn4PQsvcQm8jQi2FM
	 rBcxqxfQPJlrUZi5Z32TbFJCwe1SNELYdwj4SUW2u1tHIHRgENB5U9DLND3sOsNCVA
	 HvrvRw43CnCzA==
Date: Thu, 1 Feb 2024 18:40:49 +0000
From: Conor Dooley <conor@kernel.org>
To: Peng Fan <peng.fan@nxp.com>
Cc: Rob Herring <robh@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	"Peng Fan (OSS)" <peng.fan@oss.nxp.com>,
	"wg@grandegger.com" <wg@grandegger.com>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"krzysztof.kozlowski+dt@linaro.org" <krzysztof.kozlowski+dt@linaro.org>,
	"edumazet@google.com" <edumazet@google.com>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	"linux-can@vger.kernel.org" <linux-can@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] dt-bindings: can: fsl,flexcan: add i.MX95 compatible
 string
Message-ID: <20240201-relish-glacial-a73532d3e8c6@spud>
References: <20240122091738.2078746-1-peng.fan@oss.nxp.com>
 <20240122-skilled-wimp-4bc1769bf235-mkl@pengutronix.de>
 <20240122125631.4c54eba1@kernel.org>
 <DU0PR04MB941750744E86A1656009B7BE88742@DU0PR04MB9417.eurprd04.prod.outlook.com>
 <20240131145736.GA1262278-robh@kernel.org>
 <DU0PR04MB94178632D6F774339FB13375887C2@DU0PR04MB9417.eurprd04.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="XxIjggpR5LQGNVIU"
Content-Disposition: inline
In-Reply-To: <DU0PR04MB94178632D6F774339FB13375887C2@DU0PR04MB9417.eurprd04.prod.outlook.com>


--XxIjggpR5LQGNVIU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 31, 2024 at 11:22:49PM +0000, Peng Fan wrote:
> > Subject: Re: [PATCH] dt-bindings: can: fsl,flexcan: add i.MX95 compatib=
le
> > string
> >=20
> > On Tue, Jan 23, 2024 at 07:00:27AM +0000, Peng Fan wrote:
> > > > Subject: Re: [PATCH] dt-bindings: can: fsl,flexcan: add i.MX95
> > > > compatible string
> > > >
> > > > On Mon, 22 Jan 2024 11:26:25 +0100 Marc Kleine-Budde wrote:
> > > > > > Add i.MX95 flexcan which is compatible i.MX93 flexcan
> > > > > >
> > > > > > Signed-off-by: Peng Fan <peng.fan@nxp.com>
> > > > >
> > > > > Acked-by: Marc Kleine-Budde <mkl@pengutronix.de>
> > > >
> > > > Hm, you don't apply CAN DTB patches?
> > >
> > > Nope. I am preparing dt-binding first, then post the i.MX95 SoC dtsi.
> > > The CAN will be in the i.MX95 SOC dtsi file, not a single patch only
> > > for CAN node.
> >=20
> > The question was why isn't Marc, the CAN maintainer, applying this. I h=
ave
> > the same question.
>=20
> That's fine, let's drop this patch, the CAN node will not be put in my so=
c dtsi
> patch file, it will be in a separate patchset with some i.MX95 patches.

I am confused. This patch (for the binding) needs to be applied
regardless of what you are doing with your soc dtsi file.

--XxIjggpR5LQGNVIU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZbvlsQAKCRB4tDGHoIJi
0lKXAQD9Q4v0VDU/Dyun0tgqIB2JBr3Fh9ja/fUDKvmCx66YyQD/cqPjogSsgjOw
SCCzaqrgXBrwCRCJNuBV6lywKxI1ngc=
=L85i
-----END PGP SIGNATURE-----

--XxIjggpR5LQGNVIU--

