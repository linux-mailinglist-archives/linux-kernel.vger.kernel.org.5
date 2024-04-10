Return-Path: <linux-kernel+bounces-138143-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BEADB89ED3A
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 10:10:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 590A31F21D55
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 08:10:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC1B913D605;
	Wed, 10 Apr 2024 08:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="AqHxZtmb"
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F54D1C0DD9;
	Wed, 10 Apr 2024 08:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712736598; cv=none; b=oqZxljf36QA6xrfuxl5+aq/wnSy83lr1i4REt4hTXqIHBnImy1Xykzp6gcagRgKi7HErCLe/t0n729W9dbELjuGnhgvaOZx3qb5Jv0uEX84hiz4Y99WnRVwFODM3w2QMvSRmT6Z/l7ubyy/eDEJA0A1GquLajSswQCseFzMozrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712736598; c=relaxed/simple;
	bh=mzy36E8KWXL6Rc2Bnz52G/aFc6SaQE1wTcy55bneo6E=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lxhNPQht2CBDNhI33C6c38alQ7wge+kQIRtGfZMw89AoijB2rA2k6zUnh9oddsNhy9FWJN4Yodgy01AEddGioZU/ss6m/eNn92a2NepfnvlIBMjH5R5ZcZ+1l4+vUkT8wOfI/OpYAJXl+HBLFNpY+sq0YfBZtIIOPk7eU8mag+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=AqHxZtmb; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 0AD0D20002;
	Wed, 10 Apr 2024 08:09:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1712736593;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=67fO9dB9+aCmoUPt8C/edMdaWBrSxm958Jbh7XiQUIM=;
	b=AqHxZtmbrOcFs4dSt9HVYUN4tknKKN3kvY33S3Sak9S/RXZKzPS4R9duaaKwavNcAtUf/4
	STZPMXGct0+PICzyL8yuIr6SDAcMp4qZrZowe1txLfVuUAHdGul0X3lJnkTHr4GxO1l0W9
	TO+IaJ/29/R/i+xZ1OE6bA0AC3LSABwLmNYCTqKY2Wz3gZGUXkRC5+50VpwKRDaPwstHt9
	RE1myhLvgnsJwwQf5qg0Z78S3mnMdMRgTOf1JoHBTCFP5MiIQnMMB+B4sUwrmsbX1NIF+p
	su9eDvtYeQaYXHWjLSo/hb8s9UiY+dGkbJXCa4UzliXRFE/wtggEOUD/hsWNvQ==
Date: Wed, 10 Apr 2024 10:09:48 +0200
From: Kory Maincent <kory.maincent@bootlin.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Jonathan Corbet
 <corbet@lwn.net>, Luis Chamberlain <mcgrof@kernel.org>, Russ Weight
 <russ.weight@linux.dev>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley
 <conor+dt@kernel.org>, Oleksij Rempel <o.rempel@pengutronix.de>, Mark Brown
 <broonie@kernel.org>, Frank Rowand <frowand.list@gmail.com>, Andrew Lunn
 <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, Russell King
 <linux@armlinux.org.uk>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, devicetree@vger.kernel.org, Dent Project
 <dentproject@linuxfoundation.org>, kernel@pengutronix.de, Maxime Chevallier
 <maxime.chevallier@bootlin.com>
Subject: Re: [PATCH net-next v7 13/17] net: pse-pd: Use regulator framework
 within PSE framework
Message-ID: <20240410100948.1df6ca0d@kmaincent-XPS-13-7390>
In-Reply-To: <20240409141621.392bd34b@kernel.org>
References: <20240409-feature_poe-v7-0-11e38efd4dee@bootlin.com>
	<20240409-feature_poe-v7-13-11e38efd4dee@bootlin.com>
	<20240409141621.392bd34b@kernel.org>
Organization: bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: kory.maincent@bootlin.com

On Tue, 9 Apr 2024 14:16:21 -0700
Jakub Kicinski <kuba@kernel.org> wrote:

> On Tue, 09 Apr 2024 17:04:03 +0200 Kory Maincent wrote:
> > -static inline struct pse_control *of_pse_control_get(struct device_node
> > *node) +static inline struct pse_control *of_pse_control_get(struct dev=
ice
> > *dev,
> > +						     struct device_node
> > *node) =20
>=20
> One of the related patches breaks the build:
>=20
> drivers/net/mdio/fwnode_mdio.c: In function =E2=80=98fwnode_find_pse_cont=
rol=E2=80=99:
> drivers/net/mdio/fwnode_mdio.c:32:35: error: passing argument 1 of
> =E2=80=98of_pse_control_get=E2=80=99 from incompatible pointer type
> [-Werror=3Dincompatible-pointer-types] 32 |         psec =3D
> of_pse_control_get(np); |                                   ^~ |
>                      | |                                   struct device_=
node
> * In file included from drivers/net/mdio/fwnode_mdio.c:13:
> ./include/linux/pse-pd/pse.h:157:69: note: expected =E2=80=98struct devic=
e *=E2=80=99 but
> argument is of type =E2=80=98struct device_node *=E2=80=99 157 | static i=
nline struct
> pse_control *of_pse_control_get(struct device *dev, |
>                              ~~~~~~~~~~~~~~~^~~
> drivers/net/mdio/fwnode_mdio.c:32:16: error: too few arguments to function
> =E2=80=98of_pse_control_get=E2=80=99 32 |         psec =3D of_pse_control=
_get(np); |
>     ^~~~~~~~~~~~~~~~~~ In file included from
> drivers/net/mdio/fwnode_mdio.c:13: ./include/linux/pse-pd/pse.h:157:35: n=
ote:
> declared here 157 | static inline struct pse_control
> *of_pse_control_get(struct device *dev, |
> ^~~~~~~~~~~~~~~~~~ cc1: all warnings being treated as errors

Arg, a leftover of an old version of the series.
Thanks for the report.

Regards,
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

