Return-Path: <linux-kernel+bounces-65628-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 75827854F9B
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 18:14:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A8D701C28F0D
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 17:14:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D3397C6C9;
	Wed, 14 Feb 2024 17:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="14/moJsH"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FC1A79DC3;
	Wed, 14 Feb 2024 17:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707930831; cv=none; b=q59C33kdlBSmrJXKmEMODHh+jCAkJ3p8TAPLRNyu1XOM4PJL1icL67tD6H8T3U1lc9EZg3EBpSzmJ/R5ZykRrAMiDGYDheTtrMICNTYngjsvF8T+3tYSYv3XOPGvNvM/o9BJnunTOZ2q0hYp0WlDn6nOkdMaRMvJ2nIbt9FpO5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707930831; c=relaxed/simple;
	bh=O4EP7ZsiuTpR1qxri74QC+bU4B0c46R87VFN0TDKcAE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HHsym0rel6BvEbiuCI+NEXbNSoBAD/XfQYTdO3CshYz8cJUXTgFJdC73Les1IKJYDxX82qz6qi1pBo+9QwrWIDtOZuT5kh15GaweCR0GMRm6WNSm63ERup4Cx8UoVS6IUr+KuCWe8KI1MYPdBh6fZisUQkxZSX8uWuqVNZ9/ZYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=14/moJsH; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=BwOfhdkr2CJpORP5be5oyVP8qg5R4oDqxvMHwIB5C7E=; b=14/moJsH2jrh6/MIfq4rqwUW23
	HwYKLSmz48hGx2U5x7WSr/ThEpauCgOXWd+eQuSpaThBhEAFqzkDTZycmkOQKmV/epyH55zIFxPMJ
	HGVMOYPeg+ZccuBMBUN0ffDKm7Q1hPt4nSRNPU15sKkWZXqmr7bTUtJ7HA8BROF7qC2E=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1raIpH-007o7X-VO; Wed, 14 Feb 2024 18:13:39 +0100
Date: Wed, 14 Feb 2024 18:13:39 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Kory Maincent <kory.maincent@bootlin.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Russ Weight <russ.weight@linux.dev>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	Mark Brown <broonie@kernel.org>,
	Frank Rowand <frowand.list@gmail.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, devicetree@vger.kernel.org,
	Dent Project <dentproject@linuxfoundation.org>
Subject: Re: [PATCH net-next v3 01/17] MAINTAINERS: net: Add Oleksij to
 pse-pd maintainers
Message-ID: <2a89db56-484f-466c-9dea-fce3e0da0e71@lunn.ch>
References: <20240208-feature_poe-v3-0-531d2674469e@bootlin.com>
 <20240208-feature_poe-v3-1-531d2674469e@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240208-feature_poe-v3-1-531d2674469e@bootlin.com>

On Thu, Feb 08, 2024 at 02:08:38PM +0100, Kory Maincent wrote:
> Oleksij was the first to add support for pse-pd net subsystem.
> Add himself to the maintainers seems logical.
> 
> Sponsored-by: Dent Project <dentproject@linuxfoundation.org>
> Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>

Oleksij, are you O.K. with this? It would be good to Acked-by: it.

	Andrew

