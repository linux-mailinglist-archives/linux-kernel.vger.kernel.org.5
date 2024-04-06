Return-Path: <linux-kernel+bounces-133990-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C48E89ABCD
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Apr 2024 17:52:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B0DF7B214FA
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Apr 2024 15:52:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9B243BBD7;
	Sat,  6 Apr 2024 15:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="lJ8iiQfV"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FB011CFB9;
	Sat,  6 Apr 2024 15:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712418747; cv=none; b=m4LLx5TDMZhAl4xNCjyrzBRQm1TSbJEu7IErkmzCzC54oVrUjKb1jvOO5iy8BhrkCSd6oG3L5FEZOdNuLlS5IOtxXlD0GGPEoBZl+DyJdZW/XIZzTQ5WkcoCTbgpmWT1Z6yECGx79skXww6DtvuQRynNXbyM7L3FbNf/o8oiLgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712418747; c=relaxed/simple;
	bh=DijJAWy9i/up+jDarXl3HGvDuc5nZ1pLtm25cesA4iA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qGCUUwDOW8iLJG9l4P6Ahd+7gdguzOSFQm5TmqhWYFoiX3W8KraRwaqp7GklwFm0v0cNgF+O2LueT9V0xLiL8i4HVHS3N8rjdz/De3/Pbka82MX798aESdcl4bhPV+Zbb8lvo12VxdGjBBKzRDN0y8atd1p8wjN2q2kyq/TkKqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=lJ8iiQfV; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=MEl8Sy+tCfS2l7mF/OXdN4vincdv+IXBh938c/3Vnqc=; b=lJ8iiQfVAnvqJaBytHQRN4D1YQ
	yeMHKI5j9PnYO39PT75Axy1RNkaEMWC1PopS9hZ9yVKdwaOGVc266R272RDGtDKALer65EXNH5F/q
	kn4hauzI68jYrofo2YEm/YwtEakC+bMdV9+Qa4XsCawrCKPdMDTlWXlzVTFQSs19pWv4=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rt8L8-00CNTV-IQ; Sat, 06 Apr 2024 17:52:22 +0200
Date: Sat, 6 Apr 2024 17:52:22 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>,
	linux-arm-kernel@lists.infradead.org,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Herve Codina <herve.codina@bootlin.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	=?iso-8859-1?Q?K=F6ry?= Maincent <kory.maincent@bootlin.com>,
	Jesse Brandeburg <jesse.brandeburg@intel.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>,
	Piergiorgio Beruto <piergiorgio.beruto@gmail.com>,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	=?iso-8859-1?Q?Nicol=F2?= Veronese <nicveronese@gmail.com>,
	Simon Horman <horms@kernel.org>, mwojtas@chromium.org
Subject: Re: [PATCH net-next v11 03/13] net: phy: add helpers to handle sfp
 phy connect/disconnect
Message-ID: <5561aaf7-b01a-495a-958f-2a07e1ff8cf3@lunn.ch>
References: <20240404093004.2552221-1-maxime.chevallier@bootlin.com>
 <20240404093004.2552221-4-maxime.chevallier@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240404093004.2552221-4-maxime.chevallier@bootlin.com>

On Thu, Apr 04, 2024 at 11:29:53AM +0200, Maxime Chevallier wrote:
> There are a few PHY drivers that can handle SFP modules through their
> sfp_upstream_ops. Introduce Phylib helpers to keep track of connected
> SFP PHYs in a netdevice's namespace, by adding the SFP PHY to the
> upstream PHY's netdev's namespace.
> 
> By doing so, these SFP PHYs can be enumerated and exposed to users,
> which will be able to use their capabilities.
> 
> Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

