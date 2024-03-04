Return-Path: <linux-kernel+bounces-90910-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 094728706AB
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 17:12:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3B93F1C21679
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 16:12:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62CD54AEF6;
	Mon,  4 Mar 2024 16:12:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="DLydrWNU"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 333A1482FF;
	Mon,  4 Mar 2024 16:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709568742; cv=none; b=ewhTy3hS9cmdx39m0C9BQWrhEUhXcG1GIUCT3Wcp4XwxD2qvYecww+TtF/44oaocKMfv4lBtm8wtTy6L/uu5zSRoggNK8ImpPxPFBR6mbcOHyY7rN8RoM+cehGO0l8JneN6EAdWsNdT13RJSFFzAq9Xsq2No5GRK2UWjpgTcWHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709568742; c=relaxed/simple;
	bh=klaBAwoTO2sGv+p6YOJJyuEHsObzpTe/dLfKcraFE98=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CrywGON5CF0W0j160siHPPIWa2TunBiifHjhDr/s7pCLxdtF6Jb9u/ZM1rRYGf7DI6ZE01tq9HOI1I1grI/rvVZYb0cN6UIp5n+k7Lx1mmoX3xfKf7JUrM7Gzrn7RW7+t2EwVMr4H29LS8/bnJ/Lofk5tazQ0W28j6N57BUsArY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=DLydrWNU; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=sl45xCq737WyHgw80qy+Kro/iyZe2pIal7SyTZ5AsWc=; b=DLydrWNU0Vbv6iriBVMie0WA8P
	9zEy1+0W6eT5NpSE4bB6EcFMQtY5hQ8GshO3DkAvV5w95f7Phxbm1aWtaKitWjoQ8CDPIs/tAv125
	J+r3NARW/D38hQvHSO7GaD1cmCWROL9MtqKkrgEP3J89R+cPZHZK9k13k3M8p0qWdmPQ=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rhAvg-009LCm-On; Mon, 04 Mar 2024 17:12:40 +0100
Date: Mon, 4 Mar 2024 17:12:40 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: Arun.Ramadoss@microchip.com, olteanv@gmail.com, davem@davemloft.net,
	Woojung.Huh@microchip.com, pabeni@redhat.com, edumazet@google.com,
	f.fainelli@gmail.com, kuba@kernel.org, kernel@pengutronix.de,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	UNGLinuxDriver@microchip.com
Subject: Re: [PATCH net v1 1/1] net: dsa: microchip: make sure drive strength
 configuration is not lost by soft reset
Message-ID: <c26ca1b6-1df5-4c64-a941-a0a2b1c60fe8@lunn.ch>
References: <20240304135612.814404-1-o.rempel@pengutronix.de>
 <5a830dd5c253d12d719a5e979a1d43c5fb47e011.camel@microchip.com>
 <ZeXxr1qZ0ZP4U--O@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZeXxr1qZ0ZP4U--O@pengutronix.de>

> I fully agree, but I fear this change would be too big for stable.

How big is the change to do it correctly?

The stable rules are all about making it obviously correct, and so low
risk. In general, a big patch is not always obviously correct. But if
all you are doing is moving code around, no actual change, and it
clearly states that, the size limit should not matter, the risk is
low. Include this information as justification in the commit message,
and it should be O.K.

	Andrew

