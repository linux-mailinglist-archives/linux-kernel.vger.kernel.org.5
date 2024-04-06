Return-Path: <linux-kernel+bounces-133994-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB51A89ABD6
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Apr 2024 18:01:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 90B6D281BF0
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Apr 2024 16:01:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3041D3BBE1;
	Sat,  6 Apr 2024 16:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="r4QC+Lcv"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20C6B3D971;
	Sat,  6 Apr 2024 16:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712419247; cv=none; b=FJYMYGq/Gf/8E2MGFn1tlBv2V8OHJATehw8QLem+W8PRWlHtRi3nD4a8jgOqh/RDxgCW1/gK09x5cLHAa5LHh0i+IfVqHL3+jZ7MjkFyNFYot0i5Ooufr4sFBCxaatEJ7C4FSF127dr1icep1tKC55YOZBn/u41bSNiACyr7pIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712419247; c=relaxed/simple;
	bh=sqN39mACaEMC34n6hRty1c9YRl8kWJxl3ygrgVrCqUU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FyCMC6XH1gC0yxKj2iHPyBLL364SoZ4I8hunOSTJAaQ1TmPSswklclHt99h6MDcuvMAatfTgzy1K9EG7Vbwx2hWrF9HtzvlhexAiQBEFPN74PfIrIUB10iUPf8ZeTia8dSJvSxY71vLg5OOFe/Pe7zfiRJHK0qdVY1Ggdg5wr0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=r4QC+Lcv; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=ZrGAtvWMJTVgvdqKgEyxVIUzwoxIXXEpYPO5/OIoXCE=; b=r4QC+Lcvi6uNUhS4xPqVMQHx9r
	RSjFbGR5H2kCaAtek2qm8GbDrtkiAkQ2AbZms8H5YQxReDObl+TYNadFVUSZ0afmxoelXjwzgzbS2
	R4RMrEc8I+K6m8UkFUPuNitFG2eGazlgZIGLl/NTiuGx3eDnTfkqLC0+gNh6zsKywE2U=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rt8TE-00CNXL-4W; Sat, 06 Apr 2024 18:00:44 +0200
Date: Sat, 6 Apr 2024 18:00:44 +0200
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
Subject: Re: [PATCH net-next v11 10/13] net: ethtool: pse-pd: Target the
 command to the requested PHY
Message-ID: <b8aff04a-2b5d-44df-aed0-89f5c232893e@lunn.ch>
References: <20240404093004.2552221-1-maxime.chevallier@bootlin.com>
 <20240404093004.2552221-11-maxime.chevallier@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240404093004.2552221-11-maxime.chevallier@bootlin.com>

On Thu, Apr 04, 2024 at 11:30:00AM +0200, Maxime Chevallier wrote:
> PSE and PD configuration is a PHY-specific command. Instead of targeting
> the command towards dev->phydev, use the request to pick the targeted
> PHY device.
> 
> Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

