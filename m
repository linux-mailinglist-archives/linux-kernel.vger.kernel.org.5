Return-Path: <linux-kernel+bounces-76027-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4338185F226
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 08:50:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 41A101C2130E
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 07:50:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 091B9179B0;
	Thu, 22 Feb 2024 07:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="BLCxIX+X"
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC6EE17BA1;
	Thu, 22 Feb 2024 07:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708588206; cv=none; b=jFEGT8NhNLlzlpS/mzVTwuVhcX2GkYmmHD43w2vUeNh1syfk8BI5x1nmQWp+xQXwR6E7Xxxp4RGc0vkJ/lXD3TgujujmKXSlrjpcirE99Esq1G3FbPOoZ76/8jbrLHeqQCJsSYu+chxgU3+ITUAjLkpFS5n8r4j2tOgfOeZfOEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708588206; c=relaxed/simple;
	bh=BqYEx4+PAF1FIXKlUO2VJyByU6HT6YoYRVz0HmIAOpY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DEVgEvOK0/zyWSc3UhQgK5ziBy2Ke00rXwLGkCN1lqfH3Ms3enruDG86eRjMFmx+sh+yv86JNY2Xouw9/g/19Y3j0h/1TDOOlWa//N26IVxetc0bR3IpCGKEE1+aaDAongaVKcW9pQBECNYhCwHBOfa2s49mX5dweMZCPkhcHa4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=BLCxIX+X; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id C130F20003;
	Thu, 22 Feb 2024 07:49:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1708588195;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cSLLCAcqZ7/cxOMZwrSaXrhe6GA62RvNVFkADGqZ++w=;
	b=BLCxIX+X5angxkQeWAztWV9x6zzwuU3z/7oG1Ge5YsBPp2+4OSkNerlYOabq63gMHkKkKW
	Q0CP9Dd2fy44RFsMG4FWuW1OQH2kamUIT+BZQZoUT9Ab+6P1AWXTi2+PCTSYlWTyN8lu7t
	BzWzlLs4KpugsZZDkydR5nVTIcQxj7NcXWJgtkbv1kVkFtbFq7x8Dp3wR/4U9CPYIX5par
	yqMvicTBjF24H4n6rkbL8LAymCMxJ5QAOyKP2cyylshSQ/tPa8x1tMV6d9oNGliBK59R72
	s4fP5EL9w1goFIzDtfZDWGVH+4zM1duNTaJFS7g2WfdxOgrec6LLY+w6CnCRrQ==
Date: Thu, 22 Feb 2024 08:49:48 +0100
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com, Andrew Lunn
 <andrew@lunn.ch>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Russell King <linux@armlinux.org.uk>,
 linux-arm-kernel@lists.infradead.org, Christophe Leroy
 <christophe.leroy@csgroup.eu>, Herve Codina <herve.codina@bootlin.com>,
 Florian Fainelli <f.fainelli@gmail.com>, Heiner Kallweit
 <hkallweit1@gmail.com>, Vladimir Oltean <vladimir.oltean@nxp.com>,
 =?UTF-8?B?S8O2cnk=?= Maincent <kory.maincent@bootlin.com>, Jesse Brandeburg
 <jesse.brandeburg@intel.com>, Jonathan Corbet <corbet@lwn.net>, Marek
 =?UTF-8?B?QmVow7pu?= <kabel@kernel.org>, Piergiorgio Beruto
 <piergiorgio.beruto@gmail.com>, Oleksij Rempel <o.rempel@pengutronix.de>,
 =?UTF-8?B?Tmljb2zDsg==?= Veronese <nicveronese@gmail.com>, Simon Horman
 <horms@kernel.org>, mwojtas@chromium.org
Subject: Re: [PATCH net-next v8 08/13] netlink: specs: add ethnl PHY_GET
 command set
Message-ID: <20240222084948.16f33760@device-28.home>
In-Reply-To: <20240221170023.452a01ca@kernel.org>
References: <20240220184217.3689988-1-maxime.chevallier@bootlin.com>
	<20240220184217.3689988-9-maxime.chevallier@bootlin.com>
	<20240221170023.452a01ca@kernel.org>
Organization: Bootlin
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: maxime.chevallier@bootlin.com

Hello Jakub,

On Wed, 21 Feb 2024 17:00:23 -0800
Jakub Kicinski <kuba@kernel.org> wrote:

> On Tue, 20 Feb 2024 19:42:11 +0100 Maxime Chevallier wrote:
> > +      -
> > +        name: upstream-phy-index
> > +        type: u32 =20
>=20
> The C define appears to be called:
>=20
> 	ETHTOOL_A_PHY_UPSTREAM_INDEX,		/* u32 */
>=20
> either it needs to gain the PHY_ or the spec needs to lose the phy-,
> otherwise C code gen gets upset:

I'll do it, sorry about that.

>=20
> ethtool-user.c:689:10: error: =E2=80=98ETHTOOL_A_PHY_UPSTREAM_PHY_INDEX=
=E2=80=99 undeclared here (not in a function); did you mean =E2=80=98ETHTOO=
L_A_PHY_UPSTREAM_INDEX=E2=80=99?
>   689 |         [ETHTOOL_A_PHY_UPSTREAM_PHY_INDEX] =3D { .name =3D "upstr=
eam-phy-index", .type =3D YNL_PT_U32, },
>       |          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>       |          ETHTOOL_A_PHY_UPSTREAM_INDEX
>=20
> Unfortunately ethtool in the in-between state where we can auto-gen
> user space code (or rather most of it) but the uAPI header is not
> auto-generated so we need to take extra care to keep things in sync :(

Is there anything I run for testing, so that I can make sure this
doesn't happen again ?

Thanks,

Maxime


