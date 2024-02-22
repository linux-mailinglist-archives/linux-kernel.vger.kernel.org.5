Return-Path: <linux-kernel+bounces-77490-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A94A6860644
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 00:10:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 490E31F26170
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 23:10:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CBA8199AD;
	Thu, 22 Feb 2024 23:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GY9Z65NT"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B738612E40;
	Thu, 22 Feb 2024 23:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708643425; cv=none; b=Q/SHH3cL9RXngcArT5Nh3VmnICCLkdo+ZZb/HAzhlHNdiqgtcjbcnwWAoSImrsOC3VRz42HOXdir3/mq4GYtfChbv3/mUyp+ZriJtrGqnL8zAYKckjGYog0X9TRB/PjnuI/r211K2RYt8lh/NfLFbQ++3Bedj/ncjiKfovhRoig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708643425; c=relaxed/simple;
	bh=6OzJegTSQdyWQrZYOG0vp/5VWZxH+EYUsQm/nWQ5X88=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CD1RRtmsdAXPyv3LfEQ04qBp3WSaFHfFsi0hyes4oJ5rcK4pco6LPg4YrTdjNl2+WLG9r7My7KsbS4nTd2GnhqQUPQqBgyVhQmQdBQS2jivKyle9rhXMvYWJBGdwqs6kEUEO5aCZatf2TMcULtFKgVI+39oTPgCVmyH28GU0udw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GY9Z65NT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09C94C433F1;
	Thu, 22 Feb 2024 23:10:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708643425;
	bh=6OzJegTSQdyWQrZYOG0vp/5VWZxH+EYUsQm/nWQ5X88=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=GY9Z65NTnMWV6jVdvd5S1Equ09fRRddum6/7PmWFA2J2wUoXc2XMyP6d981QGTyOb
	 GXftQN5+7y5Zq67S35aNDlqPt4xsCF3GC3c+Z9atZkL/eChZ/A4oNR0d4ks7dK8Oqf
	 LTo/ExczFqLColgZcEowH0sLbHt417t2ybnQu9xdfwpr3cDpUtYVi2L4NVWhGFDwBf
	 3w8NzYCXNGVcLcckEx2gHZ6VZ95zvRG1PIqy33MDDBFRlVlVQ6BsHx2o84i/ImlhNJ
	 OszGA6GFkfQzwlxCF64bVghnR806hp+e4akkjYQIgruREKEMXPcJW0aVGpmK4KVqGm
	 s6qHK50fkhlxw==
Date: Thu, 22 Feb 2024 15:10:23 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
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
Message-ID: <20240222151023.64abe662@kernel.org>
In-Reply-To: <20240222084948.16f33760@device-28.home>
References: <20240220184217.3689988-1-maxime.chevallier@bootlin.com>
	<20240220184217.3689988-9-maxime.chevallier@bootlin.com>
	<20240221170023.452a01ca@kernel.org>
	<20240222084948.16f33760@device-28.home>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 22 Feb 2024 08:49:48 +0100 Maxime Chevallier wrote:
> > ethtool-user.c:689:10: error: =E2=80=98ETHTOOL_A_PHY_UPSTREAM_PHY_INDEX=
=E2=80=99 undeclared here (not in a function); did you mean =E2=80=98ETHTOO=
L_A_PHY_UPSTREAM_INDEX=E2=80=99?
> >   689 |         [ETHTOOL_A_PHY_UPSTREAM_PHY_INDEX] =3D { .name =3D "ups=
tream-phy-index", .type =3D YNL_PT_U32, },
> >       |          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> >       |          ETHTOOL_A_PHY_UPSTREAM_INDEX
> >=20
> > Unfortunately ethtool in the in-between state where we can auto-gen
> > user space code (or rather most of it) but the uAPI header is not
> > auto-generated so we need to take extra care to keep things in sync :( =
=20
>=20
> Is there anything I run for testing, so that I can make sure this
> doesn't happen again ?

make -C tools/net/ynl

will run the build. It needs some basic python libs, should be easy to
figure out from stack traces if they are missing.=20

I didn't mention it to you because.. it may not build for you on
net-next until what I'm about to post gets merged.

