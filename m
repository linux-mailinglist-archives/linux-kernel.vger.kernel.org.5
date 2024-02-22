Return-Path: <linux-kernel+bounces-75748-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E09285EE64
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 02:00:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 282BA283E2D
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 01:00:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5157511C83;
	Thu, 22 Feb 2024 01:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ogw8MftI"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F8CA28EF;
	Thu, 22 Feb 2024 01:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708563625; cv=none; b=rk0wrZGw5sgMLM0GwwIcLeyuUGIxzSw6L5ZxJASl5rZsRA1TY5uZwC9dfOz0BIixmPs+ykw7dFS8iyNG4kdlANCvo92x7ipzE/IQbwv8iARBKcUUM7D01F+0DUPAmdJMujfpyKaXRfPBoO+UlC99enQL66znMRS7R+WXOTG7GKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708563625; c=relaxed/simple;
	bh=ggpfbAk/8v/uRbo53fh+Pe5sfNyqrpSgwKHDrVgb8PQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qgs1x/ig8oAq5TtvTv2CV9dll5kvw13n+/V0Svb2HBKVauPr9g4bYOh98wxUBwgqRmD+foIlB9rj0Jq0HRuZrgKf4ldoUK2gOGSf6723R0+FunUTRvNkdKktBb8SPehdkE511G1STjJyfABVInHGoVqoctrhs+RdF+xFJOhhkHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ogw8MftI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02E85C433C7;
	Thu, 22 Feb 2024 01:00:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708563625;
	bh=ggpfbAk/8v/uRbo53fh+Pe5sfNyqrpSgwKHDrVgb8PQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Ogw8MftII1she2XJ/vthGAOx21yXJm/UADxrQwTaBYHTGurb4Bl5WhdgC01NEjlMW
	 uPEh4cxfQg7LdyNMO9p5RAFgIlMyDeK7naLh2PZHJPKiv8Nvovbrai68h9555iGAu+
	 6mNBcfnYDF8p1SJgyfNqJjOba3k8AKAPse70Psxx5vwjYx5XVtVdQ5l6j5ppSe9zq8
	 8x+MZWjstN3ehwaqktbqT07NythCCrcMTzbsl/BtagtPF0a7tA1CrbjUe9BAeSMs0O
	 4UAj+ly3OU6rAhOZ3nH6A+/LxGb7QRSq70tk9JKZRKjmbUlCuxyjwlmhjEF49fp0+M
	 qCC/X222RBsQg==
Date: Wed, 21 Feb 2024 17:00:23 -0800
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
Message-ID: <20240221170023.452a01ca@kernel.org>
In-Reply-To: <20240220184217.3689988-9-maxime.chevallier@bootlin.com>
References: <20240220184217.3689988-1-maxime.chevallier@bootlin.com>
	<20240220184217.3689988-9-maxime.chevallier@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 20 Feb 2024 19:42:11 +0100 Maxime Chevallier wrote:
> +      -
> +        name: upstream-phy-index
> +        type: u32

The C define appears to be called:

	ETHTOOL_A_PHY_UPSTREAM_INDEX,		/* u32 */

either it needs to gain the PHY_ or the spec needs to lose the phy-,
otherwise C code gen gets upset:

ethtool-user.c:689:10: error: =E2=80=98ETHTOOL_A_PHY_UPSTREAM_PHY_INDEX=E2=
=80=99 undeclared here (not in a function); did you mean =E2=80=98ETHTOOL_A=
_PHY_UPSTREAM_INDEX=E2=80=99?
  689 |         [ETHTOOL_A_PHY_UPSTREAM_PHY_INDEX] =3D { .name =3D "upstrea=
m-phy-index", .type =3D YNL_PT_U32, },
      |          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
      |          ETHTOOL_A_PHY_UPSTREAM_INDEX

Unfortunately ethtool in the in-between state where we can auto-gen
user space code (or rather most of it) but the uAPI header is not
auto-generated so we need to take extra care to keep things in sync :(

