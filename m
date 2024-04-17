Return-Path: <linux-kernel+bounces-147980-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95E5D8A7C1F
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 08:13:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C76E81C21999
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 06:13:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7E405381E;
	Wed, 17 Apr 2024 06:13:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="U/OXeJl7"
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8700432182;
	Wed, 17 Apr 2024 06:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713334386; cv=none; b=DFXH3PIR44FMZi6Z5fa/MnlGTW7EVhASU3e8VkUpMirzdCL4k8QrCNbe8w48jQSyfzyiEObMAJGMKJ2BcReSzx+IUR1WFFzSzTTGBfzjG1iipEc2VhgJ1S9GWyf75vPB+98CJaI/OhDE+AkIXp54H9Px8Z3sdYU+DdQTMDTcxJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713334386; c=relaxed/simple;
	bh=7ZgUen8ot11Qz879HUcjaNN0IEVPXOLC3zfr6OtSodc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qU1acFmWG4Q2LjNXfDwbZTnwBuOnMzG4vYqwjoJOXo0i/ke2hLPbESkgxNISzbKyvaJ5wcvBFMLW6fKVnaHSSYjiY+44pVqIQlzVaL4ZQB5J0QXU+7CCiaUum9KLsFFI2iaXoJe67RsJK2YjW3uam9mOLL20Ct3rBjh2J2j7gvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=U/OXeJl7; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 7DE592000A;
	Wed, 17 Apr 2024 06:12:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1713334381;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6dGOFNPsAT2bpY0iMzqWzQtr2Je5V47A0xRQXyXChek=;
	b=U/OXeJl7xv4grdNUAujts4V4Qv/0Yd1oYDnqOoIEqZRNxHQ8szmmKg9wc7usiesylnz+/l
	2DdOB+MCM+3LiRMgPb3kn4spUT+VEbdmTmTxzYz1Vu2tEMwYwNl1NtdzwZQ35yb49uvmsH
	nnWJs/bwZm51gm5YE1SYSsPAVPWOsWUCsMgddeIa4SlMXWbPSoDcHVSzTouVXxoycr/PNx
	7XZjvH7nphEvJbtVHdVTMmH1SYWRM6MkrxOD48d0u1R4jvdQc860aAm+gspLQVwaNGn5Xi
	wqZ0i9rP4CbDtIAScjFsEMDkgRuLGcjDYM6wne9IX5dK0d1+0Wbv7PRkHjMoSA==
Date: Wed, 17 Apr 2024 08:12:49 +0200
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
Subject: Re: [PATCH net-next v8 04/17] ethtool: Expand Ethernet Power
 Equipment with c33 (PoE) alongside PoDL
Message-ID: <20240417081249.1e92dab2@kmaincent-XPS-13-7390>
In-Reply-To: <20240416192037.50aa0136@kernel.org>
References: <20240414-feature_poe-v8-0-e4bf1e860da5@bootlin.com>
	<20240414-feature_poe-v8-4-e4bf1e860da5@bootlin.com>
	<20240416192037.50aa0136@kernel.org>
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

On Tue, 16 Apr 2024 19:20:37 -0700
Jakub Kicinski <kuba@kernel.org> wrote:

> On Sun, 14 Apr 2024 16:21:53 +0200 Kory Maincent wrote:
> > + * @ETHTOOL_C33_PSE_PW_D_STATUS_DISABLED: "The enumeration
> > \u201cdisabled\u201d
> > + *	indicates that the PSE State diagram is in the state DISABLED."
> > + * @ETHTOOL_C33_PSE_PW_D_STATUS_SEARCHING: "The enumeration
> > \u201csearching\u201d
> > + *	indicates the PSE State diagram is in a state other than those
> > + *	listed."
> > + * @ETHTOOL_C33_PSE_PW_D_STATUS_DELIVERING: "The enumeration
> > + *	\u201cdeliveringPower\u201d indicates that the PSE State diagram
> > is in the
> > + *	state POWER_ON."
> > + * @ETHTOOL_C33_PSE_PW_D_STATUS_TEST: "The enumeration \u201ctest\u201d
> > indicates that
> > + *	the PSE State diagram is in the state TEST_MODE."
> > + * @ETHTOOL_C33_PSE_PW_D_STATUS_FAULT: "The enumeration \u201cfault\u2=
01d
> > indicates that
> > + *	the PSE State diagram is in the state TEST_ERROR."
> > + * @ETHTOOL_C33_PSE_PW_D_STATUS_OTHERFAULT: "The enumeration
> > \u201cotherFault\u201d =20
>=20
> funny characters here: \u201c and \u201d

Arf again, I have learned the hard way of do not copy past some documentati=
on
from the standard to Linux.
Thanks Jakub, for the reviewing and the merge try!

Regards,
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

