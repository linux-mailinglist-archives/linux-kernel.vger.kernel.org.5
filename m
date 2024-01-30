Return-Path: <linux-kernel+bounces-45007-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3323A842A47
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 18:03:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 50A381C23559
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 17:03:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BC8C12838F;
	Tue, 30 Jan 2024 17:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dvoSdqNe"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA52B1E4A1;
	Tue, 30 Jan 2024 17:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706634177; cv=none; b=cqy3qEjEeUOf8ou/dlovWrqTPTrAn0S+o2LkrplFUYx+M8eaqV5CbK59HXCgAuaRHmMmCGDvTmSjVvoo37ijN3vUY9v3dG/hlWgHNRope6v+les1k3MIS+NNCRGbtGjXDblU8u9OecyT6RtIHs0crisbyAMXHUPhgqC3VLYa9Bo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706634177; c=relaxed/simple;
	bh=SXaLPfDZAvSOvV1Meuu6KFULLIZdu+ujJNFiM7oIWY0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=azX/vJ9RscEaEmT7rxL1Ln5R0uSCSN52yFd/klfQ99yJ+oMWSvcin/wTRdN2FcRcFAkoFMMSBC1ydDveBUDuQ5Dkmylxi6sPFK9ibHvrIsXWfAUb0I3UL7bztyKfkUPH9s576tHqcXft7cjAH+HP/f29vNQvNHrzHZgB+QkrztY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dvoSdqNe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14292C43609;
	Tue, 30 Jan 2024 17:02:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706634176;
	bh=SXaLPfDZAvSOvV1Meuu6KFULLIZdu+ujJNFiM7oIWY0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dvoSdqNeIiWSDsCr2ioyEf58I7OUGQb9uOX26I5X1yuzX/WwCAaZ6jzR8t4UQBX7L
	 BlitvCOVARsj5HhNBRufBvScpFuOCrQjwRv0E/5FeIJ1f5nVd/yxWkK8rKYQ8I02A3
	 yOQZMODrPQDmXmt1ydm95wv2CFFJ1xsqrun+tvXtwBQrv6iVvmePUC+pyES5d9QUtu
	 WYUKX0tGqB+XrI1FafYq0WrUMJEqe9MU/YlLbHBbLbGRYzoriiRPQ4pdIVUYIVt7r6
	 B8yXwEwzUV6NO3seSe0zy22uB5EfIwBPraYmtfkrkPzmYdTi/x13T760qIkDyAKU2X
	 bvoJB8qBTVqRg==
Date: Tue, 30 Jan 2024 17:02:50 +0000
From: Conor Dooley <conor@kernel.org>
To: William Qiu <william.qiu@starfivetech.com>
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
	"linux-can@vger.kernel.org" <linux-can@vger.kernel.org>,
	Emil Renner Berthing <kernel@esmil.dk>,
	Rob Herring <robh+dt@kernel.org>,
	Wolfgang Grandegger <wg@grandegger.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>
Subject: Re: [PATCH v1 2/4] dt-bindings: can: Add bindings for CAST CAN
 Controller
Message-ID: <20240130-extruding-yodel-8580cc390b64@spud>
References: <20240129031239.17037-1-william.qiu@starfivetech.com>
 <20240129031239.17037-3-william.qiu@starfivetech.com>
 <20240129-garnet-polar-65afd461a1c6@spud>
 <ZQ0PR01MB125387EBAB0E6883FAD077859F7DA@ZQ0PR01MB1253.CHNPR01.prod.partner.outlook.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="6HBub9x1mt/td7wn"
Content-Disposition: inline
In-Reply-To: <ZQ0PR01MB125387EBAB0E6883FAD077859F7DA@ZQ0PR01MB1253.CHNPR01.prod.partner.outlook.cn>


--6HBub9x1mt/td7wn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 30, 2024 at 06:30:54AM +0000, William Qiu wrote:
> > From: Conor Dooley <conor@kernel.org>
> > On Mon, Jan 29, 2024 at 11:12:37AM +0800, William Qiu wrote:

> > > +properties:
> > > +  compatible:
> > > +    enum:
> > > +      - cast,can
> > > +      - cast,canfd
> >=20
> > I don't like these uber generic compatibles that have no users as a fal=
lback.
> > Allowing them in the binding only really discourages people from creati=
ng device
> > specific compatibles.
> > Secondly, this is some purchased IP that I am sure has a versioning sch=
eme and
> > the compatibles that you have created do not reflect that.
> > If they were being used as a fallback, I would request some versioning.
> > That's not going to really work though since the canfd features on the
> > jh7110 require setting u0_can_ctrl_can_fd_enable, so neither of these
> > compatibles really has a use right now.
> >=20
> I'll add some tag to do versioning.

I don't want to see a "cast,can-<something>" compatible allowed in
isolation either as there is no user for it.
The generic compatibles like that should only be permitted in
combination with a device specific one - particularly since there are
bits in implementation defined registers that control whether or not
canfd is enabled.

--6HBub9x1mt/td7wn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZbkrugAKCRB4tDGHoIJi
0gttAP4/q8qVZkSoUY5SEHx4IMoXGOkLA6t5XrEBE2tGdNgmnAD+IW65Z6LW6bDe
j71PnmrSgtOR9MjEvpq0SgpOkZfnlQ4=
=asIB
-----END PGP SIGNATURE-----

--6HBub9x1mt/td7wn--

