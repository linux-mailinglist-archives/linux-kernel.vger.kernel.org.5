Return-Path: <linux-kernel+bounces-137634-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB87C89E4D6
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 23:16:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D55D4283016
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 21:16:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FC9E158A2B;
	Tue,  9 Apr 2024 21:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aMGh6szq"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3F63158851;
	Tue,  9 Apr 2024 21:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712697383; cv=none; b=A6RMMKrzhAVbrVhsOhEmVJ51QLdCrcFPyreJZAOcn76lI0EEArxwQtLDKfw/rXzIdnof2jlH87g+kpGWZzEkYC1kusn2iDPSVh7Ez6hgpencFKDPTEpLbMoUjse0rfnympL/HwdJp3NYaUeVZUY4wuDCnZ4Es1HzJiYt+PNtiuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712697383; c=relaxed/simple;
	bh=xeavq2Gb3F1c/5wmYZH2baldLPex/RujkQlSGyUMlMI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PZCm+evtekY/X+MGkZAmd7j+tVqVgtFSf2RnExnFwp9Ab4hdaq/0BODKVU+Rr6gLYyXtTkHfmSDSNEkP4rlmqZOQwGMkHP7vBo4mDXYXTT5X0XffjbV6klw1NoTzLZE/TKUE0fOov+Vd326rIYOce1acFvA38zfK22BNcCaNIJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aMGh6szq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19DA7C43390;
	Tue,  9 Apr 2024 21:16:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712697383;
	bh=xeavq2Gb3F1c/5wmYZH2baldLPex/RujkQlSGyUMlMI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=aMGh6szqtH7TmNpSsLX4qbLmYjFYjKcz2ZjhBeO7cyQ0LijA2GRHez0PAwOpudg6+
	 brewFq94uC5EHt893rZ2rx32JrrchuViKyKcdJZzyx6LXHecTOmVIIfg/a2pFXtpv5
	 VdP42+jFZrc6kamwsnBQW9X+Ff1IBlODSJ/pwgu3Ee6BsgHvqxM8G6Jttvn9LrlTpg
	 DHi8dGYeYSLFdgjra9vTlKBfwXT/3wIpEBt67p8l6C+W1cfXpVDrW9HjsdUh8qgf3N
	 qBE7HswHhqOHRQjTr/p1TyD6ZwiM1wkmdWdR9syr9Qmk2H8Zai/m/383VWYQPaYtRS
	 kxLK1KWsoaeQw==
Date: Tue, 9 Apr 2024 14:16:21 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Kory Maincent <kory.maincent@bootlin.com>
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
Message-ID: <20240409141621.392bd34b@kernel.org>
In-Reply-To: <20240409-feature_poe-v7-13-11e38efd4dee@bootlin.com>
References: <20240409-feature_poe-v7-0-11e38efd4dee@bootlin.com>
	<20240409-feature_poe-v7-13-11e38efd4dee@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 09 Apr 2024 17:04:03 +0200 Kory Maincent wrote:
> -static inline struct pse_control *of_pse_control_get(struct device_node =
*node)
> +static inline struct pse_control *of_pse_control_get(struct device *dev,
> +						     struct device_node *node)

One of the related patches breaks the build:

drivers/net/mdio/fwnode_mdio.c: In function =E2=80=98fwnode_find_pse_contro=
l=E2=80=99:
drivers/net/mdio/fwnode_mdio.c:32:35: error: passing argument 1 of =E2=80=
=98of_pse_control_get=E2=80=99 from incompatible pointer type [-Werror=3Din=
compatible-pointer-types]
   32 |         psec =3D of_pse_control_get(np);
      |                                   ^~
      |                                   |
      |                                   struct device_node *
In file included from drivers/net/mdio/fwnode_mdio.c:13:
/include/linux/pse-pd/pse.h:157:69: note: expected =E2=80=98struct device =
*=E2=80=99 but argument is of type =E2=80=98struct device_node *=E2=80=99
  157 | static inline struct pse_control *of_pse_control_get(struct device =
*dev,
      |                                                      ~~~~~~~~~~~~~~=
~^~~
drivers/net/mdio/fwnode_mdio.c:32:16: error: too few arguments to function =
=E2=80=98of_pse_control_get=E2=80=99
   32 |         psec =3D of_pse_control_get(np);
      |                ^~~~~~~~~~~~~~~~~~
In file included from drivers/net/mdio/fwnode_mdio.c:13:
/include/linux/pse-pd/pse.h:157:35: note: declared here
  157 | static inline struct pse_control *of_pse_control_get(struct device =
*dev,
      |                                   ^~~~~~~~~~~~~~~~~~
cc1: all warnings being treated as errors

