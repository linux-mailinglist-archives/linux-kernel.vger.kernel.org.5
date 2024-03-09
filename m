Return-Path: <linux-kernel+bounces-97779-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D9378876F51
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Mar 2024 06:27:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 765821F21AE8
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Mar 2024 05:27:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2191D335C7;
	Sat,  9 Mar 2024 05:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b2ZGK//s"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63A88364A4;
	Sat,  9 Mar 2024 05:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709962026; cv=none; b=jWL87JEwVsyXojbxaH2GMEZXWaggZEYumGWOkecHvcUimxhvgJI6NPpf26rv3Fl4yZ/ZIBoJdCe6mVMzfCM/almNQtO6bYdAAh4FlhpNh3mUzob/0wy/OpX3mgwep06czWGJ/PDJwAyJMkzigjkvfotnxNJll4q2LZWXOYHzprY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709962026; c=relaxed/simple;
	bh=kKwe57YoGVcoyss0ap390jlp9pG9+fYB0DFZcYPltOE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=O0INCehedNLzJqKQyFZAYl0kMRiG8C30OncTIXtmjSSZDCYNHClqjQfQlSXGsXC44pZY5zZRXM7VPwOuXxHpHvRT7ea7gGF63D0/gqyLmfa5CgZUrW4wmdo1NC5TlRS0AMIOSOmEz1iwMwg2bvzwWsT/QT/fqOnMhtmKpMD4vxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b2ZGK//s; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E977C433F1;
	Sat,  9 Mar 2024 05:27:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709962026;
	bh=kKwe57YoGVcoyss0ap390jlp9pG9+fYB0DFZcYPltOE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=b2ZGK//sZVoGCK02BOQX1N2SWoVYhLNLuWKRrK4U2EvKKX2lkalC9BAVxWqqfHz63
	 Y1oUqjkEcMiGdHBElb2WXygtEzxODSEpDjkOSPlXpnwdkx54xnG9hnxgSTmEXcZxnP
	 0KvUJ1QY4H4WYpPZV+peQ/SXK8vH70uohDLr/WE39uHCNnPgrW1kkMNhOqpHZEiDwI
	 SyrMGz6xMePCwJgmd6+XflwN809gbAHED+OHMZTx1HlG4BQd+0ND84XmgKrmlcLJh1
	 CBrJPerRgAFKe158Twx8qOSO4IXKrbSJyzIpYd4Zn+45vO+X5/bpg1fVXoJbLlUKao
	 SyKUcdJ7uvKJw==
Date: Fri, 8 Mar 2024 21:27:04 -0800
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
Subject: Re: [PATCH net-next v10 13/13] Documentation: networking: document
 phy_link_topology
Message-ID: <20240308212704.02766ff6@kernel.org>
In-Reply-To: <20240304151011.1610175-14-maxime.chevallier@bootlin.com>
References: <20240304151011.1610175-1-maxime.chevallier@bootlin.com>
	<20240304151011.1610175-14-maxime.chevallier@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

We should :ref: to this doc from the PHY_GET in the ethtool one as well?

On Mon,  4 Mar 2024 16:10:09 +0100 Maxime Chevallier wrote:
> +An Ethernet Interface from userspace's point of view is nothing but a

interface

> +:c:type:`struct net_device <net_device>`, which exposes configuration options
> +through the legacy ioctls and the ethool netlink commands. The base assumption

ethtool

> +when designing these configuration channels were that the link looked

nit: s/channels/APIs/ channels sometimes means IRQs/queues in netdev :S
s/looked/looks/

> +something like this ::

s/this//

> +  +-----------------------+        +----------+      +--------------+
> +  | Ethernet Controller / |        | Ethernet |      | Connector /  |
> +  |       MAC             | ------ |   PHY    | ---- |    Port      | ---... to LP
> +  +-----------------------+        +----------+      +--------------+
> +  struct net_device               struct phy_device
> +
> +Commands that needs to configure the PHY will go through the net_device.phydev
> +field to reach the PHY and perform the relevant configuration.
> +
> +This assumption falls apart in more complex topologies that can arise when,
> +for example, using SFP transceivers (although that's not the only specific case).

s/specific/such/

> +Here, we have 2 basic scenarios. Either the MAC is able to output a serialized
> +interface, that can directly be fed to an SFP cage, such as SGMII, 1000BaseX,
> +10GBaseR, etc.

The "Either" makes me expect and "or" at some state in this paragraph..

> +The link topology then looks like this (when an SFP module is inserted) ::
> +
> +  +-----+  SGMII  +------------+
> +  | MAC | ------- | SFP Module |
> +  +-----+         +------------+
> +
> +Knowing that some modules embed a PHY, the actual link is more like ::
> +
> +  +-----+  SGMII   +--------------+
> +  | MAC | -------- | PHY (on SFP) |
> +  +-----+          +--------------+
> +
> +In this case, the SFP PHY is handled by phylib, and registered by phylink through
> +its SFP upstream ops.
> +
> +Now some Ethernet controllers aren't able to output a serialized interface, so
> +we can't directly connect them to an SFP cage. However, some PHYs can be used

s/However, some/In such cases, certain/

> +as media-converters, to translate the non-serialized MAC MII interface to a
> +serialized MII interface fed to the SFP ::
> +
> +  +-----+  RGMII  +-----------------------+  SGMII  +--------------+
> +  | MAC | ------- | PHY (media converter) | ------- | PHY (on SFP) |
> +  +-----+         +-----------------------+         +--------------+

