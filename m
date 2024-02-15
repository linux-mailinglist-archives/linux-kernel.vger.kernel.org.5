Return-Path: <linux-kernel+bounces-66354-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ABA11855B7C
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 08:19:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 69009283E8E
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 07:19:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8787DDD1;
	Thu, 15 Feb 2024 07:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="PlrBizhF"
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5EBCDDAE;
	Thu, 15 Feb 2024 07:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707981591; cv=none; b=fyhow+fk8O5ysGl9MbyrEMd43dLlsaRF2QPy/KrseafAwIw/IxgyG6bWnTG0VGLEgL+QiOxLQmHUaJkNteETHFYrINFHg74dhCYOBcGPJ+LTV+RnipO3caL+O3+CIAw1ivJhXRmIC/HlyHVsUQp9Ukb9XbteaFiQNdxWQwCEMXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707981591; c=relaxed/simple;
	bh=nQlOf/Q/5O5SukLZ6rtBuODtxXePZxAGd0xexsFVcJ8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QqTYIoKSFUDj8BSbVkcAn2/aIOARwrZRbh2ibaROnnMYKhBbvcuxXRL162yGvFGr10O9bqn2EvHxMfuSPI0+prTg9WdkHuTDBc11/jczDOOdtyG6Fv0FIxg0b3Ny4PCuuvh3jX03elkqbIiM33QQ/tZcbKP9gQZkLGnYJwwHWIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=PlrBizhF; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id B02D61C0005;
	Thu, 15 Feb 2024 07:19:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1707981584;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qieT2V8qh8j5k3DSAaJeE/xzPVOTH5+a2qFckHpBsi0=;
	b=PlrBizhFKr9GmYlg/RJutFVOSydG0cdSZgtPSHCFs+RN1pslgbfi80oFHcWMUCPZqn8fdF
	HlA1V9dBWl8ix+45xjJQzdwknFsTWhG7w+Eg18N+WWXDsVu6TkRG+FCv2+OCpEe/9erJel
	Gi6Vb+37cespGAogm091ZaKtZ2cNEWlKIBOJ/7V7w7MPPP61KMR4KbjoWPkSJff3B+gBJw
	ccYlUHVgEr23GVTD6d25QsdkM4wL89AyI9WEroVoE5h1QHVUXzXYwvhUXZGG8YivukJVD6
	vZRzxyhk+ZzBRsrDAHjVTE3ejT/Mkf7YnNmiDAo0HM/LxQd/F/YmXPoBX+jcuQ==
Date: Thu, 15 Feb 2024 08:19:39 +0100
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
Subject: Re: [PATCH net-next v7 00/13] Introduce PHY listing and
 link_topology tracking
Message-ID: <20240215081939.1df19818@device-28.home>
In-Reply-To: <20240214165902.55bf3a04@kernel.org>
References: <20240213150431.1796171-1-maxime.chevallier@bootlin.com>
	<20240214165902.55bf3a04@kernel.org>
Organization: Bootlin
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-GND-Sasl: maxime.chevallier@bootlin.com

Hi Jakub,

On Wed, 14 Feb 2024 16:59:02 -0800
Jakub Kicinski <kuba@kernel.org> wrote:

> On Tue, 13 Feb 2024 16:04:17 +0100 Maxime Chevallier wrote:
> > This is V7 for the link topology addition, allowing to track all PHYs
> > that are linked to netdevices.
> > 
> > The main change in V7 is the protection of the main internal API
> > entrypoints (link_topo_init/cleanup, link_topo_add/del_phy) by
> > IS_REACHABLE(CONFIG_PHYLIB).
> > 
> > That's restrictive, but it looks difficult to do otherwise while still keep the
> > data structure opaque and not add dependency clutter with PHYLIB.
> > 
> > As you can tell, I'm unsure about this, so please don't hesitate to
> > comment on that part :)
> > 
> > The other changes are very minor, the only one is a call to netdev_put
> > in the .done() netlink callback.
> > 
> > As a remainder, here's what the PHY listings would look like :
> >  - eth0 has a 88x3310 acting as media converter, and an SFP module with
> >    an embedded 88e1111 PHY
> >  - eth2 has a 88e1510 PHY  
> 
> Needs a rebase, core has been busy lately:

Arg, I'll send a rebased version, sorry about that

Best regards,

Maxime

